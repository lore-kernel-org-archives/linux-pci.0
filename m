Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0619DC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D294223DD
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="OEevYhAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D294223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKOEc2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:32:28 -0500
Received: from mail-eopbgr710108.outbound.protection.outlook.com ([40.107.71.108]:13376
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727969AbeKOEc1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 23:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMMxNkP0LRnVMaBUkfYKtTDHvWs5bAWAUVOjp5o6XS0=;
 b=OEevYhAOel83Tim6yArGKOunIBpBGQStVEvU2wLDhFdfTGgY8XiV3Bb3XVqFIrIy5uHQ46xZSBzVWpPwzTLwFetVP9GMldKxo+NEoM2zhB4A/bhILZVYfMw4zhCvl/j/FRmDi5yOcJTzQ0KpRpaYmXy+/BwZ7VXIrqZoQ0rcX7I=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3674.namprd06.prod.outlook.com (10.167.236.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 14 Nov 2018 18:28:05 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 18:28:05 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@google.com" <helgaas@google.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVPmEcA
Date:   Wed, 14 Nov 2018 18:28:05 +0000
Message-ID: <1542220084.30311.453.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
In-Reply-To: <20181113225734.8026-1-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3674;6:w/aGgkW4foJpKKUQL9Rhx3WePar37TCrBUhzVL3VZeVzKBLVrfRrRhUnzb1cAOnIxCCVxb7fvfapTnZBolENFAdy0OVjOHzcrEcnd/Uc5Mo5QZRjEeoUmDfitO4t2CpAH1Bsr3uDIhq5X2Y3SOy5+vabIw4BD8fbanXILAdrcgJjPkHjiB22nxpvWrLIPvGXR2u4XjDnhYdsCvA7ldshQj/XtFQUxfgebqU5txzfNXrtb0GKX2kwta0EQAEw5AnQiPhT0SNeBWWt0cajozI9X4OvenA2MptuLXEfBocl3WPNNg0kRzj0Pyz9hpUxbxiv/alhjx/drYmNwR6OoQ+aLyhYCoNnQTjG2nYd5O7XMvo/pju4or36TPPU4BDlM85+jJq1EkoddksEAM55AUW2l9V0UCeZWwZwMiItAZqu442+F3qJ8bobc4dSkKIdmRtfRJB0vmz3h5btnMhcK9LA0A==;5:5FU8iQ56DtoB3pG2I89higrqSP4lSypxWtQJjkKMjIu667MpvGaoljBZKrTkSYHAghOZmP7YGrjkowIW/JdsV2ORyeVMjeYs0RC9e9ZR+tsThb3sfUC8/743rLqsVmxWGXw5fGUVc87bLhTjbAOx3qszM15fyRBRqIeKeOUd1iY=;7:m2HyLb0Xuh17fpfpxgF9YMicBqNJbNg664G1IhzL7AVjK1lXptUvmZVDPAjhIFoG/+zcibHwQK2kHQcFLqwf0aTIjEmEJVhGqjrQFh0X9cIvWykCUxTnM/BYW1ctimhAM+v0KPm0QSR1JVq9ZBhEpQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1b1ed3df-2e14-4bb5-a5d0-08d64a5eeb42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3674;
x-ms-traffictypediagnostic: MWHPR0601MB3674:
x-microsoft-antispam-prvs: <MWHPR0601MB36741213FD8717A0B9618809D3C30@MWHPR0601MB3674.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3674;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3674;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(39060400002)(99286004)(26005)(4001150100001)(8676002)(3846002)(6506007)(6246003)(8936002)(81166006)(36756003)(81156014)(5660300001)(4326008)(68736007)(71190400001)(2900100001)(256004)(2616005)(11346002)(476003)(103116003)(446003)(76176011)(486006)(14444005)(186003)(71200400001)(6116002)(102836004)(2906002)(105586002)(97736004)(106356001)(2201001)(2501003)(478600001)(6436002)(54906003)(110136005)(316002)(6512007)(66066001)(53936002)(7736002)(229853002)(6486002)(25786009)(14454004)(305945005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3674;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HaYPrT+lhgOfvfuitkzi8/gRfS1HOfpvOxL/erqlCbAAjhtacqmblHiDlsNuTWC/p/BZzd6cicCk48hXigFY64/voR7feR9P4CkaI8LCMUJEor1pVhT6Wvrz/lOnV8skaLYh9WhTJKpyqQtbzEN3I8scX7C+gOAhKvdhLvNUb0/U4bhLqG2mnPzjC7xJe3vFb4jCOlWv3FzI03zEFdxIcRRnfvpm/47cLox5EHnIR5x2xbh+s+rTpqy0T7KGWGKTLWMaf0XLqtsMeRl71V6XPGvcZ4UqOSas0PlxFOGNUFUwswnM+f/OlIWN+zWeOWXdSmujKEKPt2uR05WENFVySR9AHD5ovZlyc9dMCcFRDdA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EAD98A1A7ABC84698C9F2889F327C02@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1ed3df-2e14-4bb5-a5d0-08d64a5eeb42
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 18:28:05.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3674
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTEzIGF0IDIyOjU3ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEl0IHJlY2VudGx5IGNhbWUgdG8gbGlnaHQgdGhhdCB0aGUgRGVzaWdud2FyZSBQQ0llIGRyaXZl
ciBpcyByYXRoZXINCj4gYnJva2VuIGluIHRoZSB3YXkgaXQgaGFuZGxlcyBNU0lbMV06DQo+IA0K
PiAtIEl0IG1hc2tzIGludGVycnVwdCBieSBkaXNhYmxpbmcgdGhlbSwgbWVhbmluZyB0aGF0IE1T
SXMgZ2VuZXJhdGVkDQo+ICAgZHVyaW5nIHRoZSBtYXNrZWQgd2luZG93IGFyZSBzaW1wbHkgbG9z
dC4gT29wcy4NCj4gDQo+IC0gQWNraW5nIG9mIHRoZSBjdXJyZW50bHkgcGVuZGluZyBNU0kgaXMg
ZG9uZSBvdXRzaWRlIG9mIHRoZQ0KPiBpbnRlcnJ1cHQNCj4gICBmbG93LCBnZXR0aW5nIG1vdmVk
IGFyb3VuZCByYW5kb21seSBhbmQgdWx0aW1hdGVseSBicmVha2luZyB0aGUNCj4gICBkcml2ZXIu
IE5vdCBncmVhdC4NCj4gDQo+IFRoaXMgc2VyaWVzIGF0dGVtcHRzIHRvIGFkZHJlc3MgdGhpcyBi
eSBzd2l0Y2hpbmcgdG8gdXNpbmcgdGhlIE1BU0sNCj4gcmVnaXN0ZXIgZm9yIG1hc2tpbmcgaW50
ZXJydXB0cyAoISksIGFuZCBtb3ZlIHRoZSBhY2sgaW50byB0aGUNCj4gYXBwcm9wcmlhdGUgY2Fs
bGJhY2ssIGdpdmluZyBpdCBhIGZpeGVkIHBsYWNlIGluIHRoZSBNU0kgaGFuZGxpbmcNCj4gZmxv
dy4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIGlzIG9ubHkgY29tcGlsZS10ZXN0ZWQgb24gbXkgYXJt
NjQgbGFwdG9wLCBhcyBJJ20NCj4gdHJhdmVsbGluZyBhbmQgZG8gbm90IGhhdmUgdGhlIHJlcXVp
cmVkIEhXIHRvIHRlc3QgaXQgYW55d2F5LiBJJ2QNCj4gd2VsY29tZSBib3RoIHJldmlldyBhbmQg
dGVzdGluZyBieSB0aGUgaW50ZXJlc3RlZCBwYXJ0aWVzIChkd2MNCj4gbWFpbnRhaW5lciBhbmQg
dXNlcnMgYWZmZWN0ZWQgYnkgZXhpc3RpbmcgYnVncykuDQo+IA0KDQpJJ3ZlIHN0YXJ0ZWQgdG8g
dGVzdCB0aGlzIHNlcmllcyBhZnRlciBwb3J0aW5nIGFsbCB0aGUgcGF0Y2hlcyBuZWVkZWQNCnRv
IG1ha2UgSU1YN2Qgd29yayBmcm9tIDQuMTYuOCB0byA0LjIwLjAtcmMyLg0KDQpUb29rIGEgbGl0
dGxlIHdoaWxlIHRvIGZpZ3VyZSBvdXQgdGhhdCB0aGUgcGNpZXBvcnQgZHJpdmVyIGhhcyBhIG5l
dw0KY29uZmlnIGVudHJ5IHRvIGVuYWJsZSwgb3Igb25lIGdldHMgbm8gaW50ZXJydXB0cy4gIEkn
bSBub3Qgc3VyZSBpZg0KdGhpcyBpcyBlbnRpcmVseSBjb3JyZWN0IGJlaGF2aW9yLg0KDQpUaGUg
bmV3IGRvbWFpbiBzdHVmZiBkb2VzIG5vdCBhcHBlYXIgdG8gaW50ZWdyYXRlIGludG8gdGhlIGV4
aXN0aW5nIGlycQ0KZnJhbWV3b3JrIHBlcmZlY3RseS4gIE15IGludGVycnVwdCBoYXMgY2hhbmdl
ZCBmcm9tIE1TSSAjMSB0byBNU0kNCiM1MjQyODguICBOb3QgdGhlIG1vc3QgdXNlciBmcmllbmRs
eSBudW1iZXIuDQoNCjI5MjogICAgICAgICAgMCAgICAgICAgICAwICAgUENJLU1TSSAgIDAgRWRn
ZSAgICAgIFBDSWUgUE1FLCBhZXJkcnYNCjI5MzogICAgICAgICAgMSAgICAgICAgICAwICAgUENJ
LU1TSSA1MjQyODggRWRnZSAgICAgIGltcGluai1yZmlkLW1vZGVtDQoNClByZXZpb3VzbHkgdGhl
IGR3YyBjb250cm9sbGVyIHdvdWxkIHNob3cgdXAgYXMgdGhlIG93bmVyIG9mIEdQQ3YyIElSUQ0K
MTIyLiAgSXQgZG9lc24ndCBhbnkgbW9yZS4gIFNlZW1zIGxpa2UgdGhlIGtlcm5lbCBpbmZvIGZv
ciBpdCBpcyB3cm9uZy4NCg0KL3N5cy9rZXJuZWwvaXJxLzY1L2FjdGlvbnM6KG51bGwpDQovc3lz
L2tlcm5lbC9pcnEvNjUvY2hpcF9uYW1lOkdQQ3YyDQovc3lzL2tlcm5lbC9pcnEvNjUvaHdpcnE6
MTIyDQovc3lzL2tlcm5lbC9pcnEvNjUvcGVyX2NwdV9jb3VudDowLDANCi9zeXMva2VybmVsL2ly
cS82NS90eXBlOmVkZ2UNCg0KU2hvdWxkIGJlIGxldmVsIGFuZCB0aGUgY291bnQgc2hvdWxkIGJl
IDEsMC4gIFRoZSBkZWJ1Z2ZzIGludGVyZmFjZSBpcw0KbW9yZSBhY2N1cmF0ZToNCg0KIyBjYXQg
L3N5cy9rZXJuZWwvZGVidWcvaXJxL2lycXMvNjUNCmhhbmRsZXI6ICBkd19jaGFpbmVkX21zaV9p
c3INCmRldmljZTogICAobnVsbCkNCnN0YXR1czogICAweDAwMDEwYzAwDQogICAgICAgICAgICBf
SVJRX05PUFJPQkUNCiAgICAgICAgICAgIF9JUlFfTk9SRVFVRVNUDQogICAgICAgICAgICBfSVJR
X05PVEhSRUFEDQpkc3RhdGU6ICAgMHgwMzQwMDIwNA0KICAgICAgICAgICAgSVJRX1RZUEVfTEVW
RUxfSElHSA0KICAgICAgICAgICAgSVJRRF9BQ1RJVkFURUQNCiAgICAgICAgICAgIElSUURfSVJR
X1NUQVJURUQNCiAgICAgICAgICAgIElSUURfU0lOR0xFX1RBUkdFVA0KDQpTdGlsbCBkb2Vzbid0
IGtub3cgd2hhdCBkZXZpY2UgaXQncyBmb3IuDQoNCk5vdyBJIGNhbiBmaW5hbGx5IHRlc3QgaXQh
DQoNCkNvbmZpcm1lZCBpbnRlcnJ1cHQgcmFjZSBpcyBzdGlsbCB0aGVyZSBpbiBzdG9jayBrZXJu
ZWwuDQoNCkNvbmZpcm1lZCBhZnRlciBteSBwYXRjaCBJIGRpZG4ndCBzZWUgdGhlIHJhY2UuICBE
aWRuJ3QgY2hlY2sgd2h5IHRoZQ0KYnJva2VuIGVuYWJsZS9kaXNhYmxlIGFzIG1hc2sgZGlkbid0
IGFwcGVhciBjYXVzZSBhIG5ldyByYWNlLCBidXQNCnNvbWV0aGluZyBtdXN0IGJlIHdyb25nIHNv
bWV3aGVyZS4NCg0KVHJpZWQgeW91ciAxc3QgcGF0Y2guICBBcyBJIG1lbnRpb25lZCBiZWZvcmUg
aW4gYSByZXBseSB0byBHdXN0YXZvLA0KanVzdCBjaGFuZ2luZyB0aGUgZW5hYmxlIHRvIG1hc2sg
cmVzdWx0cyBpbiB0aGUgTVNJIG5ldmVyIGdldHRpbmcNCmVuYWJsZWQgaW4gdGhlIGZpcnN0IHBs
YWNlLiAgTm90aGluZyBlbHNlIHdyaXRlcyB0byB0aGUgZW5hYmxlDQpyZWdpc3Rlci4uLg0KDQpB
cyBhIHdvcmthcm91bmQsIEkgYWRkZWQgYW4gaXJxX2VuYWJsZSBtZXRob2QgdG8gZHdfcGNpZV9t
c2lfaXJxX2NoaXANCnRoYXQganVzdCBjaGFpbnMgdG8gdGhlIHBhcmVudCwgYW5kIHRoZW4gYSBo
YWNreSBpcnFfZW5hYmxlIGluDQpkd19wY2lfbXNpX2JvdHRvbV9pcnFfY2hpcCB0aGF0IG1hbmlw
dWxhdGVzIHRoZSBlbmFibGUgcmVnaXN0ZXIuDQoNCk5vdyBpdCB3b3JrcyBhZ2Fpbi4gIFJhY2Ug
c3RpbGwgcHJlc2VudC4gIEkgZG9uJ3Qgc2VlIHRoZQ0KZHdfcGNpX21zaV9ib3R0b21fKHVuKW1h
c2sgbWV0aG9kcyBldmVyIGdldCBjYWxsZWQuICBJIHNlZW0gdG8gcmVjYWxsDQp0aGF0IHRoZXkg
YXJlIGNhbGxlZCBhcyBhIHN1YnN0aXR1dGUgaWYgZW5hYmxlL2Rpc2FibGUgYXJlIG5vdCBwcmVz
ZW50LA0KYnV0IGhhdmVuJ3QgY29uZmlybWVkIHRoYXQsIHdoaWNoIHdvdWxkIGV4cGxhaW4gd2h5
IHRoZXkgYXJlIG5vdCBjYWxsZWQNCmFmdGVyIEkgYWRkZWQgZW5hYmxlLg0KDQpOZXh0IHRyaWVk
IHlvdXIgbmV4dCB0d28gcGF0Y2hlcy4gIE5vIGxvbmdlciBzZWUgbG9zdCBpbnRlcnJ1cHRzLCBh
cw0KdGhlIHN0YXR1cyBpcyBjbGVhcmVkIGJlZm9yZSB0aGUgaGFuZGxlciBpcyBjYWxsZWQuDQoN
CkZyb20gd2hhdCBJIHNlZSB0aGUgY2xlYXIgb2YgdGhlIHN0YXR1cyBiaXQgaXMgZWZmZWN0aXZl
bHkgYXQgdGhlIHNhbWUNCnBvaW50IGluIHRoZSBpcnEgcGF0aCBhcyB0aGUgd2F5IEkgY2xlYXJl
ZCBpdCBpbiBteSBwYXRjaC4gIFRoZXJlJ3MNCmp1c3QgYSBsb25nZXIgY2FsbCBjaGFpbiB0byBn
ZXQgdG8gaXQgaW4gdGhlIGFjayBtZXRob2QuICBOb3QgdGhhdCBpdCdzDQpub3QgYSBiZXR0ZXIg
cGxhY2UgZm9yIGl0ICh3aGljaCBpc24ndCB0aGVyZSBpbiA0LjE2KSwgYnV0IEkgZG9uJ3QNCnRo
aW5rIGl0IGNoYW5nZXMgYW55dGhpbmcuICBJcyB0aGVyZSBzb21lIHJlYXNvbiBkd19wY2lfYm90
dG9tX2Fjaw0Kd291bGQgbm90IGJlIGNhbGxlZD8NCg0KU2luY2UgSSBkb24ndCBzZWUgdGhlIHVu
KG1hc2spIG1ldGhvZHMgZXZlciBnZXQgY2FsbGVkLCBJJ20gbm90IHN1cmUgaWYNCnRoZXkgYXJl
IGNvcnJlY3Qgb3Igbm90LiAgSSBhbHNvIGhhZCBzb21lIHVuYW5zd2VyZWQgZGV0YWlscyBvZg0K
YmVoYXZpb3Igb24gdW5tYXNrLiAgSSBjYW4gc2VlIHBvc3NpYmxlIGZsYXdzLCBkZXBlbmRpbmcg
b24gaG93IHRoaXMNCndvcmtzLg==
