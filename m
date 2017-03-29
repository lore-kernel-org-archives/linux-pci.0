Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48545 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932294AbdC2SCF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2017 14:02:05 -0400
From: Wei Zhang <wzhang@fb.com>
To: Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@fb.com>, Chris Petersen <cpetersen@fb.com>,
        Krishna Dhulipala <krishnad@fb.com>
Subject: Re: [PATCHv6 0/5] Limiting PCI access
Date: Wed, 29 Mar 2017 18:01:26 +0000
Message-ID: <78716267-0C57-49ED-8602-68E4F6868B3B@fb.com>
References: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
In-Reply-To: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgRm9sa3MsDQoNClRoaXMgc2VyaWVzIG9mIHBhdGNoZXMgaXMgY3JpdGljYWwgaW4gc3VwcG9y
dGluZyB0aGUgTlZNZSBTU0QgaG90IHBsdWcgb24gdGhlIEZsYXNoIEpCT0YgcGxhdGZvcm1zIHN1
Y2ggRmFjZWJvb2svT0NQIExpZ2h0bmluZy4gIFRoZSBQQ0llIGhvdHBsdWcgaW1wcm92ZW1lbnRz
IGhhdmUgYmVlbiBwcmVzZW50ZWQgaW4gbXVsdGlwbGUgY29uZmVyZW5jZXMgKG5hbWVseSBPQ1Ag
U3VtbWl0IDE3IGluIFNhbnRhIENsYXJhIGFuZCBMaW51eCBWYXVsdCAxNyBpbiBDYW1icmlkZ2Up
IGluIHRoZSBwYXN0IG1vbnRoLiAgVGhlc2UgY2hhbmdlcyBoYXZlIGJlZW4gdmFsaWRhdGVkIGJ5
IHRoZSBGYWNlYm9vayBpbnRlcm5hbCB0ZXN0aW5nIGFzIHdlbGwgYXMgbXVsdGlwbGUgT0RNIHZl
bmRvcnMgdGVzdGluZyB0ZWFtcy4gIA0KDQpBcmUgdGhlcmUgYWRkaXRpb25hbCBjb21tZW50cyBv
biB0aGlzPyAgSSB0YWxrZWQgdG8gS2VpdGggYXQgdGhlIFZhdWx0IGxhc3Qgd2Vlay4gIEhlIG1l
bnRpb25lZCB0aGVyZSB3YXMgbm8gb3V0c3RhbmRpbmcgcmV2aWV3IGZlZWRiYWNrIHRvIGJlIGFk
ZHJlc3NlZC4gICBXZSB3b3VsZCBhcHByZWNpYXRlIGlmIHdlIGNhbiB1cHN0cmVhbSB0aGlzIHBh
dGNoIEFTQVAhDQoNClRlc3RlZC1ieTogS3Jpc2huYSBEaHVsaXBhbGEgPGtyaXNobmFkQGZiLmNv
bT4NClJldmlld2VkLWJ5OiBXZWkgWmhhbmcgPHd6aGFuZ0BmYi5jb20+DQoNClRoYW5rcyENCi1X
ZWkNCg0KLS0NCndlaSB6aGFuZyB8IHNvZnR3YXJlIGVuZ2luZWVyIHwgZmFjZWJvb2sNCnd6aGFu
Z0BmYi5jb20gfCAoNDA4KSA0NjAtNDgwMw0KDQpPbiAyLzcvMTcsIDExOjMyIEFNLCAiS2VpdGgg
QnVzY2giIDxrZWl0aC5idXNjaEBpbnRlbC5jb20+IHdyb3RlOg0KDQogICAgVGhlIGNvZGUgaXMg
ZnVuY3Rpb25hbGx5IGVxdWl2YWxlbnQgdG8gdjUuIEkndmUgZml4ZWQgdGhlIHN0eWxlDQogICAg
cG9pbnRzIG1lbnRpb25lZCBpbiByZXZpZXcgb24gbGluZSB3YXJwcGluZywgYWRqdXN0ZWQgdGhl
IGNoYW5nZSBsb2cNCiAgICBvbiB0aGUgbXNpL21zaXggc2tpcHBhZ2UgdG8gbm90IGV4Y2x1ZGUg
bWVudGlvbmluZyBtc2ksIGFuZCBhZGRlZCB0aGUNCiAgICBhY2N1bXVsYXRlZCBSZXZpZXdlZC1i
eSdzLg0KICAgIA0KICAgIEtlaXRoIEJ1c2NoICg1KToNCiAgICAgIHBjaTogRXhwb3J0IHBjaSBk
ZXZpY2UgY29uZmlnIGFjY2Vzc29ycw0KICAgICAgcGNpOiBBZGQgZGV2aWNlIGRpc2Nvbm5lY3Rl
ZCBzdGF0ZQ0KICAgICAgcGNpOiBObyBjb25maWcgYWNjZXNzIGZvciBkaXNjb25uZWN0ZWQgZGV2
aWNlcw0KICAgICAgcGNpL21zaXg6IFNraXAgZGlzYWJsaW5nIGRpc2Nvbm5lY3RlZCBkZXZpY2Vz
DQogICAgICBwY2k6IFF1aWNrIHJldHVybiBmb3IgcGNpX2RldmljZV9pc19wcmVzZW50DQogICAg
DQogICAgIGRyaXZlcnMvcGNpL2FjY2Vzcy5jICAgICAgICAgICAgIHwgNTYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KICAgICBkcml2ZXJzL3BjaS9ob3RwbHVnL3Bj
aWVocF9wY2kuYyB8ICA2ICsrKysrDQogICAgIGRyaXZlcnMvcGNpL21zaS5jICAgICAgICAgICAg
ICAgIHwgIDcgKysrKy0NCiAgICAgZHJpdmVycy9wY2kvcGNpLmMgICAgICAgICAgICAgICAgfCAg
MiArKw0KICAgICBkcml2ZXJzL3BjaS9wY2kuaCAgICAgICAgICAgICAgICB8IDE0ICsrKysrKysr
KysNCiAgICAgZHJpdmVycy9wY2kvcGNpZS9wY2llLWRwYy5jICAgICAgfCAgNSArKysrDQogICAg
IGluY2x1ZGUvbGludXgvcGNpLmggICAgICAgICAgICAgIHwgMzQgKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tDQogICAgIDcgZmlsZXMgY2hhbmdlZCwgOTcgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRp
b25zKC0pDQogICAgDQogICAgLS0gDQogICAgMi43LjINCiAgICANCiAgICANCg0K
