Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FC7C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A710D20879
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="SPgeXXTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfCYJtL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:49:11 -0400
Received: from mail-eopbgr1400102.outbound.protection.outlook.com ([40.107.140.102]:35808
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730354AbfCYJtK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 05:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfUY04AI+woW4NsBnMWblUY8FEeqd5UBrK6Yf7OgP50=;
 b=SPgeXXTy2kMJIRHkq2KHZrIhjdXDJxQG+sVXObQCOmy8uqRPr2/4m8XHy0ktiotkkKiJCWi9y4igY30c/f8lRwEJIktz1D1CovKV0CT0U62CIuO0eOcRikecRTRAyYwSZQdItI3GnsD9DxWmuHe9mrLdQQu/lE4dqZXVyzEYTKU=
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com (20.178.139.140) by
 TYAPR01MB4365.jpnprd01.prod.outlook.com (20.179.173.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 09:49:06 +0000
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::84e1:f4b4:f625:8b97]) by TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::84e1:f4b4:f625:8b97%3]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 09:49:06 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: rcar-gen2: Ensure the mandatory clock is enabled
Thread-Topic: [PATCH] PCI: rcar-gen2: Ensure the mandatory clock is enabled
Thread-Index: AQHU4MnyGFbJe9nykkKn5BziIXD9taYYBVMAgAQR9FA=
Date:   Mon, 25 Mar 2019 09:49:06 +0000
Message-ID: <TYAPR01MB40151FEB45D1774008DABD04DF5E0@TYAPR01MB4015.jpnprd01.prod.outlook.com>
References: <1553271070-7509-1-git-send-email-gareth.williams.jx@renesas.com>
 <CAMuHMdWoCdYYwVu6UsUxE2KNK3Qr52d7=0BemdOCvRNDy41FnA@mail.gmail.com>
