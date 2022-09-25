/*
 * Copyright (c) 2021, Linaro Limited
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include <err.h>
#include <stdio.h>
#include <string.h>

/* OP-TEE TEE client API (built by optee_client) */
#include <tee_client_api.h>

/* TA API: UUID and command IDs */
#include <secure_storage_ta.h>

#include "csapp.h"

/* TEE resources */
struct test_ctx {
	TEEC_Context ctx;
	TEEC_Session sess;
};

void prepare_tee_session(struct test_ctx *ctx)
{
	TEEC_UUID uuid = TA_SECURE_STORAGE_UUID;
	uint32_t origin;
	TEEC_Result res;

	/* Initialize a context connecting us to the TEE */
	res = TEEC_InitializeContext(NULL, &ctx->ctx);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_InitializeContext failed with code 0x%x", res);

	/* Open a session with the TA */
	res = TEEC_OpenSession(&ctx->ctx, &ctx->sess, &uuid,
			       TEEC_LOGIN_PUBLIC, NULL, NULL, &origin);
	if (res != TEEC_SUCCESS)
		errx(1, "TEEC_Opensession failed with code 0x%x origin 0x%x",
			res, origin);
}

void terminate_tee_session(struct test_ctx *ctx)
{
	TEEC_CloseSession(&ctx->sess);
	TEEC_FinalizeContext(&ctx->ctx);
}

TEEC_Result read_secure_object(struct test_ctx *ctx, char *id,
			char *data, size_t data_len)
{
	TEEC_Operation op;
	uint32_t origin;
	TEEC_Result res;
	size_t id_len = strlen(id);

	memset(&op, 0, sizeof(op));
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_MEMREF_TEMP_INPUT,
					 TEEC_MEMREF_TEMP_OUTPUT,
					 TEEC_NONE, TEEC_NONE);

	op.params[0].tmpref.buffer = id;
	op.params[0].tmpref.size = id_len;

	op.params[1].tmpref.buffer = data;
	op.params[1].tmpref.size = data_len;

	res = TEEC_InvokeCommand(&ctx->sess,
				 TA_SECURE_STORAGE_CMD_READ_RAW,
				 &op, &origin);
	switch (res) {
	case TEEC_SUCCESS:
	case TEEC_ERROR_SHORT_BUFFER:
	case TEEC_ERROR_ITEM_NOT_FOUND:
		break;
	default:
		printf("Command READ_RAW failed: 0x%x / %u\n", res, origin);
	}

	return res;
}

TEEC_Result write_secure_object(struct test_ctx *ctx, char *id,
			char *data, size_t data_len)
{
	TEEC_Operation op;
	uint32_t origin;
	TEEC_Result res;
	size_t id_len = strlen(id);

	memset(&op, 0, sizeof(op));
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_MEMREF_TEMP_INPUT,
					 TEEC_MEMREF_TEMP_INPUT,
					 TEEC_NONE, TEEC_NONE);

	op.params[0].tmpref.buffer = id;
	op.params[0].tmpref.size = id_len;

	op.params[1].tmpref.buffer = data;
	op.params[1].tmpref.size = data_len;

	res = TEEC_InvokeCommand(&ctx->sess,
				 TA_SECURE_STORAGE_CMD_WRITE_RAW,
				 &op, &origin);
	if (res != TEEC_SUCCESS)
		printf("Command WRITE_RAW failed: 0x%x / %u\n", res, origin);

	switch (res) {
	case TEEC_SUCCESS:
		break;
	default:
		printf("Command WRITE_RAW failed: 0x%x / %u\n", res, origin);
	}

	return res;
}

TEEC_Result delete_secure_object(struct test_ctx *ctx, char *id)
{
	TEEC_Operation op;
	uint32_t origin;
	TEEC_Result res;
	size_t id_len = strlen(id);

	memset(&op, 0, sizeof(op));
	op.paramTypes = TEEC_PARAM_TYPES(TEEC_MEMREF_TEMP_INPUT,
					 TEEC_NONE, TEEC_NONE, TEEC_NONE);

	op.params[0].tmpref.buffer = id;
	op.params[0].tmpref.size = id_len;

	res = TEEC_InvokeCommand(&ctx->sess,
				 TA_SECURE_STORAGE_CMD_DELETE,
				 &op, &origin);

	switch (res) {
	case TEEC_SUCCESS:
	case TEEC_ERROR_ITEM_NOT_FOUND:
		break;
	default:
		printf("Command DELETE failed: 0x%x / %u\n", res, origin);
	}

	return res;
}

