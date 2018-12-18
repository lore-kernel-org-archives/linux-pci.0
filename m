Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CD4C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 23:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91221852
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 23:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="dkjvU17a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLRXHQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:07:16 -0500
Received: from mail-eopbgr790117.outbound.protection.outlook.com ([40.107.79.117]:34112
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbeLRXHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 18:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjguJvvcGbVCxUcSG3ZP0JI2mzlpjX8DZTNHUiY0zV0=;
 b=dkjvU17aa324ih4q0KKQzoiURg4nh+McRl55yjITF18137XKWAa500IxA1cwBHweYBRFSG8DRw4hLZy0cULz+vab+UdqA1a0MC7KsihvmE7XPQUOj9/Thko7RLCqpVyB6Ifi1a/X4leAJ8EGgmCAb2awmLFq34qK/itq7ysNLHk=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3634.namprd06.prod.outlook.com (52.132.101.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 23:06:34 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::841e:68c6:7e3a:3a3e]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::841e:68c6:7e3a:3a3e%5]) with mapi id 15.20.1425.021; Tue, 18 Dec 2018
 23:06:34 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thesven73@gmail.com" <thesven73@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Subject: Re: [RFC BUG] pci: Freescale i.MX6 PCIe controller: revert mainline
 regression
Thread-Topic: [RFC BUG] pci: Freescale i.MX6 PCIe controller: revert mainline
 regression
