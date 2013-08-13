Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4709 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758094Ab3HMUN7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Aug 2013 16:13:59 -0400
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"lance.ortiz@hp.com" <lance.ortiz@hp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Tue, 13 Aug 2013 20:13:56 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CB9150@ORSMSX106.amr.corp.intel.com>
References: <20130808163822.67e0828a@samsung.com>
 <20130810180322.GC4155@pd.tnic> <20130812083355.47c1bae8@samsung.com>
 <5208D80D.5030206@linux.vnet.ibm.com> <20130812125343.GE18018@pd.tnic>
 <520A16BD.30201@linux.vnet.ibm.com> <20130813124258.GC4077@pd.tnic>
 <520A6D98.9060204@linux.vnet.ibm.com> <20130813175809.GE4077@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F31CB8F53@ORSMSX106.amr.corp.intel.com>
 <20130813181004.GF4077@pd.tnic>
In-Reply-To: <20130813181004.GF4077@pd.tnic>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBXaGF0IGFib3V0IHNlbmRpbmcgdHJhY2Vwb2ludCBkYXRhIG92ZXIgc2VyaWFsIGFuZC9vciBu
ZXR3b3JrPyBJIGFncmVlDQo+IHRoYXQgZG1lc2cgb3ZlciBzZXJpYWwgd291bGQgYmUgaGVscGZ1
bCBidXQgd2UgbmVlZCBhIHNpbWlsYXIgc3VyZS1maXJlDQo+IHdheSBmb3IgY2FycnlpbmcgZXJy
b3IgaW5mbyBvdXQuDQoNCkdlbmVyaWMgdHJhY2Vwb2ludHMgYXJlIGFyY2hpdGVjdGVkIHRvIGJl
IGFibGUgdG8gZmlyZSBhdCB2ZXJ5IGhpZ2ggcmF0ZXMgYW5kDQpsb2cgaHVnZSBhbW91bnRzIG9m
IGluZm9ybWF0aW9uLiAgU28gd2UnZCBuZWVkIHNvbWV0aGluZyBzcGVjaWFsIHRvIHNheQ0KanVz
dCBsb2cgdGhlc2Ugc3BlY2lhbCB0cmFjZXBvaW50cyB0byBuZXR3b3JrL3NlcmlhbC4NCg0KPiBX
aGljaCByZW1pbmRzIG1lLCBwc3RvcmUgY291bGQgYWxzbyBiZSBhIGdvb2QgdGhpbmcgdG8gdXNl
LCBpbiBhZGRpdGlvbi4NCj4gT25seSBwdXQgZXJyb3IgaW5mbyB0aGVyZSBhcyBpdCBpcyBsaW1p
dGVkIGFueXdheS4NCg0KWWVzIC0gc3BhY2UgaXMgdmVyeSBsaW1pdGVkLiAgSSBkb24ndCBrbm93
IGhvdyB0byBhc3NpZ24gcHJpb3JpdHkgZm9yIGxvZ2dpbmcNCnRoZSBkbWVzZyBkYXRhIHZzLiBz
b21lIGVycm9yIGxvZ3MuDQoNCg0KSWYgd2UganVzdCAicHJpbnRrKCkiIHRoZSBtb3N0IGltcG9y
dGFudCBwYXJ0cyAtIHRoZW4gdGhhdCBkYXRhIHdpbGwgYXV0b21hdGljYWxseQ0KZmxvdyB0byB0
aGUgc2VyaWFsIGNvbnNvbGUgYW5kIHRvIHBzdG9yZS4gIFRoZW4gd2UgaGF2ZSBtdWx0aXBsZSBw
YXRocyBmb3IgdGhlDQpjcml0aWNhbCBiaXRzIG9mIHRoZSBlcnJvciBsb2cgLSBhbmQgdGhlIHRy
YWNlcG9pbnRzIGdpdmUgdXMgbW9yZSBkZXRhaWxzIGZvciB0aGUNCmNhc2VzIHdoZXJlIHRoZSBt
YWNoaW5lIGRvZXNuJ3Qgc3BvbnRhbmVvdXNseSBleHBsb2RlLg0KDQotVG9ueQ0K
