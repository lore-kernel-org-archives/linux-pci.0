Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:24943 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751487AbcADOSR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2016 09:18:17 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: RE: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling
 in pcie-rcar
Date: Mon, 4 Jan 2016 14:18:12 +0000
Message-ID: <HK2PR0601MB1393CE3EA6A72D0F74498251F5F20@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
	<1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
	<20151217133058.GA20372@katana>
	<PS1PR06MB1180304088ECF5384C497E40F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151218140412.GA4595@katana>
	<KL1PR06MB1174165C6112327548CD29DDF5E40@KL1PR06MB1174.apcprd06.prod.outlook.com>
 <CAMuHMdUKHO50n_OAhx-OcZX9FwN+dUbZCHnjP4HaPqgt3j=MzQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUKHO50n_OAhx-OcZX9FwN+dUbZCHnjP4HaPqgt3j=MzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgR2VlcnQsDQoNCk9uIDIxIERlY2VtYmVyIDIwMTUgMTM6MTcsIEdlZXJ0IFV5dHRlcmhvZXZl
biB3cm90ZToNCj4gT24gTW9uLCBEZWMgMjEsIDIwMTUgYXQgMTE6NTIgQU0sIFBoaWwgRWR3b3J0
aHkNCj4gPHBoaWwuZWR3b3J0aHlAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IE9uIDE4IERlY2Vt
YmVyIDIwMTUgMTQ6MDQsIFdvbGZyYW0gU2FuZyB3cm90ZToNCj4gPj4gPiBTaW5jZSB0aGUgaGFy
ZHdhcmUgZG9lc24ndCBzdXBwb3J0IGhvdCBwbHVnLCBJIGJlbGlldmUgdGhpcyBsb29wIHdpbGwN
Cj4gPj4gPiBhbHdheXMgZXhpdCB2ZXJ5IHF1aWNrbHkuIFVubGVzcyBzb21lb25lIGhhcyB0YWtl
biBhIGhhbW1lciB0byB0aGUgSFcNCj4gPj4gPiBvZiBjb3Vyc2UuDQo+ID4+DQo+ID4+IEkga25v
dyB3aGF0IHlvdSBtZWFuLiBCdXQgc2luY2UgcmVhZGxfcG9sbF90aW1lb3V0KCkgbWFrZXMgaXQg
ZWFzeSwgd2UNCj4gPj4gc2hvdWxkIGJldHRlciBiZSBzYWZlIHRoYW4gc29ycnkuDQo+ID4gSG1t
LCBJIGNoYW5nZWQgdGhlIGNvZGUsIGJ1dCBub3cgaXQgZG9lc24ndCBjb21lIG91dCBvZiBzdXNw
ZW5kIHVubGVzcw0KPiA+IHNsZWVwX3VzIHBhc3NlZCB0byByZWFkbF9wb2xsX3RpbWVvdXQgaXMg
MC4gQW55IHJlYXNvbiB5b3UgY2FuIHRoaW5rIG9mPw0KPiANCj4gVGltZXJzIG9yIGludGVycnVw
dHMgZGlzYWJsZWQ/DQo+IA0KPiBEb2VzIHRoZSBtaWdodF9zbGVlcF9pZigpIHNjcmVhbSBpZiBD
T05GSUdfREVCVUdfQVRPTUlDX1NMRUVQPXk/DQpZZXMsIGl0IGRvZXMgaW5kZWVkIHNjcmVhbS4g
V291bGQgeW91IHJlY29tbWVuZCB0byBzdGlsbCB1c2UgcmVhZGxfcG9sbF90aW1lb3V0DQp3aXRo
IHNsZWVwX3VzIHNldCB0byAwPw0KDQpUaGFua3MNClBoaWwNCg==