In-Reply-To: <CAMuHMdWoCdYYwVu6UsUxE2KNK3Qr52d7=0BemdOCvRNDy41FnA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68e1e103-ff58-42ff-d36e-08d6b1071efb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB4365;
x-ms-traffictypediagnostic: TYAPR01MB4365:
x-microsoft-antispam-prvs: <TYAPR01MB43658427C4738C4488FC3FC9DF5E0@TYAPR01MB4365.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(478600001)(105586002)(106356001)(8676002)(14454004)(8936002)(81166006)(81156014)(54906003)(33656002)(6506007)(110136005)(53546011)(256004)(102836004)(316002)(476003)(7696005)(66066001)(486006)(76176011)(6636002)(9686003)(55016002)(26005)(52536014)(305945005)(3846002)(6246003)(6116002)(11346002)(5660300002)(2906002)(446003)(99286004)(97736004)(186003)(68736007)(71190400001)(71200400001)(6436002)(4326008)(74316002)(86362001)(7736002)(229853002)(53936002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4365;H:TYAPR01MB4015.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GC8/05PQVa1/+0BK8/0u/25/3zbcRxMhjjbbhLDfvgaM93iSFy617qCmTsjwLBWbt7pCcH3S7vcbR9lvkVZdhHIJyuG7ydaT7KNp5YfpmRoD2vcnhJkeKpL+GBwUj1uG+GCdEQ1vD+l8hAkfhS9k5j6OqQJELSwEtTsvx+r+9jjgcToHG/dAOR/hCAaPs6OGBZ4vTN1EAKzxk53Ig+hCBAzxMm7D5sqGL+cl9NFSo3dknvfEC4MVgS+4Yp4ehHvFX0Z9F6PaVS8wwDvAka+VXxC4qVKCkNYaRkMDjp0p1yXJFBC1KW1YBRcS+ZvQcDGQR7tIJdQf/EM3lzKvgUdOHHjYcpMy70hHknxfedZ5i7W/3IWdGzF4HumcgDbt8vYaeDnRnKwxAxhAbeOY3BC15ubr0AHeMAnAI+wBa6Zv7/Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e1e103-ff58-42ff-d36e-08d6b1071efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 09:49:06.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4365
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgR2VlcnQsDQoNCkkgd2lsbCB0YWtlIGEgbG9vayBpbnRvIGhvdyBJIGNhbiBkbyB0aGlzLiBU
aGFua3MgZm9yIHRha2luZyB0aGUgdGltZSB0byBnaXZlDQpzb21lIGJhY2tncm91bmQgYW5kIHBv
aW50ZXJzLg0KDQpLaW5kIFJlZ2FyZHMsDQoNCkdhcmV0aA0KDQpPbiBGcmksIE1hciAyMiwgMjAx
OSBhdCAxOToxNCBQTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3
cm90ZTogDQo+IEhpIEdhcmV0aCwgUGhpbCwNCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCEN
Cj4gDQo+IE9uIEZyaSwgTWFyIDIyLCAyMDE5IGF0IDU6MTEgUE0gR2FyZXRoIFdpbGxpYW1zDQo+
IDxnYXJldGgud2lsbGlhbXMuanhAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IEZyb206IFBoaWwg
RWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlAcmVuZXNhcy5jb20+DQo+ID4NCj4gPiBBbGwgU29DIGRl
dmljZXMgdGhhdCB1c2UgdGhpcyBkcml2ZXIgaGF2ZSBhIG1vZHVsZSBzdG9wIGNsb2NrDQo+ID4g
YXNzb2NpYXRlZCB3aXRoIGl0IHRoYXQgd2UgbXVzdCBlbnN1cmUgaXMgZW5hYmxlZC4gQWxsIFNv
Q3MgZW5hYmxlZA0KPiA+IHRoaXMgY2xvY2sgYnkgZGVmYXVsdCwgc28gSSBndWVzcyBubyBvbmUg
bm90aWNlZCB0aGF0IHRoZSBkcml2ZXIgZGlkbid0IGVuYWJsZQ0KPiBpdC4NCj4gDQo+IFRoaXMg
aXMgbm90IHJlYWxseSBjb3JyZWN0OiB0aGUgbW9kdWxlIGNsb2NrIGhhcyBhbHdheXMgYmVlbiBj
b250cm9sbGVkDQo+IHRocm91Z2ggdGhlIGNsb2NrIGRvbWFpbiB0aGUgZGV2aWNlIGlzIHBhcnQg
b2YsIGVpdGhlciB0aHJvdWdoIHRoZSAicG93ZXItDQo+IGRvbWFpbnMiIHByb3BlcnR5IGluIERU
LCBvciB0aHJvdWdoIHRoZSBsZWdhY3kgY2xvY2sgZG9tYWluIGJlZm9yZSB0aGF0LA0KPiBjb21i
aW5lZCB3aXRoIFJ1bnRpbWUgUE0gKHNlZSBhbHNvIGNvbW1pdCBmYjE3OGQ4YjJmYWIzZjJhDQo+
ICgiUENJOiByY2FyOiBBZGQgcnVudGltZSBQTSBzdXBwb3J0IikpLg0KPiANCj4gRnVydGhlcm1v
cmUgYWRkaW5nIGV4cGxpY2l0IGNsb2NrIG1hbmFnZW1lbnQgKHdpdGggYSBtYW5kYXRvcnkgY2xv
Y2spDQo+IG1ha2VzIGl0IGhhcmRlciB0byB1c2UgdGhlIGRldmljZSB3aXRoIHZpcnR1YWxpemF0
aW9uIGFuZCBWRklPLCBhbmQgdG8gcmV1c2UNCj4gdGhlIGRyaXZlciBvbiBvdGhlciBTb0NzIHdo
ZXJlIG5vIG1vZHVsZSBjbG9jayBtYXkgYmUgcHJlc2VudC4NCj4gVXNpbmcgUnVudGltZSBQTSBh
bGxvd3MgdG8gYWJzdHJhY3QgdGhlIHByZXNlbmNlIG9mIHRoZSBtb2R1bGUgY2xvY2ssIG9yDQo+
IHdoYXRldmVyIHBvd2VyIHNhdmluZyBmZWF0dXJlIHRoYXQgbWF5IGJlIHByZXNlbnQgKGUuZy4g
YSBwb3dlciBhcmVhKSwNCj4gd2hpY2ggaXMgYW4gaW50ZWdyYXRpb24gZmVhdHVyZSwgYW5kIG5v
dCBhIGZlYXR1cmUgb2YgdGhlIGFjdHVhbCBkZXZpY2UuDQo+IA0KPiBTbyBJIGRvbid0IHRoaW5r
IHRoaXMgY2hhbmdlIGlzIG5lZWRlZCBvciB3YW50ZWQuDQo+IA0KPiBOQUtlZC1ieTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gDQo+ID4gTm90ZTogVGhp
cyBjaGFuZ2Ugd2FzIHRlc3RlZCBvbiBSWk4xIGFuZCBSLUNhciBNMiBoYXJkd2FyZS4gTlVMTCBp
cw0KPiA+IHBhc3NlZCB0byBkZXZtX2Nsa19nZXQgZm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5
IHJlYXNvbnMgd2l0aCBSLUNhcg0KPiA+IGdlbjIgZGV2aWNlcyB3aGljaCBkbyBub3QgbmFtZSB0
aGUgY2xvY2suDQo+ID4NCj4gPiBEVFMgZmlsZXMgZm9yIFJlbmVzYXMgZGV2aWNlcyB0aGF0IHVz
ZSB0aGlzIGRyaXZlciBoYXZlIGJlZW4gY2hlY2tlZA0KPiA+IHRvIGVuc3VyZSB0aGV5IHNwZWNp
ZnkgYSBjbG9jayBhbmQgZG8gbm90IG5hbWUgdGhhdCBjbG9jay4NCj4gDQo+IEkgdW5kZXJzdGFu
ZCBSWi9OMSBoYXMgdGhlIHNhbWUgUENJIGNvbnRyb2xsZXIsIGFuZCB5b3UncmUgdHJ5aW5nIHRv
IGFkZA0KPiBzdXBwb3J0IGZvciBpdD8gIEkgdGhpbmsgdGhlIHNvbHV0aW9uIHRoZXJlIGlzIHRv
IGFkZCBjbG9jayBkb21haW4gc3VwcG9ydCB0bw0KPiBkcml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA2
ZzAzMi1jbG9ja3MuYy4NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBU
aGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsu
b3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4N
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
