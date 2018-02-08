Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Moore, Robert" <robert.moore@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Box, David E" <david.e.box@intel.com>
CC: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH v2 0/5] ACPI: Do not call _STA on battery devices with
 unmet dependencies
Date: Thu, 8 Feb 2018 17:34:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B7570FA0@ORSMSX110.amr.corp.intel.com>
References: <20180122085135.16732-1-hdegoede@redhat.com>
 <3281375.11fh90aaLK@aspire.rjw.lan>
 <7efce3e1-4cb7-fa68-9024-73fa124b9171@redhat.com>
In-Reply-To: <7efce3e1-4cb7-fa68-9024-73fa124b9171@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gPiBUaGUgbGFzdCBvbmUgbmVlZHMgdG8gZ28gaW4gdmlhIEFDUElDQSBhbnl3YXkgb3Ig
d2UnbGwgbmVlZCB0byBjYXJyeSBhDQo+ID4gTGludXgtc3BlY2lmaWMgcmVwbGFjZW1lbnQgZm9y
IGFjcGlfZ2V0X29iamVjdF9pbmZvKCkuDQo+IA0KPiBBY2ssIEknbSBkaXNjdXNzaW5nIGhvdyB0
byBwcm9jZWVkIHdpdGggdGhpcyB3aXRoIHRoZSBBQ1BJQ0EgcGVvcGxlLg0KPiANCj4gUmVnYXJk
cywNCj4gDQo+IEhhbnMNCg0KDQpJIG5vcm1hbGx5IGRvbid0IGxpa2UgdG8gY2hhbmdlIGV4dGVy
bmFsIGludGVyZmFjZXMgKHRoZSBiaWdnZXN0IHJlYXNvbiBiZWluZyB0aGUgc2hlZXIgbnVtYmVy
IG9mIGRpZmZlcmVudCBPUyB2ZW5kb3JzIHRoYXQgdXNlIEFDUElDQSksIGJ1dCBpbiB0aGlzIGNh
c2UsIEkgZmVlbCBpdCBtYXkgYmUgT0suIFRoaXMgaW50ZXJmYWNlIGlzIHByb2JhYmx5IG5vdCBo
ZWF2aWx5IHVzZWQsIGFuZCB0aGVyZSBpcyBwcmVjZWRlbnQgZm9yIHRoaXMgd2hlbiB0aGUgaW52
b2NhdGlvbiBvZiBfU1VCIHdhcyByZW1vdmVkLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgSSB0aGlu
ayBJIHNhdyBpdCBtZW50aW9uZWQgdGhhdCBMaW51eCBjYWxscyB0aGlzIGludGVyZmFjZSBvbmx5
IG9uY2UsIGlzIHRoaXMgY29ycmVjdD8gSWYgc28sIHBlcmhhcHMgaXQgd291bGQgYmUgZWFzaWVz
dCB0byBzaW1wbHkgcmVtb3ZlIHRoaXMgY2FsbCBhbmQgdXNlIGRpcmVjdCBjb250cm9sIG1ldGhv
ZCBpbnZvY2F0aW9ucyB0byBvYnRhaW4gdGhlIGRlc2lyZWQgZGF0YS4NCg0KSWYgd2UgZ28gYWhl
YWQgYW5kIG1ha2UgdGhpcyBjaGFuZ2UgdG8gQUNQSUNBOiBJIGhhdmUgbm90IHNlZW4gdGhlIHBh
dGNoLCBidXQgcGxlYXNlIG1ha2Ugc3VyZSB0aGF0IGFsbCB2ZXN0aWdlcyBvZiB0aGlzIGFyZSBy
ZW1vdmVkLiBUaGlzIGluY2x1ZGVzIGFsbCBpbnZvY2F0aW9ucyB3aXRoaW4gQUNQSUNBIHRoYXQg
ZXhhbWluZSB0aGUgcmVzdWx0IG9mIHRoZSBfU1RBIGludm9jYXRpb24sIHRoZSBDdXJyZW50U3Rh
dHVzIGZpZWxkIG9mIEFDUElfREVWSUNFX0lORk8sIHRoZSBBQ1BJX1ZBTElEX1NUQSBmbGFnLCBl
dGMuDQoNCkJvYg0KDQo=
