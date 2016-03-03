Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0087.outbound.protection.outlook.com ([157.55.234.87]:64512
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750896AbcCCFV7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Mar 2016 00:21:59 -0500
From: Richard Zhu <hongxing.zhu@nxp.com>
To: "chf.fritz@googlemail.com" <chf.fritz@googlemail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
CC: Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 0/2] Add PCIe driver support for imx6sx
Date: Thu, 3 Mar 2016 01:46:02 +0000
Message-ID: <DBXPR04MB2708AB0A3F95E78580FC7408CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
 <1456969281.2246.0.camel@googlemail.com>
In-Reply-To: <1456969281.2246.0.camel@googlemail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RvcGggRnJpdHogW21h
aWx0bzpjaGYuZnJpdHpAZ29vZ2xlbWFpbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAw
MywgMjAxNiA5OjQxIEFNDQo+IFRvOiBSaWNoYXJkIFpodTsgU2hhd24gR3VvOyBMdWNhcyBTdGFj
aA0KPiBDYzogRmFiaW8gRXN0ZXZhbTsgQmpvcm4gSGVsZ2FhczsgTGVlIEpvbmVzOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8yXSBBZGQgUENJZSBkcml2ZXIgc3VwcG9y
dCBmb3IgaW14NnN4DQo+IA0KPiAqcGluZyoNCj4gDQo+IE9uIFRodSwgMjAxNi0wMi0yNSBhdCAx
NTo0NyArMDEwMCwgQ2hyaXN0b3BoIEZyaXR6IHdyb3RlOg0KPiA+IHYzOg0KPiA+ICAqIGFkYXB0
IGRldmljZXRyZWUgYmluZGluZ3MgZG9jdW1lbnRhdGlvbiBmc2wsaW14NnEtcGNpZS50eHQNCj4g
PiB2MjoNCj4gPiAgKiBsZWF2ZSBvdXQgcmVndWxhdG9yIGhhbmRsaW5nIGZyb20gZHJpdmVyLCB3
aWxsIGJlIGRvbmUgbGF0ZXINCj4gPiAgICBpbiBQTSBzdWJzeXN0ZW0NCj4gPiAgKiB1c2UgQklU
KCkgbWFjcm8gZm9yIE1GRA0KPiA+DQo+ID4gQ2hyaXN0b3BoIEZyaXR6ICgyKToNCj4gPiAgIE1G
RDogaW14NnN4OiBBZGQgUENJZSByZWdpc3RlciBkZWZpbml0aW9ucyBmb3IgaW9tdXhjIGdwcg0K
PiA+ICAgUENJOiBpbXg2OiBhZGQgaW5pdGlhbCBpbXg2c3ggc3VwcG9ydA0KPiA+DQo+ID4gIC4u
Li9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS50eHQgICAgIHwgICA2ICst
DQo+ID4gIGRyaXZlcnMvcGNpL2hvc3QvcGNpLWlteDYuYyAgICAgICAgICAgICAgICAgICAgICAg
IHwgMTMwICsrKysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9zeXNj
b24vaW14NnEtaW9tdXhjLWdwci5oICAgICAgICB8ICAgNSArDQo+ID4gIDMgZmlsZXMgY2hhbmdl
ZCwgMTAxIGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiANCltaaHUg
aG9uZ3hpbmddIEhpIENocmlzdG9waDoNCkknbSBva2F5IHdpdGggdGhpcyBwYXRjaC1zZXQuIEhv
cGUgdGhlIHJlZ3VsYXRvciBoYW5kaW5nIHBhdGNoIG1hbmRhdG9yeSByZXF1aXJlZCBieSBpbXg2
c3ggcGNpZQ0KaXMgbWVyZ2VkIGluIFBNIHN5c3RlbSBhc2FwLiA6KS4NClRoYW5rcy4NClJpY2hh
cmQNCg==
