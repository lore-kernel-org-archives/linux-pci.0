Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7D6C04EBC
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43CB2243E
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="SxFOql+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43CB2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbeKOFYk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:24:40 -0500
Received: from mail-eopbgr680122.outbound.protection.outlook.com ([40.107.68.122]:64366
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725756AbeKOFYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 00:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkVXy4uJi3CPdRQQhT/gQnMbe81/Z1ujdi1ZJTA0HYk=;
 b=SxFOql+dFwNOpRROI9OcboTPEzVDWZliodkmm8z9wdEHOy1dQKeJt5SxHLWqjKjchEA+iLYinN60ndbdwKB1iDzQ7guUiKFOxInUyr+ecugbnwvNKL6UleaM+4zbT/1znGzgnfvCCWtqDGBl5BJd5L6cju19mIcWA77+J7OtdR0=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3594.namprd06.prod.outlook.com (10.167.173.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Wed, 14 Nov 2018 19:19:27 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 19:19:27 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@google.com" <helgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICAAJ3NAA==
Date:   Wed, 14 Nov 2018 19:19:27 +0000
Message-ID: <1542223166.30311.471.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
In-Reply-To: <86a7mcdlwg.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3594;6:QN+Li3X5+BQfmcDmafB6vNVcrZRMxtvoK5ycFN0PZkAW+1NmjDTkzxZ1IOUSaeIUrqUvAOMSslibEyJosVhJ29NCipgS0eOnB7lqOQrogdomPiw/QBux+CdHOxVUz8UCEdhydgT2qc8PlocOmvB+Kv6PXsBgOwXfGUmPEFEoQdEZPpRRFQUjutQ6umco1r8mPdBo0ex3zsMnqbgYeV5WitvR6Perkm9kBc1fX5sNZyfyM0qcGQzG7giZ/+PoCtwLH85kn/b3OyQ1deHgUEElq0ETsMOjfFglCnOmQB+vaLsJsVo5vuKT1uEdsGHcuI3lVQJbpLzxlH6w8jirGwuQIx868NWiWXyD4dB4lPdCJNhAnetrCDU4rxxUfN58VRHGxqD7xcrxbQ5sDNDj3G/agg7bTrtHljiD5QGaAER7asi4KIlz7aWDKkwq9lb83gF43Cvbdj8KLEiM7H5X9r5+og==;5:27tl8sFIdxdrzS0V4msE8JKxJZHZSW8xIybqBjlGnqM4wslFqIssMcdaF+fvi+6bcoUBDLL9W2dfsvxf4a/N0R4goIxYfeQlADFhyHwJQ1fqKP0oP75m7y6A2dxmWeyrRD4m6oaFB+JbuJTh+xJYQPRz0R9ktdMUSWuTr4dSX98=;7:NVQpmS9V/sqKc9TJfnfLMaMa9HDkcmPHHexfgzUkG8dZV7hOuD1XpsOEWFarCGWWJet8qVHTBYkV9Ryt3/tEJP+pyhAfLoDWVAQx09e1vntvapsODSB6BpXbc2eW2nq1k2971slTUyvA8QlwaeIlMw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eaa687d9-316b-4e7f-922d-08d64a661832
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3594;
x-ms-traffictypediagnostic: MWHPR0601MB3594:
x-microsoft-antispam-prvs: <MWHPR0601MB3594FBF8BA2790B11153C569D3C30@MWHPR0601MB3594.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(944501410)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3594;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3594;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(25786009)(2900100001)(2501003)(68736007)(14444005)(256004)(305945005)(97736004)(7736002)(4326008)(4001150100001)(8936002)(39060400002)(486006)(71200400001)(86362001)(71190400001)(36756003)(54906003)(476003)(81156014)(81166006)(229853002)(2906002)(6116002)(3846002)(446003)(6506007)(11346002)(2616005)(102836004)(6512007)(66066001)(53936002)(6486002)(106356001)(478600001)(5660300001)(110136005)(14454004)(76176011)(105586002)(316002)(8676002)(6246003)(99286004)(6436002)(26005)(186003)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3594;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QfIkSFPraJ3mSkB9qs/zae3+KPNzLK9CwqOYbBS66N/QuroWiB2fZW7aJlkcnwWL5cRV+dW/TlWBpnLgW0qNiwSI4k5tqxAArlFZS2rBVNXMnLIedVB6v04fpXA/avZa6OcuzNlcU9kLL1IPVeDikGtjBz7eo2e3s9PocX6UQUko1WwBSwKTYjy/CEgsugmrBnfpm4rxcTAsAo/ymv4nhsPLIMAW0+jxX5PQuFjNbSeMkAt09n0JEWGYSMWKX5slyxtpcgfL7Rfvjo+wQ2AwvqRUu1gjhBneMhUc3Hwp7Wy70sKIP0ziQiwXvT71HAYzKwZTiejWOhfDDmqS83wyelF8NB0TROMdIVMKGBcB8R4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6A1AE2D159FCB41B1B76EA9BB79DC67@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa687d9-316b-4e7f-922d-08d64a661832
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 19:19:27.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3594
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDA5OjU0ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
ICAgICAgICAgLyogSW5pdGlhbGl6ZSBJUlEgU3RhdHVzIGFycmF5ICovDQo+IC0gICAgICAgZm9y
IChjdHJsID0gMDsgY3RybCA8IG51bV9jdHJsczsgY3RybCsrKQ0KPiAtICAgICAgICAgICAgICAg
ZHdfcGNpZV9yZF9vd25fY29uZihwcCwgUENJRV9NU0lfSU5UUjBfRU5BQkxFICsNCj4gKyAgICAg
ICBmb3IgKGN0cmwgPSAwOyBjdHJsIDwgbnVtX2N0cmxzOyBjdHJsKyspIHsNCj4gKyAgICAgICAg
ICAgICAgIGR3X3BjaWVfd3Jfb3duX2NvbmYocHAsIFBDSUVfTVNJX0lOVFIwX01BU0sgKw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGN0cmwgKiBNU0lfUkVHX0NU
UkxfQkxPQ0tfU0laRSksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQs
ICZwcC0+aXJxX3N0YXR1c1tjdHJsXSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDQsIH4wKTsNCj4gKyAgICAgICAgICAgICAgIGR3X3BjaWVfd3Jfb3duX2NvbmYocHAs
IFBDSUVfTVNJX0lOVFIwX0VOQUJMRSArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAoY3RybCAqIE1TSV9SRUdfQ1RSTF9CTE9DS19TSVpFKSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgNCwgfjApOw0KPiArICAgICAgICAgICAgICAgcHAt
PmlycV9zdGF0dXNbY3RybF0gPSAwOw0KPiArICAgICAgIH0NCj4gIA0KDQpJIHRlc3RlZCB5ZXN0
ZXJkYXkgYmVmb3JlIHRoaXMgcGF0Y2ggd2FzIHNlbnQgYW5kIGZpeGVkIHRoaXMgaXNzdWUNCmFu
b3RoZXIgd2F5LiAgSSBwcmV0dHkgc3VyZSB0aGlzIHdvdWxkIHdvcmsgYXMgd2VsbCwgdGhvdWdo
IGl0J3Mgbm90DQpjbGVhciB0byBtZSBpdCdzIG1vcmUgY29ycmVjdC4NCg0KSXQgbG9va3MgdG8g
bWUgdGhhdCB0aGUgcHJldmlvdXMgY29kZSB3YXMgdXNpbmcgd2hhdGV2ZXIgTVNJcyB3ZXJlDQph
bHJlYWR5IGVuYWJsZWQgd2hlbiB0aGUgZHJpdmVyIGlzIGluaXRpYWxpemVkIGFzIHRoZSBzZXQg
dG8gbGVhdmUNCmVuYWJsZWQuDQoNClRoaXMgbG9va3MgbGlrZSBpdCBjaGFuZ2luZyB0aGF0IGJl
aGF2aW9yLCBhbmQgaW5zdGVhZCBlbmFibGluZyBhbGwNCk1TSXMgb24gaW5pdGlhbGl6YXRpb24u
DQoNCkkgd291bGQgdGhpbmsgdGhlIGRlZmF1bHQgdmFsdWUgZm9yIGEgTVNJIHNob3VsZCBiZSBk
aXNhYmxlZCB1bnRpbA0Kc29tZXRoaW5nIGVuYWJsZXMgaXQuDQoNCkkgc3BlY3VsYXRlZCB0aGF0
IHRoZSBwcmV2aW91cyBiZWhhdmlvciB3YXMgdHJ5aW5nIHRvIHdvcmsgd2l0aCBhbiBNU0kNCmVu
YWJsZWQgYnkgdGhlIGJvb3Rsb2FkZXIsIEFDUEkgZmlybXdhcmUsIGV0Yy4gdGhhdCBzaG91bGQg
YmUgbGVmdA0KYWxvbmUuICBPciBwZXJoYXBzIHRoZXJlIHdhcyBubyBnb29kIHJlYXNvbiBub3Qg
dG8gZGlzYWJsZSBldmVyeXRoaW5nDQpvbiBpbml0aWFsaXphdGlvbiBhbmQgdGhhdCBjb2RlIGp1
c3QgZ290IGNvcGllZCBmcm9tIHNvbWV3aGVyZSBlbHNlIGFuZA0Kbm8gb25lIHRob3VnaHQgYWJv
dXQgaXQuICBUaGVyZSdzIGNlcnRhaW5seSBldmlkZW5jZSBvZiB0aGF0IGluIHRoaXMNCmRyaXZl
ci4NCg0K
