Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C96C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06152184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LCAOq5QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLIg7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:59 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:2222
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbfDLIg6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMLVy3ETzctqm1tILQbJb0wFRJp2H+CqVo6ngffvK4o=;
 b=LCAOq5QAp0B6wuVYla8d/2t5ff+hYZWsVhqeVaMDiejJPTVCQiaz5VT7qTqm/ACIpsfEj/q+bySXxNqIsBUYz2a6D3u80i6A6J/YhcMTgjvMMCEZM/mE1NVjBkhHkrhQRUqzvRRxSJjM//BE8erX46Rc6CQgjb7Xwj8BOh3lwFk=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5926.eurprd04.prod.outlook.com (20.179.3.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 08:36:54 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:54 +0000
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
Subject: [PATCHv5 17/20] PCI: mobiveil: Complete initialization of host even
 if no PCIe link
Thread-Topic: [PATCHv5 17/20] PCI: mobiveil: Complete initialization of host
 even if no PCIe link
Thread-Index: AQHU8Qrh69RXVzVSWU2bYWJ3S9cC9Q==
Date:   Fri, 12 Apr 2019 08:36:54 +0000
Message-ID: <20190412083635.33626-18-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: f81bf660-c701-4238-3a76-08d6bf220423
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5926;
x-ms-traffictypediagnostic: AM6PR04MB5926:
x-microsoft-antispam-prvs: <AM6PR04MB59261015045BBE552326F2A984280@AM6PR04MB5926.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(54534003)(478600001)(36756003)(305945005)(52116002)(6486002)(110136005)(186003)(7416002)(3846002)(7736002)(6436002)(50226002)(54906003)(316002)(6512007)(6116002)(25786009)(1076003)(26005)(86362001)(105586002)(8676002)(81166006)(386003)(106356001)(14454004)(2501003)(6506007)(81156014)(76176011)(5660300002)(102836004)(256004)(53936002)(71200400001)(71190400001)(2906002)(68736007)(476003)(66066001)(99286004)(2616005)(97736004)(4326008)(486006)(446003)(11346002)(8936002)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5926;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o6bqLS3aY7JQ8zDi9xiu09MWtf0QlmkFCGErLY17CKCIf4weGgFCmkDVc/azuxWRgeadrOxF+ciCyO7BQLlqUsUfGdukmN86SsESMGmvrw68HUF6yNiv1XCs8pg5g29aHVDsYhoLh3KIEwPguwKw3hkhsJvyx+UyPjhqJbzZuPFdizYr0dDXfDDSX19n2NbNizBI5dUyDpRkGxNNrKLPamsVMZK4KI+RBggyCzyXAIFa1MrD8onu7Kg2trs3qLYAa/3fjgZvXaFZ7NcFEjfHFuZKhdxFXwDkZEsyiLvh/W34LgayCXAtHgSV8vrAWYvwZQz7CPRuieYZ5umxt3nfwcXmmPduoZqlaLM1pJKTFg7QNdjoJ0FnKimPViCP4JT7xd1ROxJCvp4pSBqUMa++qcGe9cmSGaSRcnpE+23pwXU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81bf660-c701-4238-3a76-08d6bf220423
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:54.3218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5926
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KU29tZXRpbWVzIHRo
ZXJlIGlzIG5vdCBhIFBDSWUgRW5kcG9pbnQgc3RhbGxlZCBpbiB0aGUgc2xvdCwNCnNvIGRvIG5v
dCBleGl0IHdoZW4gdGhlIFBDSWUgbGluayBpcyBub3QgdXAuIEFuZCBkZWdyYWRlIHRoZQ0KcHJp
bnQgbGV2ZWwgb2YgbGluayB1cCBpbmZvLg0KDQpTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcg
PFpoaXFpYW5nLkhvdUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IE1pbmdodWFuIExpYW4gPE1pbmdo
dWFuLkxpYW5AbnhwLmNvbT4NClJldmlld2VkLWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5z
dWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCi0tLQ0KVjU6DQogLSBDb3JyZWN0ZWQgYW5kIHJl
dG91Y2hlZCB0aGUgc3ViamVjdCBhbmQgY2hhbmdlbG9nLg0KDQogZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMgfCA2ICsrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2Jp
dmVpbC5jDQppbmRleCAxZWUzZWEyNTcwYzAuLjhkYzg3YzdhNjAwZSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQorKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KQEAgLTU2MCw3ICs1NjAsNyBAQCBzdGF0aWMgaW50
IG1vYml2ZWlsX2JyaW5ndXBfbGluayhzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiAJCXVz
bGVlcF9yYW5nZShMSU5LX1dBSVRfTUlOLCBMSU5LX1dBSVRfTUFYKTsNCiAJfQ0KIA0KLQlkZXZf
ZXJyKCZwY2llLT5wZGV2LT5kZXYsICJsaW5rIG5ldmVyIGNhbWUgdXBcbiIpOw0KKwlkZXZfaW5m
bygmcGNpZS0+cGRldi0+ZGV2LCAibGluayBuZXZlciBjYW1lIHVwXG4iKTsNCiANCiAJcmV0dXJu
IC1FVElNRURPVVQ7DQogfQ0KQEAgLTkyNiwxMCArOTI2LDggQEAgc3RhdGljIGludCBtb2JpdmVp
bF9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWJyaWRnZS0+c3dp
enpsZV9pcnEgPSBwY2lfY29tbW9uX3N3aXp6bGU7DQogDQogCXJldCA9IG1vYml2ZWlsX2JyaW5n
dXBfbGluayhwY2llKTsNCi0JaWYgKHJldCkgew0KKwlpZiAocmV0KQ0KIAkJZGV2X2luZm8oZGV2
LCAibGluayBicmluZy11cCBmYWlsZWRcbiIpOw0KLQkJZ290byBlcnJvcjsNCi0JfQ0KIA0KIAkv
KiBzZXR1cCB0aGUga2VybmVsIHJlc291cmNlcyBmb3IgdGhlIG5ld2x5IGFkZGVkIFBDSWUgcm9v
dCBidXMgKi8NCiAJcmV0ID0gcGNpX3NjYW5fcm9vdF9idXNfYnJpZGdlKGJyaWRnZSk7DQotLSAN
CjIuMTcuMQ0KDQo=
