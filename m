Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Tue, 4 Jul 2017 15:14:42 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B15AA2@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
 <20170619100209.GC629@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
 <CAHp75VevOno613gk8QHDA7kmLZJj9TLZRiu7oJUs_xaRzcbpnw@mail.gmail.com>
In-Reply-To: <CAHp75VevOno613gk8QHDA7kmLZJj9TLZRiu7oJUs_xaRzcbpnw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQW5keQ0KDQpbLi4uXQ0KDQo+IA0KPiBKRllJOiBNaWthIG9uIHZhY2F0aW9uLg0KDQpUaGFu
a3MgZm9yIGxldHRpbmcgbWUga25vdw0KDQo+IA0KPiA+IEkgaGFkIGEgbG9vayBpbnRvIHRoZSBN
RkQgZnJhbWV3b3JrLiBJZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QNCj4gdGhlIG1mZA0K
PiA+IGZyYW1ld29yayBjcmVhdGUgYSBwbGF0Zm9ybSBkZXZpY2UgZm9yIGVhY2ggZGVjbGFyZWQg
bWZkX2NlbGwgdGhhdCBpcw0KPiBwYXNzZWQNCj4gPiB0byBtZmRfYWRkX2RldmljZXMoKS4NCj4g
DQo+IFJpZ2h0Lg0KPiANCj4gPiBIb3dldmVyIHRoZXJlIGlzIHNvbWV0aGluZyB0aGF0IEkgZG8g
bm90IHF1aXRlIHVuZGVyc3RhbmQ6DQo+ID4gZnJvbQ0KPiA+IGh0dHA6Ly9lbGl4aXIuZnJlZS1l
bGVjdHJvbnMuY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9tZmQvbWZkLQ0KPiBjb3Jl
LmMjTDIwNw0KPiA+IGl0IHNlZW1zIHRoYXQgbWZkX2FkZF9kZXZpY2UoKSB3aWxsIGNyZWF0ZSB0
aGUgcGxhdGZvcm0gZGV2aWNlIHVzaW5nDQo+IHRoZQ0KPiA+IHJlc291cmNlcyB0aGF0IGFyZSBz
dGF0aWNhbGx5IGRlY2xhcmVkIGluIHRoZSByZXNwZWN0aXZlIG1mZF9jZWxsLg0KPiANCj4gSXQn
cyBvbmUgcG9zc2liaWxpdHkuDQo+IA0KPiA+IEluIG15IGNhc2UgSSdkIGxpa2UgdG8gaGF2ZSBh
IHBsYXRmb3JtIGRldmljZSB1c2luZyB0aGUgcmVzb3VyY2VzDQo+IHRoYXQgYXJlDQo+ID4gcGFy
c2VkIGZyb20gdGhlIEFDUEkgdGFibGUgKGkuZS4gYXMgaXQgaXMgZG9uZSBub3cgYnkNCj4gPiBh
Y3BpX2NyZWF0ZV9wbGF0Zm9ybV9kZXZpY2UoKSkuDQo+IA0KPiBTbyBmYXIgc28gZ29vZC4gTm90
aGluZyBwcmV2ZW50cyB5b3UgdG8gZG8gdGhhdC4NCj4gDQo+ID4gSWYgbXkgdW5kZXJzdGFuZGlu
ZyBpcyBjb3JyZWN0LCBpZiBJIGRlY2xhcmVkIGFuIG1mZF9jZWxsIGZvciBteSBJUE1JDQo+IGNo
aWxkDQo+ID4gdGhlIG1mZCBzdWJzeXN0ZW0gd291bGQgY3JlYXRlIGEgcGxhdGZvcm0gZGV2aWNl
IGZvciBzdWNoIGNoaWxkIGFuZA0KPiA+IHRoZXJlZm9yZSBhY3BpX2NyZWF0ZV9wbGF0Zm9ybV9k
ZXZpY2UoKSB3b3VsZCBmYWlsIHRvIGNyZWF0ZSBhIG5ldw0KPiBwbGF0Zm9ybQ0KPiA+IGRldmlj
ZSBhcyBhZGV2LT5waHlzaWNhbF9ub2RlX2NvdW50IHdpbGwgYmUgbm9uIHplcm8uDQo+ID4gSG93
ZXZlciBhcyB0aGluZ3Mgc3RhbmQgbm93IG1mZF9jZWxsIGRldmljZXMgY2FuIG9ubHkgdXNlIHRo
ZQ0KPiByZXNvdXJjZXMNCj4gPiB0aGF0IGFyZSBzdGF0aWNhbGx5IGRlZmluZWQgaW4gdGhlIGNv
ZGUgKGFuZCB0aGVyZWZvcmUgbm90IHRoZSBvbmVzDQo+IGluIHRoZQ0KPiA+IEFDUEkgbm9kZXMp
Li4uYW0gSSByaWdodD8NCj4gDQo+IFlvdSBtYXkgZmlsZSByZXNvdXJjZXMgZmlyc3QgYW5kIHRo
ZW4gcmVnaXN0ZXIgTUZEIGNlbGxzLiBTZWUgbWFueQ0KPiBleGlzdGluZyBleGFtcGxlcyBpbiB0
aGUga2VybmVsLg0KDQpXZWxsIEkgaGFkIGEgbG9vayBhcm91bmQgdGhlIEtlcm5lbCBJIGhhdmUg
c2VlbiBubyBtZmQgY2VsbHMgdXNpbmcNClJlc291cmNlcyB0aGF0IGFyZSBub3Qgc3RhdGljYWxs
eSBkZWZpbmVkOg0KaS5lLiBjZWxsLT5yZXNvdXJjZXMgaW4gbWZkX2FkZF9kZXZpY2UoKSBhbHdh
eXMgcG9pbnRzIHRvIHN0YXRpY2FsbHkNCmRlZmluZWQgcmVzb3VyY2Ugc3RydWN0dXJlcy4NCg0K
VXN1YWxseSBmb3IgQUNQSSBkZXZpY2VzIGZpcnN0IHlvdSBuZWVkIHRvIHBhcnNlIHRoZSBBQ1BJ
IHJlc291cmNlcw0KZnJvbSB0aGUgdGFibGUgY2FsbGluZyBhY3BpX2Rldl9nZXRfcmVzb3VyY2Vz
KCksIHRoZW4geW91IGl0ZXJhdGUgDQpvdmVyIHRoZSByZXNvdXJjZSBsaXN0IGFuZCBmaWxsIHRo
ZSByZXNvdXJjZSBhcnJheSBieSBjYWxsaW5nDQphY3BpX3BsYXRmb3JtX2ZpbGxfcmVzdXJjZXMo
KSAoYXMgaW4gYWNwaV9jcmVhdGVfcGxhdGZvcm1fZGV2aWNlKCkpDQoNCldpdGggcmVzcGVjdCB0
byBteSBjYXNlIGFyZSB5b3Ugc3VnZ2VzdGluZyBkeW5hbWljYWxseSBhbGxvY2F0ZSBhDQpyZXNv
dXJjZSBhcnJheSBhbmQgZmlsbCBpdCB1c2luZyB0aGUgc2FtZSBmYXNoaW9uIGFzIA0KYWNwaV9j
cmVhdGVfcGxhdGZvcm1fZGV2aWNlKCksIHRoZW4gcG9pbnQgY2VsbC0+cmVzb3VyY2VzIHRvIHN1
Y2gNCmFycmF5IGJlZm9yZSBjYWxsaW5nIG1mZF9hZGRfZGV2aWNlKCkgPw0KDQpUaGFua3MNCkdh
Yg0KDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
