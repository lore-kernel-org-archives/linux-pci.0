Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2563ECDE47
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0420844
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 20:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="MolpU/OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA0420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeKIG24 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:28:56 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:64153
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeKIG24 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 01:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9C86PkJMdAfuQgWIKWp51pYaqt6cUH+U+jdkQAlqCs=;
 b=MolpU/OY87fBV+uU4rXhLw7sjdBlUKTgKtOdHDBDiIrC9cYh1leXy6NZ7EJf/KRVH6Sne3+OjcHJjUKLrBjhStTpgt2JEf1gB8mS9M1wlfsj5cNn6idjI1dDwjztGc8oWEJsMHTF4+Dh6mMXNQHoIHnDk5/XnhWyg6YoqqzOQfo=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3626.namprd06.prod.outlook.com (10.167.236.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 8 Nov 2018 20:51:39 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 20:51:39 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAV9pgIAAXX+AgAEgwwCAAJhwAA==
Date:   Thu, 8 Nov 2018 20:51:38 +0000
Message-ID: <1541710298.30311.349.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
         <1541615551.30311.286.camel@impinj.com>
         <60173610-25c2-5f11-a55f-bd431199dc0c@synopsys.com>
In-Reply-To: <60173610-25c2-5f11-a55f-bd431199dc0c@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3626;6:IJRfUnG2KsdcfAsqgSaLuuRG/hHGtPyZuqc4V49Ib9uTk8w4Eyfg/3aPf/ZYZbBiKIkZjleGxcTJxN1MZYsDjk4aNuX3GJXBiQQ1UQPczQqnBZH9umMqooA3J+w3De15f4E+kQbsY5zeJFaOEEd0XZ36KySf+YqL3nnTUovNi66enNWl7FUQo6y31hU1vOtgH23DTdRrS1xX1bTlQY0oFHu7FOHgdO6LFl6GaRyHDVJt1A5UGCPY/9nduocM7rW9ZoDAd9jGMeJyjcNimHMOZnl4I9fC4iQGUiZzGY+BmystR/4tDGCO7A5B70fO1MKK/yuRUiRY0LBeFV7j130Hv9zh+s0iSGFMpFGkDifIlv5FoDU5aWGm24ppl4jISQI3RG7NesxaqzSruLlUQZOFYAYYWKETHFcS89Av59fJLOTH96+EO2/zDAzjuIy2Lamnp5mzsdon7ZBs0+lhwoJvvQ==;5:oXRzfkWbvH3Ko/naCKxmRfibjhQ30GVT6s6Iw2gEVoTgClY49PCciNB21qME+0rLsg1SB7FpWD6caNlLu90Q3nu3xJoB/7GBcAVxulYH1HhAYokrQaNeACZ2pGndi8gVy6uA6KpTt+vWFVhzcjjGbymTR2J1Er5plp7nrONBlYI=;7:CRmo9ZIaMj2A+p6xdbwMMr8gyA3buVHVvg3hHE1r4qTE0skWnXFzjvABm/w2SukLfep8RFoClfLL5hshN2JAqPcr9h0XLO3uwL8dXVoiStab0XsuazGh5usrOnk/iMukXelPGv9doU7iTRxaUcOTXw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 207c481d-5cc7-4232-d841-08d645bbfae9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3626;
x-ms-traffictypediagnostic: MWHPR0601MB3626:
x-microsoft-antispam-prvs: <MWHPR0601MB36268A429F9A561B7D197601D3C50@MWHPR0601MB3626.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3626;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3626;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39850400004)(376002)(366004)(189003)(199004)(71190400001)(105586002)(71200400001)(3846002)(99286004)(76176011)(2201001)(6116002)(229853002)(26005)(36756003)(186003)(6486002)(6506007)(106356001)(256004)(14444005)(102836004)(53546011)(2501003)(2906002)(7416002)(39060400002)(66066001)(81166006)(93886005)(8676002)(486006)(4326008)(2900100001)(8936002)(5660300001)(81156014)(6246003)(2616005)(11346002)(476003)(446003)(305945005)(103116003)(7736002)(6512007)(316002)(54906003)(110136005)(53936002)(86362001)(14454004)(97736004)(68736007)(25786009)(6436002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3626;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1IrSOMUNhPCQ0HPgPROzkHCFDU5L11EGUHX+e0+FGcp7ZYY8rp9AwmyEWwgiGcFuLdwxpYI5S5zQtXOu/YMgDuxpyx6EDClbTIYlOZQ6uNBEREaQhfigwJO77VS8iuSbyE+8J8RHQp3MqsORsnnm/cC5qRTu2cTVPN5Lwlxdfv2IAUcRFq+K720SeI3WQ+r9ZX0q6EuV7tz30lklyxRFmg7JE+GIRKGkdIz/mNrXTH+Z3ZCx2c7eUkrtV4BRuPELYsAJUemIEtJD3zjGZoSkqL9NN8yUDVFqyHyxCe8ojFcPAc9FyfY0TmF1bA2pKMiqU5tJfEum9Pq6kNCqW8m738cXzcYuvYvHCY+FEYbNMc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FAB46E6F74D8C4A8984E63B751CB2F7@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207c481d-5cc7-4232-d841-08d645bbfae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 20:51:38.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3626
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTA4IGF0IDExOjQ2ICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3Rl
Og0KPiBPbiAwNy8xMS8yMDE4IDE4OjMyLCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDE4LTExLTA3IGF0IDEyOjU3ICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3RlOg0KPiA+
ID4gT24gMDYvMTEvMjAxOCAxNjowMCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiA+ID4gPiBPbiAw
Ni8xMS8xOCAxNDo1MywgTG9yZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gPiA+ID4gT24gU2F0
LCBPY3QgMjcsIDIwMTggYXQgMTI6MDA6NTdBTSArMDAwMCwgVHJlbnQgUGllcGhvIHdyb3RlOg0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGlzIGdpdmVzIHRoZSBmb2xsb3dpbmcgcmFjZSBz
Y2VuYXJpbzoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gMS4gIEFuIE1TSSBpcyByZWNlaXZl
ZCBieSwgYW5kIHRoZSBzdGF0dXMgYml0IGZvciB0aGUgTVNJIGlzIHNldCBpbiwgdGhlDQo+ID4g
PiA+ID4gPiBEV0MgUENJLWUgY29udHJvbGxlci4NCj4gPiA+ID4gPiA+IDIuICBkd19oYW5kbGVf
bXNpX2lycSgpIGNhbGxzIGEgZHJpdmVyJ3MgcmVnaXN0ZXJlZCBpbnRlcnJ1cHQgaGFuZGxlcg0K
PiA+ID4gPiA+ID4gZm9yIHRoZSBNU0kgcmVjZWl2ZWQuDQo+ID4gPiA+ID4gPiAzLiAgQXQgc29t
ZSBwb2ludCwgdGhlIGludGVycnVwdCBoYW5kbGVyIG11c3QgZGVjaWRlLCBjb3JyZWN0bHksIHRo
YXQNCj4gPiA+ID4gPiA+IHRoZXJlIGlzIG5vIG1vcmUgd29yayB0byBkbyBhbmQgcmV0dXJuLg0K
PiA+ID4gPiA+ID4gNC4gIFRoZSBoYXJkd2FyZSBnZW5lcmF0ZXMgYSBuZXcgTVNJLiAgQXMgdGhl
IE1TSSdzIHN0YXR1cyBiaXQgaXMgc3RpbGwNCj4gPiA+ID4gPiA+IHNldCwgdGhpcyBuZXcgTVNJ
IGlzIGlnbm9yZWQuDQo+ID4gPiA+ID4gPiA2LiAgZHdfaGFuZGxlX21zaV9pcnEoKSB1bnNldHMg
dGhlIE1TSSBzdGF0dXMgYml0Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGUgTVNJIHJl
Y2VpdmVkIGF0IHBvaW50IDQgd2lsbCBuZXZlciBiZSBhY3RlZCB1cG9uLiAgSXQgb2NjdXJyZWQg
YWZ0ZXINCj4gPiA+ID4gPiA+IHRoZSBkcml2ZXIgaGFkIGZpbmlzaGVkIGNoZWNraW5nIHRoZSBo
YXJkd2FyZSBzdGF0dXMgZm9yIGludGVycnVwdA0KPiA+ID4gPiA+ID4gY29uZGl0aW9ucyB0byBh
Y3Qgb24uICBTaW5jZSB0aGUgTVNJIHN0YXR1cyB3YXMgbWFza2VkLCBpdCBkb2VzIG5vdA0KPiA+
ID4gPiA+ID4gZ2VuZXJhdGVkIGEgbmV3IElSUSwgbmVpdGhlciB3aGVuIGl0IHdhcyByZWNlaXZl
ZCBub3Igd2hlbiB0aGUgTVNJIGlzDQo+ID4gPiA+ID4gPiB1bm1hc2tlZC4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gVGhpcyBzdGF0dXMgcmVnaXN0ZXIgaW5kaWNhdGVzIHdoZXRoZXIgZXhpc3RzIG9y
IG5vdCBhIE1TSSBpbnRlcnJ1cHQgb24gdGhhdA0KPiA+ID4gY29udHJvbGxlciBbMC4uN10gdG8g
YmUgaGFuZGxlLg0KPiA+IA0KPiA+IFdoaWxlIHRoZSBzdGF0dXMgZm9yIGFuIE1TSSBpcyBzZXQs
IG5vIG5ldyBpbnRlcnJ1cHQgd2lsbCBiZSB0cmlnZ2VyZWQNCj4gDQo+IFllcw0KPiANCj4gPiBp
ZiBhbm90aGVyIGlkZW50aWNhbCBNU0kgaXMgcmVjZWl2ZWQsIGNvcnJlY3Q/DQo+IA0KPiBZb3Ug
Y2Fubm90IHJlY2VpdmUgYW5vdGhlciBpZGVudGljYWwgTVNJIHRpbGwgeW91IGFja25vd2xlZGdl
IHRoZSBjdXJyZW50IG9uZQ0KPiAoVGhpcyBpcyBlbnN1cmVkIGJ5IHRoZSBQQ0kgcHJvdG9jb2ws
IEkgZ3Vlc3MpLg0KDQpJIGRvbid0IGJlbGlldmUgdGhpcyBpcyBhIHJlcXVpcmVtZW50IG9mIFBD
SS4gIFdlIGRlc2lnbmVkIG91ciBoYXJkd2FyZQ0KdG8gbm90IHNlbmQgYW5vdGhlciBNU0kgdW50
aWwgb3VyIGhhcmR3YXJlJ3MgaW50ZXJydXB0IHN0YXR1cyByZWdpc3Rlcg0KaXMgcmVhZCwgYnV0
IHdlIGRpZG4ndCBoYXZlIHRvIGRvIHRoYXQuDQoNCj4gPiA+IEluIHRoZW9yeSwgd2Ugc2hvdWxk
IGNsZWFyIHRoZSBpbnRlcnJ1cHQgZmxhZyBvbmx5IGFmdGVyIHRoZSBpbnRlcnJ1cHQgaGFzDQo+
ID4gPiBhY3R1YWxseSBoYW5kbGVkICh3aGljaCBjYW4gdGFrZSBzb21lIHRpbWUgdG8gcHJvY2Vz
cyBvbiB0aGUgd29yc3QgY2FzZSBzY2VuYXJpbykuDQo+ID4gDQo+ID4gQnV0IHNlZSBhYm92ZSwg
dGhlcmUgaXMgYSByYWNlIGlmIGEgbmV3IE1TSSBhcnJpdmVzIHdoaWxlIHN0aWxsIG1hc2tlZC4N
Cj4gPiAgSSBjYW4gc2VlIG5vIHBvc3NpYmxlIHdheSB0byBzb2x2ZSB0aGlzIGluIHNvZnR3YXJl
IHRoYXQgZG9lcyBub3QNCj4gPiBpbnZvbHZlIHVubWFza2luZyB0aGUgTVNJIGJlZm9yZSBjYWxs
aW5nIHRoZSBoYW5kbGVyLiAgVG8gbGVhdmUgdGhlDQo+ID4gaW50ZXJydXB0IG1hc2tlZCB3aGls
ZSBjYWxsaW5nIHRoZSBoYW5kbGVyIHJlcXVpcmVzIHRoZSBoYXJkd2FyZSB0bw0KPiA+IHF1ZXVl
IGFuIGludGVycnVwdCB0aGF0IGFycml2ZXMgd2hpbGUgbWFza2VkLiAgV2UgaGF2ZSBubyBkb2Nz
LCBidXQgdGhlDQo+ID4gZGVzaWdud2FyZSBjb250cm9sbGVyIGRvZXNuJ3QgYXBwZWFyIHRvIGRv
IHRoaXMgaW4gcHJhY3RpY2UuDQo+IA0KPiBTZWUgbXkgcmVwbHkgdG8gTWFyYyBhYm91dCB0aGUg
aW50ZXJydXB0IG1hc2tpbmcuIExpa2UgeW91IHNhaWQsIHByb2JhYmx5IHRoZQ0KPiBzb2x1dGlv
biBwYXNzIHRocm91Z2ggdXNpbmcgaW50ZXJydXB0IG1hc2svdW5tYXNrIHJlZ2lzdGVyIGluc3Rl
YWQgb2YgaW50ZXJydXB0DQo+IGVuYWJsZS9kaXNhYmxlIHJlZ2lzdGVyLg0KPiANCj4gQ2FuIHlv
dSBkbyBhIHF1aWNrIHRlc3QsIHNpbmNlIHlvdSBjYW4gZWFzaWx5IHJlcHJvZHVjZSB0aGUgaXNz
dWU/IENhbiB5b3UNCj4gY2hhbmdlIHJlZ2lzdGVyIG9mZnNldCBvbiBib3RoIGZ1bmN0aW9ucyBk
d19wY2lfYm90dG9tX21hc2soKSBhbmQNCj4gZHdfcGNpX2JvdHRvbV91bm1hc2soKT8NCj4gDQo+
IEJhc2ljYWxseSBleGNoYW5nZSB0aGUgUENJRV9NU0lfSU5UUjBfRU5BQkxFIHJlZ2lzdGVyIGJ5
IFBDSUVfTVNJX0lOVFIwX01BU0suDQoNCk9mIGNvdXJzZSBNU0kgc3RpbGwgbmVlZCB0byBiZSBl
bmFibGVkIHRvIHdvcmsgYXQgYWxsLCB3aGljaCBoYXBwZW5zDQpvbmNlIHdoZW4gdGhlIGRyaXZl
ciB1c2luZyB0aGUgTVNJIHJlZ2lzdGVycyBhIGhhbmRsZXIuICBNYXNraW5nIGNhbiBiZQ0KZG9u
ZSB2aWEgbWFzayByZWdpc3RlciBhZnRlciB0aGF0Lg0KDQpJdCBpcyBub3Qgc28gZWFzeSBmb3Ig
bWUgdG8gdGVzdCBvbiB0aGUgbmV3ZXN0IGtlcm5lbCwgYXMgaW14N2QgZG9lcw0Kbm90IHdvcmsg
ZHVlIHRvIHlldCBtb3JlIGJ1Z3MuICBJIGhhdmUgdG8gcG9ydCBhIHNldCBvZiBwYXRjaGVzIHRv
IGVhY2gNCm5ldyBrZXJuZWwuICBBIHNldCB0aGF0IGRvZXMgbm90IHNocmluayBkdWUgdG8gaG9s
ZHVwcyBsaWtlIHRoaXMuDQoNCkkgdW5kZXJzdGFuZCB0aGUgbmV3IGZsb3cgd291bGQgbG9vayBs
aWtlIHRoaXMgKGFzc3VtZSBkdyBjb250cm9sbGVyDQpNU0kgaW50ZXJydXB0IG91dHB1dCBzaWdu
YWwgaXMgY29ubmVjdGVkIHRvIG9uZSBvZiB0aGUgQVJNIEdJQw0KaW50ZXJydXB0IGxpbmVzLCB0
aGVyZSBjb3VsZCBiZSBkaWZmZXJlbnQgb3IgbW9yZSBjb250cm9sbGVycyBhYm92ZSB0aGUNCmR3
YyBvZiBjb3Vyc2UgKGJ1dCB1c3VhbGx5IGFyZW4ndCkpOg0KDQoxLiBNU0kgYXJyaXZlcywgc3Rh
dHVzIGJpdCBpcyBzZXQgaW4gZHdjLCBpbnRlcnJ1cHQgcmFpc2VkIHRvIEdJQy4NCjIuIGR3YyBo
YW5kbGVyIHJ1bnMNCjMuIGR3YyBoYW5kbGVyIHNlZXMgc3RhdHVzIGJpdCBpcyBzZXQgZm9yIGEo
bikgTVNJKHMpDQo0LiBkd2MgaGFuZGxlciBzZXRzIG1hc2sgZm9yIHRob3NlIE1TSXMNCjUuIGR3
YyBoYW5kbGVyIGNsZWFycyBzdGF0dXMgYml0DQo2LiBkd2MgaGFuZGxlciBydW5zIGRyaXZlciBo
YW5kbGVyIGZvciB0aGUgcmVjZWl2ZWQgTVNJDQo3LiAqKiBhbiBuZXcgTVNJIGFycml2ZXMsIHJh
Y2luZyB3aXRoIDYgKioNCjguIHN0YXR1cyBiaXQgYmVjb21lcyBzZXQgYWdhaW4sIGJ1dCBubyBp
bnRlcnJ1cHQgaXMgcmFpc2VkIGR1ZSB0byBtYXNrDQo5LiBkd2MgaGFuZGxlciB1bm1hc2tzIE1T
SSwgd2hpY2ggcmFpc2VzIHRoZSBpbnRlcnJ1cHQgdG8gR0lDIGJlY2F1c2UNCm9mIG5ldyBNU0kg
cmVjZWl2ZWQgaW4gNy4NCjEwLiBUaGUgb3JpZ2luYWwgR0lDIGludGVycnVwdCBpcyBFT0knZWQu
DQoxMS4gVGhlIGludGVycnVwdCBmb3IgdGhlIGR3YyBpcyByZS1yYWlzZWQgYnkgdGhlIEdJQyBk
dWUgdG8gOSwgYW5kIHdlDQpnbyBiYWNrIHRvIDIuDQoNCkl0IGlzIHZlcnkgaW1wb3J0YW50IHRo
YXQgNSBiZSBkb25lIGJlZm9yZSA2LiAgTGVzcyBzbyA0IGJlZm9yZSA1LCBidXQNCnJldmVyc2lu
ZyB0aGUgb3JkZXIgdGhlcmUgd291bGQgYWxsb3cgcmUtcmFpc2luZyBldmVuIGlmIHRoZSAybmQg
TVNJDQphcnJpdmVkIGJlZm9yZSB0aGUgZHJpdmVyIGhhbmRsZXIgcmFuLCB3aGljaCBpcyBub3Qg
bmVjZXNzYXJ5Lg0KDQpJIGRvIG5vdCBzZWUgYSByYWNlIGluIHRoaXMgZGVzaWduIGFuZCBpdCBh
cHBlYXJzIGNvcnJlY3QgdG8gbWUuICBCdXQsDQpJIGFsc28gZG8gbm90IHRoaW5rIHRoZXJlIGlz
IGFueSBpbW1lZGlhdGUgaW1wcm92ZW1lbnQgZHVlIHRvIGV4dHJhDQpzdGVwcyBvZiBtYXNraW5n
IGFuZCB1bm1hc2tpbmcgdGhlIE1TSS4NCg0KVGhlIHJlYXNvbiBpcyB0aGF0IHRoZSBHSUMgaW50
ZXJydXB0IGFib3ZlIHRoZSBkd2MgaXMgbm9uLXJlZW50cmFudC4gDQpJdCByZW1haW5zIG1hc2tl
ZCAoYWthIGFjdGl2ZVsxXSkgZHVyaW5nIHRoaXMgZW50aXJlIHByb2Nlc3MgKDEgdG8gMTApLg0K
IFRoaXMgbWVhbnMgZXZlcnkgTVNJIGlzIGVmZmVjdGl2ZWx5IGFscmVhZHkgbWFza2VkLiAgU28g
bWFza2luZyB0aGUNCmFjdGl2ZSBNU0kocykgYSAybmQgdGltZSBnYWlucyBub3RoaW5nIGJlc2lk
ZXMgcHJldmVudGluZyBzb21lIGV4dHJhDQplZGdlcyBmb3IgYSBtYXNrZWQgaW50ZXJydXB0IGdv
aW5nIHRvIHRoZSBBUk0gR0lDLg0KDQpJbiB0aGVvcnksIGlmIHRoZSBHSUMgaW50ZXJydXB0IGhh
bmRsZXIgd2FzIHJlZW50cmFudCwgdGhlbiBvbiByZWNlaXB0DQpvZiBhIG5ldyBNU0kgd2UgY291
bGQgcmUtZW50ZXIgdGhlIGR3YyBoYW5kbGVyIG9uIGEgZGlmZmVyZW50IENQVSBhbmQNCnJ1biB0
aGUgbmV3IE1TSSAoYSBkaWZmZXJlbnQgTVNJISkgYXQgdGhlIHNhbWUgdGltZSBhcyB0aGUgb3Jp
Z2luYWwgTVNJDQpoYW5kbGVyIGlzIHN0aWxsIHJ1bm5pbmcuDQoNClRoZXJlIGRpZmZlcmVuY2Ug
aGVyZSBpcyB0aGF0IGJ5IHVubWFza2luZyBpbiB0aGUgaW50ZXJydXB0IGluIHRoZSBHSUMNCmJl
Zm9yZSB0aGUgZHdjIGhhbmRsZXIgaXMgZmluaXNoZWQsIG1hc2tpbmcgYW4gaW5kaXZpZHVhbCBN
U0kgaW4gdGhlDQpkd2MgaXMgbm8gbG9uZ2VyIGEgMm5kIHJlZHVuZGFudCBtYXNraW5nLg0KDQoN
ClsxXSBXaGVuIEkgc2F5IG1hc2tlZCBpbiBHSUMsIEkgbWVhbiB0aGUgaW50ZXJydXB0IGlzIGlu
IHRoZSAiYWN0aXZlIg0Kb3IgImFjdGl2ZSBhbmQgcGVuZGluZyIgc3RhdGVzLiAgSW4gdGhlc2Ug
c3RhdGVzIHRoZSBpbnRlcnJ1cHQgd2lsbCBub3QNCmJlIHJhaXNlZCB0byB0aGUgQ1BVIGFuZCBj
YW4gYmUgY29uc2lkZXJlZCBtYXNrZWQuDQo=
