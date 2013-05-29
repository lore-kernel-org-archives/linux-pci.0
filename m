Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Luck, Tony" <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Lance Ortiz <lance.ortiz@hp.com>
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
Date: Wed, 29 May 2013 23:07:47 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
References: <20130529190326.24171.86905.stgit@grignak.americas.hpqcorp.net>
 <30463843.EmBn1xaq3I@vostro.rjw.lan>
In-Reply-To: <30463843.EmBn1xaq3I@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiArCS8qDQo+ICsJICogVE9ETzogVGhpcyBmdW5jdGlvbiBuZWVkcyB0byBiZSByZS13cml0dGVu
IHNvIHRoYXQgaXQncyBvdXRwdXQNCj4gKwkgKiBtYXRjaGVzIHRoZSBvdXRwdXQgb2YgYWVyX3By
aW50X2Vycm9yKCkuICBSaWdodCBub3csIHRoZSBvdXRwdXQNCj4gKwkgKiBpcyBmb3JtYXR0ZWQg
dmVyeSBkaWZmZXJlbnRseS4NCj4gKwkgKi8NCg0KU28gd2UgaGF2ZSB0aGlzIGJpZyAiVE9ETyIg
Y29tbWVudCBzaXR0aW5nIHRoZXJlIHZlcnkgcHJvbWluZW50bHkgLi4uIHdoaWNoIExpbnVzDQpp
cyBib3VuZCB0byBhc2sgYWJvdXQgaWYgSSBhc2sgaGltIHRvIHB1bGwgdGhpcyBpbnRvIDMuMTAt
cmNYIC4uLiB3aGF0J3MgdGhlIGltcGFjdCBvZg0KdGhpcz8gIFdoYXQgc2hvdWxkIEkgc2F5IHdo
ZW4gaGUgYXNrcyB3aHkgc2hvdWxkIGhlIHB1bGwgdGhpcyBmaXggaW50byAzLjEwIHdoZW4NCnRo
ZXJlIGlzIHN0aWxsIHNvbWUgd29yayB0byBkbz8gIElzIG1hdGNoaW5nIHRoZSBvdXRwdXQgbm8g
YmlnIGRlYWwgYW5kIGNhbiB3YWl0IGZvcg0Kc29tZSBmdXR1cmUsIHdoaWxlIG1vdmluZyB0aGUg
cGNpIGJpdHMgdG8gdGhlIHdvcmsgZnVuY3Rpb24gbmVlZHMgdG8gZ28gaW4gbm93Pw0KDQotVG9u
eQ0K
