Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF80C43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 01:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298B32173A
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 01:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298B32173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbeI1Hfi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:35:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:13884 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeI1Hfi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 03:35:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 18:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,312,1534834800"; 
   d="scan'208";a="90222163"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2018 18:14:21 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 18:14:20 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 18:14:20 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.220]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0319.002;
 Fri, 28 Sep 2018 09:14:18 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>
Subject: RE: [PATCH v3 02/10] iommu/sva: Bind process address spaces to
 devices
Thread-Topic: [PATCH v3 02/10] iommu/sva: Bind process address spaces to
 devices
Thread-Index: AQHUUQbgutZwv5cp60y0WOXEu5U5TKT8rHMAgAIpzICAA4degIABYXMAgAEtgJA=
Date:   Fri, 28 Sep 2018 01:14:17 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1913438B3@SHSMSX101.ccr.corp.intel.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-3-jean-philippe.brucker@arm.com>
 <cdcd4083-ef28-4c5e-4a2c-5b93e61a86b4@linux.intel.com>
 <7cbd503a-c79e-3c40-7388-ce6c23f7f536@arm.com>
 <20180926110103.45b57f75@jacob-builder>
 <79c0e0e1-691e-b8e1-0e68-21876135d2ab@arm.com>
In-Reply-To: <79c0e0e1-691e-b8e1-0e68-21876135d2ab@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDVlMmYyOTAtYmYwMi00M2FmLTk1M2QtNzgzMmQ2NzZhNzEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVU5RUEFTNFFTYlhzckNlU1V5ZGpTejFVWGVNc0tVaFdhdHc5QjNieDBTSUxcLzFhWGc1MHh0ZkJvQmt6QVRob3YifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBoaWxpcHBlLmJydWNr
ZXJAYXJtLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNywgMjAxOCAxMTowNiBQ
TQ0KPiANCj4gT24gMjYvMDkvMjAxOCAxOTowMSwgSmFjb2IgUGFuIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjQgU2VwIDIwMTggMTM6MDc6NDcgKzAxMDANCj4gPiBKZWFuLVBoaWxpcHBlIEJydWNrZXIg
PGplYW4tcGhpbGlwcGUuYnJ1Y2tlckBhcm0uY29tPiB3cm90ZToNCj4gPg0KPiA+PiBPbiAyMy8w
OS8yMDE4IDA0OjA1LCBMdSBCYW9sdSB3cm90ZToNCj4gPj4gPiBIaSwNCj4gPj4gPg0KPiA+PiA+
IE9uIDA5LzIxLzIwMTggMDE6MDAgQU0sIEplYW4tUGhpbGlwcGUgQnJ1Y2tlciB3cm90ZToNCj4g
Pj4gPj4gQWRkIGJpbmQoKSBhbmQgdW5iaW5kKCkgb3BlcmF0aW9ucyB0byB0aGUgSU9NTVUgQVBJ
LiBCaW5kKCkNCj4gPj4gPj4gcmV0dXJucyBhIFBBU0lEIHRoYXQgZHJpdmVycyBjYW4gcHJvZ3Jh
bSBpbiBoYXJkd2FyZSwgdG8gbGV0IHRoZWlyDQo+ID4+ID4+IGRldmljZXMgYWNjZXNzIGFuIG1t
LiBUaGlzIHBhdGNoIG9ubHkgYWRkcyBza2VsZXRvbnMgZm9yIHRoZQ0KPiA+PiA+PiBkZXZpY2Ug
ZHJpdmVyIEFQSSwgbW9zdCBvZiB0aGUgaW1wbGVtZW50YXRpb24gaXMgc3RpbGwgbWlzc2luZy4N
Cj4gPj4gPg0KPiA+PiA+IElzIGl0IHBvc3NpYmxlIHRoYXQgYSBtYWxpY2lvdXMgcHJvY2VzcyBj
YW4gdW5iaW5kIGEgcGFzaWQgd2hpY2ggaXMNCj4gPj4gPiB1c2VkIGJ5IGFub3RoZXIgbm9ybWFs
IHByb2Nlc3M/DQo+ID4+DQo+ID4+IFllcywgaXQncyB1cCB0byB0aGUgZGV2aWNlIGRyaXZlciB0
aGF0IGNhbGxzIHVuYmluZCgpIHRvIGNoZWNrIHRoYXQNCj4gPj4gdGhlIGNhbGxlciBpcyBhbGxv
d2VkIHRvIHVuYmluZCB0aGlzIFBBU0lELiBXZSBjYW4ndCBkbyBpdCBvdXJzZWx2ZXMNCj4gPj4g
c2luY2UgdW5iaW5kKCkgY291bGQgYWxzbyBiZSBjYWxsZWQgZnJvbSBhIGtlcm5lbCB0aHJlYWQg
Zm9yIGV4YW1wbGUNCj4gPj4gZnJvbSBhIGNsZWFudXAgZnVuY3Rpb24gaW4gc29tZSB3b3JrcXVl
dWUsIG91dHNpZGUgdGhlIGNvbnRleHQgb2YgdGhlDQo+ID4+IHByb2Nlc3MgdG8gdW5iaW5kLg0K
PiANCj4gQWN0dWFsbHkgSSdtIG5vdCB0b28gY29uY2VybmVkIGFib3V0IGEgcHJvY2VzcyB1bmJp
bmRpbmcgYW5vdGhlciBvbmUsDQo+IHNpbmNlIGluIGdlbmVyYWwgb25seSB0aGUga2VybmVsIHdp
bGwgaG9sZCB0aGUgUEFTSUQgdmFsdWVzLiBVc2Vyc3BhY2UNCj4gc2hvdWxkbid0IGV2ZW4gbmVl
ZCB0byBzZWUgdGhlbSwgc28gaXNzdWluZyB1bmJpbmQoKSB3aXRoIHRoZSB3cm9uZw0KPiBQQVNJ
RCBpc24ndCBhbiBlYXN5IG1pc3Rha2UuDQo+IA0KDQp3ZWxsLCBpdCBkZXBlbmRzIG9uIHdoaWNo
IHNjZW5hcmlvIGlzIHRhbGtlZCBoZXJlLg0KDQpmb3IgbmF0aXZlIFNWQSB3aXRoIGRldmljZSBk
cml2ZXIgaW4ga2VybmVsLCB5b3VyIGRlc2NyaXB0aW9uIGlzIGNvcnJlY3QuDQoNCmZvciBuYXRp
dmUgU1ZBIHdpdGggZGV2aWNlIGRyaXZlciBpbiB1c2VyIHNwYWNlLCB0aGVuIHVzZXIgc3BhY2Ug
bmVlZHMgdG8NCnNlZS9ob2xkIFBBU0lEcyBhbmQgcHJvZ3JhbSB0aGVtIHRvIGRldmljZSBzcGVj
aWZpYyByZWdpc3Rlci4NCg0KZm9yIHZpcnR1YWwgU1ZBICh2dGQgY2FzZSksIFFlbXUgbmVlZHMg
dG8gc2VlL2hvbGQgUEFTSURzIGFuZCBwYXNzIHRvIA0KZ3Vlc3QgdXBvbiBhbnkgUEFTSUQgYWxs
b2NhdGlvbiByZXF1ZXN0IHRocnUgYSBQViBjaGFubmVsLCBhcyB5b3UganVzdCANCnNhdyBpbiBh
bm90aGVyIHRocmVhZC4gOi0pDQoNClRoYW5rcw0KS2V2aW4NCg==
