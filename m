Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DF9ECDE47
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 19:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089A20857
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 19:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="NbyGjNLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1089A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725723AbeKIF06 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:26:58 -0500
Received: from mail-eopbgr720116.outbound.protection.outlook.com ([40.107.72.116]:6167
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbeKIF05 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 00:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwfNhzhPhK3EJFSeQdKEjSsZRXWqhDXPU1ITLrGiPKs=;
 b=NbyGjNLvLsQqMYZj9wIEzQtmZAb/JOmCZuoSwkmEWy2os7NU8bLu60Sx/zBCFcLUzAwmK3r3jze8QCaC/879qnsCDYerSQL2IfXbbN+0LXDE6YyyBMxRUYEyBstIp7q/nar8qOJC5bpocDhTtO7FOAItaXB3Ly0YNHjwicDswNE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3692.namprd06.prod.outlook.com (10.167.236.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 8 Nov 2018 19:49:53 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 19:49:53 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAD2CgIABgdKAgAAa7ICAAOK+gIAAp9qA
Date:   Thu, 8 Nov 2018 19:49:52 +0000
Message-ID: <1541706591.30311.308.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <1541533217.30311.263.camel@impinj.com>
         <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
         <1541621853.30311.294.camel@impinj.com>
         <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
In-Reply-To: <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3692;6:7DZ/DTMBFwXPWPtWjW4AwlBluscYZzMMetV8AD7Dyt4VhkRGmoSSMWq5NxPRUCv94KrdZSGmw22EgJqSffhsE3vkNOkC6SxbquZ3iw6ocYgPwckzcFlMZXzhpMSOpNJJNKXgNYg8cZDOreau6/O9HRqMXnyD9IkJioMlX+hvBWdnepDHXtQjpAxvoSF33wa1KjwNa2uetbt5KOb5RhZsTVDC2j7vkim+XhhbYoMOGv5Kk3Wecox/UuNdibRjB8klv86Zq5T450rgciXrw23z2/FpOoFkbekvkxScOT8PBW2ytOFovrTYo5B1vVQ6x8rVo0OmeOhuKb0So4bB1pDnZAbE58c0cKz//oDzo9f2O34NWCyD02KD3FhKRykW8sXhmbyn2lyx18Tu22rVaV+dLzmbk47sb5Jo7eeEwIYfebpoVT0DFNcP9nDG+/oPNryJ4cjNvSVAzj8+C00ho+PNUw==;5:ijgLQM6ldRuHQ+YoCHZIfDUgBC/r8Y5n3ophaO7WX/4AG3Fmc4jZRFM40fszSyNciVf8Ob2dEh1EVcvcm/A73YvLh2u+Yy2uWpXyAY5UXoJL1exZetKHWV9Iml6LbFv1VjDVqkTHCRXBdcWd4oZrFnmh3Ho4Zf0cAl/kTt8km44=;7:bNr38HJJ2iG0S/ToQbRBkTlvJ4ebJi1yIVqFGSiQF9sJHbdlAjGC/kM1nxOB9qerdMd/aDtFyIrXSKAt71IA5apjMOJ3VXe8vO51gRoNjATE13hBW5Zko7vQjHU2rOpDbhy391mU9hpEcku1A1HwyQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fa1c675d-bf97-4375-72d3-08d645b35a03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3692;
x-ms-traffictypediagnostic: MWHPR0601MB3692:
x-microsoft-antispam-prvs: <MWHPR0601MB369254541C9175302CA40FEFD3C50@MWHPR0601MB3692.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3692;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3692;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39850400004)(346002)(136003)(199004)(189003)(476003)(305945005)(6512007)(7416002)(7736002)(316002)(97736004)(54906003)(110136005)(478600001)(93886005)(103116003)(6506007)(99286004)(105586002)(76176011)(2900100001)(102836004)(53546011)(14454004)(966005)(106356001)(39060400002)(26005)(6246003)(486006)(53936002)(71190400001)(229853002)(25786009)(71200400001)(81156014)(8936002)(81166006)(2501003)(4326008)(6486002)(8676002)(66066001)(6436002)(256004)(3846002)(2616005)(6306002)(6116002)(2906002)(11346002)(36756003)(5660300001)(186003)(86362001)(68736007)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3692;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Vrkkxoo/V4wDSFnTkFgppkufLlydPbdcwlqKZYYgUsAWoNVx7mgN5T0NYQ6E8gHcTNSkskK4uTlCANYHBcXjtqtpt74iyeMmwRyPH9oUYSzTNKoPYkwTp2yI4OE2yF6NWpnpSomFqhtrLDbMXFHetjXgwmXeS0m44grMsFxhAxLgJd6GDZD9HnIZ9KW6un48VPOzFa0TZgAZR7VSbTwtm+bpGJu0Ikww1ibaywUmm75marqvPaCBqfMpK9HexkS80ZZOitv69/L5TReT+Ysyn/pxCzCzXoMWUEL/FjZYJ1AhyWCNnwHLLuT42OuRJOOnbAjPlLXjXiD27Sa0v8YgIwVkxCJRZGFkFBBRFJZ6fk8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <375DA7942D2D0540AEA1FB1294FE7CF9@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1c675d-bf97-4375-72d3-08d645b35a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 19:49:52.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3692
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTA4IGF0IDA5OjQ5ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDA3LzExLzE4IDIwOjE3LCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE4
LTExLTA3IGF0IDE4OjQxICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gPiBPbiAwNi8x
MS8xOCAxOTo0MCwgVHJlbnQgUGllcGhvIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gV2hhdCBh
Ym91dCBzdGFibGUga2VybmVscyB0aGF0IGRvbid0IGhhdmUgdGhlIGhpZXJhcmNoaWNhbCBBUEk/
DQo+ID4gPiANCj4gPiA+IE15IGdvYWwgaXMgdG8gZml4IG1haW5saW5lIGZpcnN0LiBPbmNlIHdl
IGhhdmUgc29tZXRoaW5nIHRoYXQgd29ya3Mgb24NCj4gPiA+IG1haW5saW5lLCB3ZSBjYW4gbG9v
ayBhdCBwcm9wYWdhdGluZyB0aGUgZml4IHRvIG90aGVyIHZlcnNpb25zLiBCdXQNCj4gPiA+IG1h
aW5saW5lIGFsd2F5cyBjb21lcyBmaXJzdC4NCj4gPiANCj4gPiBUaGlzIGlzIGEgcmVncmVzc2lv
biB0aGF0IHdlbnQgaW50byA0LjE0LiAgV291bGRuJ3QgdGhlIGFwcHJvcHJpYXRlDQo+ID4gYWN0
aW9uIGZvciB0aGUgc3RhYmxlIHNlcmllcyBiZSB0byB1bmRvIHRoZSByZWdyZXNzaW9uPw0KPiAN
Cj4gVGhpcyBpcyBub3QgaG93IHN0YWJsZSB3b3Jrcy4gU3RhYmxlIGtlcm5lbHMgKm9ubHkqIGNv
bnRhaW4gcGF0Y2hlcyB0aGF0DQo+IGFyZSBiYWNrcG9ydGVkIGZyb20gbWFpbmxpbmUsIGFuZCBk
byBub3QgdGFrZSBzdGFuZGFsb25lIHBhdGNoLg0KPiANCj4gRnVydGhlcm1vcmUsIHlvdXIgZml4
IGlzIHRvIGFjdHVhbGx5IHVuZG8gc29tZW9uZSBlbHNlJ3MgZml4LiBXaG8gaXMNCj4gcmlnaHQ/
IEluIHRoZSBhYnNlbmNlIG9mIGFueSBkb2N1bWVudGF0aW9uLCB0aGUgYW5zd2VyIGlzICJub2Jv
ZHkiLg0KDQpMaXR0bGUgbW9yZSBoaXN0b3J5IHRvIHRoaXMgYnVnLiAgVGhlIGNvZGUgd2FzIG9y
aWdpbmFsbHkgdGhlIHdheSBpdCBpcw0Kbm93LCBidXQgdGhpcyBzYW1lIGJ1ZyB3YXMgZml4ZWQg
aW4gMjAxMyBpbiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3INCmcvcGF0Y2gvMzMzMzY4MS8N
Cg0KVGhlbiB0aGF0IGxhc3RlZCBmb3VyIHllYXJzIHVudGlsIGl0IHdhcyBjaGFuZ2VkIEF1ZyAy
MDE3IGluIGh0dHBzOi8vcGENCnRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85ODkzMzAzLw0KDQpU
aGF0IGxhc3RlZCBqdXN0IHNpeCBtb250aHMgdW50aWwgc29tZW9uZSB0cmllZCB0byByZXZlcnQg
aXQsIGh0dHBzOi8vcA0KYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85ODkzMzAzLw0KDQpTZWVt
cyBwcmV0dHkgY2xlYXIgdGhlIHdheSBpdCBpcyBub3cgaXMgbXVjaCB3b3JzZSB0aGFuIHRoZSB3
YXkgaXQgd2FzDQpiZWZvcmUsIGV2ZW4gaWYgdGhlIHByZXZpb3VzIGRlc2lnbiBtYXkgaGF2ZSBo
YWQgYW5vdGhlciBmbGF3LiAgVGhvdWdoDQpJJ3ZlIHlldCB0byBzZWUgYW55b25lIHBvaW50IG91
dCBzb21ldGhpbmcgbWFrZXMgdGhlIHByZXZpb3VzIGRlc2lnbg0KYnJva2VuLiAgU3ViLW9wdGlt
YWwgeWVzLCBidXQgbm90IGJyb2tlbi4NCg0KPiBBbnl0aGluZyBjYW4gYmUgYmFja3BvcnRlZCB0
byBzdGFibGUgb25jZSB3ZSB1bmRlcnN0YW5kIHRoZSBpc3N1ZS4gQXQNCj4gdGhlIG1vbWVudCwg
d2UncmUganVzdCBwbGF5aW5nIGdhbWVzIG1vdmluZyBzdHVmZiBhcm91bmQgYW5kIGhvcGUNCj4g
bm90aGluZyBlbHNlIHdpbGwgYnJlYWsuIFRoYXQncyBub3QgYSBzdXN0YWluYWJsZSB3YXkgb2Yg
bWFpbnRhaW5pbmcNCj4gdGhpcyBkcml2ZXIuIEF0IHRoZSBtb21lbnQsIHRoZSBvbmx5IHBhdGNo
IEknbSBpbmNsaW5lZCB0byBwcm9wb3NlIHVudGlsDQo+IHdlIGdldCBhbiBhY3R1YWwgaW50ZXJy
dXB0IGhhbmRsaW5nIGZsb3cgZnJvbSBTeW5vcHN5cyBpcyB0byBtYXJrIHRoaXMNCj4gZHJpdmVy
IGFzICJCUk9LRU4iLg0KDQpJdCBmZWVscyBsaWtlIHlvdSdyZSB1c2luZyB0aGlzIGJ1ZyB0byBo
b2xkIGRlc2lnbndhcmUgaG9zdGFnZSBpbiBhDQpicm9rZW4ga2VybmVsLCBhbmQgbWUgYWxvbmcg
d2l0aCB0aGVtLiAgSSBkb24ndCBoYXZlIHRoZSBkb2N1bWVudGF0aW9uLA0Kbm8gb25lIGRvZXMs
IHRoZXJlJ3Mgbm8gd2F5IGZvciBtZSB0byBnaXZlIHlvdSB3YW50IHlvdSB3YW50LiAgQnV0IEkn
dmUNCmdvdCBoYXJkd2FyZSB0aGF0IGRvZXNuJ3Qgd29yayBpbiB0aGUgbWFpbmxpbmUga2VybmVs
Lg0K
