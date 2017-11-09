Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: dann frazier <dann.frazier@canonical.com>
CC: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH v10 0/9] LPC: legacy ISA I/O support
Date: Thu, 9 Nov 2017 16:18:15 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC85DB@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <CALdTtnsCXp9kone=VECSyPOi6kuYML8eU-TKHM+_ekhVoGSTYA@mail.gmail.com>
In-Reply-To: <CALdTtnsCXp9kone=VECSyPOi6kuYML8eU-TKHM+_ekhVoGSTYA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgRGFubg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGRhbm4gZnJh
emllciBbbWFpbHRvOmRhbm4uZnJhemllckBjYW5vbmljYWwuY29tXQ0KPiBTZW50OiAwOSBOb3Zl
bWJlciAyMDE3IDE2OjE2DQo+IFRvOiBHYWJyaWVsZSBQYW9sb25pDQo+IENjOiBDYXRhbGluIE1h
cmluYXM7IFdpbGwgRGVhY29uOyBSb2IgSGVycmluZzsgRnJhbmsgUm93YW5kOyBCam9ybg0KPiBI
ZWxnYWFzOyByYWZhZWxAa2VybmVsLm9yZzsgQXJuZCBCZXJnbWFubjsgbGludXgtYXJtLWtlcm5l
bDsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgTWFyayBSdXRsYW5kOyBCcmlhbiBTdGFy
a2V5OyBvbG9mQGxpeG9tLm5ldDsNCj4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IExp
bnV4YXJtOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBDb3JleQ0KPiBNaW55YXJkOyBKb2hu
IEdhcnJ5OyB4dXdlaSAoTykNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMC85XSBMUEM6IGxl
Z2FjeSBJU0EgSS9PIHN1cHBvcnQNCj4gDQo+IE9uIEZyaSwgT2N0IDI3LCAyMDE3IGF0IDEwOjEx
IEFNLCBHYWJyaWVsZSBQYW9sb25pDQo+IDxnYWJyaWVsZS5wYW9sb25pQGh1YXdlaS5jb20+IHdy
b3RlOg0KPiA+IEZyb206IGdhYnJpZWxlIHBhb2xvbmkgPGdhYnJpZWxlLnBhb2xvbmlAaHVhd2Vp
LmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2hzZXQgc3VwcG9ydHMgdGhlIElQTUktYnQgZGV2aWNl
IGF0dGFjaGVkIHRvIHRoZSBMb3ctUGluLQ0KPiBDb3VudA0KPiA+IGludGVyZmFjZSBpbXBsZW1l
bnRlZCBvbiBIaXNpbGljb24gSGlwMDYvSGlwMDcgU29DLg0KPiANCj4gZndpdywgSSB0ZXN0ZWQg
dGhpcyBvbiBvbmUgb2Ygb3VyIEQwNSBib2FyZHMgYW5kIHZlcmlmaWVkIHRoYXQgdGhlDQo+IElQ
TUkgU0kgd29ya2VkIGZpbmUuDQo+IA0KPiBUZXN0ZWQtYnk6IGRhbm4gZnJhemllciA8ZGFubi5m
cmF6aWVyQGNhbm9uaWNhbC5jb20+DQoNCk1hbnkgdGhhbmtzIGZvciB0aGlzDQpHYWINCg==
