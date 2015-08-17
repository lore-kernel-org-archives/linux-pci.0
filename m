Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47840 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbbHQXcn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 17 Aug 2015 19:32:43 -0400
From: "Jiang, Dave" <dave.jiang@intel.com>
To: "Busch, Keith" <keith.busch@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCIE: Remove symbol export for pcie_set_mps()
Date: Mon, 17 Aug 2015 23:32:41 +0000
Message-ID: <1439854361.3253.23.camel@intel.com>
References: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
	 <1438208335-19457-4-git-send-email-keith.busch@intel.com>
	 <20150817223136.GL26431@google.com>
In-Reply-To: <20150817223136.GL26431@google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gTW9uLCAyMDE1LTA4LTE3IGF0IDE3OjMxIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIEp1bCAyOSwgMjAxNSBhdCAwNDoxODo1NVBNIC0wNjAwLCBLZWl0aCBCdXNjaCB3
cm90ZToNCj4gPiBGcm9tOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gPiAN
Cj4gPiBUaGUgc2V0dGluZyBvZiBQQ0llIE1QUyBzaG91bGQgYmUgbGVmdCB0byB0aGUgUENJIHN1
YnN5c3RlbSBhbmQgbm90DQo+ID4gdGhlIGRyaXZlci4gQW4gaWxsIGNvbmZpZ3VyZWQgTVBTIGJ5
IHRoZSBkcml2ZXIgY291bGQgY2F1c2UgdGhlIA0KPiA+IGRldmljZQ0KPiA+IHRvIG5vdCBmdW5j
dGlvbiBvciB1bnN0YWJsaXplIHRoZSBlbnRpcmUgc3lzdGVtLiBSZW1vdmluZyB0aGUgDQo+ID4g
ZXhwb3J0ZWQNCj4gPiBzeW1ib2wuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2ZSBKaWFu
ZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL3BjaS5j
IHwgICAgMSAtDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS5jIGIvZHJpdmVycy9wY2kvcGNpLmMNCj4gPiBp
bmRleCAwMDA4Yzk1Li45MjM0OWVlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaS5j
DQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmMNCj4gPiBAQCAtNDEyMSw3ICs0MTIxLDYgQEAg
aW50IHBjaWVfc2V0X21wcyhzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgDQo+ID4gbXBzKQ0KPiA+
ICAJcmV0dXJuIHBjaWVfY2FwYWJpbGl0eV9jbGVhcl9hbmRfc2V0X3dvcmQoZGV2LCANCj4gPiBQ
Q0lfRVhQX0RFVkNUTCwNCj4gPiAgCQkJCQkJIA0KPiA+ICBQQ0lfRVhQX0RFVkNUTF9QQVlMT0FE
LCB2KTsNCj4gPiAgfQ0KPiA+IC1FWFBPUlRfU1lNQk9MKHBjaWVfc2V0X21wcyk7DQo+IA0KPiBJ
IHRoaW5rIHRoZSBwY2llX3NldF9tcHMoKSBkZWNsYXJhdGlvbiBjb3VsZCBiZSBtb3ZlZCBmcm9t
DQo+IGluY2x1ZGUvbGludXgvcGNpLmggdG8gZHJpdmVycy9wY2kvcGNpLmgsIGNvdWxkbid0IGl0
Pw0KDQpPay4=
