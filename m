Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C34C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A923F2171F
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="PaYW5+JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDLSDe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:03:34 -0400
Received: from mail-eopbgr760115.outbound.protection.outlook.com ([40.107.76.115]:37504
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbfDLSDd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 14:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx6As8IBVyZ7wB8QdnDMrwgEgIFD38j2HSSanowKkEg=;
 b=PaYW5+JON1TlCwUcO+OaDnbzqEUmjnsfI6s5QHkHxGZWO3Q6Gudv1ajyAGJZ6UhsUgBIzUB4R6sd8MmjAy9tb1TynBXmVD8ldYoyx5ydKBj9rAu658GvdQ+I0XF0I7nnC9yM6k0g0BLGMbys3WQlY7TlehxKtUn+08IFzQ+IRRc=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3674.namprd06.prod.outlook.com (10.167.236.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Fri, 12 Apr 2019 18:03:30 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::fdcc:6c58:2101:a81a]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::fdcc:6c58:2101:a81a%5]) with mapi id 15.20.1771.016; Fri, 12 Apr 2019
 18:03:30 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Topic: [PATCH] PCI: imx6: Simplify Kconfig depends on
Thread-Index: AQHU2DyNuTuwA21czUeOVRo2YY20PKY5A5YA
Date:   Fri, 12 Apr 2019 18:03:29 +0000
Message-ID: <1555092208.2142.50.camel@impinj.com>
References: <e3fd8e88a22468be8bd8fce85dafcc14f2e6a618.1552330407.git.leonard.crestez@nxp.com>
         <20190326181912.GB12093@e107981-ln.cambridge.arm.com>
         <VI1PR04MB5533A64718D373F9F8357BCDEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533A64718D373F9F8357BCDEE280@VI1PR04MB5533.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c91f1384-f180-4051-3698-08d6bf712b73
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR0601MB3674;
x-ms-traffictypediagnostic: MWHPR0601MB3674:
x-microsoft-antispam-prvs: <MWHPR0601MB36749148BD80F45D27B6CCE2D3280@MWHPR0601MB3674.namprd06.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(376002)(346002)(189003)(199004)(103116003)(54906003)(6506007)(305945005)(53546011)(66066001)(105586002)(486006)(99286004)(25786009)(106356001)(2906002)(14444005)(478600001)(256004)(14454004)(53936002)(11346002)(71200400001)(26005)(71190400001)(36756003)(316002)(446003)(186003)(110136005)(476003)(2501003)(6512007)(3846002)(97736004)(5660300002)(81166006)(4326008)(6116002)(68736007)(86362001)(7736002)(8936002)(76176011)(6436002)(81156014)(6486002)(102836004)(2616005)(8676002)(6246003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3674;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CGNIrlXA+aVQnQ/Rvk5Rs5PBjY62tG6DBcr7wetHt3lvA/C+g/XiK3huZz28wmYwDlrOMwZhyg1K6JaWWkNK4fnZpOEO/iFQBaP9Otls1I9wgoPNDUXxnkM7WplmcYCS+mF4kUfFi9eqPmTeNr9O8BMq1qqWbae51emdxqg4sctgdvSQcrgf+Fv643o4WUUc9JU3p2NGOG2sNPeiuVD3swtmY7AH15SByY1DHg7LaPn7IRVY/SHWy3OsNRv0ja/sZK55c7yn40D468/GQf+lW3zSM1Iip4pkrMzKV9rCcsAoj3ZwDvD28wwTy4umaVc97vgBhxeXHautkvSav7bM95a6Ova5tem0tiSodlDN4hSej0BV9IGehtj+O0W4Ux5ywi/sH7Nbwo4gDdLKdTWdaH9TwsUjKCv0NEMdZD0dFus=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D196841CDC60C34BBF678EBAD051CB0A@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91f1384-f180-4051-3698-08d6bf712b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 18:03:29.9143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3674
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE5LTA0LTEyIGF0IDE3OjU2ICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6
DQo+IE9uIDMvMjYvMTkgODoxOSBQTSwgTG9yZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gT24g
TW9uLCBNYXIgMTEsIDIwMTkgYXQgMDY6NTk6MjhQTSArMDAwMCwgTGVvbmFyZCBDcmVzdGV6IHdy
b3RlOg0KPiA+ID4gSW4gdGhlb3J5IHRoaXMgZHJpdmVyIGNhbiBiZSB1c2VkIG9uIGlteDZzeCB3
aXRob3V0IGVuYWJsaW5nIHN1cHBvcnQgZm9yDQo+ID4gPiBpbXg2cSBvciBpbXg3ZCBidXQgdGhl
ICJkZXBlbmRzIG9uIiBjb25kaXRpb24gZG9lc24ndCBhbGxvdyB0aGF0Lg0KPiA+ID4gDQo+ID4g
PiBJbnN0ZWFkIG9mIG1ha2luZyB0aGUgY29uZGl0aW9uIGV2ZW4gbG9uZ2VyIGp1c3QgbWFrZSBp
dCBkZXBlbmQgb24NCj4gPiA+ICJBUkNIX01YQyB8fCBDT01QSUxFX1RFU1QiIGluc3RlYWQuDQo+
ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVz
dGV6QG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvS2NvbmZpZyB8IDIgKy0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9LY29uZmlnIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZp
Zw0KPiA+ID4gaW5kZXggNmVhNzRiMWMwZDk0Li4yMTc0N2ZkMGU3OTkgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gPiBAQCAtODgsMTEgKzg4LDExIEBA
IGNvbmZpZyBQQ0lfRVhZTk9TDQo+ID4gPiAgIAlkZXBlbmRzIG9uIFBDSV9NU0lfSVJRX0RPTUFJ
Tg0KPiA+ID4gICAJc2VsZWN0IFBDSUVfRFdfSE9TVA0KPiA+ID4gICANCj4gPiA+ICAgY29uZmln
IFBDSV9JTVg2DQo+ID4gPiAgIAlib29sICJGcmVlc2NhbGUgaS5NWDYvNy84IFBDSWUgY29udHJv
bGxlciINCj4gPiA+IC0JZGVwZW5kcyBvbiBTT0NfSU1YNlEgfHwgU09DX0lNWDdEIHx8IChBUk02
NCAmJiBBUkNIX01YQykgfHwgQ09NUElMRV9URVNUDQo+ID4gPiArCWRlcGVuZHMgb24gQVJDSF9N
WEMgfHwgQ09NUElMRV9URVNUDQo+ID4gPiAgIAlkZXBlbmRzIG9uIFBDSV9NU0lfSVJRX0RPTUFJ
Tg0KPiA+ID4gICAJc2VsZWN0IFBDSUVfRFdfSE9TVA0KPiA+IA0KPiA+IElmIEx1Y2FzIGRvZXMg
bm90IHNwb3QgYW55IHByb2JsZW0gd2l0aCB0aGlzIHBhdGNoIEkgd291bGQgcmVxdWVzdCBoaXMN
Cj4gPiBBQ0sgdG8gbWVyZ2UgaXQsIHRoYW5rcy4NCj4gDQo+IEx1Y2FzOiBDYW4geW91IHBsZWFz
ZSBhY2sgdGhpcz8gSXQncyBhIGJpdCBvbGQgYnV0IGFwcGxpZXMgY2xlYW5seSBhbmQgDQo+IHJl
c2VuZCBzaG91bGRuJ3QgYmUgcmVxdWlyZWQuDQoNClRoZSBJTVg3cyBkb2VzIG5vdCBoYXZlIGEg
UENJLWUgY29udHJvbGxlci4gIFRoZSBJTVg3ZCBkb2VzIGhhdmUgb25lLA0KYnV0IG5vdCB0aGUg
InMiLg0KDQpFbmFibGluZyB0aGUgY29udHJvbGxlciBkcml2ZXIgb24gYW4gSU1YIFNvQyB0aGF0
IGRvZXNuJ3QgaGF2ZSBpdCBpcw0Kbm90IGV4YWN0bHkgdGhlIGVuZCBvZiB0aGUgd29ybGQgYW5k
IGhhdmluZyB0byBrZWVwIGFkZGluZyBuZXcgSU1YIFNPQ3MNCnRvIHRoZSBsaXN0IGhlcmUgaXMg
YW5ub3lpbmcuICBTbyBJTUhPLCBpdCdzIG9rIHRvIG1ha2UgdGhpcyBjaGFuZ2UNCmV2ZW4gaWYg
dGhlIGNvbnRyb2xsZXIgaXMgYWxsb3dlZCBvbiBhIHN1cGVyc2V0IG9mIHRoZSBTb0NzIHRoYXQg
aGF2ZQ0KaXQuDQo=
