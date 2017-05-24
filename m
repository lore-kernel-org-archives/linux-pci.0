Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0063.outbound.protection.outlook.com ([104.47.34.63]:32365
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1764211AbdEXM46 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 08:56:58 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Joerg Roedel' <jroedel@suse.de>
CC: 'David Woodhouse' <dwmw2@infradead.org>,
        'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        "Samuel Sieb" <samuel@sieb.net>
Subject: RE: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Date: Wed, 24 May 2017 12:56:49 +0000
Message-ID: <BN6PR12MB1652DBB703ED7B98F5C17FC5F7FE0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652634583ADBB2C93E1414DF70C0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <1493893297.4904.71.camel@infradead.org>
 <BN6PR12MB1652A0F240C19F2CF3304300F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170524084450.GB12353@suse.de>
In-Reply-To: <20170524084450.GB12353@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VyZyBSb2VkZWwgW21haWx0
bzpqcm9lZGVsQHN1c2UuZGVdDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI0LCAyMDE3IDQ6NDUg
QU0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlcg0KPiBDYzogJ0RhdmlkIFdvb2Rob3VzZSc7ICdK
b2VyZyBSb2VkZWwnOyBCam9ybiBIZWxnYWFzOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGFuaWVsIERyYWtlOyBTYW11ZWwNCj4g
U2llYg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IEFkZCBBVFMtZGlzYWJsZSBxdWly
ayBmb3IgQU1EIFN0b25leSBHUFVzDQo+IA0KPiBIaSBBbGV4YW5kZXIsDQo+IA0KPiBPbiBUdWUs
IE1heSAyMywgMjAxNyBhdCAwNzo1NDoxMlBNICswMDAwLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3Jv
dGU6DQo+ID4gSSBmaW5hbGx5IGdvdCBhbiBhbnN3ZXIgZnJvbSB0aGUgaHcgdGVhbSBhbmQgd2Ug
dmFsaWRhdGVkIEFUUyBvbg0KPiA+IHN0b25leSBhcyB3ZWxsIHNvIGluIHRoZW9yeSB0aGlzIHBh
dGNoIHNob3VsZG7igJl0IGFjdHVhbGx5IGJlIG5lZWRlZC4NCj4gPiBJIHRoaW5rIHdlIG1heSBh
Y3R1YWxseSBiZSBwYXBlcmluZyBvdmVyIHNvbWUgb3RoZXIgaXNzdWUuICBUaGUNCj4gPiBmb2xs
b3dpbmcgcGF0Y2ggc2VlbXMgdG8gYWxzbyBmaXggdGhpcyBpc3N1ZSAoYW5kIG90aGVyIGlzc3Vl
cyk6DQo+ID4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvc3RhYmxlL21zZzE3MjYzMS5o
dG1sDQo+IA0KPiBZZWFoLCBidXQgaXQgc3RpbGwgbG9va3MgdG8gbWUgbGlrZSB0aGF0IHRoZSBo
YXJkd2FyZSBnb3QgaW50byBzb21lDQo+IHdlaXJkIHN0YXRlIHdpdGggdGhlIHN0b3JtIG9mIEFU
UyBpbnZhbGlkYXRpb25zIHNlbnQgdG8gaXQuDQo+IA0KPiBUaGUgQ29tcGxldGlvbi1XYWl0IGxv
b3AgdGltZW91dHMgc2VlbiBpbiB0aGUgb3JpZ2luYWwgYnVnIHJlcG9ydA0KPiBpbmRpY2F0ZSB0
aGF0IHRoZSBJT01NVSBpcyB3YWl0aW5nIGZvciBhIHJlc3BvbnNlIHRoYXQgbmV2ZXIgY29tZXMu
IEFuZA0KPiB0aGlzIGlzIHByb2JhYmx5IHRoZSBBVFMgZmx1c2ggY29tcGxldGlvbiByZXNwb25z
ZSBmcm9tIHRoZSBHUFUsIGFzDQo+IGRpc2FibGluZyBBVFMgb24gdGhlIEdQVSBtYWtlcyB0aGUg
aXNzdWUgZGlzYXBwZWFyLg0KDQpZZWFoLCBpdCdzIHdlaXJkLiAgTXkgYWNrIG9uIHRoZSBwYXRj
aCBzdGlsbCBzdGFuZHMuICBKdXN0IGFkZGluZyBzb21lIGFkZGl0aW9uYWwgZGF0YS4NCg0KQWxl
eA0KDQo=
