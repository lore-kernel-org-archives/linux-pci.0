Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68DDC64EBC
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746862098A
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 13:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AsQd4Tg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746862098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJDUNk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:13:40 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:59672
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbeJDUNk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 16:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia+Yxo4cgifafQGinnKpR2ja3zbDz33AZEHZlR6uuus=;
 b=AsQd4Tg7b5TG+dY18o/EqEDzbFANJLRhQKxxz4GQaYjzDOibvZsXPNztYMiuZ1aT3p0C0N+0ENyWnWzhBH6uWLuDc+WCHr9MWgU5FH3ZVRNDLu/e1zH86WIU8ulW8m8UJN/tJONANZ54WCTrdiQu/YB86eXn7PWQWU1Bg6eOQnM=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5332.eurprd04.prod.outlook.com (52.134.126.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.22; Thu, 4 Oct 2018 13:20:20 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 13:20:20 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 4/4] PCI: imx: Add PME_Turn_Off support
Thread-Topic: [PATCH 4/4] PCI: imx: Add PME_Turn_Off support
Thread-Index: AQHUWcCHbQ3Y0BEOyk+EhXZC1cmPE6UOzbwAgABIvQA=
Date:   Thu, 4 Oct 2018 13:20:20 +0000
Message-ID: <e7d5a2beb146f627e7043a81083e6978961b2761.camel@nxp.com>
References: <cover.1538423063.git.leonard.crestez@nxp.com>
         <1cf53d188657bba7df06ad417eb2a65160238196.1538423063.git.leonard.crestez@nxp.com>
         <1538643596.3515.5.camel@pengutronix.de>
