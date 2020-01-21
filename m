Return-Path: <SRS0=9+zz=3K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E867C33CA1
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 01:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189812467A
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 01:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAUBWu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Jan 2020 20:22:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:5081 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbgAUBWu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Jan 2020 20:22:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 17:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,344,1574150400"; 
   d="scan'208";a="258879504"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2020 17:22:48 -0800
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jan 2020 17:22:48 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.100]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.73]) with mapi id 14.03.0439.000;
 Mon, 20 Jan 2020 17:22:48 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Use pci_real_dma_dev() for mapping
Thread-Topic: [PATCH v4 4/7] iommu/vt-d: Use pci_real_dma_dev() for mapping
Thread-Index: AQHVzYW+pdAk+HzEA0yLYDZroXu/j6f02RUAgAAEjgA=
Date:   Tue, 21 Jan 2020 01:22:47 +0000
Message-ID: <8fcd8782dfdfb567e7399b78f552658f9cd9f5b1.camel@intel.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
         <1579278449-174098-5-git-send-email-jonathan.derrick@intel.com>
         <88149be1-1e5d-f0d2-ba5d-6e979014f11e@linux.intel.com>
In-Reply-To: <88149be1-1e5d-f0d2-ba5d-6e979014f11e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.198]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA405CEA6002A41BE5DF60303D78A23@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

R29vZCBjYXRjaC4gVGhhbmtzIEJhb2x1Lg0KV2lsbCBkbyB2NSBmaXhpbmcgdGhpcyBhbmQgQ2hy
aXN0b3BoJ3Mgbml0DQoNCk9uIFR1ZSwgMjAyMC0wMS0yMSBhdCAwOTowNiArMDgwMCwgTHUgQmFv
bHUgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gMS8xOC8yMCAxMjoyNyBBTSwgSm9uIERlcnJpY2sg
d3JvdGU6DQo+ID4gVGhlIFBDSSBkZXZpY2UgbWF5IGhhdmUgYSBETUEgcmVxdWVzdGVyIG9uIGFu
b3RoZXIgYnVzLCBzdWNoIGFzIFZNRA0KPiA+IHN1YmRldmljZXMgbmVlZGluZyB0byB1c2UgdGhl
IFZNRCBlbmRwb2ludC4gVGhpcyBjYXNlIHJlcXVpcmVzIHRoZSByZWFsDQo+ID4gRE1BIGRldmlj
ZSB3aGVuIG1hcHBpbmcgdG8gSU9NTVUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9uIERl
cnJpY2s8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJz
L2lvbW11L2ludGVsLWlvbW11LmMgfCA5ICsrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lu
dGVsLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMNCj4gPiBpbmRleCAwYzhk
ODFmLi4wMWExYjBmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYw0KPiA+IEBAIC03ODIsNiAr
NzgyLDggQEAgc3RhdGljIHN0cnVjdCBpbnRlbF9pb21tdSAqZGV2aWNlX3RvX2lvbW11KHN0cnVj
dCBkZXZpY2UgKmRldiwgdTggKmJ1cywgdTggKmRldmYNCj4gPiAgIAkJCXJldHVybiBOVUxMOw0K
PiA+ICAgI2VuZGlmDQo+ID4gICANCj4gPiArCQlwZGV2ID0gcGNpX3JlYWxfZG1hX2RldihkZXYp
Ow0KPiANCj4gVGhpcyBpc24ndCBjb3JyZWN0LiBJdCB3aWxsIHJlc3VsdCBpbiBhIGNvbXBpbGlu
ZyBlcnJvciB3aGVuIGJpc2VjdC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg==
