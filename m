Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367ADECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 17:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF571214D5
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D6CBr8J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF571214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIQWnf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:43:35 -0400
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:20288
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbeIQWne (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 18:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo3M6GVMooTX0DGxpLW7/SdBmj0FCnM6yOoXfZ5csu8=;
 b=D6CBr8J1fHa07DtXro1row5XrATKAGEYwb/sheXk1RUD/Ry94OKOcLW/K5Kr14awhGESASCKlfBOaLi8stirlOYmigoPxihLrBXN5qb05r6ksEdmxCBDbJJ6M8qMTpNJrsXC2H7LrBcF8eDoFJri9Fe13xRN4Z7Uz235FZuOJ3c=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4164.eurprd04.prod.outlook.com (52.134.126.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Mon, 17 Sep 2018 17:15:14 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 17:15:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Thread-Topic: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Thread-Index: AQHUM+76K2DBZY0BEEaUopztAS8XkaT0yQyAgAAOaICAAA5ygIAABjMA
Date:   Mon, 17 Sep 2018 17:15:14 +0000
Message-ID: <e367a04f3b5652aa9ed3baefbb7d0b12eb5eb8dd.camel@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
         <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
         <16d68541fd499dfda88e79d4386be7ad6d0919d9.camel@nxp.com>
         <20180917165257.GJ7239@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180917165257.GJ7239@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4164;6:Htflv1tJclCd/+J4zWHz9k+lgAUDQ+3Ll7Vu0DEkL9tdr00n2i0witAMMzIkAt9TflgnHdQs8570gndYKs8fJk0fhTVptDqQE82hTK75PDQYmBhEbELwJ/gr8cTGiqyJF/igjMcAu8NV/5e4Ks7YaTL21SVesS9xzoUwAjwta8596Z4DQ1znGUdNPkgakHLdBTvoVSFu0huoF2eVhIt5mlFV5gp5XyRV/d3wDaD90AQLgkgkmV7kMCssTfs4Y8HnrklHu97UJT5y75tgKJI8KlcwX3zZW82hvp7lNP3K6Ur8pkUeUCBRnUMCqoaKlZHJP2mVuCMb1urH0p39ajNJMiGLZuZ6TJ7ZhTzzyJ/wIwIMMHqyF5YCheR26lIBPP9LMMA+CYzQ4WVxQtHmFMdw8EusiB5tm/MiFRhV5X1cRNeBI6ToNfyAt7n6n68is2wTojo/mK4lRxDpguyFJufxOA==;5:SZ+DYc5HNAXcpNDZU2uhangSAKicI9UhDhJVaQjhxF2VmpdwZ6aaKlkRcsM3GJmIurzFFfhkwUkUHoAW0HYJVrc0ngxAcih1dNKF8vrYhm18QosbNM2OvwJ99MdjUC7zDVl9OenSXbL5qqEq7l/Gwu51gwCOXCtW3rqWJUinMK8=;7:CdOkSG+5ldHHSUhJX643k2bPYEfhpN8GwRiLbVNFTwgVijIHT3C2bPcrorJ6G91hTHdkPyEYn9CTBHkeW6379Rp8VS6z4P51jhCtN0Ttud0NB8IpD6MDO7KZWTzyvi+jyla38IacfSW1mDq3IPNHMoDFBbKsxQ24e1sLvW4eYbDAPrR3l9FwT220uPtRnbfJucUQKhNsT+lOOc+y56gkvydpkr+uK4HRPc7qlWu8opL2RSsJp6qZ8KwV/nkblZA0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0b3f6ccd-99f9-4115-afd1-08d61cc12202
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4164;
x-ms-traffictypediagnostic: AM0PR04MB4164:
x-microsoft-antispam-prvs: <AM0PR04MB41646CE6863232329B72CC02EE1E0@AM0PR04MB4164.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:AM0PR04MB4164;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4164;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(366004)(39860400002)(199004)(189003)(5250100002)(66066001)(2616005)(36756003)(486006)(11346002)(6116002)(446003)(4326008)(97736004)(476003)(25786009)(8936002)(39060400002)(106356001)(7416002)(102836004)(118296001)(2201001)(54906003)(44832011)(110136005)(478600001)(50226002)(76176011)(99286004)(6246003)(316002)(3846002)(81156014)(81166006)(6506007)(68736007)(6436002)(5660300001)(26005)(86362001)(8676002)(6486002)(2900100001)(305945005)(229853002)(2906002)(6512007)(256004)(53936002)(7736002)(93886005)(14444005)(186003)(14454004)(2501003)(105586002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4164;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IZE+aN59ob8PSmEdOXukV4MCzaQkvMwFzO9xQpUFK+DI7zgetThWPboK4U1h0OtkuE1cYlWogYRw0XrOYp5TZvUT5SD5KD6YEtD7UoCOcKbK3+jVAl03xSGi69+FvOrgUdu1piqOqlVaKlaH42gFSm0BtB4eSdTwRhiz3i4kHUwqioAWeyOZaU1IeB7RERtCzZpSBskrlNJfrG7r7xMk6a674Xv6Bl0wlG8UANJ175CmTj8d70eLlAONLmi1Oro4VWw6h4W+GdNTWEGxXNpp/gPf4NBcAxCJh6w+4WLt81XjjX3JUPFbNmIFLk86kFLr/g2YauPCFa5h0SQX79cWBLbojKZSzFkMQBnO8592B1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E58251B00C34D4C858BA7BB5E7F3A7A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3f6ccd-99f9-4115-afd1-08d61cc12202
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 17:15:14.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4164
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917171514.JMcajRE2210uadORUgcR2LvrQQAJCn436wGWEgfkpWc@z>

T24gTW9uLCAyMDE4LTA5LTE3IGF0IDE3OjUyICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gTW9uLCBTZXAgMTcsIDIwMTggYXQgMDQ6MDE6MjFQTSArMDAwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOC0wOS0xNyBhdCAxNjowOSArMDEwMCwgTG9y
ZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEF1ZyAxNCwgMjAxOCBhdCAwNzo1
MDoxNFBNICswMzAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gPiA+IFY0IGFkZHMgNCBt
b3JlIHBhdGNoZXMgd2l0aCBQTUVfVHVybl9PZmYgc3VwcG9ydCBvbiB0b3AsIHVzaW5nIGEgbmV3
DQo+ID4gPiA+IHJlc2V0IGJpdC4gSSBnZW5lcmFsbHkgdHJ5IHRvIGtlZXAgc2VyaWVzIHNob3J0
IGJ1dCBpbiB0aGlzIGNhc2Ugc29tZQ0KPiA+ID4gPiBwbGFubmluZyBtaWdodCBiZSBuZWVkZWQg
dG8gZ2V0IHBhdGNoZXMgaW50byA0LjIwLg0KPiA+ID4gPiANCj4gPiA+ID4gU2luY2UgdGhlIG5l
dyByZXNldCBpcyB0cmVhdGVkIGFzIG9wdGlvbmFsIHdpdGggb2xkIERUQiB0aGVyZSBzaG91bGQg
YmUNCj4gPiA+ID4gYWdhaW4gbm8gcHJvYmxlbSBpZiByZXNldCBhbmQgcGNpIGFyZSBtZXJnZWQg
b3V0IG9mIG9yZGVyLg0KPiA+ID4gPiANCj4gPiA+ID4gU2hhd24vUGhpbGlwcC9Mb3JlbnpvOiBX
b3VsZCBpdCBtYWtlIHNlbnNlIHRvIG1lcmdlIHRoaXMgc2VyaWVzIHRocm91Z2ggYQ0KPiA+ID4g
PiBzaW5nbGUgc3BlY2lmaWMgdHJlZSwgc3VjaCBhcyB0aGUgb25lIGZvciBpbXg/DQo+ID4gPiAN
Cj4gPiA+IFRoaXMgc2VyaWVzIGlzIGEgYml0IG9mIGEgbWl4dHVyZSBvZiBtdWx0aXBsZSB0aGlu
Z3MgaGFyZCB0byBkaXNjZXJuDQo+ID4gPiAoYWN0dWFsbHkgSSBhbHJlYWR5IG1lcmdlZCBwYXRj
aCAyIGFuZCBwYXRjaCAxIHNlZW1zIGNvbXBsZXRlbHkNCj4gPiA+IHVucmVsYXRlZCkuDQo+ID4g
PiANCj4gPiA+IEkgd291bGQgdGFrZSB0aGUgc2VyaWVzIHRocm91Z2ggdGhlIFBDSSB0cmVlIGJ1
dCBJIG5lZWQgYW4gQUNLIGZvcg0KPiA+ID4gcGF0Y2hlcyA1IGFuZCA2LCBwbGVhc2UgbGV0IG1l
IGtub3cgaG93IHlvdSB3YW50IHRvIGhhbmRsZSBpdC4NCj4gPiANCj4gPiBQYXRjaGVzIDEgYW5k
IDIgYXJlIGFscmVhZHkgaW4sIHRoZSByZXN0IG5lZWQgcmV2aWV3LiBJIGNhbiBub3cganVzdA0K
PiA+IHJlc2VuZCBwYXRjaGVzIDMtNiBhcyBhIHNlcGFyYXRlIHNlcmllcywgdW5sZXNzIHNvbWVi
b2R5IGNvbXBsYWlucw0KPiA+IGFib3V0IHNwYW0uDQo+IA0KPiBXaGF0IGRvIHlvdSBtZWFuIGJ5
ICJhcmUgYWxyZWFkeSBpbiIgPyBQYXRjaCAyIEkgcXVldWVkIHZpYSB0aGUgUENJDQo+IHRyZWUs
IHBhdGNoIDEgPyBDYW4gSSBkcm9wIGl0IGZyb20gdGhlIFBDSSBwYXRjaCBxdWV1ZSA/DQoNClNv
cnJ5LCB3aGF0IEkgbWVhbnQgaGVyZSBpcyAiYWNjZXB0ZWQgYnkgYSBtYWludGFpbmVyIi4gU28g
a2VlcCBwYXRjaCAyDQpwbGVhc2U7IHBhdGNoIDEgd2FzIGFjY2VwdGVkIGJ5IFNoYXduIGZldyB3
ZWVrcyBhZ28uDQoNCj4gSSBkbyBub3QgdGhpbmsgdGhlcmUgaXMgYW55IG5lZWQgdG8gcmVzZW5k
LCBJIGNhbiBtZXJnZSBwYXRjaGVzIDMtNA0KPiBzaW5jZSB0aGV5IGhhdmUgYmVlbiByZXZpZXdl
ZCBidXQgcGF0Y2hlcyA1IGFuZCA2IG5lZWQgcmV2aWV3Lg0KDQpQYXRjaGVzIDMtNCB3ZXJlIGFj
a2VkIGJ5IFJvYiBIZXJyaW5nIG1vc3RseSBmcm9tIHRoZSBkZXZpY2V0cmVlDQpwZXJzcGVjdGl2
ZS4gU2luY2UgcGF0Y2hlcyAzLTYgYXJlIG5vdCB1c2VmdWwgaW5kZXBlbmRlbnRseSBzb21lYm9k
eQ0KbGlrZSBMdWNhcyBzaG91bGQgcmV2aWV3IHRoZSB3aG9sZSBzZXJpZXMgYW5kIHRoZW4gaXQg
Y2FuIGJlIG1lcmdlZC4NCg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJk
