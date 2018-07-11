Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0054.outbound.protection.outlook.com ([104.47.34.54]:11072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbeGKITZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jul 2018 04:19:25 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Colin King <colin.king@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: pcie-candence-ep: remove redundant variable mmc
Date: Wed, 11 Jul 2018 08:16:17 +0000
Message-ID: <MWHPR07MB350280DBA03402F078C80ACCD85A0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <20180711080103.4581-1-colin.king@canonical.com>
In-Reply-To: <20180711080103.4581-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gMTEgSnVseSAyMDE4IDA5OjAxLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBGcm9tOiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVmFyaWFibGUgbW1jIGlz
IGJlaW5nIGFzc2lnbmVkIGJ1dCBpcyBuZXZlciB1c2VkIGhlbmNlIGl0IGlzIHJlZHVuZGFudA0K
PiBhbmQgY2FuIGJlIHJlbW92ZWQuDQo+IA0KPiBDbGVhbnMgdXAgY2xhbmcgd2FybmluZzoNCj4g
d2FybmluZzogdmFyaWFibGUgJ21tYycgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNl
dC12YXJpYWJsZV0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5r
aW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LWNhZGVuY2UtZXAuYyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLWNhZGVuY2UtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNl
LWVwLmMNCj4gaW5kZXggZTNmZTQxMjRlM2FmLi42MzU0OWUwM2VhZTggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWVwLmMNCj4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtZXAuYw0KPiBAQCAtMjM4LDcgKzIzOCw3IEBA
IHN0YXRpYyBpbnQgY2Ruc19wY2llX2VwX2dldF9tc2koc3RydWN0IHBjaV9lcGMgKmVwYywgdTgg
Zm4pDQo+ICAJc3RydWN0IGNkbnNfcGNpZV9lcCAqZXAgPSBlcGNfZ2V0X2RydmRhdGEoZXBjKTsN
Cj4gIAlzdHJ1Y3QgY2Ruc19wY2llICpwY2llID0gJmVwLT5wY2llOw0KPiAgCXUzMiBjYXAgPSBD
RE5TX1BDSUVfRVBfRlVOQ19NU0lfQ0FQX09GRlNFVDsNCj4gLQl1MTYgZmxhZ3MsIG1tYywgbW1l
Ow0KPiArCXUxNiBmbGFncywgbW1lOw0KPiANCj4gIAkvKiBWYWxpZGF0ZSB0aGF0IHRoZSBNU0kg
ZmVhdHVyZSBpcyBhY3R1YWxseSBlbmFibGVkLiAqLw0KPiAgCWZsYWdzID0gY2Ruc19wY2llX2Vw
X2ZuX3JlYWR3KHBjaWUsIGZuLCBjYXAgKyBQQ0lfTVNJX0ZMQUdTKTsNCj4gQEAgLTI0OSw3ICsy
NDksNiBAQCBzdGF0aWMgaW50IGNkbnNfcGNpZV9lcF9nZXRfbXNpKHN0cnVjdCBwY2lfZXBjICpl
cGMsIHU4IGZuKQ0KPiAgCSAqIEdldCB0aGUgTXVsdGlwbGUgTWVzc2FnZSBFbmFibGUgYml0Zmll
bGQgZnJvbSB0aGUgTWVzc2FnZSBDb250cm9sDQo+ICAJICogcmVnaXN0ZXIuDQo+ICAJICovDQo+
IC0JbW1jID0gKGZsYWdzICYgUENJX01TSV9GTEFHU19RTUFTSykgPj4gMTsNCj4gIAltbWUgPSAo
ZmxhZ3MgJiBQQ0lfTVNJX0ZMQUdTX1FTSVpFKSA+PiA0Ow0KPiANCj4gIAlyZXR1cm4gbW1lOw0K
PiAtLQ0KPiAyLjE3LjENClRoYW5rcyBmb3Igc3BvdHRpbmcgdGhpcywgbW1jIGlzIG5vdCBuZWVk
ZWQgaGVyZSwganVzdCBpbnRlcmVzdGVkIGluIG1tZS4NCkFja2VkLWJ5OiBBbGFuIERvdWdsYXMg
PGFkb3VnbGFzQGNhZGVuY2UuY29tPg0KDQo=
