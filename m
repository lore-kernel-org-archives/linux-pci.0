Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1BCC43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6C32086B
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="oo17epBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6C32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbeK0Crz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:47:55 -0500
Received: from mail-eopbgr710109.outbound.protection.outlook.com ([40.107.71.109]:10688
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbeK0Crz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Nov 2018 21:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhL9GjjAhmTjsks8rvcvZKh98HbjDMIGz4oVw0vquyc=;
 b=oo17epBftfyyqY7qrkIugplQRQbDcKz1eKEWSns78DvkMZ9LjtB4Lw/jsbC8zjoX9UeaYZYakizJNqy6lUgTf8crpjsOPT1TTVY5/cswPPyBdamUTYxr9Exg/LAPuyKTZnH0CtWVoZLpWvQiPv7iPsrGTNMg5XZyCe/DOoVHJis=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3636.namprd06.prod.outlook.com (52.132.101.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 15:52:42 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 15:52:42 +0000
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
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICADLahgIAGiV+A
Date:   Mon, 26 Nov 2018 15:52:42 +0000
Message-ID: <1543247559.18519.13.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
         <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
In-Reply-To: <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3636;6:C8AJXh3tjXSnPhgtdW1YxSAG7eYzRCVRRinqQrSOabvuPSDvQ/ODpXYhqZup/HSfI6fPvof3fDIxzduQLUqjkzQ0+hw2ApqW9RLWIm0F/rGzpPExAoeBMFZreE+rtonZSIkXuiZ20XDQJsVUyZYs92dbx1Q1JD5X9yyywfSQ363whDKNcG7qBmChAxe7ZqGfE0P9X2BpESZ7lux1sBya2hVqg09MxUtET5lNzJYUSo8OzL1duPFvhzrzcrdMVAWeeBLBm/rOrN3VHNz+kTVvttVbJz8yoIMw0kQ3P3j6tcjZM5QjjzG5rygw6iJdB1LiQwcYLAeb57PaCKr+s+yYQ+f/kH30qbb20+YGAKfaP576jQ/bOtCk1/O+X3hqoEOOwwJILPalpZvceMhb9xttcSwy63cKm6OswPEI4biZZ6xWsrRy91sgbZZfg5XB59mlxLXDm4u4CYwc9DObuzeogQ==;5:QXv/+sR1Hi1B9hb/JcmsR2IfC6zc3pF65UL0q7layw4qqBNGXP2JqKq+ORXTYLy4hs03IqOH5ZW3rN9oCIx1gZXxOEz/E2dwkVxK5FjYQZqWjN3BGT1PQhsDvfrxl4P58y3Qqs7uwANv5UJHMFGoolxC0Si6Z8fvEiMNztBcLlA=;7:5LsdVJ774icKyx7NXpbAKx7lFyh4tVlPJnQQ5THvbayQ4slUXSBdRs0+o82jh+SdQf7TfAm5anKXZ56Rnv0w9FvTodC4hmXg/az4OzSDFUpnX279yC3ae4H7HhnTxE4IYYnwr4vVKHPqXxg0gEcaPQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f67fb021-6fe0-490c-28f6-08d653b7337f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3636;
x-ms-traffictypediagnostic: CY4PR0601MB3636:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-microsoft-antispam-prvs: <CY4PR0601MB363637022140781C6F75DA88D3D70@CY4PR0601MB3636.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3636;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3636;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(396003)(366004)(376002)(346002)(199004)(189003)(97736004)(76176011)(53936002)(6246003)(316002)(6512007)(103116003)(66066001)(446003)(2616005)(11346002)(476003)(486006)(25786009)(8676002)(4001150100001)(478600001)(6486002)(4326008)(39060400002)(36756003)(68736007)(71190400001)(71200400001)(2501003)(229853002)(54906003)(6506007)(26005)(102836004)(8936002)(14454004)(86362001)(6116002)(2906002)(5660300001)(110136005)(3846002)(99286004)(105586002)(256004)(7736002)(106356001)(305945005)(81166006)(6436002)(93886005)(81156014)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3636;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vcdOPm9DkKP2S9/iNuS6VLDmDjuaFgi3ng0aZL2SopjdbUiskP8wJyf8sqdrp56U9D8bfpl94yjk8w7NP/gBk8hTRFnRNoZc0Iqd77fc0lOSGoqkn9qw5jT6N+/Enej+YNwjiVQUmNcRc609693c7eRdfX2UuQWhDeYWxKWi2iFgnqX0cA0LzGyJAJfO7e4RuUlrFpV8BZRg8QGnfAKJP9imqDHwe1EHUJKPVcR+hIhzosowdZsTk3Cfe4S5cYwUYesRva58ytU2VwXFHU5NrW07ha70peuBomjONXNAXlce5NENpJ/WCdlapOEu4W9GJyTatmqAn/0dDFOaA11hHd4/cZC0p8/YrTWo3Y2dHoY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <753C0964C5D88D4EAE8549AEA08FFCB1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67fb021-6fe0-490c-28f6-08d653b7337f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 15:52:42.5694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3636
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTIyIGF0IDEyOjAzICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3Rl
Og0KPiANCj4gPiBJIGp1c3QgcmVhbGlzZWQgKGF0IDFhbSEpIHRoYXQgdGhlIGZpcnN0IHBhdGNo
IGlzIGF3ZnVsbHkgYnVnZ3k6DQo+ID4gLSBFTkFCTEUgYW5kIE1BU0sgaGF2ZSBvcHBvc2l0ZSBw
b2xhcml0aWVzDQo+ID4gLSBUaGVyZSBpcyBub3RoaW5nIGluaXRpYWxpc2luZyB0aGUgRU5BQkxF
IGFuZCBNQVNLIHJlZ2lzdGVycw0KPiA+IA0KPiA+IEkndmUgc3Rhc2hlZCB0aGUgZm9sbG93aW5n
IGZpeC11cCBvbiB0b3Agb2YgdGhlIGV4aXN0aW5nIHNlcmllczoNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0K
PiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0K
PiA+IGluZGV4IGYwNmU2N2M2MDU5My4uMGZhOWU4ZmRjZTY2IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4g
QEAgLTE2Niw3ICsxNjYsNyBAQCBzdGF0aWMgdm9pZCBkd19wY2lfYm90dG9tX21hc2soc3RydWN0
IGlycV9kYXRhDQo+ID4gKmRhdGEpDQo+IA0KPiAoc25pcCkNCj4gDQo+IEkgdXNlZCB5b3VyIHBh
dGNoIGFuZCBtYWRlIGl0IG1vcmUgcGVyY2VwdGlibGUgaW4gbXkgb3BpbmlvbiwgKGJhc2ljYWxs
eSBJDQo+IHRyYW5zZm9ybWVkIHRoZSB2YXJpYWJsZSBpcnFfbWFzayAocHJldmlvdXMgaXJxX3N0
YXR1cykgaW50byBhIG1pcnJvciBvZiBNQVNLDQo+IHJlZ2lzdGVycywgd2hpY2ggcmVtb3ZlZCB0
aGUgbmVlZCBmb3IgdGhlICpOT1QqIG9wZXJhdGlvbiBhbmQgZm9yY2VkIHRoZSBtYXNrDQo+IG9w
ZXJhdGlvbiBzd2FwIGluIHRoZSBjYWxsYmFja3MpDQoNClRoaXMgd291bGQgYmUgdGhlIHBhdGNo
IHRoYXQgZW5hYmxlcyBhbGwgTVNJIGludGVycnVwdHMgb24gZHJpdmVyDQppbml0aWFsaXphdGlv
bj8NCg0KSSBkb24ndCB0aGluayB0aGF0J3MgYSBnb29kIGlkZWEuICBJIHdhcyB1bmRlciB0aGUg
aW1wcmVzc2lvbiBNYXJjDQp0aG91Z2h0IHRoYXQgYXMgd2VsbC4gIEl0IHdvdWxkIGJlIGJldHRl
ciB0byBlbmFibGUgdGhlbSB3aGVuIHRoZXkgYXJlDQplbmFibGVkLCB2aWEgZW5hYmxlIGFuZCBk
aXNhYmxlIG1ldGhvZHMuDQoNCkkndmUgbG9va2VkIGludG8gdGhlIGludGVycGxheSB3aXRoIGVu
YWJsZSBhbmQgbWFzayBzb21lIG1vcmUuIA0KUHJldmlvdXMgdmVyc2lvbnMgb2YgdGhlIGRyaXZl
ciB1c2VkIHRoZSBtYXNrIHJlZ2lzdGVycyB0byBib3RoDQplbi9kaXNhYmxlIGFuZCB1bi9tYXNr
IE1TSXMuICBCb3RoIGVuYWJsZSBhbmQgbWFzayBtZXRob2RzIHdlcmUNCnByb3ZpZGVkLCBidXQg
dGhleSB3ZXJlIHRoZSBzYW1lIG1hc2sgZnVuY3Rpb24gaW4gdGhlIGRyaXZlci4NCg0KRnVuY3Rp
b25zIGxpa2UgaXJxX3BlcmNwdV9lbmFibGUoKSB3aWxsIGNhbGwgdGhlIGlycV9lbmFibGUgbWV0
aG9kLCBidXQNCmZhbGwtYmFjayB0byBpcnFfdW5tYXNrIGlmIHRoZSBjaGlwIGRvZXMgbm90IHBy
b3ZpZGUgaXJxX2VuYWJsZS4gIFNvIGENCmRyaXZlciBjYW4gYmUgc2xvcHB5IGFib3V0IHRoZSBk
aXN0aW5jdGlvbiBiZXR3ZWVuIG1hc2tpbmcgYW5kIGRpc2FibGUNCmFuIGlycSBhbmQgaXQgaXNu
J3QgbmVjZXNzYXJpbHkgYXBwYXJlbnQuDQoNCldoaWNoIGlzIGhvdyBrZXlzdG9uZSBoYXMga3Nf
cGNpZV9tc2lfc2V0X2lycSgpIHRoYXQgaXMgcGFydCBvZiB0aGUNCnVubWFzayBtZXRob2QgKG5v
dyksIGJ1dCBjZXJ0YWlubHkgbG9va3MgbGlrZSBpdCBzaG91bGQgYmUgcGFydCBvZg0KZW5hYmxl
Lg0KDQpJIHRoaW5rIHRoZSByaWdodCB3YXkgdG8gZml4IHRoaXMgZHJpdmVyIHdvdWxkIGJlIHRv
Og0KQWNrIHRoZSBpcnEgaW4gdGhlIGlycV9hY2sgbWV0aG9kLg0KV3JpdGUgZW5hYmxlIGFuZCBk
aXNhYmxlIG1ldGhvZHMgdGhhdCB1c2UgdGhlIGVuYWJsZSByZWdpc3Rlcg0KV3JpdGUgbWFzay91
bm1hc2sgbWV0aG9kcyB0aGF0IHVzZSB0aGUgbWFzayByZWdpc3Rlcg0KUmVuYW1lIHRoZSBtc2lf
KHNldHxjbHIpX2lycSBtZXRob2RzIHRvIG1zaV8oZW58ZGlzKWFibGVfaXJxDQpDYWxsIG9wcy0+
bXNpX2VuYWJsZV9pcnEoKSBmcm9tIGR3X3BjaV9ib3R0b21fZW5hYmxlKCkNCmlycV9zdGF0dXMg
c2hvdWxkIGdldCByZW5hbWVkIHRvIGlycV9tYXNrLCBzaW5jZSBpdCdzIGp1c3QgYSBkcml2ZXIg
DQpjYWNoZSBvZiB0aGUgbWFzayByZWdpc3Rlci4gIENvdWxkIGFsc28gY2FjaGUgdGhlIGVuYWJs
ZSByZWdpc3RlciwgYnV0DQp0aGF0IHJlZyBpcyB1c2VkIGxlc3Mgb2Z0ZW4uICBDb3VsZCBhbHNv
IHVzZSByZWdjYWNoZSB0byBjYWNoZSB0aGVzZQ0KcmVnaXN0ZXJzLg0K
