Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF980C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 18:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13A720892
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 18:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="LpkXo63R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13A720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeKHEEN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:04:13 -0500
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:10944
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbeKHEEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 23:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19eEvNmXoEJmpjYMf0qhvbBok00u5n4Y1oaJZ7KVj+k=;
 b=LpkXo63RQhm7VznnZ1lYQKa0D7NsBgK82mOUzc6Ax7J09V6XnNQFiy/RhK+tF4n8RZTXi89dN12nYZI4REO3LrvKovLI+pC0AxyeqNp27IPRZlKXZydWy/ucxseZ7KgPzkQvuiZp8yfUYyND9xuPN5FxOQ+4baGIodY9WutvTQg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3787.namprd06.prod.outlook.com (10.167.236.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 18:32:32 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 18:32:32 +0000
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
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAV9pgIAAXX+A
Date:   Wed, 7 Nov 2018 18:32:31 +0000
Message-ID: <1541615551.30311.286.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
In-Reply-To: <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3787;6:Tf+u9mH8I6ei4XtC5hA8ELHS6NHhV8gl9uyv0WsDDbYH+/2m+vk0s4oxUVzw30SJuXUpwz5uhOT/Ay9wMTEEVIfgJYqCLEbARRRCQ1b5wfq9+nJ/pn8DrYMajw9GTO3FW1sUoBgjeHkKLjGQyxM43ykKgMDcsuv2xGEC/OfQaeU1L3RyUJkTc//fISdkMQfcS85ip6kb8I6PVwf1rqszKsg65v093nVk8maXRVhC4NPzuXNYEWqiyOE9A0QJDu7/hSmR2OngV/TfOTbdkHVYiva/h5CsJTo4NjL3ZvMIXAgkxWKc8O+ZgKvl+Zk+WCJ72t+KVZ/llpUkrCn9FzoWeK9p1zWmlYjbaTuWdQrKACl9BkAhKiB5+Pw9S5e1KOJOpsJExGPFhWTBEfr94trebIEKQEjdDrj/a9fipIzk/Sqc4OyhxbjhKMpDi5eNY4Jaz8T/c9BexX1VtbAnMRVaQw==;5:nR6LkwsAChCIIMzm9mLnVf2dQCZTgXrqtm6LNSiHo+BpwrrpLJ1qGSnKnfb3IQDwUzQ5YER2dUDljbenqcQN7ZEC+O2NIX4KmGWNZexLVhTsUMC8Yrni9RJOrhIkWGrkOaq+Opa1oiuI4mpSsq6edDcRr4n1z271m3T5Jf0kdJg=;7:OzVwvAUq9cNwhb3JtqpLZXtJ0uQ6Njjqrep0lhedcFAZXJqz+tPTmh6JHTGQqdCZTi/GJ5INHW2S3Kc0rNbT9l6y03gMhXdQ/PM7X5VJf2uRgu2campwpYN75eFh1Wo5uleOj6tupDrUyEx2nfKygA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e6fb6416-7aec-4ed9-87c8-08d644df614e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3787;
x-ms-traffictypediagnostic: MWHPR0601MB3787:
x-microsoft-antispam-prvs: <MWHPR0601MB3787BB94E5EB329458CC65FBD3C40@MWHPR0601MB3787.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3787;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3787;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39850400004)(396003)(376002)(346002)(136003)(189003)(199004)(229853002)(110136005)(54906003)(6116002)(3846002)(4326008)(7736002)(478600001)(186003)(305945005)(66066001)(39060400002)(81156014)(68736007)(486006)(81166006)(102836004)(8936002)(6506007)(11346002)(476003)(2616005)(53546011)(103116003)(76176011)(2906002)(105586002)(106356001)(8676002)(7416002)(2900100001)(316002)(2201001)(6512007)(93886005)(97736004)(6486002)(36756003)(2501003)(14454004)(25786009)(71190400001)(71200400001)(26005)(446003)(5660300001)(6436002)(99286004)(6246003)(256004)(53936002)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3787;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jBetqJgFAdXNdrc8vbA5hvijAmc8Q/czpLT0cnWLt74Qj9DMGRe4932OwuFEd91l3AbjG7uRjyS0VnZWNIETYkDN5s4JTg1Dq9icd1Y3hOn7q7kB1xLr/IDrkwyOtdRj+MMQls+EIo/0QsrFLwIcOJZ/DfVrT43DY9fJQ5Szmd4P3LXSAHtV49jbszXGU9yDmLROI2yxss9NbdJ1KIozIZTMMVi6y2FshzrX3Aa+srAyrcdgcJqhwxITD3EMCP8SDTaK3mln8TKCAgXJX8Jmmy13CCkbh4VlGAWr5acUyeeRaZMEBftILx8o9N5SMBuw/2sCur3samQBETJus2KL26x2oM6FdqR/S0hedUg+Ya0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E86F6905943B364EB78F2C445B30263C@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fb6416-7aec-4ed9-87c8-08d644df614e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 18:32:31.9115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3787
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDEyOjU3ICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3Rl
Og0KPiBPbiAwNi8xMS8yMDE4IDE2OjAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gT24gMDYv
MTEvMTggMTQ6NTMsIExvcmVuem8gUGllcmFsaXNpIHdyb3RlOg0KPiA+ID4gT24gU2F0LCBPY3Qg
MjcsIDIwMTggYXQgMTI6MDA6NTdBTSArMDAwMCwgVHJlbnQgUGllcGhvIHdyb3RlOg0KPiA+ID4g
PiANCj4gPiA+ID4gVGhpcyBnaXZlcyB0aGUgZm9sbG93aW5nIHJhY2Ugc2NlbmFyaW86DQo+ID4g
PiA+IA0KPiA+ID4gPiAxLiAgQW4gTVNJIGlzIHJlY2VpdmVkIGJ5LCBhbmQgdGhlIHN0YXR1cyBi
aXQgZm9yIHRoZSBNU0kgaXMgc2V0IGluLCB0aGUNCj4gPiA+ID4gRFdDIFBDSS1lIGNvbnRyb2xs
ZXIuDQo+ID4gPiA+IDIuICBkd19oYW5kbGVfbXNpX2lycSgpIGNhbGxzIGEgZHJpdmVyJ3MgcmVn
aXN0ZXJlZCBpbnRlcnJ1cHQgaGFuZGxlcg0KPiA+ID4gPiBmb3IgdGhlIE1TSSByZWNlaXZlZC4N
Cj4gPiA+ID4gMy4gIEF0IHNvbWUgcG9pbnQsIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBtdXN0IGRl
Y2lkZSwgY29ycmVjdGx5LCB0aGF0DQo+ID4gPiA+IHRoZXJlIGlzIG5vIG1vcmUgd29yayB0byBk
byBhbmQgcmV0dXJuLg0KPiA+ID4gPiA0LiAgVGhlIGhhcmR3YXJlIGdlbmVyYXRlcyBhIG5ldyBN
U0kuICBBcyB0aGUgTVNJJ3Mgc3RhdHVzIGJpdCBpcyBzdGlsbA0KPiA+ID4gPiBzZXQsIHRoaXMg
bmV3IE1TSSBpcyBpZ25vcmVkLg0KPiA+ID4gPiA2LiAgZHdfaGFuZGxlX21zaV9pcnEoKSB1bnNl
dHMgdGhlIE1TSSBzdGF0dXMgYml0Lg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIE1TSSByZWNlaXZl
ZCBhdCBwb2ludCA0IHdpbGwgbmV2ZXIgYmUgYWN0ZWQgdXBvbi4gIEl0IG9jY3VycmVkIGFmdGVy
DQo+ID4gPiA+IHRoZSBkcml2ZXIgaGFkIGZpbmlzaGVkIGNoZWNraW5nIHRoZSBoYXJkd2FyZSBz
dGF0dXMgZm9yIGludGVycnVwdA0KPiA+ID4gPiBjb25kaXRpb25zIHRvIGFjdCBvbi4gIFNpbmNl
IHRoZSBNU0kgc3RhdHVzIHdhcyBtYXNrZWQsIGl0IGRvZXMgbm90DQo+ID4gPiA+IGdlbmVyYXRl
ZCBhIG5ldyBJUlEsIG5laXRoZXIgd2hlbiBpdCB3YXMgcmVjZWl2ZWQgbm9yIHdoZW4gdGhlIE1T
SSBpcw0KPiA+ID4gPiB1bm1hc2tlZC4NCj4gPiA+ID4gDQoNCj4gVGhpcyBzdGF0dXMgcmVnaXN0
ZXIgaW5kaWNhdGVzIHdoZXRoZXIgZXhpc3RzIG9yIG5vdCBhIE1TSSBpbnRlcnJ1cHQgb24gdGhh
dA0KPiBjb250cm9sbGVyIFswLi43XSB0byBiZSBoYW5kbGUuDQoNCldoaWxlIHRoZSBzdGF0dXMg
Zm9yIGFuIE1TSSBpcyBzZXQsIG5vIG5ldyBpbnRlcnJ1cHQgd2lsbCBiZSB0cmlnZ2VyZWQNCmlm
IGFub3RoZXIgaWRlbnRpY2FsIE1TSSBpcyByZWNlaXZlZCwgY29ycmVjdD8NCg0KPiBJbiB0aGVv
cnksIHdlIHNob3VsZCBjbGVhciB0aGUgaW50ZXJydXB0IGZsYWcgb25seSBhZnRlciB0aGUgaW50
ZXJydXB0IGhhcw0KPiBhY3R1YWxseSBoYW5kbGVkICh3aGljaCBjYW4gdGFrZSBzb21lIHRpbWUg
dG8gcHJvY2VzcyBvbiB0aGUgd29yc3QgY2FzZSBzY2VuYXJpbykuDQoNCkJ1dCBzZWUgYWJvdmUs
IHRoZXJlIGlzIGEgcmFjZSBpZiBhIG5ldyBNU0kgYXJyaXZlcyB3aGlsZSBzdGlsbCBtYXNrZWQu
DQogSSBjYW4gc2VlIG5vIHBvc3NpYmxlIHdheSB0byBzb2x2ZSB0aGlzIGluIHNvZnR3YXJlIHRo
YXQgZG9lcyBub3QNCmludm9sdmUgdW5tYXNraW5nIHRoZSBNU0kgYmVmb3JlIGNhbGxpbmcgdGhl
IGhhbmRsZXIuICBUbyBsZWF2ZSB0aGUNCmludGVycnVwdCBtYXNrZWQgd2hpbGUgY2FsbGluZyB0
aGUgaGFuZGxlciByZXF1aXJlcyB0aGUgaGFyZHdhcmUgdG8NCnF1ZXVlIGFuIGludGVycnVwdCB0
aGF0IGFycml2ZXMgd2hpbGUgbWFza2VkLiAgV2UgaGF2ZSBubyBkb2NzLCBidXQgdGhlDQpkZXNp
Z253YXJlIGNvbnRyb2xsZXIgZG9lc24ndCBhcHBlYXIgdG8gZG8gdGhpcyBpbiBwcmFjdGljZS4N
Cg0KPiBIb3dldmVyLCB0aGUgVHJlbnQncyBwYXRjaCBhbGxvd3MgdG8gYWNrbm93bGVkZ2UgdGhl
IGZsYWcgYW5kIGhhbmRsZSB0aGUNCj4gaW50ZXJydXB0IGxhdGVyLCBnaXZpbmcgdGhlIG9wcG9y
dHVuaXR5IHRvIGNhdGNoIGEgcG9zc2libGUgbmV3IGludGVycnVwdCwgd2hpY2gNCj4gd2lsbCBi
ZSBoYW5kbGUgYnkgYSBuZXcgY2FsbCBvZiB0aGlzIGZ1bmN0aW9uLg0KPiANCj4gPiANCj4gPiBX
aGF0IEknbSBpbnRlcmVzdGVkIGluIGlzIHRoZSByZWxhdGlvbnNoaXAgdGhpcyBoYXMgd2l0aCB0
aGUgbWFzay91bm1hc2sNCj4gPiBjYWxsYmFja3MsIGFuZCB3aGV0aGVyIG1hc2tpbmcgdGhlIGlu
dGVycnVwdCBiZWZvcmUgYWNraW5nIGl0IHdvdWxkIGhlbHAuDQo+IA0KPiBBbHRob3VnaCB0aGVy
ZSBpcyB0aGUgcG9zc2liaWxpdHkgb2YgbWFzay91bm1hc2sgdGhlIGludGVycnVwdGlvbnMgb24g
dGhlDQo+IGNvbnRyb2xsZXIsIGZyb20gd2hhdCBJJ3ZlIHNlZW4gdHlwaWNhbGx5IGluIG90aGVy
IGR3IGRyaXZlcnMgdGhpcyBpcyBub3QgZG9uZS4NCj4gUHJvYmFibHkgd2UgZG9uJ3QgZ2V0IG11
Y2ggYmVuZWZpdCBmcm9tIHVzaW5nIGl0Lg0KPiANCj4gR3VzdGF2bw0KPiANCj4gPiANCj4gPiBH
dXN0YXZvLCBjYW4geW91IGhlbHAgaGVyZT8NCj4gPiANCj4gPiBJbiBhbnkgd2F5LCBtb3Zpbmcg
dGhlIGFjdGlvbiBvZiBhY2tub3dsZWRnaW5nIHRoZSBpbnRlcnJ1cHQgdG8gaXRzDQo+ID4gcmln
aHQgc3BvdCBpbiB0aGUga2VybmVsIChkd19wY2lfYm90dG9tX2Fjaykgd291bGQgYmUgYSBnb29k
IHN0YXJ0Lg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiANCj4gPiAJTS4NCj4gPiANCj4gDQo+IA==
