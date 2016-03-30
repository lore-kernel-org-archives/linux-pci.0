Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0095.outbound.protection.outlook.com ([104.47.2.95]:42016
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752794AbcC3QKZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Mar 2016 12:10:25 -0400
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "ynezz@true.cz" <ynezz@true.cz>,
	"khalasa@piap.pl" <khalasa@piap.pl>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stefan@agner.ch" <stefan@agner.ch>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
Date: Wed, 30 Mar 2016 14:38:08 +0000
Message-ID: <1459348687.5073.53.camel@toradex.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	 <20160330120644.GM20367@ibawizard.net>
In-Reply-To: <20160330120644.GM20367@ibawizard.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgUGV0cg0KDQpPbiBXZWQsIDIwMTYtMDMtMzAgYXQgMTQ6MDYgKzAyMDAsIFBldHIgxaB0ZXRp
YXIgd3JvdGU6DQo+IEtyenlzenRvZiBIYcWCYXNhIDxraGFsYXNhQHBpYXAucGw+IFsyMDE2LTAz
LTI1IDE0OjMyOjM1XToNCj4gDQo+IEN6ZcWbxIcsDQo+IA0KPiA+IA0KPiA+IEkgd29uZGVyIGlm
IGFsbCBib2FyZHMgKGV4Y2VwdCBtYXliZSB0aGF0IFRvcmFkZXggc2V0KSB1c2UgYW4NCj4gPiBh
Y3RpdmUtbG93DQo+ID4gUENJZSByZXNldCBhbmQgYXJlIG5vdyBicm9rZW4uIFBlcmhhcHMgVG9y
YWRleCB1c2VzIGFjdGl2ZS1oaWdoIGFuZA0KPiA+IHRodXMNCj4gPiB3b3Jrcy4NCj4gSSdtIHJl
YWxseSBwdXp6bGVkIGJ5IHRoaXMgOi0pIFdpdGggeW91ciBwYXRjaCBhcHBsaWVkIEkgZ2V0DQo+
IGZvbGxvd2luZyBvbg0KPiBUb3JhZGV4IEFwYWxpcyBtb2R1bGVzOg0KPiANCj4gwqBEVFM6wqDC
oMKgwqDCoMKgwqDCoMKgcmVzZXQtZ3BpbyA9IDwmZ3BpbzEgMjggR1BJT19BQ1RJVkVfTE9XPjsN
Cj4gwqBkbWVzZzrCoMKgwqDCoMKgwqDCoGlteDZxLXBjaWUgMWZmYzAwMC5wY2llOiBwaHkgbGlu
ayBuZXZlciBjYW1lIHVwDQo+IMKgZ3BpbzrCoMKgwqDCoMKgwqDCoMKgZ3Bpby0yOMKgwqAowqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHxyZXNldMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCkNCj4gb3V0IGhpDQo+IMKgcGluIHZvbHRhZ2U6IDBWDQo+IA0KPiDC
oERUUzrCoMKgwqDCoMKgwqDCoMKgwqByZXNldC1ncGlvID0gPCZncGlvMSAyOCBHUElPX0FDVElW
RV9ISUdIPjsNCj4gwqBkbWVzZzrCoMKgwqDCoMKgwqDCoGF0aDlrIDAwMDA6MDE6MDAuMDogZW5h
YmxpbmcgZGV2aWNlICgwMTQwIC0+IDAxNDIpDQo+IMKgZ3BpbzrCoMKgwqDCoMKgwqDCoMKgZ3Bp
by0yOMKgwqAowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHxyZXNldMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCkNCj4gb3V0IGxvDQo+IMKgcGluIHZvbHRhZ2U6
IDNWMw0KPiANCj4gU28gVG9yYWRleCBBcGFsaXMgaXMgYWN0dWFsbHkgYWN0aXZlLWhpZ2g/DQoN
ClllcywgSSBhY3R1YWxseSBleHBsYWluZWQgdGhpcyBpbiBkZXRhaWwgaW4gbXkgY292ZXIgbGV0
dGVyOg0KDQpodHRwOi8vYXJ0aWNsZS5nbWFuZS5vcmcvZ21hbmUubGludXguZHJpdmVycy5kZXZp
Y2V0cmVlLzE1NDgyOQ0KDQo+ICBUaGFua3MuDQo+IA0KPiAtLSB5bmV6eg0KDQoNCkNoZWVycw0K
DQpNYXJjZWwNCg==
