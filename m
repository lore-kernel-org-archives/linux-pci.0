Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3643BC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 23:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B9A22419
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 23:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="Wd4fQUj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B9A22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeKOJ2u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:28:50 -0500
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:15358
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKOJ2u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 04:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnonLUW3kCqqFIbBjlTzjIOdH65EgFfFiXZtBTqJCfM=;
 b=Wd4fQUj5KJCL+t7SzMLr9mxRrcruS16LvwCF99HdasPzQ2LPTRWdXlyx/pcuSawOYIMLVrlVdRzfaBcyP0bm9V4JWNOA/v8oRQ6nYqG47QiVjPznbzC/2gMz5r3+JdWHBo2akmSwc1uDBG7sYyHnZtTiozvJnX178lM1MoWEA5M=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3754.namprd06.prod.outlook.com (10.167.236.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 14 Nov 2018 23:23:25 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 23:23:24 +0000
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
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICAAJ3NAIAALV6AgAAGpgCAAAVjgIAACsMA
Date:   Wed, 14 Nov 2018 23:23:24 +0000
Message-ID: <1542237804.30311.520.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
         <1542223166.30311.471.camel@impinj.com>
         <86sh0348tu.wl-marc.zyngier@arm.com>
         <1542234336.30311.494.camel@impinj.com>
         <86pnv746u2.wl-marc.zyngier@arm.com>
In-Reply-To: <86pnv746u2.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3754;6:5ZAV+TKeP21T/C6mpNSrdUK4eltlZ236eQ/69IqNDiaOnwaha/462p+Lmaw5No1/J6nIIfvUNBjjak9jI5QaqqlYCwIs8XA23ypM0CxHIYEG4gKrfbM//UKd006QvqZh45U34JZ2zj130inf8xz4PVX0gqOS5+WQX+/88rn/rNfGQgBRU3s5mVTM7pZCMuk2t1mlbuS4AE0hr6WJA7tUl1wupguc/jv23pA+hP87OOECkFGHiixXS6E1Z7eLSACAiaIOv3i98LjOVMAnUzPPcO9U+yZNwXe2PtIcuf1JZ2r+A6GR0bABno7Z5HJVrF7BlE5f6VkCWDIbl+BWHJnWPS4zWmJ9oTatfZSAkB8bOZafoHVT87B497AZ9PJubgZIF1XtgsugO+TTDvkehjll1pruEKi1gwtVjxxjDAOAjCpXN7ihk9ccqbDUYLmtP7eRJ/Q1DRSM8N/NZ6YbHZLtIg==;5:Xw8RyxdS0Fumi47Rymcaz3WfxuQcs35V0gzfAzwo2jAWmo5xzxq1O521az7ux0T8oZKTU0yfmODZMYbvehlEDkAYADrM6QKD8VinRuOB8SVmbfXPsCiRl+YHXBdQXkJciFdZppozbx4boa7oaMwvhnMMFxcM5ZBXo4HpyTykTmg=;7:WIdUS+kLKBguaUaI8Bf7iBHqR3jtCd9iPVDLzn39B6lmkCwTLj8clEYCOp9eB3LimS8PLGkaNz4xGkrtpmzJHGlF3+TxKSbNk7M1n2VlqSCraUjpO62gUgELuFnZt8gQ0c+Na5AXbD0o1rXMXiHzXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 385abfe0-da14-44fe-dff4-08d64a882cec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3754;
x-ms-traffictypediagnostic: MWHPR0601MB3754:
x-microsoft-antispam-prvs: <MWHPR0601MB37540BD63EF128E1E08E7B06D3C30@MWHPR0601MB3754.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3754;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3754;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(396003)(346002)(376002)(366004)(199004)(189003)(54094003)(2900100001)(7736002)(2501003)(305945005)(229853002)(97736004)(4001150100001)(106356001)(2351001)(53936002)(6246003)(6512007)(103116003)(8936002)(81166006)(81156014)(8676002)(3846002)(6116002)(105586002)(256004)(14444005)(2616005)(476003)(25786009)(486006)(71200400001)(71190400001)(68736007)(478600001)(11346002)(4326008)(446003)(2906002)(99286004)(86362001)(186003)(6506007)(26005)(102836004)(93886005)(316002)(54906003)(36756003)(76176011)(14454004)(39060400002)(66066001)(5640700003)(6436002)(6486002)(5660300001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3754;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N+7lI5ecNwjbYbqh87bf3oOQ7EOgXEBPdYQv1NiS21EL9yaPKSXCjC0LRSOVmBXUMWQH6ToNF9XRnCMBzWD2LoJIj5lOB9R5N//JJFCUaW4rMByDJqazV0RIIwUrxYBlmpFSH5BKTNNY/wZzdIdJT4Q3hR6ww8SAI2j1vUJe4ZJZp7XEVhK/4L5CUAwguEUPkJoL6L1CHh17/ETjqeOvBttcklskX9Heh4EPcid0eCSuTxSUjry1f1gEUNnO72sDdCIoFnngeAkJLUPo4iNUxEIBqBs8MN6r1GmOUOMvDn0pOOfctMidOlGeMg7IS2LH7xYXQ2/i1hFO2wfZ6DM28ksrmbltcm16kjeWiKHBCU0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A8AB97721A17F4F85B76244FC61A746@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385abfe0-da14-44fe-dff4-08d64a882cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 23:23:24.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3754
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDIyOjQ0ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
ICBzdGF0aWMgc3RydWN0IGlycV9jaGlwIGR3X3BjaWVfbXNpX2lycV9jaGlwID0gew0KPiA+ICAJ
Lm5hbWUgPSAiUENJLU1TSSIsDQo+ID4gIAkuaXJxX2FjayA9IGR3X21zaV9hY2tfaXJxLA0KPiA+
ICAJLmlycV9tYXNrID0gZHdfbXNpX21hc2tfaXJxLA0KPiA+ICAJLmlycV91bm1hc2sgPSBkd19t
c2lfdW5tYXNrX2lycSwNCj4gPiArCS5pcnFfZW5hYmxlID0gZHdfbXNpX2VuYWJsZV9pcnEsDQo+
IA0KPiBJZiB5b3UncmUgZG9pbmcgdGhhdCwgcGxlYXNlIGltcGxlbWVudCBib3RoIGVuYWJsZSAq
YW5kKiBkaXNhYmxlLg0KDQpZZXMsIGNlcnRhaW5seS4gIEknbSBub3QgeWV0IGNvbnZpbmNlZCBJ
J3ZlIHNob3VsZCBwdXQgdGhpcyBoZXJlIG9yIGlmDQpteSBlbmFibGUgbWV0aG9kIGhhcyBub3Qg
bWlzc2VkIHNvbWV0aGluZy4gIEp1c3QgcHV0dGluZyB0aGlzIG91dCB0aGVyZQ0KYXMgYSB3YXkg
dG8gdGVzdCB0aGUgY29kZS4NCg0KPiANCj4gPiArc3RhdGljIHZvaWQgZHdfcGNpX2JvdHRvbV9l
bmFibGUoc3RydWN0IGlycV9kYXRhICpkYXRhKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcGNpZV9w
b3J0ICpwcCA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGRhdGEpOw0KPiA+ICsJdW5zaWdu
ZWQgaW50IHJlcywgYml0LCBjdHJsOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAr
CXUzMiBlbmFibGU7DQo+ID4gKw0KPiA+ICsJY3RybCA9IGRhdGEtPmh3aXJxIC8gTUFYX01TSV9J
UlFTX1BFUl9DVFJMOw0KPiA+ICsJcmVzID0gY3RybCAqIE1TSV9SRUdfQ1RSTF9CTE9DS19TSVpF
Ow0KPiA+ICsJYml0ID0gZGF0YS0+aHdpcnEgJSBNQVhfTVNJX0lSUVNfUEVSX0NUUkw7DQo+ID4g
Kw0KPiA+ICsJcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZwcC0+bG9jaywgZmxhZ3MpOw0KPiA+ICsN
Cj4gPiArCWR3X3BjaWVfcmRfb3duX2NvbmYocHAsIFBDSUVfTVNJX0lOVFIwX0VOQUJMRSArIHJl
cywgNCwNCj4gPiAmZW5hYmxlKTsNCj4gPiArCWVuYWJsZSB8PSBCSVQoYml0KTsNCj4gPiArCWR3
X3BjaWVfd3Jfb3duX2NvbmYocHAsIFBDSUVfTVNJX0lOVFIwX0VOQUJMRSArIHJlcywgNCwNCj4g
PiBlbmFibGUpOw0KDQpJIHdvbmRlciBpZiB0aGVyZSBhcmUgRU5BQkxFX1NFVCBhbmQgRU5BQkxF
X0NMUiByZWdpc3RlcnMgdG8gYWxsb3cNCnNldHRpbmcvY2xlYXJpbmcgYSBiaXQgYXRvbWljYWxs
eSB3aXRoIG9uZSB3cml0ZSwgYXMgaXMgcG9zc2libGUgd2l0aA0KdGhlIHN0YXR1cyByZWdpc3Rl
ci4NCg0KPiA+ICsNCj4gPiArCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZwcC0+bG9jaywg
ZmxhZ3MpOw0KPiA+ICt9DQo+IA0KPiBIb3cgZG9lcyBpdCB3b3JrIGZvciBkcml2ZXJzIHRoYXQg
dXNlIHRoZSBjYWxsYmFja3Mgc3R1ZmY/DQoNCkRvIHlvdSBtZWFuIHRoZSBvcHMgY2FsbGJhY2tz
IGluIHRoZSBwY2llX3BvcnQ/ICBUaGVyZSBpc24ndCBhIGNhbGxiYWNrDQppbiBkd19wY2llX2hv
c3Rfb3BzIGZvciBlbmFibGUvZGlzYWJsZS4gIEJ1dCB0aGVyZSBpcw0KbXNpX3NldC9jbGVhcl9p
cnEsIHVuZG9jdW1lbnRlZC4gIExvb2tzIGxpa2UgaXQncyB0aGUgbWF5YmUgdGhlIHNhbWUNCnRo
aW5nIHVzaW5nIGRpZmZlcmVudCB0ZXJtcy4gIE9ubHkgdXNlciBpcyBrZXlzdG9uZS4gIE9ubHkg
Y2FsbHNpdGUgaXMNCmZyb20gdGhlIGR3X3BjaV9ib3R0b21fdW4vKiptYXNrKiooKSBtZXRob2Rz
Lg0KDQpJdCBzZWVtcyBzb21lb25lIGVsc2Ugd2FzIHVuY2xlYXIgb24gdGhlIGRpc3RpbmN0aW9u
IGJldHdlZW4gZGlzYWJsaW5nDQphbmQgbWFza2luZyBhbiBJUlEuDQoNClNvIG15IHBhdGNoIHNo
b3VsZCBwbGF5IG9rIHdpdGggdGhlIG9ubHkgYWZmZWN0ZWQgdXNlciwga2V5c3RvbmUsIGluDQp0
aGUgc2Vuc2UgaXQgY2F1c2VzIG5vIG5ldyBwcm9ibGVtcy4NCg0KQnV0IHRoZXJlIG1pZ2h0IGJl
IGFub3RoZXIgZmxhdyBoZXJlLCBmaXhlZCBieToNCg0KMS4gRGVjaWRlIG1zaV9zZXQvY2xlYXJf
aXJxIHNob3VsZCBlbmFibGUvZGlzYWJsZSB0aGUgaXJxLCByZW1vdmUgaXQNCmZyb20gdGhlIHVu
L21hc2sgbWV0aG9kcyBhbmQgbW92ZSBpdCBpbnRvIHRoZSBlbi9kaXNhYmxlIG1ldGhvZHMuDQoN
CjIuIERlY2lkZSBtc2lfc2V0L2NsZWFyX2lycSBzaG91bGQgdW4vbWFzayB0aGUgaXJxIGFuZCBr
ZXlzdG9uZSBzaG91bGQNCm5vdCBiZSB1c2luZyBpdCB3aXRoIHRoZSBrZXlzdG9uZSAiRU5BQkxF
IiByZWdpc3Rlci4NCg0KMy4gTGlrZSAyLCBidXQgZGVjaWRlIHRoZSBrZXlzdG9uZSBlbmFibGUg
cmVnaXN0ZXIgcmVhbGx5IGlzIGEgbWFzayBhbmQNCmV2ZXJ5dGhpbmcgaXMgZmluZS4NCg0KTXkg
YmV0IGlzIG9uIDEuDQo=
