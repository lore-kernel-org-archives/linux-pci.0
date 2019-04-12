Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C14C10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE842186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADEJeibu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDLIfx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:35:53 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:9286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbfDLIfx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62SMIro4NrJzCpVb/rZeIuesF0RKs3K3YOR3QBZPZJ8=;
 b=ADEJeibutO5flHiQi2Q+wyatknTxTHKpv1FqiJ4hC0ps+qliRcHhJZbWnKbArwcDRIccM9UFBbMcl8sB47vmPyyBkgW3yVHzEIu4s0VgyR6Tli4yG3/stze5rKWnohGRLqSC+OBbpnRwN6Y6PduaW8AlPz/RxTQz9KSweLyqmMQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:35:48 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:35:48 +0000
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
Subject: [PATCHv5 06/20] PCI: mobiveil: Replace the resource list iteration
 function
Thread-Topic: [PATCHv5 06/20] PCI: mobiveil: Replace the resource list
 iteration function
Thread-Index: AQHU8Qq600aUhJFkeEuVVnZKUmApJA==
Date:   Fri, 12 Apr 2019 08:35:48 +0000
Message-ID: <20190412083635.33626-7-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 70ad0aa1-19f5-45ed-cda0-08d6bf21dd03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB5846C238C3DD6DCBC177DC2D84280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14444005)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WOJo5iazmza2/CB6h3DQLfFDQgiywM3RyP4XU9+NMJyyWXxwZEVm7oIM1atrZ7ZR/ImdmD9xu2/liEwWP4Gu932/hlNppSJfBY5sBWP3pstxm6eL5N17NzPji1rcCTX1PTti2QUw0VNqMHyBUcNjzsg5Y3LP4S/GvL+ZGzwfZSm2bJoXZZ8OQIsMvpZaaS6T4hiOYyNxjCoV48t8FkwEPIVts/hr7SDjMmn545/J8jfWOribzQiIfeA9br9KPSi1DEDbuxYumrPmiFbNrdxC7Pdq2xd5VqbT6HRmAka+xpSMcoRZ6a+dDo9/6Guu4oMT4uDXaDiRM0GT0apJVC90VjDZ9W2yLX/UwwILAkzeTdRVabdK3hWbokEqJFtH3cRO7nx4+OeVQ5uzXQlfFrIzgmSO34Nnt+i3IJTHq4wdHxg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ad0aa1-19f5-45ed-cda0-08d6bf21dd03
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:35:48.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQXMgaXQgd29uJ3Qg
ZGVsZXRlIGFueSBub2RlIGR1cmluZyB0aGlzIGl0ZXJhdGlvbiwgcmVwbGFjZQ0KdGhlIGZ1bmN0
aW9uIHJlc291cmNlX2xpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpIHdpdGggdGhlDQpyZXNvdXJj
ZV9saXN0X2Zvcl9lYWNoX2VudHJ5KCkuDQoNClNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8
WmhpcWlhbmcuSG91QG54cC5jb20+DQpSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1
YW4uTGlhbkBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1
YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KLS0tDQpWNToNCiAtIENvcnJlY3RlZCBhbmQgcmV0
b3VjaGVkIHRoZSBzdWJqZWN0IGFuZCBjaGFuZ2Vsb2cuDQoNCiBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbW9iaXZlaWwuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbW9iaXZlaWwuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVp
bC5jDQppbmRleCA4ZmY4NzMwMjNiNWYuLmIyY2M5YzA5N2ZjOSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KQEAgLTU2OSw3ICs1NjksNyBAQCBzdGF0aWMgaW50IG1v
Yml2ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiB7DQogCXUzMiB2
YWx1ZSwgcGFiX2N0cmwsIHR5cGU7DQogCWludCBlcnI7DQotCXN0cnVjdCByZXNvdXJjZV9lbnRy
eSAqd2luLCAqdG1wOw0KKwlzdHJ1Y3QgcmVzb3VyY2VfZW50cnkgKndpbjsNCiANCiAJZXJyID0g
bW9iaXZlaWxfYnJpbmd1cF9saW5rKHBjaWUpOw0KIAlpZiAoZXJyKSB7DQpAQCAtNjIwLDcgKzYy
MCw3IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2ll
ICpwY2llKQ0KIAlwcm9ncmFtX2liX3dpbmRvd3MocGNpZSwgV0lOX05VTV8xLCAwLCBNRU1fV0lO
RE9XX1RZUEUsIElCX1dJTl9TSVpFKTsNCiANCiAJLyogR2V0IHRoZSBJL08gYW5kIG1lbW9yeSBy
YW5nZXMgZnJvbSBEVCAqLw0KLQlyZXNvdXJjZV9saXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUod2lu
LCB0bXAsICZwY2llLT5yZXNvdXJjZXMpIHsNCisJcmVzb3VyY2VfbGlzdF9mb3JfZWFjaF9lbnRy
eSh3aW4sICZwY2llLT5yZXNvdXJjZXMpIHsNCiAJCWlmIChyZXNvdXJjZV90eXBlKHdpbi0+cmVz
KSA9PSBJT1JFU09VUkNFX01FTSkNCiAJCQl0eXBlID0gTUVNX1dJTkRPV19UWVBFOw0KIAkJZWxz
ZSBpZiAocmVzb3VyY2VfdHlwZSh3aW4tPnJlcykgPT0gSU9SRVNPVVJDRV9JTykNCi0tIA0KMi4x
Ny4xDQoNCg==
