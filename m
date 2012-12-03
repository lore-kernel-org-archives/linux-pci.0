Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Ortiz, Lance E" <lance.oritz@hp.com>
To: Borislav Petkov <bp@alien8.de>
CC: Mauro Carvalho Chehab <mchehab@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Zhang Yanmin <yanmin.zhang@intel.com>
Subject: RE: [PATCH v3 1/3] aerdrv: Trace Event for AER
Date: Mon, 3 Dec 2012 21:13:49 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F9516EE7B0@G4W3218.americas.hpqcorp.net>
References: <20121130213330.7649.51101.stgit@grignak.americas.hpqcorp.net>
 <20121201093614.720aa96a@redhat.com>
 <A961433CDFF2F640A2866803152E61F9516EE717@G4W3218.americas.hpqcorp.net>
 <20121203202756.GB14798@liondog.tnic>
In-Reply-To: <20121203202756.GB14798@liondog.tnic>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiANCj4gTWF5YmUgd2Ugc2hvdWxkIGFzayBZYW5taW4gd2hvIGFkZGVkIHRob3NlIHN0cmluZ3Mg
aW4NCj4gNmMyYjM3NGQ3NDg1N2U4OTIwODBlZTcyNjE4NGVjMWQxNWU3ZDRlNDsgQ0NlZC4NCj4g
DQo+IEFsc28sIGl0IHdvdWxkIG1ha2UgYSBsb3Qgb2Ygc2Vuc2UgdG8gaGF2ZSB0aG9zZSBzdHJp
bmcgZGVmaW5pdGlvbnMNCj4gYXQgb25lIHBsYWNlIGFuZCB0aGVuIHJldXNlIHRoZW0gaW5zdGVh
ZCBvZiBkZWZpbmUgdGhlbSBhZ2FpbiBpbiB0aGUNCj4gdHJhY2Vwb2ludCBoZWFkZXIgYW5kIHRo
ZXkgZ2V0IG91dCBvZiBzeW5jIGFuZCBoYXZlIG5lZWRsZXNzDQo+IGR1cGxpY2F0aW9uDQo+IGlu
IHRoZSBrZXJuZWwsIGV0YywgZXRjLg0KPiANCj4gU28sIGluc3RlYWQsIHlvdSBjb3VsZCBkZWZp
bmUgc29tZSBtYWNyb3Mgd2hpY2ggY2FuIGdlbmVyYXRlIHlvdXINCj4gc3RyaW5ncyBhYm92ZSBs
aWtlIHRoaXM6DQo+IA0KPiAjZGVmaW5lIGFlcl91bmNvcl9lcnJfc3RyKGJpdG51bSkJXA0KPiAJ
eyBCSVQoYml0bnVtKSwgYWVyX3VuY29ycmVjdGFibGVfZXJyb3Jfc3RyaW5nKGJpdG51bSkgfQ0K
PiANCj4gYW5kIHVzZSB0aGF0IG1hY3JvIGZvciB0aGUgX19wcmludF9mbGFncyBmbGFnX2FycmF5
IGFyZ3VtZW50Lg0KPiANCj4gT3Igc29tZXRoaW5nIHRvIHRoYXQgZWZmZWN0Lg0KPiANCj4gRXZl
biBiZXR0ZXIgd291bGQgaXQgYmUgaWYgdGhlIGVycm9yIHN0cmluZ3MgaW4NCj4gPGRyaXZlcnMv
cGNpL3BjaWUvYWVyL2FlcmRydl9lcnJwcmludC5jPiBjb3VsZCBiZSBzaGFyZWQgd2l0aCB0aGUN
Cj4gdHJhY2Vwb2ludCBvbmVzLiBUaGF0IHdvdWxkIHJlcXVpcmUgYSBiaXQgbW9yZSBjaGFuZ2Vz
IHRob3VnaCBidXQNCj4gc29tZXRoaW5nIGxpa2UgdXNpbmcgYW4gYXJyYXkgb2YgdHJhY2VfcHJp
bnRfZmxhZ3MgaW5zdGVhZCBhbiBhcnJheSBvZg0KPiBzdHJpbmdzIGNvdWxkIGJlIGRvYWJsZS4N
Cj4gDQo+IFRoZW4sIHdoZW4geW91IG5lZWQgdGhlIHN0cmluZywgeW91IGRvIHVuY29yX2Vycl9h
cnJheVtpXS5uYW1lIGFuZCBzbw0KPiBvbi4NCg0KVGhpcyBhIGZpbmUgaWRlYS4gIEknbSB0aGlu
a2luZyB3ZSBtaWdodCB3YW50IHRvIGltcGxlbWVudCB0aGF0IGluIGEgbGF0ZXIgcGF0Y2ggc2lu
Y2UgaXQgaXMgYSBiaWdnZXIgY2hhbmdlIGFuZCB3ZSBzdGlsbCBuZWVkIHRvIHNlZSBhYm91dCBh
ZGRpbmcgYWRkaXRpb25hbCBzdHJpbmdzLiAgSSBjYW4gc2VuZCBvdXQgb25lIG1vcmUgdmVyc2lv
biBvZiB0aGUgcGF0Y2ggd2l0aCB0aGUgY29tbWVudCBoZWFkZXIgY2hhbmdlcyB5b3Ugc3VnZ2Vz
dGVkLCBhbmQgdGhlIGNvbW1lbnRzIEpvZSBoYWQgYW5kIG1heWJlIHdlIGNhbiBtb3ZlIGZvcndh
cmQgd2l0aCB0aGF0Lg0KDQpMYW5jZSANCg0K
