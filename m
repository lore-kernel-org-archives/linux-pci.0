Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC: Mauro Carvalho Chehab <m.chehab@samsung.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"lance.ortiz@hp.com" <lance.ortiz@hp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Tue, 13 Aug 2013 18:05:02 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CB8F53@ORSMSX106.amr.corp.intel.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812125343.GE18018@pd.tnic> <520A16BD.30201@linux.vnet.ibm.com>
 <20130813124258.GC4077@pd.tnic> <520A6D98.9060204@linux.vnet.ibm.com>
 <20130813175809.GE4077@pd.tnic>
In-Reply-To: <20130813175809.GE4077@pd.tnic>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBXaHkgd291bGQgeW91IG5lZWQgZG1lc2cgaWYgeW91IGdldCB5b3VyIGh3IGVycm9ycyBvdmVy
IHRoZSB0cmFjZXBvaW50Pw0KDQpSZWR1bmRhbmN5IGlzIGEgZ29vZCB0aGluZyB3aGVuIHRhbGtp
bmcgYWJvdXQgbWlzc2lvbiBjcml0aWNhbCBzeXN0ZW1zLiAgZG1lc2cNCm1heSBiZSBmZWVkaW5n
IHRvIGEgc2VyaWFsIGNvbnNvbGUgdG8gYmUgbG9nZ2VkIGFuZCBhbmFseXNlZCBvbiBhbm90aGVy
IHN5c3RlbS4NCg0KVGhlIHRyYWNlcG9pbnQgZGF0YSBnb2VzIHRvIGEgcHJvY2VzcyBvbiB0aGUg
c3lzdGVtIGV4cGVyaWVuY2luZyB0aGUgZXJyb3JzLiBJZiB0aGUNCmVycm9ycyBhcmUgc2VyaW91
cyAob3IgYSBwcmVjdXJzb3IgdG8gc29tZXRoaW5nIHNlcmlvdXMpIHRoYXQgcHJvY2VzcyBtYXkg
bmV2ZXIgZ2V0DQp0aGUgY2hhbmNlIHRvIHNhdmUgdGhlIGxvZy4NCg0KLVRvbnkNCg==
