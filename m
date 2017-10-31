Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbdJaMze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Oct 2017 08:55:34 -0400
From: "Wang, Liang-min" <liang-min.wang@intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "O'riordain, Seosamh" <seosamh.oriordain@intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] Enable SR-IOV instantiation through /sys file
Date: Tue, 31 Oct 2017 12:55:20 +0000
Message-ID: <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5BB50@FMSMSX110.amr.corp.intel.com>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
         <20171024234351.0af0ff4a@t450s.home>
         <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
         <20171025000654.7621b84e@t450s.home>
         <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5ADD3@FMSMSX110.amr.corp.intel.com>
         <20171028001907.7b8fa60d@t450s.home> <1509146439.11655.60.camel@intel.com>
         <20171029061646.GA28105@infradead.org>
 <1509367141.11641.51.camel@infradead.org>
In-Reply-To: <1509367141.11641.51.camel@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgV29vZGhvdXNl
IFttYWlsdG86ZHdtdzJAaW5mcmFkZWFkLm9yZ10NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDMw
LCAyMDE3IDg6MzkgQU0NCj4gVG86IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz47IER1eWNrLCBBbGV4YW5kZXIgSA0KPiA8YWxleGFuZGVyLmguZHV5Y2tAaW50ZWwuY29tPg0K
PiBDYzogV2FuZywgTGlhbmctbWluIDxsaWFuZy1taW4ud2FuZ0BpbnRlbC5jb20+Ow0KPiBhbGV4
LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2ly
c2hlciwgSmVmZnJleSBUDQo+IDxqZWZmcmV5LnQua2lyc2hlckBpbnRlbC5jb20+OyBrdm1Admdl
ci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEVuYWJsZSBTUi1JT1YgaW5zdGFudGlhdGlv
biB0aHJvdWdoIC9zeXMgZmlsZQ0KPiANCj4gT24gU2F0LCAyMDE3LTEwLTI4IGF0IDIzOjE2IC0w
NzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiBPbiBGcmksIE9jdCAyNywgMjAxNyBh
dCAxMToyMDo0MVBNICswMDAwLCBEdXljaywgQWxleGFuZGVyIEggd3JvdGU6DQo+ID4gPg0KPiA+
ID4gSSBkb24ndCBzZWUgdGhpcyBzbyBtdWNoIGFzIGEgc2VjdXJpdHkgcHJvYmxlbSBwZXItc2Uu
IEl0IGFsbCBkZXBlbmRzDQo+ID4gPiBvbiB0aGUgaGFyZHdhcmUgc2V0dXAuIElmIEkgcmVjYWxs
IGNvcnJlY3RseSwgdGhlcmUgYXJlIGRldmljZXMgd2hlcmUNCj4gPiA+IHRoZSBQRiBmdW5jdGlv
biBkb2Vzbid0IHJlYWxseSBkbyBtdWNoIG90aGVyIHRoYW4gYWN0IGFzIGEgYml0IG1vcmUNCj4g
PiA+IGhlYXZ5LXdlaWdodCBWRiwgYW5kIHRoZSBhY3R1YWwgbG9naWMgaXMgaGFuZGxlZCBieSBh
IGZpcm13YXJlIGVuZ2luZQ0KPiA+ID4gb24gdGhlIGRldmljZS4NCj4gPg0KPiA+IENhbiB5b3Ug
Y2l0ZSBhbiBleGFtcGxlP8KgwqBXaGlsZSB0aG9zZSBzdXJlbHkgY291bGQgZXhpc3QgaW4gdGhl
b3J5LA0KPiA+IEkgY2FuJ3QgdGhpbmsgb2YgYSBwcmFjdGljYWwgZXhhbXBsZS4NCj4gDQo+IEkg
aGF2ZSB0aGVtLCB3aGljaCBpcyB3aHkgSSdtIHBhdGNoaW5nIHRoZSBVSU8gZHJpdmVyIHRvIGFs
bG93IG51bV92ZnMNCj4gdG8gYmUgc2V0LiBJIGRvbid0IGV2ZW4gd2FudCB0byAqdXNlKiB0aGUg
VUlPIGRyaXZlciBmb3IgYW55IHB1cnBvc2UNCj4gZXhjZXB0IHRvIG1ha2UgdGhhdCBhcHBlYXIg
aW4gc3lzZnMuIEl0J3MgYWxsIGhhbmRsZWQgaW4gdGhlIGRldmljZS4NCj4gDQo+IChJIHRoaW5r
IHdlIG1pZ2h0IGJlIGFibGUgdG8ganVzdCBnaXZlIHRoZSBQRiBvdXQgdG8gYSBndWVzdCBhcyBp
ZiBpdA0KPiB3ZXJlIGp1c3QgYW5vdGhlciBWRiwgYnV0IEkgZG9uJ3QgdGhpbmsgd2UgYWN0dWFs
bHkgKmRvKiB0aGF0IHJpZ2h0DQo+IG5vdykuDQoNClVuZGVyIFVFRkkgc2VjdXJlIGJvb3QgZW52
aXJvbm1lbnQsIGtlcm5lbCBwdXRzIHJlc3RyaWN0aW9ucyBvbiBVSU8gYW5kIGl0cyBkZXJpdmF0
aXZlcy4NClNvLCB1c2VyLXNwYWNlIGZ1bmN0aW9uL2RyaXZlciBiYXNlZCB1cG9uIFVJTyBpcyBu
byBsb25nZXIgd29ya2luZyB1bmRlciBVRUZJIHNlY3VyZQ0KYm9vdCBlbnZpcm9ubWVudC4gVGhl
IG5leHQgdmlhYmxlIG9wdGlvbiBpcyB2ZmlvLXBjaSwgaGVuY2UgdGhpcyBwYXRjaCBpbiBwYXJh
bGxlbCB3aXRoDQpVSU8gd29yay4NCg==
