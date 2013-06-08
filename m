Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
To: Matt Fleming <matt@console-pimps.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"Fleming, Matt" <matt.fleming@intel.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	"Seth Forshee" <seth.forshee@canonical.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/PCI: setup data may be in highmem
Date: Sat, 8 Jun 2013 11:14:08 +0000
Message-ID: <1370690248.2938.65.camel@sauron.fi.intel.com>
References: <1369215782-32697-1-git-send-email-matt@console-pimps.org>
	 <1370690146.2938.64.camel@sauron.fi.intel.com>
In-Reply-To: <1370690146.2938.64.camel@sauron.fi.intel.com>
Reply-To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gU2F0LCAyMDEzLTA2LTA4IGF0IDE0OjE1ICswMzAwLCBBcnRlbSBCaXR5dXRza2l5IHdyb3Rl
Og0KPiBPbiBXZWQsIDIwMTMtMDUtMjIgYXQgMTA6NDMgKzAxMDAsIE1hdHQgRmxlbWluZyB3cm90
ZToNCj4gPiBGcm9tOiBNYXR0IEZsZW1pbmcgPG1hdHQuZmxlbWluZ0BpbnRlbC5jb20+DQo+ID4g
DQo+ID4gcGNpYmlvc19hZGRfZGV2aWNlKCkgYXNzdW1lcyB0aGF0IHRoZSBwaHlzaWNhbCBhZGRy
ZXNzZXMgc3RvcmVkIGluDQo+ID4gc2V0dXBfZGF0YSBhcmUgYWNjZXNzaWJsZSB2aWEgdGhlIGRp
cmVjdCBrZXJuZWwgbWFwcGluZywgYW5kIHRoYXQNCj4gPiBjYWxsaW5nIHBoeXNfdG9fdmlydCgp
IGlzIHZhbGlkLiBUaGlzIGlzbid0IGd1YXJhbnRlZWQgdG8gYmUgdHJ1ZSBvbiB4ODYNCj4gPiB3
aGVyZSB0aGUgZGlyZWN0IG1hcHBpbmcgcmFuZ2UgaXMgbXVjaCBzbWFsbGVyIHRoYW4gb24geDg2
LTY0Lg0KPiA+IA0KPiA+IENhbGxpbmcgcGh5c190b192aXJ0KCkgb24gYSBoaWdobWVtIGFkZHJl
c3MgcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nLA0KPiANCj4gRml4ZXMgcGFnaW5nIHJlcXVlc3Qg
b29wcyBmb3IgbWUgYXMgd2VsbCwgdGhhbmtzISBXb3VsZCB5b3UgcGxlYXNlIGFkZCBhDQo+IC1z
dGFibGUgdGFnIHRvIHRoaXMgcGF0Y2g/DQoNCk9oLCBwYXJkb24sIHlvdSBkaWQgQ0MgLXN0YWJs
ZS4NCg0KLS0gDQpCZXN0IFJlZ2FyZHMsDQpBcnRlbSBCaXR5dXRza2l5DQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
SW50ZWwgRmlubGFuZCBPeQpSZWdpc3RlcmVkIEFkZHJlc3M6IFBMIDI4MSwgMDAxODEgSGVsc2lu
a2kgCkJ1c2luZXNzIElkZW50aXR5IENvZGU6IDAzNTc2MDYgLSA0IApEb21pY2lsZWQgaW4gSGVs
c2lua2kgCgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWluIGNvbmZp
ZGVudGlhbCBtYXRlcmlhbCBmb3IKdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykuIEFueSByZXZpZXcgb3IgZGlzdHJpYnV0aW9uCmJ5IG90aGVycyBpcyBzdHJpY3RseSBw
cm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQKcmVjaXBpZW50LCBwbGVhc2Ug
Y29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllcy4K

