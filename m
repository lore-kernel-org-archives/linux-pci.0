Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F3C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F92D21871
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfABBrP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:47:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:23484 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbfABBrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jan 2019 20:47:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 17:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="scan'208";a="122641330"
Received: from kmsmsx152.gar.corp.intel.com ([172.21.73.87])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jan 2019 17:47:13 -0800
Received: from pgsmsx109.gar.corp.intel.com ([169.254.14.187]) by
 KMSMSX152.gar.corp.intel.com ([169.254.11.13]) with mapi id 14.03.0415.000;
 Wed, 2 Jan 2019 09:47:12 +0800
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lftan.linux@gmail.com" <lftan.linux@gmail.com>
Subject: Re: [PATCH v2 1/2] pci: altera: Add Stratix10 PCIe support
Thread-Topic: [PATCH v2 1/2] pci: altera: Add Stratix10 PCIe support
Thread-Index: AQHUoOJf5nxJfFbQskSLdMJODwRKs6WYcAMAgAJCOwA=
Date:   Wed, 2 Jan 2019 01:47:11 +0000
Message-ID: <1546393624.35646.2.camel@intel.com>
References: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
         <1546244693-34633-2-git-send-email-ley.foon.tan@intel.com>
         <20181231151730.GD159477@google.com>
In-Reply-To: <20181231151730.GD159477@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.226.248.90]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED99A248D1515F4C9A92013BA1895647@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTMxIGF0IDA5OjE3IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBSdW4gImdpdCBsb2cgLS1vbmVsaW5lIC0tZm9sbG93IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1hbHRlcmEuYyIgDQo+IGFuZA0KPiBtYWtlIHlvdXIgc3ViamVjdCBsaW5lIG1hdGNoIGlu
IHN0eWxlLCBwaHJhc2luZywgYW5kIGNhcGl0YWxpemF0aW9uLg0KPiANCj4gSGludDoNCj4gDQo+
IMKgIC4uLi4uLi4uLi4uLiBwY2k6IGFsdGVyYTogQWRkIFN0cmF0aXgxMCBQQ0llIHN1cHBvcnQN
Cj4gwqAgZWY3NTM2OWE1YjlhIFBDSTogYWx0ZXJhOiBGaXggcGxhdGZvcm1fZ2V0X2lycSgpIGVy
cm9yIGhhbmRsaW5nDQo+IMKgIGJmZGJiZjBlM2MyYSBQQ0k6IGFsdGVyYTogVXNlIHNpemU9NCBJ
UlEgZG9tYWluIGZvciBsZWdhY3kgSU5UeA0KPiDCoCA2YWIzODA5NTc4MzggUENJOiBhbHRlcmE6
IERyb3AgcGNpX2ZpeHVwX2lycXMoKQ0KPiDCoCA5ODE1NzkxMzE5YTAgUENJOiBhbHRlcmE6IENv
bnZlcnQgUENJIHNjYW4gQVBJIHRvDQo+IHBjaV9zY2FuX3Jvb3RfYnVzX2JyaWRnZSgpDQo+IMKg
IDJhNzI3NWEzZDg2NyBQQ0k6IGFsdGVyYTogRml4IFRMUF9DRkdfRFcwIGZvciBUTFAgd3JpdGUN
Cj4gDQo+IE9uZSBvZiB0aGVzZSBpcyBub3QgbGlrZSB0aGUgb3RoZXJzLg0KT2theSwgd2lsbCBj
aGFuZ2UgaXQuDQoNCj4gDQo+IE9uIE1vbiwgRGVjIDMxLCAyMDE4IGF0IDA0OjI0OjUyUE0gKzA4
MDAsIExleSBGb29uIFRhbiB3cm90ZToNCj4gLi4uDQo+ID4gDQo+ID4gK3N0cnVjdCBhbHRlcmFf
cGNpZV9kYXRhIHsNCj4gPiArCWludCAoKnRscF9yZWFkX3BrdCkoc3RydWN0IGFsdGVyYV9wY2ll
ICpwY2llLCB1MzIgKnZhbHVlKTsNCj4gPiArCXZvaWQgKCp0bHBfd3JpdGVfcGt0KShzdHJ1Y3Qg
YWx0ZXJhX3BjaWUgKnBjaWUsIHUzMg0KPiA+ICpoZWFkZXJzLA0KPiA+ICsJCQnCoMKgwqDCoMKg
wqB1MzIgZGF0YSwgYm9vbCBhbGlnbik7DQo+ID4gKwlib29sICgqZ2V0X2xpbmtfc3RhdHVzKShz
dHJ1Y3QgYWx0ZXJhX3BjaWUgKnBjaWUpOw0KPiA+ICsJaW50ICgqcnBfcmVhZF9jZmcpKHN0cnVj
dCBhbHRlcmFfcGNpZSAqcGNpZSwgaW50IHdoZXJlLA0KPiA+ICsJCQnCoMKgwqBpbnQgc2l6ZSwg
dTMyICp2YWx1ZSk7DQo+ID4gKwlpbnQgKCpycF93cml0ZV9jZmcpKHN0cnVjdCBhbHRlcmFfcGNp
ZSAqcGNpZSwgdTggYnVzLCBpbnQNCj4gPiB3aGVyZSwNCj4gPiArCQkJwqDCoMKgwqBpbnQgc2l6
ZSwgdTMyIHZhbHVlKTsNCj4gPiArCWJvb2wgczEwX2ZsYWc7CQkvKiBTdHJhdGl4IDEwICovDQo+
IFRoaXMgaXMgT0sgaWYgeW91IG9ubHkgZXZlciBoYXZlIHR3byBwcm9ncmFtbWluZyBtb2RlbHMg
KHRoZSBvcmlnaW5hbA0KPiBhbmQgU3RyYXRpeCAxMCkuwqDCoEJ1dCBpZiB0aGVyZSdzIGEgcG9z
c2liaWxpdHkgb2YgbW9yZSwgYW4gaW50IG1vZGVsDQo+IHR5cGUgdGhhdCBjYW4gYmUgdGVzdGVk
IHdpdGggYSBzd2l0Y2ggaXMgbW9yZSBleHRlbnNpYmxlLg0KPiANCj4gUGVyc29uYWxseSBJIHBy
ZWZlciBiaXRmaWVsZHMgb3ZlciBib29sIGluIHN0cnVjdHVyZXMsIGJ1dCB1bHRpbWF0ZWx5DQo+
IExvcmVuem8gd2lsbCB0YWtlIHRoaXMgYW5kIEkgZG9uJ3Qga25vdyB3aGV0aGVyIGhlIGhhcyBh
IHByZWZlcmVuY2UuDQo+IA0KPiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yL0NBKzU1YUZ4bmVQ
RGlta1ZLVnR2M2dObVJHY3djOEtRNW1IWXZVeFk4c0ENCj4gUWc2eXZWWWdAbWFpbC5nbWFpbC5j
b20NCj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci9DQSs1NWFGektRNlBqMThUQjhwNFlyME00
dCtTK0JzaUhIPUJKTm1uPTc2DQo+IC1OY2pUai1nQG1haWwuZ21haWwuY29tDQoNClllcywgeW91
IGFyZSByaWdodC4gV2lsbCBjaGFuZ2UgaXQgdG8gc29tZXRoaW5nIGxpa2UgInZlcnNpb24gdHlw
ZSIuDQoNClJlZ2FyZHMNCkxleSBGb29uDQo=
