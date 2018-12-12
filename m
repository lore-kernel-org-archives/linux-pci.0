Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82128C04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1A2084E
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lFB9bSBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C1A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeLLILT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:11:19 -0500
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:7261
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbeLLILT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 03:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ianS4fla2KMp7AqYiMSLvMan92abrWx728eMIa3yybk=;
 b=lFB9bSBk9GxNaM91uno7ZXSgYUKLKuOPc4cXgTe8XJ9lcUOdOG/MZo0yg1cNcq4qSxrMQmViJ76fyb3PQYqOBNmDPmjVpO6bUJiUazBcrAUPJx4LnwVMBuIaKK4cr3+dJ3kzXP4eZGMqyGwmbvN80SL5o0JaKEoLHymBc6pzpgE=
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com (52.133.20.10) by
 AM6PR0402MB3941.eurprd04.prod.outlook.com (52.133.30.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Wed, 12 Dec 2018 08:11:14 +0000
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7c3d:d902:7d9a:a9ee]) by AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7c3d:d902:7d9a:a9ee%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 08:11:14 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "niklas.cassel@linaro.org" <niklas.cassel@linaro.org>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Thread-Topic: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on
 PCIEPORTBUS
Thread-Index: AQHUjTfAKfSDDQAl2EmhEp6vpo0ZjaVxgowAgAE1F4CAAIqVgIAAtIeAgAbR09A=
Date:   Wed, 12 Dec 2018 08:11:13 +0000
Message-ID: <AM6PR0402MB357372AD961BCB1C0AECB9278CA70@AM6PR0402MB3573.eurprd04.prod.outlook.com>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
 <1544092136.3709.57.camel@pengutronix.de>
 <CAHQ1cqFeJtxnpfzqWVQ3T9Sv=gfw+cvZZw-uKnZV7pxJg_S+EA@mail.gmail.com>
 <20181207131113.GA427@centauri.lan>
 <CAHQ1cqFtnSrP=kNzZrFb7kf4i0-zn90k9JFpektFhh-5_HenBA@mail.gmail.com>
