import { Table } from 'antd';
import * as React from "react";
import sha256 from 'crypto-js/sha256';

const dataResource = [
    {
        key: '1',
        type: `导入数据`,
        user: `${sha256('小夏').toString().slice(0, 30)}`,
        dataType: `${sha256('支付宝8月账单').toString().slice(0, 30)}`,
        time: '2021-8-12',
    },
    {
        key: '2',
        type: `导入数据`,
        user: `${sha256('TA').toString().slice(0, 30)}`,
        dataType: `${sha256('微信支付8月账单').toString().slice(0, 30)}`,
        time: '2021-8-12',
    },
    {
        key: '3',
        type: `导入数据`,
        user: `${sha256('交通TA').toString().slice(0, 30)}`,
        dataType: `${sha256('微信支付2月账单').toString().slice(0, 30)}`,
        time: '2021-8-12',
    },
    {
        key: '4',
        type: `导入数据`,
        user: `${sha256('交通TA').toString().slice(0, 30)}`,
        dataType: `${sha256('微信支付1月账单').toString().slice(0, 30)}`,
        time: '2021-8-12',
    },
    {
        key: '5',
        type: `使用数据`,
        user: `${sha256('交通TA').toString().slice(0, 30)}`,
        dataType: `${sha256('微信支付3月账单').toString().slice(0, 30)}`,
        time: '2021-8-12',
    }
];


export class BlockChainTable extends React.Component{

    constructor(props) {
        super(props);
        this.state = {
            data: []
        }
    }

    fleshData = newItem => {
        this.setState({data: this.state.data.concat(newItem)});
    }

    onSpacePress = e => {
        if(e.key === 'Enter') {
            this.fleshData(dataResource[this.state.data.length])
        }
    }

    render() {
        const columns = [
            {
                title: '操作类型',
                dataIndex: 'type',
                key: 'type',
            },
            {
                title: '访问方',
                dataIndex: 'user',
                key: 'user',
            },
            {
                title: '数据类型',
                dataIndex: 'dataType',
                key: 'dataType',
            },
            {
                title: '时间',
                dataIndex: 'time',
                key: 'time',
            },
        ];
        return <div className={'wxp'} tabIndex={'0'} onKeyPress={this.onSpacePress}>
            <Table columns={columns} dataSource={this.state.data} />
        </div>
    }
}