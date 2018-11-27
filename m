Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA9C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 19:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA8420663
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 19:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="jNLbDMrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA8420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeK1GJE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:09:04 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:13482 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbeK1GJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 01:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1543345811; x=1574881811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xf7YamjZfEpzmT2Rrgb9/9JsmSnBoFHgSPtTlEa1t4g=;
  b=jNLbDMrrTBGQD0FIqZpJipA+O8d/OkQ0i2GdYFXeTvR+UVUHwgKWxhIK
   OdJ02LpGKq7bJxRlRtZhAXbOx3h1zrAeIftfcucaFYGADTP9LbSSd3GvR
   7RwS5M2ctlHmSOddg6nsg3jm5cir2EcGFPJ9qMi/sbf+EwrmM8hJGRwOr
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ESAAB5lf1bhiWd50NZChwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYJpgQInCoNviBhfiyiCDYNFk3sUgSs7CwEBIwuEPgIXgwI?=
 =?us-ascii?q?iNAkNAQMBAQIBAQIBAQIQAQEBCgkLCCkjDII2Ig4ETS8JATIBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBwINSQEBGAEBAQECARIRBA06CwU?=
 =?us-ascii?q?HBAIBCBEEAQEBAgImAgICRQIBBQgCBAENBQgagn8BgXkID5oqAoEQiVgBAQF?=
 =?us-ascii?q?ufDOEQUCFKAWBC4sCghaBEYMShE4BBwsBNoJtglcCixWEC5AXVQcChnyKLCC?=
 =?us-ascii?q?RC41GikoCBAIEBQIUgUaBHXFwUIJsgicOCYNKilNAATEBi1eBH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2ESAAB5lf1bhiWd50NZChwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YJpgQInCoNviBhfiyiCDYNFk3sUgSs7CwEBIwuEPgIXgwIiNAkNAQMBAQIBA?=
 =?us-ascii?q?QIBAQIQAQEBCgkLCCkjDII2Ig4ETS8JATIBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBBwINSQEBGAEBAQECARIRBA06CwUHBAIBCBEEAQEBA?=
 =?us-ascii?q?gImAgICRQIBBQgCBAENBQgagn8BgXkID5oqAoEQiVgBAQFufDOEQUCFKAWBC?=
 =?us-ascii?q?4sCghaBEYMShE4BBwsBNoJtglcCixWEC5AXVQcChnyKLCCRC41GikoCBAIEB?=
 =?us-ascii?q?QIUgUaBHXFwUIJsgicOCYNKilNAATEBi1eBH4EfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Nov 2018 13:10:09 -0600
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARJ9mr5022454;
        Tue, 27 Nov 2018 14:10:09 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2p19qq8s37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 14:10:08 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Nov 2018 01:09:49 +0600
X-LoopCount0: from 10.166.132.190
X-IronPort-AV: E=Sophos;i="5.56,287,1539666000"; 
   d="scan'208";a="1330534356"
To:     <rafael@kernel.org>, <mika.westerberg@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <ashok.raj@intel.com>, <bhelgaas@google.com>, <rjw@rjwysocki.net>,
        <jacob.jun.pan@intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <lukas@wunner.de>, <ckellner@redhat.com>,
        <anthony.wong@canonical.com>, <lorenzo.pieralisi@arm.com>,
        <hch@infradead.org>, <alex.williamson@redhat.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Thread-Topic: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Thread-Index: AQHUhXleXffS4I9HcUm72Le85XAeQaVkQwKA//+6PNA=
