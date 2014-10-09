Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0113.outbound.protection.outlook.com ([207.46.100.113]:50879
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750705AbaJIFji (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Oct 2014 01:39:38 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: RE: [PATCH v4 10/10] ARM: imx6sx: enable pcie on imx6sx sdb board
Date: Thu, 9 Oct 2014 05:39:36 +0000
Message-ID: <ab53fbcf034b4f79a2942e0ade2df35c@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1412069804-17162-1-git-send-email-r65037@freescale.com>
	<1412069804-17162-11-git-send-email-r65037@freescale.com>
	<CAOMZO5A3Bdxdspc_UnJcQ-DVrmUXQCKW0W08msnDs7TELzXEJg@mail.gmail.com>
	<28E9FA64-81D5-42C2-ABCA-8B72239EC6AA@freescale.com>
	<f11b939d2a1f4d6f823bc36d55eb3d09@DM2PR0301MB0862.namprd03.prod.outlook.com>
 <CAOMZO5DUkM=ao5Fa-DZEjMDNrQJ2rAaBLxuCDjQFNBfTT89eCA@mail.gmail.com>
In-Reply-To: <CAOMZO5DUkM=ao5Fa-DZEjMDNrQJ2rAaBLxuCDjQFNBfTT89eCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gW21h
aWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDA5LCAy
MDE0IDk6MTEgQU0NCj4gVG86IFpodSBSaWNoYXJkLVI2NTAzNw0KPiBDYzogbGludXgtcGNpLW93
bmVyQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgR3VvIFNoYXdu
LQ0KPiBSNjUwNzM7IEx1Y2FzIFN0YWNoOyBUaW0gSGFydmV5DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjQgMTAvMTBdIEFSTTogaW14NnN4OiBlbmFibGUgcGNpZSBvbiBpbXg2c3ggc2RiIGJvYXJk
DQo+IA0KPiBPbiBXZWQsIE9jdCA4LCAyMDE0IGF0IDM6NDEgQU0sIEhvbmctWGluZy5aaHVAZnJl
ZXNjYWxlLmNvbSA8SG9uZy0NCj4gWGluZy5aaHVAZnJlZXNjYWxlLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IFRoaXMgaHVuayBpcyB3cm9uZy4gVGhlcmUgaXMgbm8gInBvd2VyLW9uLWdwaW8iIGluIHRo
ZSBiaW5kaW5nIGFueW1vcmUuDQo+ID4gQWxzbyB0aGVyZSBpcyBhbHJlYWR5IGEgY2hhbmdlIGlu
IFNoYXducyB0cmVlIHRvIG1vZGVsIHRoaXMgYXMgYSBhbHdheXMtb24NCj4gcmVndWxhdG9yLiBJ
ZiB3ZSByZWFsbHkgd2FudCB0byBjb250cm9sIHBjaSBidXMgcG93ZXIgdGhpcyBuZWVkcyB0byBi
ZSBkb25lDQo+IHRocm91Z2ggdGhpcyByZWd1bGF0b3IsIG5vdCBzb21lIGFyYml0cmFyeSBncGlv
IGhhY2suDQo+IA0KPiBZZXMsIEkgbmV2ZXIgYXNrZWQgeW91IHRvIGluY2x1ZGUgJ3Bvd2VyLW9u
LWdwaW8nLiBXaGF0IG5lZWRzIHRvIGJlIGRvbmUgaXMNCj4gdGhlIHNhbWUgYXMgaW4gaW14NnFk
bC1zYWJyZXNkLCB3aGljaCBwYXNzZXMgdGhlIHJlZ3VsYXRvciB0aGF0IHBvd2VycyB0aGUgUENJ
DQo+IHNsb3QuIFlvdSBjYW4gcmVmZXIgdG8gU2hhd24ncyB0cmVlIG9yIGxpbnV4LW5leHQuDQpb
UmljaGFyZF0gVW5kZXJzdGFuZCwgdGhhbmtzIGEgbG90Lg0KDQpCVFcsIHRoZSBlbWFpbCBuYW1l
IGNoYW5nZSBpcyBzdGlsbCBvbi1nb2luZywgd291bGQgYmUgZmluaXNoZWQgbGF0ZXIuDQoNCkJl
c3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0K
