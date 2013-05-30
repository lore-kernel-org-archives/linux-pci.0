Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:26117 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab3E3OFn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 10:05:43 -0400
From: "Ortiz, Lance E" <lance.oritz@hp.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"mchehab@redhat.com" <mchehab@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] aerdrv: Move cper_print_aer() call out of interrupt
 context
Date: Thu, 30 May 2013 14:04:42 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F95D13A762@G9W0715.americas.hpqcorp.net>
References: <20130529190326.24171.86905.stgit@grignak.americas.hpqcorp.net>
	 <30463843.EmBn1xaq3I@vostro.rjw.lan>
	 <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
	 <A961433CDFF2F640A2866803152E61F95D13A6F2@G9W0715.americas.hpqcorp.net>
	 <20130530072849.GA20793@pd.tnic>
 <1369921028.26799.4.camel@gandalf.local.home>
In-Reply-To: <1369921028.26799.4.camel@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiA+DQo+ID4gU291bmRzIHRvIG1lLCB0aGlzIFRPRE8gaXRlbSBzaG91bGQgYmUgb24geW91ciBU
T0RPIGxpc3QgLSBub3QgaW4NCj4ga2VybmVsDQo+ID4gc291cmNlcyA6LSkNCj4gPg0KPiANCj4g
QWxzbywgdGhhdCBUT0RPIHNvdW5kcyBsaWtlIHRoZXJlJ3Mgb3V0cHV0IHRvIHVzZXJzcGFjZSB0
aGF0IGNhbiBiZQ0KPiBwYXJzZWQgYnkgYSB1c2Vyc3BhY2UgdG9vbC4gSWYgYSB0b29sIGV4cGVj
dHMgdGhlIGN1cnJlbnQgZm9ybWF0LCBpdA0KPiBtYXkNCj4gbm90IGJlIGFjY2VwdGFibGUgdG8g
Y2hhbmdlIGl0IGxhdGVyLg0KPiANCj4gSWYgdGhlIGNvbnRlbnRzIG9mIHRoaXMgcGF0Y2ggaGFz
IG5vdGhpbmcgdG8gZG8gd2l0aCB0aGUgVE9ETywgdGhlbg0KPiBsZWF2ZSBpdCBvdXQuIEl0IGp1
c3QgY29uZnVzZXMgdGhpbmdzLg0KDQpTdGV2ZSwgeW91IGRvIGhhdmUgYSBnb29kIHBvaW50IGhl
cmUuICBJIGFtIHdvbmRlcmluZyBpZiB0aGF0IGlzIHdoeSB3ZSBzaG91bGQgY29uc2lkZXIgY2hh
bmdpbmcgdGhlIG91dHB1dCB0byBtYXRjaCBhZXJfcHJpbnRfZXJyb3IoKS4gIFRoZSBjb2RlIHBh
dGggdG8gYWVyX3ByaW50X2Vycm9yKCkgaXMgdGhlIG1vcmUgY29tbW9uIHBhdGggd2hlcmUgbm90
IGFzIG1hbnkgcGxhdGZvcm1zIHN1cHBvcnQgdGhlIGNwZXJfcHJpbnRfZXJyb3IoKSBwYXRoIChm
aXJtd2FyZSBmaXJzdCBBRVIpLiAgU28gaXQgaXMgbW9yZSBsaWtlbHkgdGhhdCBhbnkgdG9vbHMg
d3JpdHRlbiB3b3VsZCBrbm93IGhvdyB0byBwYXJzZSB0aGUgb3V0cHV0IGZyb20gYWVyX3ByaW50
X2Vycm9yKCkuICBJdCB3b3VsZCBiZSBnb29kIGZvciB0aG9zZSB0b29scyB0byBzdXBwb3J0IGZp
cm13YXJlIGZpcnN0IEFFUiB3aGVuIGl0IGJlY29tZXMgbW9yZSBjb21tb24uICBPZiBjb3Vyc2Ug
dGhpcyBpcyBwdXJlbHkgY29uamVjdHVyZS4gIEkgaGF2ZSBubyBpZGVhIGlmIHRoZXJlIGFyZSBh
bnkgdG9vbHMgdGhhdCBwYXJzZSB0aGlzIHRleHQgb3V0cHV0Lg0KDQpMYW5jZQ0K
