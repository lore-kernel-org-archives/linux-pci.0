Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28649 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab3HOTOg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Aug 2013 15:14:36 -0400
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
Date: Thu, 15 Aug 2013 19:14:34 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CBD158@ORSMSX106.amr.corp.intel.com>
References: <20130812125343.GE18018@pd.tnic>
 <520A16BD.30201@linux.vnet.ibm.com> <20130813124258.GC4077@pd.tnic>
 <520A6D98.9060204@linux.vnet.ibm.com> <20130813175809.GE4077@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F31CB8F53@ORSMSX106.amr.corp.intel.com>
 <20130813181004.GF4077@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F31CB9150@ORSMSX106.amr.corp.intel.com>
 <20130814054322.GA9158@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F31CBAAFA@ORSMSX106.amr.corp.intel.com>
 <20130815101432.GE27616@pd.tnic>
In-Reply-To: <20130815101432.GE27616@pd.tnic>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBXZWxsLCBpZiBJIGhhdmUgc2VyaWFsIGNvbm5lY3RlZCB0byB0aGUgYm94LCBpdCB3aWxsIGNv
bnRhaW4gYmFzaWNhbGx5DQo+IGV2ZXJ5dGhpbmcgdGhlIG1hY2hpbmUgc2FpZCwgbm8/DQoNClll
cyAtIGJ1dCB0aGUgc2VyaWFsIHBvcnQgaXMgdG9vIHNsb3cgdG8gbG9nIGV2ZXJ5dGhpbmcgdGhh
dCB5b3UgbWlnaHQNCmNvbmNlaXZhYmx5IG5lZWQgdG8gZGVidWcgeW91ciBwcm9ibGVtLiAgSW1h
Z2luZSB0cnlpbmcgdG8gbG9nIGV2ZXJ5DQppbnRlcnJ1cHQgYW5kIGV2ZXJ5IHBhZ2VmYXVsdCBv
biBldmVyeSBwcm9jZXNzb3IgZG93biBhIHNpbmdsZSAxMTUyMDANCmJhdWQgY29ubmVjdGlvbi4g
IFRodXMgbXkgZWFybGllciBjb21tZW50cyBhYm91dCBndWVzc2luZyB3aGF0IHRvDQpsb2cuDQoN
Ci1Ub255DQo=
