Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:15007
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbeHIOXo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 10:23:44 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "cyrille.pitchen@bootlin.com" <cyrille.pitchen@bootlin.com>,
        Scott Telford <stelford@cadence.com>
Subject: RE: [PATCH 0/5] Add MSI-X support for cadence EP driver
Date: Thu, 9 Aug 2018 11:59:06 +0000
Message-ID: <MWHPR07MB35027FFA5F33ED9D6C8006D5D8250@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1532971260-5269-1-git-send-email-adouglas@cadence.com>
 <20180808163821.GA486@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180808163821.GA486@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gIDA4IEF1Z3VzdCAyMDE4IDE3OjM4LCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gT24g
TW9uLCBKdWwgMzAsIDIwMTggYXQgMDY6MjE6MDBQTSArMDEwMCwgQWxhbiBEb3VnbGFzIHdyb3Rl
Og0KPiA+IFBhdGNoIHNlcmllcyBtYWRlIGFnYWluc3QgQmpvcm4gSGVsZ2FhcydzIHBjaSBuZXh0
IGJyYW5jaC4NCj4gDQo+IEFsd2F5cyByZWJhc2UgcGF0Y2hlcyBvbiBhIGZpeGVkIC1yYyAoaWUg
Qmpvcm4gYW5kIEkgYXJlIHVzaW5nDQo+IHY0LjE4LXJjMSkgYW5kIG1lbnRpb24gdGhlIGRlcGVu
ZGVuY3kgcmF0aGVyIHRoYW4gcmViYXNpbmcgdGhlDQo+IHNlcmllcyBvbiBwY2ktbmV4dCBwbGVh
c2UuDQo+IA0KT0ssIHdpbGwgZG8gdGhhdCBmb3IgdjENCg0KPiA+IEl0IHJlbGllcyBvbiBHdXN0
YXZvIFBpbWVudGVsJ3MgcGF0Y2ggc2VyaWVzIGFkZGluZyBNU0ktWA0KPiA+IHN1cHBvcnQgaW4g
dGhlIFBDSWUgRVAgZHJpdmVyIGZyYW1ld29yaywgYW5kIGltcGxlbWVudHMNCj4gPiBNU0ktWCBz
dXBwb3J0IGZvciB0aGUgY2FkZW5jZSBlbmRwb2ludCBkcml2ZXIuDQo+ID4gIC0gVXNlIEFYSSBy
ZWdpb24gMCBmb3IgaW50ZXJydXB0IHNpZ25hbGxpbmcNCj4gPiAgLSBXcml0ZSBNU0kgYW5kIE1T
SS1YIHdpdGggMzJiaXQgdmFsdWUgcmF0aGVyIHRoYW4gMTZiaXQNCj4gPiAgLSBDaGVjayBmb3Ig
bWFza2luZyBiZWZvcmUgc2VuZGluZyBNU0kgb3IgTVNJLVgNCj4gPiAgLSBDaGVjayBsaW5rIGlz
IHVwIGJlZm9yZSBzZW5kaW5nIElSUQ0KPiANCj4gVGhlc2UgZmlyc3QgZm91ciBhcmUgZml4ZXMg
b3IgY2hhbmdlcyByZXF1aXJlZCBiZWZvcmUgZW5hYmxpbmcNCj4gdGhlIGxhc3QgcGF0Y2ggaW4g
dGhlIHNlcmllcyA/DQo+IA0KPiBSZXdvcmRlZDogZG9lcyB0aGUgY3VycmVudCBkcml2ZXIgd29y
ayB3aXRob3V0IHRoZSBmaXJzdCA0DQo+IHBhdGNoZXMgYXBwbGllZCA/DQo+IA0KPiBJZiB0aGV5
IGFyZSBmaXhlcyBwbGVhc2UgbWFyayB0aGVtIGFzIHN1Y2ggaW4gdGhlIGNvbW1pdCBsb2cuDQo+
IA0KVGhlc2UgYXJlIGZpeGVzLCB3aWxsIG1hcmsgdGhlbSBhcyBzdWNoIGluIHRoZSBsb2csIGFu
ZCB3aWxsDQpzcGxpdCBwYXRjaGVzIHN1Y2ggdGhhdCB0aGV5IGNhbiBiZSBhcHBsaWVkIHdpdGhv
dXQgYWRkaW5nDQpNU0ktWCBzdXBwb3J0Lg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsDQpB
bGFuDQo=
