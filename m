Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B91C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3020882
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 10:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PhI3QR5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED3020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeLMKVS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:21:18 -0500
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:13973
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727647AbeLMKVR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 05:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJLg+yVgbkkuLN79OZ4FXPcjpRKFQYj2cfAawgvYDp8=;
 b=PhI3QR5CC/8QOzUdXmnwqX71B+yMq22EFXc0raGfakfN8l+UOYagjiBKGQtaYwNcYMUl44MDtzJ2N75+bKYjyY2dnA/vEtcsmhUag9K2fPRszg0JXTOBPrTkfFjf3rIfBCd1eaX2e3FSllwvR7IE1e0OwhOotJ5LMKq2KyHoWpk=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3764.eurprd04.prod.outlook.com (52.133.39.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 10:21:11 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 10:21:11 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v2] PCI: imx: make msi work without pcieportbus
Thread-Topic: [v2] PCI: imx: make msi work without pcieportbus
Thread-Index: AQHUkron3jfJ309qkk6cQky/juy8waV8ZHAAgAAINuCAAAUlAIAAAqIg
Date:   Thu, 13 Dec 2018 10:21:11 +0000
Message-ID: <AM0PR0402MB3570AE67BDF0391481EC13998CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
         <1544692768.3137.25.camel@pengutronix.de>
         <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
 <1544695636.3137.27.camel@pengutronix.de>
