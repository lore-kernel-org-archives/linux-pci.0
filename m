Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11857 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CFIkc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 03:40:32 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ80054QDFELGJ0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 06 Mar 2013 17:40:30 +0900 (KST)
Date: Wed, 06 Mar 2013 08:40:19 +0000 (GMT)
From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lior Amsalem <alior@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Message-id: <22387327.428751362559215433.JavaMail.weblogic@epml07>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkbmVzZGF5LCBNYXJjaCAwNiwgMjAxMyA1OjI2IFBNLCBUaG9tYXMgUGV0YXp6b25pIHdy
b3RlOg0KPiANCj4gRGVhciBKaW5nb28gSGFuLA0KPiANCj4gT24gV2VkLCAwNiBNYXIgMjAxMyAw
NjoyODowOCArMDAwMCAoR01UKSwgSmluZ29vIEhhbiB3cm90ZToNCj4gDQo+ID4gU29ycnksIEkg
ZGlkIG5vdCBrbm93IHRoYXQgeW91IHN1Ym1pdHRlZCB0aGUgcGF0Y2guDQo+IA0KPiBObyBwcm9i
bGVtLCBJJ20gaGFwcHkgdG8gaGF2ZSBvbmUgbGVzcyBwYXRjaCB0byBjYXJyeSBpbiBteSBQQ0ll
IHBhdGNoDQo+IHNldCA6KQ0KDQpUaGFuayB5b3UgOikNCg0KPiANCj4gPiBMaWtlIHlvdSwgSSBh
bSBkZXZlbG9waW5nIFBDSWUgSG9zdCBkcml2ZXIuDQo+IA0KPiBKdXN0IGN1cmlvdXMsIGRvIHlv
dSBhbHJlYWR5IGhhdmUgc29tZSBjb2RlPyBUaGllcnJ5IFJlZGluZyBhbmQgbXlzZWxmDQo+IGhh
dmUgYmVlbiBsb29raW5nIGF0IGVhY2ggb3RoZXIncyBQQ0llIGhvc3QgZHJpdmVyIHNpbmNlIGEg
d2hpbGUgaW4NCj4gb3JkZXIgdG8gbWFrZSBzb21lIGNvbnNpc3RlbnQgY2hvaWNlcyB3aGVyZSBw
b3NzaWJsZS4gSXQgd291bGQgYmUgZ29vZA0KPiB0byBzZWUgeW91ciBjb2RlIGFzIHdlbGwuDQoN
ClllcywgSSBhbSBkZXZlbG9waW5nIGEgUENJZSBkcml2ZXIgZm9yIFNhbXN1bmcgRXh5bm9zIFNv
Q3MuDQpBbHNvLCAyIGRheXMgYWdvLCBJIHN1Ym1pdHRlZCB0aGUgUENJZSBkcml2ZXIuDQoNCmh0
dHA6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtcGNpL21zZzIwNTQ4Lmh0bWwNCmh0dHA6
Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtcGNpL21zZzIwNTQ5Lmh0bWwNCg0KSWYgc29t
ZW9uZSBsb29rIGF0IG15IGNvZGUsIGl0IHdpbGwgYmUgdmVyeSBoZWxwZnVsLg0KVGhhbmsgeW91
IDopDQoNCkJlc3QgcmVnYXJkcywNCkppbmdvbyBIYW4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiANCj4gVGhvbWFzDQo+IC0tDQo+IFRob21hcyBQZXRhenpvbmksIEZyZWUgRWxlY3Ryb25zDQo+
IEtlcm5lbCwgZHJpdmVycywgcmVhbC10aW1lIGFuZCBlbWJlZGRlZCBMaW51eA0KPiBkZXZlbG9w
bWVudCwgY29uc3VsdGluZywgdHJhaW5pbmcgYW5kIHN1cHBvcnQuDQo+IGh0dHA6Ly9mcmVlLWVs
ZWN0cm9ucy5jb20NCg==


