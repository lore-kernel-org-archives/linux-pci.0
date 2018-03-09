Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:56480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750918AbeCIFCh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 00:02:37 -0500
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: hv: fix bus domain ID corruption
Date: Fri, 9 Mar 2018 05:02:34 +0000
Message-ID: <19EE9647-AE9B-443E-ADBD-51CCEFC3EDEA@microsoft.com>
References: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
In-Reply-To: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

V2hlbiBQQ0kgQlVTIGlzIGFkZGVkLCBQQ0lfQlVTIGRvbWFpbiBJRCBpcyBzZXQuIFdoZW4gUENJ
X0JVUyBhbmQgYSBkZXZpY2UNCmFkZGVkIHRvIHRoZSBidXMgaXMgcmFjaW5nIGFnYWluc3QgZWFj
aCBvdGhlciwgdGhlIGZpcnN0IGRldmljZSB0ZW5kcyB0bw0Kb3ZlcndyaXRlIHRoZSBkb21haW4g
SUQuIEluIG9yZGVyIHRvIGF2b2lkIHRoZSByYWNlLCB0aGlzIHBhdGNoIG1ha2Ugc3VyZQ0Kd2hl
biBhIGRldmljZSBpcyBhZGRlZCB0byBhIGJ1cywgaXQgbmV2ZXIgdXBkYXRlZCB0aGUgYnVzIGRv
bWFpbiBJRC4gU2luY2UNCndlIGhhdmUgdGhlIHRyYW5zcGFyZW50IFNSSU9WIG1vZGUgbm93LCB0
aGUgc2hvcnQgVkYgZGV2aWNlIG5hbWUgaXMgbm8NCmxvbmdlciBuZWVkZWQuDQoNCkZpeGVzOiA0
YTliMDkzM2JkZmMoIlBDSTpodjpVc2UgZGV2aWNlIHNlcmlhbCBudW1iZXIgYXMgUENJIGRvbWFp
biIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogU3JpZGhhciBQ
aXRjaGFpIDxzcnBpdGNoYUBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9wY2kvaG9zdC9w
Y2ktaHlwZXJ2LmMgfCAxMSAtLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpLWh5cGVydi5jIGIvZHJp
dmVycy9wY2kvaG9zdC9wY2ktaHlwZXJ2LmMNCmluZGV4IDJmYWYzOGUuLmFjNjdlNTYgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYw0KKysrIGIvZHJpdmVycy9wY2kv
aG9zdC9wY2ktaHlwZXJ2LmMNCkBAIC0xNTE4LDE3ICsxNTE4LDYgQEAgc3RhdGljIHN0cnVjdCBo
dl9wY2lfZGV2ICpuZXdfcGNpY2hpbGRfZGV2aWNlKHN0cnVjdCBodl9wY2lidXNfZGV2aWNlICpo
YnVzLA0KIAlnZXRfcGNpY2hpbGQoaHBkZXYsIGh2X3BjaWRldl9yZWZfY2hpbGRsaXN0KTsNCiAJ
c3Bpbl9sb2NrX2lycXNhdmUoJmhidXMtPmRldmljZV9saXN0X2xvY2ssIGZsYWdzKTsNCiANCi0J
LyoNCi0JICogV2hlbiBhIGRldmljZSBpcyBiZWluZyBhZGRlZCB0byB0aGUgYnVzLCB3ZSBzZXQg
dGhlIFBDSSBkb21haW4NCi0JICogbnVtYmVyIHRvIGJlIHRoZSBkZXZpY2Ugc2VyaWFsIG51bWJl
ciwgd2hpY2ggaXMgbm9uLXplcm8gYW5kDQotCSAqIHVuaXF1ZSBvbiB0aGUgc2FtZSBWTS4gIFRo
ZSBzZXJpYWwgbnVtYmVycyBzdGFydCB3aXRoIDEsIGFuZA0KLQkgKiBpbmNyZWFzZSBieSAxIGZv
ciBlYWNoIGRldmljZS4gIFNvIGRldmljZSBuYW1lcyBpbmNsdWRpbmcgdGhpcw0KLQkgKiBjYW4g
aGF2ZSBzaG9ydGVyIG5hbWVzIHRoYW4gYmFzZWQgb24gdGhlIGJ1cyBpbnN0YW5jZSBVVUlELg0K
LQkgKiBPbmx5IHRoZSBmaXJzdCBkZXZpY2Ugc2VyaWFsIG51bWJlciBpcyB1c2VkIGZvciBkb21h
aW4sIHNvIHRoZQ0KLQkgKiBkb21haW4gbnVtYmVyIHdpbGwgbm90IGNoYW5nZSBhZnRlciB0aGUg
Zmlyc3QgZGV2aWNlIGlzIGFkZGVkLg0KLQkgKi8NCi0JaWYgKGxpc3RfZW1wdHkoJmhidXMtPmNo
aWxkcmVuKSkNCi0JCWhidXMtPnN5c2RhdGEuZG9tYWluID0gZGVzYy0+c2VyOw0KIAlsaXN0X2Fk
ZF90YWlsKCZocGRldi0+bGlzdF9lbnRyeSwgJmhidXMtPmNoaWxkcmVuKTsNCiAJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOw0KIAlyZXR1cm4g
aHBkZXY7DQotLSANCjIuNy40DQogDQoNCg==
