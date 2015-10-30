Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jake Oshins <jakeo@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Date: Fri, 30 Oct 2015 17:30:23 +0000
Message-ID: <BY2PR0301MB16545FF0E85390EBF3B6BF1FA02F0@BY2PR0301MB1654.namprd03.prod.outlook.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-7-git-send-email-jakeo@microsoft.com>
	<CAHp75VfcLVsESDT-KdjobcKVwSWUT=f1i_1PrET47tJ=rB91jA@mail.gmail.com>
	<DM2PR0301MB123280EE1F7E37B57E27E6EAAB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
	<CAHp75VdTFWMtxT3ftfT4-EgvMaQD=rXVcZf2K2adJM_zyT5Rdg@mail.gmail.com>
	<BY2PR0301MB16543334659C86300E12DD5AA02F0@BY2PR0301MB1654.namprd03.prod.outlook.com>
 <CAHp75Ve5kbzUN341Q85dSQsQDkj0NDPMzmD7_8c=RS5ae2ULyA@mail.gmail.com>
In-Reply-To: <CAHp75Ve5kbzUN341Q85dSQsQDkj0NDPMzmD7_8c=RS5ae2ULyA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IFttYWlsdG86YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDMwLCAyMDE1IDk6NTkgQU0NCj4gVG86IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQu
Y29tPg0KPiBDYzogSmFrZSBPc2hpbnMgPGpha2VvQG1pY3Jvc29mdC5jb20+OyBHcmVnIEtyb2Fo
LUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZzsgb2xhZkBhZXBm
bGUuZGU7IGFwd0BjYW5vbmljYWwuY29tOyBWaXRhbHkNCj4gS3V6bmV0c292IDx2a3V6bmV0c0By
ZWRoYXQuY29tPjsgdGdseEByZWRoYXQuY29tOyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPjsgbWFyYy56eW5naWVyQGFybS5jb207IEppYW5nIExpdQ0KPiA8amlhbmcu
bGl1QGxpbnV4LmludGVsLmNvbT47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+
OyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0
IDYvN10gZHJpdmVyczpodjogRGVmaW5lIHRoZSBjaGFubmVsIHR5cGUgZm9yIEh5cGVyLVYNCj4g
UENJIEV4cHJlc3MgcGFzcy10aHJvdWdoDQo+IA0KPiBPbiBGcmksIE9jdCAzMCwgMjAxNSBhdCA2
OjU2IFBNLCBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0KPiA+
PiA+PiBXaGF0IGFib3V0DQo+ID4+ID4+ICNpbmNsdWRlIDxsaW51eC91dWlkLmg+DQo+ID4+ID4+
DQo+ID4+ID4+IFVVSURfTEUoLi4uKQ0KPiA+PiA+Pg0KPiA+PiA+PiBBbmQgeW91IG1heSB1c2Ug
dXVpZF9sZSB0eXBlIGluc3RlYWQgb2YgY3VzdG9tIHJhdyBidWZmZXIuDQo+ID4+ID4+DQo+ID4+
ID4NCj4gPj4gPiBUaGFua3MuICBJIHdhcyBqdXN0IGZvbGxvd2luZyB0aGUgZm9ybSBvZiBhbGwg
dGhlIG90aGVycyBpbiB0aGlzIGZpbGUuICBJIHRoaW5rDQo+ID4+IHRoYXQgdGhpcyB3YXMgZG9u
ZSB0byBtYXRjaCB1cCB3aXRoIHRoZSByZXByZXNlbnRhdGlvbiB0aGF0J3MgY29taW5nDQo+IGFj
cm9zcw0KPiA+PiB0aGUgVk0gYm91bmRhcnkgZnJvbSBXaW5kb3dzLg0KPiA+Pg0KPiA+PiBQZXJo
YXBzIGEgc2VwYXJhdGUgcGF0Y2ggdG8gbW92ZSB0byB1dWlkLmggdGhlbj8NCj4gPg0KPiA+IFll
czsgSSBhbSBhYm91dCB0byBzZW5kIG91dCBhIHBhdGNoIHRvIHVzZSB0aGUgVVVJRF9MRSBtYWNy
byBmb3IgYWxsIG9mIHRoZQ0KPiBIeXBlci1WIGd1aWRzLg0KPiANCj4gQW5kIHN3aXRjaGluZyB0
byBzdHJ1Y3QgdXVpZF9sZSA/DQoNClllcy4NCg0KSy4gWQ0KPiANCj4gLS0NCj4gV2l0aCBCZXN0
IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
