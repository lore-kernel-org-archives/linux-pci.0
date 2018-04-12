Return-Path: <SRS0=9FkI=HB=microsoft.com=Sridhar.Pitchai@kernel.org>
Return-Path: <SRS0=9FkI=HB=microsoft.com=Sridhar.Pitchai@kernel.org>
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Dexuan Cui <decui@microsoft.com>, Stephen Hemminger
	<sthemmin@microsoft.com>, Jake Oshins <jakeo@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "Michael Kelley (EOSG)"
	<Michael.H.Kelley@microsoft.com>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Date: Thu, 12 Apr 2018 15:56:42 +0000
Message-ID: <F8BC8B81-D3A4-40F7-95F4-CAF77A7917B7@microsoft.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
 <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
 <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
 <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

ICAgID4gDQogICAgPiAgICAgPj4gSSBhbSBzdGlsbCBub3QgaGFwcHkgd2l0aCB0aGlzIHBhdGNo
Lg0KICAgID4gICAgID4+DQogICAgPiAgICAgPj4gLSAgWW91IGRvIG5vdCBleHBsYWluIGF0IGFs
bCB0aGUgZGVwZW5kZW5jeSBvbiBjb21taXQgMGMxOTU1NjdhOGY2IGFuZA0KICAgID4gICAgID4+
ICAgIHlvdSBzaG91bGQgYmVjYXVzZSB0aGF0J3MgZnVuZGFtZW50YWwsIGlmIHRoYXQgcGF0Y2gg
aXMgbm90IHByZXNlbnQNCiAgICA+ICAgICA+PiAgICB0aGlzIHJldmVydCBicmVha3MgdGhlIGtl
cm5lbCBhcyBwZXIgcHJldmlvdXMgZGlzY3Vzc2lvbnNbMV0uDQogICAgPiAgICAgPj4gLSAgWW91
IGFyZSBzZW5kaW5nIHRoaXMgcGF0Y2ggdG8gYWxsIHN0YWJsZSBrZXJuZWxzIHRoYXQgY29udGFp
biB0aGUNCiAgICA+ICAgICA+PiAgICBjb21taXQgeW91IGFyZSBmaXhpbmcgLSBzb21lIHRoYXQg
bWF5IG5vdCBjb250YWluIHRoZSBjb21taXQgYWJvdmUNCiAgICA+ICAgICA+PiAgICAodGhhdCB3
YXMgbWVyZ2VkIGluIHY0LjE0KSwgeW91IGFyZSBicmVha2luZyB0aG9zZSBrZXJuZWxzLCBpZiBu
b3QNCiAgICA+ICAgICA+PiAgICBleHBsYWluIG1lIHdoeSBwbGVhc2UNCiAgICA+IA0KICAgID4g
ICAgID5JZiB0aGVyZSdzIGEgZGVwZW5kZW5jeSBvbiAwYzE5NTU2N2E4ZjYsIEkgdG90YWxseSBh
Z3JlZSB0aGF0DQogICAgPiAgICAgPm5lZWRzIHRvIGJlIGNsZWFyZWQgdXAuICBJIHdhcyBhc3N1
bWluZyB0aGF0IHR1cm5lZCBvdXQgdG8gYmUNCiAgICA+ICAgICA+aXJyZWxldmFudC4NCiAgICA+
IFRoYXQgaXMgcmlnaHQuIFRoZXJlIGlzIG5vIGRlcGVuZGVuY3kgb24gMGMxOTU1NjdhOGY2LiBX
ZSBqdXN0IG5lZWQgdG8gcmV2ZXJ0DQogICAgPiA0YTliMDkzM2JkZmMuDQogICAgDQogICAgPiBU
aGlzIHBhdGNoIHNob3VsZCBvbmx5IGJlIGFwcGxpZWQgdG8gbGF0ZXIgdmVyc2lvbnMgYWZ0ZXIg
IDBjMTk1NTY3YThmNiIgKHRyYW5zcGFyZW50IFZGKS4NCiAgICA+IE90aGVyd2lzZSBpdCBjYXVz
ZXMgbG9uZyAmIHJhbmRvbSBuYW1lcyBvZiBWRiBOSUNzIGZvciBib25kaW5nLiBUaGF0IHdpbGwg
bWFrZSBib25kaW5nDQogICAgPiBjb25maWcgZGlmZmljdWx0LCBlc3BlY2lhbGx5IGZvciBhdXRv
IGNvbmZpZy4NCiAgICANCiAgICA+VGhhbmtzLA0KICAgID4tIEhhaXlhbmcNCk9rLiBJIHdpbGwg
dXBkYXRlIHRoZSBwYXRjaCwgYXMgTG9yZW56byBzdWdnZXN0ZWQuIA0KDQogICAgDQoNCg==
