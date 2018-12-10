Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4AAC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7848120672
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="PZIDlUIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7848120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeLJSQB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:16:01 -0500
Received: from mail-eopbgr780112.outbound.protection.outlook.com ([40.107.78.112]:52030
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbeLJSQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 13:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEfrAVdSsVOzXFTjp/kWGJT3c6l+WWCoaxVMsYo6YCE=;
 b=PZIDlUImLaDDR+ouZiVED8zCgp7o/fNfSEDMsKzS5h9rv0KZHCX3cHkN02KX2dD4GM+2VNGZUtRta+IX0kB+oYzRS9JYw/xP6/Z1aT+DGzrxkb35aGRbqWfs1E4CS/kqXVdLjq+A1cp0hbZUMF47/HQ6ngt+wXTtRzBjgqnlMCc=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3755.namprd06.prod.outlook.com (10.167.236.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 18:15:53 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%5]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 18:15:53 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@google.com" <helgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqV4UIWAgAAg9wA=
Date:   Mon, 10 Dec 2018 18:15:53 +0000
Message-ID: <1544465752.18519.188.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <20181210161753.GA12563@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181210161753.GA12563@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3755;6:lhfMbF3KmehWIXKm12lTlg1N5WSYBXLexyEF36LZ0y0OQnfipPUAc2BookM8UVgQ4iOX6lcm0+TbZEJIsAPyOcpzuW6Gbi7s5mOU8rqQzozwY8k/wAlz7fO0s4IllQmEDr9fdGpUyhMI5cVtE5mCYzLKLvE1ARjXVr8wVOz7vyJMLbmulVeqYdE4YXF5h8Rper7Nyg8deyWfA+ngMDqGMy2avNWIeapUghaDipBaXtqq8xdDy10sPZby87slmvHrhkDSJP46gDFAeo1Z1XX89sqqx6uAuKi+4ti5r49cl90/047LEs14FrlHS+J/pFJvETtnYDhzeUWHXlqQ0CpraD5nUKftLr4wPVlymSKukP6v6jMqiFhIWD76xr7EEUGQ2aefaHogdItJcwqHlycfexOo1BtYOFmf5sGNFkqO0IahByLmugrXZa2rihYHaqu6IeWbgU9PFVMUgW/nWbyJQw==;5:Tfhcl+cXR8kA/u2D5r00MYAcBjYejd6nXXB9GN1A/XlOXT6R8cy0xx8sJ1eJx8rVNfP6i7wM4swF6oQ+wz58IRukKToNvh57VdGfQ+dPOORJ0CFgR9y+bGmF6pgykCOFdp1NJJveJW8obAr/tdWhzxV/yF97m+ea2a3zHNV8UpY=;7:wyEYaIUzuoq+P09UesVDcTpOMvErI3dULnAEW1h7Oc9OF/pR/tijvZaIJQqNFWgM5vlk41ttuk9Wo0E7I5qkvmVgGf0naK19j2UpOo93NYfyeItnCzda/MsPXFo0ZFUGwEMAHVOUirKyP0P9lL9oXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2a0a4370-1ee8-4f88-9984-08d65ecb85dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3755;
x-ms-traffictypediagnostic: MWHPR0601MB3755:
x-microsoft-antispam-prvs: <MWHPR0601MB375563B6F6E49E1E18684414D3A50@MWHPR0601MB3755.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3755;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3755;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39840400004)(376002)(346002)(189003)(199004)(99286004)(54906003)(6486002)(110136005)(103116003)(2906002)(25786009)(14454004)(6436002)(478600001)(8936002)(81166006)(6116002)(76176011)(66066001)(3846002)(81156014)(8676002)(36756003)(316002)(97736004)(4001150100001)(229853002)(2501003)(6512007)(14444005)(2201001)(39060400002)(6246003)(105586002)(305945005)(106356001)(2616005)(53936002)(7736002)(71190400001)(5660300001)(86362001)(68736007)(71200400001)(446003)(11346002)(486006)(476003)(186003)(102836004)(4326008)(6506007)(26005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3755;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WVR7QGKMhM1KmsbmUW/L0TSKv3pP2UA9ClluBsbXBakLw5p0Xmrsv2p5lx0mjGokLxMEDui+9q64v4MxvF3h5KyB04+cEr5HdPIJJUFWA8AQLn5gEBreHHer564dcID9e3+ZiWTQzziiNeSKuHNcy1R54L41vk8HUr2HfvtguaUUJlJfchRonMQDZiFrC8A9ITuKTov62/jWN8py5ifg/NkAaQjoiB/xpqaSwrW38TEY4teTzC1eCRHt98DNc9TpiCrUDcbel3kP3ktHRQuYdHmI+M2Ck2y3s5srpIguqCp8CxNlNJirdC6EXMp0wgn+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CC13AC95528214E9D966B648260FDF5@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0a4370-1ee8-4f88-9984-08d65ecb85dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 18:15:53.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3755
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTEwIGF0IDE2OjE3ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBOb3YgMTMsIDIwMTggYXQgMTA6NTc6MzFQTSArMDAwMCwgTWFyYyBaeW5n
aWVyIHdyb3RlOg0KPiA+IEl0IHJlY2VudGx5IGNhbWUgdG8gbGlnaHQgdGhhdCB0aGUgRGVzaWdu
d2FyZSBQQ0llIGRyaXZlciBpcyByYXRoZXINCj4gPiBicm9rZW4gaW4gdGhlIHdheSBpdCBoYW5k
bGVzIE1TSVsxXToNCj4gPiANCj4gPiAtIEl0IG1hc2tzIGludGVycnVwdCBieSBkaXNhYmxpbmcg
dGhlbSwgbWVhbmluZyB0aGF0IE1TSXMgZ2VuZXJhdGVkDQo+ID4gICBkdXJpbmcgdGhlIG1hc2tl
ZCB3aW5kb3cgYXJlIHNpbXBseSBsb3N0LiBPb3BzLg0KPiA+IA0KPiA+IC0gQWNraW5nIG9mIHRo
ZSBjdXJyZW50bHkgcGVuZGluZyBNU0kgaXMgZG9uZSBvdXRzaWRlIG9mIHRoZQ0KPiA+IGludGVy
cnVwdA0KPiA+ICAgZmxvdywgZ2V0dGluZyBtb3ZlZCBhcm91bmQgcmFuZG9tbHkgYW5kIHVsdGlt
YXRlbHkgYnJlYWtpbmcgdGhlDQo+ID4gICBkcml2ZXIuIE5vdCBncmVhdC4NCj4gPiANCj4gPiAN
Cj4gSSBoYXZlIGRlY2lkZWQgdG8gcXVldWUgdGhpcyBzZXJpZXMgLSBmaXhlZC11cCBhcyBwZXIg
dGhpcyB0aHJlYWQsDQo+IGF2YWlsYWJsZSBhdDoNCj4gDQo+IGdpdDovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9scGllcmFsaXNpL3BjaS5naXQNCj4gdGVzdC9wY2kt
ZHdjLW1zaQ0KPiANCj4gV2UgYWxsb3dlZCBlbm91Z2ggdGltZSBmb3IgcGVvcGxlIHRvIHRlc3Qg
aXQsIHdlIGNhbid0IGxlYXZlIG1haW5saW5lDQo+IGJyb2tlbiBmb3IgdGhlLCBhcHBhcmVudGx5
IGZldywgcGVvcGxlIHdobyBjYXJlLg0KPiANCj4gSSAqdGhpbmsqIHRoYXQgdGhpcyBpcyB0aGUg
Rml4ZXM6IHRhZyB0byBiZSBhZGRlZCB0byBhbGwgcGF0Y2hlcyBpbg0KPiB0aGlzDQo+IHNlcmll
cywgQEd1c3Rhdm8gcGxlYXNlIGNvdW50ZXJjaGVjazoNCj4gDQo+IDdjNTkyNWFmYmM1OCAoIlBD
STogZHdjOiBNb3ZlIE1TSSBJUlFzIGFsbG9jYXRpb24gdG8gSVJRIGRvbWFpbnMNCj4gaGllcmFy
Y2hpY2FsIEFQSSIpDQoNClRoYXQncyBub3QgdGhlIGNvcnJlY3QgRml4ZXMuICBJdCBzaG91bGQg
YmU6DQoNCjhjOTM0MDk1ZmEyZiAoIlBDSTogZHdjOiBDbGVhciBNU0kgaW50ZXJydXB0IHN0YXR1
cyBhZnRlciBpdCBpcw0KaGFuZGxlZCwgbm90IGJlZm9yZSIpDQoNCkkgaGFkIGNvbmNlcm5zIGFi
b3V0IHdoYXQgYXBwZWFycyB0byBiZSBhbiB1bm5lY2Vzc2FyeSBleHRyYSBsb2NrIHRha2VuDQpi
ZWZvcmUgaGFuZGxpbmcgYW4gaW50ZXJydXB0IGFuZCBlbmFibGluZyBhbGwgTVNJcyBldmVuIGlm
IG5vdGhpbmcgaGFzDQp0cmllZCB0byBlbmFibGUgdGhlbS4=
