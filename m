Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14034 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbcALWZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 17:25:15 -0500
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC: "arjan@linux.intel.com" <arjan@linux.intel.com>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"kay.sievers@vrfy.org" <kay.sievers@vrfy.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: [PATCH] don't allow vfio drivers to bind on driver_attach
Date: Tue, 12 Jan 2016 22:25:13 +0000
Message-ID: <1452637513.30228.16.camel@intel.com>
References: <1452634390-17729-1-git-send-email-jacob.e.keller@intel.com>
	 <1452636370.9674.47.camel@redhat.com>
In-Reply-To: <1452636370.9674.47.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gVHVlLCAyMDE2LTAxLTEyIGF0IDE1OjA2IC0wNzAwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6
DQo+IFdlIGFscmVhZHkgaGF2ZSBhIHNvbHV0aW9uIGluIHRoZSBrZXJuZWwgZm9yIHRoaXMsIGl0
J3MgdGhlDQo+IGRyaXZlcl9vdmVycmlkZSBpbnRlcmZhY2UuIMKgUmF0aGVyIHRoYW4geW91ciBh
Ym92ZSBleGFtcGxlIG9mIGFkZGluZw0KPiBhDQo+IG5ldyBJRCB0byB0aGUgZHluYW1pYyBsaXN0
IGZvciB0aGUgZHJpdmVyLCBzdWNoIHRoYXQgaXQgd2lsbA0KPiBhdXRvbWF0aWNhbGx5IHByb2Jl
IHRoZSBkZXZpY2UsIHdlIHJldmVyc2UgdGhlIHByb2Nlc3MgdG8gYWxsb3cgdGhlDQo+IGRldmlj
ZSB0byBtYXRjaCB0aGUgZHJpdmVyLiDCoFRoZSBzZXF1ZW5jZSBiZWNvbWVzOg0KPiANCj4gZWNo
byB2ZmlvLXBjaSA+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzxwY2kgYWRkcmVzcz4vZHJpdmVyX292
ZXJyaWRlDQo+IGVjaG8gPHBjaSBhZGRyZXNzPiA+IC9zeXMvYnVzL3BjaS9kcml2ZXJzLzxvbGQg
ZHJpdmVyPi91bmJpbmQNCj4gZWNobyA8cGNpIGFkZHJlc3M+IC9zeXMvYnVzL3BjaS9kcml2ZXJz
X3Byb2JlDQo+IA0KPiBUaGUgb2xkIGludGVyZmFjZSBpcyBrZXB0IGFyb3VuZCBiZWNhdXNlIHRo
ZXJlIGFyZSBxdWl0ZSBhIGZldyB1c2Vycw0KPiBvZg0KPiBpdCwgc29tZSBvZiB3aGljaCB3b3Vs
ZCBiZSBicm9rZW4gYnkgdGhlIHByb3Bvc2VkwqBtYW51YWxfYmluZF9vbmx5DQo+IGNvZGUNCj4g
Y2hhbmdlLCBpbmNsdWRpbmcgdGhlIGV4YW1wbGUgb2YgdXNpbmcgZHJpdmVyX292ZXJyaWRlIGFi
b3ZlLiDCoFRoaXMNCj4gYWxzbyBhdm9pZHMgZXZlbiB0aGUgbmVlZCBmb3IgcGNpLXN0dWIgKHdo
aWNoIGhhcyB0aGUgc2FtZSBpc3N1ZSksDQo+IHNpbmNlIHdlIGNhbiBzaW1wbHkgcHV0IGEgZHVt
bXkgbmFtZSBpbiBkcml2ZXJfb3ZlcnJpZGUgdG8gYXZvaWQgYQ0KPiBkZXZpY2UgZnJvbSBtYXRj
aGluZyBhbnkgZHJpdmVyLiDCoFRoYW5rcywNCj4gDQo+IEFsZXgNCg0KDQpIbW0sIHRoYXQgbWFr
ZXMgc2Vuc2UuIFNvIHJlYWxseSBJIHNob3VsZCBzZWUgYWJvdXQgZ2V0dGluZyB0aGUgdG9vbHMN
CndoaWNoIGN1cnJlbnRseSB1c2UgdGhlIG9sZCBpbnRlcmZhY2UgdG8gdXNlIGEgbmV3IG9uZT8N
Cg0KKERvbid0IHdlIHN0aWxsIHdhbnQvbmVlZCB2ZmlvLXBjaSBmb3Igb3RoZXIgcmVhc29ucyBi
ZXNpZGVzIGp1c3QgYmVpbmcNCmEgc3R1YiBkcml2ZXI/KQ0KDQpSZWdhcmRzLA0KSmFrZQ==
