Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:4017 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeAQTDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 14:03:06 -0500
Subject: Re: [PATCH] pci: Do not read INTx PIN and LINE registers for virtual
 functions
To: Alex Williamson <alex.williamson@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        "=?UTF-8?Q?Jan_H_._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
References: <1516213829-14844-1-git-send-email-karahmed@amazon.de>
 <20180117114944.4835c296@w520.home>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <afe21e82-b75a-107c-05d4-b4037dfd22b7@amazon.com>
Date: Wed, 17 Jan 2018 20:02:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180117114944.4835c296@w520.home>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CgpPbiAwMS8xNy8yMDE4IDA3OjQ5IFBNLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4gT24gV2Vk
LCAxNyBKYW4gMjAxOCAxOTozMDoyOSArMDEwMAo+IEthcmltQWxsYWggQWhtZWQgPGthcmFobWVk
QGFtYXpvbi5kZT4gd3JvdGU6Cj4KPj4gLi4uIHNpbmNlIElOVHggaXMgbm90IHN1cHBvcnRlZCBi
eS1zcGVjIGZvciB2aXJ0dWFsIGZ1bmN0aW9ucy4KPiBCdXQgdGhlIHNwZWMgYWxzbyBzdGF0ZXMg
dGhhdCBWRnMgbXVzdCBpbXBsZW1lbnQgdGhlIGludGVycnVwdCBwaW4KPiByZWdpc3RlciBhcyBy
ZWFkLW9ubHkgemVybywgc28gZWl0aGVyIHRoaXMgaXMgcmVkdW5kYW50IG9yIGl0J3MgYQo+IHdv
cmthcm91bmQgZm9yIFZGcyB0aGF0IGFyZW4ndCBxdWl0ZSBjb21wbGlhbnQ/ICBUaGFua3MsCgpU
aGUgZW5kIGdvYWwgZm9yIG1lIGlzIGp1c3QgdG8gTk9UIGRvIHRoZSByZWFkIGFjcm9zcyB0aGUg
UENJIGJ1cyBmb3Igbm8gCmdvb2QgcmVhc29uLiBXZSBoYXZlIGRldmljZXMgd2l0aCB0aG91c2Fu
ZHMgb2YgdmlydHVhbCBmdW5jdGlvbnMgYW5kIAp0aGlzIHJlYWQgaXMgc2ltcGx5IG5vdCB1c2Vm
dWwgaW4gdGhpcyBjYXNlIGFuZCBjYW4gYmUgb3B0aW1pemVkIGFzIEkgCmRpZC4gU28gZnJvbSBh
IGZ1bmN0aW9uYWxpdHkgcG9pbnQgb2YgdmlldyBwcm9iYWJseSB0aGUgcGF0Y2ggZG9lcyBub3Qg
CmFkZCBhbnkgdmFsdWUgYXMgeW91IG1lbnRpb25lZCwgYnV0IGl0IGlzIHJlYWxseSB1c2VmdWwg
YXMgYSAKbWljcm8tb3B0aW1pemF0aW9uLgoKPgo+IEFsZXgKPgo+PiBDYzogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KPj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcK
Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPj4gU2lnbmVkLW9mZi1ieTogS2Fy
aW1BbGxhaCBBaG1lZCA8a2FyYWhtZWRAYW1hem9uLmRlPgo+PiBTaWduZWQtb2ZmLWJ5OiBKYW4g
SC4gU2Now7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRlPgo+PiAtLS0KPj4gICBkcml2ZXJzL3Bj
aS9wcm9iZS5jIHwgNyArKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMvcGNpL3By
b2JlLmMKPj4gaW5kZXggNjUwOTlkMC4uNjEwMDJmYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9w
Y2kvcHJvYmUuYwo+PiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCj4+IEBAIC0xMjMyLDYgKzEy
MzIsMTMgQEAgc3RhdGljIHZvaWQgcGNpX3JlYWRfaXJxKHN0cnVjdCBwY2lfZGV2ICpkZXYpCj4+
ICAgewo+PiAgIAl1bnNpZ25lZCBjaGFyIGlycTsKPj4gICAKPj4gKwkvKiBWaXJ0dWFsIGZ1bmN0
aW9ucyBkbyBub3QgaGF2ZSBJTlR4IHN1cHBvcnQgKi8KPj4gKwlpZiAoZGV2LT5pc192aXJ0Zm4p
IHsKPj4gKwkJZGV2LT5waW4gPSAwOwo+PiArCQlkZXYtPmlycSA9IDA7Cj4+ICsJCXJldHVybjsK
Pj4gKwl9Cj4+ICsKPj4gICAJcGNpX3JlYWRfY29uZmlnX2J5dGUoZGV2LCBQQ0lfSU5URVJSVVBU
X1BJTiwgJmlycSk7Cj4+ICAgCWRldi0+cGluID0gaXJxOwo+PiAgIAlpZiAoaXJxKQo+CgpBbWF6
b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFj
aGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vuc3RyLiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNm
dWVocmVyOiBEci4gUmFsZiBIZXJicmljaCwgQ2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERF
Mjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAx
NDkxNzMgQgo=
