Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:47006
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754538AbdHYGvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Aug 2017 02:51:32 -0400
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, "Roy Zang" <roy.zang@nxp.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Subject: RE: [PATCHv4 4/9] PCI: layerscape: refactor the host_init function
Date: Fri, 25 Aug 2017 06:51:28 +0000
Message-ID: <AM5PR0402MB277172B53A21C895EFB70BF1849B0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
 <20170823060856.9387-5-Zhiqiang.Hou@nxp.com>
 <20170824171206.GP31858@bhelgaas-glaptop.roam.corp.google.com>
 <AM5PR0402MB27710E17C1F6C33BC6985C22849B0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
 <20170825042252.GA28480@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170825042252.GA28480@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE35bm0OOaciDI15pelIDEyOjIzDQo+IFRvOiBaLnEu
IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBqaW5nb29oYW4xQGdtYWlsLmNvbTsgSm9hby5Q
aW50b0BzeW5vcHN5cy5jb207IE0uaC4gTGlhbg0KPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsg
TWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFphbmcNCj4gPHJveS56YW5nQG54
cC5jb20+OyBzdmFyYmFub3ZAbW0tc29sLmNvbTsgbmlrbGFzLmNhc3NlbEBheGlzLmNvbTsNCj4g
amVzcGVyLm5pbHNzb25AYXhpcy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSHY0IDQvOV0gUENJ
OiBsYXllcnNjYXBlOiByZWZhY3RvciB0aGUgaG9zdF9pbml0IGZ1bmN0aW9uDQo+IA0KPiBPbiBG
cmksIEF1ZyAyNSwgMjAxNyBhdCAwMzoxNjozNkFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4g
PiBIaSBCam9ybiwNCj4gPg0KPiA+IFRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCj4g
Pg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJqb3JuIEhl
bGdhYXMgW21haWx0bzpoZWxnYWFzQGtlcm5lbC5vcmddDQo+ID4gPiBTZW50OiAyMDE35bm0OOac
iDI15pelIDE6MTINCj4gPiA+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+
ID4gPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gPiA+IGppbmdvb2hhbjFAZ21haWwuY29tOyBKb2FvLlBpbnRvQHN5bm9wc3lzLmNvbTsgTS5o
LiBMaWFuDQo+ID4gPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2th
aS5odUBueHAuY29tPjsgUm95IFphbmcNCj4gPiA+IDxyb3kuemFuZ0BueHAuY29tPjsgc3ZhcmJh
bm92QG1tLXNvbC5jb207IG5pa2xhcy5jYXNzZWxAYXhpcy5jb207DQo+ID4gPiBqZXNwZXIubmls
c3NvbkBheGlzLmNvbQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSHY0IDQvOV0gUENJOiBsYXll
cnNjYXBlOiByZWZhY3RvciB0aGUgaG9zdF9pbml0DQo+ID4gPiBmdW5jdGlvbg0KPiA+ID4NCj4g
PiA+IE9uIFdlZCwgQXVnIDIzLCAyMDE3IGF0IDAyOjA4OjUxUE0gKzA4MDAsIFpoaXFpYW5nIEhv
dSB3cm90ZToNCj4gPiA+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNv
bT4NCj4gPiA+ID4NCj4gPiA+ID4gTWFrZSB0aGUgbHMxMDIxYSdzIGhvc3RfaW5pdCByZXVzZSBs
YXllcnNjYXBlIHBsYXRmb3JtJ3MgY29tbW9uDQo+ID4gPiA+IGhvc3RfaW5pdCBmdW5jdGlvbi4N
Cj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGRvZXMgdHdvIHRoaW5nczoNCj4gPiA+DQo+ID4gPiAg
IDEpIE1vdmVzIGxzMTAyMV9wY2llX2hvc3RfaW5pdCgpIHRvIGEgZGlmZmVyZW50IHBsYWNlIGlu
IHRoZSBmaWxlDQo+ID4gPiAgIDIpIENhbGxzIGxzX3BjaWVfaG9zdF9pbml0KCkgaW5zdGVhZCBv
ZiByZXBlYXRpbmcgdGhhdCBjb2RlIGluDQo+ID4gPiAgICAgIGxzMTAyMV9wY2llX2hvc3RfaW5p
dCgpDQo+ID4gPg0KPiA+ID4gVGhvc2Ugc2hvdWxkIGJlIHNlcGFyYXRlIHBhdGNoZXMgc28gdGhl
eSdyZSBlYXNpZXIgdG8gcmV2aWV3Lg0KPiA+ID4NCj4gPiA+IE9yIGlmIHlvdSBkb24ndCByZWFs
bHkgbmVlZCB0byBtb3ZlIGxzMTAyMV9wY2llX2hvc3RfaW5pdCgpIHRvIGENCj4gPiA+IGRpZmZl
cmVudCBwbGFjZSwgdGhhdCB3b3VsZCBiZSBldmVuIGVhc2llci4NCj4gPg0KPiA+IE1vdmVkIGxz
MTAyMV9wY2llX2hvc3RfaW5pdCgpIHRvIHRoaXMgcGxhY2UgYmVoYW5kIHRoZSBmdW5jDQo+IGxz
X3BjaWVfaG9zdF9pbml0IGlzIHRvIGNhbGwgbHNfcGNpZV9ob3N0X2luaXQgd2l0aG91dCBhZGRp
bmcgYSBkZWNsYXJhdGlvbiBvZiBpdC4NCj4gSXMgaXQgbmVjZXNzYXJ5IHRvIHNlcGFyYXRlIGl0
Pw0KPiANCj4gWWVzLCBwbGVhc2UuICBJIHdhbnQgdG8gc2VlIG9uZSBwYXRjaCB0aGF0ICpvbmx5
KiBtb3ZlcyB0aGUgZnVuY3Rpb24gKGFuZA0KPiBtZW50aW9ucyB3aHkgeW91J3JlIG1vdmluZyBp
dCkgYW5kIGFub3RoZXIgdGhhdCAqb25seSogY2FsbHMNCj4gbHNfcGNpZV9ob3N0X2luaXQoKSBp
bnN0ZWFkIG9mIHJlcGVhdGluZyB0aGF0IGNvZGUgaW4gbHMxMDIxX3BjaWVfaG9zdF9pbml0KCku
DQo+IFRoYXQgd2F5LCBib3RoIHBhdGNoZXMgYXJlIHRyaXZpYWwgdG8gcmV2aWV3LiAgVGhlIGNv
bWJpbmVkIG9uZSBpcyBub3QgdHJpdmlhbA0KPiB0byByZXZpZXcuDQoNCkdvdCBpdCwgd2lsbCBz
ZXBhcmF0ZSBpdCBpbiBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNClpoaXFpYW5nDQo=
