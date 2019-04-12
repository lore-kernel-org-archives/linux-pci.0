Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55456C10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259352186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="egcFB3kQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfDLIgF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:05 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:7975
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbfDLIgE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZpJBWOEoGZWx6zfMH3SiTSeijrqH6pH6njmCP6mt0o=;
 b=egcFB3kQyTX9OA0pHWC5WDWf4U5wlGOHx2OxOW7CSewr5RYCHdKvHFB3mGWLYVtbJ9B7i2X2otv1L3BkNW3rg8fAqKftQkOup5XSOPpITW41kr0pVVptbstRzC8pLc6zwPqdgRD0De2ZcnET+x7Zy+LfQqgW6r+tjmehPEB9/Ik=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:36:01 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:01 +0000
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
Subject: [PATCHv5 08/20] PCI: mobiveil: Use the 1st inbound window for MEM
 inbound transactions
Thread-Topic: [PATCHv5 08/20] PCI: mobiveil: Use the 1st inbound window for
 MEM inbound transactions
Thread-Index: AQHU8QrC2oaNOTxwc0KYfHKro/AvVQ==
Date:   Fri, 12 Apr 2019 08:36:00 +0000
Message-ID: <20190412083635.33626-9-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 69401896-1d28-47b0-2ffb-08d6bf21e40f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB58468F3CA590E74D182F852A84280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14444005)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XMOEOI2JxFDfoIqraGl8IgVA1giSswng1ecza6lcNZO0WU1PWqxpywcW+0EuWinGp+U2NfCG8Ra9DcBISAhdDrDypSZHJewATkwK2M+7KGLXbbLCI3xZj4RJpKFLv0zmzU4O5jZdLlUfCe4TaqEi3DC+BPzsgsS2YAGmWTlVMmJZgGcvx6xooC+c+8GswY7G6mLsgQDmrBbZZdDasm5uCpY4pR2UhuQ0ZQXT26cRj5qnu65NrBOJBSE5OOm2NT36JqwEgOS7py90OkatfkvvtfbY73YKR08qVqMzT53rRVaaRr8vVXyzWLHL/hvzCufBulGZvaaRgNietT75IhEvA0phbw3884XS6CLVmUU342l3uXSw+1pUhvTr7Xidf+AxXIWSfykfegXa//uGcF6eo62CRkc+HNghb3IXSEnKIgQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69401896-1d28-47b0-2ffb-08d6bf21e40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:00.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhlIGluYm91bmQg
d2luZG93cyBoYXZlIGluZGVwZW5kZW50IHJlZ2lzdGVyIHNldCBhZ2FpbnN0IG91dGJvdW5kIHdp
bmRvd3MuDQpUaGlzIHBhdGNoIGNoYW5nZSB0aGUgTUVNIGluYm91bmQgd2luZG93IHRvIHRoZSBm
aXJzdCBvbmUuDQoNClNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54
cC5jb20+DQpSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29t
Pg0KUmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2
ZWlsLmNvLmluPg0KLS0tDQpWNToNCiAtIENvcnJlY3RlZCBhbmQgcmV0b3VjaGVkIHRoZSBzdWJq
ZWN0IGFuZCBjaGFuZ2Vsb2cuDQoNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZl
aWwuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5j
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCmluZGV4IGRmNzFjMTFi
NDgxMC4uZTg4YWZjNzkyYTVjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLW1vYml2ZWlsLmMNCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVp
bC5jDQpAQCAtNjE2LDcgKzYxNiw3IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfaG9zdF9pbml0KHN0
cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKQ0KIAkJCSAgIENGR19XSU5ET1dfVFlQRSwgcmVzb3Vy
Y2Vfc2l6ZShwY2llLT5vYl9pb19yZXMpKTsNCiANCiAJLyogbWVtb3J5IGluYm91bmQgdHJhbnNs
YXRpb24gd2luZG93ICovDQotCXByb2dyYW1faWJfd2luZG93cyhwY2llLCBXSU5fTlVNXzEsIDAs
IE1FTV9XSU5ET1dfVFlQRSwgSUJfV0lOX1NJWkUpOw0KKwlwcm9ncmFtX2liX3dpbmRvd3MocGNp
ZSwgV0lOX05VTV8wLCAwLCBNRU1fV0lORE9XX1RZUEUsIElCX1dJTl9TSVpFKTsNCiANCiAJLyog
R2V0IHRoZSBJL08gYW5kIG1lbW9yeSByYW5nZXMgZnJvbSBEVCAqLw0KIAlyZXNvdXJjZV9saXN0
X2Zvcl9lYWNoX2VudHJ5KHdpbiwgJnBjaWUtPnJlc291cmNlcykgew0KLS0gDQoyLjE3LjENCg0K
