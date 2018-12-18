Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39CC43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 09:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF67217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 09:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uSEQanyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbeLRJe2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:34:28 -0500
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:28256
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbeLRJe1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 04:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOE/XYzgB63wntpLznWjecbIwq4Z6dUQX4AzLfCy/pE=;
 b=uSEQanyNS2Vg/cLJEaG0VNN7UDkOJrmLssGRRK4Ofhi/vE2e/CTZJCz+lfscXvq9I/URTgZ43HycxmbWJY7UVoRL9auerAA98SF1iHmi079I8pc/HlNbBdRg6MGUeN7fprI/fweSZkfz3gauvXiWpJw0ibZxRE5F2ANCi929dmk=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4383.eurprd04.prod.outlook.com (20.177.55.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Tue, 18 Dec 2018 09:34:21 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 09:34:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Topic: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Index: AQHUlocxSxlVauzxZ0epY0uSJZc9vaWEO6CA
Date:   Tue, 18 Dec 2018 09:34:21 +0000
Message-ID: <8149d09e665c4a4efb85a9d60f266d478bee02d8.camel@nxp.com>
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
         <20181218040702.29231-4-andrew.smirnov@gmail.com>
In-Reply-To: <20181218040702.29231-4-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4383;6:1jsx4xp5lbp0h3SK2Lw0RNuZmxqMMuFmCcw8YZzJNwpC4m8PjHviDZXXxVEiED5l0d59C2vmn8UybzBYwUtBzpAK+ps3sHecJyfvzojl0W7aNVtF824eZN3FRf0fmPx6qvX4+oqmvx2xnENBYSb2ucjeh0wIU9WMApk1zwl1LlI45XbLbnLAVL8TAU2D+ERfTyjqqVbwLhQkQfkbgrO8azsI6FnVOS5LUXAZ7b9gY36EMk5R3M+//DrXs8gbf+pw61q2Q52iI9yssYZaMJkDJOsGXWsc+glyrSDLyTio1DEcMxd41gAhkV9xz20qE6PWEaSERLzz5DbiPI5HyyzU2E+MsuSx4Cxo99d3FobA0pEtAMh+GIOkY8ISSEUnEZyW7ZjfO2oZ/L0SNtAdjPMN8O/Jig7QZW+tqx/U0WF0BUINTO1ND+TWSKQGhMVhpLqXRQzRqDpHn/xm4FvvZlpReg==;5:mnLUB/wv91LuvSx4jSmaRQXqnnOti4VcJgvSQBeesJnidtRH2lPUDtf1TaksVwrf3mQtLoJM2I6o/FkYU1Y0f/FYEjvUpPi5M4Gr4f9lQM1ZqQbuekbCev+346jBNZVHbpx0GLy++OjfEdtNVwexwY7u2RMu+OsZkvG6Sy45AyM=;7:80xt8wIhnmu9Cu4cFBjr2bNSMiayG0e0vSypqV8Z0j7JZpmfRggCM4kYDoxo2hwNQWZgRh+B+sh+9HwdGVYHhD2wYmDInm84zzX5jWs6MX7Fbghonybz3cFSedVHUg/ciMprj66551MG7KiNlDLWKQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d63b4649-fbcf-486f-1cdc-08d664cbfd78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4383;
x-ms-traffictypediagnostic: VI1PR04MB4383:
x-microsoft-antispam-prvs: <VI1PR04MB4383B190E1CCD8DFB8CB1AD9EEBD0@VI1PR04MB4383.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4383;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4383;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(99286004)(66066001)(14454004)(76176011)(5660300001)(26005)(6506007)(102836004)(68736007)(81156014)(81166006)(36756003)(8936002)(25786009)(2906002)(118296001)(8676002)(7736002)(316002)(54906003)(110136005)(478600001)(2616005)(4326008)(86362001)(14444005)(256004)(6116002)(3846002)(53936002)(4001150100001)(476003)(486006)(44832011)(97736004)(39060400002)(446003)(11346002)(229853002)(6436002)(71190400001)(71200400001)(186003)(105586002)(6486002)(6512007)(305945005)(2501003)(6246003)(7416002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4383;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l/k82zaKQ5WtOYrGJ5fEE6Xzs6CjAkGDQ2JVS0zuMtgeI9ChkBiooR+7T2Y+SHur/1afok8QjvqdK40oRVrah80dWwA1GYDpM7fdWxADMxpE42rTxCfvPin4dkIefF1mpwJh/w7wDroa/25T4AvzQtSeRv+PiYvz/bphZm4K5W0dG0/zCtFYMIGVqVm6DHWe0uRCcbn5+EWnePK/tDiDgryIyZlMU4k4S4rzFVqFSG/9sANDlCTEWoBLjuwqOiCLura+pfl0oSn0PhTE7blJnhfY25f7hyF9D0fxAsT1bXIglc8S4J8TaAGa+5OLNIKi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <316A6C852A737245A9B92932430DFBFC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63b4649-fbcf-486f-1cdc-08d664cbfd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 09:34:21.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4383
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTE3IGF0IDIwOjA3IC0wODAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gQWRkIGNvZGUgbmVlZGVkIHRvIHN1cHBvcnQgaS5NWDhNUSB2YXJpYW50Lg0KDQo+ICBzdGF0
aWMgdm9pZCBpbXg2X3BjaWVfaW5pdF9waHkoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0K
PiAgew0KPiArDQo+ICsNClJlbW92ZSBlbXB0eSBsaW5lcz8NCg0KPiArCXVuc2lnbmVkIGludCBt
YXNrLCB2YWwsIG9mZnNldDsNCj4gKw0KPiArCW1hc2sgPSBJTVg2UV9HUFIxMl9ERVZJQ0VfVFlQ
RTsNCj4gKwl2YWwgID0gRklFTERfUFJFUChJTVg2UV9HUFIxMl9ERVZJQ0VfVFlQRSwgUENJX0VY
UF9UWVBFX1JPT1RfUE9SVCk7DQoNCi4uLiBzbmlwIC4uLg0KDQo+IC0JcmVnbWFwX3VwZGF0ZV9i
aXRzKGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEyLA0KPiAtCQkJSU1YNlFfR1BS
MTJfREVWSUNFX1RZUEUsIFBDSV9FWFBfVFlQRV9ST09UX1BPUlQgPDwgMTIpOw0KPiArCXJlZ21h
cF91cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxMiwgbWFzaywg
dmFsKTsNCg0KTWF5YmUgc2V0dGluZyBwb3J0IHR5cGUgc2hvdWxkIGJlIGEgc2VwYXJhdGUgZnVu
Y3Rpb24gZnJvbSBpbml0X3BoeT8NCg==
