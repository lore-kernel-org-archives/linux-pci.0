Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409FDC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 21:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE68922419
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 21:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="NqsYK5eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE68922419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeKOHec (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:34:32 -0500
Received: from mail-eopbgr730132.outbound.protection.outlook.com ([40.107.73.132]:6123
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbeKOHec (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 02:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZy4M4YQ4a09oqR0XliqIRH//qvkKaiE8QbdCC5G+y8=;
 b=NqsYK5eo4qdhIT2OU4LqtyB6PkmDfuDZ3w+sx+QAAfWZDRd9NaOupNVxHavxh6fUDzzo5G2Kc4fX2Hum0X0vcFluZEH85GLEui9gcRLFM2ZQrAdhMN34HEu8Enf9bXRAEH89hPrLdrZGBN20ZUGsrkI/bECuB2V6UkrJih+M/zs=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3628.namprd06.prod.outlook.com (10.167.236.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Wed, 14 Nov 2018 21:29:29 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 21:29:29 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAV9pgIAAXX+AgAEgwwCAAJhwAIAF+FkAgAOANgA=
Date:   Wed, 14 Nov 2018 21:29:28 +0000
Message-ID: <1542230968.30311.485.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
         <1541615551.30311.286.camel@impinj.com>
         <60173610-25c2-5f11-a55f-bd431199dc0c@synopsys.com>
         <1541710298.30311.349.camel@impinj.com>
         <20181112160148.GA26379@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181112160148.GA26379@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3628;6:4uomWALiVLg6k4TmB/Z3VX9gBXqT1dYE0E6UmtzYJkPeQ3MVVyV9wseAeSskzipq5Yz7s5IpEUBesVVKPdKjVbExpqlTVXadvC6Qsj4evOGFkCLTi6WPk57Chj6LgP7Vdil+DQlrVOFlZAiyycjwDxKBKmAVhaEXUuSixRiUAKkKcTPD9Hzyl19pQ+DwWKc4x0YNBJqMXFIg4+M46AKRbvTXzUyUcMOXr4AOT7nq0+0xfaYaDyl1PDp2R9cD6+G7C59eHpcfBO9Hzl5T5tc3a4q2S2kr3MooLOpy82CB9CRJA3EOTW/VO4O6+vtIACfXe7klIUVd4XZlsGEV3Xz4PeQlfZUuLeldtkuHmPPbBWCEB2GZne5KLhq0nXsfG8Bvty6J2TlA+wmzVIitULQI8t1ywMm/Q8cKTIHzpfuqfQpjCVgwyFqvlV2NFRaVukvTvyec7EW412MgNeFfys6jfQ==;5:iW/EBksrmKcIW4CbFvdg2D1kDdmoSefHYt3MchzqMT7NlH27A8eZsiDsxp3FQRPc7bLOq/YbzBHDjXDQllx0SQP/H/+bgvdEryBxrBdC4tkjcb9YfuqItz8mbwz/pM3Xb9rNCnDpnU4btzeN0vvW7fjJDsMjFMsSSktcjxtOxx0=;7:UGudLUwAuXL1nSDA9qsbYkcYer/zCt+8NtJhLJYVVpjGVHWvCnVqc6E64tLj43hFcWQF0XXZXmuK8PTfEIuY4B7TBRaX6mC7oR3lN7vNo5dYSi3+zflj3fktCkMgl3vzhNg6O1QITuXL6G9+KRc1UQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 91a2a8ad-33c8-4ae2-60ba-08d64a78428b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3628;
x-ms-traffictypediagnostic: MWHPR0601MB3628:
x-microsoft-antispam-prvs: <MWHPR0601MB36289EE1E9F365257C135B9CD3C30@MWHPR0601MB3628.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3628;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3628;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39850400004)(346002)(396003)(199004)(189003)(103116003)(6512007)(316002)(25786009)(6116002)(3846002)(66066001)(2616005)(81166006)(36756003)(71190400001)(76176011)(478600001)(4326008)(14454004)(54906003)(476003)(105586002)(8676002)(446003)(229853002)(99286004)(6916009)(305945005)(81156014)(7736002)(11346002)(2351001)(6486002)(6436002)(71200400001)(2501003)(68736007)(26005)(8936002)(93886005)(97736004)(186003)(5660300001)(7416002)(86362001)(6506007)(102836004)(39060400002)(2900100001)(486006)(53936002)(256004)(6246003)(4001150100001)(2906002)(5640700003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3628;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g6E53I/ea7pptOv6ZnhhNnNgto8pyVICM8ng3juGepoSOeUxp6+6ejoChoSjefmAoEGnDVnaz9R1/jOBvpq9kGW0e0SFuxjXKejdgVvzG4WkYve+loD6TSKtijW3XvjzsZocErMfu+nw4TSXJkuOwQUEWy4BT25TjRxFxca++B5+dniRzjMlUnubct4ykdOtdQAmsgE2bFS6AlcT2jsKpQOB7Som9KJWOo6XRt4gG+LQIP8N4+hzMru/Ut//1c0+I2DDw1orC4mPouzJ2iMV/v+iXZXqv/e4SQq2ysicgx3sTQiwd5WGoey0y1KIdsrL1xUNV51HnOcARoTfo5kldSd7hkl23oHIwN1r1ehBkRc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB1FA92E7BD9A54FB86CC19839C19184@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a2a8ad-33c8-4ae2-60ba-08d64a78428b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 21:29:29.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3628
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTEyIGF0IDE2OjAxICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBOb3YgMDgsIDIwMTggYXQgMDg6NTE6MzhQTSArMDAwMCwgVHJlbnQgUGll
cGhvIHdyb3RlOg0KPiA+IA0KPiA+IFRoZSByZWFzb24gaXMgdGhhdCB0aGUgR0lDIGludGVycnVw
dCBhYm92ZSB0aGUgZHdjIGlzIG5vbi1yZWVudHJhbnQuIA0KPiA+IEl0IHJlbWFpbnMgbWFza2Vk
IChha2EgYWN0aXZlWzFdKSBkdXJpbmcgdGhpcyBlbnRpcmUgcHJvY2VzcyAoMSB0byAxMCkuDQo+
ID4gIFRoaXMgbWVhbnMgZXZlcnkgTVNJIGlzIGVmZmVjdGl2ZWx5IGFscmVhZHkgbWFza2VkLiAg
U28gbWFza2luZyB0aGUNCj4gPiBhY3RpdmUgTVNJKHMpIGEgMm5kIHRpbWUgZ2FpbnMgbm90aGlu
ZyBiZXNpZGVzIHByZXZlbnRpbmcgc29tZSBleHRyYQ0KPiA+IGVkZ2VzIGZvciBhIG1hc2tlZCBp
bnRlcnJ1cHQgZ29pbmcgdG8gdGhlIEFSTSBHSUMuDQo+ID4gDQo+ID4gSW4gdGhlb3J5LCBpZiB0
aGUgR0lDIGludGVycnVwdCBoYW5kbGVyIHdhcyByZWVudHJhbnQsIHRoZW4gb24gcmVjZWlwdA0K
PiA+IG9mIGEgbmV3IE1TSSB3ZSBjb3VsZCByZS1lbnRlciB0aGUgZHdjIGhhbmRsZXIgb24gYSBk
aWZmZXJlbnQgQ1BVIGFuZA0KPiA+IHJ1biB0aGUgbmV3IE1TSSAoYSBkaWZmZXJlbnQgTVNJISkg
YXQgdGhlIHNhbWUgdGltZSBhcyB0aGUgb3JpZ2luYWwgTVNJDQo+ID4gaGFuZGxlciBpcyBzdGls
bCBydW5uaW5nLg0KPiA+IA0KPiA+IFRoZXJlIGRpZmZlcmVuY2UgaGVyZSBpcyB0aGF0IGJ5IHVu
bWFza2luZyBpbiB0aGUgaW50ZXJydXB0IGluIHRoZSBHSUMNCj4gPiBiZWZvcmUgdGhlIGR3YyBo
YW5kbGVyIGlzIGZpbmlzaGVkLCBtYXNraW5nIGFuIGluZGl2aWR1YWwgTVNJIGluIHRoZQ0KPiA+
IGR3YyBpcyBubyBsb25nZXIgYSAybmQgcmVkdW5kYW50IG1hc2tpbmcuDQo+IA0KPiBUaGVyZSBp
cyBub3QgKGFuZCB0aGVyZSBtdXN0IG5vdCBiZSkgYW55dGhpbmcgaW4gRFdDIEhXIHRoYXQgYWxs
b3dzDQo+IHVzIGFzc3VtZSBpdHMgImludGVycnVwdCBjb250cm9sbGVyIiBpcyBjYXNjYWRlZCB0
byBhIEdJQy4gSXQgbWF5DQo+IGNvcnJlc3BvbmQgdG8gd2hhdCB3ZSBhcmUgZGVidWdnaW5nIGJ1
dCBpdCBpcyBhbiBhc3N1bXB0aW9uIHdlIG11c3Qgbm90DQo+IG1ha2UgYW5kIGl0cyBkcml2ZXIg
aGFzIHRvIHdvcmsgcmVnYXJkbGVzcyBvZiB3aGF0IGl0cyBpbnRlcnJ1cHQNCj4gY29udHJvbGxl
ciBpcyBjb25uZWN0ZWQgdG8sIHRoYXQncyB0aGUgYmFzaXMgb2YgaGllcmFyY2hpY2FsIElSUSBj
aGlwcw0KPiBtYW5hZ2VtZW50LCBhdCBsZWFzdCBmcm9tIG15IG5hcnJvdyBhbmQgKG1vc3QgbGlr
ZWx5KSBpbmNvbXBsZXRlDQo+IGtub3dsZWRnZSBvZiB0aGUgSVJRIHN1YnN5c3RlbS4NCg0KSWYg
eW91IG1lYW4gd2UgY2FuJ3QgYXNzdW1lIHRoZSBkd2MgaXMgY2FzY2FkZWQgZnJvbSBzcGVjaWZp
Y2FsbHkgYQ0KR0lDLCB0b3RhbGx5IGFncmVlLg0KDQpJZiB5b3UgbWVhbiB3ZSBjYW4ndCBhc3N1
bWUgdGhlIGR3YyBpcyBjYXNjYWRlZCBmcm9tICJzb21ldGhpbmciLCB0aGVuDQpJIGRpc2FncmVl
LiAgVGhlIGRyaXZlciBjYW4ndCBwb3NzaWJseSBiZSBhdCB0aGUgdG9wIGxldmVsLiAgSG93IHdv
dWxkDQp0aGUgY3B1IGV2ZXIgZW50ZXIgaXQ/DQoNCldoYXQgSSB0aGluayByZWFsbHkgaXMgd2hh
dCBtYXR0ZXJzIGhlcmUgaXMgaWYgdGhlIHRoZSBjaGFpbiB0aGUgZHdjIGlzDQpjYXNjYWRlZCBm
cm9tIGFsbG93cyB0aGUgZHdjIHRvIGJlIGNhbGxlZCByZWVudHJhbnRseSBvciBub3QuDQoNCk9u
IG15IHN5c3RlbSwgdGhlIGNvZGUgYmFzZSBJIGluc3BlY3RlZCBkb2VzIG5vdCBhbGxvdyB0aGF0
LiAgSSBkb24ndA0Ka25vdyBvZiBhbnkgd3JpdHRlbiBMaW51eCBpbnRlcnJ1cHQgcG9saWN5IHRo
YXQgc2F5cyB0aGlzIG11c3QgYmUgdGhlDQpjYXNlLiAgSWYgaXQgaXMgbm90IHRoZSBjYXNlLCB0
aGVuIEkgc2VlIG90aGVyIHBvaW50cyBpbiB0aGUgZHdjIGRyaXZlcg0KdGhhdCBhcmUgcG90ZW50
aWFsbHkgcmFjeS4NCg==
