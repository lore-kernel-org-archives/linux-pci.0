Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8544 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab3FLHMI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2013 03:12:08 -0400
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Mike Turquette' <mturquette@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>
CC: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"olof@lixom.net" <olof@lixom.net>, Hiroshi Doyu <hdoyu@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Juha Tukkinen <jtukkinen@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Date: Wed, 12 Jun 2013 12:41:38 +0530
Subject: RE: [PATCH V3 1/4] ARM: tegra30: clocks: Fix pciex clock
 registration
Message-ID: <C79B248886DD134989C8FF6B096A91AB91CF1615C6@BGMAIL01.nvidia.com>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <51AE3B18.9010604@wwwdotorg.org> <20130611221709.8816.15602@quantum>
In-Reply-To: <20130611221709.8816.15602@quantum>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBRdW90aW5nIFN0ZXBoZW4gV2FycmVuICgyMDEzLTA2LTA0IDEyOjA4OjA4KQ0KPiA+IE9uIDA2
LzA0LzIwMTMgMTI6NTcgUE0sIEpheSBBZ2Fyd2FsIHdyb3RlOg0KPiA+ID4gUmVnaXN0ZXJpbmcg
cGNpZXggYXMgcGVyaXBoZXJhbCBjbG9jayBpbnN0ZWFkIG9mIGZpeGVkIGNsb2NrIGFzDQo+ID4g
PiB0ZWdyYV9wZXJpaF9yZXNldF9hc3NlcnQoZGVhc3NlcnQpIGFwaSBvZiB0aGlzIGNsb2NrIGFw
aSBnaXZlcw0KPiA+ID4gd2FybmluZyBhbmQgdWx0aW1hdGVseSBkb2VzIG5vdCBzdWNjZWVkIHRv
IGFzc2VydChkZWFzc2VydCkuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmF5IEFnYXJ3
YWwgPGphZ2Fyd2FsQG52aWRpYS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IFBhdGNoIGlzIGJhc2Vk
IG9uIHJlbW90ZXMvZ2l0b3Jpb3VzX3RoaWVycnlyZWRpbmdfbGludXgvdGVncmEvbmV4dCBhbmQN
Cj4gc2hvdWxkIGJlIGFwcGxpZWQgb24gdG9wIG9mIHRoaXMuDQo+ID4NCj4gPiBGb3IgdGhpcyBj
aGFuZ2UsIE1pa2UgbWF5IGFzIHdlbGwgYXBwbHkgaXQgZGlyZWN0bHkgdG8gdGhlIGNsb2NrIHRy
ZWUuDQo+ID4gVGhpZXJyeSBjYW4gdGhlbiBwaWNrIGl0IHVwIHdoZW4gaGUgcmViYXNlcyBoaXMg
dGVncmEvbmV4dCB0cmVlLg0KPiA+DQo+ID4gVGhhdCBzYWlkLCBJIGRvbid0IHRoaW5rIHlvdSBz
aG91bGQgbmVlZCBhbnkgb2YgdGhlDQo+ID4gVEVHUkFfQ0xLX0RVUExJQ0FURSgpIGVudHJpZXM7
IHRoZSBQQ0llIGRyaXZlciBzaG91bGQgZ2V0IGl0cyBjbG9ja3MNCj4gPiBmcm9tIGRldmljZSB0
cmVlIG5vdywgYW5kIGhlbmNlIHRoZSBkcml2ZXIgbmFtZSBpbiB0aGUgY2xvY2sNCj4gPiByZWdp
c3RyYXRpb24gc2hvdWxkbid0IGJlIG5lY2Vzc2FyeS4gQWxsIG9mIHRoZXNlDQo+ID4gVEVHUkFf
Q0xLX0RVUExJQ0FURSgpIGVudHJpZXMgc2hvdWxkIGJlIHJlbW92ZWQgZW4gbWFzcyBzb21ldGlt
ZQ0KPiBzb29uDQo+ID4gd2l0aCBsdWNrLiBTbywgY2FuIHlvdSBzaW1wbHkgbGVhdmUgdGhlIHR3
byBURUdSQV9DTEtfRFVQTElDQVRFKCkNCj4gPiBlbnRyaWVzIHVudG91Y2hlZCwgcmF0aGVyIHRo
YW4gY2hhbmdpbmcgdGhlbT8NCj4gDQo+IFBpbmcgb24gdGhpcyBwYXRjaC4gIEkgY2FuIHRha2Ug
aXQgdGhyb3VnaCBteSB0cmVlLCBidXQgaXMgdGhlcmUgZ29pbmcgdG8gYmUNCj4gcmV3b3JrIGJh
c2VkIG9uIFN0ZXBoZW4ncyBjb21tZW50cz8NCg0KSGkgTWlrZSwNCkkgaGF2ZSB1cGxvYWRlZCBu
ZXh0IHZlcnNpb24gVjQgb2YgdGhpcyBwYXRjaCBhZnRlciB0YWtpbmcgY2FyZSBvZiB0aGlzIGNv
bW1lbnQuDQo=
