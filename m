Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:47994
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751134AbaIYBXK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Sep 2014 21:23:10 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH v1 4/4] PCI: imx6: add imx6sx pcie support
Date: Thu, 25 Sep 2014 01:23:07 +0000
Message-ID: <5ecf8c18ffa242b993f42ba5c6d542d7@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1411382705-15301-1-git-send-email-r65037@freescale.com>
	<1411382705-15301-5-git-send-email-r65037@freescale.com>
	<CAOMZO5D_s7ST_J0FV+NbrHpw2jVBDSpHprHnwJfPbQ=tqy7PWQ@mail.gmail.com>
	<8f7c463a0c7c4bd2a4a4416bd8b046b3@DM2PR0301MB0862.namprd03.prod.outlook.com>
	<CAOMZO5BQQdVvyh56dO6CWJF23NN17hgsEEeBBzruhjV4FpSyXQ@mail.gmail.com>
	<d61b12831f97408badd1850d6a8782b1@BY1PR0301MB0855.namprd03.prod.outlook.com>
 <CAOMZO5ADM1ig6=+TiQJJVkBMSK6qW_Vf7vYsnW_KKoGcFtmxJg@mail.gmail.com>
In-Reply-To: <CAOMZO5ADM1ig6=+TiQJJVkBMSK6qW_Vf7vYsnW_KKoGcFtmxJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBb
bWFpbHRvOmZlc3RldmFtQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAy
NSwgMjAxNCA1OjEzIEFNDQo+IFRvOiBaaHUgUmljaGFyZC1SNjUwMzcNCj4gQ2M6IGxpbnV4LXBj
aS1vd25lckB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IEd1byBT
aGF3bi0NCj4gUjY1MDczOyBMdWNhcyBTdGFjaA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDQv
NF0gUENJOiBpbXg2OiBhZGQgaW14NnN4IHBjaWUgc3VwcG9ydA0KPiANCj4gT24gVHVlLCBTZXAg
MjMsIDIwMTQgYXQgMTE6NTUgUE0sIEhvbmctWGluZy5aaHVAZnJlZXNjYWxlLmNvbSA8SG9uZy0N
Cj4gWGluZy5aaHVAZnJlZXNjYWxlLmNvbT4gd3JvdGU6DQo+IA0KPiA+PiBXaGF0IGFib3V0IHRo
ZSBleGlzdGluZyBteDZxIHNpbGljb24gdmVyc2lvbj8gSG93IGNhbiB3ZSBmaXggdGhlIGhhbmc/
DQo+ID4gW1JpY2hhcmRdIFRoZXJlIGlzIGFscmVhZHkgb25lIFNXIHdvcmthcm91bmQodG9nZ2xl
IHRoZSBURVNUX1BEIGJpdCBpbg0KPiBhcmNoL2FybS9tYWNoLWlteC9wbS5jKSBmb3IgdGhpcyBp
c3N1ZS4NCj4gPiBJdCBjYW4gd29ya2Fyb3VuZCB0aGlzIGlzc3VlLCBhbHRob3VnaCB3ZSBkb24n
dCBnZXQgZ3VhcmFudGVlIGZyb20gZGVzaWduDQo+IHRlYW0uDQo+IA0KPiBUaGlzIHdvcmthcm91
bmQgaXMgYXZhaWxhYmxlIGluIHRoZSBGU0wga2VybmVsLiBIb3dldmVyLCBJIGFtIGludGVyZXN0
ZWQgaW4gYQ0KPiBzb2x1dGlvbiBmb3IgdGhlIG1haW5saW5lIGtlcm5lbC4NCltSaWNoYXJkXSBJ
TUhPLCBJIGRvbid0IGtub3cgZWl0aGVyLg0KVGhlIFNXIHdvcmthcm91bmQgdXNlZCBpbiB0aGUg
RlNMIGtlcm5lbCBjYW4gd29ya3MsIGJ1dCBpdCBzdGlsbCBjYW4ndCBnZXQgZ3VhcmFudGVlDQpU
aGF0IGl0IGNhbiBmaXggdGhpcyBwcm9ibGVtIGZvciBzdXJlIGZyb20gZGVzaWduIHRlYW0geWV0
Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo=
