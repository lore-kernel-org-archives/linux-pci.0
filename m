Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0145.outbound.protection.outlook.com ([157.56.111.145]:59904
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751134AbaIYCCO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 22:02:14 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: RE: [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
Date: Thu, 25 Sep 2014 02:02:11 +0000
Message-ID: <e5a6b27166044f288a0b8482daa9d94a@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-2-git-send-email-r65037@freescale.com>
	<CAOMZO5BuPcw9bJSdLMJ2D=a6EMFMPtKeY352N9-x8dwmRnnfWw@mail.gmail.com>
	<f72dd09d379d4c1b89cc27612afcea77@BY1PR0301MB0855.namprd03.prod.outlook.com>
	<CAOMZO5CKZce3AZfm79DVGShx7bY6DJ3YvSC7q9MYx5v+Zwve5g@mail.gmail.com>
	<366bf7b53b044fdd94f12ed21f505841@DM2PR0301MB0862.namprd03.prod.outlook.com>
 <CAOMZO5DC55n_2=5qCeGa-cdkRRnc1z9F+hau=jgTkP_66gn=qA@mail.gmail.com>
In-Reply-To: <CAOMZO5DC55n_2=5qCeGa-cdkRRnc1z9F+hau=jgTkP_66gn=qA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgRmFiaW86DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZh
YmlvIEVzdGV2YW0gW21haWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5
LCBTZXB0ZW1iZXIgMjUsIDIwMTQgOTo0MCBBTQ0KPiBUbzogWmh1IFJpY2hhcmQtUjY1MDM3DQo+
IENjOiBsaW51eC1wY2ktb3duZXJAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBHdW8gU2hhd24tDQo+IFI2NTA3MzsgTHVjYXMgU3RhY2g7IFRpbSBIYXJ2ZXkNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzVdIFBDSTogaW14NjogZW5hYmxlIHBjaWUgb24gaW14
NnFkbCBzYWJyZWF1dG8NCj4gDQo+IE9uIFdlZCwgU2VwIDI0LCAyMDE0IGF0IDEwOjIxIFBNLCBI
b25nLVhpbmcuWmh1QGZyZWVzY2FsZS5jb20gPEhvbmctDQo+IFhpbmcuWmh1QGZyZWVzY2FsZS5j
b20+IHdyb3RlOg0KPiA+IFtSaWNoYXJkXSBZZXMgaXQgaXMuIE9uIEFSRCBib2FyZCwgdGhlIFBD
SUVfUlNUX0IgaXMgY29ubmVjdGVkIHRvDQo+IENQVV9QRVJfUlNUX0IuDQo+ID4gQnV0IHRoaXMg
aXMgbm90IG9uZSBzaWduYWwgdGhhdCBjYW4gYmUgY29udHJvbGxlZCBieSBQQ0lFIG1vZHVsZSBp
dHNlbGYuDQo+IA0KPiBMZXQncyB0YWtlIGlteDZxZGwtc2FicmVzZC5kdHNpIGZvciBleGFtcGxl
Og0KPiANCj4gJnBjaWUgew0KPiAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gICAg
IHBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llPjsNCj4gICAgIHJlc2V0LWdwaW8gPSA8JmdwaW83
IDEyIDA+Ow0KPiAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiB9Ow0KPiANCj4gSXQgdXNlcyBHUElP
N18xMiBmb3IgUENJIHJlc2V0Lg0KPiANCj4gRm9yIHNhYnJlYXV0byB3ZSBqdXN0IG5lZWQgdG8g
Y2hhbmdlIHRvIHNvbWV0aGluZyBsaWtlIHRoaXMgZm9ybWF0Og0KPiANCj4gcmVzZXQtZ3BpbyA9
IDwmbWF4NzMxMF9iIDIgMD47DQo+IA0KPiA+IEl0IGlzIGtpY2tlZCBvbmNlIGF0IHRoZSBtb21l
bnQgd2hlbiB0aGUgYm9hcmQgaXMgcG93ZXJlZCB1cC4NCj4gDQo+IFllcywgdGhlIHNpZ25hbCBp
cyBjb25uZWN0ZWQgdG8gcG93ZXItb24gYW5kIGl0IGNhbiBhbHNvIGJlIGluZGVwZW5kZW50bHkN
Cj4gY29udHJvbGxlZCB2aWEgTUFYNzMxMC4NCj4gDQo+IEFueXdheSwgbm8gbmVlZCB0byBjaGFu
Z2UgdGhpcyBpZiB5b3UgZG9uJ3Qgd2FudC4gSSBjYW4gc2VuZCBhIHBhdGNoIGFkZGluZw0KPiB0
aGUgcmVzZXQgbGF0ZXIgOi0pDQoNCltSaWNoYXJkXSBPbmUgbW9yZSBkZXBlbmRlbmN5LCB0aGlz
IHNpZ25hbCB3b3VsZCBiZSBzaGFyZS11c2VkIGJ5IG11bHRpLW1vZHVsZXMuDQpJJ20gYWZyYWlk
IHRoZSBvcGVyYXRpb25zIG9mIHRoZSBwY2llLXJlc2V0LWIgd291bGQgYnJpbmcgdW4tZXhjZXB0
aW9uYWwgdG8gb3RoZXIgbW9kdWxlcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
