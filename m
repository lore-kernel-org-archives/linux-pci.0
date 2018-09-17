Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B1BECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 16:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EE52098A
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G0xVQtph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EE52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeIQVaE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:30:04 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:46089
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeIQVaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 17:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0TyOaU7ineebN+zlWsWMGtRKyZ/92rlp3BnfXtCRo8=;
 b=G0xVQtphhImAQr0f9VK9QmeKtHsGA+hGlzqpOs0tl7GFSbtST98Qbm8Nl6TKMcoj8x4eP0cjKoI9QFDMJZXndcbGTOXCHlFj25Nf+JzckeyPlsPudgpkU4fs/260Z39sG5cB24FVA38rUL/wz6e2svro6Cv7qsKIMrHHnugEfRA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4692.eurprd04.prod.outlook.com (20.176.214.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 16:01:21 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 16:01:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Thread-Topic: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Thread-Index: AQHUM+76K2DBZY0BEEaUopztAS8XkaT0yQyAgAAOaIA=
Date:   Mon, 17 Sep 2018 16:01:21 +0000
Message-ID: <16d68541fd499dfda88e79d4386be7ad6d0919d9.camel@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
         <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4692;6:ojSIGP13mvDfNJr3pjGi2jcd+lmuyqlGy8ZXnL+sqb/SLTUeDNux8bqslcGYk9W8mp7v8Ofp8Y14RnHcXEvzJyk4kfgHK3K5ltYvFKW2RmRlYwAPmB2jmQeWHSJ/7OxaEA2dg1Eo78u8JlbqjWDOsdkaNaA7BOyNxkRoT4v/1IdXZ57ENrLaGVqRRLQw6iqz3SAYZtOYBG8IREAeImE7Z9/OqWABEmP2plLWgJDKY1CUojRYE59jyBRxrIc0W1R95PaYtorULPAvu3CKBvO+g4iHgPia4bxKi+rLyzJ0kjYcdiEUOI/YEhcZ4iidJ4OnXzwO+pLB8zCmcSaxPLqXJqS9vt5+aWtA2N5zxMHbHTELKWq6IZQv3vm6f3dwUX4jtvABaKEl6wv/4nrNJ1HdzUGF8r8eUCBS/9pFH5+w7eQNq7sEXidRMV96g6XJndqC+XE1HqXHQRU9/V+ZlXs3kA==;5:2u8ODbPFtOthzEvsDwOZ/omnsKC3wjzww9Q8FBMmaIaLzt+Kd7F4/PaifywU+grVSH5tFvYXELa75dn84xcNHHvFbb0dKoHsAuUvtHSfxRt7zScYFf97oAEydM0Xo/BbYVpcddT2cphBH4OuB4J+UmlKHID56E3rUtL6dUHBQqg=;7:AzL3z1octF83WE8qsxeZoWSItkJXvJAelEGKIXn0jihbcvgwV9Y806RgRShVbyCxrjLS67CbVHX2lWD6Fwc9jQOL5Q/qpjYrLXtqDMSgFtiB13kNOknULX+LlCu+A8ao44cnKS/hoRe8Mug97UnK/ki6gIf+N0uNj92UGDlF12TSKc+UeBvN25jMb10wQWk1KCEgmM5xr4FxyIvcOvAeP24rXe4k7hvagUmVwKvVVYBABUijr5j4LDYgd+tJc73X
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: edd528c8-5a05-48c7-f1b5-08d61cb6cfe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4692;
x-ms-traffictypediagnostic: AM0PR04MB4692:
x-microsoft-antispam-prvs: <AM0PR04MB46926459C86ACB5E9287FCC6EE1E0@AM0PR04MB4692.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:AM0PR04MB4692;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4692;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(50226002)(478600001)(118296001)(99286004)(186003)(76176011)(14454004)(6506007)(3846002)(102836004)(316002)(54906003)(25786009)(81166006)(2900100001)(106356001)(229853002)(81156014)(110136005)(26005)(6116002)(8936002)(4326008)(36756003)(305945005)(6486002)(6436002)(14444005)(5660300001)(8676002)(256004)(105586002)(44832011)(2201001)(53936002)(7416002)(66066001)(2906002)(6512007)(486006)(68736007)(97736004)(2501003)(11346002)(446003)(2616005)(5250100002)(476003)(86362001)(39060400002)(6246003)(7736002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4692;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mRv4lIsMxbW+B3dGS1Oli95dwWaHe6PuG8u4JYi6GU1NGTG5WuRHswW/QvJ7rLRWBS3ivXBvlHZbnah4sFwRu4VIUvi4VJdy5i1U1N8fxeaARNoKIie7zOZYdomffTy2UsEhL8BEm2Ag3Eb2KIWFza7KxD7GzJVg1cvjmt1BijiQXHRJRrDN7kaOjChUv1lV/p0levg8ZwZmHFNCcdDeQNQjU6G65yCxhhJs49Hg/tg9lhf2KAvvcL9Yxt/nJowPOnR34c4+Ba3pS/TyabXpCT1QYlFf8Kyenc+kdvjVQBGyr4DyLur9aPhVK/sk8AUVejDTlhCpIfQ7sg7jgj0ax6BdUI+34iIfL7bV6QF8rsk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1053A0F5F2F184499B4BED2BF7DB069A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd528c8-5a05-48c7-f1b5-08d61cb6cfe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 16:01:21.6285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4692
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917160121.1ebGKE7tBXReYYp90py67Cb0JXj_rXdvq8nkZtjITzc@z>

T24gTW9uLCAyMDE4LTA5LTE3IGF0IDE2OjA5ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMTQsIDIwMTggYXQgMDc6NTA6MTRQTSArMDMwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KDQo+ID4gVjQgYWRkcyA0IG1vcmUgcGF0Y2hlcyB3aXRoIFBNRV9UdXJu
X09mZiBzdXBwb3J0IG9uIHRvcCwgdXNpbmcgYSBuZXcNCj4gPiByZXNldCBiaXQuIEkgZ2VuZXJh
bGx5IHRyeSB0byBrZWVwIHNlcmllcyBzaG9ydCBidXQgaW4gdGhpcyBjYXNlIHNvbWUNCj4gPiBw
bGFubmluZyBtaWdodCBiZSBuZWVkZWQgdG8gZ2V0IHBhdGNoZXMgaW50byA0LjIwLg0KPiA+IA0K
PiA+IFNpbmNlIHRoZSBuZXcgcmVzZXQgaXMgdHJlYXRlZCBhcyBvcHRpb25hbCB3aXRoIG9sZCBE
VEIgdGhlcmUgc2hvdWxkIGJlDQo+ID4gYWdhaW4gbm8gcHJvYmxlbSBpZiByZXNldCBhbmQgcGNp
IGFyZSBtZXJnZWQgb3V0IG9mIG9yZGVyLg0KPiA+IA0KPiA+IFNoYXduL1BoaWxpcHAvTG9yZW56
bzogV291bGQgaXQgbWFrZSBzZW5zZSB0byBtZXJnZSB0aGlzIHNlcmllcyB0aHJvdWdoIGENCj4g
PiBzaW5nbGUgc3BlY2lmaWMgdHJlZSwgc3VjaCBhcyB0aGUgb25lIGZvciBpbXg/DQo+IA0KPiBU
aGlzIHNlcmllcyBpcyBhIGJpdCBvZiBhIG1peHR1cmUgb2YgbXVsdGlwbGUgdGhpbmdzIGhhcmQg
dG8gZGlzY2Vybg0KPiAoYWN0dWFsbHkgSSBhbHJlYWR5IG1lcmdlZCBwYXRjaCAyIGFuZCBwYXRj
aCAxIHNlZW1zIGNvbXBsZXRlbHkNCj4gdW5yZWxhdGVkKS4NCj4gDQo+IEkgd291bGQgdGFrZSB0
aGUgc2VyaWVzIHRocm91Z2ggdGhlIFBDSSB0cmVlIGJ1dCBJIG5lZWQgYW4gQUNLIGZvcg0KPiBw
YXRjaGVzIDUgYW5kIDYsIHBsZWFzZSBsZXQgbWUga25vdyBob3cgeW91IHdhbnQgdG8gaGFuZGxl
IGl0Lg0KDQpQYXRjaGVzIDEgYW5kIDIgYXJlIGFscmVhZHkgaW4sIHRoZSByZXN0IG5lZWQgcmV2
aWV3LiBJIGNhbiBub3cganVzdA0KcmVzZW5kIHBhdGNoZXMgMy02IGFzIGEgc2VwYXJhdGUgc2Vy
aWVzLCB1bmxlc3Mgc29tZWJvZHkgY29tcGxhaW5zDQphYm91dCBzcGFtLg0KDQpNdWx0aXBsZSBz
ZXBhcmF0ZSBwYXRjaGVzIGFyZSByZXF1aXJlZCBiZWNhdXNlIGl0IHRvdWNoZXMgcmVzZXQgKyBk
dCArDQpwY2kuIEkgZ3Vlc3MgYWRkaW5nIHRoZSBpbmNsdWRlIGNvbnN0YW50IHNob3VsZCBiZSBt
b3ZlZCBmcm9tIHRoZSBkdHMNCnBhdGNoIHRvIGR0LWJpbmRpbmdzIHRob3VnaC4NCg0KTWVyZ2lu
ZyByZXNldCBhbmQgcGNpIG91dCBvZiBvcmRlciBzaG91bGQgYmUgZmluZSBoZXJlIGFuZCBpcyBy
ZXF1aXJlZA0KYnkgRFQgY29tcGF0aWJpbGl0eSBydWxlcyBhbnl3YXkuDQoNCi0tDQpSZWdhcmRz
LA0KTGVvbmFyZA==
