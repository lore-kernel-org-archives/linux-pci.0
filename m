Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:55437
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751665AbbDPBPU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 21:15:20 -0400
From: "Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"Stuart Yoder" <stuart.yoder@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] irqchip/gicv3-its: Decrease page size when needed
Date: Thu, 16 Apr 2015 01:15:17 +0000
Message-ID: <DM2PR0301MB06407F457016250193B6E9D3E2E40@DM2PR0301MB0640.namprd03.prod.outlook.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <20150415115118.GN18660@io.lakedaemon.net>
 <8ba82758f57122dd360b2e6fac8040fc@www.loen.fr>
In-Reply-To: <8ba82758f57122dd360b2e6fac8040fc@www.loen.fr>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgTWFyYywNCg0KT0ssIEkgd2lsbCBmb2xsb3cgeW91ciBjb21tZW50Lg0KDQpUaGFua3MsDQpN
aW5naHVhbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnlu
Z2llciBbbWFpbHRvOm1hcmMuenluZ2llckBhcm0uY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIEFw
cmlsIDE1LCAyMDE1IDEwOjE3IFBNDQo+IFRvOiBKYXNvbiBDb29wZXI7IExpYW4gTWluZ2h1YW4t
QjMxOTM5DQo+IENjOiBBcm5kIEJlcmdtYW5uOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBI
dSBNaW5na2FpLUIyMTI4NDsgWmFuZw0KPiBSb3ktUjYxOTExOyBZb2RlciBTdHVhcnQtQjA4MjQ4
OyBXb29kIFNjb3R0LUIwNzQyMTsgQmpvcm4gSGVsZ2FhczsgbGludXgtDQo+IGFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpcnFjaGlwL2dpY3Yz
LWl0czogRGVjcmVhc2UgcGFnZSBzaXplIHdoZW4gbmVlZGVkDQo+IA0KPiBPbiAyMDE1LTA0LTE1
IDEyOjUxLCBKYXNvbiBDb29wZXIgd3JvdGU6DQo+ID4gTWluZ2h1YW4gTGlhbiwNCj4gPg0KPiA+
IE9uIFdlZCwgQXByIDE1LCAyMDE1IGF0IDA1OjQ5OjIyUE0gKzA4MDAsIE1pbmdodWFuIExpYW4g
d3JvdGU6DQo+ID4+IFRoZSBkZWZhdWx0IHBhZ2Ugc2l6ZSBvZiBJVFMgdGFibGUgaGFzIGJlZW4g
Y2hhbmdlZCB0byA2NEtCLCBidXQgZm9yDQo+ID4+IHNvbWUgcGxhdGZvcm1zIHRoZSByZWFsIHNp
emUgb2YgYWxsb2NhdGUgbWVtb3J5IHdoaWNoIGNhbGN1bGF0ZWQgYnkNCj4gPj4gREVWQklUUyBv
ZiByZWdpc3RlciBHSVRTX1RZUEVSIG1heSBzbWFsbGVyIHRoYW4gZGVmYXVsdCBzaXplLiBJbiB0
aGlzDQo+ID4+IGNhc2UsIHBzeiBtdXN0IGJlIGRlY3JlYXNlZCwgb3RoZXJ3aXNlLCB0aGUgd3Jv
bmcgcGFnZSBudW1iZXIgd2lsbA0KPiA+PiBjYXVzZSBrZXJuZWwgaGFuZy4NCj4gPj4NCj4gPj4g
U2lnbmVkLW9mZi1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBmcmVlc2NhbGUuY29t
Pg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy5jIHwgMyAr
KysNCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IFBsZWFz
ZSBydW4gc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBvbiB5b3VyIHBhdGNoZXMgYmVmb3JlIHNl
bmRpbmcuDQo+ID4gVGhpcw0KPiA+IG5lZWRzIHRvIGJlIHNlbnQgdG8gbXlzZWxmIGFuZCBUaG9t
YXMgR2xlaXhuZXIgZm9yIHJldmlldy4NCj4gDQo+IFBsZWFzZSBhbHNvIENDIG1lIG9uIGFueXRo
aW5nIHRoYXQgdG91Y2hlcyBHSUN2MyBvciB0aGUgSVRTIGNvZGUuDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiAgICAgICAgICBNLg0KPiAtLQ0KPiBGYXN0LCBjaGVhcCwgcmVsaWFibGUuIFBpY2sgdHdv
Lg0K