Date:   Tue, 27 Nov 2018 19:10:01 +0000
Message-ID: <67a765097ed546fe8b626026e35262b3@ausx13mpc120.AMER.DELL.COM>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com>
 <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270162
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI3LCAyMDE4IDEx
OjE1IEFNDQo+IFRvOiBNaWthIFdlc3RlcmJlcmcNCj4gQ2M6IG9wZW4gbGlzdDpBTUQgSU9NTVUg
KEFNRC1WSSk7IEpvZXJnIFJvZWRlbDsgRGF2aWQgV29vZGhvdXNlOyBMdSBCYW9sdTsNCj4gUmFq
LCBBc2hvazsgQmpvcm4gSGVsZ2FhczsgUmFmYWVsIEouIFd5c29ja2k7IFBhbiwgSmFjb2IganVu
OyBBbmRyZWFzIE5vZXZlcjsNCj4gTWljaGFlbCBKYW1ldDsgWWVoZXprZWwgQmVybmF0OyBMdWth
cyBXdW5uZXI7IGNrZWxsbmVyQHJlZGhhdC5jb207IExpbW9uY2llbGxvLA0KPiBNYXJpbzsgQW50
aG9ueSBXb25nOyBMb3JlbnpvIFBpZXJhbGlzaTsgQ2hyaXN0b3BoIEhlbGx3aWc7IEFsZXggV2ls
bGlhbXNvbjsgQUNQSQ0KPiBEZXZlbCBNYWxpbmcgTGlzdDsgTGludXggUENJOyBMaW51eCBLZXJu
ZWwgTWFpbGluZyBMaXN0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS80XSBQQ0kgLyBBQ1BJ
OiBJZGVudGlmeSB1bnRydXN0ZWQgUENJIGRldmljZXMNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1B
SUxdDQo+IA0KPiBPbiBNb24sIE5vdiAyNiwgMjAxOCBhdCAxMjoxNSBQTSBNaWthIFdlc3RlcmJl
cmcNCj4gPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
UmVjZW50IHN5c3RlbXMgd2l0aCBUaHVuZGVyYm9sdCBwb3J0cyBtYXkgc3VwcG9ydCBJT01NVSBu
YXRpdmVseS4gVGhpcw0KPiA+IG1lYW5zIHRoYXQgdGhlIHBsYXRmb3JtIHV0aWxpemVzIElPTU1V
IHRvIHByZXZlbnQgRE1BIGF0dGFja3Mgb3Zlcg0KPiA+IGV4dGVybmFsbHkgZXhwb3NlZCBQQ0ll
IHJvb3QgcG9ydHMgKHR5cGljYWxseSBUaHVuZGVyYm9sdCBwb3J0cykNCj4gPg0KPiA+IFRoZSBz
eXN0ZW0gQklPUyBtYXJrcyB0aGVzZSBQQ0llIHJvb3QgcG9ydHMgYXMgYmVpbmcgZXh0ZXJuYWxs
eSBmYWNpbmcNCj4gPiBwb3J0cyBieSBpbXBsZW1lbnRpbmcgZm9sbG93aW5nIEFDUEkgX0RTRCBb
MV0gdW5kZXIgdGhlIHJvb3QgcG9ydCBpbg0KPiA+IHF1ZXN0aW9uOg0KPiA+DQo+ID4gICBOYW1l
IChfRFNELCBQYWNrYWdlICgpIHsNCj4gPiAgICAgICBUb1VVSUQgKCJlZmNjMDZjYy03M2FjLTRi
YzMtYmZmMC03NjE0MzgwN2MzODkiKSwNCj4gPiAgICAgICBQYWNrYWdlICgpIHsNCj4gPiAgICAg
ICAgICAgUGFja2FnZSAoKSB7IkV4dGVybmFsRmFjaW5nUG9ydCIsIDF9LA0KPiA+ICAgICAgICAg
ICBQYWNrYWdlICgpIHsiVUlEIiwgMCB9DQo+ID4gICAgICAgfQ0KPiA+ICAgfSkNCj4gPg0KPiA+
IFRvIG1ha2UgaXQgcG9zc2libGUgZm9yIElPTU1VIGNvZGUgdG8gaWRlbnRpZnkgdGhlc2UgZGV2
aWNlcywgd2UgbG9vayB1cA0KPiA+IGZvciB0aGlzIHByb3BlcnR5IGFuZCBtYXJrIGFsbCBjaGls
ZHJlbiBkZXZpY2VzIChpbmNsdWRpbmcgdGhlIHJvb3QgcG9ydA0KPiA+IGl0c2VsZikgd2l0aCBh
IG5ldyBmbGFnICgtPmlzX3VudHJ1c3RlZCkuIFRoaXMgZmxhZyBpcyBtZWFudCB0byBiZSB1c2Vk
DQo+ID4gd2l0aCBhbGwgUENJZSBkZXZpY2VzIChub3QganVzdCBUaHVuZGVyYm9sdCkgdGhhdCBj
YW5ub3QgYmUgdHJ1c3RlZCBpbg0KPiA+IHRoZSBzYW1lIGxldmVsIHRoYW4gaW50ZWdyYXRlZCBk
ZXZpY2VzIGFuZCBtYXkgbmVlZCB0byBwdXQgYmVoaW5kIGZ1bGwNCj4gPiBJT01NVSBwcm90ZWN0
aW9uLg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vZG9jcy5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRv
d3MtaGFyZHdhcmUvZHJpdmVycy9wY2kvZHNkLWZvci0NCj4gcGNpZS1yb290LXBvcnRzI2lkZW50
aWZ5aW5nLWV4dGVybmFsbHktZXhwb3NlZC1wY2llLXJvb3QtcG9ydHMNCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1pa2EgV2VzdGVyYmVyZyA8bWlrYS53ZXN0ZXJiZXJnQGxpbnV4LmludGVsLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9hY3BpL3Byb3BlcnR5LmMgfCAgMyArKysNCj4gPiAg
ZHJpdmVycy9wY2kvcGNpLWFjcGkuYyAgfCAxOCArKysrKysrKysrKysrKysrKysNCj4gPiAgZHJp
dmVycy9wY2kvcHJvYmUuYyAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGlu
Y2x1ZGUvbGludXgvcGNpLmggICAgIHwgIDggKysrKysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2Vk
LCA1MSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3By
b3BlcnR5LmMgYi9kcml2ZXJzL2FjcGkvcHJvcGVydHkuYw0KPiA+IGluZGV4IDhjN2M0NTgzYjUy
ZC4uNGJkYWQzMmY2MmM4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9wcm9wZXJ0eS5j
DQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL3Byb3BlcnR5LmMNCj4gPiBAQCAtMzEsNiArMzEsOSBA
QCBzdGF0aWMgY29uc3QgZ3VpZF90IHBycF9ndWlkc1tdID0gew0KPiA+ICAgICAgICAgLyogSG90
cGx1ZyBpbiBEMyBHVUlEOiA2MjExZTJjMC01OGEzLTRhZjMtOTBlMS05MjdhNGUwYzU1YTQgKi8N
Cj4gPiAgICAgICAgIEdVSURfSU5JVCgweDYyMTFlMmMwLCAweDU4YTMsIDB4NGFmMywNCj4gPiAg
ICAgICAgICAgICAgICAgICAweDkwLCAweGUxLCAweDkyLCAweDdhLCAweDRlLCAweDBjLCAweDU1
LCAweGE0KSwNCj4gPiArICAgICAgIC8qIEV4dGVybmFsIGZhY2luZyBwb3J0IEdVSUQ6IGVmY2Mw
NmNjLTczYWMtNGJjMy1iZmYwLTc2MTQzODA3YzM4OSAqLw0KPiA+ICsgICAgICAgR1VJRF9JTklU
KDB4ZWZjYzA2Y2MsIDB4NzNhYywgMHg0YmMzLA0KPiA+ICsgICAgICAgICAgICAgICAgIDB4YmYs
IDB4ZjAsIDB4NzYsIDB4MTQsIDB4MzgsIDB4MDcsIDB4YzMsIDB4ODkpLA0KPiA+ICB9Ow0KPiAN
Cj4gT25lIG9ic2VydmF0aW9uIGhlcmUuICBOb3RlIHRoYXQgSSByZWFsbHkgaGF2ZSBubyBzdHJv
bmcgb3BpbmlvbiBvbg0KPiB0aGF0LCBzbyB0aGlzIGlzIG5vdCBhbiBvYmplY3Rpb24sIGJ1dCBJ
TU8gaXQgaXMgZmFpciB0byBtYWtlIHRoaW5ncw0KPiBjbGVhciBmb3IgZXZlcnlib2R5Lg0KPiAN
Cj4gU28gdGhpcyBjYXVzZXMgdGhlIEV4dGVybmFsIGZhY2luZyBwb3J0IEdVSUQgKHdoaWNoIGFs
cmVhZHkgaXMgdGhlDQo+IGNhc2Ugd2l0aCB0aGUgSG90cGx1ZyBpbiBEMyBHVUlEIGZvciB0aGF0
IG1hdHRlcikgdG8gYmUgcHJhY3RpY2FsbHkNCj4gZXF1aXZhbGVudCB0byB0aGUgQUNQSSBfRFNE
IGRldmljZSBwcm9wZXJ0aWVzIEdVSUQuICBUaGlzIG1lYW5zIHRoYXQNCj4gTGludXggd2lsbCBj
b25zaWRlciBhIGNvbWJpbmF0aW9uIG9mIGFueSBvZiB0aGVzZSBHVUlEcyB3aXRoIGFueQ0KPiBw
cm9wZXJ0aWVzIGRlZmluZWQgZm9yIGFueSBvZiB0aGVtIGFzIHZhbGlkLCB3aGljaCBuZWVkIG5v
dCBiZSB0aGUNCj4gY2FzZSBpbiBXaW5kb3dzLg0KPiANCj4gRm9yIGV4YW1wbGUsIHNpbmNlIHRo
ZSBFeHRlcm5hbEZhY2luZ1BvcnQgcHJvcGVydHkgaXMgZGVmaW5lZCBhbG9uZw0KPiB3aXRoIHRo
ZSBFeHRlcm5hbCBmYWNpbmcgcG9ydCBHVUlELCBXaW5kb3dzIHdpbGwgbGlrZWx5IGlnbm9yZSBp
dCBpZg0KPiBpdCBpcyB1c2VkIGluIGEgY29tYmluYXRpb24gd2l0aCB0aGUgSG90cGx1ZyBpbiBE
MyBHVUlEIG9yIHRoZSBBQ1BJDQo+IF9EU0QgZGV2aWNlIHByb3BlcnRpZXMgR1VJRC4gIElmIHRo
ZSBmaXJtd2FyZSBjb21iaW5lcyB0aGUgSG90cGx1ZyBpbg0KPiBEMyBHVUlEIG9yIHRoZSBBQ1BJ
IF9EU0QgZGV2aWNlIHByb3BlcnRpZXMgR1VJRCB3aXRoIHRoYXQgcHJvcGVydHksDQo+IFdpbmRv
d3Mgd2lsbCBub3QgcmVnYXJkIGl0IGFzIHZhbGlkLCBtb3N0IGxpa2VseSwgYnV0IExpbnV4IHdp
bGwgdXNlDQo+IGl0IGp1c3QgZmluZS4gIEluIHRoZSBmYWNlIG9mIEFTTCBidWdzLCB3aGljaCBh
cmUgaW5ldml0YWJsZSAoYXQgbGVhc3QNCj4ganVzdCBiZWNhdXNlIEFTTCBpcyBjb2RlIHdyaXR0
ZW4gYnkgaHVtYW5zKSwgdGhhdCBtYXkgYmVjb21lIGEgcmVhbA0KPiBwcm9ibGVtLCBhcyBzeXN0
ZW1zIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgd2l0aCBXaW5kb3dzIG1heSBub3Qgd29yayB3aXRoDQo+
IExpbnV4IGFzIGV4cGVjdGVkIGFuZCB2aWNlIHZlcnNhIGJlY2F1c2Ugb2YgaXQuDQo+IA0KPiBG
cm9tIHRoZSBlY29zeXN0ZW0gcHVyaXR5IHBlcnNwZWN0aXZlIHRoaXMgc2hvdWxkIGJlIGF2b2lk
ZWQsIGJ1dCB0aGVuDQo+IEkgZG8gcmVhbGl6ZSB0aGF0IHRoaXMgYWxsb3dzIGNvZGUgdG8gYmUg
cmUtdXNlZCBhbmQgYXZvaWRzIHF1aXRlIGENCj4gYml0IG9mIGNvbXBsZXhpdHkuICBUaGUgbGlr
ZWxpaG9vZCBvZiBhbiBBU0wgYnVnIHRoYXQgd2lsbCBleHBvc2UgdGhpcw0KPiBpc3N1ZSBpcyBh
cmd1YWJseSBzbWFsbCwgc28gbWF5YmUgaXQgaXMgbm90IGEgcHJhY3RpY2FsIGNvbmNlcm4gYWZ0
ZXINCj4gYWxsLg0KDQpUaGlzIGlzIHRoZSBwZXJmZWN0IHR5cGUgb2Ygc2l0dWF0aW9uIHRoYXQg
c2hvdWxkIGJlIHJhaXNlZCBhcyBhIGhpZ2hseQ0KbWFya2VkIGJ1ZyBpbiBGV1RTLiAgRldUUyBp
cyBhbHJlYWR5IGluIHRoZSBVRUZJIHNlbGYgY2VydGlmaWNhdGlvbiBzdWl0ZSBhbmQgDQppcyBi
ZWluZyB1c2VkIGJ5IElCVnMsIE9FTXMgYW5kIE9ETXMgdG8gZmluZCBhbmQgZml4IEFTTCBpc3N1
ZXMuDQoNCg==
