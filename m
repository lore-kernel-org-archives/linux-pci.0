Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:60871
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750918AbeCIEzJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Mar 2018 23:55:09 -0500
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
Date: Fri, 9 Mar 2018 04:55:07 +0000
Message-ID: <A9BC9573-36AA-4493-A086-F99F9204BEC9@microsoft.com>
Content-Type: multipart/mixed;
        boundary="_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DA46037FEB72948B777033CFA1AC4F9@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64

IA0KDQo=

--_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_
Content-Type: application/octet-stream;
	name="0001-PCI-BUS-domain-ID-corruption.patch"
Content-Description: 0001-PCI-BUS-domain-ID-corruption.patch
Content-Disposition: attachment;
	filename="0001-PCI-BUS-domain-ID-corruption.patch"; size=1898;
	creation-date="Fri, 09 Mar 2018 04:55:06 GMT";
	modification-date="Fri, 09 Mar 2018 04:55:06 GMT"
Content-ID: <AE3E0D4C692FEB4ABA9676172324D897@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA5NzcxNmNmNGNhZTk3NzljMTgwYzAwZmI0YmVjYWNkMmRhMTM5MzU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmlkaGFyIFBpdGNoYWkgPHNyaWRoYXIucGl0Y2hhaUBnbWFp
bC5jb20+CkRhdGU6IFRodSwgOCBNYXIgMjAxOCAxNDoxNzo1MSAtMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIFBDSSBCVVMgZG9tYWluIElEIGNvcnJ1cHRpb24KCldoZW4gUENJIEJVUyBpcyBhZGRlZCwg
UENJX0JVUyBkb21haW4gSUQgaXMgc2V0LiBXaGVuIFBDSV9CVVMgYW5kIGEgZGV2aWNlCmFkZGVk
IHRvIHRoZSBidXMgaXMgcmFjaW5nIGFnYWluc3QgZWFjaCBvdGhlciwgdGhlIGZpcnN0IGRldmlj
ZSB0ZW5kcyB0bwpvdmVyd3JpdGUgdGhlIGRvbWFpbiBJRC4gSW4gb3JkZXIgdG8gYXZvaWQgdGhl
IHJhY2UsIHRoaXMgcGF0Y2ggbWFrZSBzdXJlCndoZW4gYSBkZXZpY2UgaXMgYWRkZWQgdG8gYSBi
dXMsIGl0IG5ldmVyIHVwZGF0ZWQgdGhlIGJ1cyBkb21haW4gSUQuIFNpbmNlCndlIGhhdmUgdGhl
IHRyYW5zcGFyZW50IFNSSU9WIG1vZGUgbm93LCB0aGUgc2hvcnQgVkYgZGV2aWNlIG5hbWUgaXMg
bm8KbG9uZ2VyIG5lZWRlZC4KCkZpeGVzOiA0YTliMDkzM2JkZmMoIlBDSTpodjpVc2UgZGV2aWNl
IHNlcmlhbCBudW1iZXIgYXMgUENJIGRvbWFpbiIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ClNpZ25lZC1vZmYtYnk6IFNyaWRoYXIgUGl0Y2hhaSA8c3JwaXRjaGFAbWljcm9zb2Z0LmNvbT4K
LS0tCiBkcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYyB8IDExIC0tLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvaG9z
dC9wY2ktaHlwZXJ2LmMgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYwppbmRleCAyZmFm
MzhlLi5hYzY3ZTU2IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYwor
KysgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaS1oeXBlcnYuYwpAQCAtMTUxOCwxNyArMTUxOCw2IEBA
IHN0YXRpYyBzdHJ1Y3QgaHZfcGNpX2RldiAqbmV3X3BjaWNoaWxkX2RldmljZShzdHJ1Y3QgaHZf
cGNpYnVzX2RldmljZSAqaGJ1cywKIAlnZXRfcGNpY2hpbGQoaHBkZXYsIGh2X3BjaWRldl9yZWZf
Y2hpbGRsaXN0KTsKIAlzcGluX2xvY2tfaXJxc2F2ZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywg
ZmxhZ3MpOwogCi0JLyoKLQkgKiBXaGVuIGEgZGV2aWNlIGlzIGJlaW5nIGFkZGVkIHRvIHRoZSBi
dXMsIHdlIHNldCB0aGUgUENJIGRvbWFpbgotCSAqIG51bWJlciB0byBiZSB0aGUgZGV2aWNlIHNl
cmlhbCBudW1iZXIsIHdoaWNoIGlzIG5vbi16ZXJvIGFuZAotCSAqIHVuaXF1ZSBvbiB0aGUgc2Ft
ZSBWTS4gIFRoZSBzZXJpYWwgbnVtYmVycyBzdGFydCB3aXRoIDEsIGFuZAotCSAqIGluY3JlYXNl
IGJ5IDEgZm9yIGVhY2ggZGV2aWNlLiAgU28gZGV2aWNlIG5hbWVzIGluY2x1ZGluZyB0aGlzCi0J
ICogY2FuIGhhdmUgc2hvcnRlciBuYW1lcyB0aGFuIGJhc2VkIG9uIHRoZSBidXMgaW5zdGFuY2Ug
VVVJRC4KLQkgKiBPbmx5IHRoZSBmaXJzdCBkZXZpY2Ugc2VyaWFsIG51bWJlciBpcyB1c2VkIGZv
ciBkb21haW4sIHNvIHRoZQotCSAqIGRvbWFpbiBudW1iZXIgd2lsbCBub3QgY2hhbmdlIGFmdGVy
IHRoZSBmaXJzdCBkZXZpY2UgaXMgYWRkZWQuCi0JICovCi0JaWYgKGxpc3RfZW1wdHkoJmhidXMt
PmNoaWxkcmVuKSkKLQkJaGJ1cy0+c3lzZGF0YS5kb21haW4gPSBkZXNjLT5zZXI7CiAJbGlzdF9h
ZGRfdGFpbCgmaHBkZXYtPmxpc3RfZW50cnksICZoYnVzLT5jaGlsZHJlbik7CiAJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOwogCXJldHVybiBo
cGRldjsKLS0gCjIuNy40Cgo=

--_002_A9BC957336AA4493A086F99F9204BEC9microsoftcom_--
