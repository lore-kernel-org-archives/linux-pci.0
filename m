Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC9C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A593920663
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="qM/oQ9C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A593920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeK0D3U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:29:20 -0500
Received: from mail-eopbgr710120.outbound.protection.outlook.com ([40.107.71.120]:8547
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbeK0D3T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Nov 2018 22:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtCAuTxJ/Adbls9rUIJbdXZro/7vNQT3VKEMHeh/2Qs=;
 b=qM/oQ9C4omwWTyad6MJQZ89OHcObR1tUv3UcYd/RtIt64EmE6GU+/bL/LNWyDSzzfm6PANryXXEyIfkdad/3mmN8HmL+z8AgX5FWP/Pn8QtIoct/Qqyg2rDSrkTpyLr9hLTWFSFSYSdvintplZl9fH4feAoUA93Il19YQHWs71Q=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3619.namprd06.prod.outlook.com (52.132.101.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Mon, 26 Nov 2018 16:34:23 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 16:34:23 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
CC:     "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUgPH+9f73kyfh4Ey6Y3qhQ/Hi4qVY+SkAgAAPIwCAABjpAIAIvvoAgABpsgA=
Date:   Mon, 26 Nov 2018 16:34:23 +0000
Message-ID: <1543250062.18519.34.camel@impinj.com>
References: <20181120165626.26424-1-stefan@agner.ch>
         <20181120165626.26424-2-stefan@agner.ch>
         <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
         <1542741198.30311.608.camel@impinj.com>
         <268e109e1c6b309454bd5a313078894c@agner.ch>
         <ee74fde8e40a0ca40bd8b69755c9b0919f779b13.camel@nxp.com>
In-Reply-To: <ee74fde8e40a0ca40bd8b69755c9b0919f779b13.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3619;6:vzodNaLKQ7FC9AgNI3A2G0qN1Wkfo/bQpk/+BEbo3WIdvuHvktigj8oBlcI+nrxY1MiYv4x38qiarcxBCV8J3ak5du2j4fOgXNtJn/QMOiFfWu0IKFSRzcM76jHEgLSWuDhtWk7NbRsGpMRVlbKOqzjTZfnK8Scnic8vfAe27Siuv7b8vBshGXN4LZoBWOBiFGUmDzMkdhdFMQi13bsha4tLVCUhQZPXTjLLQYoKQKCw4EQ96gxD0hv2LkUyTkr2/0i4nbRrXm9iB1NJS+pnsy5m2YGFEXBd5U+hYyMu93mTgCGOejwggkogIA7DXbMqclrHbAlcampZb1qKYiHzrAsv8bouOMd02+G3Qm4w4AzztAeusmVDpvbX3+d08/3Zo59IZoDOHQvqz5ssUZLCzZQPfTbWzitqbXFKSzRbV5eMLwHgVu5vPx9DjbEBFfu1PJfyWnDCY0TVttfEDDq+mg==;5:G1xBEZ3v7g1txR6OeZoMmTfIQrTSRph2C7LE/hm493ZAPH+epfGIwG2+RUFQicfMCB8fjQ+2zGR/NS5x0zxOBQeKsWoyHSmKKhCS9yYv/HJB9Rv7Nq5+eRVQVNsWVxrasqx8TlHQBperiIRQSEvR2d8WPOJ7hlKXZ3ndPzpmIrE=;7:rVIPKQJ7mFLkDC+nnud+A9l1WUAXdwKsEbO6Q2PRgl9hky+DM2GPgB+bc8U63I6cj6b7Odx8Fkb6RaC60ColduJj51wTMMCF3uyLHbBADO/Prrsb24B5OCMEwaIk8LjCxIQtk+2Gl3IHPLERhc1i2A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ef0afc5f-c976-4257-e23c-08d653bd063b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3619;
x-ms-traffictypediagnostic: CY4PR0601MB3619:
x-microsoft-antispam-prvs: <CY4PR0601MB3619242DF73E49BAAA0C4094D3D70@CY4PR0601MB3619.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3619;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3619;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39840400004)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(2906002)(14444005)(256004)(14454004)(36756003)(81156014)(8936002)(81166006)(68736007)(102836004)(6436002)(2501003)(39060400002)(4326008)(316002)(2201001)(86362001)(305945005)(2616005)(476003)(5660300001)(7736002)(99286004)(186003)(11346002)(54906003)(446003)(25786009)(110136005)(6246003)(66066001)(486006)(103116003)(106356001)(105586002)(6506007)(53546011)(6116002)(6512007)(3846002)(97736004)(478600001)(229853002)(6486002)(4001150100001)(7416002)(93886005)(26005)(76176011)(53936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3619;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BreSHS8zPd6VKJyLXbC4rBCplZkpl/g+PSNbVumsHyeptJPjhLPjc/I0SFRXHdJI7RYbTExLxpssNHx7N6/4ow18dLLXMucsA5Ej4bWtIlL+kqw7nIRcVOVpDsI/nWpBMv+MZ9iam9wQOY6ShI9bjOI7E0MVCBuc0Ma4C6WUXz6mAhfq32UOgyz4UM+DZRMZdEkb9EyKeF6c50HcJWTloYXnpQ/S/K2H+iYVk5fBeEQy5gOGumXWO4XVh95QrnT5BkCyHm5Pzu4cmSSNVUkhyH9CUNZKjz4aByssF5rh1HudWrHQDZuQXS7QpixWkL/dg20gliWVMzbMW4VN3hNHxnF1f6jlVvvz753B4md1gSY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F63BF7C2D36C9346AE4DAA674917AEF4@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0afc5f-c976-4257-e23c-08d653bd063b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 16:34:23.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3619
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTI2IGF0IDEwOjE2ICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6
DQo+IE9uIFR1ZSwgMjAxOC0xMS0yMCBhdCAyMTo0MiArMDEwMCwgU3RlZmFuIEFnbmVyIHdyb3Rl
Og0KPiA+IE9uIDIwLjExLjIwMTggMjA6MTMsIFRyZW50IFBpZXBobyB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgMjAxOC0xMS0yMCBhdCAxODoxOSArMDAwMCwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOg0K
PiA+ID4gPiBPbiBUdWUsIDIwMTgtMTEtMjAgYXQgMTc6NTYgKzAxMDAsIFN0ZWZhbiBBZ25lciB3
cm90ZToNCj4gPiA+ID4gPiBEZWZpbmUgdGhlIGxlbmd0aCBvZiB0aGUgREJJIHJlZ2lzdGVycy4g
VGhpcyBtYWtlcyBzdXJlIHRoYXQNCj4gPiA+ID4gPiB0aGUga2VybmVsIGRvZXMgbm90IGFjY2Vz
cyByZWdpc3RlcnMgYmV5b25kIHRoYXQgcG9pbnQsIGF2b2lkaW5nDQo+ID4gPiA+ID4gdGhlIGZv
bGxvd2luZyBhYm9ydCBvbiBhIGkuTVggNlF1YWQ6DQo+ID4gPiA+ID4gICAjIGNhdA0KPiA+ID4g
PiA+IC9zeXMvZGV2aWNlcy9zb2MwL3NvYy8xZmZjMDAwLnBjaWUvcGNpMDAwMFw6MDAvMDAwMFw6
MDBcOjAwLjAvY29uZmlnDQo+ID4gPiA+ID4gICBbICAxMDAuMDIxNDMzXSBVbmhhbmRsZWQgZmF1
bHQ6IGltcHJlY2lzZSBleHRlcm5hbCBhYm9ydCAoMHgxNDA2KQ0KPiA+ID4gPiA+IGF0IDB4YjZl
YTcwMDANCj4gPiA+ID4gPiAgIC4uLg0KPiA+ID4gPiA+ICAgWyAgMTAwLjA1NjQyM10gUEMgaXMg
YXQgZHdfcGNpZV9yZWFkKzB4NTAvMHg4NA0KPiA+ID4gPiA+ICAgWyAgMTAwLjA2MDc5MF0gTFIg
aXMgYXQgZHdfcGNpZV9yZF9vd25fY29uZisweDQ0LzB4NDgNCj4gPiA+ID4gDQo+ID4gPiA+IEkg
ZG9uJ3Qga25vdyBleGFjdGx5IHdoZXJlIHRoaXMgbGltaXRhdGlvbiBjb21lcyBmcm9tLCBJIGNh
biBpbmRlZWQNCj4gPiA+ID4gcmVwcm9kdWNlIGEgc3RhY2sgZHVtcCB3aGVuIGR1bXBpbmcgcGNp
IGNvbmZpZyBmcm9tIC9zeXMvDQo+ID4gPiA+IA0KPiA+ID4gPiBVbmZvcnR1bmF0ZWx5IHRoaXMg
c2VlbXMgdG8gYmxvY2sgYWNjZXNzIHRvIHJlZ2lzdGVycyB1c2VkIGZvcg0KPiA+ID4gPiBmdW5j
dGlvbmFsaXR5IGxpa2UgaW50ZXJydXB0cy4gRm9yIGV4YW1wbGUgZHdfaGFuZGxlX21zaV9pcnEg
ZG9lczoNCj4gPiA+ID4gDQo+ID4gPiA+IAlkd19wY2llX3JkX293bl9jb25mKHBwLCBQQ0lFX01T
SV9JTlRSMF9TVEFUVVMgKw0KPiA+ID4gPiAJCQkgICAgKGkgKiBNU0lfUkVHX0NUUkxfQkxPQ0tf
U0laRSksDQo+ID4gPiA+IAkJCSAgICA0LCAmdmFsKTsNCj4gPiA+ID4gDQo+ID4gPiA+IHdoZXJl
IFBDSV9NU0lfSU5UUjBfU1RBVFVTIGlzIDB4ODMwLiBUaGVyZSBhcmUgbW9yZSBhY2Nlc3NlcyBs
aWtlIHRoaXMuDQo+ID4gPiANCj4gPiA+IE9uIElNWDdkLCB0aGVyZSBhcmUgc2lnbmlmaWNhbnQg
YmxvY2tzIG9mIDAwcyBpbiB0aGUgY29uZmlnIHNwYWNlLCBhbmQNCj4gPiA+IGFsbCAweGZmIGF0
IDB4YjUwIG9uIHVwLg0KPiA+ID4gDQo+ID4gPiBJLmUuLCBzaWduaWZpY2FudCBwb3J0aW9ucyBh
cmUgZW1wdHksIGluIHRoZSBtaWRkbGUgb2YgdGhlIGNvbmZpZw0KPiA+ID4gc3BhY2UsIG5vdCBq
dXN0IGF0IHRoZSBlbmQuDQo+ID4gPiANCj4gPiA+IEJ1dCB0aGV5IGNhbiBiZSByZWFkIHdpdGhv
dXQgcHJvYmxlbS4NCj4gPiA+IA0KPiA+ID4gUGVyaGFwcyBpbXg2cSBhYm9ydHMgb24gYSByZWFk
IG9mIGFuIHVuaW1wbGVtZW50ZWQgYWRkcmVzcyBpbnN0ZWFkIG9mDQo+ID4gPiByZXR1cm5pbmcg
emVyb3MgbGlrZSBpbXg3ZC4gIEluIHRoYXQgY2FzZSBpdCByZWFsbHkgbmVlZHMgc29tZXRoaW5n
DQo+ID4gPiBtb3JlIGNvbXBsZXggdG8gcHJldmVudCBhYm9ydCB0aGFuIGp1c3QgYSBsZW5ndGgu
DQo+ID4gDQo+ID4gWWVhaCBpdCBzZWVtcyB0aG9zZSBTb0NzIGJlaGF2ZSBkaWZmZXJlbnRseS4N
Cj4gPiANCj4gPiBEZXNjcmliaW5nIGEgcmVnaXN0ZXIgc2V0IHdpdGggaG9sZXMgd2lsbCBnZXQg
Y29tcGxpY2F0ZWQsIEkgZ3Vlc3MgaXQNCj4gPiB3b3VsZCBhc2sgZm9yIGEgcmVnbWFwLi4uDQo+
IA0KPiBUaGUgUG9ydExvZ2ljIGFyZWEgc2VlbXMgdG8gYmUgYWx3YXlzIGF0IDB4NzAwLTB4QTAw
LCB0aGVyZSBhcmUgZGVmaW5lcw0KPiBmb3IgaXQuIFNvIHRoaXMgd291bGQgb25seSByZXF1aXJl
IG9uZSBhZGRpdGlvbmFsIHJhbmdlLCBubyByZWdtYXANCj4gc3R1ZmYuDQo+IA0KPiBJIGRvbid0
IGtub3cgaWYgbWFraW5nIHBvcnRsb2dpYyBhY2Nlc3NpYmxlIHRvIHVzZXJzcGFjZSBpcyB1c2Vm
dWwuIEluDQo+IHRoZW9yeSBzb21lYm9keSBjb3VsZCByZWFkIGRlYnVnIERXQyByZWdpc3RlcnMg
dmlhIC9zeXMvYmxhaC9jb25maWcsDQo+IGJ1dCB0aGVyZSBhcmUgYmV0dGVyIHdheXMgdG8gcmVh
ZCBIVyByZWdpc3RlcnMgZnJvbSB1c2Vyc3BhY2UuDQo+IA0KPiBCcm93c2luZyB0aHJvdWdoIHRo
ZSBkb2NzIEkgY2FuJ3QgZmluZCBzdHVmZiBsaWtlIHJlYWRzIHdpdGggc2lkZS0NCj4gZWZmZWN0
cyBzbyBJIGNhbid0IHNheSB0aGF0IGl0J3MgaGFybWZ1bCBlaXRoZXIuDQoNCkkgZG91YnQgdGhv
c2UgcmVnaXN0ZXIgYXJlIHVzZWQgbXVjaCBmcm9tIHVzZXJzcGFjZSwgc2luY2UgQUZBSUsgdGhl
cmUNCmFyZSBubyBwdWJsaWMgZG9jcyBmb3IgdGhlbS4gIEkgaGF2ZSBkdW1wZWQgdGhlIGNvbmZp
ZyByZWdzIGZyb20NCnVzZXJzcGFjZSBpbiBpbXg3ZCB0byBkZWJ1ZyBhIGhhbmcgcHJvYmxlbSwg
YnV0IHRob3NlIHJlZ2lzdGVycyB3ZXJlbid0DQp1c2VmdWwgdG8gbWUuICBNYXliZSB0aGV5IHdv
dWxkIGhhdmUgYmVlbiwgbm8gZG9jcy4uLg0KDQo+ID4gPiBJdCBhbHNvIHNlZW1zIHRvIG1lIHRo
YXQgdGhpcyBkb2Vzbid0IG5lZWQgdG8gYmUgaW4gdGhlIGludGVybmFsIHBjaQ0KPiA+ID4gY29u
ZmlnIGFjY2VzcyBmdW5jdGlvbnMuICBUaGUgZHJpdmVyIHNob3VsZG4ndCBiZSByZWFkaW5nIHJl
Z2lzdGVycw0KPiA+ID4gdGhhdCBkb24ndCBleGlzdCBhbnl3YXkuICBJdCdzIHJlYWxseSBhYm91
dCB0cnlpbmcgdG8gZml4IHN5c2ZzIGFjY2Vzcw0KPiA+ID4gdG8gcmVnaXN0ZXJzIHRoYXQgZG9u
J3QgZXhpc3QuICBTbyBtYXliZSBpdCBzaG91bGQgYmUgZG9uZSB0aGVyZS4NCj4gPiANCj4gPiBU
aGF0IHdhcyBteSBmaXJzdCBhcHByb2FjaA0KPiANCj4gRG9pbmcgaXQgb24gYSBwZXItc29jIGJh
c2lzIGlzIGJldHRlciwgdGhpcyBzZWVtcyB0byBhZmZlY3QgYm90aCA2cSBhbmQNCj4gNnFwICh0
aG9zZSBhcmUgZGlzdGluY3QhKSBidXQgbm90IG90aGVycy4NCj4gDQo+IFRoZSBwY2kgY29uZmln
IGFyZWEgZnJvbSB1c2Vyc3BhY2UgaXMgYWNjZXNzZWQgdGhyb3VnaCBwY2lfb3BzLnJlYWQgPQ0K
PiBkd19wY2llX3JkX2NvbmYgd2hpbGUgaW50ZXJuYWwgYWNjZXNzZXMgZ28gdGhyb3VnaCBkd19w
Y2llX3JkX293bl9jb25mLg0KPiBTbyBtb3ZpbmcgdGhlIGRiaV9sZW5ndGggY2hlY2sgdXAgb25l
IGxldmVsIHdvdWxkIHdvcmsgZWFzaWx5Lg0KDQpXaGF0IGFib3V0IHNvbWV0aGluZyBsaWtlOg0K
DQpzdGF0aWMgaW50IGR3X3BjaWVfcmRfY29uZihzdHJ1Y3QgcGNpX2J1cyAqYnVzLCB1MzIgZGV2
Zm4sIGludCB3aGVyZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBzaXplLCB1MzIg
KnZhbCkNCnsNCglzdHJ1Y3QgcGNpZV9wb3J0ICpwcCA9IGJ1cy0+c3lzZGF0YTsNCg0KCWlmICgh
ZHdfcGNpZV92YWxpZF9kZXZpY2UocHAsIGJ1cywgUENJX1NMT1QoZGV2Zm4pKSkgew0KCQkqdmFs
ID0gMHhmZmZmZmZmZjsNCgkJcmV0dXJuIFBDSUJJT1NfREVWSUNFX05PVF9GT1VORDsNCgl9DQoN
CglpZiAoYnVzLT5udW1iZXIgPT0gcHAtPnJvb3RfYnVzX25yKSB7DQorCQlpZiAocHAtPm9wcy0+
Y2ZnX3ZhbGlkICYmICFwcC0+b3BzX2NmZ192YWxpZChwcCwgd2hlcmUsIHNpemUpKSB7DQorCQkJ
KnZhbCA9IDB4ZmZmZmZmZmY7DQorCQkJcmV0dXJuIFBDSUJJT1NfU09NRVRISU5HX0dPRVNfSEVS
RTsNCisJCX0NCisNCiAgICAgICAgICAgICAgICByZXR1cm4gZHdfcGNpZV9yZF9vd25fY29uZihw
cCwgd2hlcmUsIHNpemUsIHZhbCk7DQorCX0NCglyZXR1cm4gZHdfcGNpZV9yZF9vdGhlcl9jb25m
KHBwLCBidXMsIGRldmZuLCB3aGVyZSwgc2l6ZSwgdmFsKTsNCn0NCg0KaW14NnEgYW5kIGlteDZx
cCBjYW4gcHJvdmlkZSBjZmdfdmFsaWQgdGhhdCBjaGVja3MgdGhlaXIgcmFuZ2UuDQo=
