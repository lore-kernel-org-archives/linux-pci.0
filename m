Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD6C00449
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 08:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C042084D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 08:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C042084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeJHPkk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:40:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:23315 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbeJHPkk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 11:40:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 01:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="270416732"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 08 Oct 2018 01:29:11 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 8 Oct 2018 01:29:10 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 8 Oct 2018 01:29:10 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.48]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.245]) with mapi id 14.03.0319.002;
 Mon, 8 Oct 2018 16:29:07 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "liguozhu@hisilicon.com" <liguozhu@hisilicon.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        Robin Murphy <Robin.Murphy@arm.com>
Subject: RE: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Thread-Topic: [PATCH v3 03/10] iommu/sva: Manage process address spaces
Thread-Index: AQHUUQbeYoKTwka2WEyXMYBJUUEZKaT/0+gAgACqp4CAAKmhgIAAtMQAgAAoe4CAABIbgIABZMTAgAAqHQCAEU0V8A==
Date:   Mon, 8 Oct 2018 08:29:07 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D2682F@SHSMSX104.ccr.corp.intel.com>
References: <20180920170046.20154-1-jean-philippe.brucker@arm.com>
 <20180920170046.20154-4-jean-philippe.brucker@arm.com>
 <09933fce-b959-32e1-b1f3-0d4389abf735@linux.intel.com>
 <20180925132627.vbdotr23o7lqrmnd@8bytes.org>
 <b33a1911-e100-586b-b8df-eb04312ecffd@linux.intel.com>
 <754d495d-d016-f42f-5682-ba4a75a618e0@arm.com>
 <20180926124527.GD18287@8bytes.org>
 <1f53c6f1-4e7a-1451-1abc-a7bca4a2359d@arm.com>
 <A2975661238FB949B60364EF0F2C257439D0CC48@SHSMSX104.ccr.corp.intel.com>
 <9aedb22e-ff28-7bfd-feeb-ae86802e6400@arm.com>