In-Reply-To: <1538643596.3515.5.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5332;6:jfXpuhsgZf0a6lj2RKmwXwTzIF7smPPMHwZ7szv+XGKKhzGxv95dwlPUWYYnOzLsMKncVTyI3omm2dbUHpodD1Sfp+vY6YYgSRiRGBr0QbarG48/zvCPTE45Sowos4MYW0ZzSxAEO+JERCtjKBtUHx+NRqHSAC73iqq3HEBuGEsw1ddn6IZ1jdZM+D8hOMLw87NMkU+x872lLp+VnrJl5/DjDBSZXDH6OOkORNpsMr75Y7SQSZ8KJPhOBSZwNhNOwCE+o7ymag8W+rpCVmyoP2sK36V91TWf7SfEIYF3rdFWrMOXT5tX+/Xy7duA/BRvGnB0iknjsHjzBpTbRyQJLH3wAOmhI/IrjmAKswI96xArE7nJCriAJaAi3D5FASru2KlZITPKTf1PntTpVdTtufLN4ZwNQoE+mfLHhq4V0rn/j21UcgYICPwTrXEVYhvni/GcXMv3eahMHCkItdzeFg==;5:wFWj1pDk32v6ee5WMXW3qutWw0vEKQx481l902+2Qib8+lNxxvvnIcm1xm2bE+G8LJYpb0N8bZYHmB583W2PKvKNtsia/8b57IGhQg5HBfejStAzftUOJN/TaUhq8pNPLyhogQULXx61RhUcwDec6CK5YSTlky3x/y5iw1VsyXw=;7:/DjMiH//+Ogx5kwmdtF/x/SoiwH9hPeRst1DZ3h3ya0dpJmt8kjUHUeNN0g38W1IwATXEASQ6aArWH/VrRALH1aOxdHXdwiHC7fjgr5jzqbz5lifmIfs0Tyi6xo+rj89MeVpc8ZSso0R4R1rUf5wa5W7eoukLHukv95+PlSqrx5uM8yUV93u6kXq8DuBE+ZvgJbpaDBvswlhwk7axzzypPsXwGCCCvdoGtDC+IPCUBOn/OwenI2rl/7QJKpFhIfw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be8e0f94-02ab-4e52-7e79-08d629fc2258
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5332;
x-ms-traffictypediagnostic: AM0PR04MB5332:
x-microsoft-antispam-prvs: <AM0PR04MB5332CD93603F31866EEA878EEEEA0@AM0PR04MB5332.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991048);SRVR:AM0PR04MB5332;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5332;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(186003)(53936002)(7736002)(476003)(7416002)(2501003)(102836004)(6246003)(26005)(118296001)(305945005)(14454004)(81166006)(97736004)(105586002)(5250100002)(446003)(8676002)(44832011)(6506007)(2906002)(486006)(86362001)(2616005)(39060400002)(11346002)(106356001)(6486002)(5660300001)(8936002)(68736007)(36756003)(25786009)(4326008)(6436002)(3846002)(6636002)(6116002)(76176011)(81156014)(6512007)(478600001)(66066001)(50226002)(316002)(256004)(229853002)(2900100001)(71190400001)(71200400001)(99286004)(54906003)(110136005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5332;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X2/0A+BmZPnq8eXJ+kyamxm1Rs4y8x0NL1ktN/0qW2TH0IF1g2U1kqbyIGGdJ5FM5UDTyAeNMc7dvv7CrVrQnPmjqhbRYmiBdmerfFUlHKmW57E7zTdPx2P//tZuIpkO9gXvCil9pFryP3j9kiwRRw0b1qM4DCVzv1AfTOmziluUVO1YmhgP9tU9z0RBQNuA9HB96shQVlPKdpvCrhh5WQmE2srRqLmC1NMsY4MsrHDCfu9FtxV+dadC+7+YExJpnIS+PHTK4gVy44bH3fMC4HbGKw9/kLyiGs/MOIVTBP3I+y919dPN3Y1GtnGZk/AF+bXrp1bd1NzyK+dUDVndj8lNg8tjILZnPXHl3rPEad0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <02EBFD72DE2CCE4CA1BF49B7DCFBE4F2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8e0f94-02ab-4e52-7e79-08d629fc2258
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 13:20:20.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5332
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTA0IGF0IDEwOjU5ICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTW9udGFnLCBkZW4gMDEuMTAuMjAxOCwgMjI6NTMgKzAzMDAgc2NocmllYiBMZW9uYXJkIENy
ZXN0ZXo6DQo+ID4gV2hlbiB0aGUgcm9vdCBjb21wbGV4IHN1c3BlbmRzIGl0IG11c3Qgc2VuZCBh
IFBNRV9UdXJuX09mZiBUTFAuDQo+ID4gSW1wbGVtZW50IHRoaXMgYnkgYXNzZXJ0aW5nIHRoZSAi
dHVybm9mZiIgcmVzZXQuDQo+ID4gDQo+ID4gK3N0YXRpYyB2b2lkIGlteDZfcGNpZV9wbV90dXJu
b2ZmKHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkNCj4gPiArew0KPiA+ICsJcmVzZXRfY29u
dHJvbF9hc3NlcnQoaW14Nl9wY2llLT50dXJub2ZmX3Jlc2V0KTsNCj4gPiArCXJlc2V0X2NvbnRy
b2xfZGVhc3NlcnQoaW14Nl9wY2llLT50dXJub2ZmX3Jlc2V0KTsNCj4gDQo+IEknbSBhIGJpdCBz
dXJwcmlzZWQgdG8gc2VlIG5vIHRpbWluZyByZXF1aXJlbWVudHMgaGVyZS4gSSB3b3VsZCBoYXZl
DQo+IGV4cGVjdGVkIHRoYXQgdGhlcmUgaXMgYSBtaW5pbXVtIHRpbWUgZnJvbSBhc3NlcnRpbmcg
dGhlIHJlc2V0LCBzbyB0aGUNCj4gdHVybm9mZiBtZXNzYWdlIGdldHMgdHJhbnNtaXR0ZWQgdG8g
dGhlIEVQIGJlZm9yZSB0aGUgY2xvY2tzIGFyZQ0KPiBzdG9wcGVkLg0KDQpBY2NvcmRpbmcgdG8g
dGhlIFBDSSBzdGFuZGFyZCBhZnRlciBQTUVfVHVybl9PZmYgaXMgc2VudCBhbGwgY29tcG9uZW50
cw0KbXVzdCByZXNwb25kIHdpdGggUE1FX1RPX0Fjay4gVGhlcmUgZG9lc24ndCBzZWVtIHRvIGJl
IGFueSBiaXQgZXhwb3NlZA0KdG8gY2hlY2sgaWYgYWNrcyB3ZXJlIHJlY2VpdmVkIGJ1dCB0aGUg
c3RhbmRhcmQgcmVjb21tZW5kcyBhIDEtMTBtcw0KdGltZW91dCBhZnRlciB3aGljaCB5b3Ugc2hv
dWxkIHByb2NlZWQgYW55d2F5Lg0KDQpJdCBzZWVtcyB0aGUgTlhQIHZlbmRvciB0cmVlIGhhcyBh
biB1ZGVsYXkoMTAwMCkgd2hpY2ggSSBtaXNzZWQsIGl0DQpzZWVtcyBsaWtlIGFuIGFjY2VwdGFi
bGUgc29sdXRpb24uIE9yIG1heWJlIGl0IHNob3VsZCBiZSBtc2xlZXAoMTApPw0KDQotLQ0KUmVn
YXJkcywNCkxlb25hcmQNCg==