Thread-Index: AQHUlxVcQ1hHMeh4HkGhwy1xCQU5b6WFHneA
Date:   Tue, 18 Dec 2018 23:06:34 +0000
Message-ID: <1545174393.22930.65.camel@impinj.com>
References: <20181218210444.5950-1-TheSven73@googlemail.com>
In-Reply-To: <20181218210444.5950-1-TheSven73@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3634;6:NdKRsHUnP8uE9gMWDvYKE5OvYp6qUmxSB/FdzTF/epKaE2zlx2Ex28a8IuPBl2D3m3KEH4tbdfgyQOwwWikjX+PIoInxWqcgXp00vHOD0o5w1zL4xSNgItBTtp41NqHW9gNVzwDhOiJ5QC6WMnhDEuUZPeYIPfMzK6HI/PTx4oYg3+psUsrW+RV9xyCsp2uXr9qocIJKnCjW9RyJvlzw8a+IjBBj1joIy2rPwho2v6qHVbHMklWceDXBvNp7g6azQLrWCKaEutgc5LeEOM/7wjTP3rnVb7PoNyBWYNzsNqGFZKLllNXUrd5dKqzNmuW4/Hwbw20oDqBX9WG4MHWM9XoBwcGEuHos8NJxPgYnS/v74ZCWMHiB14F+nmCLQoxuGNO+XiErc3LBoS1oIQEjMkcQJZPo8NStS194GbFiIdvwjldEQLpRyxeBT7F1resF7BiYxuhL5kkGmw2ZvyK/YQ==;5:NO77xGdh/zG9EPbBT9oMx6SG+yyxrFExPnZVV1k/X6cdhURGpsWOZDKj2Lj4kwiWwX2SSsDT9+F31p/nLsJNyDKZqcpItPY49PPgB3nhHJbH0iKJ3h3iIsgEV5sjXvDjL8KSmkFuxrontXC4ZGmUo2VkeSS3YxRzq70/K1H8EC8=;7:p2UpaiQqn1LcKsu9QWsUT+J1YdzcE5OLJE4xZi6EjLgKF/qXSy/X1MqwSGiJKSi8yoO+P2b2EJuRA3mUawGHU9fmzQqIcusw1RX6HmXjNurmSoKcyGh58HF5rzU0FhlBzjeF6L8n6VTVo9LnIMdk8A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be10ec99-ea2a-41b4-04ab-08d6653d74af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3634;
x-ms-traffictypediagnostic: CY4PR0601MB3634:
x-microsoft-antispam-prvs: <CY4PR0601MB363480CD3DA4282C84B66D1BD3BD0@CY4PR0601MB3634.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3634;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3634;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39850400004)(396003)(346002)(189003)(199004)(6436002)(39060400002)(575784001)(5660300001)(3846002)(86362001)(6116002)(6486002)(97736004)(7416002)(229853002)(76176011)(2501003)(4001150100001)(2616005)(2906002)(53936002)(446003)(11346002)(486006)(54906003)(110136005)(6246003)(68736007)(4326008)(7736002)(81166006)(305945005)(81156014)(8936002)(8676002)(476003)(2201001)(105586002)(25786009)(106356001)(99286004)(14454004)(316002)(6512007)(103116003)(478600001)(36756003)(102836004)(71190400001)(26005)(71200400001)(256004)(66066001)(6506007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3634;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lmaFDBJP0w4yJJ45rgEyjD7zGVaU+6X5I/1U6+xcpo908DiladwN88bayQlCfnJJarILgPmOk4C+S/m8QaCz2smgCrG5nq2sb0CFcKlGz59hdSYUtQl0qlmuH4sbfRgZ9cUw8dZU4KLo473YNHbIFJQm54oJYbnAbCLWwP7WrdeIOUje8Wi5hQLCEfzYW00KbCA47jNNlrNPY12f937lwzAhmxJuXIuSETRutyEjAyNdspevEK+OKI1rN3eaqaW2N4kVOMGDIB5SsGqGyNrRZlNlR/YBtkiMyEefcYkW/xGWt2xc+2WX1xveiHzPNOdd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <587E574A1605B94B8DBCB16243576998@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be10ec99-ea2a-41b4-04ab-08d6653d74af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 23:06:34.2940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3634
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTEyLTE4IGF0IDE2OjA0IC0wNTAwLCBTdmVuIFZhbiBBc2Jyb2VjayB3cm90
ZToNCj4gV2UgYXJlIHVzaW5nIGEgQnJvYWRjb20gQkNNNTc3ODAgZXRoZXJuZXQgYWRhcHRlciAo
VGlnb24zKSBjb25uZWN0ZWQNCj4gdG8gYSBpLk1YNiBQQ0llIGNvbnRyb2xsZXIuIE9uIGEgRnJl
ZXNjYWxlIGkuTVg2IFNvQy4NCj4gDQo+IFRoaXMgY29tYm8gd29ya2VkIG9rIG9uIG1haW5saW5l
IHY0LjE3Lg0KPiBPbiBtYWlubGluZSB2NC4xOC1yYzEsIGEgcmVncmVzc2lvbiB3YXMgaW50cm9k
dWNlZCB0aGF0IGNhdXNlZCBhIGNyYXNoLg0KPiBUaGlzIHJlZ3Jlc3Npb24gaXMgc3RpbGwgcHJl
c2VudCBpbiBjdXJyZW50IG1haW5saW5lIGFzIG9mIHY0LjIwLXJjNw0KPiANCj4gQmlzZWN0ZWQg
dGhlIHJlZ3Jlc3Npb24gdG8gdGhlIGZvbGxvd2luZyBtZXJnZSBoZWFkOg0KPiBjb21taXQgMGVj
ZGEzYTA4NzQ2ICgiTWVyZ2UgYnJhbmNoICdwY2kva2NvbmZpZyciKQ0KPiBXaGVuIHRoaXMgbWVy
Z2UgaGVhZCBpcyByZW1vdmVkLCB0aGUgcmVncmVzc2lvbiBkaXNhcHBlYXJzLiBUaGlzIGNvbW1p
dA0KPiByZXZlcnRzIHRoZSBjaGFuZ2VzIGludHJvZHVjZWQgYnkgdGhlIG9mZmVuZGluZyBtZXJn
ZSBoZWFkLg0KDQpJdCdzIGFjdHVhbGx5IGNvbW1pdCBmM2ZkZmM0YWMzYTIgKCJQQ0k6IFJlbW92
ZSBob3N0IGRyaXZlciBLY29uZmlnDQpzZWxlY3Rpb24gb2YgQ09ORklHX1BDSUVQT1JUQlVTIikg
dGhhdCBtYWRlIHRoaXMgcHJvYmxlbSBhcHBhcmVudC4NCg0KQnV0IHRoZSByZWFsIGJ1ZyBpcyBu
b3QgaW4gdGhhdCBjb21taXQsIGJ1dCBhIHByb2JsZW0gd2l0aCBpbXg2Lzcgbm90DQpjb25maWd1
cmluZyBhIHNldHRpbmcgaW4gdGhlIFJDIGNvcnJlY3RseSB3aXRob3V0IHBjaWVwb3J0YnVzLCB3
aGljaA0Kc2hvdWxkIG5vdCBiZSBuZWNlc3NhcnkuDQoNClNlZSAiW3Y0XSBQQ0k6IGlteDogbWFr
ZSBtc2kgd29yayB3aXRob3V0IENPTkZJR19QQ0lFUE9SVEJVUz15IiBieQ0KUmljaGFyZCBaaHUg
Zm9yIGEgcmVhbCBmaXguDQoNClRoZXJlIGFub3RoZXIgYnVnIHRoYXQgbWFrZXMgdGhpcyBkcml2
ZXIgc29tZXRpbWVzIGxvc2UgYW4gTVNJLCBidXQNCnRoYXQgcmVncmVzc2lvbiB3YXMgaW4gdjQu
MTQgYW5kIHdvdWxkIG5vdCBiZSBmaXhlZCBieSB5b3VyIHBhdGNoLCBzbw0KdGhpcyB0aWdvbjMg
cHJvYmxlbSBpcyBhbG1vc3QgY2VydGFpbmx5IGNhdXNlZCBieSB0aGUgcHJldmlvdXNseQ0KbWVu
dGlvbmVkIGlzc3VlIHdpdGggcGNpZXBvcnRidXMuDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvS2NvbmZpZyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZw0K
PiBpbmRleCA2NjcxOTQ2ZGJmNjYuLjZlNDI0MWFjMGExZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
S2NvbmZpZw0KPiBAQCAtMTEzLDYgKzExMyw3IEBAIGNvbmZpZyBQQ0lfWEdFTkUNCj4gIAlib29s
ICJYLUdlbmUgUENJZSBjb250cm9sbGVyIg0KPiAgCWRlcGVuZHMgb24gQVJNNjQgfHwgQ09NUElM
RV9URVNUDQo+ICAJZGVwZW5kcyBvbiBPRiB8fCAoQUNQSSAmJiBQQ0lfUVVJUktTKQ0KPiArCXNl
bGVjdCBQQ0lFUE9SVEJVUw0KPiAgCWhlbHANCj4gIAkgIFNheSBZIGhlcmUgaWYgeW91IHdhbnQg
aW50ZXJuYWwgUENJIHN1cHBvcnQgb24gQVBNIFgtR2VuZSBTb0MuDQo+IA==
