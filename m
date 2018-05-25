Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44065 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967587AbeEYTLQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 May 2018 15:11:16 -0400
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "Busch, Keith" <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Bauer, Scott" <scott.bauer@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI/VMD: White list for fast interrupt handlers
Date: Fri, 25 May 2018 19:11:14 +0000
Message-ID: <1527275472.24363.8.camel@intel.com>
References: <20180508160022.30954-1-keith.busch@intel.com>
         <20180509043828.GA9413@infradead.org>
         <20180509152652.GA823@localhost.localdomain>
         <1526053159.7581.15.camel@intel.com>
In-Reply-To: <1526053159.7581.15.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

K0xvcmVuem8NCg0KT24gRnJpLCAyMDE4LTA1LTExIGF0IDA5OjM5IC0wNjAwLCBKb25hdGhhbiBE
ZXJyaWNrIHdyb3RlOg0KPiBPbiBXZWQsIDIwMTgtMDUtMDkgYXQgMDk6MjYgLTA2MDAsIEtlaXRo
IEJ1c2NoIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTWF5IDA4LCAyMDE4IGF0IDA5OjM4OjI4UE0gLTA3
MDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBNYXkgMDgsIDIwMTgg
YXQgMTA6MDA6MjJBTSAtMDYwMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+ID4gPiA+IERldmljZXMg
d2l0aCBzbG93IGludGVycnVwdCBoYW5kbGVycyBhcmUgc2lnbmlmaWNhbnRseSBoYXJtaW5nDQo+
ID4gPiA+IHBlcmZvcm1hbmNlDQo+ID4gPiA+IHdoZW4gdGhlaXIgaW50ZXJydXB0IHZlY3RvciBp
cyBzaGFyZWQgd2l0aCBhIGZhc3QgZGV2aWNlLiBUaGlzDQo+ID4gPiA+IHBhdGNoDQo+ID4gPiA+
IGNyZWF0ZXMgYSBjbGFzcyBjb2RlIHdoaXRlIGxpc3QgZm9yIGRldmljZXMgd2l0aCBrbm93biBm
YXN0DQo+ID4gPiA+IGludGVycnVwdA0KPiA+ID4gPiBoYW5kbGVycywgYW5kIGFsbCBvdGhlciBk
ZXZpY2VzIHdpbGwgc2hhcmUgYSBzaW5nbGUgdmVjdG9yIHNvDQo+ID4gPiA+IHRoZXkgZG9uJ3QN
Cj4gPiA+ID4gaW50ZXJmZXJlIHdpdGggcGVyZm9ybWFuY2UuDQo+ID4gPiA+IA0KPiA+ID4gPiBB
dCB0aGUgbW9tZW50LCBvbmx5IHRoZSBOVk0gRXhwcmVzcyBjbGFzcyBjb2RlIGlzIG9uIHRoZSBs
aXN0LA0KPiA+ID4gPiBidXQgbW9yZQ0KPiA+ID4gPiBtYXkgYmUgYWRkZWQgaWYgVk1EIHVzZXJz
IGRlc2lyZSB0byB1c2Ugb3RoZXIgbG93LWxhdGVuY3kNCj4gPiA+ID4gZGV2aWNlcw0KPiA+ID4g
PiBpbg0KPiA+ID4gPiB0aGVzZSBkb21haW5zLg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoaXMg
aXMgZmFyIHRvbyBtdWNoIG9mIGEgaGFjay4gICBKdXN0IGRvbid0IHVzZSBWTUQgaWYNCj4gPiA+
IHlvdXINCj4gPiA+IGNhcmUgYWJvdXQgcGVyZm9ybWFuY2UuDQo+ID4gDQo+ID4gSSdtIG5vdCBh
d2FyZSBvZiBhbiBlYXNpZXIgd2F5IHlvdSBjYW4gZGlyZWN0LWFzc2lnbiBhbiBlbnRpcmUgUENJ
ZQ0KPiA+IGRvbWFpbg0KPiA+IHRvIGEgdmlydHVhbCBtYWNoaW5lLiA6KQ0KPiANCj4gSXQncyBm
aW5lIHdpdGggbWUNCj4gDQo+IEFja2VkLWJ5OiBKb24gRGVycmljazogPGpvbmF0aGFuLmRlcnJp
Y2tAaW50ZWwuY29tPg0KDQoNCldlJ3ZlIHNlZW4gdGhpcyBhY3R1YWxseSBmaXggYW4gaXNzdWUg
d2l0aCBvbmUgdmVuZG9yJ3MgbXVsdGktZnVuY3Rpb24NCnN3aXRjaC4NCkknZCBsaWtlIHRvIHNl
ZSBpdCBnZXQgaW50byA0LjE4IGlmIHBvc3NpYmxl
