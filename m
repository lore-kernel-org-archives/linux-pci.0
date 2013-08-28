Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53419 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754735Ab3H1UG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Aug 2013 16:06:56 -0400
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yuval Mintz <yuvalmin@broadcom.com>,
	Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH 0/4] PCIe Capability accessor fix and cleanups
Date: Wed, 28 Aug 2013 20:06:34 +0000
Message-ID: <1377720394.26167.11.camel@jekeller-desk1.amr.corp.intel.com>
References: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
In-Reply-To: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkLCAyMDEzLTA4LTI4IGF0IDEzOjI2IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBUaGUgZmlyc3QgcGF0Y2ggZml4ZXMgYSBMaW5rIENvbnRyb2wgaXNzdWUgcmVwb3J0ZWQgYnkg
WXV2YWwgTWludHouDQo+IFRoZSByZXN0IHNpbXBsaWZ5IHRoZSBjb2RlIGEgYml0Lg0KPiANCj4g
LS0tDQo+IA0KPiBCam9ybiBIZWxnYWFzICg0KToNCj4gICAgICAgUENJOiBBbGxvdyBQQ0llIENh
cGFiaWxpdHkgbGluay1yZWxhdGVkIHJlZ2lzdGVyIGFjY2VzcyBmb3Igc3dpdGNoZXMNCj4gICAg
ICAgUENJOiBSZW1vdmUgUENJZSBDYXBhYmlsaXR5IHZlcnNpb24gY2hlY2tzDQo+ICAgICAgIFBD
STogU3VwcG9ydCBQQ0llIENhcGFiaWxpdHkgU2xvdCByZWdpc3RlcnMgb25seSBmb3IgcG9ydHMg
d2l0aCBzbG90cw0KPiAgICAgICBQQ0k6IFJlbW92ZSBwY2llX2NhcF9oYXNfZGV2Y3RsKCkNCj4g
DQo+IA0KPiAgZHJpdmVycy9wY2kvYWNjZXNzLmMgfCAgIDI2ICsrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25z
KC0pDQoNCkkgbGlrZSB0aGUgY2hhbmdlcyBoZXJlLCBtYWtlcyBpdCBhIGxvdCBtb3JlIHJlYWRh
YmxlLg0KDQpUaGFua3MsDQpKYWtlDQo=
