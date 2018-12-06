Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC91C04EB9
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE7320892
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WNLBUYJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE7320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbeLFBZW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:25:22 -0500
Received: from mail-eopbgr10048.outbound.protection.outlook.com ([40.107.1.48]:18432
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727514AbeLFBZW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 20:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRfXGKjFyreAs4o5gAb780jNt0+nnrUV+nIH3/66sCQ=;
 b=WNLBUYJOl2bnYfCUiZdVYSJp61q593E3KbvzJEipxuWIGvLAUjBS32VIUaIWGFdM56whyHF8VU3CZKgwqgopDox3BO9ggTrU3UrH0SyM1I7/zOz4lpRAkXy788tAlDDwKlFiL5fn3jlHwOzREgQsMazeNSbh2pllPKVkLLKu5YU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4871.eurprd04.prod.outlook.com (20.177.33.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 01:25:17 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 01:25:17 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCHv2 2/4] PCI: dwc: fix 4GiB outbound window size truncated
 to zero issue
Thread-Topic: [PATCHv2 2/4] PCI: dwc: fix 4GiB outbound window size truncated
 to zero issue
Thread-Index: AQHUdoHtyqLmhpxOWkOjGGaxpD7Vz6VweqmAgACcG1A=
Date:   Thu, 6 Dec 2018 01:25:17 +0000
Message-ID: <AM6PR04MB57813C419469B58F3C7DC37C84A90@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
 <20181107100854.28389-3-Zhiqiang.Hou@nxp.com>
 <20181205160153.GA18567@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181205160153.GA18567@e107981-ln.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4871;6:xxjus+V3NO9seXAN82HUQaUZSQc8YtWNsKyEyB8x31bkMJxmaheVn+3hT+94fjAwXCB4cgCsVl0oVkHcz0n/wU88hP4RqIkIY7LpfURLA/qNci4s7Zbfiym7ZCKXxtwQO03MHKlDZ7A9xmWzF/grAyYrz+HBlvVaXAnsXW02pHy9kEtaGP0+LXeDEHuhsLuKacqoqZYQgllkBQVvO1EUlRbo5aQ7uTgkOs38suOq46dp9rBk6OKuCB+aT5JeP4fumEjWdm0XvnwWAwTdw2Lx29MiIS1bCa/21ybJCge1rd/ZOAfkeTKnTfmusSdscTCC/HlVlFKmZg5krVo/IG8JUJJJUBIFUYuRQOxye72hpuJsrk2DcTi1hiCF4SWKGoGrA85H1qbfuU2ezMklH+8x1NCJD1CEpNM0R7kixfZhgvf8CGC6GOZYHJiUrVadZI2UIkl3D8c11qZ6g44rSWrN8g==;5:rcytzFs5A1Qh6/dt5jwCYQfm3k6k46bMZmDyYryLpZGc4CyzOh5n8H50pfZu7dYtqUomH1ufVqGD5An4vWy9x76JFcvhd/lPtQ3Z8VSIMWKx7vltBIYcuK1JKSRsVHDknwUGx+J2/zCJtPcXwap8VU+XeE9+YJXVTJkEIqX3Y8k=;7:CphKosTpReenTJnMT/bakLv1e0oRkkz4sI+GE4RyCM1lFf7c1l6vPk/AR33NqYw7GfswVNcnBul+QBR3h5G935vviJk3WTZtae/1cX/d4bkfBoDx9TypvFsySLvUsLAEQmI8t0EQR3RhhQO6nQgdiQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 74ecfb11-074e-4853-e3fb-08d65b19ae4d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4871;
x-ms-traffictypediagnostic: AM6PR04MB4871:
x-microsoft-antispam-prvs: <AM6PR04MB487177E9C9C1121FFE896E9484A90@AM6PR04MB4871.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4871;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4871;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(13464003)(4326008)(6506007)(316002)(39060400002)(54906003)(81156014)(8676002)(305945005)(7736002)(256004)(55016002)(102836004)(81166006)(9686003)(74316002)(8936002)(2906002)(26005)(186003)(6116002)(86362001)(575784001)(5660300001)(97736004)(3846002)(53546011)(53936002)(105586002)(33656002)(14454004)(486006)(6916009)(106356001)(6246003)(476003)(71200400001)(6436002)(71190400001)(25786009)(11346002)(68736007)(446003)(7696005)(66066001)(229853002)(76176011)(99286004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4871;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7a/iMn7gj5P4euFc85IcDocEmBq1Fk/vKIMINMcVOCqmM9l7Z63dEpmrF7ybtxpfmR5h+Pcc9gXIIDaD5T0ygZp2+wr4iNPTUf/7tNMZukoR1KEi1Y3qch3WABvWSwF4a4P1GzW3yCIKaXWxj1rcx3PyGTlctZsKv50+ovDbWE4ev1ZjqH1lGKNvgrLYNG/SEGHfJ1ab9QQ3/IOMTxD53dZ8hlRVQEVpdu/bBjwkHxzOJ2IAShClkiX5dLDs85M110z1kE3ls+CggMMbrmmFe3d2w0PF5v89iEjIlL/Ab0fXMP+Xl+cgwO2tLz5dVlctco+8DynXaDXkdhQAQW4gdnWotSuahh4/pC6HEGY+E1k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ecfb11-074e-4853-e3fb-08d65b19ae4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:25:17.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4871
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIDxsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tPg0KPiBTZW50OiAyMDE4xOoxMtTCNsjVIDA6MDINCj4gVG86IFou
cS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5j
b207IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNv
bTsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1
QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSHYyIDIvNF0gUENJOiBkd2M6IGZpeCA0R2lCIG91dGJvdW5kIHdpbmRvdyBzaXpl
DQo+IHRydW5jYXRlZCB0byB6ZXJvIGlzc3VlDQo+IA0KPiBPbiBXZWQsIE5vdiAwNywgMjAxOCBh
dCAxMDowOToxMEFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlh
bmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgdHlwZSBvZiBt
ZW1fc2l6ZSBpcyAndTMyJywgc28gd2hlbiByZXNvdXJjZV9zaXplKCkgcmV0dXJuDQo+ID4gNEcg
aXQgd2lsbCBiZSB0cnVuY2F0ZWQgdG8gemVyby4gVGhpcyBwYXRjaCBmaXggaXQgYnkgY2hhbmdp
bmcgaXRzDQo+ID4gdHlwZSB0byAndTY0Jy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBa
aGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gQWNrZWQtYnk6IEd1c3Rhdm8gUGlt
ZW50ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+IFYyOg0K
PiA+ICAtIFJld29yZGVkIHRoZSBzdWJqZWN0Lg0KPiA+DQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIHwgNCArKy0tDQo+ID4gZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggfCA0ICsrLS0NCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBJIHdvdWxkIGxpa2Ug
dG8gYWRkIGEgRml4ZXM6IHRhZy4NCj4gDQo+IGlzDQo+IA0KPiBlZGQ0NWUzOTY4MjkgKCJQQ0k6
IGR3YzogZGVzaWdud2FyZTogTW92ZSBfdW5yb2xsIGNvbmZpZ3VyYXRpb25zIHRvIGENCj4gc2Vw
YXJhdGUgZnVuY3Rpb24iKQ0KPiANCj4gdGhlIGNvbW1pdCB5b3UgYXJlIGZpeGluZyA/DQoNClll
cywgd2lsbCBhZGQgdGhlIEZpeGVzLCBhbmQgSSB0aGluayBpdCBmaXhlcyB0aGUgb3JpZ2luYWwg
cGF0Y2g6IDM0MGNiYTYwOTJjMiAoInBjaTogQWRkIFBDSWUgZHJpdmVyIGZvciBTYW1zdW5nIEV4
eW5vcyIpLg0KDQo+IFRoYW5rcywNCj4gTG9yZW56bw0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gaW5kZXggMjE1Mzk1NmEw
YjIwLi43YWM1OTg5YzIzZWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IEBAIC0xMDYsNyArMTA2LDcgQEAgc3RhdGljIHZv
aWQgZHdfcGNpZV93cml0ZWxfb2JfdW5yb2xsKHN0cnVjdA0KPiA+IGR3X3BjaWUgKnBjaSwgdTMy
IGluZGV4LCB1MzIgcmVnLA0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGR3X3BjaWVfcHJvZ19vdXRi
b3VuZF9hdHVfdW5yb2xsKHN0cnVjdCBkd19wY2llICpwY2ksIGludA0KPiBpbmRleCwNCj4gPiAg
CQkJCQkgICAgIGludCB0eXBlLCB1NjQgY3B1X2FkZHIsDQo+ID4gLQkJCQkJICAgICB1NjQgcGNp
X2FkZHIsIHUzMiBzaXplKQ0KPiA+ICsJCQkJCSAgICAgdTY0IHBjaV9hZGRyLCB1NjQgc2l6ZSkN
Cj4gPiAgew0KPiA+ICAJdTMyIHJldHJpZXMsIHZhbDsNCj4gPg0KPiA+IEBAIC0xNDEsNyArMTQx
LDcgQEAgc3RhdGljIHZvaWQNCj4gPiBkd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1X3Vucm9sbChz
dHJ1Y3QgZHdfcGNpZSAqcGNpLCBpbnQgaW5kZXgsICB9DQo+ID4NCj4gPiAgdm9pZCBkd19wY2ll
X3Byb2dfb3V0Ym91bmRfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksIGludCBpbmRleCwgaW50IHR5
cGUsDQo+ID4gLQkJCSAgICAgICB1NjQgY3B1X2FkZHIsIHU2NCBwY2lfYWRkciwgdTMyIHNpemUp
DQo+ID4gKwkJCSAgICAgICB1NjQgY3B1X2FkZHIsIHU2NCBwY2lfYWRkciwgdTY0IHNpemUpDQo+
ID4gIHsNCj4gPiAgCXUzMiByZXRyaWVzLCB2YWw7DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gaW5kZXggOWYxYTVlMzk5
YjcwLi5hNDM4YzM4NzlhYTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IEBAIC0xNTMsNyArMTUzLDcgQEAgc3RydWN0IHBj
aWVfcG9ydCB7DQo+ID4gIAl1MzIJCQlpb19zaXplOw0KPiA+ICAJdTY0CQkJbWVtX2Jhc2U7DQo+
ID4gIAlwaHlzX2FkZHJfdAkJbWVtX2J1c19hZGRyOw0KPiA+IC0JdTMyCQkJbWVtX3NpemU7DQo+
ID4gKwl1NjQJCQltZW1fc2l6ZTsNCj4gPiAgCXN0cnVjdCByZXNvdXJjZQkJKmNmZzsNCj4gPiAg
CXN0cnVjdCByZXNvdXJjZQkJKmlvOw0KPiA+ICAJc3RydWN0IHJlc291cmNlCQkqbWVtOw0KPiA+
IEBAIC0yMzgsNyArMjM4LDcgQEAgaW50IGR3X3BjaWVfbGlua191cChzdHJ1Y3QgZHdfcGNpZSAq
cGNpKTsgIGludA0KPiA+IGR3X3BjaWVfd2FpdF9mb3JfbGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNp
KTsgIHZvaWQNCj4gPiBkd19wY2llX3Byb2dfb3V0Ym91bmRfYXR1KHN0cnVjdCBkd19wY2llICpw
Y2ksIGludCBpbmRleCwNCj4gPiAgCQkJICAgICAgIGludCB0eXBlLCB1NjQgY3B1X2FkZHIsIHU2
NCBwY2lfYWRkciwNCj4gPiAtCQkJICAgICAgIHUzMiBzaXplKTsNCj4gPiArCQkJICAgICAgIHU2
NCBzaXplKTsNCj4gPiAgaW50IGR3X3BjaWVfcHJvZ19pbmJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNp
ZSAqcGNpLCBpbnQgaW5kZXgsIGludCBiYXIsDQo+ID4gIAkJCSAgICAgdTY0IGNwdV9hZGRyLCBl
bnVtIGR3X3BjaWVfYXNfdHlwZSBhc190eXBlKTsgIHZvaWQNCj4gPiBkd19wY2llX2Rpc2FibGVf
YXR1KHN0cnVjdCBkd19wY2llICpwY2ksIGludCBpbmRleCwNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0K
PiA+DQoNClRoYW5rcywNClpoaXFpYW5nDQo=
