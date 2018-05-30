Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:24566 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753670AbeE3Qyk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 12:54:40 -0400
From: "Duyck, Alexander H" <alexander.h.duyck@intel.com>
To: "Rustad, Mark D" <mark.d.rustad@intel.com>,
        "mst@redhat.com" <mst@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Liang, Cunming" <cunming.liang@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>
Subject: Re: [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 16:54:35 +0000
Message-ID: <1527699273.29907.2.camel@intel.com>
References: <20180530085521.26583-1-tiwei.bie@intel.com>
         <20180530192010-mutt-send-email-mst@kernel.org>
         <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
In-Reply-To: <414C18B1-30FA-4AC0-B47D-F0FBF9832737@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkLCAyMDE4LTA1LTMwIGF0IDA5OjQ0IC0wNzAwLCBSdXN0YWQsIE1hcmsgRCB3cm90ZToN
Cj4gT24gTWF5IDMwLCAyMDE4LCBhdCA5OjIyIEFNLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+ID4gPiArc3RhdGljIGludCB2aXJ0aW9fcGNpX3NyaW92
X2NvbmZpZ3VyZShzdHJ1Y3QgcGNpX2RldiAqcGNpX2RldiwgaW50ICANCj4gPiA+IG51bV92ZnMp
DQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiA9IHBj
aV9nZXRfZHJ2ZGF0YShwY2lfZGV2KTsNCj4gPiA+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYgPSAmdnBfZGV2LT52ZGV2Ow0KPiA+ID4gKwlpbnQgKCpzcmlvdl9jb25maWd1cmUpKHN0cnVj
dCBwY2lfZGV2ICpwY2lfZGV2LCBpbnQgbnVtX3Zmcyk7DQo+ID4gPiArDQo+ID4gPiArCWlmICgh
KHZkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyh2ZGV2KSAmIFZJUlRJT19DT05GSUdfU19EUklWRVJf
T0spKQ0KPiA+ID4gKwkJcmV0dXJuIC1FQlVTWTsNCj4gPiA+ICsNCj4gPiA+ICsJaWYgKCFfX3Zp
cnRpb190ZXN0X2JpdCh2ZGV2LCBWSVJUSU9fRl9TUl9JT1YpKQ0KPiA+ID4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ID4gPiArDQo+ID4gPiArCXNyaW92X2NvbmZpZ3VyZSA9IHBjaV9zcmlvdl9jb25m
aWd1cmVfc2ltcGxlOw0KPiA+ID4gKwlpZiAoc3Jpb3ZfY29uZmlndXJlID09IE5VTEwpDQo+ID4g
PiArCQlyZXR1cm4gLUVOT0VOVDsNCj4gPiANCj4gPiBCVFcgd2hhdCBpcyBhbGwgdGhpcyB0cmlj
a2VyeSBpbiBhaWQgb2Y/DQo+IA0KPiBXaGVuIFNSLUlPViBzdXBwb3J0IGlzIG5vdCBjb21waWxl
ZCBpbnRvIHRoZSBrZXJuZWwsICANCj4gcGNpX3NyaW92X2NvbmZpZ3VyZV9zaW1wbGUgaXMgI2Rl
ZmluZWQgYXMgTlVMTC4gVGhpcyBhbGxvd3MgaXQgdG8gY29tcGlsZSAgDQo+IGluIHRoYXQgY2Fz
ZSwgZXZlbiB0aG91Z2ggdGhlcmUgaXMgdXR0ZXJseSBubyB3YXkgZm9yIGl0IHRvIGJlIGNhbGxl
ZCBpbiAgDQo+IHRoYXQgY2FzZS4gSXQgaXMgYW4gYWx0ZXJuYXRpdmUgdG8gI2lmcyBpbiB0aGUg
Y29kZS4NCg0KV2h5IGV2ZW4gaGF2ZSB0aGUgY2FsbCB0aG91Z2g/IEkgd291bGQgd3JhcCBhbGwg
b2YgdGhpcyBpbiBhbiAjaWZkZWYNCmFuZCBzdHJpcCBpdCBvdXQgc2luY2UgeW91IGNvdWxkbid0
IHN1cHBvcnQgU1ItSU9WIGlmIGl0IGlzbid0IHByZXNlbnQNCmluIHRoZSBrZXJuZWwgYW55d2F5
Lg==
