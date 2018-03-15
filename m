Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0093.outbound.protection.outlook.com ([104.47.42.93]:60600
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751459AbeCOADK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 20:03:10 -0400
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Date: Thu, 15 Mar 2018 00:03:07 +0000
Message-ID: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

V2hlbmV2ZXIgUENJIGJ1cyBpcyBhZGRlZCwgSHlwZXJWIGd1YXJhbnRlZXMgdGhlIEJVUyBpZCBp
cyB1bmlxdWUuIEV2ZW4NCndpdGggdGhhdCB3aGVuIGEgZmlyc3QgZGV2aWNlIGlzIGFkZGVkIHRv
IHRoZSBidXMsIGl0IG92ZXJyaWRlcyBidXMgZG9tYWluDQpJRCB3aXRoIHRoZSBkZXZpY2Ugc2Vy
aWFsIG51bWJlci4gU29tZXRpbWUgdGhpcyBjYW4gcmVzdWx0IGluIEJVUyBJRCBub3QNCmJlaW5n
IHVuaXF1ZS4gSW4gdGhpcyBjYXNlLCB3aGVuIFBDSV9CVVMgYW5kIGEgZGV2aWNlIHRvIGJ1cyBp
cyBhZGRlZCwgdGhlDQpmaXJzdCBkZXZpY2Ugb3ZlcndyaXRlcyB0aGUgYnVzIGRvbWFpbiBJRCB0
byB0aGUgZGV2aWNlIHNlcmlhbCBudW1iZXIsDQp3aGljaCBpcyAwLiBTaW5jZSB0aGVyZSBleHNp
c3QgYSBQQ0kgYnVzIHdpdGggZG9tYWluIElEIDAgYWxyZWFkeSB0aGUgUENJDQpidXMgYWRkaXRp
b24gZmFpbHMuIFRoaXMgcGF0Y2ggbWFrZSBzdXJlIHdoZW4gYSBkZXZpY2UgaXMgYWRkZWQgdG8g
YSBidXMsDQppdCBuZXZlciB1cGRhdGVkIHRoZSBidXMgZG9tYWluIElELiBTaW5jZSB3ZSBoYXZl
IHRoZSB0cmFuc3BhcmVudCBTUklPVg0KbW9kZSBub3csIHRoZSBzaG9ydCBWRiBkZXZpY2UgbmFt
ZSBpcyBubyBsb25nZXIgbmVlZGVkLg0KDQpGaXhlczogNGE5YjA5MzNiZGZjKCJQQ0k6aHY6VXNl
IGRldmljZSBzZXJpYWwgbnVtYmVyIGFzIFBDSSBkb21haW4iKQ0KQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IFNyaWRoYXIgUGl0Y2hhaSA8c3JwaXRjaGFAbWljcm9z
b2Z0LmNvbT4NCi0tLQ0KDQpDaGFuZ2VzIGluIHYzOg0KKiBmaXggdGhlIGNvbW1pdCBjb21tZW50
LiBbS1kgU3Jpbml2YXNhbiwgTWljaGFlbCBLZWxsZXldDQotLS0NCiBkcml2ZXJzL3BjaS9ob3N0
L3BjaS1oeXBlcnYuYyB8IDExIC0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvaG9zdC9wY2ktaHlwZXJ2LmMgYi9k
cml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYw0KaW5kZXggMmZhZjM4ZS4uYWM2N2U1NiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpLWh5cGVydi5jDQorKysgYi9kcml2ZXJzL3Bj
aS9ob3N0L3BjaS1oeXBlcnYuYw0KQEAgLTE1MTgsMTcgKzE1MTgsNiBAQCBzdGF0aWMgc3RydWN0
IGh2X3BjaV9kZXYgKm5ld19wY2ljaGlsZF9kZXZpY2Uoc3RydWN0IGh2X3BjaWJ1c19kZXZpY2Ug
KmhidXMsDQogCWdldF9wY2ljaGlsZChocGRldiwgaHZfcGNpZGV2X3JlZl9jaGlsZGxpc3QpOw0K
IAlzcGluX2xvY2tfaXJxc2F2ZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOw0KIA0K
LQkvKg0KLQkgKiBXaGVuIGEgZGV2aWNlIGlzIGJlaW5nIGFkZGVkIHRvIHRoZSBidXMsIHdlIHNl
dCB0aGUgUENJIGRvbWFpbg0KLQkgKiBudW1iZXIgdG8gYmUgdGhlIGRldmljZSBzZXJpYWwgbnVt
YmVyLCB3aGljaCBpcyBub24temVybyBhbmQNCi0JICogdW5pcXVlIG9uIHRoZSBzYW1lIFZNLiAg
VGhlIHNlcmlhbCBudW1iZXJzIHN0YXJ0IHdpdGggMSwgYW5kDQotCSAqIGluY3JlYXNlIGJ5IDEg
Zm9yIGVhY2ggZGV2aWNlLiAgU28gZGV2aWNlIG5hbWVzIGluY2x1ZGluZyB0aGlzDQotCSAqIGNh
biBoYXZlIHNob3J0ZXIgbmFtZXMgdGhhbiBiYXNlZCBvbiB0aGUgYnVzIGluc3RhbmNlIFVVSUQu
DQotCSAqIE9ubHkgdGhlIGZpcnN0IGRldmljZSBzZXJpYWwgbnVtYmVyIGlzIHVzZWQgZm9yIGRv
bWFpbiwgc28gdGhlDQotCSAqIGRvbWFpbiBudW1iZXIgd2lsbCBub3QgY2hhbmdlIGFmdGVyIHRo
ZSBmaXJzdCBkZXZpY2UgaXMgYWRkZWQuDQotCSAqLw0KLQlpZiAobGlzdF9lbXB0eSgmaGJ1cy0+
Y2hpbGRyZW4pKQ0KLQkJaGJ1cy0+c3lzZGF0YS5kb21haW4gPSBkZXNjLT5zZXI7DQogCWxpc3Rf
YWRkX3RhaWwoJmhwZGV2LT5saXN0X2VudHJ5LCAmaGJ1cy0+Y2hpbGRyZW4pOw0KIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZoYnVzLT5kZXZpY2VfbGlzdF9sb2NrLCBmbGFncyk7DQogCXJldHVy
biBocGRldjsNCi0tIA0KMi43LjQgDQoNCg==
