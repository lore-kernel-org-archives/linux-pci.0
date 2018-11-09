Return-Path: <SRS0=f7a+=NU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6734AC43441
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 18:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1A22086C
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 18:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="CbYb8HSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1A22086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeKJEe6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:34:58 -0500
Received: from mail-eopbgr700108.outbound.protection.outlook.com ([40.107.70.108]:27552
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727961AbeKJEe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 23:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uyB/v2Sv7XyZjf1926dBFpjvoRI/XC0RrIRP2OWT2E=;
 b=CbYb8HSR0e6PDZ7wauitNW1xVsD2M+K2FnmswOKj0Qb6w3SjnIXIK+uyfQ7XbZtjLG4TGy6Oss6R79PN5O0qXFiCI2X0Zt3F+NzV54mjdY6BioS2C6Aax9yPsl4D81SdXafIdY0J/MuQMyy0jiEKS22ekQIeqyS5jgkJ0lr42Cw=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3705.namprd06.prod.outlook.com (10.167.236.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 18:53:03 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 18:53:03 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAD2CgIABgdKAgAAa7ICAAOK+gIAAp9qAgAEH8QCAAHqEAA==
Date:   Fri, 9 Nov 2018 18:53:02 +0000
Message-ID: <1541789582.30311.382.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <1541533217.30311.263.camel@impinj.com>
         <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
         <1541621853.30311.294.camel@impinj.com>
         <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
         <1541706591.30311.308.camel@impinj.com>
         <b4dfa6e0-c569-c669-d3f1-b1016eecefa8@arm.com>
In-Reply-To: <b4dfa6e0-c569-c669-d3f1-b1016eecefa8@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3705;6:ng+x8HrinNz9ie9JPY/6Q+CzrSxg1qhKKKxMItqP1uTUiVij3T/uoUfkn/jZ0+QqW43N/2ArsIYhBLv8nuTiYSJYFPHZZ4JUG+nqQVfIDouDH34eRiwiawmDaETlhHsB3uE2wKJLGlNxCX9oCKR3nGaoGtGj9K6T5b7JrsCKRL8DdagCE8w0hRMre3zgs6gun+3v+j/rUWvNpCvxVUuO2CLghLZTzpZNyGT16noBwI5ZYC4M0wQh5g1czYH9YBP3PeeiDYez6nNa+KKLxoUf8wxV+bbAnwpuPLdDNRn2aXUgFA86Ns8mX+mVH4xMKGhFK0a8EnO0bkusno5SJo13FFOjopT26qd2ALq5meYh09/3HTKRuOj1Ii5/gp+NzZEfJv2lyMHr53fzVmChMhpwCKAUbXcWTOPDxD3GPyM81t+Q7Zj+8OxWJDpv+5JyZ7gShu9Ipm4Y6Z/cSOPAoUnUsQ==;5:tTeDK8s1Ub1rKOcgGDV0hrK4M2IeUgVsdRqXM0iNOHh0UZhpB3BvBo69qe0tKDR0T25iQ19J10RIGVtAb6IsxZuOHC5GLtz/imCaM5wTpV6PNJAOrndQ/sv4mf8Jmr4FnYMFhXASUmNBtxR3uhdNLhyDjc8ZOr5ewXZOntON39o=;7:BEEbLPYyIjBKU5GXWI7z4CtcJI8E/99j0YvfYAoS7FYPBHVg8AzclJmNeFYTyZ+6WoqwxQi634jaTmqKQFQOqfhHlgrIE4aHrw2wGXej5lc+Qj7lImp6DI6Ldwj3IM9H0/FGcB/6Wd7VnSVWzb/EEw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b9b7768b-65ce-49f8-f889-08d6467493dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3705;
x-ms-traffictypediagnostic: MWHPR0601MB3705:
x-microsoft-antispam-prvs: <MWHPR0601MB37050355F1749357804B768DD3C60@MWHPR0601MB3705.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3705;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3705;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39850400004)(376002)(366004)(396003)(189003)(199004)(99286004)(7736002)(14454004)(76176011)(54906003)(8676002)(103116003)(110136005)(186003)(6506007)(39060400002)(4326008)(53546011)(6486002)(6246003)(26005)(81166006)(93886005)(5660300001)(3846002)(81156014)(316002)(6306002)(66066001)(102836004)(2900100001)(68736007)(2906002)(305945005)(6116002)(345774005)(7416002)(8936002)(53936002)(6436002)(6512007)(229853002)(106356001)(105586002)(36756003)(256004)(478600001)(2616005)(11346002)(966005)(476003)(25786009)(86362001)(2201001)(71200400001)(71190400001)(446003)(97736004)(486006)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3705;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 19EFXL8P536qinFzMcfjddWa1fMkaouwwJ18W2/Kyj0v70FxONyt+Ph0PCzXQX1RC2Grpl6lKY7nK/YD/gx6fxQRVwXNBCjHzWeKrsYsmzIVGq8iGbqUo8tm/dRPAUNTVoDLfuTv7bSon9c7QcPPgGAiNpPyPJqJawy34FIxSIUnEiH48CILUx+EbavNWkJ4j/tIX5HRu489wEbXzbQ16hNFve0zC2jINqbYLtR2KSAESn7Pa3KbhZFC485PJQvh9K9zJpc9t+z4M5IzPrLFEiYUvZJUnVCmpwya4PLs5czRNTSu2nujdPvRNX8gafNKmzbQbBulPiJ2WXgoRTq7hwBLBm3CO0o+kVZwbVKXJyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BB8FA45ED3AE8419E4E78EC019D935E@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b7768b-65ce-49f8-f889-08d6467493dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 18:53:02.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3705
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE4LTExLTA5IGF0IDExOjM0ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDA4LzExLzE4IDE5OjQ5LCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDE4
LTExLTA4IGF0IDA5OjQ5ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gPiANCj4gPiBU
aGVuIHRoYXQgbGFzdGVkIGZvdXIgeWVhcnMgdW50aWwgaXQgd2FzIGNoYW5nZWQgQXVnIDIwMTcg
aW4gaHR0cHM6Ly9wYQ0KPiA+IHRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85ODkzMzAzLw0KPiA+
IA0KPiA+IFRoYXQgbGFzdGVkIGp1c3Qgc2l4IG1vbnRocyB1bnRpbCBzb21lb25lIHRyaWVkIHRv
IHJldmVydCBpdCwgaHR0cHM6Ly9wDQo+ID4gYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85ODkz
MzAzLw0KDQpTaG91bGQgYmUgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDIw
ODg3OS8NCg0KPiA+IA0KPiA+IFNlZW1zIHByZXR0eSBjbGVhciB0aGUgd2F5IGl0IGlzIG5vdyBp
cyBtdWNoIHdvcnNlIHRoYW4gdGhlIHdheSBpdCB3YXMNCj4gPiBiZWZvcmUsIGV2ZW4gaWYgdGhl
IHByZXZpb3VzIGRlc2lnbiBtYXkgaGF2ZSBoYWQgYW5vdGhlciBmbGF3LiAgVGhvdWdoDQo+ID4g
SSd2ZSB5ZXQgdG8gc2VlIGFueW9uZSBwb2ludCBvdXQgc29tZXRoaW5nIG1ha2VzIHRoZSBwcmV2
aW91cyBkZXNpZ24NCj4gPiBicm9rZW4uICBTdWItb3B0aW1hbCB5ZXMsIGJ1dCBub3QgYnJva2Vu
Lg0KPiANCj4gVGhpcyBpcyBub3Qgd2hhdCB3YXMgcmVwb3J0ZWQgYnkgdGhlIHByZXZpb3VzIHN1
Ym1pdHRlci4gSSBndWVzcyB0aGV5DQo+IGNoYW5nZWQgdGhpcyBmb3IgYSByZWFzb24sIG5vPyBJ
J20gcHJlcGFyZWQgdG8gYWRtaXQgdGhpcyBpcyBhIGVuZC1wb2ludA0KPiBkcml2ZXIgYnVnLCBi
dXQgd2UgbmVlZCB0byB1bmRlcnN0YW5kIHdoYXQgaXMgaGFwcGVuaW5nIGFuZCBzdG9wDQo+IGNo
YW5naW5nIHRoaXMgZHJpdmVyIHJhbmRvbWx5Lg0KDQpTZWUgVmlnbmVzaCdzIHJlY2VudCBtZXNz
YWdlIGFib3V0IHRoZSBsYXN0IGNoYW5nZS4gIEl0IHdhcyBhIG1pc3Rha2VuDQphdHRlbXB0IHRv
IGZpeCBhIHByb2JsZW0sIHdoaWNoIGl0IGRpZG4ndCBmaXgsIGFuZCBJIHRoaW5rIHdlIGFsbCBh
Z3JlZQ0KaXQncyBub3QgcmlnaHQuDQoNClJldmVydGluZyBpdCBpcyBub3QgImNoYW5naW5nIHRo
aXMgZHJpdmVyIHJhbmRvbWx5LiIgIEFuZCBJIHRha2UgdGhhdA0KYXMgYSBwZXJzb25hbCBvZmZl
bnNlLiAgWW91IGltcGx5IEkganVzdCBhcHBsaWVkIHBhdGNoZXMgcmFuZG9tbHkgdW50aWwNCnNv
bWV0aGluZyBhcHBlYXJlZCB0byB3b3JrLiAgTWF5YmUgeW91IHRoaW5rIHRoaXMgaXMgYWxsIG92
ZXIgbXkgaGVhZD8gDQpGYXIgZnJvbSBpdC4gIEkgdHJhY2VkIGV2ZXJ5IHBhcnQgb2YgdGhlIGlu
dGVycnVwdCBwYXRoIGFuZCB0aG91Z2h0DQp0aHJvdWdoIGV2ZXJ5IHJhY2UuICBIYW1zdHJ1bmcg
YnkgbGFjayBvZiBkb2NzLCBJIHN0aWxsIGRldGVybWluZWQgdGhlDQpiZWhhdmlvciB0aGF0IHdh
cyByZWxldmFudCB0aHJvdWdoIGVtcGlyaWNhbCBhbmFseXNpcy4gIEkgb25seQ0KZGlzY292ZXJl
ZCB0aGlzIHdhcyBhIHJlY2VudCByZWdyZXNzaW9uIGFuZCBWaWduZXNoJ3MgZWFybGllciBhdHRl
bXB0DQp0byByZXZlcnQgaXQgYWZ0ZXIgSSB3YXMgZG9uZSBhbmQgd2FzIHRyeWluZyB0byBkZXRl
cm1pbmUgaG93IHRoZSBjb2RlDQpnb3QgdGhpcyB3YXkgaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQo+
ID4gSXQgZmVlbHMgbGlrZSB5b3UncmUgdXNpbmcgdGhpcyBidWcgdG8gaG9sZCBkZXNpZ253YXJl
IGhvc3RhZ2UgaW4gYQ0KPiA+IGJyb2tlbiBrZXJuZWwsIGFuZCBtZSBhbG9uZyB3aXRoIHRoZW0u
ICBJIGRvbid0IGhhdmUgdGhlIGRvY3VtZW50YXRpb24sDQo+ID4gbm8gb25lIGRvZXMsIHRoZXJl
J3Mgbm8gd2F5IGZvciBtZSB0byBnaXZlIHlvdSB3YW50IHlvdSB3YW50LiAgQnV0IEkndmUNCj4g
PiBnb3QgaGFyZHdhcmUgdGhhdCBkb2Vzbid0IHdvcmsgaW4gdGhlIG1haW5saW5lIGtlcm5lbC4N
Cj4gDQo+IEkgdGFrZSBpdCBhcyBhIHBlcnNvbmFsIG9mZmVuY2UgdGhhdCBJJ2QgYmUgaG9sZGlu
ZyBhbnl0aGluZyBvciBhbnlvbmUNCj4gaG9zdGFnZS4gSSB0aGluayBJIGhhdmUgYSBsb25nIGVu
b3VnaCB0cmFjayByZWNvcmQgd29ya2luZyB3aXRoIHRoZQ0KPiBMaW51eCBrZXJuZWwgbm90IHRv
IHRha2UgYW55IG9mIHRoaXMgbm9uc2Vuc2UuIFdoYXQncyBteSBpbnRlcmVzdCBpbg0KPiBrZWVw
aW5nIGFueXRoaW5nIGluIHRoaXMgc29ycnkgc3RhdGU/IFRoaW5rIGFib3V0IGl0IGZvciBhIG1p
bnV0ZS4NCg0KSSdtIHNvcnJ5IGlmIHlvdSB0b29rIGl0IHRoYXQgd2F5LiAgSSBhcHByZWNpYXRl
IHRoYXQgdGhlcmUgYXJlIHN0aWxsDQpwZW9wbGUgd2hvIGNhcmUgYWJvdXQgZml4aW5nIHRoaW5n
cyByaWdodCBhbmQgZG9uJ3Qgc2V0dGxlIGZvciB3aGF0ZXZlcg0KdGhlIGVhc2llc3QgdGhpbmcg
aXMgdGhhdCBsZXRzIHRoZW0gc2F5IHRoZXkncmUgZG9uZSwgZXZlbiBpZiB0aGF0IGp1c3QNCmxl
YXZlcyB0aW1lIGJvbWJzIGZvciBldmVyeW9uZSB3aG8gY29tZXMgYWZ0ZXIuDQoNClNvIEkgdGhh
bmsgeW91IGZvciB0YWtpbmcgYSBzdGFuZC4NCg0KQnV0IEkgdGhpbmsgaXQncyBjbGVhciB0aGF0
IDhjOTM0MDk1ZmEyZiB3YXMgYSBtaXN0YWtlIHRoYXQgY2F1c2VzDQpzZXJpb3VzIGJ1Z3MuICBU
aGF0J3Mgbm90IGEgcmFuZG9tIGd1ZXNzOyBpdCdzIHdlbGwgY29uc2lkZXJlZCBhbmQgd2VsbA0K
dGVzdGVkLiAgTm90IHJldmVydGluZyBpdCBub3cgaXNuJ3QgaGVscGluZyBhbnlvbmUgdXNpbmcg
c3RhYmxlIGtlcm5lbHMNCndpdGggdGhpcyByZWdyZXNzaW9uLg0K
