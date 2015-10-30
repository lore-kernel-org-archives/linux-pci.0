Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0105.outbound.protection.outlook.com ([157.56.111.105]:2267
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758680AbbJ3QNq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 30 Oct 2015 12:13:46 -0400
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
Subject: RE: [PATCH v4 6/7] drivers:hv: Define the channel type for Hyper-V
 PCI Express pass-through
Date: Fri, 30 Oct 2015 15:57:56 +0000
Message-ID: <DM2PR0301MB123280EE1F7E37B57E27E6EAAB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-7-git-send-email-jakeo@microsoft.com>
 <CAHp75VfcLVsESDT-KdjobcKVwSWUT=f1i_1PrET47tJ=rB91jA@mail.gmail.com>
In-Reply-To: <CAHp75VfcLVsESDT-KdjobcKVwSWUT=f1i_1PrET47tJ=rB91jA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gW21h
aWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciAyOSwgMjAxNSA1OjQ1IFBNDQo+IFRvOiBKYWtlIE9zaGlucyA8amFrZW9AbWljcm9zb2Z0LmNv
bT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
OyBLWSBTcmluaXZhc2FuDQo+IDxreXNAbWljcm9zb2Z0LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmc7IG9sYWZAYWVwZmxl
LmRlOyBhcHdAY2Fub25pY2FsLmNvbTsgVml0YWx5DQo+IEt1em5ldHNvdiA8dmt1em5ldHNAcmVk
aGF0LmNvbT47IHRnbHhAcmVkaGF0LmNvbTsgSGFpeWFuZyBaaGFuZw0KPiA8aGFpeWFuZ3pAbWlj
cm9zb2Z0LmNvbT47IG1hcmMuenluZ2llckBhcm0uY29tOyBKaWFuZyBMaXUNCj4gPGppYW5nLmxp
dUBsaW51eC5pbnRlbC5jb20+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsg
bGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA2
LzddIGRyaXZlcnM6aHY6IERlZmluZSB0aGUgY2hhbm5lbCB0eXBlIGZvciBIeXBlci1WDQo+IFBD
SSBFeHByZXNzIHBhc3MtdGhyb3VnaA0KPiANCj4gPg0KPiA+ICAvKg0KPiA+ICsgKiBQQ0kgRXhw
cmVzcyBQYXNzIFRocm91Z2gNCj4gPiArICogezQ0QzRGNjFELTQ0NDQtNDQwMC05RDUyLTgwMkUy
N0VERTE5Rn0NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjZGVmaW5lIEhWX1BDSUVfR1VJRCBcDQo+
ID4gKyAgICAgICAuZ3VpZCA9IHsgXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDB4MUQs
IDB4RjYsIDB4QzQsIDB4NDQsIDB4NDQsIDB4NDQsIDB4MDAsIDB4NDQsIFwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAweDlELCAweDUyLCAweDgwLCAweDJFLCAweDI3LCAweEVELCAweEUx
LCAweDlGIFwNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiANCj4gV2hhdCBhYm91dA0KPiAjaW5j
bHVkZSA8bGludXgvdXVpZC5oPg0KPiANCj4gVVVJRF9MRSguLi4pDQo+IA0KPiBBbmQgeW91IG1h
eSB1c2UgdXVpZF9sZSB0eXBlIGluc3RlYWQgb2YgY3VzdG9tIHJhdyBidWZmZXIuDQo+IA0KDQpU
aGFua3MuICBJIHdhcyBqdXN0IGZvbGxvd2luZyB0aGUgZm9ybSBvZiBhbGwgdGhlIG90aGVycyBp
biB0aGlzIGZpbGUuICBJIHRoaW5rIHRoYXQgdGhpcyB3YXMgZG9uZSB0byBtYXRjaCB1cCB3aXRo
IHRoZSByZXByZXNlbnRhdGlvbiB0aGF0J3MgY29taW5nIGFjcm9zcyB0aGUgVk0gYm91bmRhcnkg
ZnJvbSBXaW5kb3dzLg0KDQpJIGRvIHZlcnkgbXVjaCBhcHByZWNpYXRlIHRoZSBmZWVkYmFjaywg
dGhvdWdoLA0KSmFrZSBPc2hpbnMNCg==