In-Reply-To: <CAHQ1cqFtnSrP=kNzZrFb7kf4i0-zn90k9JFpektFhh-5_HenBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3941;6:34VfqOeL2foZ08BKEBFv7Jmz/nOMQSkXZPrNl42pq01s4zGs2budMudo4PIvuLkppILxvvokVk6Dn5q1hRDA3Byfx0t1RiqkHNyxu6StAclzRpgTaELDXpv4MyvBMCzO774ATbfWSx1qX0r48Hu6dXdNvgrGcL0M6v0CfGMczbwa/79f9SIO3nKZoaYT/npVnp/fbj8iTDjf9u40PCrdSQY6Zw1My40yqtuu4QnIKO5QEm1yhcEXTil/FZEqO35tYjYNUL5rJJzhyezggG5mJb2JYDhyA18aBtB0c8P/5nlhy/OXjNE5OEYq0h5lWOHcfGj8eCZiZHQyZesIUqZmub+X5MZcJgvtzRjF0ONwhDHaAXLCG2ngOI0VuJyaZy/kDMgUTCOtAgjRkjH4ieqx9joHT3nsJ5e1vHeMyjn8PXB99DnUs9gAjcTEuN8eZZyEjyWFnTotwa1vNJqSUmckzw==;5:klSnPjEQVAoKAzctuI8tmA1U2/svWV69CZ0e4RbvGQSuwZx1KbJ6xdMZ5TYkkoBOkmfl3YQrLp6lX+ZQEh15ltv07ab5u8Y6x7Ah7d65tjwAsXQxOVvShuqvK4mlqhZK+P9I/Re/5tnsMvDzvjjty8/prl9TA5x5x6+//uBMaDc=;7:z1hUAwkWqhXA9l8DqvahXmjI3YRzq1MQSfPeIpZ++04TrqAUEj/jVPdZV4GUUAwPP4/nE1+Jtsqv2+aZAd1OMSVS/Zp9/wNnSAQVl/vBB8Ytb3ML1qQegGNKPOPWjmsYGMEAroH1oDLc3hVN0pp8+g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fa3d75e9-fb0d-4aa6-a2cc-08d66009625e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3941;
x-ms-traffictypediagnostic: AM6PR0402MB3941:
x-microsoft-antispam-prvs: <AM6PR0402MB3941839852B7EAB737B2439C8CA70@AM6PR0402MB3941.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3941;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3941;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(13464003)(189003)(199004)(71190400001)(25786009)(102836004)(8936002)(106356001)(68736007)(81156014)(446003)(2501003)(256004)(71200400001)(6436002)(5024004)(476003)(66066001)(11346002)(486006)(2906002)(26005)(53546011)(229853002)(5660300001)(14444005)(575784001)(6506007)(186003)(76176011)(93886005)(45080400002)(966005)(33656002)(99286004)(4326008)(54906003)(478600001)(14454004)(86362001)(7696005)(7736002)(74316002)(39060400002)(81166006)(110136005)(55016002)(105586002)(316002)(6116002)(9686003)(6306002)(6246003)(53936002)(8676002)(97736004)(305945005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3941;H:AM6PR0402MB3573.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y0FwQHzfohkUBL1YzUOZD0qz3EYdiL+ISg/lGhlLM4B3oCa1JTTh3YzQC4tM0c7xISgtjjSn4iWrcmq6LfeY5dyE6FhzV44lBAlIUxAZmKkhY7NZEApv92Zya6GvHCc6lZQIuPmYlpbV//sDsOAl3ZY/COyZMzZPbxLjjsx42d7HMP2o+uwNjwdR/rgh33IBBO6wEfK2y0E07BBDO9JZtpp2hj30mtyWFdGl62w77fbst1lyy5t2KH+6KNrEGiuMd7WDnNJF1zS59Axe6byDa3d0AZeG4QroohLXudxZa8invRnzveR92HYIRiOUV+SE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3d75e9-fb0d-4aa6-a2cc-08d66009625e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 08:11:13.9234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3941
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJleSBTbWlybm92IFtt
YWlsdG86YW5kcmV3LnNtaXJub3ZAZ21haWwuY29tXQ0KPiBTZW50OiAyMDE45bm0MTLmnIg45pel
IDc6NTcNCj4gVG86IG5pa2xhcy5jYXNzZWxAbGluYXJvLm9yZw0KPiBDYzogTHVjYXMgU3RhY2gg
PGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBCam9y
bg0KPiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgQ2hyaXMgSGVhbHkgPGNwaGVhbHlA
Z21haWwuY29tPjsNCj4gTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT47
IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
bGludXgtYXJtLWtlcm5lbA0KPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
PjsgbGludXgta2VybmVsDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBQQ0k6IGNvbnRyb2xsZXI6IGR3YzogTWFrZSBQQ0lfSU1YNiBkZXBl
bmQgb24NCj4gUENJRVBPUlRCVVMNCj4gDQo+IE9uIEZyaSwgRGVjIDcsIDIwMTggYXQgNToxMSBB
TSBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fzc2VsQGxpbmFyby5vcmc+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gT24gVGh1LCBEZWMgMDYsIDIwMTggYXQgMDg6NTU6MTNQTSAtMDgwMCwgQW5kcmV5IFNt
aXJub3Ygd3JvdGU6DQo+ID4gPiBPbiBUaHUsIERlYyA2LCAyMDE4IGF0IDI6MjggQU0gTHVjYXMg
U3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBBbSBNaXR0d29jaCwgZGVuIDA1LjEyLjIwMTgsIDIzOjQ1IC0wODAwIHNjaHJpZWIgQW5kcmV5
IFNtaXJub3Y6DQo+ID4gPiA+ID4gQnVpbGRpbmcgYSBrZXJuZWwgd2l0aCBDT05GSUdfUENJX0lN
WDY9eSwgYnV0DQo+ID4gPiA+ID4gQ09ORklHX1BDSUVQT1JUQlVTPW4gcHJvZHVjZXMgYSBzeXN0
ZW0gd2hlcmUgYnVpbHQtaW4gUENJRQ0KPiA+ID4gPiA+IGJyaWRnZSAoMTZjMzphYmNkKSBpc24n
dCBib3VuZCB0byBwY2llcG9ydCBkcml2ZXIuIFRoaXMsIGluDQo+ID4gPiA+ID4gdHVybiwgcmVz
dWx0cyBpbiBhIFBDSUUgYnVzIHRoYXQgaXMgY2FwYWJsZSBvZiBlbnVtZXJhdGluZw0KPiA+ID4g
PiA+IGF0dGFjaGVkIFBDSUUgZGV2aWNlLCBidXQgbGFja3MgZnVuY3Rpb25hbCBpbnRlcnJ1cHQg
c3VwcG9ydC4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBpcyBvZGQuIEFGQUlLIFBDSSBwb3J0IHNl
cnZpY2VzIGFyZSBhIHRvdGFsbHkgb3B0aW9uYWwgdGhpbmcNCj4gPiA+ID4gYW5kIHRoZW0gYmVp
bmcgYWJzZW50IHNob3VsZCBub3QgbGVhZCB0byBhIG5vbi1mdW5jdGlvbmFsIFBDSSBidXMuDQo+
ID4gPiA+IFNvIEkgd291bGQgcmVhbGx5IGxpa2UgdG8gc2VlIHNvbWUgZGVlcGVyIGFuYWx5c2lz
IHdoYXQgaXMgZ29pbmcgb24gaGVyZS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBBRkFJQ1QsIHRo
aXMgaXMgZHVlIHRvIHBjaWVwb3J0IGRyaXZlciBlbmFibGluZyBNU0kgb2YgdGhlIGJyaWRnZQ0K
PiA+ID4gZGV2aWNlICgxNmMzOmFiY2QpIHZpYSBwY2llX3BvcnRfZGV2aWNlX3JlZ2lzdGVyKCkg
LT4NCj4gPiA+IHBjaWVfaW5pdF9zZXJ2aWNlX2lycXMoKSAtPiBwY2llX3BvcnRfZW5hYmxlX2ly
cV92ZWMoKSAtPiBldGMuDQo+ID4gPg0KPiA+ID4gSSBkaWQgYW4gZXhwZXJpbWVudCBvbiBhIGku
TVg4TVEvUENJRSAtPiBpMjEwIHNldHVwIEkgaGF2ZTogSQ0KPiA+ID4gZGlzYWJsZWQgQ09ORklH
X1BDSUVQT1JUQlVTIGFuZCBoYWNrZWQgaWdiX21haW4uYyBlbm91Z2ggdG8gbWFrZQ0KPiB0aGUN
Cj4gPiA+IGkyMTAgZHJpdmVyIGJlbGlldmUgaXQgc2hvdWxkIGZhbGwgYmFjayBvbnRvIGxlZ2Fj
eSBpbnRlcnJ1cHRzLiBFdmVuDQo+ID4gPiB3aXRob3V0IHBjaWVwb3J0IHByZXNlbnQgaW4gdGhl
IHN5c3RlbSwgaTIxMCB3b3JrZWQgYXMgZXhwZWN0ZWQgdmlhDQo+ID4gPiBsZWdhY3kgaW50ZXJy
dXB0cywgd2hpY2ggc2VlbXMgdG8gY29sbGFib3JhdGUgbXkgY29uamVjdHVyZSBhYm92ZS4NCj4g
PiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBBbmRyZXkgU21pcm5vdg0KPiA+DQo+ID4gSUlVQyBQ
Q0lFUE9SVEJVUyBzaG91bGQgbm90IGJlIG5lZWRlZCBmb3IgTVNJcyB0byB3b3JrLCBpdCBpcyBv
bmx5DQo+ID4gbmVlZGVkIGlmIHlvdSB3YW50IGUuZy4gUE1FIG9yIEFFUi4NCj4gPg0KPiA+IFRo
ZSBkaWZmZXJlbmNlIGlzIHRoYXQgaWYgUENJRVBPUlRCVVMgaXMgZW5hYmxlZCwgYSBNU0kgaXJx
IHZlY3Rvcg0KPiA+IHdpbGwgYmUgYWxsb2NhdGVkIGZvciB0aGUgUm9vdCBDb21wbGV4IGl0c2Vs
Ziwgc28gdGhhdCBpdCBjYW4gc2VuZCBhbg0KPiA+IGlycSB3aGVuIGUuZy4gQUVSIGhhcyBkZXRl
Y3RlZCBhbiBlcnJvci4NCj4gPg0KPiA+DQo+ID4gSWYgd2UgZGlzcmVnYXJkIHRoYXQgTVNJIGhh
bmRsaW5nIGlzIGN1cnJlbnRseSBicm9rZW4gb24gRFdDIFBDSWU6DQo+ID4NCj4gaHR0cHM6Ly9l
bWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
Rm1hcg0KPiA+DQo+IGMuaW5mbyUyRiUzRmwlM0RsaW51eC1wY2klMjZtJTNEMTU0MjE0OTg2OTI0
MjQ0JTI2dyUzRDImYW1wO2QNCj4gYXRhPTAyJTdDDQo+ID4NCj4gMDElN0Nob25neGluZy56aHUl
NDBueHAuY29tJTdDZDBlNzVjMjRiNzUwNGMzZjM5NTUwOGQ2NWM5ZmMxYTMlDQo+IDdDNjg2ZWEN
Cj4gPg0KPiAxZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNjc5ODIzODU1
Mjk4NTQ4NiZhbXA7DQo+IHNkYXRhPXJ3ZA0KPiA+IGVkRjBTaWpacWtGcnBTSEZxN3VMbVhlZnRH
YWcwcEp5VDlYQzROT2MlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiBJdCBpcyB2ZXJ5IHBvc3NpYmxl
IHRvIGhhdmUgTVNJcyBvbiBkcmFnb25ib2FyZCA4MjBjLCB3aGljaCBhbHNvIHVzZXMNCj4gPiB0
aGUgRFdDIFBDSWUgY29udHJvbGxlciwgd2l0aG91dCBoYXZpbmcgUENJRVBPUlRCVVMgc2VsZWN0
ZWQ6DQo+ID4NCj4gPiAjIHpjYXQgL3Byb2MvY29uZmlnLmd6IHwgZ3JlcCAtRSAiUENJRV9RQ09N
fFBDSUVQT1JUQlVTIg0KPiA+ICMgQ09ORklHX1BDSUVQT1JUQlVTIGlzIG5vdCBzZXQNCj4gPiBD
T05GSUdfUENJRV9RQ09NPXkNCj4gPg0KPiA+DQo+ID4gIyBsc3BjaSAtdiAtcyAwMDAwOjAwOjAw
LjANCj4gPiAwMDAwOjAwOjAwLjAgUENJIGJyaWRnZTogUXVhbGNvbW0gRGV2aWNlIDAxMDQgKHBy
b2ctaWYgMDAgW05vcm1hbA0KPiBkZWNvZGVdKQ0KPiA+ICAgICAgICAgLi4uDQo+ID4gICAgICAg
ICBDYXBhYmlsaXRpZXM6IFs1MF0gTVNJOiBFbmFibGUtIENvdW50PTEvMzIgTWFza2FibGUrIDY0
Yml0Kw0KPiA+DQo+ID4gIyBsc3BjaSAtdiAtcyAwMDAwOjAxOjAwLjANCj4gPiAwMDAwOjAxOjAw
LjAgTmV0d29yayBjb250cm9sbGVyOiBRdWFsY29tbSBBdGhlcm9zIFFDQTYxNzQgODAyLjExYWMN
Cj4gV2lyZWxlc3MgTmV0d29yayBBZGFwdGVyIChyZXYgMzIpDQo+ID4gICAgICAgICAuLi4NCj4g
PiAgICAgICAgIENhcGFiaWxpdGllczogWzUwXSBNU0k6IEVuYWJsZSsgQ291bnQ9MS84IE1hc2th
YmxlKyA2NGJpdC0NCj4gPg0KPiA+DQo+ID4gIyBjYXQgL3Byb2MvaW50ZXJydXB0cyB8IGdyZXAg
TVNJDQo+ID4gIDcwOiAgICAgICA1NjIwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAw
ICAgUENJLU1TSQ0KPiA1MjQyODggRWRnZSAgICAgIGF0aDEwa19wY2kNCj4gPg0KPiA+IFNvIHBl
cmhhcHMgdGhpcyBpcyBhIGJ1ZyBzcGVjaWZpYyB0byBpbXg2Pw0KPiA+DQo+IA0KPiBZZWFoLCB0
aGF0IHNlZW1zIGVudGlyZWx5IHBsYXVzaWJsZS4gSSByZWFjaGVkIG91dCB0byBOWFAgdmlhIG9u
ZSBvZiB0aGUNCj4gc3VwcG9ydCBjaGFubmVscyB0byBjbGFyaWZ5LiBJJ2xsIHJlcG9ydCBpZiBJ
IGhlYXIgYmFjayBmcm9tIHRoZW0uDQo+IA0KW1JpY2hhcmQgWmh1XSBEaWQgc29tZSB0ZXN0cy4N
ClRoZSBNU0lfRU4gb2YgdGhlIE1TSSBDQVAgb2YgUkMgc2hvdWxkIGJlIHNldCB0byAxIG9uIGlN
WDYgUENJZS4NCk90aGVyd2lzZSwgdGhlIE1TSSB3b3VsZG4ndCBiZSB0cmlnZ2VyZWQgYWx0aG91
Z2ggdGhlIGRldmljZSBpcyBwcmVzZW50IGFuZCB0aGUgTVNJcyBhcmUgYXNzaWduZWQuDQoNCj4g
VGhhbmtzLA0KPiBBbmRyZXkgU21pcm5vdg0K
