Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:64758
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752360AbdHICvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Aug 2017 22:51:06 -0400
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
CC: "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, "Roy Zang" <roy.zang@nxp.com>
Subject: RE: [PATCHv2 2/6] PCI: designware: enable write permission before
 updating class code
Date: Wed, 9 Aug 2017 02:51:02 +0000
Message-ID: <AM5PR0402MB27711A696D80EA72F60BF8EB848B0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-3-git-send-email-Zhiqiang.Hou@nxp.com>
 <20d204aa-027f-6d90-7eeb-b9c86d62df62@synopsys.com>
In-Reply-To: <20d204aa-027f-6d90-7eeb-b9c86d62df62@synopsys.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgSm9hbywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGFjayENCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FvIFBpbnRvIFttYWlsdG86Sm9hby5QaW50b0BzeW5v
cHN5cy5jb21dDQo+IFNlbnQ6IDIwMTflubQ45pyIOOaXpSAyMDo0Ng0KPiBUbzogWi5xLiBIb3Ug
PHpoaXFpYW5nLmhvdUBueHAuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IEpvYW8uUGludG9Ac3lub3Bz
eXMuY29tDQo+IENjOiBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkg
SHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47DQo+IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIdjIgMi82XSBQQ0k6IGRlc2lnbndhcmU6IGVuYWJsZSB3cml0
ZSBwZXJtaXNzaW9uIGJlZm9yZQ0KPiB1cGRhdGluZyBjbGFzcyBjb2RlDQo+IA0KPiDDgHMgOToy
MyBBTSBkZSA4LzMvMjAxNywgWmhpcWlhbmcgSG91IGVzY3JldmV1Og0KPiA+IEZyb206IEhvdSBa
aGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBUaGUgZXhpc3RpbmcgZml4
IGRvZXNuJ3QgYWN0dWFsbHkgd29yayBiZWNhdXNlIHRoZSBDbGFzcyByZWdpc3RlciBpcw0KPiA+
IHJlYWQtb25seSwgc28gaXQgbXVzdCBlbmFibGUgdGhlIHdyaXRlIHBlcm1pc3Npb24gYmVmb3Jl
IHdyaXRlIHRoZQ0KPiA+IGNvcnJlY3QgdmFsdWUgdG8gdGhpcyByZWdpc3Rlci4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gVjI6DQo+ID4gIC0gTm9uZQ0KPiA+DQo+ID4gIGRyaXZlcnMvcGNpL2R3Yy9wY2ll
LWRlc2lnbndhcmUtaG9zdC5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNp
Z253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0
LmMNCj4gPiBpbmRleCBkMjljMDIwLi42ZTEwY2RhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvZHdj
L3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBAQCAtNjM0LDggKzYzNCwxMiBAQCB2b2lkIGR3
X3BjaWVfc2V0dXBfcmMoc3RydWN0IHBjaWVfcG9ydCAqcHApDQo+ID4NCj4gPiAgCWR3X3BjaWVf
d3Jfb3duX2NvbmYocHAsIFBDSV9CQVNFX0FERFJFU1NfMCwgNCwgMCk7DQo+ID4NCj4gPiArCS8q
IEVuYWJsZSB3cml0ZSBwZXJtaXNzaW9uIGZvciB0aGUgREJJIHJlYWQtb25seSByZWdpc3RlciAq
Lw0KPiA+ICsJZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNpKTsNCj4gPiAgCS8qIHByb2dyYW0gY29y
cmVjdCBjbGFzcyBmb3IgUkMgKi8NCj4gPiAgCWR3X3BjaWVfd3Jfb3duX2NvbmYocHAsIFBDSV9D
TEFTU19ERVZJQ0UsIDIsDQo+IFBDSV9DTEFTU19CUklER0VfUENJKTsNCj4gPiArCS8qIEJldHRl
ciBkaXNhYmxlIHdyaXRlIHBlcm1pc3Npb24gcmlnaHQgYWZ0ZXIgdGhlIHVwZGF0ZSAqLw0KPiA+
ICsJZHdfcGNpZV9kYmlfcm9fd3JfZGlzKHBjaSk7DQo+ID4NCj4gPiAgCWR3X3BjaWVfcmRfb3du
X2NvbmYocHAsIFBDSUVfTElOS19XSURUSF9TUEVFRF9DT05UUk9MLCA0LA0KPiAmdmFsKTsNCj4g
PiAgCXZhbCB8PSBQT1JUX0xPR0lDX1NQRUVEX0NIQU5HRTsNCj4gPg0KPiANCj4gQWNrZWQtQnk6
IEpvYW8gUGludG8gPGpwaW50b0BzeW5vcHN5cy5jb20+DQoNCi0gWmhpcWlhbmcNCg==
