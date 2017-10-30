Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "minyard@acm.org" <minyard@acm.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: RE: [PATCH v10 1/9] LIB: Introduce a generic PIO mapping method
Date: Mon, 30 Oct 2017 15:31:21 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CAED4C@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-2-git-send-email-gabriele.paoloni@huawei.com>
 <49ac8217-1e89-bb4a-8592-9d57039f792c@acm.org>
In-Reply-To: <49ac8217-1e89-bb4a-8592-9d57039f792c@acm.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQ29yZXkNCg0KTWFueSBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMNCg0KWy4uLl0NCg0KPiA+
ICAgI2RlZmluZSBJT19TUEFDRV9MSU1JVCAweGZmZmYNCj4gPiAgICNlbmRpZg0KPiA+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9sb2dpY19waW8uaD4NCj4gDQo+IFRoaXMgd2hvbGUgdGhpbmcgd291
bGQgYmUgYSBsb3Qgc2ltcGxlciBpZiB5b3UgaGFkOg0KPiANCj4gI2lmZGVmIENPTkZJR19JTkRJ
UkVDVF9QSU8NCj4gI2RlZmluZSBpbmIgbG9naWNfaW5iDQo+ICNkZWZpbmUgb3V0YiBsb2dpYyBv
dXRiDQo+IC4NCj4gLg0KPiAjZW5kaWYgLyogQ09ORklHX0lORElSRUNUX1BJTyAqLw0KPiANCj4g
YW5kIGxldCB0aGUgImlmbmRlZiBYWFgiIGJlbG93IGhhbmRsZSBub3QgZW5hYmxpbmcgdGhlIHN0
YW5kYXJkIGNvZGUuDQo+IFlvdSBjb3VsZCBldmVuIHB1dCB0aGF0IGluIGxvZ2ljX3Bpby5oIHRv
IGF2b2lkIHBvbGx1dGluZyBpby5oLg0KDQpBZ3JlZWQuIEknbGwgbW92ZSBpdCBpbnRvICJsb2dp
Y19waW8uaCINCg0KPiANCj4gWW91IG1pZ2h0IGhhdmUgdG8gYWRkICIjaWZuZGVmIGluYiIsIGV0
Yy4gYWJvdmUsIGJ1dCBJIHN0aWxsIHRoaW5rIGl0DQo+IHdvdWxkDQo+IGJlIGJldHRlci4NCg0K
WWVzIGFncmVlZCBhbHNvIG9uIGFkZGluZyB0aGUgIiNpZm5kZWYgKioqIiBhcm91bmQgZWFjaCBm
dW5jdGlvbiByZS1kZWZpbml0aW9uDQppbiBsb2dpY19waW8uaA0KDQpUaGlzIHdpbGwgYmUgZml4
ZWQgaW4gdjExDQoNCj4gDQo+IEknbSBub3Qgc3VyZSBpZiB0aGlzIHdvdWxkbid0IGJlIGJldHRl
ciBkb25lIGluIGFybTY0L2luY2x1ZGUvYXNtL2lvLmgsDQo+IHRob3VnaC4NCj4gQSBzcGVjaWZp
YyBtYWNoaW5lIG1heSB3YW50IHRvIG9ubHkgZG8gdGhpcyBpbiByYW5nZXMsIGZvciBpbnN0YW5j
ZS4NCg0KTm8gSSBkb27igJl0IHRoaW5rIHNvLi4udGhpcyBpbyBmdW5jdGlvbnMgcmUtMGRlZmlu
aXRpb24gaGFzIG5vdGhpbmcgdG8gZG8NCndpdGggQVJNIGFyY2hpdGVjdHVyZSBhbmQgSSB0aGlu
ayBpdCBpcyBiZXR0ZXIgdG8ga2VlcCBldmVyeXRoaW5nIGluDQpsb2dpY19waW8uaCBpbmNsdWRp
bmcgdGhlIGZpbGUgZnJvbSAiaW5jbHVkZS9hc20tZ2VuZXJpYy9pby5oIg0KDQpDaGVlcnMNCkdh
Yg0KDQo+IA0KPiAtY29yZXkNCg0KWy4uLl0NCg0KPiA+IC0tLSBhL2xpYi9LY29uZmlnDQo+ID4g
KysrIGIvbGliL0tjb25maWcNCj4gPiBAQCAtNTksNiArNTksMzIgQEAgY29uZmlnIEFSQ0hfVVNF
X0NNUFhDSEdfTE9DS1JFRg0KPiA+ICAgY29uZmlnIEFSQ0hfSEFTX0ZBU1RfTVVMVElQTElFUg0K
PiA+ICAgCWJvb2wNCj4gPg0KPiA+ICtjb25maWcgTE9HSUNfUElPDQo+ID4gKwlib29sICJHZW5l
cmljIGxvZ2ljYWwgSS9PIG1hbmFnZW1lbnQiDQo+ID4gKwlkZWZfYm9vbCB5IGlmIFBDSSAmJiAh
WDg2ICYmICFJQTY0ICYmICFQT1dFUlBDDQo+ID4gKwloZWxwDQo+ID4gKwkgIEZvciBzb21lIGFy
Y2hpdGVjdHVyZXMsIHRoZXJlIGFyZSBubyBJTyBzcGFjZS4gVG8gc3VwcG9ydCB0aGUNCj4gPiAr
CSAgYWNjZXNzZXMgdG8gbGVnYWN5IEkvTyBkZXZpY2VzIG9uIHRob3NlIGFyY2hpdGVjdHVyZXMs
IGtlcm5lbA0KPiA+ICsJICBpbXBsZW1lbnRlZCB0aGUgbWVtb3J5IG1hcHBlZCBJL08gbWVjaGFu
aXNtIGJhc2VkIG9uIGJyaWRnZSBidXMNCj4gPiArCSAgc3VwcG9ydHMuIEJ1dCBmb3Igc29tZSBi
dXNlcyB3aGljaCBkbyBub3Qgc3VwcG9ydCBNTUlPLCB0aGUNCj4gPiArCSAgcGVyaXBoZXJhbHMg
dGhlcmUgc2hvdWxkIGJlIGFjY2Vzc2VkIHdpdGggZGV2aWNlLXNwZWNpZmljIHdheS4NCj4gPiAr
CSAgVG8gYWJzdHJhY3QgdGhvc2UgZGlmZmVyZW50IEkvTyBhY2Nlc3NlcyBpbnRvIHVuaWZpZWQg
SS9PDQo+IGFjY2Vzc29ycywNCj4gPiArCSAgdGhpcyBvcHRpb24gcHJvdmlkZSBhIGdlbmVyaWMg
SS9PIHNwYWNlIG1hbmFnZW1lbnQgd2F5IGFmdGVyDQo+IG1hcHBpbmcNCj4gPiArCSAgdGhlIGRl
dmljZSBJL08gdG8gc3lzdGVtIGxvZ2ljYWwvZmFrZSBJL08gYW5kIGhlbHAgdG8gaGlkZSBhbGwN
Cj4gdGhlDQo+ID4gKwkgIGhhcmR3YXJlIGRldGFpbC4NCj4gPiArDQo+ID4gK2NvbmZpZyBJTkRJ
UkVDVF9QSU8NCj4gPiArCWJvb2wgIkFjY2VzcyBJL08gaW4gbm9uLU1NSU8gbW9kZSIgaWYgTE9H
SUNfUElPDQo+ID4gKwloZWxwDQo+ID4gKwkgIE9uIHNvbWUgcGxhdGZvcm1zIHdoZXJlIG5vIHNl
cGFyYXRlIEkvTyBzcGFjZSBleGlzdCwgdGhlcmUgYXJlDQo+IEkvTw0KPiA+ICsJICBob3N0cyB3
aGljaCBjYW4gbm90IGJlIGFjY2Vzc2VkIGluIE1NSU8gbW9kZS4gQmFzZWQgb24NCj4gTE9HSUNf
UElPDQo+ID4gKwkgIG1lY2hhbmlzbSwgdGhlIGhvc3QtbG9jYWwgSS9PIHJlc291cmNlIGNhbiBi
ZSBtYXBwZWQgaW50bw0KPiBzeXN0ZW0NCj4gPiArCSAgbG9naWMgUElPIHNwYWNlIHNoYXJlZCB3
aXRoIE1NSU8gaG9zdHMsIHN1Y2ggYXMgUENJL1BDSUUsIHRoZW4NCj4gc3lzdGVtDQo+ID4gKwkg
IGNhbiBhY2Nlc3MgdGhlIEkvTyBkZXZpY2VzIHdpdGggdGhlIG1hcHBlZCBsb2dpYyBQSU8gdGhy
b3VnaA0KPiBJL08NCj4gPiArCSAgYWNjZXNzb3JzLg0KPiA+ICsJICBUaGlzIHdheSBoYXMgYSBs
aXR0bGUgSS9PIHBlcmZvcm1hbmNlIGNvc3QuIFBsZWFzZSBtYWtlIHN1cmUNCj4geW91cg0KPiA+
ICsJICBkZXZpY2VzIHJlYWxseSBuZWVkIHRoaXMgY29uZmlndXJlIGl0ZW0gZW5hYmxlZC4NCj4g
PiArDQo+IA0KPiBJZiB0aGlzIGlzIGFsd2F5cyBhdmFpbGFibGUgb24gdGhlIGhpc2lsaWNvbiBj
aGlwcywgSSB0aGluayB5b3Ugd291bGQNCj4gd2FudCB0byBqdXN0IGFsd2F5cw0KPiBlbmFibGUg
dGhpcyBvbiB0aG9zZSBjaGlwcy4NCg0KSW4gcGF0Y2ggNi85IHdlIGhhdmUgDQoNCitjb25maWcg
SElTSUxJQ09OX0xQQw0KKwlib29sICJTdXBwb3J0IGZvciBJU0EgSS9PIHNwYWNlIG9uIEhpc2ls
aWNvbiBIaXAwWCINCisJZGVwZW5kcyBvbiAoQVJNNjQgJiYgKEFSQ0hfSElTSSB8fCBDT01QSUxF
X1RFU1QpKQ0KKwlzZWxlY3QgTE9HSUNfUElPDQorCXNlbGVjdCBJTkRJUkVDVF9QSU8NCg0KU28g
dGhlIExQQyBob3N0IGNvbnRyb2xsZXIgZHJpdmVyIGlzIHNlbGVjdGluZyBJTkRJUkVDVF9QSU8u
Li4NCg0KPiANCj4gLWNvcmV5DQo+IA0KDQpDaGVlcnMNCkdhYg0KDQo=
