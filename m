Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B357C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8952184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Et2hj3nG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfDLIgT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:19 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:4153
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbfDLIgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdrYnYmg2rbnYsxtk3doEzJ1fhSzTcLnhskxjeLlvcU=;
 b=Et2hj3nGW9M0nA0WXvrmvgpYvjV9TVe2N12399SUtwEXsYT7Zdb4XMxsA8y8ZEUHUofXQ7K26ArH6guExhsLo/s676eIDFiCYeYYgeWYXQFWeO09wIbr3cdXN1hSc7G5xgysM5F190XGc4ndLEXTivPSphz30Xbd+FrjlXXl8Bk=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:36:12 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:12 +0000
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
Subject: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Thread-Topic: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Thread-Index: AQHU8QrIICRAPGaNQUWlVdR7PlC4dA==
Date:   Fri, 12 Apr 2019 08:36:12 +0000
Message-ID: <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: c7cb07dd-c83f-4222-451e-08d6bf21eb2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB58463409ACDAB97F0F1FDE6884280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14444005)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nzYmerYz5F3ohNfb2cZ++f1li8hfA0lPXuTpbwJpJqsmsu8NtxS7Mk8gzcNRFgQ357N/cZtGHKojrgCag2FsiGqZDLexIGV/Vpc+RGo2jtRbOu1Xo/FdcNwcZ6uK2bfDGziKFyB7Fhbn1cPJD0vGrLf9P1pd8yhMS/0WYUX57jCgZrAp0ewW/RUTcZurcDc/s0nuEXvTITDbg77wJ2pHMw7upY2DHGZ1EIcn1QbKespI/eV8jBcRxbsUfyKCyfE7NGy1PSh5S+ZLNEzXlYly6IAqB62MMOUbaerN+hL+1kMaBMiyN/hkkx/EicC2OMlrc+7phGIyg8LOEIWTEJlcqS3HaXpHA2W+QiSNFClv/guRDsZGz2ps/PzPapLnfDfRDjFM5JL4znNqRaigju+xUhEfMniglWTHlvtEdUuiC1g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cb07dd-c83f-4222-451e-08d6bf21eb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:12.4471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KSW4gdGhlIGxvb3Ag
YmxvY2ssIHRoZXJlIGlzIG5vdCBjb2RlIHRvIHVwZGF0ZSB0aGUgbG9vcCBrZXksDQp0aGlzIHBh
dGNoIHVwZGF0ZXMgdGhlIGxvb3Aga2V5IGJ5IHJlLXJlYWQgdGhlIElOVHggc3RhdHVzDQpyZWdp
c3Rlci4NCg0KVGhpcyBwYXRjaCBhbHNvIGFkZCB0aGUgY2xlYXJpbmcgb2YgdGhlIGhhbmRsZWQg
SU5UeCBzdGF0dXMuDQoNCk5vdGU6IE5lZWQgTVYgdG8gdGVzdCB0aGlzIGZpeC4NCg0KRml4ZXM6
IDlhZjZiY2IxMWUxMiAoIlBDSTogbW9iaXZlaWw6IEFkZCBNb2JpdmVpbCBQQ0llIEhvc3QgQnJp
ZGdlIElQIGRyaXZlciIpDQpTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IE1pbmdodWFuIExpYW4gPE1pbmdodWFuLkxpYW5Abnhw
LmNvbT4NClJldmlld2VkLWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBt
b2JpdmVpbC5jby5pbj4NCi0tLQ0KVjU6DQogLSBDb3JyZWN0ZWQgYW5kIHJldG91Y2hlZCB0aGUg
c3ViamVjdCBhbmQgY2hhbmdlbG9nLg0KDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1v
Yml2ZWlsLmMgfCAxMyArKysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1tb2JpdmVpbC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWls
LmMNCmluZGV4IDRiYTQ1ODQ3NGU0Mi4uNzhlNTc1ZTcxZjRkIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tb2JpdmVpbC5jDQpAQCAtMzYxLDYgKzM2MSw3IEBAIHN0YXRpYyB2b2lkIG1v
Yml2ZWlsX3BjaWVfaXNyKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCiAJLyogSGFuZGxlIElOVHgg
Ki8NCiAJaWYgKGludHJfc3RhdHVzICYgUEFCX0lOVFBfSU5UWF9NQVNLKSB7DQogCQlzaGlmdGVk
X3N0YXR1cyA9IGNzcl9yZWFkbChwY2llLCBQQUJfSU5UUF9BTUJBX01JU0NfU1RBVCk7DQorCQlz
aGlmdGVkX3N0YXR1cyAmPSBQQUJfSU5UUF9JTlRYX01BU0s7DQogCQlzaGlmdGVkX3N0YXR1cyA+
Pj0gUEFCX0lOVFhfU1RBUlQ7DQogCQlkbyB7DQogCQkJZm9yX2VhY2hfc2V0X2JpdChiaXQsICZz
aGlmdGVkX3N0YXR1cywgUENJX05VTV9JTlRYKSB7DQpAQCAtMzcyLDEyICszNzMsMTYgQEAgc3Rh
dGljIHZvaWQgbW9iaXZlaWxfcGNpZV9pc3Ioc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KIAkJCQkJ
ZGV2X2Vycl9yYXRlbGltaXRlZChkZXYsICJ1bmV4cGVjdGVkIElSUSwgSU5UJWRcbiIsDQogCQkJ
CQkJCSAgICBiaXQpOw0KIA0KLQkJCQkvKiBjbGVhciBpbnRlcnJ1cHQgKi8NCi0JCQkJY3NyX3dy
aXRlbChwY2llLA0KLQkJCQkJICAgc2hpZnRlZF9zdGF0dXMgPDwgUEFCX0lOVFhfU1RBUlQsDQor
CQkJCS8qIGNsZWFyIGludGVycnVwdCBoYW5kbGVkICovDQorCQkJCWNzcl93cml0ZWwocGNpZSwg
MSA8PCAoUEFCX0lOVFhfU1RBUlQgKyBiaXQpLA0KIAkJCQkJICAgUEFCX0lOVFBfQU1CQV9NSVND
X1NUQVQpOw0KIAkJCX0NCi0JCX0gd2hpbGUgKChzaGlmdGVkX3N0YXR1cyA+PiBQQUJfSU5UWF9T
VEFSVCkgIT0gMCk7DQorDQorCQkJc2hpZnRlZF9zdGF0dXMgPSBjc3JfcmVhZGwocGNpZSwNCisJ
CQkJCQkgICBQQUJfSU5UUF9BTUJBX01JU0NfU1RBVCk7DQorCQkJc2hpZnRlZF9zdGF0dXMgJj0g
UEFCX0lOVFBfSU5UWF9NQVNLOw0KKwkJCXNoaWZ0ZWRfc3RhdHVzID4+PSBQQUJfSU5UWF9TVEFS
VDsNCisJCX0gd2hpbGUgKHNoaWZ0ZWRfc3RhdHVzICE9IDApOw0KIAl9DQogDQogCS8qIHJlYWQg
ZXh0cmEgTVNJIHN0YXR1cyByZWdpc3RlciAqLw0KLS0gDQoyLjE3LjENCg0K
