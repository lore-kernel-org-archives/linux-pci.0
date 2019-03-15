Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7549AC43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 01:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337922186A
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 01:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYA1ZWiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCOBZc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 21:25:32 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:31822
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727284AbfCOBZc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Mar 2019 21:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNYLUkUmLJrLWuQA/dfYMQE1vrHn4qiHG2A6W5xDkWc=;
 b=UYA1ZWiJYh8b9YfCz0JQB1gsfRnZHkNR0YU4+bJIwlkbgsj1HFlOlkdBN2bXqOEIky8Tnb4fdRHhh4HgjdbbDEc5mU0KnYikRl1Rip+HeWoma+8A4kY60bzfnHe75z0ldRDkLNetoPArIiRAZMjn3J8UYAePvRXfnqh9uiGA9WM=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3346.eurprd04.prod.outlook.com (52.133.49.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 01:25:26 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::c9e:21a8:3eae:bdeb]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::c9e:21a8:3eae:bdeb%3]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 01:25:26 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/2] dt-bindings: imx6q-pcie: Add support for i.MX8QM/QXP
 PCIe
Thread-Topic: [RFC 1/2] dt-bindings: imx6q-pcie: Add support for i.MX8QM/QXP
 PCIe
Thread-Index: AQHU2X1M51QS3U2KCE+Hs+Chb2DsbqYK3iYAgAEKb6A=
Date:   Fri, 15 Mar 2019 01:25:25 +0000
Message-ID: <AM0PR0402MB3570D5ECD699F57FA5E5F88C8C440@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
 <1552555830.2453.57.camel@pengutronix.de>
