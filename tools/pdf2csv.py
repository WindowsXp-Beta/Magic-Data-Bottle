#!/usr/bin/python3
#coding: utf-8

import time
import sys
import camelot
from PyPDF2 import PdfFileReader


#fileNamePdf = input("Enter the file name : ")    #get filename
def main(argv):
#get pages number
    start = time.time()
    fileNamePdf = argv[1]
    reader = PdfFileReader(fileNamePdf)
    page = reader.getNumPages()
    wholePages = '1-' + str(page)
    end = time.time()
    print("Get Page Time = %f\n" %(end - start))

    start = time.time()
    tables = camelot.read_pdf(fileNamePdf , flavor='stream', pages = wholePages, columns=['81,116,154,198,241,333,391'], split_text=True)
    end = time.time()
    print("Read PDF Time = %f\n" %(end - start))
    
    start = time.time()
    fileNameCsv = fileNamePdf[:-4] + '.csv'
    #fileNameZip = fileNamePdf[:-4] + '.zip'
    tables.export(fileNameCsv, f='csv', compress=False)
    end = time.time()
    print("Export CSV Time = %f\n" %(end - start))
    return 0
    #print("\nexport " + fileNamePdf + " to " + fileNameZip + " successfully!\n")

if __name__ == "__main__":
    main(sys.argv)
