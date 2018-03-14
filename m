Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0135.outbound.protection.outlook.com ([104.47.38.135]:20480
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751170AbeCNT4R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 15:56:17 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2]PCI: hv: fix PCI-BUS domainID corruption
Date: Wed, 14 Mar 2018 19:56:13 +0000
Message-ID: <DM5PR2101MB103077541F5DDC9B1355E71FDCD10@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <048A5571-8706-496C-99FB-35A0CF506A8B@microsoft.com>
 <3110FB76-7E16-4240-A5C0-135DD0E6EEE6@microsoft.com>
In-Reply-To: <3110FB76-7E16-4240-A5C0-135DD0E6EEE6@microsoft.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTcmlkaGFyIFBpdGNoYWkNCj4g
U2VudDogV2VkbmVzZGF5LCBNYXJjaCAxNCwgMjAxOCAxMTowOCBBTQ0KPiBUbzogTG9yZW56byBQ
aWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBNaWNoYWVsIEtlbGxleSAoRU9T
RykNCj4gPE1pY2hhZWwuSC5LZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IEJqb3JuIEhlbGdh
YXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBKYWtlIE9zaGlucyA8amFrZW9AbWljcm9zb2Z0LmNv
bT47IEhhaXlhbmcNCj4gWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBTdGVwaGVuIEhl
bW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47IERleHVhbg0KPiBDdWkgPGRlY3VpQG1p
Y3Jvc29mdC5jb20+OyBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47DQo+IGRldmVs
QGxpbnV4ZHJpdmVycHJvamVjdC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyXVBDSTogaHY6IGZp
eCBQQ0ktQlVTIGRvbWFpbklEIGNvcnJ1cHRpb24NCj4gDQo+ICAgICBXaGVuZXZlciBQQ0kgYnVz
IGlzIGFkZGVkLCBIeXBlclYgZ3VhcmFudGVlcyB0aGUgQlVTIGlkIGlzIHVuaXF1ZS4gRXZlbiB3
aXRoDQo+ICAgICB0aGF0IHdoZW4gYSBmaXJzdCBkZXZpY2UgaXMgYWRkZWQgdG8gdGhlIGJ1cywg
aXQgb3ZlcnJpZGVzIGJ1cyBkb21haW4gSUQgd2l0aA0KPiAgICAgdGhlIGRldmljZSBzZXJpYWwg
bnVtYmVyLiBTb21ldGltZSB0aGlzIGNhbiByZXN1bHQgaW4gQlVTIElEIG5vdCBiZWluZyB1bmlx
dWUuDQo+ICAgICBJbiB0aGlzIGNhc2UsIHdoZW4gUENJX0JVUyBhbmQgYSBkZXZpY2UgYWRkZWQg
dG8gdGhlIGJ1cywgZXZlbiBiZWZvcmUgdGhlIFBDSQ0KPiAgICAgQlVTIGlzIGFkZGVkIHRvIGtl
cm5lbCwgdGhlIGZpcnN0IGRldmljZSB0ZW5kcyB0byBvdmVyd3JpdGUgdGhlIGRvbWFpbiBJRCB3
aXRoDQo+ICAgICAwLiBTaW5jZSB0aGVyZSBleGlzdHMgYSBQQ0kgYnVzIHdpdGggZG9tYWluIElE
IDAgYWxyZWFkeSB0aGUgUENJIGJ1cyBhZGRpdGlvbg0KPiAgICAgZmFpbHMuIFRoaXMgcGF0Y2gg
bWFrZSBzdXJlIHdoZW4gYSBkZXZpY2UgaXMgYWRkZWQgdG8gYSBidXMsIGl0IG5ldmVyIHVwZGF0
ZWQNCj4gICAgIHRoZSBidXMgZG9tYWluIElELiBTaW5jZSB3ZSBoYXZlIHRoZSB0cmFuc3BhcmVu
dCBTUklPViBtb2RlIG5vdywgdGhlIHNob3J0IFZGDQo+ICAgICBkZXZpY2UgbmFtZSBpcyBubyBs
b25nZXIgbmVlZGVkLg0KPiANCj4gICAgIEZpeGVzOiA0YTliMDkzM2JkZmMoIlBDSTpodjpVc2Ug
ZGV2aWNlIHNlcmlhbCBudW1iZXIgYXMgUENJIGRvbWFpbiIpDQo+ICAgICBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiAgICAgU2lnbmVkLW9mZi1ieTogU3JpZGhhciBQaXRjaGFpIDxzcnBp
dGNoYUBtaWNyb3NvZnQuY29tPg0KPiAgICAgLS0tDQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtl
bGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCg==
