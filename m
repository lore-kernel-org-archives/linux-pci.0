Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0104.outbound.protection.outlook.com ([207.46.100.104]:61381
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751082AbaJVCe2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Oct 2014 22:34:28 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <richard.zhu@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>
Subject: RE: [PATCH v8]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl
 sabreauto.
Date: Wed, 22 Oct 2014 02:34:25 +0000
Message-ID: <470caee511cb48188d6a53c8308ce79f@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
 <1413879507.2751.1.camel@pengutronix.de>
 <66d89550a8de45f89b50c1862a35394f@DM2PR0301MB0862.namprd03.prod.outlook.com>
 <CAErSpo5ZkyPNY6SBxu6pZBEpDSW_V5H6g3=EX3dme3W0ehbG8A@mail.gmail.com>
In-Reply-To: <CAErSpo5ZkyPNY6SBxu6pZBEpDSW_V5H6g3=EX3dme3W0ehbG8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQmpvcm46DQoNClRoZSBuYW1lIEhvbmctWGluZy5aaHUgd291bGQgYmUgZGlzY2FyZGVkLiBS
ZXF1ZXN0IGhhZCBiZWVuIGlzc3VlIHRvIElUIHRlYW0sDQogYnV0IHRpbWUgaXMgcmVxdWlyZWQg
Zm9yIElUIHRvIG1ha2UgaXQgZWZmZWN0aXZlIGluIGFib3V0IDQ4aG91cnMgYmVoaW5kLg0KU29y
cnkgdG8gYnJpbmcgYW55IGluY29udmVuaWVuY2VzIGJ5IHRoZSBkaWZmZXJlbnQgbmFtZXMuDQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEJqb3JuIEhlbGdhYXMgW21haWx0bzpiaGVsZ2Fhc0Bnb29nbGUuY29tXQ0K
PiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIxLCAyMDE0IDExOjM4IFBNDQo+IFRvOiBaaHUgUmlj
aGFyZC1SNjUwMzcNCj4gQ2M6IEx1Y2FzIFN0YWNoOyBSaWNoYXJkIFpodTsgbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgR3VvIFNoYXduLVI2NTA3MzsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyB0
aGFydmV5QGdhdGV3b3Jrcy5jb207IG0ta2FyaWNoZXJpMkB0aS5jb20NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2OF1QQ0k6IGlteDY6IGVuYWJsZSBwY2llIG9uIGlteDZzeCBzZGIgYW5kIGlteDZx
ZGwNCj4gc2FicmVhdXRvLg0KPiANCj4gT24gVHVlLCBPY3QgMjEsIDIwMTQgYXQgMzo1NCBBTSwg
SG9uZy1YaW5nLlpodUBmcmVlc2NhbGUuY29tIDxIb25nLQ0KPiBYaW5nLlpodUBmcmVlc2NhbGUu
Y29tPiB3cm90ZToNCj4gPiAuLi4NCj4gPiBSaWNoYXJkIFpodQ0KPiANCj4gQ2FuIHlvdSBwbGVh
c2Ugc3RyYWlnaHRlbiBvdXQgdGhpcyBIb25nLVhpbmcuWmh1IHZzLiBSaWNoYXJkIFpodSB0aGlu
Zz8gIEl0IGlzDQo+IHJlYWxseSBhIGhhc3NsZSB0byBkZWFsIHdpdGggbXVsdGlwbGUgbmFtZXMg
Zm9yIG9uZSBwZXJzb24uDQo+IA0KPiBCam9ybg0K
