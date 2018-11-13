Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0899C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815C6223D0
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 18:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="GWZTfqVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815C6223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeKNEzA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:55:00 -0500
Received: from mail-eopbgr720098.outbound.protection.outlook.com ([40.107.72.98]:52512
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbeKNEzA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 23:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv3/eVAZvanvlwzOGc9dlJO8T26nhcCmi7ZpqGLlATQ=;
 b=GWZTfqVipudLCms2SG7DU0ZsiQ2sBwkqKwtWfqpySle18Dd8dUOmt4D0V5bZTwX7DOycT68LnoBOPTYlp/vQ3KY9DKnMrO5QYzh1ZEJYeAc/8uHBRPcECkoVjFXHWNxa7vTKdugvObeSmiYrC75B3+pfCLYGsodQxqgyCQFe3gE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3769.namprd06.prod.outlook.com (10.167.236.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Tue, 13 Nov 2018 18:55:31 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 18:55:31 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAD2CgIABgdKAgAAa7ICAAOK+gIAAp9qAgAEH8QCABZLXAIAACmoAgACb7gCAAItZAA==
Date:   Tue, 13 Nov 2018 18:55:31 +0000
Message-ID: <1542135330.30311.413.camel@impinj.com>
References: <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <1541533217.30311.263.camel@impinj.com>
         <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
         <1541621853.30311.294.camel@impinj.com>
         <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
         <1541706591.30311.308.camel@impinj.com>
         <b4dfa6e0-c569-c669-d3f1-b1016eecefa8@arm.com>
         <f474f03d-4b3f-9175-f91f-327f67060936@synopsys.com>
         <1542071920.30311.411.camel@impinj.com>
         <20181113103646.GA11202@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181113103646.GA11202@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3769;6:MiJwfIvncJNLMyQ4mjJSQrUWNi86/HSNB+v2Iqj1708LcxFYSnB1Y0SFkEm3Esux6cQxir8PVWKjD7cjEY0sg2yKjtFpjQ/3wgwkaSjaZ6N+Ki3lJEVFndOVORQj8UiSi+y38wg/VbXRCxWHXEcxTP4gjhVMvRhLXK4wUaZGcdEKpU/HW5e/oLnoBgoo1hQrQB9Kz3twuGxPcr1v2nwoUSMQ1gLcvLa4CYkKH6VWaCRpJmB8t2W7wVlA+CqJ7tGVdiWmfNEIJhH78phA8aURpUVWoSBLBJmphztpPetaUoJ5ebmm/vqDugttjuT+jw2fRf8VFVk9GL7FaEA2lq/9EFACZ+8pMDlpCL1aGScnGikWz3sVX9O91RQGE3DKBNPUiFsjiAwHBbJjAZ+LJGua0QAh90JvpokkZlvKGqUAbaV/GIFlbk+Q5lG8TdeO2u3y0SgYCX2+KpEGWT3Ww3CzAA==;5:ccoOlUsVU2/XaBMvMtqiawYc6jBWurXxNJ+7ibjKahzmNXxg0J1IW8NR16Hqh1Gaak38EXUCiSPDKZYkGsFbIUmz4Nonk5QP4jW1t3HDrsMLw8hJb6ASJpdZIKRU8vgDofl/xDoNmykK8Nc9Y74HnYLFdE0y88WwyyJq17qlLIU=;7:Sc8IXBb8o0uoIg3hi5B9QadORgxpGHWfPkz7JbW68uPt3urZMYeeEXoOVXLvT+anpmWk668pZGX1IwSgBIVU0F3Qq1UMW0RgZA5+14unXKUpDEFEGm9ybAbNv2WaddGWAE+dOpPzIe+9o0EPpNFybA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e1eec62d-2c95-46c2-ce3c-08d6499995e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3769;
x-ms-traffictypediagnostic: MWHPR0601MB3769:
x-microsoft-antispam-prvs: <MWHPR0601MB37694EE62CB59F919315A37DD3C20@MWHPR0601MB3769.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231406)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3769;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3769;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39850400004)(376002)(346002)(136003)(396003)(199004)(189003)(446003)(53936002)(86362001)(68736007)(2900100001)(66066001)(25786009)(486006)(8676002)(71190400001)(71200400001)(7736002)(105586002)(11346002)(99286004)(8936002)(305945005)(106356001)(81156014)(81166006)(2616005)(97736004)(93886005)(476003)(2351001)(76176011)(6246003)(478600001)(7416002)(6506007)(2906002)(102836004)(6512007)(4001150100001)(26005)(2501003)(229853002)(6486002)(186003)(6116002)(3846002)(14454004)(6916009)(4326008)(316002)(5640700003)(256004)(103116003)(54906003)(39060400002)(5660300001)(6436002)(36756003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3769;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v8P6BNDwcJGlnEcfmEI9iXDwX6j36Jlc1Ke0UkDCWSbXiyxxdH2MEmofTmwVlyJNh/0CHKH5nGlzC9Z78CuNRZOJwG1zPv/CfcfTeQFKeLkxDPNccpMxMWv8Q6URMyjiIzmI92zD6aspQ9n4Ja+J21iz5j+G2NR38ImDzD7klvtWnqlWVRXQT7nisLYK/t4+qtAmjRT8ABw/qKjywgDXyzG2MUSUT3tXTzYtzvMurIvZtuFv5pjwt1OX1CzLpZZ3tw0aWHZdFVPqYimObj4MKislc9Y/Cj7D40GqquB6ynTVs4g8hCqdCqWisP/d9yrse/Oo0TV65567KZA8PDsSVC4r7x9RdjP5+f/nWCCZ+8o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBE77534A4EB5747A69E52E0B79EC778@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eec62d-2c95-46c2-ce3c-08d6499995e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 18:55:31.1287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3769
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTEzIGF0IDEwOjM2ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBOb3YgMTMsIDIwMTggYXQgMDE6MTg6NDFBTSArMDAwMCwgVHJlbnQgUGll
cGhvIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gPiBCYXNlZCBvbiB0aGUgaW5mb3JtYXRp
b24gcHJvdmlkZWQsIGl0cyB2ZXJ5IGxpa2VseSB0aGF0IEkgc2hvdWxkDQo+ID4gPiB1c2UgdGhl
DQo+ID4gPiBQQ0lFX01TSV9JTlRSMF9NQVNLIHJlZ2lzdGVyIGluc3RlYWQgb2YgUENJRV9NU0lf
SU5UUjBfRU5BQkxFIG9uDQo+ID4gPiB0aGUNCj4gPiA+IGR3X3BjaV9ib3R0b21fbWFzaygpIGFu
ZCBkd19wY2lfYm90dG9tX3VubWFzaygpIGNhbGxiYWNrcy4gQXMNCj4gPiA+IHNvb24gYXMgSSBy
ZXR1cm4NCj4gPiA+IGZyb20gTGludXggcGx1bWJlcnMgY29uZmVyZW5jZSwgSSB3aWxsIHRlc3Qg
dGhlIHN5c3RlbSB1c2luZyB0aGUNCj4gPiA+IFBDSUVfTVNJX0lOVFIwX01BU0sgcmVnaXN0ZXIu
DQo+ID4gDQo+ID4gVXNpbmcgZW5hYmxlIHRvIG1hc2sgdGhlIGludGVycnVwdCBpcyBicm9rZW4u
ICBJdCB3aWxsIGFsbG93IGFuIE1TSQ0KPiA+IHRvDQo+ID4gYmUgbG9zdCBpZiBpdCBhcnJpdmVz
IHdoaWxlIHRoZSBNU0kgaW4gbm90IGVuYWJsZWQuICBJdCBpcw0KPiA+IGltcG9zc2libGUNCj4g
PiB0byBwcmV2ZW50IHRoYXQgZnJvbSByYWNpbmcgYWdhaW5zdCB0aGUgcGNpIGRldmljZSBkcml2
ZXIncyBmaW5hbA0KPiA+IGNoZWNrDQo+ID4gdGhhdCBubyBNU0ktc2lnbmFsZWQgY29uZGl0aW9u
IGluIHRoZSBoYXJkd2FyZSBpcyBwcmVzZW50Lg0KPiANCj4gVGhhdCdzIGV4YWN0bHkgd2h5IEkg
cmFpc2VkIHRoZSBwb2ludC4gSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgaWYNCj4gdGhpcyBt
ZWFucyB0aGF0IHRoaXMgcmV2ZXJ0IGlzIG5vdCBlbm91Z2ggdG8gZml4IHRoZSB1bmRlcmx5aW5n
IGlzc3VlDQo+IG9yIHdlIG5lZWQgdGhpcyByZXZlcnQgQU5EIGNvcnJlY3QgbWFzay91bm1hc2sg
b3BlcmF0aW9ucy4NCg0KTG9va3MgbGlrZSBfYW5vdGhlcl8gYnVnIGFkZGVkIHRvIHRoZSBkcml2
ZXIsIHRoaXMgdGltZSBpbiA0LjE3Lg0KDQo=
