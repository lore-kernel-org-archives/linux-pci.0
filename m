Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:29567 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeE3Q0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 12:26:32 -0400
From: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
To: "mst@redhat.com" <mst@redhat.com>,
        "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 16:26:30 +0000
Message-ID: <1527697588.16245.136.camel@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
         <CAKgT0UcRZd5ajpTyC3KMvNFACVAb6D8A9Tss3m0r+UdamvVeRA@mail.gmail.com>
         <20180530192215-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180530192215-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTMwIGF0IDE5OjIyICswMzAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFdlZCwgTWF5IDMwLCAyMDE4IGF0IDA5OjEwOjU3QU0gLTA3MDAsIEFsZXhhbmRl
ciBEdXljayB3cm90ZToNCj4gPiBPbiBXZWQsIE1heSAzMCwgMjAxOCBhdCAxOjU1IEFNLCBUaXdl
aSBCaWUgPHRpd2VpLmJpZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gVGhlcmUgaXMgYSBuZXcg
ZmVhdHVyZSBiaXQgYWxsb2NhdGVkIGluIHZpcnRpbyBzcGVjIHRvDQo+ID4gPiBzdXBwb3J0IFNS
LUlPViAoU2luZ2xlIFJvb3QgSS9PIFZpcnR1YWxpemF0aW9uKToNCj4gPiA+IA0KPiA+ID4gaHR0
cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvMTENCj4gPiA+IA0K
PiA+ID4gVGhpcyBwYXRjaCBlbmFibGVzIHRoZSBzdXBwb3J0IGZvciB0aGlzIGZlYXR1cmUgYml0
IGluDQo+ID4gPiB2aXJ0aW8gZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBU
aXdlaSBCaWUgPHRpd2VpLmJpZUBpbnRlbC5jb20+DQo+ID4gDQo+ID4gU28gZnJvbSBhIHF1aWNr
IGdsYW5jZSBpdCBsb29rcyBsaWtlIHdlIGFyZSBsZWF2aW5nIFNSLUlPViBlbmFibGVkIGlmDQo+
ID4gdGhlIGRyaXZlciBpcyByZW1vdmVkLiBEbyB3ZSB3YW50IHRvIGhhdmUgdGhhdCBiZWhhdmlv
ciBvciBzaG91bGQgd2UNCj4gPiBiZSBhZGRpbmcgdGhlIGNvZGUgdG8gZGlzYWJsZSBTUi1JT1Yg
YW5kIGZyZWUgdGhlIFZGcyBvbiBkcml2ZXINCj4gPiByZW1vdmFsPw0KPiANCj4gQ291bGQgcGNp
IGNvcmUgaGFuZGxlIGl0IGZvciB1cyBzb21laG93Pw0KDQpNYXliZSwgYnV0IGl0IHdvdWxkIHJl
cXVpcmUgY2hhbmdlcyB0byB0aGUgcGNpIGNvcmUgdG8gZG8gaXQuDQoNClRoZSBwcm9ibGVtIGlz
IHNvbWUgZHJpdmVycyB3YW50IHRvIGxlYXZlIHRoZSBWRnMgdGhlcmUgc2luY2UgdGhlIFBGDQpk
b2Vzbid0IHJlYWxseSBkbyBhbnl0aGluZywgb3IgdGhleSBoYXZlIHRoZSBvcHRpb24gb2YgZXNz
ZW50aWFsbHkNCnB1dHRpbmcgdGhlIFZGcyBpbnRvIGEgc3RhbmRieSBzdGF0ZSB3aGVuIHRoZSBQ
RiBpcyBnb25lLg0KDQpNeSBtYWluIGNvbmNlcm4gaXMgZG8gd2UgY2FyZSBpZiBWRnMgYXJlIGFs
bG9jYXRlZCBhbmQgdGhlbiBzb21lYm9keQ0KcmVtb3ZlcyB0aGUgZHJpdmVyIGFuZCBiaW5kcyBh
IGRpZmZlcmVudCBkcml2ZXIgdG8gdGhlIGludGVyZmFjZT8gSWYNCm5vdCB0aGVuIHRoaXMgY29k
ZSBhbmQgYmUgbGVmdCBhcyBpcywgYnV0IEkganVzdCB3YW50ZWQgdG8gYmUgY2VydGFpbg0Kc2lu
Y2UgSSBrbm93IHRoaXMgaXNuJ3QganVzdCBlbmFibGluZyBTUi1JT1Ygd2UgYXJlIGhhdmluZyB0
byBkbyBhDQpudW1iZXIgb2Ygb3RoZXIgY2hlY2tzIGFnYWluc3QgdGhlIHZpcnRpbyBkZXZpY2Uu
