Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0147.outbound.protection.outlook.com ([65.55.169.147]:24576
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752602AbaJXFRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Oct 2014 01:17:30 -0400
From: "Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v2 2/5] PCI: imx6: wait the clocks to stabilize after
 ref_en
Date: Fri, 24 Oct 2014 02:46:11 +0000
Message-ID: <6d4aaceb4c6e4fdbb4dac6ea51953d53@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-3-git-send-email-r65037@freescale.com>
 <CAOMZO5D6_py-OUsz57mcJOdCShQk0jOjJMPD=4VTzj_FoOkMjQ@mail.gmail.com>
In-Reply-To: <CAOMZO5D6_py-OUsz57mcJOdCShQk0jOjJMPD=4VTzj_FoOkMjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gW21h
aWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNCwgMjAx
NCA5OjUxIEFNDQo+IFRvOiBaaHUgUmljaGFyZC1SNjUwMzcNCj4gQ2M6IGxpbnV4LXBjaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IEd1byBTaGF3bi0N
Cj4gUjY1MDczOyBMdWNhcyBTdGFjaDsgVGltIEhhcnZleTsgQmpvcm4gSGVsZ2Fhcw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDIvNV0gUENJOiBpbXg2OiB3YWl0IHRoZSBjbG9ja3MgdG8gc3Rh
YmlsaXplIGFmdGVyDQo+IHJlZl9lbg0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IE9uIFR1ZSwg
U2VwIDIzLCAyMDE0IGF0IDE6MTEgQU0sIFJpY2hhcmQgWmh1IDxyNjUwMzdAZnJlZXNjYWxlLmNv
bT4gd3JvdGU6DQo+ID4gLSBhIHdoaWxlIGRlbGF5IGlzIG1hbmRhdG9yeSByZXF1aXJlZCBhZnRl
ciBwY2llX3JlZl9jbGtfZW4gaXMgc2V0Lg0KPiA+IE90aGVyd2lzZSwgdGhlIHN5c3RlbSB3b3Vs
ZCBiZSBoYW5nIG9uIGlteDZxZGwgYXJkIGJvYXJkcywgYmVjYXVzZQ0KPiA+IHRoYXQgaW14NnFk
bCBib2FyZHMgZG9uJ3QgaGF2ZSB0aGUgcmVzZXRfZ3Bpby4NCj4gPiAtIHRoZSBjbG9ja3Mgc2hv
dWxkIGJlIHN0YWJsZSBhbHJlYWR5IGFmdGVyIHRoZSAiY2xrX3ByZXBhcmVfZW5hYmxlIg0KPiA+
IGlzIHJldHVybi4gU28gSSB0aGluayBpdCdzIG9rIHRvIG1vdmUgdGhlIHVzbGVlcCBkZWxheSBh
ZnRlciB0aGUNCj4gPiBwY2llX3JlZl9lbiBpcyBzZXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSaWNoYXJkIFpodSA8cjY1MDM3QGZyZWVzY2FsZS5jb20+DQo+IA0KPiBUZXN0ZWQtYnk6IEZh
YmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AZnJlZXNjYWxlLmNvbT4NCj4gDQo+IFdpdGhvdXQg
dGhpcyBwYXRjaCB3ZSBub3RpY2UgdGhhdCB0aGUga2VybmVsIGRvZXMgbm90IGJvb3QgYW55bW9y
ZSBzaW5jZQ0KPiBjb21taXQgIDNmY2UwZTg4MmY2MSAoUENJOiBpbXg2OiBEZWxheSBlbmFibGlu
ZyByZWZlcmVuY2UgY2xvY2sgZm9yIFNTIHVudGlsDQo+IGl0IHN0YWJpbGl6ZXMpIG9uIGEgc3lz
dGVtIHRoYXQgZG9lcyBub3QgcGFzcyB0aGUgUENJIGdwaW8gcmVzZXQgaW4gdGhlIGR0Yi4NCj4g
VGhpcyBjYXVzZXMgYSByZWdyZXNzaW9uIG9uIG14NiBuaXRyb2dlbiBib2FyZHMuDQo+IA0KPiBJ
IHdvdWxkIHN1Z2dlc3QgdGhhdCB5b3UgcmVzZW5kIHRoaXMgcGF0Y2ggb25seSBzbyB0aGF0IGl0
IGNvdWxkIGJlIGFwcGxpZWQNCj4gaW50byAzLjE4IGFzIGEgYnVnIGZpeC4NCg0KDQpPa2F5LCBJ
IHdvdWxkIHNlbmQgb3V0IHRoZSBwYXRjaCB0b2RheS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJk
IFpodQ0K
