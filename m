Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF041C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 01:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDB3214E0
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 01:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c1qN0Z+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDB3214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeKLLjE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:39:04 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:28294
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729780AbeKLLjE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Nov 2018 06:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b7yEdwHLbz9cCKm0qtQYuTxn+mOcmO+g8OZC4E21ys=;
 b=c1qN0Z+YGzF5OaPfAwPt/f1M2OmJFxYjnFaLbrMYklPnKFpi9Uk1LRekAH3vYUxYtayldhkJyV3azyB0X7/598yVZXhmGhdblZB64S94Z910cRurYMTmDWf20hZTleL7fTi0bc7q3PPgWzu36SoNsFPs5JfjbHly6BP/BkCTu9Y=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB3974.eurprd04.prod.outlook.com (52.135.160.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 12 Nov 2018 01:48:05 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 01:48:05 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Topic: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Index: AQHUddOaH+hnWiOCjEOD1szvFZnE86VGaH0AgAT7B8A=
Date:   Mon, 12 Nov 2018 01:48:05 +0000
Message-ID: <AM6PR04MB57816EE50C61E064E6DC73A684C10@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
 <AM6PR04MB58639AF03E732FCF491113728FC50@AM6PR04MB5863.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB58639AF03E732FCF491113728FC50@AM6PR04MB5863.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB3974;6:72QxLHOhlxcIcU0dZ9eMD5Ii3+7IzJpwr+XBNzjD2py4O+3N2Y1O+fBd/C7vfX58LHnD5949ghJAJ2ZD6N4FBNPmoprqdeIx80WLsr/H49kg8Qeb9B0JIswIrZfL1NN5Jt4lGmB1lqBrMgCCOUjBvnx8oSyy1Y/u4SHuTBs9lcxRsm3E8v+OqysUG8kJBfTTmyf4doJbMgYZ4FknajNXpb+iSFeFYScoWHkCqRUKBx/zBTiMDTALnuw7q6hUs98PB4sIShk7udu3oRBoFKgohwAb+/wuVuAle2taPLTocdKOizlr6O9D3e56849c/YO7F05+nGzn39n4yKFq4FnNj1xOWKx3ABqBvv1nZUt09UgN0So/n21CqpD9GOYL9p3DJq36UwQ5lqVrx6IrdZ7s0ELD5RxNGWPJT0lF533R1e42tLrIw0PcGT45IE27Kf7rEjVJEUiSOsjT2Lp80iadEw==;5:hmN1x8D4sk8nmR0h2b+NsR1nvwgUL0nsgmdLNfj3pr/phHwtiDmfWz+E09T4dcbFk5Tzd2mBFyG6vZHKL3cTq1mOM7MemyOs/GdeD4vCrR23JT1+F8ki/fvzL1/94gGy2InO+zx+2htNL5R/7MOYmU2T/AFtcIRuKVIKSHiDOaI=;7:fgi7kcndp1VQSpvWaajmpOhm6YhvHoIZuFFftNa8KAuOG886BL4C0z+9xZYoI7v+oeWARnmA3GUrk5z4dxV1DF6ogV2gUoVSQlMzp8rNjFos0v+jSkpTYkt866QIV1kt3PLOObYwqRSnO4RQaTocZw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3f3d509b-8dec-4fad-5ba0-08d64840e3f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB3974;
x-ms-traffictypediagnostic: AM6PR04MB3974:
x-microsoft-antispam-prvs: <AM6PR04MB397491313626DA9449AA6EF984C10@AM6PR04MB3974.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(211936372134217)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231402)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB3974;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB3974;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(13464003)(66066001)(9686003)(76176011)(53936002)(446003)(25786009)(14454004)(2501003)(6436002)(476003)(316002)(3846002)(11346002)(2900100001)(55016002)(186003)(99286004)(6116002)(54906003)(68736007)(5660300001)(7416002)(486006)(33656002)(102836004)(105586002)(478600001)(8936002)(86362001)(2201001)(256004)(74316002)(8676002)(71190400001)(81156014)(106356001)(81166006)(97736004)(2906002)(229853002)(110136005)(71200400001)(7696005)(305945005)(6246003)(4326008)(26005)(53546011)(6506007)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB3974;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5OQf4b/6i3MTHRBfpMVAhp0oMCXpqQqnwLmj3Ck2HvGL+lRUegKGTlJfAnjnV+KnBoc6SiL+tCxOpzizG0ko/oU7WGaaD1QxpVRm0P75cJEse6TKYuZHZVy9qe21tNQVZBT26REPI/xtIsLpHILoCWBdi93iUyplChe6fum4cBJIvYEF7Adwgn8K0pqcxQ0em0E4i2ot4NdXfttSvDBvodcdS3ZNDL+EJWabxS1XiPtYbOhpugN7k2YDHl3Oz4jpxQ9nvd3chhdFgB6nV2KKrLW9RDsXMuz1oSvFN8Rb0gviJlgbXgXGLHhmBuKCnxfh0bKOG5ItD0m9fM27BB85urJurlyTTrxJ3m+zXq6yHg4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d509b-8dec-4fad-5ba0-08d64840e3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 01:48:05.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3974
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTGVvLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvIExpDQo+IFNlbnQ6IDIwMTjE6jEx1MI5yNUg
NToyOQ0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPjsgbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxh
bmRAYXJtLmNvbTsgbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbjsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogTWluZ2thaSBIdSA8bWlu
Z2thaS5odUBueHAuY29tPjsgTS5oLiBMaWFuDQo+IDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBY
aWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCAy
MS8yM10gZHQtYmluZGluZ3M6IHBjaTogQWRkIE5YUCBMWCBTb0NzIFBDSWUgY29udHJvbGxlcg0K
PiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogWi5x
LiBIb3UNCj4gPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA2LCAyMDE4IDc6MjEgQU0NCj4gPiBU
bzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVs
Lm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+ID4gbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5j
by5pbjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+ID4gPGxlb3lhbmcubGlAbnhwLmNv
bT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gPiBDYzogTWluZ2thaSBIdSA8bWluZ2th
aS5odUBueHAuY29tPjsgTS5oLiBMaWFuDQo+ID4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhp
YW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPjsgWi5xLg0KPiBIb3UNCj4gPiA8emhpcWlh
bmcuaG91QG54cC5jb20+DQo+ID4gU3ViamVjdDogW1BBVENIIDIxLzIzXSBkdC1iaW5kaW5nczog
cGNpOiBBZGQgTlhQIExYIFNvQ3MgUENJZQ0KPiA+IGNvbnRyb2xsZXINCj4gPg0KPiA+IEZyb206
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBBZGQgUENJZSBj
b250cm9sbGVyIERUIGJpbmRpbmdzIG9mIE5YUCBMWCBzZXJpZXMgU29Dcy4NCj4gDQo+IEknbSBu
b3Qgc3VyZSBpZiB0aGlzIGlzIGEgZ29vZCBpZGVhIHRvIG5hbWUgdGhpcyBjb250cm9sbGVyIExY
IFBDSWUgY29udHJvbGxlci4NCj4gUmlnaHQgbm93LCBpdCBjb3VsZCBiZSB0cnVlIHRoYXQgaXQg
aXMgb25seSB1c2VkIG9uIExYIHNlcmllcyBTb0NzLiAgQnV0IEknbSBub3QNCj4gc3VyZSBpZiB0
aGUgTFMgc2VyaWVzIHdpbGwgbm90IHVzZSB0aGlzIGNvbnRyb2xsZXIgb3IgTFggc2VyaWVzIHdp
bGwgb25seSB1c2UgdGhpcw0KPiBjb250cm9sbGVyIGluIHRoZSBmdXR1cmUuDQo+IA0KPiBTaW5j
ZSB0aGUgTFggc2VyaWVzIGlzIHN0aWxsIHVzaW5nIHRoZSBsYXllcnNjYXBlIGJyYW5kaW5nLCBz
byBwcm9iYWJseSB3ZQ0KPiBzaG91bGQga2VlcCB1c2luZyB0aGUgbGF5ZXJzY2FwZS1wY2kudHh0
IGFuZCBkZWZpbmUgdGhlIFBDSWUgR2VuNCB2YXJpYW50Pw0KDQpZZXMsIHdpbGwgYWRkIHRoZSBu
ZXcgUENJZSBJUCBiaW5kaW5ncyB0byBMYXllcnNjYXBlLXBjaS50eHQuDQoNCj4gDQo+IFNhbWUg
Y29tbWVudCBmb3Igb3RoZXIgcGxhY2VzIHVzaW5nIHRoZSBMWCBuYW1pbmcgaW4gdGhpcyBkcml2
ZXIuDQoNCkRvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9uIGFib3V0IGhvdyB0byBuYW1lIHRoZSBk
cml2ZXIgYW5kIHByZWZpeCBvZiBzdHJ1Y3R1cmVzIGluIHRoZSBkcml2ZXI/DQoNCj4gDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbHgtcGNpLnR4dCAgICAg
ICAgfCA1Mg0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDYwIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbHgtcGNpLnR4dA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbHgtcGNpLnR4dA0KPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9seC1wY2kudHh0DQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmRjNjAyZmVmOTNiMA0K
PiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL2x4LXBjaS50eHQNCj4gPiBAQCAtMCwwICsxLDUyIEBADQo+ID4gK05YUCBMWCBQ
Q0llIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK1RoaXMgUENJZSBjb250cm9sbGVyIGlzIGJhc2Vk
IG9uIHRoZSBNb2JpdmVpbCBQQ0llIElQIGFuZCB0aHVzDQo+ID4gK2luaGVyaXRzIGFsbCB0aGUg
Y29tbW9uIHByb3BlcnRpZXMgZGVmaW5lZCBpbiBtb2JpdmVpbC1wY2llLnR4dC4NCj4gPiArDQo+
ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGNvbnRh
aW4gdGhlIHBsYXRmb3JtIGlkZW50aWZpZXIgc3VjaCBhczoNCj4gPiArICAiZnNsLGx4MjE2MGEt
cGNpZSINCj4gPiArLSByZWc6IGJhc2UgYWRkcmVzc2VzIGFuZCBsZW5ndGhzIG9mIHRoZSBQQ0ll
IGNvbnRyb2xsZXIgcmVnaXN0ZXIgYmxvY2tzLg0KPiA+ICsgICJjb25maWdfYXhpX3NsYXZlIjog
UENJZSBjb250cm9sbGVyIHJlZ2lzdGVycw0KPiA+ICsgICJjc3JfYXhpX3NsYXZlIjogQnJpZGdl
IGNvbmZpZyByZWdpc3RlcnMNCj4gPiArLSBpbnRlcnJ1cHRzOiBBIGxpc3Qgb2YgaW50ZXJydXB0
IG91dHB1dHMgb2YgdGhlIGNvbnRyb2xsZXIuIE11c3QNCj4gPiArY29udGFpbiBhbg0KPiA+ICsg
IGVudHJ5IGZvciBlYWNoIGVudHJ5IGluIHRoZSBpbnRlcnJ1cHQtbmFtZXMgcHJvcGVydHkuDQo+
ID4gKy0gaW50ZXJydXB0LW5hbWVzOiBJdCBjb3VsZCBpbmNsdWRlIHRoZSBmb2xsb3dpbmcgZW50
cmllczoNCj4gPiArICAiaW50ciI6IFRoZSBpbnRlcnJ1cHQgdGhhdCBpcyBhc3NlcnRlZCBmb3Ig
Y29udHJvbGxlciBpbnRlcnJ1cHRzDQo+ID4gKyAgImFlciI6IEFzc2VydGVkIGZvciBhZXIgaW50
ZXJydXB0IHdoZW4gY2hpcCBzdXBwb3J0IHRoZSBhZXIgaW50ZXJydXB0DQo+IHdpdGgNCj4gPiAr
CQkgbm9uZSBNU0kvTVNJLVgvSU5UeCBtb2RlLGJ1dCB0aGVyZSBpcyBpbnRlcnJ1cHQgbGluZSBm
b3INCj4gPiBhZXIuDQo+ID4gKyAgInBtZSI6IEFzc2VydGVkIGZvciBwbWUgaW50ZXJydXB0IHdo
ZW4gY2hpcCBzdXBwb3J0IHRoZSBwbWUNCj4gPiArIGludGVycnVwdA0KPiA+IHdpdGgNCj4gPiAr
CQkgbm9uZSBNU0kvTVNJLVgvSU5UeCBtb2RlLGJ1dCB0aGVyZSBpcyBpbnRlcnJ1cHQgbGluZSBm
b3INCj4gPiBwbWUuDQo+ID4gKy0gZG1hLWNvaGVyZW50OiBJbmRpY2F0ZXMgdGhhdCB0aGUgaGFy
ZHdhcmUgSVAgYmxvY2sgY2FuIGVuc3VyZSB0aGUNCj4gPiArY29oZXJlbmN5DQo+ID4gKyAgb2Yg
dGhlIGRhdGEgdHJhbnNmZXJyZWQgZnJvbS90byB0aGUgSVAgYmxvY2suIFRoaXMgY2FuIGF2b2lk
IHRoZQ0KPiA+ICtzb2Z0d2FyZQ0KPiA+ICsgIGNhY2hlIGZsdXNoL2ludmFsaWQgYWN0aW9ucywg
YW5kIGltcHJvdmUgdGhlIHBlcmZvcm1hbmNlIHNpZ25pZmljYW50bHkuDQo+ID4gKy0gbXNpLXBh
cmVudCA6IFNlZSB0aGUgZ2VuZXJpYyBNU0kgYmluZGluZyBkZXNjcmliZWQgaW4NCj4gPiArICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvbXNp
LnR4dC4NCj4gPiArDQo+ID4gK0V4YW1wbGU6DQo+ID4gKw0KPiA+ICsJcGNpZUAzNDAwMDAwIHsN
Cj4gPiArCQljb21wYXRpYmxlID0gImZzbCxseDIxNjBhLXBjaWUiOw0KPiA+ICsJCXJlZyA9IDww
eDAwIDB4MDM0MDAwMDAgMHgwIDB4MDAxMDAwMDAgICAvKiBjb250cm9sbGVyDQo+ID4gcmVnaXN0
ZXJzICovDQo+ID4gKwkJICAgICAgIDB4ODAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMTAwMD47IC8q
IGNvbmZpZ3VyYXRpb24NCj4gPiBzcGFjZSAqLw0KPiA+ICsJCXJlZy1uYW1lcyA9ICJjc3JfYXhp
X3NsYXZlIiwgImNvbmZpZ19heGlfc2xhdmUiOw0KPiA+ICsJCWludGVycnVwdHMgPSA8R0lDX1NQ
SSAxMDggSVJRX1RZUEVfTEVWRUxfSElHSD4sIC8qIEFFUg0KPiA+IGludGVycnVwdCAqLw0KPiA+
ICsJCQkgICAgIDxHSUNfU1BJIDEwOCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogUE1FDQo+ID4g
aW50ZXJydXB0ICovDQo+ID4gKwkJCSAgICAgPEdJQ19TUEkgMTA4IElSUV9UWVBFX0xFVkVMX0hJ
R0g+OyAvKg0KPiA+IGNvbnRyb2xsZXIgaW50ZXJydXB0ICovDQo+ID4gKwkJaW50ZXJydXB0LW5h
bWVzID0gImFlciIsICJwbWUiLCAiaW50ciI7DQo+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47
DQo+ID4gKwkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKwkJZGV2aWNlX3R5cGUgPSAicGNpIjsN
Cj4gPiArCQlhcGlvLXdpbnMgPSA8OD47DQo+ID4gKwkJcHBpby13aW5zID0gPDg+Ow0KPiA+ICsJ
CWRtYS1jb2hlcmVudDsNCj4gPiArCQlidXMtcmFuZ2UgPSA8MHgwIDB4ZmY+Ow0KPiA+ICsJCW1z
aS1wYXJlbnQgPSA8Jml0cz47DQo+ID4gKwkJcmFuZ2VzID0gPDB4ODIwMDAwMDAgMHgwIDB4NDAw
MDAwMDAgMHg4MCAweDQwMDAwMDAwIDB4MA0KPiA+IDB4NDAwMDAwMDA+Ow0KPiA+ICsJCSNpbnRl
cnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4gKwkJaW50ZXJydXB0LW1hcC1tYXNrID0gPDAgMCAwIDc+
Ow0KPiA+ICsJCWludGVycnVwdC1tYXAgPSA8MDAwMCAwIDAgMSAmZ2ljIEdJQ19TUEkgMTA5DQo+
ID4gSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKwkJCQk8MDAwMCAwIDAgMiAmZ2ljIEdJQ19T
UEkgMTEwDQo+ID4gSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKwkJCQk8MDAwMCAwIDAgMyAm
Z2ljIEdJQ19TUEkgMTExDQo+ID4gSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4gKwkJCQk8MDAw
MCAwIDAgNCAmZ2ljIEdJQ19TUEkgMTEyDQo+ID4gSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4g
Kwl9Ow0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTIGluZGV4DQo+
ID4gMGM1N2NjZmYzMTg4Li43ZGE1NTVjOGUyZjUgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5F
UlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0xMTI1Miw2ICsxMTI1MiwxNCBAQCBM
OglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiAgUzoJTWFpbnRhaW5l
ZA0KPiA+ICBGOglkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy8qbGF5ZXJzY2FwZSoNCj4gPg0K
PiA+ICtQQ0kgRFJJVkVSIEZPUiBOWFAgTFgNCj4gPiArTToJSG91IFpoaXFpYW5nIDxaaGlxaWFu
Zy5Ib3VAbnhwLmNvbT4NCj4gPiArTDoJbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiA+ICtM
OglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiArUzoJTWFpbnRhaW5l
ZA0KPiA+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2x4LXBjaS50
eHQNCj4gPiArRjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpYmVpbC9wY2ktbHguYw0KPiA+
ICsNCj4gPiAgUENJIERSSVZFUiBGT1IgR0VORVJJQyBPRiBIT1NUUw0KPiA+ICBNOglXaWxsIERl
YWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4NCj4gPiAgTDoJbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZw0KPiA+IC0tDQo+ID4gMi4xNy4xDQpUaGFua3MsDQpaaGlxaWFuZw0K
