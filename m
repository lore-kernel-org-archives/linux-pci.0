Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69DEC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4272184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kUfSIMQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfDLIhK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:37:10 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:6214
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfDLIhK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AYUwKCbGvtCTx60DkELIz3VMimGftEil4VMnSeR24E=;
 b=kUfSIMQC0OH+H73pITtwALyVuHyGDZ++nDUmHRlCSflcrGOyXSX9X2cqf83p/972E3VtdLf00M/+LzUkWia/xlWcKRujQXBGg9gS0SyWMsheS4P3PkyV+FLC/Z54p7yePZVTDHvT3ciqBrgbMfAL0XGt994+KT8Mrf2DnmZBnEg=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:37:05 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:37:05 +0000
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
Subject: [PATCHv5 19/20] PCI: mobiveil: Add 8-bit and 16-bit register
 accessors
Thread-Topic: [PATCHv5 19/20] PCI: mobiveil: Add 8-bit and 16-bit register
 accessors
Thread-Index: AQHU8Qro+GZR0qQ8kEqE4mrq0ZGBSA==
Date:   Fri, 12 Apr 2019 08:37:05 +0000
Message-ID: <20190412083635.33626-20-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 46de97c0-2244-4a68-9260-08d6bf220af6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB5846208EA327B0020462E28384280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6mMn1oEdVO2RyI1E/v+1Jw9sstgPFKglCS1e2K8Bf2N8EEBKb6vNEEu+p9fqHbAd/lGFVE8z7Kzw++dlrYqoYiZaYXCL40NAlTllaMKUIUdfSSqHKf8+52PLsEIUJ+83y3ld6TJhiOhXDCriIf7IiIC+8tDp4PXDQmp1EEbQE3sNTED3sz0TY1iy53NNkh+ehDc4rBY4nR7Hl6MTIJVNKNLNJAJdRat3Mmk4R5+PzeA1imtxSMbSkIK6sWyGuQlIBcC4ETWEQ4nl6VAKR3dJg32Lj0XhlZoHmiXmC6SGjKxprkx2cvCzlx5T5RioKAXhCoAJzc5sTaBbaXUCzyYTcSImHo/wM8ZobNgNM2xTH3s27IFpsv7LOX6IMZKJoQ94B8UGcEXJVUQdGFvMthCYOqvt+Uz4Tkx0irOpfsCKwXE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46de97c0-2244-4a68-9260-08d6bf220af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:37:05.6691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhlcmUgYXJlIHNv
bWUgOC1iaXQgYW5kIDE2LWJpdCByZWdpc3RlcnMgaW4gUENJZQ0KY29uZmlndXJhdGlvbiBzcGFj
ZSwgc28gYWRkIGFjY2Vzc29ycyBmb3IgdGhlbS4NCg0KU2lnbmVkLW9mZi1ieTogSG91IFpoaXFp
YW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBNaW5naHVhbiBMaWFuIDxN
aW5naHVhbi5MaWFuQG54cC5jb20+DQpSZXZpZXdlZC1ieTogU3VicmFobWFueWEgTGluZ2FwcGEg
PGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQotLS0NClY1Og0KIC0gQ29ycmVjdGVkIGFu
ZCByZXRvdWNoZWQgdGhlIHN1YmplY3QgYW5kIGNoYW5nZWxvZy4NCiAtIE5vIGZ1bmN0aW9uYWxp
dHkgY2hhbmdlLg0KDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCAy
MCArKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQppbmRleCA0MTFlOTc3OWRh
MTIuLjQ1NmFkZmVlMzkzYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tb2JpdmVpbC5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwu
Yw0KQEAgLTI2OCwxMSArMjY4LDMxIEBAIHN0YXRpYyB1MzIgY3NyX3JlYWRsKHN0cnVjdCBtb2Jp
dmVpbF9wY2llICpwY2llLCB1MzIgb2ZmKQ0KIAlyZXR1cm4gY3NyX3JlYWQocGNpZSwgb2ZmLCAw
eDQpOw0KIH0NCiANCitzdGF0aWMgdTMyIGNzcl9yZWFkdyhzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAq
cGNpZSwgdTMyIG9mZikNCit7DQorCXJldHVybiBjc3JfcmVhZChwY2llLCBvZmYsIDB4Mik7DQor
fQ0KKw0KK3N0YXRpYyB1MzIgY3NyX3JlYWRiKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llLCB1
MzIgb2ZmKQ0KK3sNCisJcmV0dXJuIGNzcl9yZWFkKHBjaWUsIG9mZiwgMHgxKTsNCit9DQorDQog
c3RhdGljIHZvaWQgY3NyX3dyaXRlbChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyIHZh
bCwgdTMyIG9mZikNCiB7DQogCWNzcl93cml0ZShwY2llLCB2YWwsIG9mZiwgMHg0KTsNCiB9DQog
DQorc3RhdGljIHZvaWQgY3NyX3dyaXRldyhzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMy
IHZhbCwgdTMyIG9mZikNCit7DQorCWNzcl93cml0ZShwY2llLCB2YWwsIG9mZiwgMHgyKTsNCit9
DQorDQorc3RhdGljIHZvaWQgY3NyX3dyaXRlYihzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwg
dTMyIHZhbCwgdTMyIG9mZikNCit7DQorCWNzcl93cml0ZShwY2llLCB2YWwsIG9mZiwgMHgxKTsN
Cit9DQorDQogc3RhdGljIGJvb2wgbW9iaXZlaWxfcGNpZV9saW5rX3VwKHN0cnVjdCBtb2JpdmVp
bF9wY2llICpwY2llKQ0KIHsNCiAJcmV0dXJuIChjc3JfcmVhZGwocGNpZSwgTFRTU01fU1RBVFVT
KSAmDQotLSANCjIuMTcuMQ0KDQo=
