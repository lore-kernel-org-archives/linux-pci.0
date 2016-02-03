Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0070.outbound.protection.outlook.com ([104.47.2.70]:1728
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932217AbcBCCZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 21:25:32 -0500
From: Minghuan Lian <minghuan.lian@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Roy Zang <roy.zang@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCH 1/4] ARM: dts: ls1021a: add PCIe dts node
Date: Wed, 3 Feb 2016 02:11:06 +0000
Message-ID: <VI1PR04MB16159CDCE9C134363846F4CAE8D00@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com>
 <VI1PR04MB1615DCF54369ED2E01234E64E8DF0@VI1PR04MB1615.eurprd04.prod.outlook.com>
 <6117401.iajrHOL4Mn@wuerfel>
In-Reply-To: <6117401.iajrHOL4Mn@wuerfel>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQXJuZCwNCg0KSSBhbSBzb3JyeS4NCk90aGVyIHBhdGNoZXMgYXJlIGZvciBNU0kgdGVzdCwg
YW5kIG5vdCBuZWVkIHRvIGJlIHN1bW1pdGVkLg0KVGhlcmUgaXMgb25seSBvbmUgcGF0Y2gsIHNo
b3VsZCBiZSBbMS8xXSBub3QgWzEvNF0uICBJIGZvcmdvdCB0byByZW1vdmUgIjEvNCIgOigNClNo
b3VsZCBJIHJlLXN1bW1pdCB0byBmaXggaXQ/DQoNClRoYW5rcywNCk1pbmdodWFuDQoNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWlsdG86
YXJuZEBhcm5kYi5kZV0NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMDIsIDIwMTYgNTozMiBQ
TQ0KPiBUbzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBNaW5n
aHVhbiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPGtl
cm5lbEBwZW5ndXRyb25peC5kZT47DQo+IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsgU3R1
YXJ0IFlvZGVyIDxzdHVhcnQueW9kZXJAbnhwLmNvbT47DQo+IFlhbmctTGVvIExpIDxsZW95YW5n
LmxpQG54cC5jb20+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsNCj4gTWlu
Z2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0g
QVJNOiBkdHM6IGxzMTAyMWE6IGFkZCBQQ0llIGR0cyBub2RlDQo+IA0KPiBPbiBUdWVzZGF5IDAy
IEZlYnJ1YXJ5IDIwMTYgMDg6NDg6MzYgTWluZ2h1YW4gTGlhbiB3cm90ZToNCj4gPiBIaSBTaGF3
biwNCj4gPg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgaGVscCB0byByZXZpZXcgdGhlIHBhdGNoPyAg
VGhhbmsgeW91IHZlcnkgbXVjaC4NCj4gPiBUaGVyZSBpcyBvbmx5IG9uZSBwYXRjaCBub3QgYSBz
ZXQgb2YgcGF0Y2gsIHBsZWFzZSBpZ25vcmUgWzEvNF0NCj4gPg0KPiA+IEFybmQgaGFzIGdpdmVu
IGEgYWNrLg0KPiANCj4gRm9yIHNvbWUgcmVhc29uLCBJIGRpZCBub3QgZ2V0IHRoZSBvdGhlciB0
aHJlZSBwYXRjaGVzIHRob3VnaCwgSSB3YXMgZ29pbmcgdG8NCj4gbG9vayBhdCB0aGVtLCBidXQg
SSBjYW4ndCB0ZWxsIGlmIHRoaXMgd2FzIGEgc2VyaWVzIG9mIHBhdGNoZXMgZG9pbmcgUENJIHN1
cHBvcnQsIG9yDQo+IHBhdGNoZXMgZG9pbmcgb3RoZXIgZHRzIGNoYW5nZXMuDQo+IA0KPiBJZiB5
b3UgaGF2ZSBhZGRpdGlvbmFsIHBhdGNoZXMgZm9yIHRoZSBQQ0kgZHJpdmVyLCBsZXQncyByZXZp
ZXcgaXQgYWxsIHRvZ2V0aGVyIGZpcnN0Lg0KPiANCj4gCUFybmQNCg==
