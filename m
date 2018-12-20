Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CFCC43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 05:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D98120869
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 05:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XLy4zvYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeLTFPk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 00:15:40 -0500
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:47840
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbeLTFPj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 00:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4SEciJAacBUeO2clKzcAwFiI/xSpfTQiKGV0RMLL+s=;
 b=XLy4zvYB1rFPf99xWDZR2cY22okvfJJZmezczin0nY0qPo42AYNjrCiIjETK9DUymbhNrdMqRU6yWacF2/Tn8taCQrGCck63bbgCJk68uDOLNKOtqT6+dS3uwaHufOu4BiiuC2FEbL93mjGRw69rny3YEPCDkTafp1Jwn5cvAI4=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3651.eurprd04.prod.outlook.com (52.133.38.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 20 Dec 2018 05:15:21 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 05:15:21 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: RE: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUk3htX9ByhenO70SYEZSF8G6UHqWGIt2AgAAbxoCAAN1BkA==
Date:   Thu, 20 Dec 2018 05:15:20 +0000
Message-ID: <AM0PR0402MB3570C78CE4803B9D6C6DE62B8CBF0@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1544768762-18124-1-git-send-email-hongxing.zhu@nxp.com>
         <20181219141241.GB12763@google.com>
 <1545234725.5874.38.camel@pengutronix.de>
In-Reply-To: <1545234725.5874.38.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3651;6:FTyaODpPpkOe5xYGsGeWCND7kVWzs/rHbNCvKFCzfTM+illMSWRJYzmOgaTuhq6XpCTDOw9VRAN64HYtdkquNL5qmJDv1tQfG6Yi64d7EqIZA6CwSO8O16kNNCmYmJCsAcb2nd+H+fpczCe0btzyiTSZ+3meiFd+DFDOIWBbZrs21yW7z+d+Nh4+Dwii2N78Dp8VbY64rQquT37siyKWExR1xrXgMiMS8aYHEA/4eDvUBDgczBx6PVRPOJBe5uZnDqVPN1G76frcUdYEx8OA0+8+t+wkL5rCEflmvQ8LGdmw6ymXGx5RUUQYwLvd5e/11LgyaRSyWnDmqoEE+Js7XfjtmZmVdkw1I5AgzI/WhDD7gLqnOU0GT8fwKUE92S+VvqXyxQ0PrCHgnU45s3dcxyEG3ZPvRNY4mSSggTAKKNHIJwgUfELhNgMr6FFrno7E0J63/lOBMK74oGQRW3P9vw==;5:vOF8k0kTPqAOap6cyyh6/FThPdVX2vA/JNgvHzBeAiP+mIPQQIFiaw84XL/b1teTziawDsdkZP1nPHW31v7kYPch9P2h6YC/dhMGOo9R7jRBkQFNXQNsvbJ7s2/NrxBpDnBbXvof02PbAfAEWZEIrXYsVjcNjIW8440+bHdWicI=;7:eF0BxlWAezx+lD95n1aeJZz3kyrNHEaftCzKaRMHbrNzGrC0m3u06Y2nzqWtS5Cv+rLvQZXsMYcp8bDwZf5JKBG3qudIhtWZ9NVR86cK3JzC+jR+5w0t74CwxGpk/XalkCVeCXddQOuoretRPZ6Mug==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2d9f9a5b-6b3d-4cd7-4fda-08d6663a2394
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3651;
x-ms-traffictypediagnostic: AM0PR0402MB3651:
x-microsoft-antispam-prvs: <AM0PR0402MB3651CD75C39DCB320D7CAF7F8CBF0@AM0PR0402MB3651.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3651;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3651;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(366004)(13464003)(54534003)(199004)(189003)(55016002)(53936002)(9686003)(6306002)(446003)(97736004)(6246003)(8936002)(6436002)(26005)(106356001)(186003)(33656002)(39060400002)(305945005)(102836004)(105586002)(74316002)(256004)(53546011)(14444005)(6506007)(14454004)(7696005)(76176011)(476003)(966005)(486006)(11346002)(45080400002)(4326008)(99286004)(478600001)(81166006)(54906003)(110136005)(86362001)(81156014)(71200400001)(71190400001)(8676002)(316002)(25786009)(68736007)(6116002)(229853002)(3846002)(66066001)(5660300001)(2906002)(7416002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3651;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6gsbBHTyVyjp7qTH7mJdLE0BPoHHHbmDXGTDd0TT0/WN6tEkqVjuM7OjUEDHGOXQelyDPIC56ftOX27mPOIpbAuzwN15aS34+Rvz80mY55nFS1Wp9QKvADnLdaKxFqw+Fj2CcfsqhW28ojH7MFGtZAvXmdDZAmni2hCfxy7tOZzpzcNfrnVoIP3Q3iFNrlWexlGZnYCPn9S1YpbImuGI87ToD78ZqB2s67ARYMxIoT9M5iCTaa8HW7PMShtdj/hmldKjPewk2nfSkvFipO0wLNm7O1NvUDIvN+aG2QE9djT4Rgwh0zAGG0a1e1HnZi//
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9f9a5b-6b3d-4cd7-4fda-08d6663a2394
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 05:15:20.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3651
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm46DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMg
U3RhY2ggW21haWx0bzpsLnN0YWNoQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE45bm0MTLm
nIgxOeaXpSAyMzo1Mg0KPiBUbzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsg
UmljaGFyZCBaaHUNCj4gPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogTG9yZW56byBQaWVy
YWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBBbmRyZXcgU21pcm5vdg0KPiA8YW5k
cmV3LnNtaXJub3ZAZ21haWwuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBTdmVuIFZhbg0KPiBBc2Jyb2VjayA8dGhlc3ZlbjczQGdtYWlsLmNvbT47IE5pa2xh
cyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxAYXhpcy5jb20+Ow0KPiBLaXNob24gVmlqYXkgQWJyYWhh
bSBJIDxraXNob25AdGkuY29tPjsgR3VzdGF2byBQaW1lbnRlbA0KPiA8Z3VzdGF2by5waW1lbnRl
bEBzeW5vcHN5cy5jb20+OyBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT47DQo+
IFRyZW50IFBpZXBobyA8dHBpZXBob0BpbXBpbmouY29tPg0KPiBTdWJqZWN0OiBSZTogW3Y0XSBQ
Q0k6IGlteDogbWFrZSBtc2kgd29yayB3aXRob3V0IENPTkZJR19QQ0lFUE9SVEJVUz15DQo+IA0K
PiBBbSBNaXR0d29jaCwgZGVuIDE5LjEyLjIwMTgsIDA4OjEyIC0wNjAwIHNjaHJpZWIgQmpvcm4g
SGVsZ2FhczoNCj4gPiBbK2NjIFN2ZW4sIFRyZW50LCBldCBhbCBmcm9tIHJlbGF0ZWQgcmVwb3J0
Og0KPiA+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsb3INCj4gPg0KPiBlLmtlcm5lbC5vcmclMkZsaW51eC1wY2klMkYy
MDE4MTIxODIxMDQ0NC41OTUwLTEtVGhlU3ZlbjczJTQwZ29vZ2xlDQo+IG1haQ0KPiA+DQo+IGwu
Y29tJmFtcDtkYXRhPTAyJTdDMDElN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDMDViYTNiNWJi
NDJjDQo+IDRkYjliZjNiDQo+ID4NCj4gMDhkNjY1YzlmMTdiJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNg0KPiA4MDgzMTUzNDcNCj4gPg0KPiA3ODA0NjYm
YW1wO3NkYXRhPXRhN2ZmajlFUEdvcUFqRGlTMU9SdlI2NUEySWhNVXBiMkVuZHo5JTJCNnpNNA0K
PiAlM0QmYW1wOw0KPiA+IHJlc2VydmVkPTBdDQo+ID4NCj4gPiBPbiBGcmksIERlYyAxNCwgMjAx
OCBhdCAwNjo0NDoxNUFNICswMDAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+IEFzc2VydGlv
biBvZiB0aGUgTVNJIEVuYWJsZSBiaXQgb2YgUkMncyBNU0kgQ0FQIGlzIG1hbmRhdG9yeQ0KPiA+
ID4gcmVxdWlyZWQgdG8gdHJpZ2dlciBNU0kgb24gaS5NWDYgUENJZS4NCj4gPiA+IFRoaXMgYml0
IHdvdWxkIGJlIGFzc2VydGVkIHdoZW4gQ09ORklHX1BDSUVQT1JUQlVTPXkuDQo+ID4gPiBUaHVz
LCB0aGUgTVNJIHdvcmtzIGZpbmUgb24gaS5NWDYgUENJZSBiZWZvcmUgdGhlIGNvbW1pdCAiZjNm
ZGZjNCIuDQo+ID4gPg0KPiA+ID4gQXNzZXJ0IGl0IHVuY29uZGl0aW9uYWxseSB3aGVuIE1TSSBp
cyBlbmFibGVkLg0KPiA+ID4gT3RoZXJ3aXNlLCB0aGUgTVNJIHdvdWxkbid0IGJlIHRyaWdnZXJl
ZCBhbHRob3VnaCB0aGUgRVAgaXMgcHJlc2VudA0KPiA+ID4gYW5kIHRoZSBNU0lzIGFyZSBhc3Np
Z25lZC4NCj4gPg0KPiA+IE9LLCBJIHRoaW5rIEkgZmluYWxseSB1bmRlcnN0YW5kIG1vc3Qgb2Yg
d2hhdCdzIGdvaW5nIG9uLsKgwqBQbGVhc2UNCj4gPiBjaGVjayB0aGUgZm9sbG93aW5nIHBvc3Np
YmxlIGNoYW5nZWxvZyB0ZXh0Og0KPiA+DQo+ID4gwqAgVGhlIE1TSSBFbmFibGUgYml0IGluIHRo
ZSBNU0kgQ2FwYWJpbGl0eSAoUENJZSByNC4wLCBzZWMgNy43LjEuMikNCj4gPiDCoCBjb250cm9s
cyB3aGV0aGVyIGEgRnVuY3Rpb24gY2FuIHJlcXVlc3Qgc2VydmljZSB1c2luZyBNU0kuDQo+ID4N
Cj4gPiDCoCBpLk1YNiBSb290IFBvcnRzIGltcGxlbWVudCB0aGUgTVNJIENhcGFiaWxpdHkgYW5k
IG1heSB1c2UgTVNJIHRvDQo+ID4gwqAgcmVxdWVzdCBzZXJ2aWNlIGZvciBldmVudHMgbGlrZSBQ
TUUsIGhvdHBsdWcsIEFFUiwgZXRjLsKgwqBJbg0KPiA+IMKgIGFkZGl0aW9uLCBvbiBpLk1YNiwg
dGhlIE1TSSBFbmFibGUgYml0IGNvbnRyb2xzIGRlbGl2ZXJ5IG9mIE1TSQ0KPiA+IMKgIGludGVy
cnVwdHMgZnJvbSBjb21wb25lbnRzIGJlbG93IHRoZSBSb290IFBvcnQuDQo+ID4NCj4gPiDCoCBQ
cmlvciB0byBmM2ZkZmM0YWMzYTIgKCJQQ0k6IFJlbW92ZSBob3N0IGRyaXZlciBLY29uZmlnIHNl
bGVjdGlvbiBvZg0KPiA+IMKgIENPTkZJR19QQ0lFUE9SVEJVUyIpLCBlbmFibGluZyBDT05GSUdf
UENJX0lNWDYgYXV0b21hdGljYWxseQ0KPiBhbHNvDQo+ID4gwqAgZW5hYmxlZCBDT05GSUdfUENJ
RVBPUlRCVVMsIGFuZCB3aGVuIHBvcnRkcnYgY2xhaW1lZCB0aGUgUm9vdA0KPiBQb3J0cywNCj4g
PiDCoCBpdCBzZXQgdGhlIE1TSSBFbmFibGUgYml0IHNvIGl0IGNvdWxkIHVzZSBQTUUsIGhvdHBs
dWcsIEFFUiwgZXRjLg0KPiA+IMKgIEFzIGEgc2lkZSBlZmZlY3QsIHRoYXQgYWxzbyBlbmFibGVk
IGRlbGl2ZXJ5IG9mIE1TSSBpbnRlcnJ1cHRzIGZyb20NCj4gPiDCoCBkb3duc3RyZWFtIGNvbXBv
bmVudHMuDQo+ID4NCj4gPiDCoCBBZnRlciBmM2ZkZmM0YWMzYTIsIHRoZSBpbXg2cS1wY2llIGRy
aXZlciBjYW4gb3BlcmF0ZSB3aXRob3V0DQo+ID4gwqAgcG9ydGRydiwgYnV0IHRoYXQgbWVhbnMg
aW14NnEtcGNpZSBtdXN0IHNldCB0aGUgTVNJIEVuYWJsZSBiaXQNCj4gPiDCoCBpdHNlbGYgaWYg
ZG93bnN0cmVhbSBjb21wb25lbnRzIHVzZSBNU0kuDQo+ID4NCj4gPiDCoCBGaXhlczogZjNmZGZj
NGFjM2EyICgiUENJOiBSZW1vdmUgaG9zdCBkcml2ZXIgS2NvbmZpZyBzZWxlY3Rpb24gb2YNCj4g
PiBDT05GSUdfUENJRVBPUlRCVVMiKQ0KPiA+DQo+ID4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5k
IGV4YWN0bHkgKmhvdyogTVNJIEVuYWJsZSBhZmZlY3RzIE1TSSBmcm9tDQo+ID4gZG93bnN0cmVh
bSBjb21wb25lbnRzLCBzaW5jZSB0aGUgZG93bnN0cmVhbSBjb21wb25lbnQganVzdCBkb2VzIGEN
Cj4gRE1BDQo+ID4gd3JpdGUsIGFuZCB0aGUgUm9vdCBQb3J0IGNhbid0IHRlbGwgd2hldGhlciB0
aGUgd3JpdGUgaXMgdG8gbWVtb3J5IG9yDQo+ID4gaW50ZXJydXB0IGNvbnRyb2xsZXIgdW5sZXNz
IHRoZSBSb290IFBvcnQga25vd3Mgd2hlcmUgdGhlIE1TSSB0YXJnZXRzDQo+ID4gYXJlLCBlLmcu
LCBpZiB0aGUgaW50ZXJydXB0IGNvbnRyb2xsZXIgaXMgYWN0dWFsbHkgcGFydCBvZiB0aGUgUkMu
DQo+IA0KW1JpY2hhcmQgWmh1XSBUaGFua3MgYSBsb3QgZm9yIHlvdXIga2luZGx5IGhlbHAgdG8g
Y3JhZnQgdGhlIGNvbW1pdCBsb2cuDQpJJ20gdG90YWxseSBmaW5lIHdpdGggaXQuDQpKdXN0IGxp
a2UgTHVjYXMgc2FpZCBiZWxvdywgdGhlIE1TSSB0cmlnZ2VyIGNvbmRpdGlvbnMgYXJlIHBhcnQg
b2YgdGhlIGdsdWUgbG9naWMNCiBXaGVuIGludGVncmF0ZSB0aGlzIElQIGludG8gaU1YNiBTT0Mu
IA0KVGhlIE1TSSBFbmFibGUgYml0IHNldCBvZiBSQyBpcyBvbmUgb2YgdGhlIG1hbmRhdG9yeSBy
ZXF1aXJlZCBjb25kaXRpb24gdG8NCiB0cmlnZ2VyIE1TSSBmcm9tIEVQLg0KDQpCZXN0IFJlZ2Fy
ZHMNClJpY2hhcmQgWmh1DQoNCj4gVGhlIGNvbnRyb2xsZXIgdGVybWluYXRpbmcgdGhlIE1TSSB3
cml0ZSBpcyBwYXJ0IG9mIHRoZSBEV0MgUENJZSBob3N0DQo+IGNvbnRyb2xsZXIgb24gaS5NWDYs
IHdoaWNoIGlzIHF1ZXN0aW9uYWJsZSBhdCBsZWFzdCB3aGVuIHlvdSB0aGluayBhYm91dCBob3cN
Cj4gYSBNU0kgc2hvdWxkIGJlIHNlbGYtc3luY2hyb25pemluZyB0byBtZW1vcnkgd3JpdGVzLCBi
dXQgdGhhdCdzIHJlYWxpdHkuLi4NCj4gDQo+IEFzIHRvIHdoeSB0aGUgY29udHJvbGxlciBuZWVk
cyB0aGUgTVNJIEVuYWJsZSBiaXQgc2V0LCBJIGhhdmUgbm8gaWRlYS4NCj4gQnV0IHRoZW4gdGhl
IERXQyBjb250cm9sbGVyIGlzIGtub3duIHRvIGhhdmUgc29tZSBmdW5reSBkZXNpZ24gbGltaXRh
dGlvbnMNCj4gcmVnYXJkaW5nIE1TSSwgbGlrZSBub3QgZm9yd2FyZGluZyBsZWdhY3kgUENJIGlu
dGVycnVwdHMgYW55bW9yZSB3aGVuIE1TSSBpcw0KPiBlbmFibGVkLCBzbyBpdCdzIG5vdCB0b3Rh
bGx5IHN1cnByaXNpbmcgdGhhdCB3ZSBuZWVkIHNvbWUgcXVpcmt5IHNldHVwIGhlcmUuDQo+IA0K
PiBSZWdhcmRzLA0KPiBMdWNhcw0K
