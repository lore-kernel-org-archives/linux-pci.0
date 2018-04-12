Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Date: Thu, 12 Apr 2018 15:46:14 +0000
Message-ID: <BL0PR2101MB1108227C3E52DE4462A9F93CCABC0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
 <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
 <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
In-Reply-To: <9832EE81-01B3-44AB-8B3D-EEA32AED07E0@microsoft.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3JpZGhhciBQaXRjaGFp
DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxMiwgMjAxOCAxMToxNCBBTQ0KPiBUbzogQmpvcm4g
SGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgTG9yZW56byBQaWVyYWxpc2kNCj4gPGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb20+DQo+IENjOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNy
b3NvZnQuY29tPjsgRGV4dWFuIEN1aQ0KPiA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47IFN0ZXBoZW4g
SGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsNCj4gSmFrZSBPc2hpbnMgPGpha2Vv
QG1pY3Jvc29mdC5jb20+OyBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47DQo+IE1p
Y2hhZWwgS2VsbGV5IChFT1NHKSA8TWljaGFlbC5ILktlbGxleUBtaWNyb3NvZnQuY29tPjsNCj4g
ZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
N10gUmV2ZXJ0ICJQQ0k6IGh2OiBVc2UgZGV2aWNlIHNlcmlhbCBudW1iZXIgYXMgUENJDQo+IGRv
bWFpbiINCj4gDQo+ICAgICA+PiBJIGFtIHN0aWxsIG5vdCBoYXBweSB3aXRoIHRoaXMgcGF0Y2gu
DQo+ICAgICA+Pg0KPiAgICAgPj4gLSAgWW91IGRvIG5vdCBleHBsYWluIGF0IGFsbCB0aGUgZGVw
ZW5kZW5jeSBvbiBjb21taXQgMGMxOTU1NjdhOGY2IGFuZA0KPiAgICAgPj4gICAgeW91IHNob3Vs
ZCBiZWNhdXNlIHRoYXQncyBmdW5kYW1lbnRhbCwgaWYgdGhhdCBwYXRjaCBpcyBub3QgcHJlc2Vu
dA0KPiAgICAgPj4gICAgdGhpcyByZXZlcnQgYnJlYWtzIHRoZSBrZXJuZWwgYXMgcGVyIHByZXZp
b3VzIGRpc2N1c3Npb25zWzFdLg0KPiAgICAgPj4gLSAgWW91IGFyZSBzZW5kaW5nIHRoaXMgcGF0
Y2ggdG8gYWxsIHN0YWJsZSBrZXJuZWxzIHRoYXQgY29udGFpbiB0aGUNCj4gICAgID4+ICAgIGNv
bW1pdCB5b3UgYXJlIGZpeGluZyAtIHNvbWUgdGhhdCBtYXkgbm90IGNvbnRhaW4gdGhlIGNvbW1p
dCBhYm92ZQ0KPiAgICAgPj4gICAgKHRoYXQgd2FzIG1lcmdlZCBpbiB2NC4xNCksIHlvdSBhcmUg
YnJlYWtpbmcgdGhvc2Uga2VybmVscywgaWYgbm90DQo+ICAgICA+PiAgICBleHBsYWluIG1lIHdo
eSBwbGVhc2UNCj4gDQo+ICAgICA+SWYgdGhlcmUncyBhIGRlcGVuZGVuY3kgb24gMGMxOTU1Njdh
OGY2LCBJIHRvdGFsbHkgYWdyZWUgdGhhdA0KPiAgICAgPm5lZWRzIHRvIGJlIGNsZWFyZWQgdXAu
ICBJIHdhcyBhc3N1bWluZyB0aGF0IHR1cm5lZCBvdXQgdG8gYmUNCj4gICAgID5pcnJlbGV2YW50
Lg0KPiBUaGF0IGlzIHJpZ2h0LiBUaGVyZSBpcyBubyBkZXBlbmRlbmN5IG9uIDBjMTk1NTY3YThm
Ni4gV2UganVzdCBuZWVkIHRvIHJldmVydA0KPiA0YTliMDkzM2JkZmMuDQoNClRoaXMgcGF0Y2gg
c2hvdWxkIG9ubHkgYmUgYXBwbGllZCB0byBsYXRlciB2ZXJzaW9ucyBhZnRlciAgMGMxOTU1Njdh
OGY2IiAodHJhbnNwYXJlbnQgVkYpLiBPdGhlcndpc2UgaXQgY2F1c2VzIGxvbmcgJiByYW5kb20g
bmFtZXMgb2YgVkYgTklDcyBmb3IgYm9uZGluZy4gVGhhdCB3aWxsIG1ha2UgYm9uZGluZyBjb25m
aWcgZGlmZmljdWx0LCBlc3BlY2lhbGx5IGZvciBhdXRvIGNvbmZpZy4NCg0KVGhhbmtzLA0KLSBI
YWl5YW5nDQo=
