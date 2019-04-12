Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A47C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EC3218AF
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="phYrcuFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDLIgX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:23 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:4153
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfDLIgW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFKePA9EGNQX3VAyBq+Uvpx6piJIbjzLPSMZe9Gwn8g=;
 b=phYrcuFNXYPbQQI0999k4OZHin+A7PrLsQKZR0vtRnvGKgQFaoeh/08RzU1CJJbA1K6KlbcRFSScSg8lUC5Y9dB7/rR+7CqpE+1/PpO/3f63p8QudxGlkkapa2nh77u6Wd/pefrjDdwC7ZLlLxULFO2/eOA+BmEmbx0rjkTTgPo=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:36:18 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:18 +0000
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
Subject: [PATCHv5 11/20] PCI: mobiveil: Correct the fixup of Class Code field
Thread-Topic: [PATCHv5 11/20] PCI: mobiveil: Correct the fixup of Class Code
 field
Thread-Index: AQHU8QrMNHtvgkIaSEqXEa2wnzy4Kw==
Date:   Fri, 12 Apr 2019 08:36:18 +0000
Message-ID: <20190412083635.33626-12-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: b3d2fa68-d0a6-4c14-0ea4-08d6bf21ee9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB5846C1D9D7C9C9D9A938403C84280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(54534003)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WMBwyaqgSwEOD99sXB0lgCYyUswlAG4nb1vvm0CiX9wuPnckd15k+k0tdYIEUQIJ1ffhDVaIqbRo6Le7f/NkXs/ixEeyg45TGhYu83tKUC8PDCKm3Xw4MaQHWzQ2OYw7D5uAdzGptFUdy7ZyZ2eqZR19K9QgE1jwKuysbxWl9f5g1Erq/pV2Az7pEV6+Y5fOwjttFxOGPPs3bR37pceAyALgPnWK002KFM+G23LzdJ5WMUdUnRCCRCVrXPhn7/UHUZWs3H24cAgYSg7XlOwkIc6hX/t+Vi+LUmNAMGZn+el6TgUmgq6GkdnHlzsqonM7gcYJyp3YLOsGgx0LJCI5104f5UvilCIQtixy8DcVLzmZ5w9Gg83+tCCdZz9JHfAcG/lNAZ26Drmh/RrutEA7DQGjNX6rddE75tozOPqU7Gg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d2fa68-d0a6-4c14-0ea4-08d6bf21ee9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:18.1302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KT25seSBmaXggdXAg
dGhlIENsYXNzIENvZGUgZmllbGQgdG8gUENJIGJyaWRnZSwgZG8gbm90IGNoYW5nZSB0aGUNClJl
dmlzaW9uIElELiBBbmQgdGhpcyBwYXRjaCBhbHNvIG1vdmUgdGhlIENsYXNzIENvZGUgZml4dXAg
dG8NCmZ1bmN0aW9uIG1vYml2ZWlsX2hvc3RfaW5pdCgpLg0KDQpGaXhlczogOWFmNmJjYjExZTEy
ICgiUENJOiBtb2JpdmVpbDogQWRkIE1vYml2ZWlsIFBDSWUgSG9zdCBCcmlkZ2UgSVAgZHJpdmVy
IikNClNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQpS
ZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29tPg0KUmV2aWV3
ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmlu
Pg0KLS0tDQpWNToNCiAtIENvcnJlY3RlZCBhbmQgcmV0b3VjaGVkIHRoZSBzdWJqZWN0IGFuZCBj
aGFuZ2Vsb2cuDQoNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyB8IDkg
KysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5j
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCmluZGV4IDc4ZTU3NWU3
MWY0ZC4uOGVlZTFhYjdlZTI0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLW1vYml2ZWlsLmMNCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVp
bC5jDQpAQCAtNjUzLDYgKzY1MywxMiBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2hvc3RfaW5pdChz
dHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiAJCQkJICAgdHlwZSwgcmVzb3VyY2Vfc2l6ZSh3
aW4tPnJlcykpOw0KIAl9DQogDQorCS8qIGZpeHVwIGZvciBQQ0llIGNsYXNzIHJlZ2lzdGVyICov
DQorCXZhbHVlID0gY3NyX3JlYWRsKHBjaWUsIFBBQl9JTlRQX0FYSV9QSU9fQ0xBU1MpOw0KKwl2
YWx1ZSAmPSAweGZmOw0KKwl2YWx1ZSB8PSAoUENJX0NMQVNTX0JSSURHRV9QQ0kgPDwgMTYpOw0K
Kwljc3Jfd3JpdGVsKHBjaWUsIHZhbHVlLCBQQUJfSU5UUF9BWElfUElPX0NMQVNTKTsNCisNCiAJ
Lyogc2V0dXAgTVNJIGhhcmR3YXJlIHJlZ2lzdGVycyAqLw0KIAltb2JpdmVpbF9wY2llX2VuYWJs
ZV9tc2kocGNpZSk7DQogDQpAQCAtODk2LDkgKzkwMiw2IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxf
cGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJZ290byBlcnJvcjsN
CiAJfQ0KIA0KLQkvKiBmaXh1cCBmb3IgUENJZSBjbGFzcyByZWdpc3RlciAqLw0KLQljc3Jfd3Jp
dGVsKHBjaWUsIDB4MDYwNDAyYWIsIFBBQl9JTlRQX0FYSV9QSU9fQ0xBU1MpOw0KLQ0KIAkvKiBp
bml0aWFsaXplIHRoZSBJUlEgZG9tYWlucyAqLw0KIAlyZXQgPSBtb2JpdmVpbF9wY2llX2luaXRf
aXJxX2RvbWFpbihwY2llKTsNCiAJaWYgKHJldCkgew0KLS0gDQoyLjE3LjENCg0K
