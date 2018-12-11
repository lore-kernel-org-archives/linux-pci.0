Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5FDC04EB8
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 02:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4112520645
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 02:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4112520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeLKCpv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:45:51 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:6517 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728230AbeLKCpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 21:45:51 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id ACB4050199465;
        Tue, 11 Dec 2018 10:45:43 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Dec 2018 10:45:45 +0800
Received: from DGGEMM501-MBX.china.huawei.com ([169.254.1.207]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 10:45:44 +0800
From:   xuyandong <xuyandong2@huawei.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] pci: avoid bridge feature re-probing on hotplug
Thread-Topic: [PATCH] pci: avoid bridge feature re-probing on hotplug
Thread-Index: AQHUkPfZm+7kLW/u5UWB8Dht4FV3hKV41OMQ
Date:   Tue, 11 Dec 2018 02:45:44 +0000
Message-ID: <7CECC2DFC21538489F72729DF5EFB4D908AC796C@DGGEMM501-MBX.china.huawei.com>
References: <20181211021617.24072-1-mst@redhat.com>
In-Reply-To: <20181211021617.24072-1-mst@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.33.58]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIFttYWlsdG86bXN0QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEx
LCAyMDE4IDEwOjE5IEFNDQo+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENj
OiB4dXlhbmRvbmcgPHh1eWFuZG9uZzJAaHVhd2VpLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc7IFlpbmdoYWkNCj4gTHUgPHlpbmdoYWlAa2VybmVsLm9yZz47IEplc3NlIEJhcm5lcyA8amJh
cm5lc0B2aXJ0dW91c2dlZWsub3JnPjsgQmpvcm4NCj4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xl
LmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBwY2k6
IGF2b2lkIGJyaWRnZSBmZWF0dXJlIHJlLXByb2Jpbmcgb24gaG90cGx1Zw0KPiANCj4gY29tbWl0
IDFmODJkZTEwZDYgKCJQQ0kveDg2OiBkb24ndCBhc3N1bWUgcHJlZmV0Y2hhYmxlIHJhbmdlcyBh
cmUNCj4gNjRiaXQiKSBhZGRlZCBwcm9iaW5nIG9mIGJyaWRnZSBzdXBwb3J0IGZvciA2NCBiaXQg
bWVtb3J5IGVhY2ggdGltZSBicmlkZ2UgaXMNCj4gcmUtZW51bWVyYXRlZC4NCj4gDQo+IFVuZm9y
dHVuYXRlbHkgdGhpcyBwcm9iaW5nIGlzIGRlc3RydWN0aXZlIGlmIGFueSBkZXZpY2UgYmVoaW5k
IHRoZSBicmlkZ2UgaXMgaW4NCj4gdXNlIGF0IHRoaXMgdGltZS4NCj4gDQo+IFRoZXJlJ3Mgbm8g
cmVhbCBuZWVkIHRvIHJlLXByb2JlIHRoZSBicmlkZ2UgZmVhdHVyZXMgYXMgdGhlIHJlZ2l0ZXJz
IGluIHF1ZXN0aW9uDQo+IG5ldmVyIGNoYW5nZSAtIGRldGVjdCB0aGF0IHVzaW5nIHRoZSBtZW1v
cnkgZmxhZyBiZWluZyBzZXQgYW5kIHNraXAgdGhlDQo+IHByb2JpbmcuDQo+IEF2b2lkaW5nIHJl
cGVhdGVkIGNhbGxzIHRvIHBjaV9icmlkZ2VfY2hlY2tfcmFuZ2VzIG1pZ2h0IGJlIGV2ZW4gbmlj
ZXIgd291bGQNCj4gYmUgYSBiaWdnZXIgcGF0Y2ggYW5kIHByb2JhYmx5IG5vdCBhcHByb3ByaWF0
ZSBvbiBzdGFibGUuDQo+IA0KPiBSZXBvcnRlZC1ieTogeHV5YW5kb25nIDx4dXlhbmRvbmcyQGh1
YXdlaS5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBZaW5naGFpIEx1
IDx5aW5naGFpQGtlcm5lbC5vcmc+DQo+IENjOiBKZXNzZSBCYXJuZXMgPGpiYXJuZXNAdmlydHVv
dXNnZWVrLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4NCg0KVGVzdGVkLWJ5OiB4dXlhbmRvbmcgPHh1eWFuZG9uZzJAaHVhd2VpLmNvbT4N
Cg0KPiAtLS0NCj4gDQo+IFRoaXMgaXNzdWUgaGFzIGJlZW4gcmVwb3J0ZWQgb24gdXBzdHJlYW0g
TGludXggYW5kIENlbnRvcy4NCj4gDQo+ICBkcml2ZXJzL3BjaS9zZXR1cC1idXMuYyB8IDcgKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jIGIvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMgaW5k
ZXgNCj4gZWQ5NjA0MzZkZjVlLi43YWI0MmY3NjU3OWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
cGNpL3NldHVwLWJ1cy5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jDQo+IEBAIC03
NDEsNiArNzQxLDEzIEBAIHN0YXRpYyB2b2lkIHBjaV9icmlkZ2VfY2hlY2tfcmFuZ2VzKHN0cnVj
dCBwY2lfYnVzDQo+ICpidXMpDQo+ICAJc3RydWN0IHJlc291cmNlICpiX3JlczsNCj4gDQo+ICAJ
Yl9yZXMgPSAmYnJpZGdlLT5yZXNvdXJjZVtQQ0lfQlJJREdFX1JFU09VUkNFU107DQo+ICsNCj4g
KwkvKiBEb24ndCByZS1jaGVjayBhZnRlciB0aGlzIHdhcyBjYWxsZWQgb25jZSBhbHJlYWR5Og0K
PiArCSAqIGltcG9ydGFudCBzaW5jZSBicmlkZ2UgbWlnaHQgYmUgaW4gdXNlLg0KPiArCSAqLw0K
PiArCWlmIChiX3Jlc1sxXS5mbGFncyAmIElPUkVTT1VSQ0VfTUVNKQ0KPiArCQlyZXR1cm47DQo+
ICsNCj4gIAliX3Jlc1sxXS5mbGFncyB8PSBJT1JFU09VUkNFX01FTTsNCj4gDQo+ICAJcGNpX3Jl
YWRfY29uZmlnX3dvcmQoYnJpZGdlLCBQQ0lfSU9fQkFTRSwgJmlvKTsNCj4gLS0NCj4gTVNUDQo=
