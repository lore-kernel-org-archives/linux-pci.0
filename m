Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0093.outbound.protection.outlook.com ([104.47.125.93]:63552
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966689AbeE2V2p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 May 2018 17:28:45 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Date: Tue, 29 May 2018 21:28:27 +0000
Message-ID: <KL1P15301MB00062308DD0D900D9A8943FDBF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <CAHp75Vd9kiyOaSbaK6c4b7ucF23kgP0yQxKpUAGrjHgKfJprXA@mail.gmail.com>
In-Reply-To: <CAHp75Vd9kiyOaSbaK6c4b7ucF23kgP0yQxKpUAGrjHgKfJprXA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IFR1ZXNkYXksIE1heSAyOSwgMjAxOCAxNDoyMQ0KPiBPbiBUaHUsIE1heSAyNCwgMjAxOCBh
dCAxMjoxMiBBTSwgRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gd3JvdGU6DQo+
ID4NCj4gPiBCZWZvcmUgdGhlIGd1ZXN0IGZpbmlzaGVzIHRoZSBkZXZpY2UgaW5pdGlhbGl6YXRp
b24sIHRoZSBkZXZpY2UgY2FuIGJlDQo+ID4gcmVtb3ZlZCBhbnl0aW1lIGJ5IHRoZSBob3N0LCBh
bmQgYWZ0ZXIgdGhhdCB0aGUgaG9zdCB3b24ndCByZXNwb25kIHRvDQo+ID4gdGhlIGd1ZXN0J3Mg
cmVxdWVzdCwgc28gdGhlIGd1ZXN0IHNob3VsZCBiZSBwcmVwYXJlZCB0byBoYW5kbGUgdGhpcw0K
PiA+IGNhc2UuDQo+IA0KPiA+ICsgICAgICAgd2hpbGUgKHRydWUpIHsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKGhkZXYtPmNoYW5uZWwtPnJlc2NpbmQpIHsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfd2Fybl9vbmNlKCZoZGV2LT5kZXZpY2UsICJUaGUgZGV2aWNlIGlzDQo+IGdv
bmUuXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4g
PiArICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHdhaXRf
Zm9yX2NvbXBsZXRpb25fdGltZW91dChjb21wLCBIWiAvIDEwKSkNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgIH0NCj4gDQo+IEluZmluaXRlIGxvb3BzIGFy
ZSB1c3VhbGx5IGEgcmVkIGZsYWdzLg0KPiANCj4gV2hhdCdzIHdyb25nIHdpdGggc2ltcGxlOg0K
PiANCj4gZG8gew0KPiAgIC4uLg0KPiB9IHdoaWxlICh3YWl0Xy4uLiguLi4pID09IDApOw0KPiAN
Cj4gPw0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwgQW5keSENClRoZSBjb2Rpbmcgc3R5bGUg
eW91IHN1Z2dlc3RlZCBsb29rcyBiZXR0ZXIgdG8gbWUuIDotKQ0KDQo+ID4gKyAgICAgICBpZiAo
IXJldCkNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gd2FpdF9mb3JfcmVzcG9uc2UoaGRldiwg
JmNvbXApOw0KPiANCj4gQmV0dGVyIHRvIHVzZSB3ZWxsIGVzdGFibGlzaGVkIHBhdHRlcm5zLCBp
LmUuDQo+IA0KPiBpZiAocmV0KQ0KPiAgcmV0dXJuIHJldDsNCkFncmVlZC4NCg0KPiANCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKCFyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gd2FpdF9mb3JfcmVzcG9uc2UoaGRldiwNCj4gJmNvbXBfcGt0Lmhvc3RfZXZlbnQpOw0KPiAN
Cj4gSGVyZSBpdCBsb29rcyBva2F5IG9uIHRoZSBmaXJzdCBnbGFuY2UsIGJ1dCBiZXR0ZXIgdG8g
dGhpbmsgYWJvdXQgaXQNCj4gYWdhaW4gYW5kIHJlZmFjdG9yLg0KDQo+IFdpdGggQmVzdCBSZWdh
cmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg0KSSdsbCB0cnkgdG8gc2VuZCBvdXQgYSBwYXRjaCB0
byBpbXByb3ZlIHRoZSBjb2Rpbmcgc3R5bGUsIGFmdGVyIEkgYWRkcmVzcw0KTWljaGFlbCBLZWxs
ZXkncyBjb25jZXJuIG9mIGEgcmFjZS4NCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