In-Reply-To: <1552555830.2453.57.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e25702-432a-4a31-948c-08d6a8e51a4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3346;
x-ms-traffictypediagnostic: AM0PR0402MB3346:
x-microsoft-antispam-prvs: <AM0PR0402MB3346D8B746ADF8ACC2B05A398C440@AM0PR0402MB3346.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(199004)(189003)(13464003)(6116002)(52536014)(74316002)(76176011)(7696005)(6246003)(8676002)(9686003)(316002)(86362001)(4326008)(55016002)(478600001)(5660300002)(2201001)(66066001)(14454004)(476003)(81156014)(53546011)(6506007)(102836004)(6436002)(25786009)(81166006)(6346003)(11346002)(2501003)(71190400001)(71200400001)(99286004)(8936002)(256004)(53936002)(14444005)(97736004)(7736002)(106356001)(305945005)(110136005)(68736007)(229853002)(54906003)(486006)(2906002)(33656002)(446003)(3846002)(26005)(105586002)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3346;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tX1vCn2FAvw0bGV70CXqnR4R/OHb6CCAU4+ccUVoO7qPuvWEuZvE6cWsOvzmBGwkmbQDfpCe8a8SZsq6xTg0rMSjpIsYt8aiFNZhq9BXhyi/uuKCUyh+sjm2RnimPNe/RobzxbSIqQt1UanyekwIlXgUDK8MSYcTUuZk4hfEq2e1NsV6DetkyjVUzOyQtYPGL77uFkrxGJuLLtxq0cb4aQtFC0vjx7IRuCdR68m8D1F7BO5osOHyodoovNjDyHr5PUpCxYH/UlqmFsgmfhuTxNJBfcu5nhyczXyL1nI3xrQMijRGiRvNlFnBl0uvy1ppOFlJ+GO7VMmn5+IIqvgPCBaHB/Ssfpui3HiuI/PAaytRzNVWKSbu/d8tiquV1h8Hkt96hd70NUF11geipBBHVrMxL5C2h88jHgGFKgAz/0s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e25702-432a-4a31-948c-08d6a8e51a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 01:25:26.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3346
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTHVjYXM6DQpUaGFua3MgZm9yIHlvdXIgcmVpdmV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIFttYWlsdG86bC5zdGFjaEBwZW5ndXRyb25p
eC5kZV0NCj4gU2VudDogMjAxOeW5tDPmnIgxNOaXpSAxNzozMQ0KPiBUbzogUmljaGFyZCBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgYW5kcmV3LnNtaXJub3ZAZ21haWwuY29tDQo+IENjOiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgMS8y
XSBkdC1iaW5kaW5nczogaW14NnEtcGNpZTogQWRkIHN1cHBvcnQgZm9yIGkuTVg4UU0vUVhQDQo+
IFBDSWUNCj4gDQo+IEhpIFJpY2hhcmQsDQo+IA0KPiBBbSBNaXR0d29jaCwgZGVuIDEzLjAzLjIw
MTksIDA5OjE1ICswMDAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQWRkIGNvZGVzIG5lZWRl
ZCB0byBzdXBwb3J0IGkuTVg4UU0vUVhQIFBDSWUuDQo+ID4gLSBIU0lPKEhpZ2ggU3BlZWQgSU8p
IHN1YnN5c3RlbSBpcyBuZXcgZGVmaW5lZCBvbiBpLk1YOFFNL1FYUC4NCj4gPiDCoCBUaGUgUENJ
ZSBhbmQgU0FUQSBtb2R1bGVzIGFyZSBjb250YWluZWQgaW4gdGhlIEhTSU8gc3Vic3lzdGVtLiBU
aGVyZQ0KPiA+IMKgIGFyZSB0d28gUENJZSwgb25lIFNBVEEgY29udHJvbGxlcnMgYW5kIHRocmVl
IG1peGVkIGxhbmUgUEhZcyBvbg0KPiA+IMKgIGkuTVg4UU0uIFRoZXJlIGFyZSB0aHJlZSB1c2Ug
Y2FzZXMgb2YgdGhlIEhTSU8gc3Vic3lzdGVtIG9uDQo+IGkuTVg4UU0uDQo+ID4gwqAgMS4gUENJ
ZWEgMiBsYW5lcyBhbmQgb25lIFNBVEEgQUhDSSBwb3J0Lg0KPiA+IMKgIDIuIFBDSWVhIDEgbGFu
ZSwgUENJZWIgMSBsYW5lIGFuZCBvbmUgU0FUQSBBSENJIHBvcnQuDQo+ID4gwqAgMy4gUENJZWEg
MiBsYW5lcywgUENJZWIgMSBsYW5lLg0KPiA+IMKgIGkuTVg4UVhQIG9ubHkgaGFzIFBDSWViIGNv
bnRyb2xsZXIgYW5kIG9uZSBsYW5lIFBIWS4NCj4gPiDCoCBVc2UgdGhlIGhzaW8tY2ZnIHByb3Bl
cnR5IHRvIHNwZWNpZnkgdGhlIGRpZmZlcmVudCBtb2Rlcy4NCj4gPiAtIFRoZSBIU0lPIGFkZHJl
c3MgbWFwIGFzIHZpZXdlZCBmcm9tIHN5c3RlbSBsZXZlbCBpcyBhcyBzaG93biBiZWxvdy4NCj4g
PiDCoCBhZGRyZXNzIFszMToyNF3CoMKgwqDCoExvY2FsIGFkZHJlc3PCoMKgwqDCoFRhcmdldMKg
wqDCoMKgQWRkcmVzcyBTaXplDQo+ID4gwqAgNUbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgSFNJT8KgwqDCoMKgwqDCoDE2
DQo+IE1CDQo+ID4gwqAgNjAtNkbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgNDAtNEbCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBIU0lPwqDCoMKgwqDCoMKgMjU2TUINCj4gPiDCoCA3MC03RsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA4MC04RsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEhT
SU/CoMKgwqDCoMKgwqAyNTZNQg0KPiA+IMKgIFRoZSBwcm9wZXJ0eSBsb2NhbC1hZGRyIGlzIHJl
cXVpcmVkIHRvIHNwZWNpZnkgaXQuDQo+ID4gLSBCb3RoIGV4dGVybmFsIE9TQyBhbmQgaW50ZXJu
YWwgUExMIGNhbiBiZSB1c2VkIGFzIFBDSWUgcmVmZXJlbmNlDQo+ID4gwqAgY2xvY2ssIHVzZSB0
aGUgZXh0X29zYyBwcm9wZXJ0eSB0byBkaXN0aW5ndWlzaCB0aGVtLg0KPiA+IC0gY2xvY2sgcmVx
dWVzdCBHUElPIGZvciBjb250cm9sbGluZyB0aGUgUENJIHJlZmVyZW5jZSBjbG9jayByZXF1ZXN0
DQo+ID4gwqAgc2lnbmFsLiBBbmQgc2hvdWxkIGJlIGNvbmZpZ3VyZSBPRCB3aGVuIEwxU1MgbWF5
YmUgZW5hYmxlZCBsYXRlci4NCj4gPiAtIE9uZSBtb3JlIHBvd2VyIGRvbWFpbiBIU0lPX0dQSU8g
YW5kIGNsb2NrIFBDSUVfUEVSIGFyZSByZXF1aXJlZCBieQ0KPiA+IMKgIGkuTVg4UU0vUVhQIFBD
SWUuDQo+ID4gwqAgQWRkIHRoZXNlIHNwZWNpZmljIHByb3BlcnRpZXMgdG8gZW5hYmxlIGkuTVg4
UU0vUVhQIFBDSWUuDQo+IA0KPiBBbGwgdGhpcyBIU0lPIGhhbmRsaW5nIHNob3VsZCBtb3ZlIGlu
dG8gYSBzZXBhcmF0ZSBQSFkgZHJpdmVyLiBUaGlzIGhhcw0KPiBub3RoaW5nIHRvIGRvIHdpdGgg
dGhlIFBDSWUgY29udHJvbGxlciBpdHNlbGYuIFNlZSBmb3IgZXhhbXBsZSB0aGUgVGVncmEgWFVT
Qg0KPiBQSFkgZHJpdmVyIChkcml2ZXJzL3BoeS90ZWdyYS94dXNiLmMpLCB3aGljaCBpcyBhIHNp
bWlsYXIgY29tYmluZWQNCj4gUENJRS9VU0IzL1NBVEEgUEhZIGRyaXZlci4NCj4gDQpbUmljaGFy
ZCBaaHVdIFZlcnkgZ29vZCBzdWdnZXN0aW9uLCB3b3VsZCBtYWtlIHJlZmVyZW5jZSB0byBpdCBh
bmQgcmUtb3JhbmdlIHRoZSBjb2Rlcy4NClRoYW5rcy4NCg0KPiBSZWdhcmRzLA0KPiBMdWNhcw0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBj
aWUudHh0wqDCoMKgwqDCoMKgfCAyMQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4dA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNp
ZS50eHQNCj4gPiBpbmRleCBhN2Y1ZjVhLi5mNzU4NmM5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUudHh0DQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNp
ZS50eHQNCj4gPiBAQCAtMTAsNiArMTAsOCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4g
wqAJLSAiZnNsLGlteDZxcC1wY2llIg0KPiA+ID4gwqAJLSAiZnNsLGlteDdkLXBjaWUiDQo+ID4g
PiDCoAktICJmc2wsaW14OG1xLXBjaWUiDQo+ID4gPiArCS0gImZzbCxpbXg4cW0tcGNpZSINCj4g
PiA+ICsJLSAiZnNsLGlteDhxeHAtcGNpZSINCj4gPiDCoC0gcmVnOiBiYXNlIGFkZHJlc3MgYW5k
IGxlbmd0aCBvZiB0aGUgUENJZSBjb250cm9sbGVyDQo+ID4gwqAtIGludGVycnVwdHM6IEEgbGlz
dCBvZiBpbnRlcnJ1cHQgb3V0cHV0cyBvZiB0aGUgY29udHJvbGxlci4gTXVzdA0KPiA+IGNvbnRh
aW4gYW4NCj4gPiDCoMKgwqBlbnRyeSBmb3IgZWFjaCBlbnRyeSBpbiB0aGUgaW50ZXJydXB0LW5h
bWVzIHByb3BlcnR5Lg0KPiA+IEBAIC0zOCw2ICs0MCwxMCBAQCBPcHRpb25hbCBwcm9wZXJ0aWVz
Og0KPiA+IMKgwqDCoFRoZSByZWd1bGF0b3Igd2lsbCBiZSBlbmFibGVkIHdoZW4gaW5pdGlhbGl6
aW5nIHRoZSBQQ0llIGhvc3QgYW5kDQo+ID4gwqDCoMKgZGlzYWJsZWQgZWl0aGVyIGFzIHBhcnQg
b2YgdGhlIGluaXQgcHJvY2VzcyBvciB3aGVuIHNodXR0aW5nIGRvd24NCj4gPiB0aGUNCj4gPiDC
oMKgwqBob3N0Lg0KPiA+ICstIGNsa3JlcS1ncGlvOiBTaG91bGQgc3BlY2lmeSB0aGUgR1BJTyBm
b3IgY29udHJvbGxpbmcgdGhlIFBDSQ0KPiA+ICtyZWZlcmVuY2UgY2xvY2sNCj4gPiArwqDCoHJl
cXVlc3Qgc2lnbmFsLg0KPiA+ICstIGV4dF9vc2M6IEV4dGVybmFsIE9TQyBpcyB1c2VkIGFzIFBD
SWUgcmVmZXJlbmNlIGNsb2NrIG9yIG5vdC4gMDoNCj4gPiArSW50ZXJuYWwNCj4gPiArwqDCoFBM
TC4gMTogRXh0ZXJuYWwgT1NDLg0KPiA+DQo+ID4gwqBBZGRpdGlvbmFsIHJlcXVpcmVkIHByb3Bl
cnRpZXMgZm9yIGlteDZzeC1wY2llOg0KPiA+IMKgLSBjbG9jayBuYW1lczogTXVzdCBpbmNsdWRl
IHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBlbnRyaWVzOg0KPiA+IEBAIC02MCw2ICs2NiwyMSBA
QCBBZGRpdGlvbmFsIHJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIGlteDhtcS1wY2llOg0KPiA+IMKg
LSBjbG9jay1uYW1lczogTXVzdCBpbmNsdWRlIHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBlbnRy
aWVzOg0KPiA+ID4gwqAJLSAicGNpZV9hdXgiDQo+ID4NCj4gPiArQWRkaXRpb25hbCByZXF1aXJl
ZCBwcm9wZXJ0aWVzIGZvciBpbXg4cW0vcXhwIHBjaWU6DQo+ID4gKy0gcG93ZXItZG9tYWluczog
TXVzdCBiZSBzZXQgdG8gYSBwaGFuZGxlIHBvaW50aW5nIHRvIFBDSUUsIFBDSUVfUEhZDQo+ID4g
K3Bvd2VyIGFuZA0KPiA+ICvCoMKgSFNJT19HUElPIGRvbWFpbnMNCj4gPiArLSBwb3dlci1kb21h
aW4tbmFtZXM6IE11c3QgYmUgInBjaWUiLCAicGNpZV9waHkiLCAiaHNpb19ncGlvIg0KPiA+ICst
IGNsb2NrLW5hbWVzOiBNdXN0IGluY2x1ZGUgdGhlIGZvbGxvd2luZyBhZGRpdGlvbmFsIGVudHJp
ZXM6DQo+ID4gPiArCS0gInBjaWVfcGVyIg0KPiA+ICstIGhzaW8tY2ZnOiBoc2lvIGNvbmZpZ3Jh
dGlvbiBtb2RlIHdoZW4gdGhlIHBjaWUgbm9kZSBpcyBzdXBwb3J0ZWQuDQo+ID4gK8KgwqAxOiBw
Y2llYSAyIGxhbmVzIGFuZCBvbmUgc2F0YSBhaGNpIHBvcnQuDQo+ID4gK8KgwqAyOiBwY2llYSAx
IGxhbmUsIHBjaWViIDEgbGFuZSBhbmQgb25lIHNhdGEgYWhjaSBwb3J0Lg0KPiA+ICvCoMKgMzog
cGNpZWEgMiBsYW5lcywgcGNpZWIgMSBsYW5lLg0KPiA+ICstIGxvY2FsLWFkZHI6IHRoZSBsb2Nh
bCBhZGRyZXNzIHVzZWQgaW4gaHNpbyBtb2R1bGUgb24gaS5NWDhRTS9RWFAuDQo+ID4gPiArCUV4
YW1wbGU6DQo+ID4gPiArCQloc2lvLWNmZyA9IDwyPjsNCj4gPiA+ICsJCWxvY2FsLWFkZHIgPSA8
MHg4MDAwMDAwMD47DQo+ID4gKw0KPiA+IMKgRXhhbXBsZToNCj4gPg0KPiA+ID4gwqAJcGNpZUAw
MTAwMDAwMCB7DQo=
