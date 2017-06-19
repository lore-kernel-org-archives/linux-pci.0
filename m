Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Date: Mon, 19 Jun 2017 09:50:49 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
References: <20170606085553.GA20085@red-moon>
 <20170612155700.GA31930@red-moon> <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgUmFmYWVsLCBNaWthLCBMb3JlbnpvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogcmp3eXNvY2tpQGdtYWlsLmNvbSBbbWFpbHRvOnJqd3lzb2NraUBnbWFpbC5jb21d
IE9uIEJlaGFsZiBPZg0KPiBSYWZhZWwgSi4gV3lzb2NraQ0KPiBTZW50OiAxNiBKdW5lIDIwMTcg
MTM6MjMNCj4gVG86IE1pa2EgV2VzdGVyYmVyZw0KPiBDYzogUmFmYWVsIEouIFd5c29ja2k7IEdh
YnJpZWxlIFBhb2xvbmk7IExvcmVuem8gUGllcmFsaXNpOyBSYWZhZWwgSi4NCj4gV3lzb2NraTsg
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207DQo+IHJvYmgrZHRA
a2VybmVsLm9yZzsgZnJvd2FuZC5saXN0QGdtYWlsLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gYXJuZEBhcm5kYi5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgYnJpYW4uc3RhcmtleUBhcm0uY29tOyBvbG9mQGxpeG9t
Lm5ldDsNCj4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4YXJtOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOw0KPiBtaW55YXJkQGFjbS5vcmc7IEpvaG4gR2Fycnk7IHh1d2Vp
IChPKQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDUvN10gQUNQSTogVHJhbnNsYXRlIHRoZSBJ
L08gcmFuZ2Ugb2Ygbm9uLU1NSU8NCj4gZGV2aWNlcyBiZWZvcmUgc2Nhbm5pbmcNCj4gDQo+IE9u
IEZyaSwgSnVuIDE2LCAyMDE3IGF0IDI6MDAgUE0sIE1pa2EgV2VzdGVyYmVyZw0KPiA8bWlrYS53
ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4gT24gRnJpLCBKdW4gMTYsIDIw
MTcgYXQgMDE6MjQ6MzJQTSArMDIwMCwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4+ID4g
SW4gZmFjdCBpdCBtYXkgYmUgdGhhdCBpdCBpcyBub3Qgc3VmZmljaWVudCBpbiB0aGlzIGNhc2Ug
YmVjYXVzZQ0KPiB0aGUNCj4gPj4gPiBBQ1BJIGNvcmUgbWlnaHQgZW51bWVyYXRlIGNoaWxkIGRl
dmljZXMgYmVmb3JlIHRoZSBMUEMgZHJpdmVyIGV2ZW4NCj4gZ2V0cw0KPiA+PiA+IGEgY2hhbmNl
IHRvIHByb2JlIHNvIHlvdSB3b3VsZCBuZWVkIHRvIGFkZCBhbHNvIHNjYW4gaGFuZGxlciB0bw0K
PiB0aGUNCj4gPj4gPiBjaGlsZCBkZXZpY2VzIGFuZCBtYXJrIHRoZW0gYWxyZWFkeSBlbnVtZXJh
dGVkIG9yIHNvbWV0aGluZyBsaWtlDQo+IHRoYXQuDQo+ID4+DQo+ID4+IE9yIGV4dGVuZCB0aGUg
c3BlY2lhbCBJMkMvU1BJIGhhbmRsaW5nIHRvIHRoZW0uDQo+ID4NCj4gPiBTdXJlIGJ1dCB0aG9z
ZSBoYXZlIEkyYy9TcGlTZXJpYWxCdXMoKSByZXNvdXJjZXMgd2hpY2ggd2UgY2FuIHVzZSB0bw0K
PiA+IGlkZW50aWZ5IHRoZW0gYnV0IGZvciB0aGUgaXBtaSB0aGluZyB0aGVyZSBpcyBub3RoaW5n
IGVsc2UgdGhhbiBfSElEDQo+IHNvDQo+ID4gd2Ugd291bGQgbmVlZCB0byBrZWVwIGEgbGlzdCBv
ZiBzdWNoIGRldmljZXMgaW4gQUNQSSBjb3JlLg0KPiANCj4gT0ssIHNvIGFkZGluZyBhIHNjYW4g
aGFuZGxlciBmb3IgdGhhdCB3b3VsZCBiZSB0aGUgd2F5IHRvIGdvIElNTy4NCg0KTWFueSB0aGFu
a3MgZm9yIHlvdXIgcmVzcG9uc2UgYW5kIHlvdXIgaGVscCBoZXJlLg0KDQpJIGd1ZXNzIHRoYXQg
YXMgY29uY2x1c2lvbiB3aXRoIHJlc3BlY3QgdG8gdGhlIGN1cnJlbnQgdjkgcGF0Y2hzZXQgd2Ug
Y2FuDQpkaXNyZWdhcmQgdGhlIGlkZWEgb2YgTUZEIGFuZCBtb2RpZnkgdGhlIGN1cnJlbnQgdjkg
c28gdGhhdCBpdCBkb2Vzbid0DQp0b3VjaCBkaXJlY3RseSBBQ1BJIHJlc291cmNlcy4NCkluc3Rl
YWQgYXMgSSBwcm9wb3NlZCBiZWZvcmUgd2UgY2FuIGhhdmUgdGhlIHNjYW4gaGFuZGxlciB0byBl
bnVtZXJhdGUNCnRoZSBjaGlsZHJlbiBkZXZpY2VzIGFuZCB0cmFuc2xhdGUgaXRzIGFkZHJlc3Nl
cyBmaWxsaW5nIGRldi0+cmVzb3VyY2VzW10gYW5kDQphdCB0aGUgc2FtZSB0aW1lIHdlIGNhbiBt
b2RpZnkgYWNwaV9kZWZhdWx0X2VudW1lcmF0aW9uIHRvIGNoZWNrDQphY3BpX2RldmljZV9lbnVt
ZXJhdGVkKCkgYmVmb3JlIGNvbnRpbnVpbmcgd2l0aCBkZXZpY2UgZW51bWVyYXRpb24uLi4/DQoN
CkRvIHlvdSB0aGluayBpdCBhcyBhIHZpYWJsZSBzb2x1dGlvbj8NCg0KVGhhbmtzDQpHYWINCg==
