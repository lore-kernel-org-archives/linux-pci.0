Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7EC43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6942080F
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="mjRcAvGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6942080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbeKTHDV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:03:21 -0500
Received: from mail-eopbgr690093.outbound.protection.outlook.com ([40.107.69.93]:8497
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728938AbeKTHDV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 02:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTVQQnXVTsCYykwJgWjHaEnF9GY+i2rbCHfIr6QivHs=;
 b=mjRcAvGY9KlJjv8FvGGX5G3uzEpppgVaME54BVt6CQXZtvVIgCbW7TtfVR0u8o2iyRylLpmJ6rkbwyzMEw52YcDq9B+wJ7Gi+IXQn3Fzwv01geD/84EA+WTkcEeBn4hjdRI0xyJRbsxtAmZgSnNsBDg181B5E027VAq6EZUePKg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3593.namprd06.prod.outlook.com (10.167.173.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 19 Nov 2018 20:37:19 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 20:37:19 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "helgaas@google.com" <helgaas@google.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICAAJ3NAIAALV6AgAfECwA=
Date:   Mon, 19 Nov 2018 20:37:18 +0000
Message-ID: <1542659838.30311.561.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
         <1542223166.30311.471.camel@impinj.com>
         <86sh0348tu.wl-marc.zyngier@arm.com>
In-Reply-To: <86sh0348tu.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3593;6:CrYJdfQB5LZWiIAmtY0F8mzMZ7U4Qxa7O93+kIXGiKRwRidnC+DmNxmYWD7VEPh5UL/lDf+gQIx9XuPsmeozoZZYtt/sHKMdsinBGXVa4KCetxZbn28UUTszBrLIJz1xdcbS0XXtfFak6ik1N6nPnamePA7KHce7b+AlNyIcbNcPNLxCla5B2NjWOx44UhhkJjzeiVcQrDivQV/eadNFEHRsSYIVk5GSJiIR8q4Xhu35EMv1J6l22KFhvvnw2G03ZqrWvHzEvseJ5mhSMZa4FednjiHne3KeRqyMtTKjj4jRsSBkEQN1YJwKTkQkslYTtkjepYu0/wEvbWj68bRojw1TgLXZzy1YTJycBQLJZKn8FiBmvOgCzCIC2/8SlpE7mYMFQQccgbeBkISo4vbHmOyaqBxm11qwgizUCuWFxLlmuK1YKViufjTBX6uQgtkxplLKOepfqu5yCrpliRS/aQ==;5:yeYrRzy7Z8JvR63RiNaO6uxt48gbMm+WcZoaX+nC7ROsdhSeyEMXEmsXxPr8OtUYJa/7U2CzSsXlkuWNhntcp1ZQJfVBEogBo+q9al0PrS0RKiKwPMWoaH+R2nSfJn4glVrCziCxBvTxFM9AmpSRNgj7keeshVwp3d7mBXRrhQ8=;7:/7wj+vQcdwKLzeL4QlR88dWJL+B70uuKVoX5HlFT8j2MLEgwW3Kdndw0LV4s7IQD893/CBXpG6+JS5TIDQzBjj9hqMScoRiz/Q+Xw4SoOFjQpUPXih429xulzeWdxHuawJx8UefuE3HJJmclyDJuTA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 38d311d5-cb4d-438b-4306-08d64e5eccdc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3593;
x-ms-traffictypediagnostic: MWHPR0601MB3593:
x-microsoft-antispam-prvs: <MWHPR0601MB3593A4772D92C8600CC81BB1D3D80@MWHPR0601MB3593.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3593;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3593;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39850400004)(376002)(199004)(189003)(97736004)(2351001)(81166006)(81156014)(5660300001)(6486002)(25786009)(106356001)(54906003)(93886005)(6436002)(478600001)(186003)(103116003)(6506007)(36756003)(26005)(102836004)(7736002)(105586002)(8936002)(2900100001)(316002)(8676002)(305945005)(229853002)(14444005)(256004)(6916009)(6512007)(53936002)(71190400001)(6246003)(5640700003)(71200400001)(14454004)(99286004)(66066001)(2906002)(2616005)(476003)(446003)(11346002)(4326008)(68736007)(76176011)(86362001)(6116002)(4001150100001)(2501003)(486006)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3593;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DIA+jkBgzhVBWFEWwB1ykA66UlD8g/gF5tM0mjA/gBlHS8Y5fZGt+4AjRVIvl1hM1UlQ7o80jso53/qJzg0/CWDJ5isriuQRfJlCNaOSjg+VQ83cfu+SlzkNBqDbjYFt9Bk3FSvTdRUny53D96v529t7FlbtowExgLx5OX2jPVwqQkGArzMwMLUaMI9c3WUvLwizeuPcESntrZ8FT6sbkjINLsGavCV25ubrlHCvTPj5EAQwbd4ftTJOri4+NJvoB0B8GcevtHstZFgjn3ax/QfrTdA64aj/YUvJaJQFKd3KPNWRWceGYH2SY5Oa0KxSKbFKADLjYshqrwOLzgFNKqeEgGnViq+J5dmD3c/geXs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <64C6878DED860049ABD555EEF4F56839@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d311d5-cb4d-438b-4306-08d64e5eccdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 20:37:18.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3593
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDIyOjAxICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFdlZCwgMTQgTm92IDIwMTggMTk6MTk6MjcgKzAwMDAsDQo+IA0KPiA+IEl0IGxvb2tzIHRv
IG1lIHRoYXQgdGhlIHByZXZpb3VzIGNvZGUgd2FzIHVzaW5nIHdoYXRldmVyIE1TSXMgd2VyZQ0K
PiA+IGFscmVhZHkgZW5hYmxlZCB3aGVuIHRoZSBkcml2ZXIgaXMgaW5pdGlhbGl6ZWQgYXMgdGhl
IHNldCB0byBsZWF2ZQ0KPiA+IGVuYWJsZWQuDQo+IA0KPiBBbmQgSSBjbGFpbSB0aGF0IHRoaXMg
aXMgYSBncm9zcyBidWcuIFdlIGRvbid0IHdhbnQgdG8gaW5oZXJpdA0KPiBhbnl0aGluZyBhdCBh
bGwsIHJhdGhlciBzdGFydCBmcm9tIGEgZnJlc2ggc3RhcnQuDQo+IA0KPiA+IFRoaXMgbG9va3Mg
bGlrZSBpdCBjaGFuZ2luZyB0aGF0IGJlaGF2aW9yLCBhbmQgaW5zdGVhZCBlbmFibGluZyBhbGwN
Cj4gPiBNU0lzIG9uIGluaXRpYWxpemF0aW9uLg0KPiA+IA0KPiA+IEkgd291bGQgdGhpbmsgdGhl
IGRlZmF1bHQgdmFsdWUgZm9yIGEgTVNJIHNob3VsZCBiZSBkaXNhYmxlZCB1bnRpbA0KPiA+IHNv
bWV0aGluZyBlbmFibGVzIGl0Lg0KPiANCj4gU3VyZSwgdGhhdCdzIG5vIGJpZyBkZWFsLiBXZSBj
YW4gcGx1ZyBpbiB0aGUgZW5hYmxlL2Rpc2FibGUgY2FsbGJhY2tzDQo+IHRvIHRoYXQgZWZmZWN0
LCBhbHRob3VnaCB3ZSdsbCBlbmQtdXAgd2l0aCBzaW1pbGFyIHJlc3VsdCwgSSdkIGV4cGVjdC4N
Cj4gDQo+ID4gSSBzcGVjdWxhdGVkIHRoYXQgdGhlIHByZXZpb3VzIGJlaGF2aW9yIHdhcyB0cnlp
bmcgdG8gd29yayB3aXRoIGFuIE1TSQ0KPiA+IGVuYWJsZWQgYnkgdGhlIGJvb3Rsb2FkZXIsIEFD
UEkgZmlybXdhcmUsIGV0Yy4gdGhhdCBzaG91bGQgYmUgbGVmdA0KPiA+IGFsb25lLiAgT3IgcGVy
aGFwcyB0aGVyZSB3YXMgbm8gZ29vZCByZWFzb24gbm90IHRvIGRpc2FibGUgZXZlcnl0aGluZw0K
PiA+IG9uIGluaXRpYWxpemF0aW9uIGFuZCB0aGF0IGNvZGUganVzdCBnb3QgY29waWVkIGZyb20g
c29tZXdoZXJlIGVsc2UgYW5kDQo+ID4gbm8gb25lIHRob3VnaHQgYWJvdXQgaXQuICBUaGVyZSdz
IGNlcnRhaW5seSBldmlkZW5jZSBvZiB0aGF0IGluIHRoaXMNCj4gPiBkcml2ZXIuDQo+IA0KPiBB
cyB5b3Ugc2FpZCwgeW91J3JlIHNwZWN1bGF0aW5nLiBOb25ldGhlbGVzcywgdGhlcmUgaXMgbm8g
cmVhc29uIHRvDQo+IHN0YXJ0IHdpdGggYW55dGhpbmcgZW5hYmxlZCB0aGUgZmlyc3QgcGxhY2Uu
DQoNCkZpcnN0IGludHJvZHVjdGlvbiBvZiB0aGlzIGNvbmNlcHQgZXhwbGljaXRseSBhcHBlYXJz
IHRvIGJlIGJ5IEd1c3Rhdm8NCmluIGNvbW1pdCA3YzU5MjVhZmJjLiAgSXQgYWRkZWQgaXJxX3N0
YXR1cyB0byB0aGUgZHJpdmVyIHN0YXRlIGFuZA0KaW5pdGlhbGl6ZWQgaXQgZnJvbSB0aGUgZXhp
c3RpbmcgdmFsdWUgb2YgdGhlIGVuYWJsZSByZWdpc3Rlci4gIFByaW9yDQp0byB0aGlzIHRoZSBi
aXRzIHdlcmUgYWx3YXlzIHNldCBpbiBhIFJNVyBvcGVyYXRpb24gSSBkb24ndCB0aGluaw0KaW5p
dGlhbGl6YXRpb24gd2FzIGNvbnNpZGVyZWQuDQoNCkkgZG9uJ3Qgc2VlIGFueSBub3RlIGFib3V0
IHdoeS4gIEFsbCBkaXNhYmxlZCBtYWtlcyBmYXIgbW9yZSBzZW5zZSB0bw0KbWUuICBZb3UgZ2V0
IGhhcmQgdG8gdHJhY2sgZG93biBidWdzIHdpdGggdW5leHBlY3RlZCBpbnRlcnJ1cHRzIGR1cmlu
Zw0Ka2VybmVsIGJvb3QsIGJ1dCBvbmx5IGEgc29mdCByZWJvb3QsIGJlY2F1c2UgdGhlIGlycSBp
cyBlbmFibGVkIGJlZm9yZQ0KdGhlIGRyaXZlcnMgZXhwZWN0ZWQgaXQgdG8gYmUuDQo=
