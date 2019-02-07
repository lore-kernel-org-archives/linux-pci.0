Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8AFC282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18EE2175B
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="cjOauXBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfBGSP5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:15:57 -0500
Received: from mail-eopbgr820129.outbound.protection.outlook.com ([40.107.82.129]:47719
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfBGSP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 13:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BerJN4BUCpKiYutBjMwenT9jGy+xfr6fVpz5HFZQsaY=;
 b=cjOauXBsK2kqS2OHKxvN1EP0pRWluSCs7jNKhdNfFeUwC4tJ497/b37Xg7vk+1j1/c6yFGGDsnevk1/khMjAcn1Xda1crQYP8yEjUwNIrq4VUjF6k6lGblWy8iOslzuECBueGa5mr91kkf+N2oFpMMXpYO0u5w4nssfCUhiLAYE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3675.namprd06.prod.outlook.com (10.167.236.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 18:15:52 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 18:15:52 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Topic: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Index: AQHUvOg1I9SIwv2NIEC65G+x/YIYY6XUSEwAgABgM4A=
Date:   Thu, 7 Feb 2019 18:15:52 +0000
Message-ID: <1549563351.3075.49.camel@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
         <20190205001721.18639-4-tpiepho@impinj.com>
         <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3675;6:oQBw5aoTaxgGHMQQu4wNF6OpfYoz7sFEDygc8c4YdaFDctan1wUCKFCefBbEdKZxBpww8nO2LgY9AADbvngfpHoK1gs1JTyO/EuomqaGCfsH2y6UCb0K6knc6FNqh/AFL7VhIekD5hYtFDXkjsJz80V+WlI1GtTAfBiX5Z61RRkXHdU31FU41VdxIWqe+NyGdj3npFwpHszzavIicYgYsXpsOQB6L0Cbsa5ls0McbipzJMYch2rMfmjahvx5FO4hWPNhwhdRMe7pPfLJem/DHJMmuUKKb8x8vtPGhg68iAs/7Seq3C7Ivb2x/ahS7ZzhRJGG+OADiX+Lh0CPWhZgGLO1g0VgwrUwSr/num5cmjtzuPKp6Y6ida+Lq23Ag/nWDtuIoyf1yzNPN6j3YgEbbifJHCrICfCkwwP4Y8+mENpioRiI6MuLZmwx7M30iGYH5A1jdUkHPnaalX3334Oaqw==;5:cL7Y88C7hvYKKU49NP6mOn7hWtn3i4AE/1FLePUAr70hq/zAFbPI2ZITouIQF9XrrhaK4gKq9GwfVnODDUUELczEyDP51jvI4qp+xKrxJ9fKKvVWdXIn71sjc9jezoHhov6/TVZxg394eGtna7zdXKRpr4GboRvHTv3OKX5vTSEz5YkZALX5dSyJ3388KB+cn866UqcRXsUblC2Qu0M8WQ==;7:HH6L6pj3AC/Bdoi/wpxOzmkooLC/66tAWKBpELxB6njVXoTH3MlHe5d06FypaklJbBc4eh76J/8z6ai1pK0HjUubu26nSpfhWxgh8UDIj5BBfQk/lkEFPr21AQJetkHGZIJDlOFrk3Rg21ymRIr08g==
x-ms-office365-filtering-correlation-id: b258832b-1e48-43cd-573b-08d68d284bc5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3675;
x-ms-traffictypediagnostic: MWHPR0601MB3675:
x-microsoft-antispam-prvs: <MWHPR0601MB3675E910BBE4B2A2513A035CD3680@MWHPR0601MB3675.namprd06.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39850400004)(396003)(199004)(189003)(4744005)(6486002)(2501003)(316002)(229853002)(14454004)(6436002)(5640700003)(6512007)(7736002)(6246003)(2906002)(53936002)(305945005)(6116002)(8676002)(81166006)(81156014)(3846002)(97736004)(54906003)(76176011)(14444005)(68736007)(4326008)(256004)(478600001)(8936002)(99286004)(25786009)(476003)(36756003)(105586002)(2616005)(86362001)(6506007)(106356001)(186003)(11346002)(71200400001)(71190400001)(103116003)(446003)(486006)(26005)(6916009)(2351001)(102836004)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3675;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LOExDB2iArfSpxmL3wnwBhwH0DWPcZ5Gpr/a/ckBTywKRWY0EjFs41I07ethVCIdRpEPR6nl0MYO5VGQIga2PR5nxPqZ4f+kEbYOIuT5KsEdDHZvfnY9My0tltRl+mvjB28T3e84RaBaKJs3aGM6VRmvaKc6oByvU5NjVcZB4mhDr0ahsOaK5oRpTDMUHMEIU+9L5AE17qqv46oBPxpHXihih4LgQjd0gDuY+gWDyo9KABEPe3BEY31c60e68ZoW+pI+IRfNcxVfM0TTtCFu67Ir7x5L9QIEWpLRZQE0Yp4qDurt4S7Og7hoGV7FB3hsBtaElhDs5oqi5ufyr2/TIn51PwiWqrzn1LK4V8M26T1LjjCpQW9xK3bJLzV5M+wdywJd+kvAPgTsZmbLRb0BBtOm8AQU9IjdkxZOtk5WV0k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4EE99FA33ACB24EA8EF08725ECB446D@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b258832b-1e48-43cd-573b-08d68d284bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 18:15:52.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3675
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTA3IGF0IDEyOjMxICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gKwkJCS8qIERlLWFzc2VydCBEQ0NfRkJfRU4gKi8NCj4gPiArCQkJd3JpdGVsKFBDSUVf
UEhZX0NNTl9SRUc0X0RDQ19GQl9FTiwNCj4gPiArCQkJICAgICAgIGlteDZfcGNpZS0+cGh5X2Jh
c2UgKyBQQ0lFX1BIWV9DTU5fUkVHNCk7DQo+ID4gKwkJCS8qIEFzc2VydCBSWF9FUVMgYW5kIFJY
X0VRU19TRUwgKi8NCj4gPiArCQkJd3JpdGVsKFBDSUVfUEhZX0NNTl9SRUcyNF9SWF9FUV9TRUwN
Cj4gPiArCQkJCXwgUENJRV9QSFlfQ01OX1JFRzI0X1JYX0VRLA0KPiA+ICsJCQkgICAgICAgaW14
Nl9wY2llLT5waHlfYmFzZSArIFBDSUVfUEhZX0NNTl9SRUcyNCk7DQo+ID4gKwkJCS8qIEFzc2Vy
dCBBVFRfTU9ERSAqLw0KPiA+ICsJCQl3cml0ZWwoUENJRV9QSFlfQ01OX1JFRzI2X0FUVF9NT0RF
LA0KPiA+ICsJCQkgICAgICAgaW14Nl9wY2llLT5waHlfYmFzZSArIFBDSUVfUEhZX0NNTl9SRUcy
Nik7DQo+ID4gKwkJfSBlbHNlIHsNCj4gPiArCQkJZGV2X3dhcm4oZGV2LCAiRFQgbGFja3MgaW14
N2QtcGNpZS1waHksIHVuYWJsZSB0byBhcHBseSBFUlIwMTA3Mjggd29ya2Fyb3VuZFxuIik7DQo+
IA0KPiBJdCBpcyBhIG5pdCBidXQgdGhlIHdhcm5pbmcgbG9nIGlzIG5vdCBuZWNlc3NhcmlseSB0
cnVlIGllIHlvdSBtYXkgbm90DQo+IGhhdmUgYSBtYXBwZWQgYWRkcmVzcyBmb3Igb3RoZXIgcmVh
c29ucyBhcyB3ZWxsLiBJdCBpcyB1cCB0byB5b3UgYnV0IEkNCj4gd291bGQgY2hhbmdlIHRoZSBs
b2cgbWVzc2FnZS4NCg0KVHJ1ZSwgYnV0IEkgaGFyZGx5IHdhbnQgdG8gZW51bWVyYXRlIGV2ZXJ5
IHBvc3NpYmxlIGZhaWx1cmUgcG9pbnQgaW4gYQ0KbG9nIG1lc3NhZ2UuICBIb3cgYWJvdXQ6DQoN
ClVuYWJsZSB0byBhcHBseSBFUlIwMTA3Mjggd29ya2Fyb3VuZC4gIERUIGxhY2tzIGlteDdkLXBj
aWUtcGh5Pw0K
