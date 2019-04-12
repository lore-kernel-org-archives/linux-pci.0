Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF8C10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6759D2084D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="APjHhpQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfDLIfk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:35:40 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:39838
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726914AbfDLIfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU1gBR+l4L8bwID1yfbebtv1B5m1donxOM347JMmWII=;
 b=APjHhpQnzZlUJWlQHzp3XmDx7yUosuPP/cTrc4W7lpnHKhrO68Q5AT3KDSjONL5WoJOKdMe/FlpXq/id8/Fn8elO1oFrD02hmza5wS3wxDnHCCgKP5DCTlsmLFFhAJmOZkbiUDZxaTv6x9jE9LSuehLM/1U+zwhzZkQkng/GA3w=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:35:37 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:35:37 +0000
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
Subject: [PATCHv5 04/20] PCI: mobiveil: Remove the flag MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCHv5 04/20] PCI: mobiveil: Remove the flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHU8Qqz/gJFKoxI7kSHS+a5VfCWFQ==
Date:   Fri, 12 Apr 2019 08:35:36 +0000
Message-ID: <20190412083635.33626-5-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: e9e02426-ab13-46b9-c126-08d6bf21d608
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB5846CEC0BDB776DDA65AF47C84280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14444005)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(4744005)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XFQWfSFmFEtPmtXpyGmGqpIq8BIpF+j7M6XrftdYjpMfHRPBYlYAFKLrRgkZ0EgqT/6Es5YGdtbVdYRT6pIYgRS7UQYWynuSyTBXPuMrTNiO1dkQbl3IFsSC2FUR4yKieBd5CZOIm272DgBmTs0haRO6xMcp8aKJ9p+xK9oYeRA0JaiQ9Dr/295nTbuODT8x473mhAy5lwmeNZ7iI520Qfvlei++ISCq+sz4fTNqJYksnbV2cenzNnghGgo1TvzmhR3QkKZwUvCB8HAHlcUHbmb8IerEZXjQAqwoelns9vfbb6FiftNX5rqiHAzdfz6PVWEb69A/kiWip+cybDNecEQZw/wfZ3obhF0yPEu0TN+YuZE5kpt6bSb3flFyi7xfeEMMxyQFneyQ6gjAM0GQRSZUgEoUfq9a4UeScnD+Vuo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e02426-ab13-46b9-c126-08d6bf21d608
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:35:37.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhlIGN1cnJlbnQg
Y29kZSBkb2VzIG5vdCBzdXBwb3J0IG11bHRpcGxlIE1TSXMsIHNvIHJlbW92ZQ0KdGhlIGNvcnJl
c3BvbmRpbmcgZmxhZyBmcm9tIHRoZSBtc2lfZG9tYWluX2luZm8gc3RydWN0dXJlLg0KDQpGaXhl
czogMWU5MTNlNTgzMzVmICgiUENJOiBtb2JpdmVpbDogQWRkIE1TSSBzdXBwb3J0IikNClNpZ25l
ZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQpSZXZpZXdlZC1i
eTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29tPg0KLS0tDQpWNToNCiAtIENv
cnJlY3RlZCB0aGUgc3ViamVjdC4NCg0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2Jp
dmVpbC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWls
LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KaW5kZXggNTYzMjEw
ZTczMWQzLi5hMGRkMzM3YzYyMTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtbW9iaXZlaWwuYw0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2
ZWlsLmMNCkBAIC03MDMsNyArNzAzLDcgQEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBtb2JpdmVp
bF9tc2lfaXJxX2NoaXAgPSB7DQogDQogc3RhdGljIHN0cnVjdCBtc2lfZG9tYWluX2luZm8gbW9i
aXZlaWxfbXNpX2RvbWFpbl9pbmZvID0gew0KIAkuZmxhZ3MJPSAoTVNJX0ZMQUdfVVNFX0RFRl9E
T01fT1BTIHwgTVNJX0ZMQUdfVVNFX0RFRl9DSElQX09QUyB8DQotCQkgICBNU0lfRkxBR19NVUxU
SV9QQ0lfTVNJIHwgTVNJX0ZMQUdfUENJX01TSVgpLA0KKwkJICAgTVNJX0ZMQUdfUENJX01TSVgp
LA0KIAkuY2hpcAk9ICZtb2JpdmVpbF9tc2lfaXJxX2NoaXAsDQogfTsNCiANCi0tIA0KMi4xNy4x
DQoNCg==
