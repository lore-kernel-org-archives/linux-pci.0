Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6078C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97A2086A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="J/x0P7II"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B97A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeKTGkP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:40:15 -0500
Received: from mail-eopbgr680091.outbound.protection.outlook.com ([40.107.68.91]:34306
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728844AbeKTGkP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 01:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9G0bfu5PfHVB4M+uH2F8REpVhHSCv+TueWem0dbHAQ=;
 b=J/x0P7II/CgnRrBUFUbToTFgMNJgsgy/i82dx8wxFgM8sbXgZngul2aoGgbj2XI7eL1DqPef7RWIF3hwSKv5tq+MXIoIfxK5bXov1CIrdfSRHji1bw1aKVKcf55Gmz0K6nlPhjfGrRFKmG4NIpLVyGyWPzYdHCkD7xeijd/wLas=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3612.namprd06.prod.outlook.com (10.167.236.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 19 Nov 2018 20:14:55 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 20:14:55 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@google.com" <helgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVPmEcAgAFeawCAADaPAIAADoUAgAZWAgA=
Date:   Mon, 19 Nov 2018 20:14:55 +0000
Message-ID: <1542658494.30311.552.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <1542220084.30311.453.camel@impinj.com>
         <a5f464c5-bc21-5986-7974-6fbabc450147@synopsys.com>
         <1542307052.30311.531.camel@impinj.com>
         <865zwyw351.wl-marc.zyngier@arm.com>
In-Reply-To: <865zwyw351.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3612;6:peXVc5QfXSdoO7/moBWkTj0jr/MHUXP2QYS6stV8b9JBHvpkcEPDlPw7Zja1gZWrd1ab/fdOsckT150UlryyJYcY9x4jY3zr6AARZwzcLHguN7p+KAuwkGR+VelwgcNjVtHBL/aoPEr9uduEzCCr7eVI/UPvKqbClaSmvXKrgrmsS+m1iL0P4Nk5qzlodjxTWJtRZpoDq0YP4NCJr6s94bDlHdW/V6CHRxayfVwrrhrmI2SCK0Y/xqU+SA8I35/wyKZRbEOdslVdCXb4zyUXSRqvHnxpJpbxirGFTMpFzd3gON96sOpjsFslffH/cxSE1VMsrq+WaNXDTqrmOSzKFwZqhWOcY0/0b0zFXyyuI3H2yqrCz/zfan0mwufssURqpxxwgkQnPqQ872oMUZHL4DCGFxBep7IrhZ+z8b6MSiIZohHUAMHOFZCaIn+TQba4MvWvSoF7wnb8kd1yEvSd+A==;5:wfEdez+eBLtuhoncLPVzIH9GE2OeDTCprZtuipG6XV5pOT03CwlxPUoixxxswP5F0ICu9ZauWCOpdriniq5lVigPhLZCfD9ExjKKvYuoxHwbwVI0gjuT/Z7R3xxMTZwIkHutR1mBqxx9lLKhnzfCSt7htEhvVeDFf3t79XH3zVg=;7:Lm1q1TZZKwz+pyzFYjNNbSY+xZUO15NEsMDJny15wQs7x9SK/97QSpN5nX9ARJBxEo1Qq/KkSpLC4qRaCfEsdHy+xD13X7m1c7Wk850H2eUSPW4YPshq5dZq7C4UaYLPqih7OtgyLmzUaswBMHjI9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2568c83b-a1bc-4d73-ef12-08d64e5bac14
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3612;
x-ms-traffictypediagnostic: MWHPR0601MB3612:
x-microsoft-antispam-prvs: <MWHPR0601MB36129B1260E5063B2010CEBBD3D80@MWHPR0601MB3612.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3612;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3612;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(39840400004)(396003)(366004)(199004)(54094003)(189003)(2501003)(14444005)(66066001)(103116003)(71190400001)(305945005)(71200400001)(229853002)(8676002)(7736002)(81156014)(81166006)(256004)(2616005)(476003)(11346002)(36756003)(486006)(53546011)(99286004)(4326008)(105586002)(39060400002)(2906002)(76176011)(6916009)(8936002)(25786009)(106356001)(6506007)(93886005)(102836004)(446003)(6246003)(186003)(14454004)(5660300001)(68736007)(6116002)(3846002)(97736004)(86362001)(26005)(2900100001)(478600001)(6436002)(6512007)(5640700003)(2351001)(4001150100001)(53936002)(316002)(54906003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3612;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bpXDqE+xIJupzqvJIm6Xu1OOO/Bykk/3ua/CpTIXRu3oJLQfIahbgZdmOW8ijVHxLdcLG/7PwHUiaXvrH1VBUpt0rxYvlEfA+GsvowtCvLRXTI4lEu1iXxTV4Xba/Dc43r7l/Tmk2ZldxhpwjSqJLzZTQ17lHF5XpmtLP5vGnqBP5kAK5sOknEdNVGHwzj3eWwLd7sMvGvVH00FgOlyapjASG+rn7fWh3qUBBbmHETNWD5enjzkSDNTgZxKHmIyVu0qgBDE4AA40va9b1agKLXwXznwa+fo81VuB00JeOOywsJz9V6dTAJF+gb0Lrdugwa3HA1bPVqqfDhJeGPu7Q2tUpihWzdHK5dJ9YVCgaaE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF0B6873A739C449AFF25B5813C1A643@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2568c83b-a1bc-4d73-ef12-08d64e5bac14
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 20:14:55.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3612
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTE1IGF0IDE5OjI5ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFRodSwgMTUgTm92IDIwMTggMTg6Mzc6MzMgKzAwMDAsDQo+IFRyZW50IFBpZXBobyA8dHBp
ZXBob0BpbXBpbmouY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMTgtMTEtMTUgYXQg
MTU6MjIgKzAwMDAsIEd1c3Rhdm8gUGltZW50ZWwgd3JvdGU6DQo+ID4gPiBPbiAxNC8xMS8yMDE4
IDE4OjI4LCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAxOC0xMS0xMyBh
dCAyMjo1NyArMDAwMCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gTm93IGl0IHdvcmtzIGFnYWluLiAgUmFjZSBzdGlsbCBwcmVzZW50LiAgSSBkb24n
dCBzZWUgdGhlDQo+ID4gPiA+IGR3X3BjaV9tc2lfYm90dG9tXyh1biltYXNrIG1ldGhvZHMgZXZl
ciBnZXQgY2FsbGVkLiAgSSBzZWVtIHRvIHJlY2FsbA0KPiA+ID4gPiB0aGF0IHRoZXkgYXJlIGNh
bGxlZCBhcyBhIHN1YnN0aXR1dGUgaWYgZW5hYmxlL2Rpc2FibGUgYXJlIG5vdCBwcmVzZW50LA0K
PiA+ID4gPiBidXQgaGF2ZW4ndCBjb25maXJtZWQgdGhhdCwgd2hpY2ggd291bGQgZXhwbGFpbiB3
aHkgdGhleSBhcmUgbm90IGNhbGxlZA0KPiA+ID4gPiBhZnRlciBJIGFkZGVkIGVuYWJsZS4NCj4g
PiA+IA0KPiA+ID4gSHVtLCB0aGlzIHByb2JhYmx5IGlzIGNvcnJlbGF0ZWQgd2l0aCBbMV0gd2hl
cmUgb24gdGhlIGRlc2NyaWJpdGlvbiB0aGUgdGhpcw0KPiA+ID4gZW51bWVyYXRvciBzYXlzIHRo
YXQgIk9uZSBzaG90IGRvZXMgbm90IHJlcXVpcmUgbWFzay91bm1hc2siIHNlZSBbMl0NCj4gPiAN
Cj4gPiBUaGF0IHNlZW1zIHJlYXNvbmFibGUgdGhlbi4gIEkndmUgc2FpZCBiZWZvcmUgdGhhdCB3
aGlsZSBJIHRoaW5rDQo+ID4gbWFza2luZyBjb3VsZCBiZSBhZGRlZCBpbiB0aGUgaW50ZXJydXB0
IGZsb3cgd2l0aG91dCBicmVha2luZyBhbnl0aGluZywNCj4gPiBJIHRoaW5rIGl0J3MgcmVkdW5k
YW50IHRvIGRvIGl0IGF0IHRoaXMgbGF5ZXIuDQo+ID4gDQo+ID4gSSBzdXNwZWN0IGl0IG1pZ2h0
IGJlIHBvc3NpYmxlIG1hc2svdW5tYXNrIHRoZSBpbnRlcnJ1cHQgIm1hbnVhbGx5IiwNCj4gPiBl
LmcuIFVJTyBkb2VzIHRoaXMgdG8gYWxsb3cgaGFuZGxpbmcgYSBsZXZlbCBpbnRlcnJ1cHQgZnJv
bSB1c2Vyc3BhY2UsDQo+ID4gYW5kIHRoYXQgd291bGQgYmUgYSBwYXRoIHRvIHJlYWNoIHRoZSBt
YXNrIG1ldGhvZHMuDQo+IA0KPiBUaGUgcmVhbCB1c2UgY2FzZSBpcyB0aGF0IGEgZHJpdmVyIGNh
biBwZXJmZWN0bHkgZGlzYWJsZSAobWFzaykgYW4NCj4gaW50ZXJydXB0IHdoaWxlIGJlaW5nIGlu
IHRoZSBpbnRlcnJ1cHQgaGFuZGxlciwgYW5kIGVuYWJsZSBpdCBhZ2FpbiBhdA0KPiBhIGxhdGVy
IHRpbWUuDQoNClRoYXQncyB3aGF0IEkgd2FzIHRoaW5raW5nIG9mIHdpdGggVUlPLCBidXQgdWlv
X2RtZW1fZ2VuaXJxX2hhbmRsZXIoKQ0KYWN0dWFsbHkgY2FsbHMgZGlzYWJsZV9pcnFfbm9zeW5j
KCkuICBJIGhhZCB0aG91Z2h0IGl0IG1hc2tlZCB0aGUgaXJxDQpyYXRoZXIgdGhhbiBkaXNhYmxl
ZCBpdC4NCg0KSSB3b25kZXIgaWYgdGhpcyBpcyBhIFVJTyBidWcuICBUaGUgZGlzdGluY3Rpb24g
YmV0d2VlbiBkaXNhYmxlIGFuZA0KbWFzayBpcyB1c3VhbGx5IHRoYXQgdGhlIG1hc2tlZCBpbnRl
cnJ1cHQgaXMgbm90IGxvc3Qgd2hpbGUgdGhlDQpkaXNhYmxlZCBpbnRlcnJ1cHQgaXMuICBCdXQg
dGhlcmUgYXJlIGlycSBjaGlwcyAobGlrZSBkd2MhKSB0aGF0IGRvIG5vdA0KIGltcGxlbWVudCBl
bmFibGUvZGlzYWJsZSBtZXRob2RzIGFuZCB1c2UgbWFzayBtZXRob2RzIGluc3RlYWQu
