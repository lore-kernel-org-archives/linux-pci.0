Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0118.outbound.protection.outlook.com ([65.55.169.118]:15120
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751570AbaJKIsi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 11 Oct 2014 04:48:38 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <richard.zhu@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: RE: [PATCH v5 9/9] ARM: imx6sx: enable pcie on imx6sx sdb board
Date: Sat, 11 Oct 2014 08:48:34 +0000
Message-ID: <740aab02e8d94b2a918aab44a188443e@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
	<1412919676-25344-10-git-send-email-richard.zhu@freescale.com>
 <CAOMZO5ByYLX4O0-YZdU3XE0A8sE3D9QG34nq4x9B2uQzsv3P2g@mail.gmail.com>
In-Reply-To: <CAOMZO5ByYLX4O0-YZdU3XE0A8sE3D9QG34nq4x9B2uQzsv3P2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gW21h
aWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMCwgMjAx
NCAxMDo1MSBQTQ0KPiBUbzogUmljaGFyZCBaaHUNCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IEd1byBTaGF3bi1SNjUwNzM7IEx1Y2FzIFN0YWNoOyBUaW0gSGFydmV5OyBaaHUNCj4g
UmljaGFyZC1SNjUwMzcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA5LzldIEFSTTogaW14NnN4
OiBlbmFibGUgcGNpZSBvbiBpbXg2c3ggc2RiIGJvYXJkDQo+IA0KPiBPbiBGcmksIE9jdCAxMCwg
MjAxNCBhdCAyOjQxIEFNLCBSaWNoYXJkIFpodSA8cmljaGFyZC56aHVAZnJlZXNjYWxlLmNvbT4g
d3JvdGU6DQo+IA0KPiA+ICsgICAgICAgICAgICAgICBwaW5jdHJsX3BjaWU6IHBjaWVncnAgew0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZzbCxwaW5zID0gPA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTVg2U1hfUEFEX0VORVQxX0NPTF9fR1BJTzJfSU9fMCAweDE3
MDU5DQo+IA0KPiBXaHkgMHgxNzA1OSBpbnN0ZWFkIG9mIHRoZSBkZWZhdWx0IDB4MTBiMD8NCltS
aWNoYXJkXSBJIHJlLXVzZSB0aGUgcGFkIGNmZyB1c2VkIGJ5IHVzZGhjLCBpdCdzIHdvdWxkIGJl
IGxpdHRlciBmYXN0ZXIuDQpBbnl3YXksIGRlZmF1bHQgdmFsdWUgd291bGQgYmUgdXNlZCBsYXRl
ci4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPjsNCj4gPiArICAgICAgICAgICAg
ICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHBpbmN0cmxfcGNpZV9yZWc6IHBjaWVy
ZWdncnAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZzbCxwaW5zID0gPA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVg2U1hfUEFEX0VORVQxX0NSU19fR1BJTzJf
SU9fMSAweDE3MDU5DQo+IA0KPiBTYW1lIGhlcmUuDQpbUmljaGFyZF0gT2ssIGRlZmF1bHQgdmFs
dWUgd291bGQgYmUgdXNlZCBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo=
