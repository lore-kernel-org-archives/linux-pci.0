Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A5C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665262184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LhZ8rFMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDLIfr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:35:47 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:19079
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbfDLIfq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wlUAXNed+6Qf18q8DlLkZnaqEr5bMrRBJ4QXDWIo+0=;
 b=LhZ8rFMHrLDMCV0t332FoLcZqD8Tll0sdq5Z3qQakNqZSU/obaD94JHye76Im2i7ybSLTL4chrREIKVWw0FUZ1CGLKnE4y8ep3EJL56Ms03OJGN6RxClFyrQqppMR9RmhW17EYEtPLv/8V+0rCn9BDWf/rySonQcniEOAjJ3XnQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:35:43 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:35:43 +0000
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
Subject: [PATCHv5 05/20] PCI: mobiveil: Correct PCI base address in MEM/IO
 outbound windows
Thread-Topic: [PATCHv5 05/20] PCI: mobiveil: Correct PCI base address in
 MEM/IO outbound windows
Thread-Index: AQHU8Qq3PLpze6uFBUq5ddlqvoEjuw==
Date:   Fri, 12 Apr 2019 08:35:42 +0000
Message-ID: <20190412083635.33626-6-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 4e45d3a8-b966-4b7b-0bb7-08d6bf21d991
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB5846AB78A821166213462D7684280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bj7UePaurA+66C8TdgWER7Fs/+yTuvc86oAG+/r1b8bjHMpxShQylFzgBVoUsyt5GgpKg/JpuOJTJpdaEKRBBZB6m/J3SzTkbrfD1FMfqMe784zHmP1BKiePsB4ZwgNddXnf0giuJ+UGmQeUPGlOikVkKdMQAfTNY4S3VwQ0WyIEwRiusRLggbnfa0EycSfP32HhFIbDmdxS3bVF5vemA25ZfLfFp5pS3ax92Zp75zgO+t1hFNRKjThSKrAXnuQ3P/WzVir3i8Ezi916Nc6f/T1640+HOPVD5sQL1nS07zAOTNYjBMi9OaVSTvyDIo5rJa50e/YJA1jjm7TNxcPxD1PpoQoV2ko5Kg5xxK7ERVXQOnAZW7Tum0Ghe4mE2JcEnAbt5nwVt5R3hD+A68oZibedqMoE2A5sg7I8d4UiiEo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e45d3a8-b966-4b7b-0bb7-08d6bf21d991
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:35:42.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KSXQgc2hvdWxkIGdl
dCBQQ0kgYmFzZSBhZGRyZXNzIGZyb20gdGhlICdyYW5nZXMnIHByb3BlcnR5IG9mIERUIG5vZGUN
CnRvIHNldHVwIE1FTS9JTyBvdXRib3VuZCB3aW5kb3dzIGluc3RlYWQgb2YgYWx3YXlzIHVzaW5n
IHplcm8uDQoNCkZpeGVzOiA5YWY2YmNiMTFlMTIgKCJQQ0k6IG1vYml2ZWlsOiBBZGQgTW9iaXZl
aWwgUENJZSBIb3N0IEJyaWRnZSBJUCBkcml2ZXIiKQ0KU2lnbmVkLW9mZi1ieTogSG91IFpoaXFp
YW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBNaW5naHVhbiBMaWFuIDxN
aW5naHVhbi5MaWFuQG54cC5jb20+DQpSZXZpZXdlZC1ieTogU3VicmFobWFueWEgTGluZ2FwcGEg
PGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQotLS0NClY1Og0KIC0gQ29ycmVjdGVkIGFu
ZCByZXRvdWNoZWQgdGhlIHN1YmplY3QgYW5kIGNoYW5nZWxvZy4NCg0KIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIHwgNSArKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
b2JpdmVpbC5jDQppbmRleCBhMGRkMzM3YzYyMTQuLjhmZjg3MzAyM2I1ZiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQorKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KQEAgLTYzMCw4ICs2MzAsOSBAQCBzdGF0aWMg
aW50IG1vYml2ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiANCiAJ
CS8qIGNvbmZpZ3VyZSBvdXRib3VuZCB0cmFuc2xhdGlvbiB3aW5kb3cgKi8NCiAJCXByb2dyYW1f
b2Jfd2luZG93cyhwY2llLCBwY2llLT5vYl93aW5zX2NvbmZpZ3VyZWQsDQotCQkJCSAgIHdpbi0+
cmVzLT5zdGFydCwgMCwgdHlwZSwNCi0JCQkJICAgcmVzb3VyY2Vfc2l6ZSh3aW4tPnJlcykpOw0K
KwkJCQkgICB3aW4tPnJlcy0+c3RhcnQsDQorCQkJCSAgIHdpbi0+cmVzLT5zdGFydCAtIHdpbi0+
b2Zmc2V0LA0KKwkJCQkgICB0eXBlLCByZXNvdXJjZV9zaXplKHdpbi0+cmVzKSk7DQogCX0NCiAN
CiAJLyogc2V0dXAgTVNJIGhhcmR3YXJlIHJlZ2lzdGVycyAqLw0KLS0gDQoyLjE3LjENCg0K
