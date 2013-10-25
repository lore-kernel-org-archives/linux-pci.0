Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:43561 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751858Ab3JYJMM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 25 Oct 2013 05:12:12 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23173-01 for <linux-pci@vger.kernel.org>;
 Fri, 25 Oct 2013 10:12:07 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH RFC v2 12/29] PCI/MSI: Introduce pcim_enable_msi*() family helpers
Date: Fri, 25 Oct 2013 10:10:02 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B73B0@saturn3.aculab.com>
In-Reply-To: <5269D5D1.60103@start.ca>
References: <cover.1382103786.git.agordeev@redhat.com> <6bc575621ef70f72b206e4aa944acd32f1a75718.1382103786.git.agordeev@redhat.com> <20131024105158.GB13159@mtj.dyndns.org> <AE90C24D6B3A694183C094C60CF0A2F6026B73AA@saturn3.aculab.com> <20131024114133.GA26610@dhcp-26-207.brq.redhat.com> <5269D5D1.60103@start.ca>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Mark Lord" <kernel@start.ca>,
	"Alexander Gordeev" <agordeev@redhat.com>
Cc: "Tejun Heo" <tj@kernel.org>, <linux-kernel@vger.kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Michael Ellerman" <michael@ellerman.id.au>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Ben Hutchings" <bhutchings@solarflare.com>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiA+IHBjaW1fZW5hYmxlX21zaXhfbWluX21heChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBzdHJ1Y3Qg
bXNpeF9lbnRyeSAqZW50cmllcywNCj4gPiAJCQkgdW5zaWduZWQgaW50IG1pbnZlYywgdW5zaWdu
ZWQgaW50IG1heHZlYyk7DQo+IA0KPiBUaGUgaGFyZHdhcmUgSSBoYXZlIGluIG1pbmQgaGVyZSB3
b3JrcyBvbmx5IGZvciBwb3dlcnMgb2YgdHdvLg0KPiBFZy4gMTYsIDgsIDQsIDIsIG9yIDEgTVNJ
LVggdmVjdG9yLiAgTm90IHRoZSBvZGQgdmFsdWVzIGluIGJldHdlZW4uDQo+IA0KPiBCdXQgaXQg
YXBwZWFycyBJIGNhbiBzdGlsbCBqdXN0IHVzZSBhIGxvb3AgZm9yIHRoYXQgY2FzZSwNCj4gY2Fs
bGluZyB0aGUgbmV3IGZ1bmN0aW9uIGFib3ZlIGluc3RlYWQgb2YgdGhlIG9sZCBmdW5jdGlvbnMu
DQoNCllvdSdkIGVpdGhlciBoYXZlIHRvIGxvb3Agd2l0aCBtaW4gYW5kIG1heCB0aGUgc2FtZSAo
c3RhcnRpbmcgYXQgMTYpLA0Kb3IgZG8gYSBzaW5nbGUgY2FsbCB3aXRoIG1pbj0xIGFuZCBtYXg9
MTYgYW5kIHRoZSByZWxlYXNlIHRoZQ0KdW53YW50ZWQgb25lcy4NCg0KVGhlIGxhdHRlciBtaWdo
dCBiZSBwcmVmZXJyZWQgYmVjYXVzZSBpdCBtaWdodCBzdG9wIGFuIGFubm95aW5nDQp0cmFjZSBh
Ym91dCB0aGUgc3lzdGVtIG5vdCBoYXZpbmcgZW5vdWdoIE1TSSBpbnRlcnJ1cHRzLg0KDQpXaGF0
IHRoaXMgZG9lc24ndCByZXNvbHZlIGlzIGEgZHJpdmVyIHJlcXVlc3RpbmcgYSBsb3Qgb2YgaW50
ZXJydXB0cw0KZWFybHkgb24gYW5kIGxlYXZpbmcgbm9uZSBmb3IgbGF0ZXIgZHJpdmVycy4NCg0K
UmVhbGx5IHRoZSBzeXN0ZW0gbmVlZHMgdG8gYWxsb2NhdGUgdGhlIG1pbmltdW0gbnVtYmVyIHRv
IGFsbA0KZHJpdmVycyBiZWZvcmUgZ2l2aW5nIG91dCBhbnkgZXh0cmEgb25lcyAtIEkndmUgTkZJ
IGhvdyB0aGlzDQp3b3VsZCBiZSBhcnJhbmdlZCENCg0KCURhdmlkDQoNCg==