In-Reply-To: <1544695636.3137.27.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3764;6:BNtv2Wq+zDh0YVoaH5yqgknIVua+lPWMw+63fYEBUlLa3vTK43F1o1aBYEuXFw1ecCO3wU0cyvicu0awRcKVN7kYMkH78lf+YZolMqKmk3pWF0pt5zOZZNBGZGlqeboFMFGEAuSfK8UXpx1mc7IamIk7vO6ZCcBV3aYK9ysOOg0LBoig6agmnzk5Zyi1+0s4grm0q/I6LfkTcE33l3K4Ok5Ex3oM9OKx+by7gGnZTTJH5culqJXAOc2ALCdXTnTpYqe8aRG+nEImPuGbPNZ0IJqI9x8n+PktbwJQ+lddvtQ0yOfNSDziU0teRqfc9qsxkR2BuBkawGUmxk++y8z2lx9pjuJqX19ct/MituzH6IP0FZVt8onC1xuqczUFxqLPic4EzGNMSZ5lOQB4xcGJwt07tvk7bhXg2y5Bnw+dIuW5B/lzFFkt+kvGKHnWOuDglVlDGNdvRlQkhVZ9rnWcdw==;5:yjoVwCZSN14F+9prl1GKydhZ7m8rNa7coFUyhBsjRMRrCzW/tgN83Fe1XkInsphw4DZRuIIMs4qtD/WVWrWhPuzZd3YpbVbvc3lWn9PCBhDmwtufd13f3s8XLbtH/RDG2I1pHkkk+sGhz+UXObkrMd37jaGhYCJtn7/crPbfkoM=;7:fiQzj04zPb2/j3TnKXVwMWFYdDXHDqrHCtE0oEw8mmOgvuwK2wm8wkMRNDB1ctoYKLy5A9ZB3iFRH11GzX+KCLTEk8eux2Q4dTx+HLcLPGSerFjCtQL9+AIIK1oUwFUGkHf8iN1ho+J7e7Od1/t1gg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: db943c5e-0b77-4481-ccf9-08d660e4b43f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3764;
x-ms-traffictypediagnostic: AM0PR0402MB3764:
x-microsoft-antispam-prvs: <AM0PR0402MB3764B605DE7717B254FF37C78CA00@AM0PR0402MB3764.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3764;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3764;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(13464003)(106356001)(9686003)(6436002)(105586002)(2201001)(229853002)(14454004)(478600001)(476003)(486006)(256004)(25786009)(86362001)(55016002)(11346002)(446003)(2501003)(99286004)(71200400001)(71190400001)(33656002)(97736004)(68736007)(74316002)(6116002)(26005)(4326008)(186003)(102836004)(305945005)(76176011)(81156014)(8676002)(53546011)(2906002)(7696005)(6506007)(66066001)(8936002)(54906003)(5660300001)(7736002)(110136005)(53936002)(3846002)(93886005)(81166006)(316002)(39060400002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3764;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sSmvfVX6RKmcQXaKIJONVUoJVzrJRR1CyOySJsHfzE721BDIPXCx2Fo2DEeshueMKoSpbzrL0J7hRcsW4+5l+gUELOlBcfGBd8fPqQ3NJTlMbwEQSZqpKEmimWtIIoZ9NKhV+vQ91ObGt35Wm+4PXtb/RK1p28FUPAZJ3AHNAyN0tKHvRox9by9hWvVvtBVlMXrdan/A+kSxPTfY8xq483CoBd42OcqX6zuiKEEO2DpIoXcdmx2asmTnYWzOY1HHOUB6NNX3x/8lpLwVnjkq1+7/zQkxz9n8wWMFPtSeHS2Xxx4U9oyUIJIiSi6tWp+y
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db943c5e-0b77-4481-ccf9-08d660e4b43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 10:21:11.1193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3764
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1Y2FzIFN0YWNoIFttYWls
dG86bC5zdGFjaEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogMjAxOOW5tDEy5pyIMTPml6UgMTg6
MDcNCj4gVG86IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdv
b2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGFuZHJldy5zbWlybm92QGdt
YWlsLmNvbQ0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFJlOiBbdjJdIFBDSTogaW14OiBtYWtlIG1zaSB3b3JrIHdpdGhvdXQgcGNpZXBv
cnRidXMNCj4gDQo+IEFtIERvbm5lcnN0YWcsIGRlbiAxMy4xMi4yMDE4LCAwOTo1NyArMDAwMCBz
Y2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IEhpIEx1Y2FzOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IEx1Y2FzIFN0YWNoIFttYWlsdG86bC5z
dGFjaEBwZW5ndXRyb25peC5kZV0NCj4gPiA+IFNlbnQ6IDIwMTjlubQxMuaciDEz5pelIDE3OjE5
DQo+ID4gPiA+ID4gPiA+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBi
aGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgYW5k
cmV3LnNtaXJub3ZAZ21haWwuY29tDQo+ID4gPiA+ID4gPiA+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gPiA+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0
OiBSZTogW3YyXSBQQ0k6IGlteDogbWFrZSBtc2kgd29yayB3aXRob3V0IHBjaWVwb3J0YnVzDQo+
ID4gPg0KPiA+ID4gSGkgUmljaGFyZCwNCj4gPiA+DQo+ID4gPiBBbSBEb25uZXJzdGFnLCBkZW4g
MTMuMTIuMjAxOCwgMDg6MDIgKzAwMDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiA+ID4gTVNJ
X0VOIG9mIGlNWCBQQ0llIFJDIHdvdWxkIGJlIGFzc2VydGVkIHdoZW4gUENJRVBPUlRCVVMgZHJp
dmVyIGlzDQo+ID4gPiA+IHNlbGVjdGVkLg0KPiA+ID4gPiBUaHVzLCB0aGUgTVNJIHdvcmtzIGZp
bmUgb24gaU1YIFBDSWUgYmVmb3JlLg0KPiA+ID4gPiBBc3NlcnQgaXQgdW5jb25kaXRpb25hbGx5
IHdoZW4gTVNJIGlzIHN1cHBvcnRlZC4NCj4gPiA+ID4gT3RoZXJ3aXNlLCB0aGUgTVNJIHdvdWxk
bid0IGJlIHRyaWdnZXJlZCBhbHRob3VnaCB0aGUgRVAgaXMNCj4gPiA+ID4gcHJlc2VudCBhbmQg
dGhlIE1TSXMgYXJlIGFzc2lnbmVkLg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgZGlnZ2luZyBp
bnRvIHRoaXMgaXNzdWUuIFRoaXMgc2VlbXMgbGlrZSB0aGUgcmlnaHQgd2F5IGZvcndhcmQuDQo+
ID4gPiBIb3dldmVyLCBkaWQgeW91IHRlc3QgdGhpcyB3aXRoIGRldmljZXMgdXNpbmcgbGVnYWN5
IElSUXM/DQo+ID4gPiBJLmUuIGJvb3Rpbmcgd2l0aCAibm9tc2kiIG9uIHRoZSBrZXJuZWwgY29t
bWFuZCBsaW5lIHRvIHNlZSBpZg0KPiA+ID4gbGVnYWN5IElSUXMgc3RpbGwgd29yayBpZiB0aGlz
IGJpdCBpcyBzZXQsIG9yIGlmIHdlIG5lZWQgdG8gYXZvaWQNCj4gPiA+IHNldHRpbmcgdGhpcyB3
aGVuIHRoZSB1c2VyIGV4cGxpY2l0bHkgcmVxdWVzdHMgdG8gZGlzYWJsZSBNU0lzPw0KPiA+ID4N
Cj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBMdWNhcw0KPiA+ID4NCj4gPg0KPiA+IFtSaWNoYXJkIFpo
dV0gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gPiBUaGUgTGVnYWN5IElOVHggaXMgYnJva2Vu
Lg0KPiA+IFRoZSBNU0lfRU4gYml0IHNob3VsZG4ndCBiZSBhc3NlcnRlZCB3aGVuIHRoZSB1c2Vy
IGV4cGxpY2l0bHkgcmVxdWVzdHMgdG8NCj4gZGlzYWJsZSBNU0lzLg0KPiANCj4gT2theSwgc28g
dGhpcyBwYXRjaCBzaG91bGQgYmUgZXh0ZW5kZWQgd2l0aCBhIGNoZWNrIGZvcg0KPiBwY2lfbXNp
X2VuYWJsZWQoKSB0byBzZWUgaWYgdGhlIHVzZXIgZXhwbGljaXRseSB3YW50IGxlZ2FjeSBJUlFz
Lg0KPiANCj4gPiBCVFcsIHJlZ2FyZGluZyB0byBCYXJ1Y2gncyBjb21tZW50cywgaXQgc2VlbXMg
dGhhdCBhbGwgdGhlDQo+ID4gKElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kpIGNoZWNrIGluDQo+
ID4gwqB0aGUgZHdjIGhvc3QgZHJpdmVycyBhcmUgbm90IHJlcXVpcmVkIGFueW1vcmUsIHNpbmNl
IHRoZSBkZXBlbmRzIG9uDQo+IFBDSV9NU0lfSVJRX0RPTUFJTiwgcmlnaHQ/DQo+IA0KPiBUaGF0
J3MgY29ycmVjdC4gVGhpcyBpcyBtb3N0bHkgYSBoaXN0b3JpY2FsIGFydGlmYWN0IGZyb20gdGhl
IHRpbWUgd2hlbiAgd2UNCj4gd2VyZSBhYmxlIHRvIGJ1aWxkIHdpdGhvdXQgTVNJIHN1cHBvcnQu
IFRob3NlIGNoZWNrcyBjb3VsZCBiZSBjbGVhbmVkIHVwDQo+IG5vdyB0aGF0IHdlIGRlcGVuZCBv
biB0aGUgTVNJIG9wdGlvbnMuDQo+IA0KW1JpY2hhcmQgWmh1XSBHcmVhdC4gVGhhbmtzIEJhcnVj
aCBhbmQgTHVjYXMuDQpJIHdvdWxkIHNlbmQgdGhlIHYzIHBhdGNoIGEgbW9tZW50IGxhdGVyIHdp
dGggdGhlIHBjaV9tc2lfZW5hYmxlZCgpIGNoZWNrIHdoZW4NCmFzc2VydCB0aGUgTVNJX0VOIG9m
IFJDLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gUmVnYXJkcywNCj4gTHVjYXMN
Cg==
