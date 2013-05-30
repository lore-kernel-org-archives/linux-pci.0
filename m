Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Ortiz, Lance E" <lance.oritz@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@redhat.com" <mchehab@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] aerdrv: Move cper_print_aer() call out of interrupt
 context
Date: Thu, 30 May 2013 04:55:20 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F95D13A6F2@G9W0715.americas.hpqcorp.net>
References: <20130529190326.24171.86905.stgit@grignak.americas.hpqcorp.net>
 <30463843.EmBn1xaq3I@vostro.rjw.lan>
 <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiA+ICsJLyoNCj4gPiArCSAqIFRPRE86IFRoaXMgZnVuY3Rpb24gbmVlZHMgdG8gYmUgcmUtd3Jp
dHRlbiBzbyB0aGF0IGl0J3Mgb3V0cHV0DQo+ID4gKwkgKiBtYXRjaGVzIHRoZSBvdXRwdXQgb2Yg
YWVyX3ByaW50X2Vycm9yKCkuICBSaWdodCBub3csIHRoZQ0KPiBvdXRwdXQNCj4gPiArCSAqIGlz
IGZvcm1hdHRlZCB2ZXJ5IGRpZmZlcmVudGx5Lg0KPiA+ICsJICovDQo+IA0KPiBTbyB3ZSBoYXZl
IHRoaXMgYmlnICJUT0RPIiBjb21tZW50IHNpdHRpbmcgdGhlcmUgdmVyeSBwcm9taW5lbnRseSAu
Li4NCj4gd2hpY2ggTGludXMNCj4gaXMgYm91bmQgdG8gYXNrIGFib3V0IGlmIEkgYXNrIGhpbSB0
byBwdWxsIHRoaXMgaW50byAzLjEwLXJjWCAuLi4NCj4gd2hhdCdzIHRoZSBpbXBhY3Qgb2YNCj4g
dGhpcz8gIFdoYXQgc2hvdWxkIEkgc2F5IHdoZW4gaGUgYXNrcyB3aHkgc2hvdWxkIGhlIHB1bGwg
dGhpcyBmaXggaW50bw0KPiAzLjEwIHdoZW4NCj4gdGhlcmUgaXMgc3RpbGwgc29tZSB3b3JrIHRv
IGRvPyAgSXMgbWF0Y2hpbmcgdGhlIG91dHB1dCBubyBiaWcgZGVhbCBhbmQNCj4gY2FuIHdhaXQg
Zm9yDQo+IHNvbWUgZnV0dXJlLCB3aGlsZSBtb3ZpbmcgdGhlIHBjaSBiaXRzIHRvIHRoZSB3b3Jr
IGZ1bmN0aW9uIG5lZWRzIHRvIGdvDQo+IGluIG5vdz8NCg0KVG9ueSwgDQoNCllvdSBoYXZlIGEg
Z29vZCBwb2ludC4gIElkZWFsbHkgdGhlIGNvbnNvbGUgb3V0cHV0IHNob3VsZCBiZSB0aGUgc2Ft
ZSBpbiBib3RoIHRoZSBhZXIgYW5kIHRoZSBjcGVyIGNhc2UuICBUaGUgb3V0cHV0IGluIGNwZXJf
cHJpbnRfZXJyb3IoKSBkb2VzIGdpdmUgdXMgYSByZWFzb25hYmxlIGFtb3VudCBvZiBpbmZvcm1h
dGlvbiwganVzdCBub3QgYXMgZGV0YWlsZWQgYXMgSSB0aGUgYWVyIGNhc2UuIEFsc28gbm93IHdo
YXQgd2UgaGF2ZSB0aGUgdHJhY2UgZXZlbnQgZm9yIGFlciwgdGhlIGNvbnNvbGUgb3V0cHV0IG1p
Z2h0IGJlIGxlc3MgaW1wb3J0YW50LiAgVGhpcyBUT0RPIGlzIGEgbm90ZSBmb3IgZnV0dXJlIGNs
ZWFuLXVwIGFuZCBpcyBub3QgZGlyZWN0bHkgcmVsYXRlZCB0byB0aGUgYnVnIGJlaW5nIGZpeGVk
IHdpdGggdGhpcyBwYXRjaC4gIFdoaWNoIGxlbmRzIHRvIHRoZSBhcmd1bWVudCBvZiB3aHkgcHV0
IHRoZSBUT0RPIGluIHRoaXMgcGF0Y2g/ICBPcHBvcnR1bmlzdGljLiAgSSBkb27igJl0IHRoaW5r
IHdlIHdhbnQgdG8gY3JlYXRlIGEgc2VwYXJhdGUgcGF0Y2gganVzdCBmb3IgYSBUT0RPIG5vdGUu
ICANCg0KU28sIHdoeSBwdWxsIHRoaXMgcGF0Y2ggaW4gZXZlbiB0aG91Z2ggdGhlcmUgaXMgd29y
ayB0byBkbz8gIFRoZSBwYXRjaCBmaXhlcyBhIHdhcm5pbmcgdGhhdCBtaWdodCBjYXVzZSBjdXN0
b21lcnMgdW4tZHVlIGNvbmNlcm4gYW5kIHJlbW92ZXMgYSBjYWxsIGluIGludGVycnVwdCBjb250
ZXh0IHRoYXQgc2hvdWxkIG5vdCBiZSB0aGVyZS4gIA0KDQpMYW5jZQ0K