/* 
 * author: Wei Xinpeng
 * first update: 2021.11.3
 * content: test socket communication
 * second update: 2021.11.21
 * content: IPC using socket with android app
 * storage struct is <id, header data>
 * header's size is 20, including length, 
 * protocol: similiar to HTTP
 * 200 is OK
 * 201 is created
 * 404 is not found
 * 505 is internal server error
 * response_code [message]
 * TODO: not supported append data
 */

struct hdr {
    size_t buffer_length;
    // XXX
} __attribute__((packed, aligned(4)));

#define HEADER_SIZE sizeof(struct hdr)

void doit(int connfd)
{
	size_t n;
	char buf[MAXLINE];
	rio_t rio;

	struct test_ctx ctx;
	TEEC_Result res;

	printf("Prepare session with the TA\n");
	prepare_tee_session(&ctx);

	int data_length;

	char operation_type[20] = {'\0'};
	// supported operation type: "read", "write"
	char data_source[50] = {'\0'};
	// supported data source: "wechat", "alipay", "agricultural bank"

    /*
     * OP: w, r
     * SOURCE: wx, ali, ...
     * SIZE
    */

	Rio_readinitb(&rio, connfd);
	if ((n = Rio_readlineb(&rio, buf, MAXLINE)) != 0) {
		sscanf(buf, "%s %s %d", operation_type, data_source, &data_length);
	}

    /*
     * w key size
       value
     * r key
    */

	if (strcmp(operation_type, "r") == 0) {
        // step-1: try reading header
        char *chk_buf = malloc(64);
		res = read_secure_object(&ctx, data_source, chk_buf, 64);
		
		if (res != TEEC_SUCCESS && res != TEEC_ERROR_ITEM_NOT_FOUND) {
			errx(1, "Unexpected status when reading an object : 0x%x", res);
		} else if (res == TEEC_ERROR_ITEM_NOT_FOUND) {
			printf("404 %s not found", data_source);
		} else if (res == TEEC_SUCCESS) {
			struct hdr * phdr = chk_buf;
			data_length = phdr->buffer_length;
			printf("data_length %d\n", data_length);

            // step-2: read the rest
			char *read_buf = (char *)calloc(HEADER_SIZE + data_length, sizeof(char));
			res = read_secure_object(&ctx, data_source, read_buf, HEADER_SIZE + data_length);
			if (res != TEEC_SUCCESS && res != TEEC_ERROR_ITEM_NOT_FOUND)
				errx(1, "Unexpected status when reading an object : 0x%x", res);
			printf("get data is %s\n", read_buf + HEADER_SIZE);
			Rio_writen(connfd, read_buf + HEADER_SIZE, data_length);
			free(read_buf);
		}
		free(chk_buf);

	} else if (strcmp(operation_type, "w") == 0) {
		// read from the socket
		char *tmp_buf = (char *)calloc(data_length + 1, sizeof(char));
		n = Rio_readnb(&rio, tmp_buf, data_length);
		printf("read size is %ld\n", n);
        // concatenate hdr and the read buffer
        char *write_buf = (char *)calloc(HEADER_SIZE + data_length + 1, sizeof(char));
//		sprintf(write_buf, "%-20d%s", data_length, tmp_buf);
        struct hdr * phdr = write_buf;
        phdr->buffer_length = data_length;
        strncpy(write_buf + HEADER_SIZE, tmp_buf, data_length);
		printf("get data from client is %s-->(%d)%s\n", data_source, data_length, tmp_buf);
		res = write_secure_object(&ctx, data_source, write_buf, HEADER_SIZE + data_length);
		if (res != TEEC_SUCCESS) {
			errx(1, "Failed to create an object in the secure storage");
			sprintf(buf, "505 %s write error, you may retry", data_source);
			Rio_writen(connfd, buf, strlen(buf));
		}
		free(tmp_buf);
		free(write_buf);
		
		printf("write_secure_object = %d\n", res);

	}

	printf("Terminate session with the TA\n");
	terminate_tee_session(&ctx);
}

int main(int argc, char **argv)
{
	int listenfd, connfd;
	socklen_t clientlen;
	struct sockaddr_storage clientaddr;
	char client_hostname[MAXLINE], client_port[MAXLINE];

	ssize_t data_size;
	
	if(argc != 2){
		errx(1, "usage: %s <port>\n", argv[0]);
		exit(0);
	}

	listenfd = Open_listenfd(argv[1]);
	while (1) {
		clientlen = sizeof(struct sockaddr_storage);
		connfd = Accept(listenfd, (SA *)&clientaddr, &clientlen);
		Getnameinfo((SA *) &clientaddr, clientlen, client_hostname, MAXLINE, client_port, MAXLINE, 0);
		printf("Connected to (%s, %s)\n", client_hostname, client_port);
		doit(connfd);
		printf("Disconnected to (%s, %s)\n", client_hostname, client_port);
		Close(connfd);
	}
	return 0;
}
