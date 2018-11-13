Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB217C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 01:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F722507
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 01:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="MeFgrOib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F722507
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeKMLO3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:14:29 -0500
Received: from mail-eopbgr760117.outbound.protection.outlook.com ([40.107.76.117]:23319
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbeKMLO3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 06:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg3XCYpVq015EcyUBGJvdw1q0q48xQTDnfyQPtI45go=;
 b=MeFgrOibDiCzeQK7P+UfBSg2zzZ2NMTbENAnxNgUEAOzQ6lgeZMtBewkjiu3d0P+bfKde/dgME8WfXhizHmQsvlTAKttT0P+45xWmETc8j/JmZbYNZtFImd2QMSAoo8vH4UEjwiQOvESInIlqKeBQz7LH3OdgsQJ/al5dUUD6cg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3595.namprd06.prod.outlook.com (10.167.173.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.44; Tue, 13 Nov 2018 01:18:41 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 01:18:41 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAD2CgIABgdKAgAAa7ICAAOK+gIAAp9qAgAEH8QCABZLXAIAACmoA
Date:   Tue, 13 Nov 2018 01:18:41 +0000
Message-ID: <1542071920.30311.411.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <1541533217.30311.263.camel@impinj.com>
         <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
         <1541621853.30311.294.camel@impinj.com>
         <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
         <1541706591.30311.308.camel@impinj.com>
         <b4dfa6e0-c569-c669-d3f1-b1016eecefa8@arm.com>
         <f474f03d-4b3f-9175-f91f-327f67060936@synopsys.com>
In-Reply-To: <f474f03d-4b3f-9175-f91f-327f67060936@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3595;6:wxelnZFtUiH9J2egVHO1kSVtNDPOqoaERmdrXF41hpYox/gstrhJh30mmR1JO4XwlW3/jpLszhk6R5EPzxmAInVsEWMyZNhqT+Q9Yr5wZySZ0P8K4r56fLErXDH6UwwycgL9eHIbiL0X65Asu2I5WJDAXC//HSRgNqJ0xqym8e2YBR9YB2o7ELGj7tFexrSAj44Ou2eWS25JtIg/rb9T/AWqOYFW5hspfSWCiYh2wCpZsx3MdO3oBFewnYHOeClu8/lqc23fmbPljrJb2jJ9tiY823Vgt35sdXl4GzZD8U/se/9mqkcxX5aDTAa5nCpMYaS+uHhwwEu1Fou//Siai4gkXi0RXKg7twxoZBGTE3FJSfeIV6Xko8z7lpicCa9WOHaw5IsHVfeiUbPRpqs9KI2r0alrgsl+2/hkewXhUfwf+2IF9RDC79THtxsh0k97a63LWhyg1dS2LIFOFeZTSQ==;5:nzfmsni4H/gZecd/FBVLzxoslDAyF3XjjCzWmKiqr+rn1zl11TqO6TUSA5tTphVRlLQ6keeLBSo51kdOmEsO2xqSU4CdX+D6ydwBcktiBJ86wRXOtX79gweOwIjaw9doc/bzzdVe0uOW+Z0csAoBnosJF26GUxRDirgdHAfYJiY=;7:sdamNRA2fV+iAdTbRIYPHfatrSp9ZhWq5iHdggy9+tx9eSOUx9bKhu2TqaHNQC4n9vcdd+AyG0NhLN88jkyPypYWUcClYOkO3i7QizVgnTLy1X31NRmXgnuoYmhajq3ggSq6wsJV88bGZCorXT4J+Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ac54ae79-0bbc-49c3-d6a8-08d64905f29a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3595;
x-ms-traffictypediagnostic: MWHPR0601MB3595:
x-microsoft-antispam-prvs: <MWHPR0601MB35952A54C537EC96D76C3020D3C20@MWHPR0601MB3595.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3595;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3595;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(39850400004)(396003)(189003)(199004)(7416002)(486006)(11346002)(476003)(2616005)(2900100001)(76176011)(6436002)(8936002)(81166006)(8676002)(106356001)(81156014)(6512007)(68736007)(305945005)(5660300001)(7736002)(25786009)(2501003)(446003)(86362001)(2201001)(36756003)(4001150100001)(186003)(6506007)(53546011)(6486002)(229853002)(71190400001)(6246003)(4326008)(39060400002)(110136005)(26005)(53936002)(54906003)(316002)(14444005)(105586002)(2906002)(256004)(6116002)(3846002)(71200400001)(97736004)(478600001)(93886005)(103116003)(99286004)(102836004)(66066001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3595;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /9S+s9P8zCqBpho7nxkpHXk/OjksyWKNSf79q7yhYlzu4AF1dRib0ZSOJqyPkxQkbcD74Oj5itsYuhfOX/fMU+nJ0ajB1endusXCGiH+59sE7i0IdVW6mYQik1yRPeYe/aVzEA/QOiubc6DP09t/R2JSFkeoNxmjOwCIzP5tWKs2s1kjh+ecuNkdgBePglZ4DATlRmlL5+UIYVmdH1rs/2Ho+0jZ1FEiiBleHMd/JA1FS88sCyohrG/crv2qs8ceasbv2Ta8qFM8yWmlz6SKdBeQsNMkV7iK4DhmbmL1r1qhe/R/R42oH+uozOOt+R0dsHGD7KcCzaEOptA5ow34qp5bz1PVtr7c1qvGVT8vCY4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B68430F8DE7E46874F67B3DC6C32E6@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac54ae79-0bbc-49c3-d6a8-08d64905f29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 01:18:41.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3595
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTEzIGF0IDAwOjQxICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3Rl
Og0KPiBPbiAwOS8xMS8yMDE4IDExOjM0LCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gDQo+ID4g
R3VzdGF2bywgaGVyZSdzIG9uZSBzaW1wbGUgYXNrLiBQbGVhc2UgcmVwbHkgdG8gdGhpcyBlbWFp
bCB3aXRoIGEgc3RlcA0KPiA+IGJ5IHN0ZXAsIHJlZ2lzdGVyIGJ5IHJlZ2lzdGVyIGRlc2NyaXB0
aW9uIG9mIGhvdyBhbiBNU0kgbXVzdCBiZSBoYW5kbGVkDQo+ID4gb24gdGhpcyBIVy4gV2UgZG8g
bmVlZCBpdCwgYW5kIHdlIG5lZWQgaXQgbm93Lg0KPiANCj4gSGkgTWFyYywgSSB0aG91Z2h0IHRo
YXQgSSBkaWQgcmVzcG9uZCB0byB5b3VyIHF1ZXN0aW9uIG9uIE5vdiA4LiBIb3dldmVyIEkgd2ls
bA0KPiByZXBlYXQgaXQgYW5kIGFkZCBzb21lIGV4dHJhIGluZm9ybWF0aW9uIHRvIGl0IG5vdy4N
Cj4gDQo+IEFib3V0IHRoZSByZWdpc3RlcnM6DQo+IA0KPiBQQ0lFX01TSV9JTlRSMF9NQVNLDQo+
IFdoZW4gYW4gTVNJIGlzIHJlY2VpdmVkIGZvciBhIG1hc2tlZCBpbnRlcnJ1cHQsIHRoZSBjb3Jy
ZXNwb25kaW5nIHN0YXR1cyBiaXQNCj4gZ2V0cyBzZXQgaW4gdGhlIGludGVycnVwdCBzdGF0dXMg
cmVnaXN0ZXIgYnV0IHRoZSBjb250cm9sbGVyIHdpbGwgbm90IHNpZ25hbCBpdC4NCj4gQXMgc29v
biBhcyB0aGUgbWFza2VkIGludGVycnVwdCBpcyB1bm1hc2tlZCBhbmQgYXNzdW1pbmcgdGhlIHN0
YXR1cyBiaXQgaXMgc3RpbGwNCj4gc2V0IHRoZSBjb250cm9sbGVyIHdpbGwgc2lnbmFsIGl0Lg0K
PiANCj4gUENJRV9NU0lfSU5UUjBfRU5BQkxFDQo+IEVuYWJsZXMvZGlzYWJsZXMgZXZlcnkgaW50
ZXJydXB0LiBXaGVuIGFuIE1TSSBpcyByZWNlaXZlZCBmcm9tIGEgZGlzYWJsZWQNCj4gaW50ZXJy
dXB0LCBubyBzdGF0dXMgYml0IGdldHMgc2V0IGluIE1TSSBjb250cm9sbGVyIGludGVycnVwdCBz
dGF0dXMgcmVnaXN0ZXIuDQoNCklmIHRoZSBNU0kgaXMgdW5tYXNrZWQgYW5kIHRoZSBzdGF0dXMg
Yml0IGlzIHN0aWxsIHNldCwgKm5vdCogZnJvbSBhDQpuZXcgTVNJIGJ1dCByYXRoZXIgZnJvbSBv
bmUgdGhhdCBhcnJpdmVkIGJlZm9yZSB0aGUgTVNJIHdhcyBtYXNrZWQsDQpkb2VzIHRoZSBjb250
cm9sbGVyIHN0aWxsIHNpZ25hbCBpdD8NCg0KSSB3b3VsZCBzdXNwZWN0IHRoZSBhbnN3ZXIgaXMg
bm86IG9ubHkgYSBuZXcgTVNJIHdpbGwgY2F1c2UgdGhlDQppbnRlcnJ1cHQgYmUgc2lnbmFsZWQg
b24gdW5tYXNrLiAgQW5kIHRoZW4gb25seSBpZiB0aGUgc3RhdHVzIGJpdCBoYXMNCm5vdCBiZWVu
IGNsZWFyZWQgYmVmb3JlIHRoZSB1bm1hc2sgKGFzIHlvdSBzdGF0ZWQgYWxyZWFkeSkuDQoNCkJ1
dCBmb3IgdGhhdCB0byBiZSB0aGUgY2FzZSwgdGhlcmUgbXVzdCBiZSBhbm90aGVyIGJpdCBvZiBp
bnRlcnJ1cHQNCnN0YXR1cyAoaS5lLiwgInBlbmRpbmciKSB0aGF0IHdlIGRvbid0IGtub3cgYWJv
dXQgeWV0LiAgVGhlIGJpdCBpbiB0aGUNCnN0YXR1cyByZWdpc3RlciBhbG9uZSBpcyBub3QgZW5v
dWdoLg0KDQpUaGlzIHBlbmRpbmcgYml0IHdvdWxkIG5lZWQgdG8gYmUgc2V0IG9uIGEgMC0+MSB0
cmFuc2l0aW9uIG9mIHRoZQ0Kc3RhdHVzIGJpdC4gIEFuIE1TSSBhcnJpdmluZyB3aGlsZSB0aGUg
c3RhdHVzIGJpdCBpcyBhbHJlYWR5IDEgZG9lcyBub3QNCnRyaWdnZXIgYSBuZXcgaW50ZXJydXB0
Lg0KDQo+IEFib3V0IHRoaXMgbmV3IGNhbGxiYWNrczoNCj4gDQo+IFRoZSBkd19wY2lfYm90dG9t
X21hc2soKSBhbmQgZHdfcGNpX2JvdHRvbV91bm1hc2soKSBjYWxsYmFja3Mgd2VyZSBhZGRlZCBv
bg0KPiBMaW51eCBrZXJuZWwgdjQuMTcgb24gUENJOiBkd2M6IE1vdmUgTVNJIElSUXMgYWxsb2Nh
dGlvbiB0byBJUlEgZG9tYWlucw0KPiBoaWVyYXJjaGljYWwgQVBJIHBhdGNoIFsxXSBhbmQgYmFz
ZWQgb24gd2hhdCBJJ3ZlIHNlZW4gc28gZmFyLCBiZWZvcmUgdGhpcyBwYXRjaA0KPiB0aGVyZSB3
ZXJlIG5vIGludGVycnVwdCBtYXNraW5nIGJlZW4gcGVyZm9ybWVkLg0KDQpZZXMuICBPciByYXRo
ZXIsIHRoZSBzdGF0dXMgYml0IGJlaW5nIHNldCBlZmZlY3RpdmVseSBtYXNrcyB0aGUNCmludGVy
cnVwdC4NCg0KPiBCYXNlZCBvbiB0aGUgaW5mb3JtYXRpb24gcHJvdmlkZWQsIGl0cyB2ZXJ5IGxp
a2VseSB0aGF0IEkgc2hvdWxkIHVzZSB0aGUNCj4gUENJRV9NU0lfSU5UUjBfTUFTSyByZWdpc3Rl
ciBpbnN0ZWFkIG9mIFBDSUVfTVNJX0lOVFIwX0VOQUJMRSBvbiB0aGUNCj4gZHdfcGNpX2JvdHRv
bV9tYXNrKCkgYW5kIGR3X3BjaV9ib3R0b21fdW5tYXNrKCkgY2FsbGJhY2tzLiBBcyBzb29uIGFz
IEkgcmV0dXJuDQo+IGZyb20gTGludXggcGx1bWJlcnMgY29uZmVyZW5jZSwgSSB3aWxsIHRlc3Qg
dGhlIHN5c3RlbSB1c2luZyB0aGUNCj4gUENJRV9NU0lfSU5UUjBfTUFTSyByZWdpc3Rlci4NCg0K
VXNpbmcgZW5hYmxlIHRvIG1hc2sgdGhlIGludGVycnVwdCBpcyBicm9rZW4uICBJdCB3aWxsIGFs
bG93IGFuIE1TSSB0bw0KYmUgbG9zdCBpZiBpdCBhcnJpdmVzIHdoaWxlIHRoZSBNU0kgaW4gbm90
IGVuYWJsZWQuICBJdCBpcyBpbXBvc3NpYmxlDQp0byBwcmV2ZW50IHRoYXQgZnJvbSByYWNpbmcg
YWdhaW5zdCB0aGUgcGNpIGRldmljZSBkcml2ZXIncyBmaW5hbCBjaGVjaw0KdGhhdCBubyBNU0kt
c2lnbmFsZWQgY29uZGl0aW9uIGluIHRoZSBoYXJkd2FyZSBpcyBwcmVzZW50Lg==
