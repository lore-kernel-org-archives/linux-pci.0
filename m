Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34110 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbaKFBti (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Nov 2014 20:49:38 -0500
From: "Liu, Chuansheng" <chuansheng.liu@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Barto <mister.freeman@laposte.net>,
	"Tejun Heo (tj@kernel.org)" <tj@kernel.org>
CC: "Lu, Aaron" <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>,
	"Rafael Wysocki" <rjw@rjwysocki.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: Do not enable async suspend for JMicron chips
Date: Thu, 6 Nov 2014 01:48:06 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A01EB7713@SHSMSX101.ccr.corp.intel.com>
References: <1415151063-2530-1-git-send-email-chuansheng.liu@intel.com>
 <CAErSpo6cWP2ngErLVzqASkeQOLsB7JjgCC8UuA-S=Lz=AJyf6Q@mail.gmail.com>
 <545A7087.3050802@laposte.net>
 <CAErSpo4fvoeP9Gab1ZDg=ofjH+aqxGD09nLDTF1ZERnH=yEPxw@mail.gmail.com>
In-Reply-To: <CAErSpo4fvoeP9Gab1ZDg=ofjH+aqxGD09nLDTF1ZERnH=yEPxw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGVsbG8gQmpvcm4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpv
cm4gSGVsZ2FhcyBbbWFpbHRvOmJoZWxnYWFzQGdvb2dsZS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5
LCBOb3ZlbWJlciAwNiwgMjAxNCAzOjA0IEFNDQo+IFRvOiBCYXJ0bw0KPiBDYzogTGl1LCBDaHVh
bnNoZW5nOyBMdSwgQWFyb247IFRlanVuIEhlbzsgUmFmYWVsIFd5c29ja2k7DQo+IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gUENJOiBEbyBub3QgZW5hYmxlIGFzeW5jIHN1c3BlbmQgZm9yIEpNaWNy
b24gY2hpcHMNCj4gDQo+IE9uIFdlZCwgTm92IDUsIDIwMTQgYXQgMTE6NDYgQU0sIEJhcnRvIDxt
aXN0ZXIuZnJlZW1hbkBsYXBvc3RlLm5ldD4NCj4gd3JvdGU6DQo+ID4gdGhpcyBwYXRjaCBzb2x2
ZXMgdGhlc2UgMiBidWcgcmVwb3J0cyA6DQo+ID4NCj4gPiBodHRwczovL2J1Z3ppbGxhLmtlcm5l
bC5vcmcvc2hvd19idWcuY2dpP2lkPTg0ODYxDQo+ID4NCj4gPiBodHRwczovL2J1Z3ppbGxhLmtl
cm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTgxNTUxDQo+IA0KPiBUaG9zZSBidWdzIHdlcmUgYWxy
ZWFkeSBtZW50aW9uZWQuICBCdXQgZTZiN2U0MWNkZDhjIGNsYWltcyB0byBzb2x2ZQ0KPiBodHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTgxNTUxLCBhbmQgODQ4NjEg
aXMgYQ0KPiBkdXBsaWNhdGUgb2YgODE1NTEsIHNvIGl0IHNob3VsZCBhbHNvIGJlIGZpeGVkIGJ5
IGU2YjdlNDFjZGQ4Yy4NCj4gDQo+IFNvIHRoZSBxdWVzdGlvbiBpcywgd2h5IHdhcyBlNmI3ZTQx
Y2RkOGMgaW5zdWZmaWNpZW50PyAgUHJlc3VtYWJseSBpdA0KPiB3YXMgdGVzdGVkIGFuZCBzb21l
Ym9keSB0aG91Z2h0IGl0IGRpZCBmaXggdGhlIHByb2JsZW0uDQoNClRoZSBmaXJzdCBwYXRjaCBl
NmI3ZTQxY2RkOGMgd2hpY2ggaXMganVzdCBleGNsdWRlIHNvbWUgb2YgSk1pY3JvbiBjaGlwcygz
NjMvMzYxKSBvdXQgb2YgYXN5bmNfc3VzcGVuZCwNCnRoZW4gQmFydG8gZm91bmQgdGhlIHNhbWUg
aXNzdWUgb24gSk1pY3JvbiAzNjgsIHNvIHdlIG5lZWQgb25lIG1vcmUgZ2VuZXJhbCBwYXRjaCB0
byBsZXQgSk1pY3JvbiBjaGlwcw0Kb3V0IG9mIGFzeW5jX3N1c3BlbmQsIHNvIHdlIG1ha2UgdGhp
cyBwYXRjaC4NCg0KQmpvcm4sIHRqLA0KQ291bGQgeW91IGtpbmRseSB0YWtlIHRoaXMgcGF0Y2g/
IEFzIEJhcnRvIHNhaWQsIGl0IGVmZmVjdGVkIHRoZSB1c2VyIGV4cGVyaWVuY2UgaW5kZWVkLCB0
aGFua3MuDQoNCg==
