Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0074.outbound.protection.outlook.com ([104.47.2.74]:20304
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbdHPFTM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 01:19:12 -0400
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, "Roy Zang" <roy.zang@nxp.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        "Jesper Nilsson" <jesper.nilsson@axis.com>
Subject: RE: [PATCHv2 4/6] PCI: layerscape: refactor the host_init function
Date: Wed, 16 Aug 2017 05:19:09 +0000
Message-ID: <AM5PR0402MB27711A9E4C99CE353A712AEB84820@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-5-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170814213824.GJ32525@bhelgaas-glaptop.roam.corp.google.com>
 <20170814222605.GK32525@bhelgaas-glaptop.roam.corp.google.com>
 <f74fb76f-4797-7d80-703b-440bc9c831dd@mm-sol.com>
In-Reply-To: <f74fb76f-4797-7d80-703b-440bc9c831dd@mm-sol.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgU3RhbmltaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3Rh
bmltaXIgVmFyYmFub3YgW21haWx0bzpzdmFyYmFub3ZAbW0tc29sLmNvbV0NCj4gU2VudDogMjAx
N+W5tDjmnIgxNeaXpSAxNzozNA0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwu
b3JnPjsgWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gamluZ29vaGFuMUBnbWFpbC5j
b207IEpvYW8uUGludG9Ac3lub3BzeXMuY29tOyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5A
bnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IFJveSBaYW5nDQo+IDxy
b3kuemFuZ0BueHAuY29tPjsgTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEBheGlzLmNvbT47
IEplc3BlciBOaWxzc29uDQo+IDxqZXNwZXIubmlsc3NvbkBheGlzLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSHYyIDQvNl0gUENJOiBsYXllcnNjYXBlOiByZWZhY3RvciB0aGUgaG9zdF9pbml0
IGZ1bmN0aW9uDQo+IA0KPiBIaSBCam9ybiwNCj4gDQo+IE9uIDA4LzE1LzIwMTcgMDE6MjYgQU0s
IEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gWytjYyBTdGFuaW1pciwgTmlrbGFzLCBKZXNwZXJd
DQo+ID4NCj4gPiBPbiBNb24sIEF1ZyAxNCwgMjAxNyBhdCAwNDozODoyNFBNIC0wNTAwLCBCam9y
biBIZWxnYWFzIHdyb3RlOg0KPiA+PiBPbiBUaHUsIEF1ZyAwMywgMjAxNyBhdCAwNDoyMzozOFBN
ICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+ID4+PiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KPiA+Pj4NCj4gPj4+IE1ha2UgdGhlIGxzMTAyMWEncyBob3N0
X2luaXQgcmV1c2UgbGF5ZXJzY2FwZSBwbGF0Zm9ybSdzIGNvbW1vbg0KPiA+Pj4gaG9zdF9pbml0
IGZ1bmN0aW9uLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8Wmhp
cWlhbmcuSG91QG54cC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IFYyOg0KPiA+Pj4gIC0gUmVtb3Zl
ZCB0aGUgZGlzYWJsZSBvdXRib3VuZCB3aW5kb3dzIGNvZGUgYW5kIHRoZSByZW1vdmUNCj4gZHVw
bGljYXRlIGNsYXNzIGNvZGUNCj4gPj4+ICAgIGZpeHVwIGNvZGUgZnJvbSB0aGlzIHBhdGNoLg0K
PiA+Pj4NCj4gPj4+ICBkcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVyc2NhcGUuYyB8IDU0DQo+ID4+
PiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+PiAgMSBmaWxl
IGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVyc2NhcGUuYw0KPiA+Pj4gYi9k
cml2ZXJzL3BjaS9kd2MvcGNpLWxheWVyc2NhcGUuYw0KPiA+Pj4gaW5kZXggMDkwNTZhNi4uMzUz
M2E4YyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvcGNpL2R3Yy9wY2ktbGF5ZXJzY2FwZS5j
DQo+ID4+PiArKysgYi9kcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVyc2NhcGUuYw0KPiA+Pj4gQEAg
LTEwNywzMyArMTA3LDYgQEAgc3RhdGljIGludCBsczEwMjFfcGNpZV9saW5rX3VwKHN0cnVjdCBk
d19wY2llDQo+ICpwY2kpDQo+ID4+PiAgCXJldHVybiAxOw0KPiA+Pj4gIH0NCj4gPj4+DQo+IA0K
PiA8Y3V0Pg0KPiANCj4gPg0KPiA+ICAgLSBFbmFibGUgd3JpdGUgcGVybWlzc2lvbiBpbiBkd19w
Y2llX3NldHVwX3JjKCkgYW5kIHJlbW92ZSBjbGFzcw0KPiA+ICAgICBjb2RlIHVwZGF0ZSBmcm9t
IGxzX3BjaWVfaG9zdF9pbml0KCkgIFRoaXMgd2lsbCBtYWtlIGl0IG9idmlvdXMNCj4gPiAgICAg
dGhhdCBmaXhpbmcgZHdfcGNpZV9zZXR1cF9yYygpIG1ha2VzIGxzX3BjaWVfZml4X2NsYXNzKCkg
b2Jzb2xldGUuDQo+ID4NCj4gPiBEb2VzIHRoaXMgZHdfcGNpZV9zZXR1cF9yYygpIGZpeCBtZWFu
IHdlIGNhbiBhbHNvIGdldCByaWQgb2YgdGhlDQo+ID4gZGV2aWNlIGNsYXNzIGNoZWNrIGluIHFj
b21fcGNpZV9yZF9vd25fY29uZigpPw0KPiANCj4gVGhhbmtzIGZvciB0aGUgQ0MsIEknbGwgbWFu
YWdlIHRvIHRlc3QgdGhvc2UgcGF0Y2hlcyBhbmQgYWZ0ZXIgdGhhdCBJJ2xsIGNvbmZpcm0NCj4g
ZG9lcyB0aGlzIGZpeGVzIGRldmljZV9jbGFzcyByZWdpc3RlciB2YWx1ZSBmb3IgcWNvbSBkcml2
ZXIuDQoNCkkgaGF2ZSBzZW50IG91dCBwYXRjaCBzZXQgdjMsIHdoaWNoIGluY2x1ZGUgcmVtb3Zp
bmcgcWNvbSBkcml2ZXIncyBvYnNvbGV0ZSBmaXh1cCwgcGxlYXNlIGhlbHAgdG8gdGVzdC4NCg0K
VGhhbmtzLA0KWmhpcWlhbmcNCg==
