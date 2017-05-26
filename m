Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:30912
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S940894AbdEZP7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 May 2017 11:59:05 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'David Woodhouse' <dwmw2@infradead.org>,
        'Joerg Roedel' <jroedel@suse.de>,
        "Bridgman, John" <John.Bridgman@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
CC: 'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Samuel Sieb <samuel@sieb.net>
Subject: RE: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Date: Fri, 26 May 2017 15:59:01 +0000
Message-ID: <BN6PR12MB1652314B2ADF513F900D07BAF7FC0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
         <BN6PR12MB1652634583ADBB2C93E1414DF70C0@BN6PR12MB1652.namprd12.prod.outlook.com>
         <1493893297.4904.71.camel@infradead.org>
         <BN6PR12MB1652A0F240C19F2CF3304300F7F90@BN6PR12MB1652.namprd12.prod.outlook.com>
         <20170524084450.GB12353@suse.de>
         <BN6PR12MB16525FC9DD12723017F143EDF7FC0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <1495803280.26190.37.camel@infradead.org>
In-Reply-To: <1495803280.26190.37.camel@infradead.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBXb29kaG91c2UgW21h
aWx0bzpkd213MkBpbmZyYWRlYWQub3JnXQ0KPiBTZW50OiBGcmlkYXksIE1heSAyNiwgMjAxNyA4
OjU1IEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXI7ICdKb2VyZyBSb2VkZWwnDQo+IENjOiAn
Sm9lcmcgUm9lZGVsJzsgQmpvcm4gSGVsZ2FhczsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhbmllbCBEcmFrZTsgU2FtdWVsIFNp
ZWINCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gUENJOiBBZGQgQVRTLWRpc2FibGUgcXVpcmsg
Zm9yIEFNRCBTdG9uZXkgR1BVcw0KPiANCj4gT24gRnJpLCAyMDE3LTA1LTI2IGF0IDExOjU3ICsw
MDAwLCBEZXVjaGVyLCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4NCj4gPiBGV0lXLCB0aGUgR1BVIGRy
aXZlciBkb2VzIG5vdCBhY3R1YWxseSB1c2UgQVRTIGF0IHRoZSBtb21lbnQgc28gSQ0KPiA+IGRv
bid0IHRoaW5rIHdlIHNob3VsZCBzZWUgYW55IEFUUyB0cmFuc2FjdGlvbnMuDQo+IA0KPiBUaGF0
J3MgYSBjb25mdXNpbmcgc2VudGVuY2UuIFRoZSAiR1BVIGRyaXZlciIsIGlmIHlvdSBtZWFuIHNv
ZnR3YXJlDQo+IHJ1bm5pbmcgaW4gdGhlIE9TLCB3b3VsZG4ndCBiZSBleHBlY3RlZCB0byBoYXZl
IGFueXRoaW5nIHRvIGRvIHdpdGgNCj4gQVRTLg0KPiANCj4gQVRTIGlzIHNvbWV0aGluZyB0aGF0
IHRoZSBDUFUgaXRzZWxmIChvciBpdHMgRE1BIGVuZ2luZSkgd291bGQgZG8uDQo+IEluc3RlYWQg
b2YganVzdCBwZXJmb3JtaW5nIGEgRE1BIHRyYW5zYWN0aW9uIHRvIGEgZ2l2ZW4gYnVzIGFkZHJl
c3MsDQo+IGFuZCBsZXR0aW5nIHRoZSBJT01NVSBkbyB0aGUgdHJhbnNsYXRpb24sIHRoZSBoYXJk
d2FyZSBtaWdodCBjaG9vc2UgdG8NCj4gZmlyc3QgcGVyZm9ybSBhbiBJT1RMQiBsb29rdXAsIGFu
ZCB0aGVuIGxhdGVyIGRvIHRoZSBhY3R1YWwgRE1BDQo+IHRyYW5zYWN0aW9uIHRvIHRoZSBwcmUt
dHJhbnNsYXRlZCwgcmF3IHBoeXNpY2FsIGFkZHJlc3MuIFdoaWNoIGtpbmQgb2YNCj4gbWFrZXMg
YSBtb2NrZXJ5IG9mIGFueSBraW5kIG9mIHByb3RlY3Rpb24gdGhlIElPTU1VIGlzIHN1cHBvc2Vk
IHRvIGdpdmUNCj4geW91LCBidXQgZG9lcyBzaGF2ZSBhIGN5Y2xlIG9yIHR3byBvZiBsYXRlbmN5
IG9mZiB0aGUgRE1BIHdoZW4gaXQNCj4gZmluYWxseSBoYXBwZW5zLCBzaW5jZSB0aGUgdHJhbnNs
YXRpb24gY2FuIGJlIGRvbmUgaW4gYWR2YW5jZS4NCg0KKyBKb2huLCBTdXJhdmVlDQoNCkZ1bGwg
ZGlzY2xvc3VyZSwgSSdtIG5vdCBieSBhbnkgbWVhbnMgYW4gZXhwZXJ0IHdpdGggQVRTLiAgSSBn
dWVzcyBJJ20gdGhpbmtpbmcgb2YgUFJJIHN1cHBvcnQgcmF0aGVyIHRoYW4gQVRTIHBlciBzZS4g
IE9uIHRoZSBHUFUgc2lkZSB0aGUgR1BVJ3MgbWVtb3J5IGNvbnRyb2xsZXIgaGFzIG11bHRpcGxl
IHBhdGhzIHRvIHN5c3RlbSBtZW1vcnksIHRoZSBub24tQVRTL1BSSSBwYXRoIGFuZCB0aGUgQVRT
L1BSSSBwYXRoLiAgVGhlIEdQVSBoYXMgaXRzIG93biBpbnRlZ3JhdGVkIE1NVSB0byB2aXJ0dWFs
aXplIHRoZSBHUFUncyBpbnRlcm5hbCBhZGRyZXNzIHNwYWNlIHBlciBHUFUgY2xpZW50LiAgVGhl
IG5vbi1BVFMvUFJJIHBhdGggdXNlcyB0aGUgR1BVJ3MgTU1VIGFuZCBpcyBqdXN0ICJyZWd1bGFy
IiBkbWEgdG8gYWRkcmVzc2VzIHBvdGVudGlhbGx5IHRyYW5zbGF0ZWQgYnkgdGhlIElPTU1VIGp1
c3QgbGlrZSBhbnkgb3RoZXIgZGV2aWNlIHRoYXQgbWF5IG5vdCBoYXZlIEFUUyBzdXBwb3J0LiAg
VGhlIHN5c3RlbSBtZW1vcnkgaGFzIHRvIGJlIHJlc2lkZW50IGJlY2F1c2UgaWYgdGhlIEdQVSBm
YXVsdHMsIGl0IGNhbid0IHJldHJ5IHRoZSB0cmFuc2FjdGlvbi4gIEZvciB0aGUgQVRTL1BSSSBw
YXRoLCB0aGUgR1BVJ3MgTU1VIGlzIGJ5cGFzc2VkIGFuZCBQQVNJRHMgbmVlZCB0byBiZSBzZXR1
cCBvbiB0aGUgSU9NTVUgZm9yIGVhY2ggY2xpZW50LCBidXQgb25jZSBkb25lLCB0cmFuc2FjdGlv
bnMgdGhhdCB1c2UgdGhhdCBpbnRlcmZhY2Ugc3VwcG9ydCByZXRyaWVzIG9uIEdQVSBwYWdlIGZh
dWx0cyAoYWZ0ZXIgdGhlIE9TIGhhZCBwYWdlZCB0aGUgbWVtb3J5IGluIGFuZCB0aGUgSU9NTVUg
dGFibGVzIGJlZW4gdXBkYXRlZCkgYW5kIG90aGVyIGZlYXR1cmVzLiAgSSB0aGluayBvbmx5IHRo
ZSBBVFMvUFJJIGNhc2UgdXNlcyB0aGUgQVRDIG9uIHRoZSBlbmQgcG9pbnQuICBKb2huLCBTdXJh
dmVlLCBjb3JyZWN0IG1lIGlmIEknbSB3cm9uZy4NCg0KQWxleA0KDQo=
