Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0105.outbound.protection.outlook.com ([157.56.111.105]:57101
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753380AbaIXCyM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 22:54:12 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: RE: [PATCH v2 1/5] PCI: imx6: enable pcie on imx6qdl sabreauto
Date: Wed, 24 Sep 2014 02:54:07 +0000
Message-ID: <f72dd09d379d4c1b89cc27612afcea77@BY1PR0301MB0855.namprd03.prod.outlook.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	<1411445498-20250-2-git-send-email-r65037@freescale.com>
 <CAOMZO5BuPcw9bJSdLMJ2D=a6EMFMPtKeY352N9-x8dwmRnnfWw@mail.gmail.com>
In-Reply-To: <CAOMZO5BuPcw9bJSdLMJ2D=a6EMFMPtKeY352N9-x8dwmRnnfWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgRmFiaW8NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlv
IEVzdGV2YW0gW21haWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIFNl
cHRlbWJlciAyMywgMjAxNCA4OjQxIFBNDQo+IFRvOiBaaHUgUmljaGFyZC1SNjUwMzcNCj4gQ2M6
IGxpbnV4LXBjaS1vd25lckB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IEd1byBTaGF3bi0NCj4gUjY1MDczOyBMdWNhcyBTdGFjaDsgVGltIEhhcnZleQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDEvNV0gUENJOiBpbXg2OiBlbmFibGUgcGNpZSBvbiBpbXg2cWRs
IHNhYnJlYXV0bw0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IE9uIFR1ZSwgU2VwIDIzLCAyMDE0
IGF0IDE6MTEgQU0sIFJpY2hhcmQgWmh1IDxyNjUwMzdAZnJlZXNjYWxlLmNvbT4gd3JvdGU6DQo+
ID4gLSBlbmFibGUgcGNpZSBvbiBpbXg2cWRsIHNhYnJlYXV0byBib2FyZHMuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8cjY1MDM3QGZyZWVzY2FsZS5jb20+DQo+ID4gLS0t
DQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVhdXRvLmR0c2kgfCA0ICsrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVhdXRvLmR0c2kNCj4gPiBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVhdXRvLmR0c2kNCj4gPiBpbmRleCAwMDlhYmQ2Li5k
NjA0MGE1IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVh
dXRvLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlYXV0by5k
dHNpDQo+ID4gQEAgLTQxMCw2ICs0MTAsMTAgQEANCj4gPiAgICAgICAgIH07DQo+ID4gIH07DQo+
ID4NCj4gPiArJnBjaWUgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0K
PiANCj4gSXQgd291bGQgYmUgYmV0dGVyIGlmIHlvdSBjb3VsZCBwYXNzIHRoZSBQQ0kgcmVzZXQg
cGluIHRoYXQgY29tZXMgZnJvbSB0aGUNCj4gR1BJTyBleHBhbmRlci4NCltSaWNoYXJkXSA2cWRs
IHNhYnJlYXV0byBib2FyZHMgZG9uJ3QgaGF2ZSB0aGUgcGNpZSByZXNldCBncGlvIGluIHRoZSBi
b2FyZCBkZXNpZ24gYXQgYWxsLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo=
