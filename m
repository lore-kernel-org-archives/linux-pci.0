Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C7BC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BF82184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nZHkec7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfDLIgf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:35 -0400
Received: from mail-eopbgr130055.outbound.protection.outlook.com ([40.107.13.55]:55108
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfDLIgf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqvEnszV82kVT+aFyv+MMNKGqVlpYea9sV8JORrjfl8=;
 b=nZHkec7lnIN0QRRY7HO2mAVKkKeSaaeyWpX1IrEwfhePC0M0GYdxhmKI8mTAMJUJealISsVNvJnxniO8m19TLOByEkSAT8Tp6arSw/b8j4ZerVA2ZQ+8Icky02BDvhvEWS6gUjbKTJ13mSdb3xBpptts/zoOZHEgYSI/kvuO6Dc=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4183.eurprd04.prod.outlook.com (52.135.162.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 08:36:30 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:30 +0000
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
Subject: [PATCHv5 13/20] PCI: mobiveil: Move IRQ chained handler setup out of
 DT parse
Thread-Topic: [PATCHv5 13/20] PCI: mobiveil: Move IRQ chained handler setup
 out of DT parse
Thread-Index: AQHU8QrTfopCD+sT5UucqhCA6WzlIg==
Date:   Fri, 12 Apr 2019 08:36:30 +0000
Message-ID: <20190412083635.33626-14-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4443c359-9c11-4837-ad8c-08d6bf21f5a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4183;
x-ms-traffictypediagnostic: AM6PR04MB4183:
x-microsoft-antispam-prvs: <AM6PR04MB4183AC011FD8A4CA9107FF8984280@AM6PR04MB4183.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(7416002)(102836004)(446003)(52116002)(53936002)(50226002)(186003)(81166006)(8936002)(81156014)(26005)(106356001)(6506007)(6436002)(8676002)(7736002)(110136005)(6486002)(6512007)(54906003)(66066001)(2906002)(386003)(316002)(105586002)(99286004)(305945005)(5660300002)(86362001)(1076003)(71190400001)(97736004)(2201001)(71200400001)(4744005)(68736007)(36756003)(76176011)(14454004)(256004)(2501003)(486006)(476003)(11346002)(14444005)(2616005)(478600001)(3846002)(6116002)(4326008)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4183;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +jejVblDwIVCmLB7Nw513y1U9wZTcenIDBqbptB2M/jXPMzBJ4Xrb63ftatEJcprqHweCj8hY/IWnLuZTANHfry2+muY6YhfLrQu8crd0vPMXbLi4UVbbNGZ56oynQnfVWrBxNy+15ZQcdCWSVhxveB2+PlsLJzFxSGDMQDSw+00qWPZG6ZXHe3Bk4TpDsxQQkQeFsyoHK6ZiU17A2bemEvlNs1Ya/wejG2T2AhiTmBTeAZkfF4GcxOTLgYJC7uOovSxriloZoXgCaB6Xc+HbLM662dGC3X/9KEZ5aLZGpfESnXCgao0EiQjq7krCeMS7n5F6wqkE6WppptHd5yx388TUiAVSaVjOEwHFUtmQIY4FEYaBbrSA3UNvPQq+893M3A/K3PLC7z1ckNx2DRJ+x0P7q9aE7pSh1V6Yi7vzDQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4443c359-9c11-4837-ad8c-08d6bf21f5a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:30.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4183
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KTW92ZSBpcnFfc2V0
X2NoYWluZWRfaGFuZGxlcl9hbmRfZGF0YSgpIG91dCBvZiBEVCBwYXJzZSBmdW5jdGlvbi4NCg0K
U2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmll
d2VkLWJ5OiBNaW5naHVhbiBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQpSZXZpZXdlZC1i
eTogU3VicmFobWFueWEgTGluZ2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQot
LS0NClY1Og0KIC0gQ29ycmVjdGVkIHRoZSBzdWJqZWN0Lg0KDQogZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZl
aWwuYw0KaW5kZXggYzI4NDhjMjJiNDY2Li5kYjdlY2IwMjFjNjMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCkBAIC00NjAsOCArNDYwLDYgQEAgc3RhdGljIGludCBt
b2JpdmVpbF9wY2llX3BhcnNlX2R0KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKQ0KIAkJcmV0
dXJuIC1FTk9ERVY7DQogCX0NCiANCi0JaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5kX2RhdGEo
cGNpZS0+aXJxLCBtb2JpdmVpbF9wY2llX2lzciwgcGNpZSk7DQotDQogCXJldHVybiAwOw0KIH0N
CiANCkBAIC05MDIsNiArOTAwLDggQEAgc3RhdGljIGludCBtb2JpdmVpbF9wY2llX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlnb3RvIGVycm9yOw0KIAl9DQogDQorCWly
cV9zZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKHBjaWUtPmlycSwgbW9iaXZlaWxfcGNpZV9p
c3IsIHBjaWUpOw0KKw0KIAlyZXQgPSBkZXZtX3JlcXVlc3RfcGNpX2J1c19yZXNvdXJjZXMoZGV2
LCAmcGNpZS0+cmVzb3VyY2VzKTsNCiAJaWYgKHJldCkNCiAJCWdvdG8gZXJyb3I7DQotLSANCjIu
MTcuMQ0KDQo=
