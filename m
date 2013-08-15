Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>
CC: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"lance.ortiz@hp.com" <lance.ortiz@hp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Aristeu Rozanski Filho" <arozansk@redhat.com>
Subject: RE: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Thu, 15 Aug 2013 18:16:48 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CBCE72@ORSMSX106.amr.corp.intel.com>
References: <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812114404.3bd64fa0@samsung.com> <520A1B5E.8040105@linux.vnet.ibm.com>
 <20130813094147.062317f8@concha.lan> <520A6A30.1030406@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CB8DB5@ORSMSX106.amr.corp.intel.com>
 <520B603E.3040002@linux.vnet.ibm.com> <20130814211504.393cf138@concha.lan>
 <20130815100132.GC27616@pd.tnic> <20130815103421.178a5224@samsung.com>
 <20130815135106.GG27616@pd.tnic>
In-Reply-To: <20130815135106.GG27616@pd.tnic>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAqIFdlIHBhcnNlIHNvbWUgQVBFSSB0YWJsZSBhbmQgZGlzYWJsZSB0aG9zZSBNQ0EgYmFua3Mg
d2hpY2ggdGhlIEJJT1MNCj4gd2FudHMgdG8gaGFuZGxlIGZpcnN0Lg0KDQpXZSBoYXZlIG5vIGlk
ZWEgd2hpY2ggZXJyb3JzIHRoZSBCSU9TIGhhcyBjaG9zZW4gZm9yIGl0c2VsZi4gIFdlIGp1c3Qg
a25vdyB3aGljaA0KYmFuayBudW1iZXJzIC4uLiBhbmQgSW50ZWwgcHJvY2Vzc29ycyBjaGFuZ2Ug
bWFwcGluZ3Mgb2Ygd2hpY2ggZXJyb3JzIGFyZSBsb2dnZWQNCmluIHdoaWNoIGJhbmtzIGluIGV2
ZXJ5IG5ldyBwcm9jZXNzb3IgdG9jayAoYW5kIHNvbWV0aW1lcyB0aWNrKS4gIFNvbWUgYmFua3MN
CmFyZSBkb2N1bWVudGVkIGluIHByb2Nlc3NvciBkYXRhc2hlZXQuIG1vc3QgYXJlIG5vdC4gTW9z
dCBjb21tb24gY2FzZSBtaWdodA0Kd2VsbCBiZSBtZW1vcnkgLi4uIGJ1dCBpdCBjb3VsZCBiZSBj
YWNoZSwgb3IgSS9PLCBvciAuLi4NCg0KU28gdGhpcyBkb2Vzbid0IGhlbHAgTWF1cm8gZmlndXJl
IG91dCB3aGV0aGVyIHRvIGFsbG93IGxvYWRpbmcgb2YgYW4NCkVEQUMgZHJpdmVyIHRoYXQgd2ls
bCBwZWVrIGFuZCBwb2tlIGF0IGNoaXBzZXQgc3BlY2lmaWMgcmVnaXN0ZXJzIGluDQpwb3NzaWJs
eSByYWN5IHdheXMgd2l0aCBCSU9TIGNvZGUgZG9pbmcgdGhlIHNhbWUgdGhpbmcuDQoNCi1Ub255
DQo=
