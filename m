Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 06 Mar 2013 06:28:13 +0000 (GMT)
From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: Re: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
To: Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>
Reply-to: jg1.han@samsung.com
MIME-version: 1.0
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <17540873.418471362551288113.JavaMail.weblogic@epml07>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gVHVlc2RheSwgTWFyY2ggMDUsIDIwMTMgNTozMCBBTSwgQXJuZCBCZXJnbWFubiB3cm90ZToN
Cj4gDQo+IE9uIE1vbmRheSAwNCBNYXJjaCAyMDEzLCBUaG9tYXMgUGV0YXp6b25pIHdyb3RlOg0K
PiA+IEZXSVcsIGEgcGF0Y2ggdGhhdCBpcyBkb2luZyB3aGF0IEkgd2FzIGluaXRpYWxseSBwcm9w
b3NpbmcgaGFzIGJlZW4NCj4gPiBtZXJnZWQgZm9yIDMuOSwgYW5kIGl0IGRvZXNuJ3QgY29udGFp
biB0aGUNCj4gPiBJU19FTkFCTEVEKENPTkZJR19IQVNfSU9QT1JUKSB0ZXN0IHlvdSB3ZXJlIHBy
b3Bvc2luZyAoYW5kIHdoaWNoIEkNCj4gPiB0aGluayB3YXMgY29ycmVjdCkuIFNlZToNCj4gPg0K
PiA+IGNvbW1pdCA5ZWQ4YTMwZjM0NzEzNDdjMWI3NjNiZDA2MmZhNzhhZTgwZjE4ZWFlDQo+ID4g
QXV0aG9yOiBKaW5nb28gSGFuIDxqZzEuaGFuQHNhbXN1bmcuY29tPg0KPiA+IERhdGU6ICAgV2Vk
IEZlYiAyNyAxNzowMjo0MiAyMDEzIC0wODAwDQo+ID4NCj4gDQo+IFNpZ2guDQo+IA0KPiBJJ2xs
IHRha2UgaXQgYXMgYW4gYWRkaXRpb25hbCBpbmNlbnRpdmUgdG8gZmluYWxseSBjbGVhbiB1cCB0
aGUgbG9naWMgYmVoaW5kDQo+IENPTkZJR19IQVNfSU9QT1JUIGJ5IGludHJvZHVjaW5nIGEgQ09O
RklHX0hBU19JT1BPUlRfTUFQIHN5bWJvbCB0byByZXBsYWNlIGl0Lg0KPiANCj4gVGhhbmtzIGZv
ciB0aGUgaGVhZHMgdXAuDQoNCg0KSGkgVGhvbWFzIFBldGF6em9uaQ0KU29ycnksIEkgZGlkIG5v
dCBrbm93IHRoYXQgeW91IHN1Ym1pdHRlZCB0aGUgcGF0Y2guDQpMaWtlIHlvdSwgSSBhbSBkZXZl
bG9waW5nIFBDSWUgSG9zdCBkcml2ZXIuDQpBbHNvLCBJIGV4cGVyaWVuY2VkIHRoZSBhbm5veWlu
ZyBidWlsZCBlcnJvciByZWxhdGVkIHRvDQpDT05GSUdfSEFTX0lPUE9SVC4NCg0KSGkgQXJuZCBC
ZXJnbWFubiwNCkkgaGF2ZSBqdXN0IHJlYWQgdGhlIG1haWxpbmcgdGhyZWFkLg0KSWYgeW91IHJl
c29sdmUgdGhpcyBzaXR1YXRpb24gcHJvcGVybHksIGl0IHdpbGwgYmUgdmVyeSBoZWxwZnVsLg0K
VGhhbmsgeW91Lg0KDQpCZXN0IHJlZ2FyZHMsDQpKaW5nb28gSGFuDQoNCj4gDQo+IAlBcm5kDQo+
IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1
YnNjcmliZSBsaW51eC1wY2kiIGluDQo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRv
bW9Admdlci5rZXJuZWwub3JnDQo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2Vy
Lmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0K


