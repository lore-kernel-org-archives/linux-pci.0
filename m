Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450FBC10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165112184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lOM0HB/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDLIgx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:53 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:12672
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbfDLIgw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP5+GWonWaYMZ+WQieaIH3F7mlF5xXgqJoRZIqqyyEc=;
 b=lOM0HB/EX7kXwiKXDlvZ4PsoxeIGr3M0lTHz3n3dvQ+Uwqmrf8A1y4MpEfaUW3F8m65GrKmXjoIBOcMNltCjznYEK9bBe+kQDfQyJkPCNgMeidlkIwgFTlP6933aXAqwjoes2E7RIDJNCOkVQ8nIlYh+n3kki1FiS7yvR+WZmuA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:36:48 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:48 +0000
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
Subject: [PATCHv5 16/20] PCI: mobiveil: Add link up condition check
Thread-Topic: [PATCHv5 16/20] PCI: mobiveil: Add link up condition check
Thread-Index: AQHU8QreVEure7z7nE2dWdwI9OV74w==
Date:   Fri, 12 Apr 2019 08:36:48 +0000
Message-ID: <20190412083635.33626-17-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: ed8cbc1b-b1cf-48f5-0349-08d6bf2200b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB584641D2A967BB9641C9142B84280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(4744005)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +JUMBHPoLJHi2lpz8Xc+EIciOggRB3K0OKQp9rXITdUzW6LoWaRfeQyHxIIu3lv7fdkMoIB8GUOahqbCPKhqMxhH4w5io3tXtUWzXzcO+mqmH1d+9g5/qHAfY598m6JzByyn6/Wba5T/pWSwjEvlsim1GlQETepd1efiGyBKnY4ElWsTlUrV7ck2it5GDjyG18N3MVk9F0yEUlf/DyECl9TwJ6OlVAAQKo73g6/rnNYN4I6fIyT7QbsHmSj5jPW8f3uAZSLc5CqS3T+jHWkDHlPNNdcLvJQxTjKdG3PYb/CZ3H9AGgIl3cL53bu0Q2eorW0ibN6zzHN6Fke2XLFqNcJSv1T4ymlY41m64wokPcFr/Ge9tKFmyVYPLxe5RRdOQeAz7gPEEBt+V8embW/vFBvW80A0OgxTnZLitLBRAd0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8cbc1b-b1cf-48f5-0349-08d6bf2200b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:48.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQXZvaWQgdG8gaXNz
dWUgQ0ZHIHRyYW5zYWN0aW9ucyB0byBsaW5rIHBhcnRuZXIgd2hlbiB0aGUgUENJZQ0KbGluayBp
cyBub3QgdXAuDQoNClNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54
cC5jb20+DQotLS0NClY1Og0KIC0gQ29ycmVjdGVkIHRoZSBzdWJqZWN0Lg0KDQogZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCA0ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbW9iaXZlaWwuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQpp
bmRleCA2MjE4NTIwNzhjYWYuLjFlZTNlYTI1NzBjMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtbW9iaXZlaWwuYw0KQEAgLTI4Myw2ICsyODMsMTAgQEAgc3RhdGljIGJvb2wgbW9iaXZl
aWxfcGNpZV92YWxpZF9kZXZpY2Uoc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRl
dmZuKQ0KIHsNCiAJc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUgPSBidXMtPnN5c2RhdGE7DQog
DQorCS8qIElmIHRoZXJlIGlzIG5vIGxpbmssIHRoZW4gdGhlcmUgaXMgbm8gZGV2aWNlICovDQor
CWlmIChidXMtPm51bWJlciA+IHBjaWUtPnJvb3RfYnVzX25yICYmICFtb2JpdmVpbF9wY2llX2xp
bmtfdXAocGNpZSkpDQorCQlyZXR1cm4gZmFsc2U7DQorDQogCS8qIE9ubHkgb25lIGRldmljZSBk
b3duIG9uIGVhY2ggcm9vdCBwb3J0ICovDQogCWlmICgoYnVzLT5udW1iZXIgPT0gcGNpZS0+cm9v
dF9idXNfbnIpICYmIChkZXZmbiA+IDApKQ0KIAkJcmV0dXJuIGZhbHNlOw0KLS0gDQoyLjE3LjEN
Cg0K
