Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:38352
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751175AbaIYBVR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 21:21:17 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: RE: [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
Date: Thu, 25 Sep 2014 01:21:12 +0000
Message-ID: <366bf7b53b044fdd94f12ed21f505841@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-2-git-send-email-r65037@freescale.com>
	<CAOMZO5BuPcw9bJSdLMJ2D=a6EMFMPtKeY352N9-x8dwmRnnfWw@mail.gmail.com>
	<f72dd09d379d4c1b89cc27612afcea77@BY1PR0301MB0855.namprd03.prod.outlook.com>
 <CAOMZO5CKZce3AZfm79DVGShx7bY6DJ3YvSC7q9MYx5v+Zwve5g@mail.gmail.com>
In-Reply-To: <CAOMZO5CKZce3AZfm79DVGShx7bY6DJ3YvSC7q9MYx5v+Zwve5g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgRmFiaW86DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNl
cHRlbWJlciAyNSwgMjAxNCA1OjA0IEFNDQo+IFRvOiBaaHUgUmljaGFyZC1SNjUwMzcNCj4gQ2M6
IGxpbnV4LXBjaS1vd25lckB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IEd1byBTaGF3bi0NCj4gUjY1MDczOyBMdWNhcyBTdGFjaDsgVGltIEhhcnZleQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDEvNV0gUENJOiBpbXg2OiBlbmFibGUgcGNpZSBvbiBpbXg2cWRs
IHNhYnJlYXV0bw0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IE9uIFR1ZSwgU2VwIDIzLCAyMDE0
IGF0IDExOjU0IFBNLCBIb25nLVhpbmcuWmh1QGZyZWVzY2FsZS5jb20gPEhvbmctDQo+IFhpbmcu
Wmh1QGZyZWVzY2FsZS5jb20+IHdyb3RlOg0KPiANCj4gPiBbUmljaGFyZF0gNnFkbCBzYWJyZWF1
dG8gYm9hcmRzIGRvbid0IGhhdmUgdGhlIHBjaWUgcmVzZXQgZ3BpbyBpbiB0aGUgYm9hcmQNCj4g
ZGVzaWduIGF0IGFsbC4NCj4gDQo+IEkgaGF2ZSBqdXN0IGRvd25sb2FkZWQgdGhlIG14NiBzYWJy
ZWF1dG8gYm9hcmQgc2NoZW1hdGljcyBmcm9tIGZyZWVzY2FsZS5jb20NCj4gYW5kIGl0IG1hdGNo
ZXMgdGhlIG9uZSBJIGhhdmUgc2VlbiBiZWZvcmUuDQo+IA0KPiBZb3UgY2FuIHNlYXJjaCBmb3Ig
dGhlIENQVV9QRVJfUlNUX0Igc2lnbmFsLiBJdCBpcyBjb25uZWN0ZWQgdmlhIFI3ODUNCj4gMCBv
aG0gcmVzaXN0b3IgdG8gUENJRV9SU1RfQi4NCj4gDQo+IENQVV9QRVJfUlNUX0IgY2FuIGJlIGNv
bnRyb2xsZWQgdmlhIE1BWDczMTAgcGluIElPLzIuDQpbUmljaGFyZF0gWWVzIGl0IGlzLiBPbiBB
UkQgYm9hcmQsIHRoZSBQQ0lFX1JTVF9CIGlzIGNvbm5lY3RlZCB0byBDUFVfUEVSX1JTVF9CLg0K
QnV0IHRoaXMgaXMgbm90IG9uZSBzaWduYWwgdGhhdCBjYW4gYmUgY29udHJvbGxlZCBieSBQQ0lF
IG1vZHVsZSBpdHNlbGYuDQpJdCBpcyBraWNrZWQgb25jZSBhdCB0aGUgbW9tZW50IHdoZW4gdGhl
IGJvYXJkIGlzIHBvd2VyZWQgdXAuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg==
