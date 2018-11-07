Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D72EC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214CF20862
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 20:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="botN1oVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214CF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeKHFtf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:49:35 -0500
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:26944
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbeKHFtf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 00:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bkgl8xhAkhTpd56fCfq6rugatqjYzm8p9AOw2UuL/g=;
 b=botN1oVDUtHX0xzIY1w+coV54MTRsZTsg8xFZ6fJjPiMQFYoEYly6GJnLrkLJ1irLBrE2o6oeAmdYkCiino9dLUTPN0mEW7HxL57P/zlPC+jIrcSF1QD45zmQ3j6egGfe1XXn6j1sj8acHxi0i9pLc3VbqXR95+QOL/FZ18V4R0=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3626.namprd06.prod.outlook.com (10.167.236.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 20:17:34 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 20:17:34 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgAASigCAAD2CgIABgdKAgAAa7IA=
Date:   Wed, 7 Nov 2018 20:17:34 +0000
Message-ID: <1541621853.30311.294.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
         <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
         <1541533217.30311.263.camel@impinj.com>
         <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
In-Reply-To: <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3626;6:EWaFBP2BbidbixuJYQBmMHGEy/IXg6pAG6bjF0SockqhEePXD50Qur5c5SCutU14uxEmf1SLpllL+fckSbjinSI52Gb/nq2U0I7IXvrndoJI9WhpOy4+gns7nGoIlrCAG0DD174u9+C0P6fPRNU2jb86Fq9r1JveMAMxTMD9T9pOGwGjvCqwXnq6mUHzrwgrtb5/+5AY+HQGs8UAXea34X/d8JrSflLDmXtnMlsYuHQTwF+Hdfjd7XqE3y0nSjtWkp9jWqZ/e4cWA0QSnNt7h7fBY2sgq9V1kvr5w4+JohumUl+XQbuW8LFJgLDXvSi+vkRDuPsyKzg3XvKKN6x0aGYUyxEFMUW68qszaolxTdRT06tEynMbGbxFEnhvy6WGq13eVwDW2JsgVjTbKrYXi6QweZW3d56gF/q9CVoBD+8fkXOVcbDh1kBz3+xNly5l9zpmrKeUjUIXODiUCmmufg==;5:esMPlI6muXiK38z+Ohw3Y3tR3wLMDZSjJf74nq8fqlvKOo+jDabtK0zio8/XVa5Q4NN4oc7NdMMe+Ekqj/Q8+WX83NcVjKCUqzbUs9VuQ2mqzjc//cTiKbORZIIyE4KiSeRHNY/03KrHFPjlekgMKOJLi0kzGekJmyVMnvcentY=;7:N13SrjcizABSYkp570FvMR3sMlkn+4gzF3RBoFD5AC+5sAf1QkUs4bgQbHnEZxuXn52a917bZyOvWxguncToF86URWwXqHkiigtoiAAEkL6Kb1MDDGUx96c9tg91OiSZ8EZio6NH+Qph/X5w16IF/A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d8d4dfc1-dbea-4574-153e-08d644ee0df5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3626;
x-ms-traffictypediagnostic: MWHPR0601MB3626:
x-microsoft-antispam-prvs: <MWHPR0601MB36268A126EC375FF213EE0F8D3C40@MWHPR0601MB3626.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3626;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3626;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(7416002)(97736004)(5660300001)(2616005)(14444005)(11346002)(71200400001)(2501003)(446003)(2900100001)(71190400001)(2906002)(103116003)(476003)(486006)(478600001)(256004)(86362001)(25786009)(7736002)(93886005)(305945005)(4326008)(68736007)(66066001)(316002)(54906003)(110136005)(229853002)(76176011)(8676002)(81156014)(81166006)(99286004)(6512007)(6506007)(53546011)(53936002)(8936002)(6486002)(6246003)(6116002)(3846002)(14454004)(186003)(106356001)(102836004)(105586002)(36756003)(39060400002)(26005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3626;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Dic8PHV9VJvFaH7mXrpfqAoAn7m5orXAIerbxtZuDyi42yEZQi6sTjEKPTe3LQTdnIxTN+rwWWZhrsjo6SCDWDvSJgoFu9uiUTimldVblxXAtIN93mMf3kGvySh2AG6RbP4RvpVMJOwKy/rFtZ1flRqQzeQOlMCccbvBVaIuL2VuD7yoR7VCZU2ceY9ekVV62RN6m1dKE+ZGhVQGyH/z0jdPyfhnZtLDhqXF9UPexBmNFWxK4cGLBHLjR/gv5K+sK5iih0trqnIj75FMGwrMFr0a7mZog9+BqozftiG9k09zQvKFaW/UkRN2tHBr59sfY/C7EVIhbpyZnWt3Db2+0POJmDqoc2yFTDv5mpj16dU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <332D6469EA55C44FA784BDBF2CEE42E6@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d4dfc1-dbea-4574-153e-08d644ee0df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 20:17:34.5643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3626
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDE4OjQxICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIDA2LzExLzE4IDE5OjQwLCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gDQo+ID4gV2hhdCBh
Ym91dCBzdGFibGUga2VybmVscyB0aGF0IGRvbid0IGhhdmUgdGhlIGhpZXJhcmNoaWNhbCBBUEk/
DQo+IA0KPiBNeSBnb2FsIGlzIHRvIGZpeCBtYWlubGluZSBmaXJzdC4gT25jZSB3ZSBoYXZlIHNv
bWV0aGluZyB0aGF0IHdvcmtzIG9uDQo+IG1haW5saW5lLCB3ZSBjYW4gbG9vayBhdCBwcm9wYWdh
dGluZyB0aGUgZml4IHRvIG90aGVyIHZlcnNpb25zLiBCdXQNCj4gbWFpbmxpbmUgYWx3YXlzIGNv
bWVzIGZpcnN0Lg0KDQpUaGlzIGlzIGEgcmVncmVzc2lvbiB0aGF0IHdlbnQgaW50byA0LjE0LiAg
V291bGRuJ3QgdGhlIGFwcHJvcHJpYXRlDQphY3Rpb24gZm9yIHRoZSBzdGFibGUgc2VyaWVzIGJl
IHRvIHVuZG8gdGhlIHJlZ3Jlc3Npb24/DQoNClRoZSBoaWVyYXJjaGljYWwgZGVzaWduIG1pZ2h0
IGFsbG93IHVubWFza2luZyB0aGUgaXJxIHRvIGJlIHBsYWNlZCBpbiBhDQpiZXR0ZXIgbG9jYXRp
b24uICBBbmQgbWF5YmUga25vd2luZyBob3cgdGhlIGhhcmR3YXJlIHdvcmtlZCB3b3VsZCBhbGxv
dw0KZm9yIGEgZGVzaWduIHRoYXQgbWFpbnRhaW5lZCBhIHNlcGFyYXRlIHBlbmRpbmcgYW5kIGFj
dGl2ZSBzdGF0ZSBpbg0KaGFyZHdhcmUsIHdpdGggZGlzdGluY3QgYWNrIGFuZCBlb2kgY29udHJv
bHMsIGkuZS4gYWxsb3dlZCBhbiBNU0kgdG8gYmUNCnF1ZXVlZCB3aGlsZSBzdGlsbCBtYXNrZWQu
ICBCdXQgdGhhdCBkb2Vzbid0IHNlZW0gbGlrZSB0aGUga2luZCBvZg0KZW5oYW5jZW1lbnQgdGhh
dCB3b3VsZCBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZS4NCg==
