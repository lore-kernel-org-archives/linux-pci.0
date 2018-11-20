Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8093EC46475
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123152080F
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 21:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="iWuMbqQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123152080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbeKUIAV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:00:21 -0500
Received: from mail-eopbgr760104.outbound.protection.outlook.com ([40.107.76.104]:36944
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbeKUIAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 03:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvGzF5eI+tc3zOxsIj6wHr+u8AMgFdWioolaQmUz0uM=;
 b=iWuMbqQH9sqvNVOJM3hz+jaH4sbnd1A/grAqm61rykulmXsutJnoBb/ZYU9Wn7ffoU+PM24rZEmiFA2gRoaNcKuIDXd66CtTm6dIbsvDNMd9FZvVvsD7V728XTo5bB1i6T898xCcjr/iZdoL+4HrsKKzcTvZh1v7GWAisWxBazo=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3625.namprd06.prod.outlook.com (10.167.236.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 20 Nov 2018 21:28:23 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 21:28:23 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUgPH+9f73kyfh4Ey6Y3qhQ/Hi4qVY+SkAgAAPIwCAABjpAIAADNMA
Date:   Tue, 20 Nov 2018 21:28:23 +0000
Message-ID: <1542749302.30311.624.camel@impinj.com>
References: <20181120165626.26424-1-stefan@agner.ch>
         <20181120165626.26424-2-stefan@agner.ch>
         <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
         <1542741198.30311.608.camel@impinj.com>
         <268e109e1c6b309454bd5a313078894c@agner.ch>
In-Reply-To: <268e109e1c6b309454bd5a313078894c@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3625;6:pYXHtY4T9GsF+7Gt0kXqTgXySPl2V3bRx83QKcN21hq/4YNfPefIlcudH+TlRbTIgjK6fDb8LEnCdPe0eJKl2QQnESWnmXbOGDRZiaDlQrX3sD7ggTFt1aJ63Si+oVi1rzvfNUZ7o6ZDOOPTu8yGZOBao0B3Jymp1/6v5TQjFk50hR+fHifZK+ZFEZSHfXA0i86N5Z8smhairzoT64BPZGXWy4YO28Lfs9s1tAfxwAS9SuDZQ29MwsZ4VYWseJi1oJL1dgjRE10bjMCeHtMWnYsqeg3Pg5/QSrGr6l1DxJRo9fKE+02/WvCL88RylUCLBE7YFY5ohnSpwDtnwgbTYK58O9jzk5jJDcqChS2Irxwc+tHl72E7ofBjEyuplai/bhSlyQDtx+DppAwbfJGXGJlJ/vrgpALpWdMh8sztPwcPSU+mAHqCo+QIsoQcm1UggqNqiQUfSF1nwIpIXGP6gg==;5:adHs0h+9eMagMiV7M0NuzL6ZkhssC/oJGGILGxtfRrZ3IG1LGmio4gc+DAiXSZm86w0G08ACwfQhiomG8McYVVqIcEUvq8IHu6mVQwSRG+4c2To/iyTYhF781XdhFLIS/O7+5YVJNT0jNwGkarrKUOVr0SS4edhyrAQRrdrtD/0=;7:PJV/Yz38wn2jvMp0XJdW3RyrJTGOKXYw4Cx1IOqYwe8uROkR2CT1oauMgWW6RjwGrvnEvNrhbr+pP9ZbXhxt/U720fPz4SP7vXp7xd5r/Udfwcfgu2gMLwQjUV1jV/9Gjcs1t0PiNuQvwI9X9nH/ow==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5d77e209-8322-47b3-ed46-08d64f2f19e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3625;
x-ms-traffictypediagnostic: MWHPR0601MB3625:
x-microsoft-antispam-prvs: <MWHPR0601MB36253445C1C5724C128FD7E5D3D90@MWHPR0601MB3625.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3625;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3625;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39840400004)(54094003)(189003)(199004)(5640700003)(6436002)(256004)(97736004)(6512007)(14444005)(6486002)(6306002)(8936002)(5660300001)(66066001)(54906003)(4326008)(1730700003)(25786009)(39060400002)(8676002)(4001150100001)(2906002)(6916009)(6246003)(68736007)(81156014)(81166006)(7736002)(14454004)(305945005)(106356001)(6116002)(105586002)(3846002)(7416002)(103116003)(966005)(71190400001)(2351001)(71200400001)(6506007)(478600001)(53936002)(11346002)(53546011)(486006)(446003)(102836004)(229853002)(316002)(476003)(2900100001)(2616005)(36756003)(186003)(76176011)(26005)(99286004)(2501003)(86362001)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3625;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SKppySpq+CcGhitqJNnqOXbIvM8ebMcRqNpiFTr6gQbTVpstxQmoFlBOyW4iKkTtVeI2dCscKuXDQSEJRbpG+sz8GFbZ6dKapJd5FdYbqM8c0sUz6MBYc0ymDCsx0oQTui+OW9iAGHzz7egSajfQOuz98BMfFIBsFMv8xCjB0FJk6yMZ47ufgid4os7Oe7ppGA4WTmd+LjYCXRYcFBoIkU4YHC6wxoAKP09noYSpdoZwZRAJYwDxiIOOtnQ50rAgXVeUHoQUlwDVPA1ERJXILoCEDtfmneF4oEZUVohvHTbLqVI+9othmlgd3hS2ZcrUmTyUsbnv6sCb3hqt8E48kR6qWbpDtdc0SXi2NrpxsAQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <322D33FE08A8FF4D9E493E90B77E8947@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d77e209-8322-47b3-ed46-08d64f2f19e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 21:28:23.4094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3625
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTIwIGF0IDIxOjQyICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDIwLjExLjIwMTggMjA6MTMsIFRyZW50IFBpZXBobyB3cm90ZToNCj4gPiANCj4gPiBPbiBJ
TVg3ZCwgdGhlcmUgYXJlIHNpZ25pZmljYW50IGJsb2NrcyBvZiAwMHMgaW4gdGhlIGNvbmZpZyBz
cGFjZSwgYW5kDQo+ID4gYWxsIDB4ZmYgYXQgMHhiNTAgb24gdXAuDQo+ID4gDQo+ID4gSS5lLiwg
c2lnbmlmaWNhbnQgcG9ydGlvbnMgYXJlIGVtcHR5LCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBjb25m
aWcNCj4gPiBzcGFjZSwgbm90IGp1c3QgYXQgdGhlIGVuZC4NCj4gPiANCj4gPiBCdXQgdGhleSBj
YW4gYmUgcmVhZCB3aXRob3V0IHByb2JsZW0uDQo+ID4gDQo+ID4gUGVyaGFwcyBpbXg2cSBhYm9y
dHMgb24gYSByZWFkIG9mIGFuIHVuaW1wbGVtZW50ZWQgYWRkcmVzcyBpbnN0ZWFkIG9mDQo+ID4g
cmV0dXJuaW5nIHplcm9zIGxpa2UgaW14N2QuICBJbiB0aGF0IGNhc2UgaXQgcmVhbGx5IG5lZWRz
IHNvbWV0aGluZw0KPiA+IG1vcmUgY29tcGxleCB0byBwcmV2ZW50IGFib3J0IHRoYW4ganVzdCBh
IGxlbmd0aC4NCj4gDQo+IFllYWggaXQgc2VlbXMgdGhvc2UgU29DcyBiZWhhdmUgZGlmZmVyZW50
bHkuDQo+IA0KPiBEZXNjcmliaW5nIGEgcmVnaXN0ZXIgc2V0IHdpdGggaG9sZXMgd2lsbCBnZXQg
Y29tcGxpY2F0ZWQsIEkgZ3Vlc3MgaXQNCj4gd291bGQgYXNrIGZvciBhIHJlZ21hcC4uLg0KPiAN
Cj4gPiANCj4gPiBJdCBhbHNvIHNlZW1zIHRvIG1lIHRoYXQgdGhpcyBkb2Vzbid0IG5lZWQgdG8g
YmUgaW4gdGhlIGludGVybmFsIHBjaQ0KPiA+IGNvbmZpZyBhY2Nlc3MgZnVuY3Rpb25zLiAgVGhl
IGRyaXZlciBzaG91bGRuJ3QgYmUgcmVhZGluZyByZWdpc3RlcnMNCj4gPiB0aGF0IGRvbid0IGV4
aXN0IGFueXdheS4gIEl0J3MgcmVhbGx5IGFib3V0IHRyeWluZyB0byBmaXggc3lzZnMgYWNjZXNz
DQo+ID4gdG8gcmVnaXN0ZXJzIHRoYXQgZG9uJ3QgZXhpc3QuICBTbyBtYXliZSBpdCBzaG91bGQg
YmUgZG9uZSB0aGVyZS4NCj4gDQo+IFRoYXQgd2FzIG15IGZpcnN0IGFwcHJvYWNoLCBzZWU6DQoN
Cmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzExLzE0LzcxNg0KDQpZZXMsIGJ1dCB0aGF0IGp1
c3QgdXNlZCB0aGUgcGNpIGRldmljZSBpZCB3aGljaCBhcHBsaWVzIHRvIGV2ZXJ5IElNWA0KZGVz
aWduLg0KDQpJdCdzIGFsc28gbm90IHRvdGFsbHkgY29ycmVjdCwgYXMgaXQgc2VlbXMgcmVhbCBy
ZWdpc3RlcnMgYWZ0ZXIgMHgyMDANCmRvIHdvcmsgb24gaW14NiwgYW5kIHRoYXQgd291bGQgcHJl
dmVudCBhY2Nlc3MgdG8gdGhlbS4NCg0KTGlrZSB5b3Ugc2F5LCBpdCBjb3VsZCB1c2UgYSByZWdt
YXAuICBTZWVtcyBraW5kYSBvdmVya2lsbCB0byBtZQ0KdGhvdWdoLg0KDQpJIHdvbmRlciBpZiBy
ZWdtYXAgYmFzZWQgY2FjaGluZyBvZiByZWdpc3RlciB0byBhdm9pZCBSTVcgY3ljbGVzIHdvdWxk
DQpiZSBnZW5lcmFsbHkgdXNlZnVsPyAgSSBrbm93IHRoZSBlbmFibGUgYW5kIG1hc2sgcmVnaXN0
ZXJzIGFyZS93ZXJlDQpjYWNoZWQgaW4gdGhlIGRyaXZlciAoaXJxX3N0YXRlW10pLg0K
