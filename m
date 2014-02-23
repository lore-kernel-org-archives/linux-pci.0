Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14826 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbaBWXdX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2014 18:33:23 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1H0099S2RM2380@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 24 Feb 2014 08:33:22 +0900 (KST)
Date: Sun, 23 Feb 2014 23:33:22 +0000 (GMT)
From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [patch 07/26] pci: pcie-designware: Remove irq_desc abuse
To: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	pci <linux-pci@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>
Reply-to: jg1.han@samsung.com
MIME-version: 1.0
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <21860356.103351393198399120.JavaMail.weblogic@epml01>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gTW9uZGF5LCBGZWJydWFyeSAyNCwgMjAxNCA2OjQwIEFNLCBUaG9tYXMgR2xlaXhuZXIgd3Jv
dGU6DQo+IA0KPiBUaGVyZSBpcyBubyByZWFzb24gdG8gY2FyZSBhYm91dCBpcnFfZGVzYyBpbiB0
aGF0IGNvbnRleHQsIGVzY3BlY2lhbGx5DQo+IGFzIGlycV9kYXRhIGZvciB0aGF0IGludGVycnVw
dCBpcyByZXRyaWV2ZWQgYXMgd2VsbC4NCj4gDQo+IFVzZSB0aGUgcHJvcGVyIGFjY2Vzc29yIGZv
ciB0aGUgbXNpIGRlc2NyaXB0b3INCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29v
Z2xlLmNvbT4NCj4gQ2M6IEppbmdvbyBIYW4gPGpnMS5oYW5Ac2Ftc3VuZy5jb20+DQo+IENjOiBN
b2hpdCBLdW1hciA8bW9oaXQua3VtYXJAc3QuY29tPg0KPiBDYzogcGNpIDxsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnPg0KDQpBY2tlZC1ieTogSmluZ29vIEhhbiA8amcxLmhhbkBzYW1zdW5nLmNv
bT4NCg0KQSBmZXcgZGF5cyBhZ28sIEkgbm90aWNlZCB0aGF0IGlycV9kYXRhX2dldF9tc2koKSBj
YW4gYmUgdXNlZC4NCkhvd2V2ZXIsIEkgZGlkIG5vdCBzdWJtaXQgdGhlIHNhbWUgcGF0Y2guIEkg
cmVhbGx5IGFwcHJlY2lhdGUNCnlvdXIgcGF0Y2guIDotKQ0KDQpCZXN0IHJlZ2FyZHMsDQpKaW5n
b28gSGFuDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9ob3N0L3BjaWUtZGVzaWdud2FyZS5jIHwg
ICAgNCArLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25z
KC0pDQo+IA0KPiBJbmRleDogdGlwL2RyaXZlcnMvcGNpL2hvc3QvcGNpZS1kZXNpZ253YXJlLmMN
Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KPiAtLS0gdGlwLm9yaWcvZHJpdmVycy9wY2kvaG9zdC9wY2llLWRlc2ln
bndhcmUuYw0KPiArKysgdGlwL2RyaXZlcnMvcGNpL2hvc3QvcGNpZS1kZXNpZ253YXJlLmMNCj4g
QEAgLTI5NCwxNCArMjk0LDEyIEBAIG5vX3ZhbGlkX2lycToNCj4gIHN0YXRpYyB2b2lkIGNsZWFy
X2lycSh1bnNpZ25lZCBpbnQgaXJxKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGludCBwb3MsIG52ZWM7
DQo+IC0Jc3RydWN0IGlycV9kZXNjICpkZXNjOw0KPiAgCXN0cnVjdCBtc2lfZGVzYyAqbXNpOw0K
PiAgCXN0cnVjdCBwY2llX3BvcnQgKnBwOw0KPiAgCXN0cnVjdCBpcnFfZGF0YSAqZGF0YSA9IGly
cV9nZXRfaXJxX2RhdGEoaXJxKTsNCj4gDQo+ICAJLyogZ2V0IHRoZSBwb3J0IHN0cnVjdHVyZSAq
Lw0KPiAtCWRlc2MgPSBpcnFfdG9fZGVzYyhpcnEpOw0KPiAtCW1zaSA9IGlycV9kZXNjX2dldF9t
c2lfZGVzYyhkZXNjKTsNCj4gKwltc2kgPSBpcnFfZGF0YV9nZXRfbXNpKGRhdGEpOw0KPiAgCXBw
ID0gc3lzX3RvX3BjaWUobXNpLT5kZXYtPmJ1cy0+c3lzZGF0YSk7DQo+ICAJaWYgKCFwcCkgew0K
PiAgCQlCVUcoKTs=


