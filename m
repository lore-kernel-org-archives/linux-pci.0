Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:17730 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab2LEQRb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 11:17:31 -0500
From: "Ortiz, Lance E" <lance.oritz@hp.com>
To: Borislav Petkov <bp@alien8.de>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@redhat.com" <mchehab@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 3/3] aerdrv: Cleanup log output for CPER based AER
Date: Wed, 5 Dec 2012 16:16:31 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F9516F37AA@G4W3219.americas.hpqcorp.net>
References: <20121204210305.4515.91100.stgit@grignak.americas.hpqcorp.net>
 <20121204210318.4515.10180.stgit@grignak.americas.hpqcorp.net>
 <20121205145035.GE2364@liondog.tnic>
In-Reply-To: <20121205145035.GE2364@liondog.tnic>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiANCj4gSGVyZSBpdCBpcywgeW91J3JlIGluaXRpYWxpemluZyAncHJlZml4JyBoZXJlIGFsdGhv
dWdoIGl0IGlzIGJlaW5nDQo+IHVzZWQgaW4gdGhlIHByZXZpb3VzIHBhdGNoLiBZb3Ugc2hvdWxk
IGNvbmNlbnRyYXRlIHRoZSB3aG9sZSBwcmVmaXgNCj4gaW5pdGlhbGl6YXRpb24gYW5kIHBhc3Np
bmcgaW4gb25lIHBhdGNoIHNvIHRoYXQgdGhlcmUgYXJlIG5vIGJyZWFrYWdlcy4NCg0KWWVzIEkg
cHJvYmFibHkgY291bGQgaGF2ZSBicm9rZW4gdXAgdGhlIHBhdGNoZXMgaW4gYSBjbGVhbmVyIHdh
eS4gIFRoYW5rcy4NCg0KPiANCj4gQWxzbywgd2h5IGlzIGl0IGV4YWN0bHkgNDQgY2hhcnMgbG9u
ZywgaXMgdGhhdCBzb21lIG1hZ2ljIG51bWJlcg0KPiB0aGF0IGFsd2F5cyB3b3Jrcz8gQXQgbGVh
c3QgdGhpcyBpcyB3aGF0IGFlcl9wcmludF9lcnJvciBkb2VzDQo+IHRvby4gSSdtIGd1ZXNzaW5n
IHNvbWVvbmUgY2hvc2UgaXQgYmVjYXVzZSBpdCBpcyBsYXJnZSBlbm91Z2ggZm9yDQo+IGRldl9k
cml2ZXJfc3RyaW5nKCkgYW5kIGRldl9uYW1lKCkgYW5kIGEgY291cGxlIG1vcmUgZm9ybWF0dGlu
Zw0KPiBjaGFyYWN0ZXJzLiBPaCB3ZWxsLg0KPiANCg0KWWVzLCBJIHdhcyB1c2luZyB0aGUgc2Ft
ZSBjb2RlIGFzIGluIGFlcl9wcmludF9lcnJvci4gIFRoaXMgd2FzIGJyb3VnaHQgdXAgaW4gYSBw
cmV2aW91cyBtYWlsIHdpdGggSm9lIGFuZCB3ZSBkaXNjdXNzZWQgY2xlYW5pbmcgYWxsIG9mIHRo
aXMgdXAgaW4gYSBsYXRlciBwYXRjaC4NCg0KTGFuY2UNCg0K
