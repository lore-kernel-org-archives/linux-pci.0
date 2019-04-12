Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6DFC10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61982084D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2QjXbd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfDLIhQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:37:16 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:44771
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfDLIhQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+HboNYbXQXllu23GXC0gT8F0N10T8uy5nAe8PGzH7w=;
 b=G2QjXbd3mtprdloqrM5lFoRakwTFnsa3wj4Pgku8VKxKBife52Dxf9IHZgI7jYcAiC2OQBDjIIhiSshLPY7/oj6iP7yKri0ACEpXz0aVwMZf0S4cfJH/pzQT4s8UEaRgDIdULbpUh+Ps/sTfJZ3xrdPRkefoy0pTaH3PODXBWJs=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:37:11 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:37:11 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv5 20/20] dt-bindings: PCI: mobiveil: Change gpio_slave and
 apb_csr to optional
Thread-Topic: [PATCHv5 20/20] dt-bindings: PCI: mobiveil: Change gpio_slave
 and apb_csr to optional
Thread-Index: AQHU8QrsbkvrL/I3CUyUaYyndGFAZw==
Date:   Fri, 12 Apr 2019 08:37:11 +0000
Message-ID: <20190412083635.33626-21-Zhiqiang.Hou@nxp.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be12f98f-710a-4fd0-5ea5-08d6bf220e63
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB58461AA226FEE7DA0469E31684280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2C1Kv/plN36wDdVtnFav6cH5u8NBnMZ/HCLzV0z46h18RqA6Pj60YPFG8T73ueqYEeSdey4Bciv3ZI4Iv6BvYX0b/4DlRo3YtoXXeTKmMh9bDKZERQo8f5Zk7mi5DP/HcieBo9WDHnej1BnbjXHbuT4DEuQk7ZfYwCfPn0jmzMHrqGJSiO7otH6qrDTTqgd76EFXEKDcGLhkmNNzmG5/kykgOuahGCTJBzl8vwC2zYCA4tJVbYAfLGJ5hKigHbXwu/U7DNHlk89haju9duwpsoPPC6PHfD9oj11r3vvfFjq29yaBatrW06aLEZ/Unwo1FgeZ2K2t2OiEwb7Wf/y+jtm1N5sybfPeyDx0BlqITGW/0LrOtain4cDtXtsITtv74SJiX3zaso0CsYKY0v7Yywqrxa3eIY+JtUY/U3CvVg0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be12f98f-710a-4fd0-5ea5-08d6bf220e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:37:11.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQ2hhbmdlIHRoZSAi
Z3Bpb19zbGF2ZSIgYW5kICJhcGJfY3NyIiB0byBvcHRpb25hbCwgdGhlICJncGlvX3NsYXZlIg0K
aXMgbm90IHVzZWQgaW4gY3VycmVudCBjb2RlLCBhbmQgImFwYl9jc3IiIGlzIG5vdCB1c2VkIGJ5
IHNvbWUgcGxhdGZvcm1zLg0KDQpTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5n
LkhvdUBueHAuY29tPg0KQWNrZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1h
bnlhQG1vYml2ZWlsLmNvLmluPg0KQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQpSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29tPg0K
UmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2ZWls
LmNvLmluPg0KLS0tDQpWNToNCiAtIENvcnJlY3RlZCBhbmQgcmV0b3VjaGVkIHRoZSBzdWJqZWN0
IGFuZCBjaGFuZ2Vsb2cuDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L21vYml2ZWlsLXBjaWUudHh0IHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bW9iaXZlaWwtcGNpZS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L21vYml2ZWlsLXBjaWUudHh0DQppbmRleCBhNjE4ZDQ3ODdkZDcuLjY0MTU2OTkzZTA1MiAxMDA2
NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZlaWwt
cGNpZS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9i
aXZlaWwtcGNpZS50eHQNCkBAIC0xMCw4ICsxMCwxMCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
IAlpbnRlcnJ1cHQgc291cmNlLiBUaGUgdmFsdWUgbXVzdCBiZSAxLg0KIC0gY29tcGF0aWJsZTog
U2hvdWxkIGNvbnRhaW4gIm1idmwsZ3BleDQwLXBjaWUiDQogLSByZWc6IFNob3VsZCBjb250YWlu
IFBDSWUgcmVnaXN0ZXJzIGxvY2F0aW9uIGFuZCBsZW5ndGgNCisJTWFuZGF0b3J5Og0KIAkiY29u
ZmlnX2F4aV9zbGF2ZSI6IFBDSWUgY29udHJvbGxlciByZWdpc3RlcnMNCiAJImNzcl9heGlfc2xh
dmUiCSAgOiBCcmlkZ2UgY29uZmlnIHJlZ2lzdGVycw0KKwlPcHRpb25hbDoNCiAJImdwaW9fc2xh
dmUiCSAgOiBHUElPIHJlZ2lzdGVycyB0byBjb250cm9sIHNsb3QgcG93ZXINCiAJImFwYl9jc3Ii
CSAgOiBNU0kgcmVnaXN0ZXJzDQogDQotLSANCjIuMTcuMQ0KDQo=