In-Reply-To: <9aedb22e-ff28-7bfd-feeb-ae86802e6400@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjhlMDUzZTctMTYyMS00NWJjLWEwNWYtYmQyNTljZDkyMTFlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia1orZVJ1Wk9ydHp1eit1YnFpdlhMRnBZQTl6U05hR2Exc2xvUnljc0tQR042UW5YNFlTU3RRckFzelVRZHpvZCJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSmVhbiwNCg0KPiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgW21haWx0bzpqZWFuLXBo
aWxpcHBlLmJydWNrZXJAYXJtLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNywg
MjAxOCA5OjM4IFBNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT47IEpvZXJn
IFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAzLzEw
XSBpb21tdS9zdmE6IE1hbmFnZSBwcm9jZXNzIGFkZHJlc3Mgc3BhY2VzDQo+IA0KPiBPbiAyNy8w
OS8yMDE4IDA0OjIyLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4+IEZvciB0aGUgImNsYXNzaWMiIHZm
aW8tcGNpIGNhc2UsICJTVkEgaW4gZ3Vlc3QiIHN0aWxsIG1lYW5zIGdpdmluZyB0aGUNCj4gPj4g
Z3Vlc3QgY29udHJvbCBvdmVyIHRoZSB3aG9sZSBQQVNJRCB0YWJsZS4NCj4gPg0KPiA+IE5vLCBp
ZiBnaXZpbmcgZ3Vlc3QgY29udHJvbCBvdmVyIHRoZSB3aG9sZSBQQVNJRCB0YWJsZSwgaXQgbWVh
bnMgZ3Vlc3QgbWF5IGhhdmUNCj4gPiBpdHMgb3duIFBBU0lEIG5hbWVzcGFjZS4gcmlnaHQ/IEFu
ZCBmb3IgdmZpby1tZGV2IGNhc2UsIGl0IGdldHMgUEFTSUQgZnJvbSBob3N0Lg0KPiA+IFNvIHRo
ZXJlIHdvdWxkIGJlIG11bHRpcGxlIFBBU0lEIG5hbWVzcGFjZXMuIFRoaW5raW5nIGFib3V0IHRo
ZSBmb2xsb3dpbmcNCj4gc2NlbmFyaW86DQo+ID4NCj4gPiBBIFBGL1ZGIGFzc2lnbmVkIHRvIGEg
Vk0gdmlhICJjbGFzc2ljIiB2ZmlvLXBjaS4gQW5kIGFuIGFzc2lnbmFibGUtZGV2aWNlLWludGVy
ZmFjZQ0KPiA+IGFzc2lnbmVkIHRvIHRoaXMgVk0gdmlhIHZmaW8tbWRldi4gSWYgYW4gYXBwbGlj
YXRpb24gaW4gdGhpcyBWTSB0cmllcyB0byBtYW5pcHVsYXRlDQo+ID4gdGhlc2UgdHdvICJkZXZp
Y2VzIiwgaXQgc2hvdWxkIGhhdmUgdGhlIHNhbWUgUEFTSUQgcHJvZ3JhbW1lZCB0byB0aGVtLiBy
aWdodD8NCj4gPiBCdXQgYXMgdGhlIGFib3ZlIGNvbW1lbnRzIG1lbnRpb25lZCwgZm9yIHZmaW8t
cGNpIGNhc2UsIGl0IHdvdWxkIGdldCBhIFBBU0lEDQo+IGZyb20NCj4gPiBpdHMgb3duIFBBU0lE
IG5hbWVzcGFjZS4gV2hpbGUgdGhlIHZmaW8tbWRldiBjYXNlIHdvdWxkIGdldCBhIFBBU0lEIGZy
b20gaG9zdC4NCj4gPiBUaGlzIHdvdWxkIHJlc3VsdCBpbiBjb25mbGljdC4NCj4gDQo+IEFoIEkg
c2VlLCBpZiB0aGUgaG9zdCBhc3NpZ25zIGFuIEFESSB2aWEgdmZpby1tZGV2IGFuZCBhIFBDSSBm
dW5jdGlvbg0KPiB2aWEgdmZpby1wY2kgdG8gdGhlIHNhbWUgVk0sIHRoZSBndWVzdCBuZWVkcyB0
byB1c2UgdGhlIHBhcmF2aXJ0dWFsaXplZA0KPiBQQVNJRCBhbGxvY2F0b3IgZm9yIHRoZSBQQ0kg
ZGV2aWNlIGFzIHdlbGwsIG5vdCBqdXN0IHRoZSBBREkuIEluIGZhY3QNCj4gYWxsIGd1ZXN0IFBB
U0lEcyBuZWVkIHRvIGJlIGFsbG9jYXRlZCB0aHJvdWdoIG9uZSBQViBjaGFubmVsLCBldmVuIGlm
DQo+IHRoZSBWTSBoYXMgb3RoZXIgdklPTU1VcyB0aGF0IGRvbid0IHN1cHBvcnQgUFYuIEJ1dCBJ
IHN1cHBvc2UgdGhhdCBraW5kDQo+IG9mIFZNIGlzIHVucmVhbGlzdGljLg0KDQp5ZXMsIHN1Y2gg
a2luZCBvZiBWTSBpcyB1bnJlYWxpc3RpYy4gOikNCg0KPiBIb3dldmVyIGZvciBTTU1VdjMgd2Un
bGwgc3RpbGwgdXNlIHRoZQ0KPiBiaW5kX3Bhc2lkX3RhYmxlIGZvciB2ZmlvLXBjaSBhbmQgbGV0
IHRoZSBndWVzdCBhbGxvY2F0ZSBQQVNJRHMsIHNpbmNlDQo+IHRoZSBQQVNJRCB0YWJsZSBsaXZl
cyBpbiBndWVzdC1waHlzaWNhbCBzcGFjZS4NCg0KSSB0aGluayBpdCdzIG9rLiBUaGlzIGRvZXNu
4oCZdCByZXN1bHQgaW4gYW55IGNvbmZsaWN0Lg0KDQo+IA0KPiBJbiBhbnkgY2FzZSwgZm9yIHRo
ZSBwYXRjaCBzZXJpZXMgYXQgaGFuZCwgaXQgbWVhbnMgdGhhdCBpb21tdS1zdmEgd2lsbA0KPiBu
ZWVkIGFzc2lzdGFuY2UgZnJvbSB0aGUgdnQtZCBkcml2ZXIgdG8gYWxsb2NhdGUgUEFTSURzOiBo
b3N0IHVzZXMgdGhlDQo+IGdlbmVyaWMgYWxsb2NhdG9yLCBndWVzdCB1c2VzIHRoZSBQViBvbmUu
DQoNCkV4YWN0bHkuDQoNCj4gSSBndWVzcyB0aGUgbW1fYWxsb2MoKSBvcCBjb3VsZCBkbyB0aGF0
Pw0KDQpEbyB5b3UgbWVhbiB0aGUgaW9fbW1fYWxsb2MgaW4geW91ciBTVkEgcGF0Y2ggc2VyaWVz
PyBXZSd2ZSBnb3QNCnNvbWUgcGF0Y2ggZm9yIHRoZSBQViBvbmUuIEFsbGVuIChCYW9sdSBMdSkg
aXMgcHJlcGFyaW5nIHRvIHNlbmQgaXQgb3V0DQpmb3IgcmV2aWV3LiBJIGd1ZXNzIHdlIGNhbiBo
YXZlIG1vcmUgYWxpZ25tZW50IGR1cmluZyB0aGF0IHBhdGNoDQpyZXZpZXdpbmcuDQoNClRoYW5r
cywNCllpIExpdQ0K
