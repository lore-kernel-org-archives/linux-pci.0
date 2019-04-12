Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D7C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5007D2186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lG7bl9E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfDLIgr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:47 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:17320
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfDLIgq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWH8RDxbJ2dvwntQ1NSC9UgZZ+9hzinTZGYfr3Yi23Q=;
 b=lG7bl9E0moneGQvVc7GRqktaFB7OM3TTNIw++bGlk3fndaBQjbKOmgBuVu6y8EOuVS0mq0QO+OQF5Bmwx7a3a8UtVSDmZ1xGEGeBfDcGVRINYuihDslx4SnalbK36b7akNAFW+L3j3891ghQr6l3Jc70uiPgcngdCo53obpjv+8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:36:42 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:42 +0000
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
Subject: [PATCHv5 15/20] PCI: mobiveil: Fix the checking of valid device
Thread-Topic: [PATCHv5 15/20] PCI: mobiveil: Fix the checking of valid device
Thread-Index: AQHU8QrbpZrQvNQjLkyw0s9gKsKrYg==
Date:   Fri, 12 Apr 2019 08:36:42 +0000
Message-ID: <20190412083635.33626-16-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: c1d34133-07f4-4a69-6bcb-08d6bf21fd5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB5846A4DD925B43921ECB0E0584280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14444005)(14454004)(5024004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(4744005)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0rqSjr61+aaerDe6TLIkyt+DZtM30s1TSjE7TnEluTJ9mWmh/vLjVh7mZYw4hzYgBVFkZtxoE1JS8Day88G34p1RNT1iaUnjWUPshxwOjvhITulyp31XX7hO+mTxKQ0apI7DBhsEZnLJplr9SS9qkVNiq6z4G3O2eEToeRtM19gEtCJ/BT0X3IgP4nAlzO03Pq3Dgb5lybdDoTFncVypZtf/8nRaN1k357vQgXwu+sizo793H3LfEY4zQ649Q0V7owPebImxplhrEaE8lvMTGr+EZg/ICernqB57vl9xBJyvFrtr40jcPZXop38vYKHNqeviKAMMlRS1LebrtAHPK1jawN4Z3VKOPCQE5Zwrxv8i1SEzTOGY8P9lfu8wWcSSL8c4mt42IdNHAqa2eTuxyt0YdbNTzN1pnpI0rcsmPLM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d34133-07f4-4a69-6bcb-08d6bf21fd5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:42.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQWxsb3cgQ0ZHIHRy
YW5zYWN0aW9ucyB0byBhbGwgZnVuY3Rpb25zIG9mIEVuZHBvaW50IGltcGxlbWVudGVkDQptdWx0
aXBsZSBmdW5jdGlvbnMuDQoNCkZpeGVzOiA5YWY2YmNiMTFlMTIgKCJQQ0k6IG1vYml2ZWlsOiBB
ZGQgTW9iaXZlaWwgUENJZSBIb3N0IEJyaWRnZSBJUCBkcml2ZXIiKQ0KU2lnbmVkLW9mZi1ieTog
SG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBNaW5naHVh
biBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQotLS0NClY1Og0KIC0gQ29ycmVjdGVkIGFu
ZCByZXRvdWNoZWQgdGhlIHN1YmplY3QgYW5kIGNoYW5nZWxvZy4NCg0KIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZl
aWwuYw0KaW5kZXggOTIxMDE2NWZlOGMwLi42MjE4NTIwNzhjYWYgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCkBAIC0yOTEsNyArMjkxLDcgQEAgc3RhdGljIGJvb2wg
bW9iaXZlaWxfcGNpZV92YWxpZF9kZXZpY2Uoc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQg
aW50IGRldmZuKQ0KIAkgKiBEbyBub3QgcmVhZCBtb3JlIHRoYW4gb25lIGRldmljZSBvbiB0aGUg
YnVzIGRpcmVjdGx5DQogCSAqIGF0dGFjaGVkIHRvIFJDDQogCSAqLw0KLQlpZiAoKGJ1cy0+cHJp
bWFyeSA9PSBwY2llLT5yb290X2J1c19ucikgJiYgKGRldmZuID4gMCkpDQorCWlmICgoYnVzLT5w
cmltYXJ5ID09IHBjaWUtPnJvb3RfYnVzX25yKSAmJiAoUENJX1NMT1QoZGV2Zm4pID4gMCkpDQog
CQlyZXR1cm4gZmFsc2U7DQogDQogCXJldHVybiB0cnVlOw0KLS0gDQoyLjE3LjENCg0K
