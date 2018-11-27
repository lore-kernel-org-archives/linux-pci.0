Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B74C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84E521104
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="hjg13JYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84E521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725740AbeK1FL3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:11:29 -0500
Received: from mail-eopbgr690100.outbound.protection.outlook.com ([40.107.69.100]:59840
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725752AbeK1FL3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 00:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI0kB8K9HjZR0sTXoffwOgFwdOh2r7eDltlnqql9120=;
 b=hjg13JYaNZh7t9Vfn0mGY6J5sGSwOCHx1jtbkDQSI+U+8COtbj2cCQzStNOYzRQF+iewNdjcQQ3SCMAeG8Dx0qE2+g6SD125xe9Reh+zkx+73nCPkr/g0jrNKXpQzhXJTwvitqgGSU3fNeKCNRdwqiGXrrGF3j0vBJkTbzsMmtg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3692.namprd06.prod.outlook.com (10.167.236.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 27 Nov 2018 18:12:03 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 18:12:03 +0000
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
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICADLahgIAGiV+AgAELoICAAK2nAA==
Date:   Tue, 27 Nov 2018 18:12:02 +0000
Message-ID: <1543342322.18519.64.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
         <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
         <1543247559.18519.13.camel@impinj.com> <86d0qrrmbc.wl-marc.zyngier@arm.com>
In-Reply-To: <86d0qrrmbc.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3692;6:PEgDrfk88ZYoiuPCunt5EOkSdv+Zh24/DQL43YegBinRV7gNN/N5FqxpBsitc85z2EfhEM/OeQ9EwOHr1nzdIoobcZxoTXUe4mXFa5Vthnd6vhJotvmUFwdgASK1HMjAgott3mhNfZad4vjvRl3tJ/Bh1Z5KSqWfBplaCnsDRaSIg1EBPvTmVm+oAr3E5PJl06/98exHN/HNK1neO4B/n6SPYNz0siA6xtorj6VS61vTnTG/6dfURHvqvduv88VOvhJneQkbCbY5MFnDO4dRBgH8iwbWPIFzyAUj3Bn6Wnxn33Y6F5YE0QmtBgus5u5LFlcaKCTpgpJJhutqhF10Nc7avY+KCXdRY7knbNvdB2YSqYFNHscoYthzrhHG+xyvSn8ZaSZnzmEY9BxDQc4vrxdXvx07O6mS50tTt9Sd5DQ+6CmJtl7Itv3gZTWnIyQOg/ijZkEB5z4NOTOxQsTbjQ==;5:RMSWJXJWq8QnkHkshf0rZ/z8ttmMuupMLD2qhywpEq7AIjixhkeWQTNEOpo1lBTDEglPQ8n13D4zAhIR4UXmPK3N2HUmQ9LQERMYJP3P9f6MWibe71XbTIPLR6qMRXGtM9LSmhbheQSXUs6taaI6SbtMdlEdJS/SaShLybHe/wo=;7:5CLSrU3fkY77d+UfPrVHKfgztJlUeh1840dtCkqLTRPwOi987flRKSAPu9ySb88J2uSD/eKLPVehM50XgaZqUQrSDfsCc5LUJHexe7CWRDPYjgn9VSbmO7o2p1rdq9yoXXUWTj86ONWoIAg3mxhr7Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fa1dbe32-dc4d-4a81-b7ac-08d65493d51c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3692;
x-ms-traffictypediagnostic: MWHPR0601MB3692:
x-microsoft-antispam-prvs: <MWHPR0601MB36926A843AEF0492A3B833F8D3D00@MWHPR0601MB3692.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3692;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3692;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39850400004)(366004)(136003)(199004)(189003)(103116003)(305945005)(7736002)(316002)(99286004)(76176011)(2906002)(6512007)(54906003)(6916009)(8676002)(93886005)(478600001)(81166006)(2351001)(105586002)(6506007)(81156014)(3846002)(6116002)(66066001)(256004)(229853002)(106356001)(8936002)(14444005)(36756003)(5660300001)(2616005)(86362001)(11346002)(53936002)(26005)(2501003)(4326008)(186003)(25786009)(486006)(6436002)(5640700003)(446003)(102836004)(68736007)(476003)(97736004)(71190400001)(14454004)(4001150100001)(6246003)(71200400001)(6486002)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3692;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T3yF/Z+Nyi9gv8H93hoafqX6XlYO/Fj/2gqzbjQup1PQuLJ0NF201M4DrEeQDhp4xpoxQlhwkHq9j/23AUG5RY8Bs242LGJocWUV6i2N3bT9vHa6CT6GGiPRY4BBQ6A8EySdUpFkfQwxngQO71T7cb8yIPyR/bd0lL67pn0lNYOhfpgpmJNBs9y54Bc5AlgPrHv7tco+5dbRBo5+PKZAaitatfCYn/noyCMX1Arfwbo8cqy6MQ/aPtljFlGGSyvTGjdUnvq+4fh3Ki94HtHHxx+aMaSEjhNrfUsqb4iB4MYot6V6fbBU9bmHsT2nKp1vUDFN6DQmjY91S4T0GLYYYQaqP7+biX2B1WtrVVPw8L8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F277C1127F857D478AB69D419CB76727@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1dbe32-dc4d-4a81-b7ac-08d65493d51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 18:12:02.9827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3692
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTI3IGF0IDA3OjUwICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIE1vbiwgMjYgTm92IDIwMTggMTU6NTI6NDIgKzAwMDAsDQo+IFRyZW50IFBpZXBobyA8dHBp
ZXBob0BpbXBpbmouY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IEkgdXNlZCB5b3VyIHBhdGNoIGFu
ZCBtYWRlIGl0IG1vcmUgcGVyY2VwdGlibGUgaW4gbXkgb3BpbmlvbiwgKGJhc2ljYWxseSBJDQo+
ID4gPiB0cmFuc2Zvcm1lZCB0aGUgdmFyaWFibGUgaXJxX21hc2sgKHByZXZpb3VzIGlycV9zdGF0
dXMpIGludG8gYSBtaXJyb3Igb2YgTUFTSw0KPiA+ID4gcmVnaXN0ZXJzLCB3aGljaCByZW1vdmVk
IHRoZSBuZWVkIGZvciB0aGUgKk5PVCogb3BlcmF0aW9uIGFuZCBmb3JjZWQgdGhlIG1hc2sNCj4g
PiA+IG9wZXJhdGlvbiBzd2FwIGluIHRoZSBjYWxsYmFja3MpDQo+ID4gDQo+ID4gVGhpcyB3b3Vs
ZCBiZSB0aGUgcGF0Y2ggdGhhdCBlbmFibGVzIGFsbCBNU0kgaW50ZXJydXB0cyBvbiBkcml2ZXIN
Cj4gPiBpbml0aWFsaXphdGlvbj8NCj4gPiANCj4gPiBJIGRvbid0IHRoaW5rIHRoYXQncyBhIGdv
b2QgaWRlYS4gIEkgd2FzIHVuZGVyIHRoZSBpbXByZXNzaW9uIE1hcmMNCj4gPiB0aG91Z2h0IHRo
YXQgYXMgd2VsbC4gIEl0IHdvdWxkIGJlIGJldHRlciB0byBlbmFibGUgdGhlbSB3aGVuIHRoZXkg
YXJlDQo+ID4gZW5hYmxlZCwgdmlhIGVuYWJsZSBhbmQgZGlzYWJsZSBtZXRob2RzLg0KPiANCj4g
V2hhdCBnYWluIGRvZXMgdGhpcyBicmluZz8gRnJhbmtseSwgSSBzZWUgZXhhY3RseSB6ZXJvIGFk
dmFudGFnZSBvZg0KPiBkb2luZyBzby4gSXQgbWF5IGxvb2sgY29zbWV0aWNhbGx5IGFwcGVhbGlu
ZyBpbiB0aGUgc2Vuc2UgdGhhdCBpdA0KPiBtYWtlcyB1c2Ugb2Ygb2YgYSByZWdpc3RlciB0aGF0
IHRoZSBJUCBvZmZlcnMsIGJ1dCBmb3IgTGludXggdGhlDQo+IGFkdmFudGFnZSBpcyBiYXNpY2Fs
bHkgbnVsbC4NCg0KSGVyZSdzIHdoeToNCg0KMS4gSXQncyBhIGJpZyBjaGFuZ2UgaW4gZHJpdmVy
IGJlaGF2aW9yIHRvIGVuYWJsZSBhbGwgTVNJcy4gIFRoZXJlIHdpbGwNCmNlcnRhaW5seSBiZSBo
YXJkd2FyZSB0aGF0IHdyaXRlcyB0byBhbiBNU0ktWCBhZGRyZXNzLCBwZXJoYXBzIHRvDQpnZW5l
cmF0ZSBhIE1TSSwgcGVyaGFwcyBub3QsIHdoZXJlIHRoYXQgTVNJIGlzIGRpc2FibGVkLiAgTm93
IHRoYXQNCmhhcmR3YXJlIHdpbGwgc3RhcnQgZ2VuZXJhdGluZyBpbnRlcnJ1cHRzLiAgVGhhdCBj
b3VsZCBiZSBhIGJpZyBkZWFsLiANClRoZSBNU0kgbWlnaHQgd2VsbCBoYXZlIGJlZW4gbm90IGVu
YWJsZWQgdmVyeSBpbnRlbnRpb25hbGx5ISAgTm8gcmVhc29uDQp0byBjcmVhdGUgdGhhdCBjaGFu
Z2UgaW4gYmVoYXZpb3IgYW5kIGFsc28gdmVyeSBtdWNoIG5vdCBhIGdvb2QgaWRlYSB0bw0KYmFj
a3BvcnQgdG8gc3RhYmxlIGtlcm5lbHMuDQoNCjIuIEV4aXN0aW5nIGNvZGUgaXMgbm90IGNsZWFy
IGFib3V0IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gbWFzayBhbmQNCmRpc2FibGUsIGdldHRpbmcg
aXQgd3JvbmcgaW4gc29tZSBwbGFjZXMgYW5kIGNhdXNpbmcgYnVncy4gIENyZWF0aW5nDQpib3Ro
IG1hc2sgYW5kIGRpc2FibGUgd2lsbCBtYWtlIGl0IGNsZWFyLiAgSXQncyB0aGUgc2FtZSByZWFz
b25pbmcgeW91DQp1c2UgdG8gcmVqZWN0IG15IHNpbXBsZSBwYXRjaCB0byBwdXQgdGhlIGlycSBh
Y2sgYXQgdGhlIGNvcnJlY3QgdGltZQ0KYW5kIGluc3RlYWQgYWxzbyBwdXQgaXQgaW4gdGhlIHNl
bWFudGljYWxseSBjb3JyZWN0IGxvY2F0aW9uLg0KDQozLiBBIHBsYXRmb3JtLCBrZXlzdG9uZSwg
aGFzIHByb3ZpZGVkIGVuYWJsZS9kaXNhYmxlIG1ldGhvZHMgZm9yIHRoZQ0KZHdjIGRyaXZlci4g
IEJ1dCB0aGV5IGFyZSAobm93KSBjYWxsZWQgZnJvbSB0aGUgbWFzay91bm1hc2sgcm91dGluZXM/
IQ0KVGhhdCdzIG5vdCByaWdodDsgaXQnbGwgZHJvcCBpcnFzIGlmIGl0J3MgcmVhbGx5IGFuIGVu
YWJsZS9kaXNhYmxlDQpmZWF0dXJlIGluIGtleXN0b25lLiAgV2l0aG91dCBkd2MgZW5hYmxlL2Rp
c2FibGUgbWV0aG9kcywgd2hlcmUgd2lsbA0KdGhlIHBsYXRmb3JtIGVuYWJsZS9kaXNhYmxlIG1l
dGhvZHMgYmUgY2FsbGVkIGZyb20/ICBUaGVzZSBtZXRob2RzIGFyZQ0KZ2V0dGluZyByYW5kb21s
eSBtb3ZlZCBmcm9tIG1hc2sgdG8gZGlzYWJsZSBhbmQgYmFjaywgbGlrZSB0aGUgYWNrDQpnZXR0
aW5nIG1vdmVkIGFyb3VuZCwgYW5kIGNsZWFyIGRpc3RpbmN0aW9uIGJldHdlZW4gZGlzYWJsZSBh
bmQgbWFzaw0Kd2lsbCBoZWxwIHN0b3AgdGhhdC4NCg==
