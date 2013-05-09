Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Ortiz, Lance E" <lance.oritz@hp.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@redhat.com" <mchehab@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] aerdrv: Move cper_print_pcie() out of interrupt context
Date: Thu, 9 May 2013 19:10:36 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F95177AFA9@G4W3219.americas.hpqcorp.net>
References: <20130508171519.26724.63307.stgit@grignak.americas.hpqcorp.net>
 <2598827.AVAqMcfGuF@vostro.rjw.lan>
In-Reply-To: <2598827.AVAqMcfGuF@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

UmFmYWVsLCAgDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCg0KPiBUaGUgd2F5IHRoZSBj
aGFuZ2VzIGFyZSBkZXNjcmliZWQgaGVyZSBpc24ndCBwYXJ0aWN1bGFybHkgY2xlYXIgdG8gbWUu
DQoNCkkgd2lsbCB0cnkgdG8gbWFrZSBpdCBhIGxpdHRsZSBtb3JlIGNsZWFyLg0KDQoNCj4gQWxz
bywgc2luY2UgYWVyX3JlY292ZXJfd29ya19mdW5jKCkgaXMgZ29pbmcgdG8gYmUgdGhlIG9ubHkg
ZXhpc3RpbmcNCj4gY2FsbGVyIG9mDQo+IGNwZXJfcHJpbnRfYWVyKCkgYWZ0ZXIgdGhpcyBjaGFu
Z2UsIGFzIGZhciBhcyBJIGNhbiBzYXksIGFuZCBpdCBkb2Vzbid0DQo+IHVzZSB0aGUNCj4gZnVu
Y3Rpb24ncyBmaXJzdCBhcmd1bWVudCwgdGhhdCBhcmd1bWVudCBzaG91bGQgYmUgZHJvcHBlZCBl
bnRpcmVseS4NCg0KVGhlIHRydXRoIGlzLCB0aGUgZnVuY3Rpb24gY3Blcl9wcmludF9hZXIoKSBy
ZWFsbHkgbmVlZHMgdG8gYmUgcmUtd3JpdHRlbiBzbyBpdCBpcyBjb25zaXN0ZW50IHdpdGggYWVy
X3ByaW50X2Vycm9yKCkgaW4gaG93IGl0IG91dHB1dHMgaW5mb3JtYXRpb24uICBSaWdodCBub3cs
IHRoZSBvdXRwdXQgaXMgZm9ybWF0dGVkIHZlcnkgZGlmZmVyZW50bHkuICBJIHdhcyBwbGFubmlu
ZyBvbiBkb2luZyB0aGF0IGF0IGEgbGF0ZXIgZGF0ZSwgYnV0IGZpeCB0aGUgd2FybmluZyBub3cu
ICBJIG1pZ2h0IGFkZCBhIFRPRE8gY29tbWVudCBpbiB0aGUgY29kZSBmb3IgdGhpcy4NCg0KVGhl
IHJlYXNvbiBJIGRpZCBub3QgcmVtb3ZlIHRoZSBhcmd1bWVudCBpbiBjcGVyX3ByaW50X2Flcigp
IGlzIGJlY2F1c2UgJ3ByZWZpeCcgaXMgdXNlZCBpbiB0aGUgY2FsbCB0byBjcGVyX3ByaW50X2Jp
dHMoKSwgYW5kIEkgcGFzc2VkIHRocm91Z2ggYW4gZW1wdHkgc3RyaW5nIHRvIG1ha2Ugc3VyZSB0
aGF0IGZ1bmN0aW9uIHdvcmtlZCBjb3JyZWN0bHkuICBJIGNhbiB0cnkgdG8gY2xlYW4gaXQgdXAu
DQoNCkxhbmNlDQo=
