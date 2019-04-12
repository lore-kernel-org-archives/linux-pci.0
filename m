Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2BC10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DB42184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADS8gFBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfDLIg2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:28 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:58757
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfDLIg1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td6nGy9pZI+6f3PJ0XGDp9n0ursU4PSPZjJ/MmiwdpM=;
 b=ADS8gFBkW0MLfVfy829WQQ31UmAiDFVVd9crmdH+bbyvpClCt5kY6bzR2U8678rEMVTntZvpmbUu18Yr7H/cmGkFpFa26ILHOBta7baxFCrP9SEcu/tguti9vtNGKqi3WdnqB3kHWbX3lQvTqUDgAtZCOX2XtUSQf1rlA5WcRFA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4183.eurprd04.prod.outlook.com (52.135.162.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 08:36:23 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:23 +0000
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
Subject: [PATCHv5 12/20] PCI: mobiveil: Move the link up waiting out of
 mobiveil_host_init()
Thread-Topic: [PATCHv5 12/20] PCI: mobiveil: Move the link up waiting out of
 mobiveil_host_init()
Thread-Index: AQHU8QrP75iEHD9oNkeVKVqSiiGp+g==
Date:   Fri, 12 Apr 2019 08:36:23 +0000
Message-ID: <20190412083635.33626-13-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3a9fc3e7-cc71-4101-3427-08d6bf21f20f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4183;
x-ms-traffictypediagnostic: AM6PR04MB4183:
x-microsoft-antispam-prvs: <AM6PR04MB4183CB5AEEAF8EEA8BA6F80984280@AM6PR04MB4183.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(54534003)(7416002)(102836004)(446003)(52116002)(53936002)(50226002)(186003)(81166006)(8936002)(81156014)(26005)(106356001)(6506007)(6436002)(8676002)(7736002)(110136005)(6486002)(6512007)(54906003)(66066001)(2906002)(386003)(316002)(105586002)(99286004)(305945005)(5660300002)(86362001)(1076003)(71190400001)(97736004)(2201001)(71200400001)(68736007)(36756003)(76176011)(14454004)(256004)(2501003)(486006)(476003)(11346002)(2616005)(478600001)(3846002)(6116002)(4326008)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4183;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qg4ZxDcdoX0uf9yEXP9n7fWyIFaqKWG/N6F5QGb+hY+wCDzoJojWgaRuMqLbufQ98MMOwdyG7XlOq5c3HgTlF9Iy3/dSrWF8awAl1gsk2jT41eaXEjFsDVSBygJCRPYMriyD5hwjyQefWIusVhEh1H9WPo3a1qcvQgRL1deF8rLO3OtBd7DE/F+mO3fA2aVHsnSamRrMoeu9IlmNxWULeWsPSxfOUkRacWnZvc7DL+jU2PI2kFidE3jsBY8nDjaD3kA4ERtNfMbManUEa/TJFxwdsISLMfpfvjLHTZ5plFaMhdtzs85WMxJERPjmdlnEIi1ikXxpDpX8v15KP7031I1F4zaPySsez/NUgPofEhPo00wEzdjTqEKNbvRHGOU+261Qi8A0YpKeM1edkR6KdMijeqZDf8GNemClmXJvvoo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9fc3e7-cc71-4101-3427-08d6bf21f20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:23.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4183
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhlIGhvc3QgaW5p
dGlhbGl6ZSBzZXF1ZW5jZSBkb2VzIG5vdCBkZXBlbmQgb24gUENJZSBsaW5rIHVwLA0Kc28gbW92
ZSBpdCB0byB0aGUgcGxhY2UganVzdCBiZWZvcmUgdGhlIGVudW1lcmF0aW9uLg0KDQpTaWduZWQt
b2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6
IE1pbmdodWFuIExpYW4gPE1pbmdodWFuLkxpYW5AbnhwLmNvbT4NClJldmlld2VkLWJ5OiBTdWJy
YWhtYW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCi0tLQ0KVjU6
DQogLSBDb3JyZWN0ZWQgYW5kIHJldG91Y2hlZCB0aGUgc3ViamVjdCBhbmQgY2hhbmdlbG9nLg0K
DQogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCAxNSArKysrKysrLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KaW5kZXggOGVlZTFhYjdlZTI0
Li5jMjg0OGMyMmI0NjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
bW9iaXZlaWwuYw0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMN
CkBAIC01ODIsMTUgKzU4Miw4IEBAIHN0YXRpYyB2b2lkIG1vYml2ZWlsX3BjaWVfZW5hYmxlX21z
aShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiBzdGF0aWMgaW50IG1vYml2ZWlsX2hvc3Rf
aW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiB7DQogCXUzMiB2YWx1ZSwgcGFiX2N0
cmwsIHR5cGU7DQotCWludCBlcnI7DQogCXN0cnVjdCByZXNvdXJjZV9lbnRyeSAqd2luOw0KIA0K
LQllcnIgPSBtb2JpdmVpbF9icmluZ3VwX2xpbmsocGNpZSk7DQotCWlmIChlcnIpIHsNCi0JCWRl
dl9pbmZvKCZwY2llLT5wZGV2LT5kZXYsICJsaW5rIGJyaW5nLXVwIGZhaWxlZFxuIik7DQotCQly
ZXR1cm4gZXJyOw0KLQl9DQotDQogCS8qDQogCSAqIHByb2dyYW0gQnVzIE1hc3RlciBFbmFibGUg
Qml0IGluIENvbW1hbmQgUmVnaXN0ZXIgaW4gUEFCIENvbmZpZw0KIAkgKiBTcGFjZQ0KQEAgLTY2
Miw3ICs2NTUsNyBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZl
aWxfcGNpZSAqcGNpZSkNCiAJLyogc2V0dXAgTVNJIGhhcmR3YXJlIHJlZ2lzdGVycyAqLw0KIAlt
b2JpdmVpbF9wY2llX2VuYWJsZV9tc2kocGNpZSk7DQogDQotCXJldHVybiBlcnI7DQorCXJldHVy
biAwOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBtb2JpdmVpbF9tYXNrX2ludHhfaXJxKHN0cnVjdCBp
cnFfZGF0YSAqZGF0YSkNCkBAIC05MjIsNiArOTE1LDEyIEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxf
cGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlicmlkZ2UtPm1hcF9p
cnEgPSBvZl9pcnFfcGFyc2VfYW5kX21hcF9wY2k7DQogCWJyaWRnZS0+c3dpenpsZV9pcnEgPSBw
Y2lfY29tbW9uX3N3aXp6bGU7DQogDQorCXJldCA9IG1vYml2ZWlsX2JyaW5ndXBfbGluayhwY2ll
KTsNCisJaWYgKHJldCkgew0KKwkJZGV2X2luZm8oZGV2LCAibGluayBicmluZy11cCBmYWlsZWRc
biIpOw0KKwkJZ290byBlcnJvcjsNCisJfQ0KKw0KIAkvKiBzZXR1cCB0aGUga2VybmVsIHJlc291
cmNlcyBmb3IgdGhlIG5ld2x5IGFkZGVkIFBDSWUgcm9vdCBidXMgKi8NCiAJcmV0ID0gcGNpX3Nj
YW5fcm9vdF9idXNfYnJpZGdlKGJyaWRnZSk7DQogCWlmIChyZXQpDQotLSANCjIuMTcuMQ0KDQo=
