Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:58096
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751546AbdFOSN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 14:13:57 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Samuel Sieb' <samuel@sieb.net>, Joerg Roedel <jroedel@suse.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Date: Thu, 15 Jun 2017 18:13:49 +0000
Message-ID: <BN6PR12MB1652DF4130FC792B71DD9974F7C00@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170615140421.GB25710@suse.de>
 <6dd9dbac-9b65-bc7c-bb08-413a05d09fc8@sieb.net>
In-Reply-To: <6dd9dbac-9b65-bc7c-bb08-413a05d09fc8@sieb.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYW11ZWwgU2llYiBbbWFpbHRv
OnNhbXVlbEBzaWViLm5ldF0NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTUsIDIwMTcgMTowMiBQ
TQ0KPiBUbzogSm9lcmcgUm9lZGVsOyBCam9ybiBIZWxnYWFzDQo+IENjOiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBEYW5pZWwgRHJha2U7
DQo+IERldWNoZXIsIEFsZXhhbmRlcjsgRGF2aWQgV29vZGhvdXNlDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjJdIFBDSTogQWRkIEFUUy1kaXNhYmxlIHF1aXJrIGZvciBBTUQgU3RvbmV5IEdQVXMN
Cj4gDQo+IE9uIDA2LzE1LzIwMTcgMDc6MDQgQU0sIEpvZXJnIFJvZWRlbCB3cm90ZToNCj4gPiBI
aSBCam9ybiwNCj4gPg0KPiA+IE9uIEZyaSwgQXByIDA3LCAyMDE3IGF0IDA0OjMyOjE4UE0gKzAy
MDAsIEpvZXJnIFJvZWRlbCB3cm90ZToNCj4gPj4gRnJvbTogSm9lcmcgUm9lZGVsIDxqcm9lZGVs
QHN1c2UuZGU+DQo+ID4+DQo+ID4+IEFUUyBpcyBicm9rZW4gb24gdGhpcyBoYXJkd2FyZSBhbmQg
Y2F1c2VzIElPTU1VIHN0YWxscyBhbmQNCj4gPj4gc3lzdGVtIGZhaWx1cmUuIERpc2FibGUgQVRT
IG9uIHRoZXNlIGRldmljZXMgdG8gbWFrZSB0aGVtDQo+ID4+IHVzYWJsZSBhZ2FpbiB3aXRoIElP
TU1VIGVuYWJsZWQuDQo+ID4+DQo+ID4+IE5vdGUgdGhhdCB0aGUgY29tbWl0IGluIHRoZSBGaXhl
cy10YWcgaXMgbm90IGJ1Z2d5LCBpdA0KPiA+PiBqdXN0IHVuY292ZXJzIHRoZSBwcm9ibGVtIGlu
IHRoZSBoYXJkd2FyZSBieSBpbmNyZWFzaW5nDQo+ID4+IHRoZSBBVFMtZmx1c2ggcmF0ZS4NCj4g
Pj4NCj4gPj4gRml4ZXM6IGIxNTE2YTE0NjU3YSAoJ2lvbW11L2FtZDogSW1wbGVtZW50IGZsdXNo
IHF1ZXVlJykNCj4gPj4gU2lnbmVkLW9mZi1ieTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2Uu
ZGU+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvcGNpL3F1aXJrcy5jIHwgMTkgKysrKysrKysr
KysrKysrKysrKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBBbnkgbW9yZSBvYmplY3Rpb25zIG9uIHRoaXMgcGF0Y2g/IFBsZWFzZSBsZXQgbWUga25v
dyBpZiB5b3Ugd2FudCB0bw0KPiA+IGhhdmUgc29tZXRoaW5nIGNoYW5nZWQuDQo+IA0KPiBUaGUg
b3RoZXIgcGF0Y2ggc2VlbXMgdG8gZml4IHRoaXMgaXNzdWUgd2l0aG91dCBkaXNhYmxpbmcgQVRT
LiAgSXNuJ3QNCj4gdGhhdCBiZXR0ZXI/DQoNCkkgdGFsa2VkIHRvIG91ciB2YWxpZGF0aW9uIHRl
YW0gYW5kIEFUUyB3YXMgdmFsaWRhdGVkIG9uIFN0b25leSwgc28gdGhpcyBwYXRjaCBpcyBqdXN0
IHdvcmtpbmcgYXJvdW5kIHNvbWV0aGluZyBlbHNlLiAgVGhlIG90aGVyIHBhdGNoIGZpeGVzIGl0
IGFuZCBpcyBhIHZhbGlkIG9wdGltaXphdGlvbiAoaXQgc2hvdWxkIGJlIGFwcGxpZWQgZXZlbnR1
YWxseSksIGJ1dCBhcHBhcmVudGx5IHRoZSBjdXJyZW50IGJlaGF2aW9yIGlzIGFsbG93ZWQgZXZl
biBpZiBpdCdzIG5vdyBvcHRpbWFsLiAgSSdtIG5vdCByZWFsbHkgYW4gQVRTIGV4cGVydC4NCg0K
QWxleA0KDQo=
