Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F1C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82471208E7
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="ZgRuhQg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82471208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeLJTGf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:06:35 -0500
Received: from mail-eopbgr660096.outbound.protection.outlook.com ([40.107.66.96]:54272
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeLJTGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 14:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1cL6n0IqwGouk6MJg2uJVW4aDnWiOU07zymNzuuymw=;
 b=ZgRuhQg93N3yO9MRq9ts0jMs6HgHvob2RINCA9G7AWuWDrGCiWiejAc3AwzN28RXADZnZdWBeSSVJQD9J4Jw65jbXbKvDhYokC25ah37OAnwT8cgqSaGtT5Sni4T4YxH3Fb/AF7fWxhsxStrFSgw21iqKtu6/TX8Yi9By1FMbtw=
Received: from YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM (52.132.75.145) by
 YQXPR0101MB2149.CANPRD01.PROD.OUTLOOK.COM (52.132.79.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Mon, 10 Dec 2018 19:06:33 +0000
Received: from YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c111:9a62:7f65:cb1e]) by YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c111:9a62:7f65:cb1e%5]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:06:33 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Eric Wehage <Eric.Wehage@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
Thread-Topic: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
Thread-Index: AQHUkKyZHb1lpC0XKU+LZgGbMby6daV4Q5iAgAAQgAD//4wiAA==
Date:   Mon, 10 Dec 2018 19:06:32 +0000
Message-ID: <3D0DC4F7-ACF1-4CE9-854A-61ACE66D3895@raithlin.com>
References: <20181210115653.0000615a@huawei.com>
 <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
 <DD8FB053C05D2D4DB8AA6C933261787859975862@sjceml521-mbs.china.huawei.com>
 <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
In-Reply-To: <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.14.0.181202
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YQXPR0101MB2149;6:X4PcVG9As9ilf+R17ggKwq/H+4z7tYgiwGxVr7Nfu9gEmIg5F0cQi1BwRDnUQd87mNam//jqXNkRaiyhb3R3ndrjsiYTwyVCAnjquQo3g8ivMw1WwSdf0/36DbSBvSYEmnIIWE8NRIXao0nrskC2JudZmiBjUV8x9/Et/NzMyxSAk2r48cMIXeBc7MmpCpsRa3+qQAxTUQmVtcK5CP1CQXkNZ2vk6r/0qqBRo8A2zN+Uo2I1Mi7617lBQ/91mK7lw8Ys7JxKB2beGR6LbMk3S2LCkL2HfY41VDxb5eh5byQXQEQ7U1Irr65UTRZbMr6vm+mkGa+Taz2i7k/+f3bt0IeJ2m5V1C2eMbWbuE1OfJsYWCxJx3AXsai/5P1ARNS14LqsnWcXSY/96VPj8vVuqZZm7uCuLkB7GsStnHoe4aynPUqY/yC9vDeW0lIzNH0/+GCtyWCBxnAlySCTnqlOnQ==;5:rowAkmdRvw7TOQJd4tyjs4DkAQiFqpnV7w16YMWl1uLSx+TJq4yNWI2xp6kqxe+aYkPgOZtgF4eX+mZclce/9QER/+qtrGhR1JrHpN35rtRE/EMBEwW91CDEF9apAEIxKnSSkxhzPgKQUTp/oN3U+7dxCSrrDPunwZcJQUkLN5Q=;7:CeyYv9QUG02vESq5A858qHwY3wxiUVOEL8J5rpsHzGWglkElbLjXGaUG+VXdFylQhM1LTN0ez9YB6qZ4SDaY4YbsOZPrRNVbE3egFJzKRTc97PdIMYS1nHGqWtk2aa8O+75cSus0VDyd0QXo2EhqnQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c770a6d1-cd87-4958-228e-08d65ed29975
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(4534185)(7022145)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:YQXPR0101MB2149;
x-ms-traffictypediagnostic: YQXPR0101MB2149:
x-microsoft-antispam-prvs: <YQXPR0101MB214955EF26135615396D4A14AAA50@YQXPR0101MB2149.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:YQXPR0101MB2149;BCL:0;PCL:0;RULEID:;SRVR:YQXPR0101MB2149;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39830400003)(189003)(199004)(82746002)(186003)(25786009)(99286004)(58126008)(305945005)(76176011)(6512007)(71190400001)(71200400001)(110136005)(6506007)(7736002)(6246003)(4326008)(81156014)(36756003)(5660300001)(93886005)(8676002)(14454004)(53936002)(316002)(81166006)(54906003)(508600001)(217873002)(106356001)(68736007)(11346002)(476003)(6436002)(345774005)(66066001)(256004)(105586002)(486006)(26005)(3846002)(97736004)(83716004)(8936002)(102836004)(6486002)(2906002)(33656002)(229853002)(6116002)(86362001)(2501003)(2616005)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:YQXPR0101MB2149;H:YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /WrqY5QktOJPYbWuZ+LhQ3kWvPWH0CSAM8p9qf9KuPvIrHzniz4AN3qYliJdGzqQlb2RTQH5TGYcSJ2dsNXkF+Bla9fly7Fm0S0svqC0JrPK07YcuJ1qG5YkGEc+nhDNtuY1LBVYFYwx8zZQwYyn0D3ikmDJZfWd3C7Bw/4tp1Ak11bCnMZ1zv6Gix2sA3sN+87vzWzLzWyOJcDKH2B2/0phfwt/ICdhjaH4+vDUbP9P3E6G7AjPeq9/OWCIdi19PB7e31fB1WaoWboaqBaW8ZVU+b7vQekKXrDJKlVeiOQw0AZqYIDfzJPZXb6uh5C4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A05CAECC59818047B39DF57D82878AB3@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c770a6d1-cd87-4958-228e-08d65ed29975
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:06:32.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB2149
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgRXJpYy9Kb25hdGhhbg0KDQpJJ2QgYWxzbyBsaWtlIHRvIHRoYW5rIHlvdSBmb3IgdGFraW5n
IHRoaXMgd29yayBvbi4NCg0KPiBIb3dldmVyLCBpZiB5b3Ugc2VlIGEgcGFydGljdWxhciB3YXkg
dGhhdCB0aGlzIGlzc3VlIGNvdWxkIGJlIGFwcHJvYWNoZWQsIEkgYW0gc3RpbGwgDQo+IHdpbGxp
bmcgdG8gY29uc2lkZXIgYSBjaGFuZ2UuDQoNCkkgd291bGQgZWNobyBMb2dhbidzIHNlbnRpbWVu
dHMgdGhhdCBhIHNpbXBsZSBCb29sZWFuIHRvIGluZGljYXRlIHRoZSBwMnAgcGVyZm9ybWFuY2Ug
YmV0d2VlbiBSUHMgaXMgY29tcGFyYWJsZSAob3IgYmV0dGVyKSB0aGFuIFJQPC0+RFJBTSBwZXJm
b3JtYW5jZSBvciBub3Qgd291bGQgYmUgdXNlZnVsIGFuZCBzdWZmaWNpZW50LiBJdCBtaWdodCBi
ZSB1c2VmdWwgdG8gYXQgbGVhc3QgYWRkIHN1Y2ggYSBmaWVsZCB0byB0aGUgRUNSIHNvIGl0IGNh
biBiZSBkaXNjdXNzZWQgd2l0aGluIFBDSS1TSUcuDQoNCkNoZWVycw0KIA0KU3RlcGhlbg0KIA0K
DQo=
