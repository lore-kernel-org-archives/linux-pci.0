Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59820 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbbBYVG3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Feb 2015 16:06:29 -0500
From: "Luck, Tony" <tony.luck@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@suse.de>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI/AER: Avoid info leak in __print_tlp_header
Date: Wed, 25 Feb 2015 21:06:26 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F329EDF30@ORSMSX114.amr.corp.intel.com>
References: <1424818246-11841-1-git-send-email-linux@rasmusvillemoes.dk>
 <20150225185423.GA19236@pd.tnic>
 <CAErSpo5WwP1z+rzXzEM8_bJ2sq7rixOWiF5CqYYSK32r0sVYuw@mail.gmail.com>
In-Reply-To: <CAErSpo5WwP1z+rzXzEM8_bJ2sq7rixOWiF5CqYYSK32r0sVYuw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBJIHRoaW5rIHdlIHNob3VsZCBleHBlY3QgQUVSIHRvIGJlIHVzZWQgb24gYmlnLWVuZGlhbiBt
YWNoaW5lcy4gIEknbQ0KPiBwcmV0dHkgc3VyZSBpdCdzIHVzZWQgb24gSXRhbml1bSBpbiBiaWct
ZW5kaWFuIG1vZGUuDQoNCkl0YW5pdW0gY2FuIHJ1biBpbiBlaXRoZXIgYmlnIG9yIGxpdHRsZSBl
bmRpYW4gbW9kZSAtIGJ1dCBMaW51eCB1c2VzIGxpdHRsZSBlbmRpYW46DQoNCmFyY2gvaWE2NC9p
bmNsdWRlL3VhcGkvYXNtL2J5dGVvcmRlci5oOiNpbmNsdWRlIDxsaW51eC9ieXRlb3JkZXIvbGl0
dGxlX2VuZGlhbi5oPg0KDQotVG9ueQ0K
