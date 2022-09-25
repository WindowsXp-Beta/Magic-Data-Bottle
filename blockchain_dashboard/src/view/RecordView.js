import * as React from "react";
import { Layout } from 'antd';
import {BlockChainTable} from "../components/BlockChainTable";
import logo from '../assets/logo.png'

const { Header, Content } = Layout;

export class RecordView extends React.Component {


    render() {
        return <Layout className="layout">
            <Header>
                <img src={logo} style={{height:'40px'}} alt={"logo"}/>
                <span style={{color: '#fff', marginLeft: '10px'}}>Block Explorer</span>
            </Header>
            <Content style={{padding: '0 50px'}}>
                <BlockChainTable/>
            </Content>
        </Layout>
    }
}
