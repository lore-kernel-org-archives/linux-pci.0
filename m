Return-Path: <SRS0=0XAo=32=intel.com=elena.reshetova@kernel.org>
Return-Path: <SRS0=0XAo=32=intel.com=elena.reshetova@kernel.org>
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Bjorn Helgaas
	<helgaas@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Kees Cook
	<keescook@chromium.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "Hans
 Liljestrand" <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>
Subject: RE: [PATCH 17/29] drivers, pci: convert hv_pci_dev.refs from
 atomic_t to refcount_t
Date: Tue, 18 Apr 2017 14:29:43 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C8C6EB@IRSMSX102.ger.corp.intel.com>
References: <1488810076-3754-1-git-send-email-elena.reshetova@intel.com>
 <1488810076-3754-18-git-send-email-elena.reshetova@intel.com>
 <20170306213829.GB5305@bhelgaas-glaptop.roam.corp.google.com>
 <20170307115808.16f5235e@xeon-e3>
 <2236FBA76BA1254E88B949DDB74E612B41C8C518@IRSMSX102.ger.corp.intel.com>
 <CAErSpo4SauhAXm+twpUQVcX7822QdnC=obv7g6oOs_eEh9JOUA@mail.gmail.com>
In-Reply-To: <CAErSpo4SauhAXm+twpUQVcX7822QdnC=obv7g6oOs_eEh9JOUA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

PiBPbiBUdWUsIEFwciAxOCwgMjAxNyBhdCA1OjQwIEFNLCBSZXNoZXRvdmEsIEVsZW5hDQo+IDxl
bGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IE9uIE1vbiwg
NiBNYXIgMjAxNyAxNTozODoyOSAtMDYwMA0KPiA+PiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+Pg0KPiA+PiA+IFsrY2MgSHlwZXItViBmb2xrcywgLWNjIG90
aGVyc10NCj4gPj4gPg0KPiA+PiA+IE9uIE1vbiwgTWFyIDA2LCAyMDE3IGF0IDA0OjIxOjA0UE0g
KzAyMDAsIEVsZW5hIFJlc2hldG92YSB3cm90ZToNCj4gPj4gPiA+IHJlZmNvdW50X3QgdHlwZSBh
bmQgY29ycmVzcG9uZGluZyBBUEkgc2hvdWxkIGJlDQo+ID4+ID4gPiB1c2VkIGluc3RlYWQgb2Yg
YXRvbWljX3Qgd2hlbiB0aGUgdmFyaWFibGUgaXMgdXNlZCBhcw0KPiA+PiA+ID4gYSByZWZlcmVu
Y2UgY291bnRlci4gVGhpcyBhbGxvd3MgdG8gYXZvaWQgYWNjaWRlbnRhbA0KPiA+PiA+ID4gcmVm
Y291bnRlciBvdmVyZmxvd3MgdGhhdCBtaWdodCBsZWFkIHRvIHVzZS1hZnRlci1mcmVlDQo+ID4+
ID4gPiBzaXR1YXRpb25zLg0KPiA+PiA+ID4NCj4gPj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVsZW5h
IFJlc2hldG92YSA8ZWxlbmEucmVzaGV0b3ZhQGludGVsLmNvbT4NCj4gPj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEhhbnMgTGlsamVzdHJhbmQgPGlzaGthbWllbEBnbWFpbC5jb20+DQo+ID4+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gPj4gPiA+
IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdpbmRzb3IgPGR3aW5kc29yQGdtYWlsLmNvbT4NCj4gPj4N
Cj4gPj4NCj4gPj4gUmV2aWV3ZWQtYnk6IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNy
b3NvZnQuY29tPg0KPiA+DQo+ID4gR2V0dGluZyBiYWNrIG9uIHRoaXM6IGNvdWxkIHlvdSB0YWtl
IHRoZSBwYXRjaCB2aWEgeW91ciB0cmVlIG9yIHNob3VsZCBJIHJlc3VibWl0DQo+IHRvIHNvbWUg
ZGVkaWNhdGVkIHBsYWNlIHdpdGggYSBuZXcgcmV2aWV3LWJ5IGFkZGVkPw0KPiANCj4gU29ycnks
IGZvciBzb21lIHJlYXNvbiBJIGhhZCBhc3N1bWVkIHRoaXMgd291bGQgYWxsIGdvIGFzIHBhcnQg
b2YgdGhlDQo+IGxhcmdlciBzZXJpZXMuICBJIGFwcGxpZWQgaXQgdG8gbXkgcGNpL2hvc3QtaHYg
YnJhbmNoIHdpdGggU3RlcGhlbidzDQo+IHJldmlld2VkLWJ5IGZvciB2NC4xMi4NCg0KVGhhbmsg
eW91IHZlcnkgbXVjaCEgSSB0aGluayBJIGNvbmZ1c2VkIGV2ZXJ5b25lIGluIHRoZSBiZWdpbm5p
bmcsIGJ1dCBsYXRlciBvbiB3ZSBkZWNpZGVkIHRoYXQgaXQgaXMgYmV0dGVyIG9mZiBpbiBzbWFs
bCBjaHVua3MgYW5kIHNlcGFyYXRlIHRyZXNzLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo+
IA0KPiBUaGFua3MgZm9yIHRoZSBwaW5nIQ0KPiANCj4gQmpvcm4NCg==
