Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F030C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F222419
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="PgjuixQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5F222419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKOIz1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:55:27 -0500
Received: from mail-eopbgr800102.outbound.protection.outlook.com ([40.107.80.102]:43762
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKOIz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 03:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiRnXx6l+mQTiqbX/ifS4RXexLGNjOSqJBQVVRiBP50=;
 b=PgjuixQmHRpmSzeSBgHzXZBb8/6uKjJhUSjt7aT7YDZG7wZdgiJ2gFMAt4QRJ0zao7LkBmqNQn8YjxBpOTnRUF2QQitWG7HkMRCJ5H7REyFRbkEKsJw5igQPV2lmNGRARUd4wc/M3mWqhVEfgVCdzwfF+N3rikBdPrKqFR7WS/o=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3609.namprd06.prod.outlook.com (10.167.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 14 Nov 2018 22:50:09 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 22:50:09 +0000
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
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVPmEcAgAA9ZwCAAAvRAA==
Date:   Wed, 14 Nov 2018 22:50:09 +0000
Message-ID: <1542235808.30311.504.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <1542220084.30311.453.camel@impinj.com>
         <86r2fn48jt.wl-marc.zyngier@arm.com>
In-Reply-To: <86r2fn48jt.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3609;6:P7fW9SwTxaUeXvyYsPBYj8qX4GL9vYVritrC41hV3Izf5x3iwYX5sMMZ9aXfOvlT9kqtxXlwx7zLBCF/1+bUv78X/sXZtCFDdK7R2y8EeGl2EBDz5w5yZlmXav3Fx3eVURebw3Ytz8Cxz9VYEJIgySRD4pMJl3lSjMhOVUiXLtLh+siHlJHAK7ANg0osX+7JYrYyWQgY6JhNCg4F6+AiT0i2ExP4Z0tOJDORVZGygYGD99aQCOeT7eyHC2Hg8ZJb9t3f/1NLWo5UxVdDICkijsu31i2L+WxQOuH2GZyW0VlQwr37fRyJAgzjfIisd6ZghI/0wDOC15/hg1nOF5udlrYhxqIJCeU6a+IRIHkoFa17/ftiMhF8oMheg5TorTEdGIeJk/e0hQfPsO/o8gM9JjYU7futGf54w6X2x4A7Q0jInqqetSOCH8MP4BJwmVL10jW9JwmV0qfej9UKny3W1A==;5:SPmZKK3Oss24eHg17OCyvkjod8f465oMcz+4uODBPy5ytuwy2tXuVh4jx3YbNSSn8bljs5loL4wGS4fvFJtMtZWhKzoDGNS1COoYRTWR446KKEfRGNmeYTSJK5oc09aKyZr096R4eso2xTzDdu1tdhgfd5tSIbhj+J4/k5YKKx4=;7:qTky+LpGxVlN7EbzXXJAYLQUe//W0RQEmJ8xr/r3fce4lhokTYgFoS67M+PMRuyfQiznwEQAUz6FO/IL4RnYtwLmLsPqBOwfvI7JtckbjQl8A7mKzN2NfzagaV34HTf6qdmZo5d+YQAyGxV9WUJqDg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5881456a-db96-4af3-ead3-08d64a83876d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3609;
x-ms-traffictypediagnostic: MWHPR0601MB3609:
x-microsoft-antispam-prvs: <MWHPR0601MB3609E1A938144EB108AA2E51D3C30@MWHPR0601MB3609.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3609;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3609;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(136003)(366004)(346002)(396003)(189003)(199004)(6916009)(25786009)(229853002)(7736002)(106356001)(105586002)(81166006)(81156014)(8676002)(66066001)(316002)(36756003)(2906002)(8936002)(54906003)(71190400001)(71200400001)(256004)(68736007)(3846002)(6116002)(103116003)(6436002)(5640700003)(486006)(446003)(11346002)(39060400002)(2501003)(2616005)(476003)(6246003)(97736004)(5660300001)(4001150100001)(4326008)(6512007)(53936002)(478600001)(26005)(186003)(102836004)(6506007)(2900100001)(305945005)(6486002)(86362001)(2351001)(99286004)(76176011)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3609;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4/M1YJ5nr3E+8g71VhteXy07lVKMZFdSwhoJEqahMEPgCvp96FSjjMyRCHknCz2CgVN8BmIOvDLL9WPjIztCOKnK7XzNJA3rMjOH0oWM1kAJjqyWk96jDnRbKwwjPuflBxi77AT7Ce09wPPzThyOUD3inRhmpRQKDInrXLMS3biNr8js9qsaQMGMVssmsV9lTgp7OIcCem1DUEFsBXdxgnmSwOZEY+Ksj/4CKyAll1vV6m+LpgDY7/AJYrAPBuXzrkupEakihOsPMWdZkxfWouWWlIVfZupnFCmImqWKKbS3FxX1UfPZCGf8o63efVpO6eMYyY1tlzmiD6AnTtd3pxe+taWy/e+i1aw09k5Ej1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8927AB183938E14DA832C6D0770DB4A9@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5881456a-db96-4af3-ead3-08d64a83876d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 22:50:09.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3609
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDIyOjA3ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFdlZCwgMTQgTm92IDIwMTggMTg6Mjg6MDUgKzAwMDAsDQo+IFRyZW50IFBpZXBobyA8dHBp
ZXBob0BpbXBpbmouY29tPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBUaGUgbmV3IGRvbWFpbiBz
dHVmZiBkb2VzIG5vdCBhcHBlYXIgdG8gaW50ZWdyYXRlIGludG8gdGhlIGV4aXN0aW5nIGlycQ0K
PiA+IGZyYW1ld29yayBwZXJmZWN0bHkuICBNeSBpbnRlcnJ1cHQgaGFzIGNoYW5nZWQgZnJvbSBN
U0kgIzEgdG8gTVNJDQo+ID4gIzUyNDI4OC4gIE5vdCB0aGUgbW9zdCB1c2VyIGZyaWVuZGx5IG51
bWJlci4NCj4gDQo+IEl0IGlzIG5vdCBzdXBwb3NlZCB0byBiZSB1c2VyIGZyaWVuZGx5LiBJdCBp
cyBub3QgZXZlbiBzdXBwb3NlZCB0byBiZQ0KPiBpbnRlcnByZXRlZCBieSBhbnlvbmUuIEFuZCBp
ZiB5b3UgcHJpbnQgaXQgaW4gaGV4LCB5b3UnbGwgZmluZCB0aGF0IGl0DQo+ICppcyogYWN0dWFs
bHkgdXNlZnVsLg0KDQpUaGUgR1BDdjIgdmFsdWVzIG1hdGNoIHRob3NlIGluIHRoZSBkYXRhc2hl
ZXQuICBUaGlzIGlzIHZlcnkgaGFuZHkhDQoNCmRvbWFpbjogIDpzb2M6YWlwcy1idXNAMzA4MDAw
MDA6cGNpZUAzMzgwMDAwMC0zDQogaHdpcnE6ICAgMHg4MDAwMA0KIGNoaXA6ICAgIFBDSS1NU0kN
CiAgZmxhZ3M6ICAgMHgyMA0KICAgICAgICAgICAgIElSUUNISVBfT05FU0hPVF9TQUZFDQogcGFy
ZW50Og0KICAgIGRvbWFpbjogIDpzb2M6YWlwcy1idXNAMzA4MDAwMDA6cGNpZUAzMzgwMDAwMA0K
ICAgICBod2lycTogICAweDENCiAgICAgY2hpcDogICAgRFdQQ0ktTVNJDQogICAgICBmbGFnczog
ICAweDANCg0KSXQncyBub3QgY2xlYXIgdG8gbWUgd2hhdCB0aGVzZSB0d28gZG9tYWlucyBhcmUg
Zm9yLiAgUGVyaGFwcyBpZiBJIGhhZA0KbXVsdGlwbGUgYnVzc2VzIG9yIG11bHRpcGxlIHBvcnRz
IGl0IHdvdWxkIGJlLiAgSSdtIGFzc3VtaW5nIHRoZSBvZmZzZXQNCmlzIGJhc2VkIG9uIDIwNDgg
TVNJLVhzIHBlciBmdW5jdGlvbiwgOCBmdW5jdGlvbnMgcGVyIGRldmljZSwgYW5kIDMyDQpkZXZp
Y2VzIHBlciBidXMuICBTbyBwZXJoYXBzIHRoaXMgbWVhbnMgdGhpcyBpcyBNU0kgMCBvbiBidXMg
MSBvZiB0aGUNCmNvbnRyb2xsZXIu
