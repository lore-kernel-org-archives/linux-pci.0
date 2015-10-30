Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0143.outbound.protection.outlook.com ([157.56.111.143]:32420
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750835AbbJ3QNQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 30 Oct 2015 12:13:16 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"tglx@redhat.com" <tglx@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v4 5/7] PCI: irqdomain: Look up IRQ domain by
 fwnode_handle
Date: Fri, 30 Oct 2015 15:58:23 +0000
Message-ID: <DM2PR0301MB123242391B393049EACC7A81AB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-6-git-send-email-jakeo@microsoft.com>
 <CAHp75Vd=najBY7MJofStyLODWuG45=VzwLoWCSrQRm0nemuD4A@mail.gmail.com>
In-Reply-To: <CAHp75Vd=najBY7MJofStyLODWuG45=VzwLoWCSrQRm0nemuD4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21h
aWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciAyOSwgMjAxNSA1OjI4IFBNDQo+IFRvOiBKYWtlIE9zaGlucyA8amFrZW9AbWljcm9zb2Z0LmNv
bT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
OyBLWSBTcmluaXZhc2FuDQo+IDxreXNAbWljcm9zb2Z0LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmc7IG9sYWZAYWVwZmxl
LmRlOyBhcHdAY2Fub25pY2FsLmNvbTsgVml0YWx5DQo+IEt1em5ldHNvdiA8dmt1em5ldHNAcmVk
aGF0LmNvbT47IHRnbHhAcmVkaGF0LmNvbTsgSGFpeWFuZyBaaGFuZw0KPiA8aGFpeWFuZ3pAbWlj
cm9zb2Z0LmNvbT47IG1hcmMuenluZ2llckBhcm0uY29tOyBKaWFuZyBMaXUNCj4gPGppYW5nLmxp
dUBsaW51eC5pbnRlbC5jb20+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsg
bGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA1
LzddIFBDSTogaXJxZG9tYWluOiBMb29rIHVwIElSUSBkb21haW4gYnkNCj4gZndub2RlX2hhbmRs
ZQ0KPiANCj4gT24gRnJpLCBPY3QgMzAsIDIwMTUgYXQgMTo0NiBBTSwgIDxqYWtlb0BtaWNyb3Nv
ZnQuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBKYWtlIE9zaGlucyA8amFrZW9AbWljcm9zb2Z0LmNv
bT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIHNlY29uZCB3YXkgb2YgZmluZGluZyBhbiBJ
UlEgZG9tYWluIGFzc29jaWF0ZWQgd2l0aA0KPiA+IGEgcm9vdCBQQ0kgYnVzLiAgQWZ0ZXIgbG9v
a2luZyB0byBzZWUgaWYgb25lIGNhbiBiZSBmb3VuZCB0aHJvdWdoDQo+ID4gdGhlIE9GIHRyZWUs
IGl0IGF0dGVtcHRzIHRvIGxvb2sgdXAgdGhlIElSUSBkb21haW4gdGhyb3VnaCBhbg0KPiA+IGZ3
bm9kZV9oYW5kbGUgc3RvcmVkIGluIHRoZSBwY2lfc3lzZGF0YSBzdHJ1Y3QuDQo+IA0KPiANCj4g
PiArI2lmZGVmIENPTkZJR19QQ0lfTVNJX0lSUV9ET01BSU4NCj4gPiArICAgICAgIC8qDQo+ID4g
KyAgICAgICAgKiBJZiBubyBJUlEgZG9tYWluIHdhcyBmb3VuZCB2aWEgdGhlIE9GIHRyZWUsIHRy
eSBsb29raW5nIGl0IHVwDQo+ID4gKyAgICAgICAgKiBkaXJlY3RseSB0aHJvdWdoIHRoZSBmd25v
ZGVfaGFuZGxlLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAoIWQpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgaWYgKHBjaV9md25vZGUoYnVzKSkgew0KPiANCj4gSXNuJ3QgaXQgdGhl
IHNhbWUgdG8NCj4gaWYgKCFkICYmIHBjaV9md25vZGUoYnVzKSkNCj4gIGQgPSAuLi4NCj4gDQoN
ClRoYW5rcy4gIEknbGwgbWFrZSB0aGlzIGNoYW5nZSBhbmQgcmVzZW5kLg0KDQotLSBKYWtlIE9z
aGlucw0K
