Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED98C64EBC
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A420877
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 20:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ED+03DbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4A420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeJEDg2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:36:28 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:22656
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727519AbeJEDg1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 23:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoWitckSZ5+OpX9fVF8EkBPyGN3aTibHx9d5GB9YmLI=;
 b=ED+03DbQS503zEOGZmEvNIcuMCabBrFFtxtPlcf7I//7BbAPAKfxBoVj3wB4BKX3B6V1jJZmjo6BuP7FXPw/SgJh7nzI7IDEyF+u+SIAvicDizf/5Yxe/vJlNJojT0ATsMuqTlIQgCutly1wvW8DdwfDMPRxcOqkwJnS54Y1mCE=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5042.eurprd04.prod.outlook.com (20.177.40.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.22; Thu, 4 Oct 2018 20:41:23 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 20:41:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Thread-Topic: [PATCH v2 1/4] reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
Thread-Index: AQHUXAAcrEeeoawteEW641mP0pOSYaUPS76AgAAF3wCAADuWAA==
Date:   Thu, 4 Oct 2018 20:41:22 +0000
Message-ID: <e3d21879316c291966be650e52afa64c219928b5.camel@nxp.com>
References: <cover.1538670431.git.leonard.crestez@nxp.com>
         <c3a7dfd1395b12e170393a3da77e0d1602b9f542.1538670431.git.leonard.crestez@nxp.com>
         <1538671621.14153.20.camel@pengutronix.de>
         <20181004170802.GA12234@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181004170802.GA12234@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5042;6:uZ8gAUMyi52lb5w4YdBoXRRvgrx9aoC32EdDMP3CaCi9c+fxGnTQcU28H30lEJa8JzuhWlolzAt8qBjk4/o0JOcQ3k/jvl8k5NRDZx0g1DoXdOneJ6+pNjPC/ogvnBT9DmBAgyLVWqvAuFuB95EV/DpzlhNeLT6NTJElZVdtHm8xyEGfbuD0Q9ItulDfTx3CnLTcCGjUXpP6lfPgPwXJgC4vquO7wM41/I72KwHZlYC+m3DRGcTaKhdqe45MsQwODSbXtzpRmvTsq0kruYnWCb666HBAw8YT8iOLN80Rk6QBHcJG1jqIiRhuVkmkXP733HC+l7J956KZl6zuKGk5szVu45MMK4tZE5gM1TjSV9kbDw3UgXuGWQkas4ixa+CzZtwVQQoGXm1AO70j7i+8bKosoPKn0SqYPEEcD6fyyPG4FVAfVe5q0CXkxNcGwV60N0H7EeTCHhVt9TvlXFHV0A==;5:AoNqmPj5ZQQeOM8Ne+jBeGdVhv43sw6teYa2qz/245SWkr20r6XmUQT/UczOgQealWX3oM7C6QrGiBW3a8f3xyIVyUNExwkM8JAvI9KLbev1fGXQRB0u3UVL5sfCX6M4WwZ1lSXSrYFgHXv8xhopDzLGYACvETPiQggfOy3dH8I=;7:HiNXrW4x9dhc0T51C8RUvhZG8aPJFmd8puZ/AyrqMkrXYU3taBbhAbbXoTyZsebHD/+HVXJ+3mocuaQUx5Xe0MllrgRKdCKm91l9QsNvvYMMflVdgEupoXumR8LTL/YL/VnfBZYUxaCC8PWKIU+VI6CZGD7xuh4NazMovNL3lfmVs2mMr/UxDJK7MyAgEzak5jwMWLJsf8QN+cyEZxvd5j4JFdCREGo5Ns2shzjKW2i8qEKxSHJyzQCAI6rjGVds
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0b872bc9-eb1f-4ec3-53f0-08d62a39bf4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5042;
x-ms-traffictypediagnostic: AM0PR04MB5042:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB5042FD2DABDA3D65F11E5361EEEA0@AM0PR04MB5042.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991048);SRVR:AM0PR04MB5042;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5042;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(39060400002)(186003)(4326008)(25786009)(6246003)(305945005)(478600001)(966005)(66066001)(97736004)(486006)(446003)(93886005)(106356001)(105586002)(44832011)(5660300001)(99286004)(2201001)(102836004)(76176011)(7416002)(11346002)(256004)(86362001)(54906003)(6506007)(26005)(110136005)(7736002)(36756003)(476003)(2616005)(53936002)(71190400001)(2906002)(71200400001)(316002)(81166006)(6306002)(50226002)(68736007)(8936002)(8676002)(3846002)(81156014)(6512007)(6116002)(2900100001)(118296001)(6436002)(14454004)(229853002)(5250100002)(2501003)(6486002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5042;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /L6NVJzukJ7pH0WbIsfPV4KaGcEWpI49586p7GuWjFC5//Op0oHUBqqjVw4pAZ90SzGGCV2V4gisX90ZMz+dPI85hGFAjjc+4kjjwAuQoNC/4mDdmDwkvBB1+fHk6YkwZDw50x6Q2dKVcor0JJ1VF7X2t/dNFBvJ5ShOJv2AyQGCMPzi38r31jq/AQrkZwPcH9Txh3fmyRm8W9dQAwnr4zQnv2qYyrwQi1+rAL9fQnHr8oEn1tXmBmmugPwki4eUp4P7J5ySdo7R4ebCY+Mop+dZtEpGWW/o2J74vxJ7AEw4BYPeHQFkRJk7BFu6nSuJIECh+SZwQAqULM0wZfzGx2gAh29XHxsj3cFoYDnadxk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <65DADA1E6377054EA2C7A4AD4E84C9BB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b872bc9-eb1f-4ec3-53f0-08d62a39bf4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 20:41:22.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5042
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTA0IGF0IDE4OjA4ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBPY3QgMDQsIDIwMTggYXQgMDY6NDc6MDFQTSArMDIwMCwgUGhpbGlwcCBa
YWJlbCB3cm90ZToNCg0KPiA+IFRoaXMgaXMgY29udGFpbmVkIGVub3VnaCB0byBiZSBtZXJnZWQg
d2l0aCB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzLA0KPiA+IHBhdGNoZXMgMSBhbmQgMjoNCj4gPiAN
Cj4gPiBBY2tlZC1ieTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4g
PiANCj4gPiBMZXQgbWUga25vdyBpZiBJIHNob3VsZCBwaWNrIHRoZW0gdXAgaW5zdGVhZC4NCj4g
DQo+IEkgY2FuIHRha2UgdGhlIHdob2xlIHNlcmllcyBidXQgSSB3b3VsZCBsaWtlIHRvIGhhdmUg
aXQgcmViYXNlZCBhZ2FpbnN0DQo+IHY0LjE5LXJjNCBwbGVhc2Ugc2luY2UgaXQgZG9lcyBub3Qg
YXBwbHkgYXMgaXQgaXMsIHRoYW5rcy4NCg0KU2VyaWVzIGlzIGZyb20gYSBicmFuY2ggb24gdG9w
IG9mIG5leHQtMjAxODEwMDQgKyBhIGZldyBvdGhlciBjaGFuZ2VzDQpidXQgaXQgYXBwbGllZCBp
dCBvbiB0b3Agb2YgeW91ciBwY2kvZHdjIGJyYW5jaCB3aXRoIG5vIGNvbmZsaWN0cy4NCg0KUHVz
aGVkIHRoZSBicmFuY2ggaGVyZToNCg0KaHR0cHM6Ly9naXRodWIuY29tL2NkbGVvbmFyZC9saW51
eC9jb21taXRzL2lteF9wY2lfZm9yX2xvcmVuem8NCg0KQXNzdW1pbmcgeW91IHdhbnQgb24gdG9w
IG9mIHRoaXM6DQoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2xwaWVyYWxpc2kvcGNpLmdpdC9sb2cvP2g9cGNpL2R3Yw0KDQotLQ0KUmVnYXJkcywNCkxl
b25hcmQNCg==
