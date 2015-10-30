Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jake Oshins <jakeo@microsoft.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Date: Fri, 30 Oct 2015 16:56:11 +0000
Message-ID: <BY2PR0301MB16543334659C86300E12DD5AA02F0@BY2PR0301MB1654.namprd03.prod.outlook.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-7-git-send-email-jakeo@microsoft.com>
	<CAHp75VfcLVsESDT-KdjobcKVwSWUT=f1i_1PrET47tJ=rB91jA@mail.gmail.com>
	<DM2PR0301MB123280EE1F7E37B57E27E6EAAB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
 <CAHp75VdTFWMtxT3ftfT4-EgvMaQD=rXVcZf2K2adJM_zyT5Rdg@mail.gmail.com>
In-Reply-To: <CAHp75VdTFWMtxT3ftfT4-EgvMaQD=rXVcZf2K2adJM_zyT5Rdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IFttYWlsdG86YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDMwLCAyMDE1IDk6NTIgQU0NCj4gVG86IEpha2UgT3NoaW5zIDxqYWtlb0BtaWNyb3NvZnQu
Y29tPg0KPiBDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz47IEtZIFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZzsgb2xhZkBhZXBm
bGUuZGU7IGFwd0BjYW5vbmljYWwuY29tOyBWaXRhbHkNCj4gS3V6bmV0c292IDx2a3V6bmV0c0By
ZWRoYXQuY29tPjsgdGdseEByZWRoYXQuY29tOyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPjsgbWFyYy56eW5naWVyQGFybS5jb207IEppYW5nIExpdQ0KPiA8amlhbmcu
bGl1QGxpbnV4LmludGVsLmNvbT47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+
OyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0
IDYvN10gZHJpdmVyczpodjogRGVmaW5lIHRoZSBjaGFubmVsIHR5cGUgZm9yIEh5cGVyLVYNCj4g
UENJIEV4cHJlc3MgcGFzcy10aHJvdWdoDQo+IA0KPiBPbiBGcmksIE9jdCAzMCwgMjAxNSBhdCA1
OjU3IFBNLCBKYWtlIE9zaGlucyA8amFrZW9AbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0KPiA+
PiA+ICsgKiBQQ0kgRXhwcmVzcyBQYXNzIFRocm91Z2gNCj4gPj4gPiArICogezQ0QzRGNjFELTQ0
NDQtNDQwMC05RDUyLTgwMkUyN0VERTE5Rn0NCj4gPj4gPiArICovDQo+ID4+ID4gKw0KPiA+PiA+
ICsjZGVmaW5lIEhWX1BDSUVfR1VJRCBcDQo+ID4+ID4gKyAgICAgICAuZ3VpZCA9IHsgXA0KPiA+
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDB4MUQsIDB4RjYsIDB4QzQsIDB4NDQsIDB4NDQs
IDB4NDQsIDB4MDAsIDB4NDQsIFwNCj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAgICAweDlE
LCAweDUyLCAweDgwLCAweDJFLCAweDI3LCAweEVELCAweEUxLCAweDlGIFwNCj4gPj4gPiArICAg
ICAgICAgICAgICAgfQ0KPiA+Pg0KPiA+PiBXaGF0IGFib3V0DQo+ID4+ICNpbmNsdWRlIDxsaW51
eC91dWlkLmg+DQo+ID4+DQo+ID4+IFVVSURfTEUoLi4uKQ0KPiA+Pg0KPiA+PiBBbmQgeW91IG1h
eSB1c2UgdXVpZF9sZSB0eXBlIGluc3RlYWQgb2YgY3VzdG9tIHJhdyBidWZmZXIuDQo+ID4+DQo+
ID4NCj4gPiBUaGFua3MuICBJIHdhcyBqdXN0IGZvbGxvd2luZyB0aGUgZm9ybSBvZiBhbGwgdGhl
IG90aGVycyBpbiB0aGlzIGZpbGUuICBJIHRoaW5rDQo+IHRoYXQgdGhpcyB3YXMgZG9uZSB0byBt
YXRjaCB1cCB3aXRoIHRoZSByZXByZXNlbnRhdGlvbiB0aGF0J3MgY29taW5nIGFjcm9zcw0KPiB0
aGUgVk0gYm91bmRhcnkgZnJvbSBXaW5kb3dzLg0KPiANCj4gUGVyaGFwcyBhIHNlcGFyYXRlIHBh
dGNoIHRvIG1vdmUgdG8gdXVpZC5oIHRoZW4/DQoNClllczsgSSBhbSBhYm91dCB0byBzZW5kIG91
dCBhIHBhdGNoIHRvIHVzZSB0aGUgVVVJRF9MRSBtYWNybyBmb3IgYWxsIG9mIHRoZSBIeXBlci1W
IGd1aWRzLg0KDQpSZWdhcmRzLA0KDQpLLiBZDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJk
cywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
