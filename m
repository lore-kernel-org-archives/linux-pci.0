Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B17C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431002081F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 18:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431002081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeLJSSD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:18:03 -0500
Received: from dfwrgout.huawei.com ([206.16.17.72]:2059 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbeLJSSD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 13:18:03 -0500
X-Greylist: delayed 940 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 13:18:03 EST
Received: from dfweml702-cah.china.huawei.com (unknown [172.18.9.222])
        by Forcepoint Email with ESMTP id 731D1F4210CDE;
        Mon, 10 Dec 2018 12:02:21 -0600 (CST)
Received: from SJCEML701-CHM.china.huawei.com (10.208.112.40) by
 dfweml702-cah.china.huawei.com (10.193.5.176) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Dec 2018 10:02:22 -0800
Received: from SJCEML521-MBS.china.huawei.com ([169.254.2.185]) by
 SJCEML701-CHM.china.huawei.com ([169.254.3.191]) with mapi id 14.03.0415.000;
 Mon, 10 Dec 2018 10:02:12 -0800
From:   Eric Wehage <Eric.Wehage@huawei.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: RE: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
Thread-Topic: [RFC] Proposed PCI ECR for description of Advanced Peer to
 Peer Capabilities
Thread-Index: AQHUkH99uHLQpIpsU0OEL04E/sq5aKV4vkgA//+DUoA=
Date:   Mon, 10 Dec 2018 18:02:11 +0000
Message-ID: <DD8FB053C05D2D4DB8AA6C933261787859975862@sjceml521-mbs.china.huawei.com>
References: <20181210115653.0000615a@huawei.com>
 <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
In-Reply-To: <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.247.157]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9nYW4sDQoNCglUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGlzLg0KDQoJQWx0aG91Z2gg
SSBtZW50aW9uZWQgdGhlIG1pbmltdW0gYmFuZHdpZHRoIHJlcXVpcmVtZW50IGluIHRoZSBpbnRy
b2R1Y3Rpb24gb2YgdGhlIEVDUiwgSSBkaWQgbm90IGluY2x1ZGUgYW55IHNwZWNpZmljYXRpb24g
Y2hhbmdlcyB0aGF0IHdvdWxkIHJlcXVpcmUgdGhpcy4gSSByZWNvZ25pemVkIHRoYXQgZm9yIHAy
cCB0byBiZSB1c2VmdWwsIHRoZXJlIG11c3QgYmUgYSB1c2VmdWwgbGV2ZWwgb2YgYmFuZHdpZHRo
LCBob3dldmVyLCBJIGNvdWxkIHNlZSBubyBlYXN5IHdheSB0byBhZGVxdWF0ZWx5IGFkdmVydGlz
ZSB0aGlzLiBVbHRpbWF0ZWx5LCBiYW5kd2lkdGggbGV2ZWxzIGNvdWxkIGJlIHNlZW4gYXMgcGFy
dCBvZiB0aGUgcGxhdGZvcm0gYXJjaGl0ZWN0dXJlIG9mIGVhY2ggT0VNLiBQZXJmb3JtYW5jZSBk
aWZmZXJlbmNlcyBiZXR3ZWVuIE9FTSdzIGlzIG9mdGVuIHdoYXQgbWFrZXMgYSBidXllciBjaG9v
c2Ugb25lIE9FTSdzIHN5c3RlbSBvdmVyIGFub3RoZXIgaW4gYSBjb21wZXRpdGl2ZSBlbnZpcm9u
bWVudC4gU28gcmVxdWlyaW5nIGEgcGFydGljdWxhciBiYW5kd2lkdGggbGV2ZWwgaXMgbGlrZSBy
ZXF1aXJpbmcgYW4gT0VNIHRvIGluY2x1ZGUgYSBtaW5pbXVtIG51bWJlciBvZiBjb3JlcyBpbiBh
IHN5c3RlbSBvciBhIG1pbmltdW0gbnVtYmVyIG9mIFBDSWUgbGlua3MuIFNvIHVsdGltYXRlbHks
IEkgZXhjbHVkZWQgYW55IGRpc2N1c3Npb24gb2YgYmFuZHdpZHRoIGluIHRoZSBFQ1Igc3BlYyBj
aGFuZ2VzLg0KDQoJSG93ZXZlciwgaWYgeW91IHNlZSBhIHBhcnRpY3VsYXIgd2F5IHRoYXQgdGhp
cyBpc3N1ZSBjb3VsZCBiZSBhcHByb2FjaGVkLCBJIGFtIHN0aWxsIHdpbGxpbmcgdG8gY29uc2lk
ZXIgYSBjaGFuZ2UuDQoNCkVyaWMgV2VoYWdlDQpIdWF3ZWkgUHJpbmNpcGFsIEVuZ2luZWVyLCBQ
Q0llDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMb2dhbiBHdW50aG9ycGUg
W21haWx0bzpsb2dhbmdAZGVsdGF0ZWUuY29tXSANClNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTAs
IDIwMTggOToyMCBBTQ0KVG86IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVh
d2VpLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBiaGVsZ2Fhc0Bnb29nbGUu
Y29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBFcmljIFdlaGFnZSA8RXJpYy5XZWhhZ2VA
aHVhd2VpLmNvbT47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgU3RlcGhlbiBCYXRl
cyA8c2JhdGVzQHJhaXRobGluLmNvbT4NClN1YmplY3Q6IFJlOiBbUkZDXSBQcm9wb3NlZCBQQ0kg
RUNSIGZvciBkZXNjcmlwdGlvbiBvZiBBZHZhbmNlZCBQZWVyIHRvIFBlZXIgQ2FwYWJpbGl0aWVz
DQoNCkhpIEpvbmF0aGFuLA0KDQpUaGFua3MgZm9yIHRha2luZyB0aGlzIG9uLg0KDQpPbiAyMDE4
LTEyLTEwIDQ6NTYgYS5tLiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gSSB3b3VsZCByZWNv
bW1lbmQgcmVhZGluZyB0aGUgRUNSIGFuZCBwcmVzZW50YXRpb24gZm9yIG1vcmUgZGV0YWlscy4N
Cj4gQW55b25lIHdobyBjYW4ndCBnZXQgdG8gR29vZ2xlIERyaXZlLCBlbWFpbCBtZSBhbmQgSSds
bCBzZW5kIGEgY29weSBkaXJlY3RseS4NCj4gDQo+IEVDUjogDQo+IGh0dHBzOi8vZHJpdmUuZ29v
Z2xlLmNvbS9vcGVuP2lkPTFYMDhwZnlqa053U2ZwVFZCdWl1dDkwYWp4QlpkN0JYZw0KPiBTbGlk
ZXM6IA0KPiBodHRwczovL2RyaXZlLmdvb2dsZS5jb20vb3Blbj9pZD0xMWQzZWdBOHg5MWQ5OS1R
cWZZR1otTXhMR3JIcEpIQ0sNCg0KSSd2ZSBsb29rZWQgdGhyb3VnaCB0aGUgRUNSIG5vdyBhIGNv
dXBsZSB0aW1lcyBhbmQgaGF2ZW4ndCByZWFsbHkgc3BvdHRlZCBhbnkgbWFqb3IgaXNzdWVzIHdp
dGggaXQuDQoNClRoZSBtaW5pbXVtIHN1cHBvcnRlZCBiYW5kd2lkdGggcmVxdWlyZW1lbnQgaXMg
cHJldHR5IHZhZ3VlIGFuZCBteSBiaWdnZXN0IGNvbmNlcm4gaXMgdGhhdCBoYXJkd2FyZSB2ZW5k
b3JzIG11c3QgcmVwb3J0IGNvbnNpc3RlbnRseSBvdGhlcndpc2UgdGhpcyBpcyB1c2VsZXNzLiBT
byBJJ2QgbWF5YmUgc3VnZ2VzdCBleHBhbmRpbmcgb24gd2hhdCdzIHJlcXVpcmVkIGJlZm9yZSBo
YXJkd2FyZSBpcyBhbGxvd2VkIHRvIGluZGljYXRlIHN1cHBvcnQuDQoNCkFsc28sIG9uZSB0aG91
Z2h0IGlzLCBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gYWRkIGFub3RoZXIgYml0IGluZGljYXRpbmcg
cGVyZm9ybWFuY2UuIFNvIHRoZSBoYXJkd2FyZSBjYW4gc2F5OiB0aGVzZSBUTFBzIHdpbGwgYmUg
c3VwcG9ydGVkIGJ1dCB0aGV5IHdpbGwgbm90IGJlIHN1cHBvcnRlZCBhdCBoaWdoIGJhbmR3aWR0
aC4NCg0KSW4gdGVybXMgb2YgZGVmaW5pbmcgaGlnaCBiYW5kd2lkdGg6IHdoYXQgSSBjYXJlIGFi
b3V0IGlzIHdoZXRoZXIgdGhlIGJhbmR3aWR0aCB0aHJvdWdoIHRoZSBQMlAgbGluayB3aWxsIGJl
IHNpZ25pZmljYW50bHkgc2xvd2VyIHRoYW4gdGhlIGJhbmR3aWR0aCBvZiBnb2luZyB0by9mcm9t
IHN5c3RlbSBSQU0uIElmIHRoYXQncyB0aGUgY2FzZSBpdCBwcm9iYWJseSBtZWFucyBhIHN1YnNl
dCBvZiBQMlAgYXBwbGljYXRpb25zIHdvdWxkIHJhdGhlciBqdXN0IHRyYW5zZmVyIHRvIFJBTSBp
bnN0ZWFkIG9mIGdvaW5nIFAyUC4NCg0KTG9nYW4NCg0K
