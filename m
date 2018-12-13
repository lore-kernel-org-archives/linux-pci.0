Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0EAC67839
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4C320989
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 09:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HVwSLy70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4C320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeLMJ5i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:57:38 -0500
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:11392
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727210AbeLMJ5i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 04:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqMm4zwhLV6T9nbYCO3HcbBZ63THWqFFzsDHI4FjymA=;
 b=HVwSLy70XEl9VhmNDAiRkkPRSO8BKF0rtGZYorAX40rAsuKZVnxeWUbgVP0n06YAip4ZxtJhDDFriRW4orCPel+PzCDyKD2hBvzkZp8vBya+I8UaJ0Ec+htVN/uGSTJX4pvX9Ntbg5XCBQnLUfWIE5iyjCi1eG0e/bQqbABxO9Y=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3538.eurprd04.prod.outlook.com (52.133.45.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 09:57:32 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 09:57:32 +0000
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
Thread-Index: AQHUkron3jfJ309qkk6cQky/juy8waV8ZHAAgAAINuA=
Date:   Thu, 13 Dec 2018 09:57:31 +0000
Message-ID: <AM0PR0402MB35705EF0F4A77BD7B0AAFDDD8CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <1544692768.3137.25.camel@pengutronix.de>
In-Reply-To: <1544692768.3137.25.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3538;6:6/o73lBHUCL9Usthwi9DTBLT1zrVoTyp8x98XcMC56hX8PqnbN2Age7SFXFtkGEKsXOlx00Sf4NgtHwUGnCnxizFVmnPxxrAJjcpCRVtTva8pLNS1Ns8icgijwyPhXR9hasTazw2/rDpST2CnSrNrUaDrG4m1lynY9zuUGRTMWUrAo2YIsBUFN2rPTlI3B2t4oZuJXyNsKcw6tQUToSrbPPBEqpcxtfZ+n2xW9cNyhqLUQZKEzSbCHYufdGli77OJ+jxJy+IYipeEUlTnnaUHlT/o6AJBQwR1Grlo0BN50ymqS3Sj+UfLODwQo90uQQM5W2o+N23xbr83U75JkbhDV652yqq+6jG+zggwVC2B3XPPASLj7VU8IEqv3+YzeSDi+CJHcWQVlUqR+2LU410U2b0J37827nA5mcmICFSXNHtvqMi08POmLP1n+4NmzRPrNr39IoYh/fIOS3RNz+r9A==;5:qF453yJXYx+Y7RhUqQuoqtE2TDzQwWuN8g4xmbS/iupGvM1VlM7IRycBQasbXk8XnBIByqIAdg7ap0pwmIP+vGxR+7BvCly7GIl+fT4qEmbftAqxpV5yJSGuQx64ie2pLuB4HmFfHcI/5IVi0IbQQkl/lSvFSxr9ra5QvWHtU/s=;7:+NNZivDgr8toLWeYJ5hO8f3uCi7BnooSbrFA6hwL8aml75toGvByUoxzmapjz6zuupe+50mKkOE56FyqxCtdi8qpXOF2mBUrdYU/jqYN6sD1I5A2viVNg71EzkQTrmbvOzS2pouz0TwobN/1FoBJZw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bf0675af-8143-4467-4c60-08d660e16660
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3538;
x-ms-traffictypediagnostic: AM0PR0402MB3538:
x-microsoft-antispam-prvs: <AM0PR0402MB353879B3687E48D8E30043ED8CA00@AM0PR0402MB3538.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3538;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3538;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(346002)(39860400002)(136003)(396003)(13464003)(189003)(199004)(97736004)(25786009)(575784001)(26005)(7696005)(86362001)(2201001)(9686003)(14454004)(102836004)(6116002)(3846002)(99286004)(106356001)(186003)(7736002)(6506007)(53546011)(2501003)(478600001)(76176011)(105586002)(14444005)(256004)(71190400001)(71200400001)(5660300001)(6436002)(4326008)(316002)(54906003)(110136005)(81156014)(81166006)(66066001)(68736007)(39060400002)(8676002)(229853002)(6246003)(486006)(446003)(55016002)(8936002)(11346002)(53936002)(74316002)(305945005)(476003)(2906002)(33656002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3538;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DCBN4OIonCBJzUKl4zOsmhNQSRUBCUTipgxDBlxzdlpvXEQ5LLZk8BmiFBkpXnj9akGN0UubMI5rsO4nqi7lxXf5vEuH/IWk5j0fr9ubjGLHhJdF0CKOtrl12rQB/ON97vyp4GjFpy+c8bRfwvpOALhl8EcM+woW4P2KWTCvlZYe7nFgr9DTfzvxBS3iBKUKH7UAQehnyuWBtTM41YLMcnDuvN2W92Su6U4bUMneL15iFmKBmsmf6100u22jlL6LEjbZaH3qDl6bVMo/+cusdRr/QcwIA6zJUGfNE2J7qYap7T07OlST+ib2g3/1naqt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0675af-8143-4467-4c60-08d660e16660
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 09:57:31.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3538
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTHVjYXM6DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMg
U3RhY2ggW21haWx0bzpsLnN0YWNoQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE45bm0MTLm
nIgxM+aXpSAxNzoxOQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsg
YmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgYW5kcmV3
LnNtaXJub3ZAZ21haWwuY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFt2Ml0gUENJOiBpbXg6IG1ha2UgbXNpIHdvcmsgd2l0
aG91dCBwY2llcG9ydGJ1cw0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IEFtIERvbm5lcnN0YWcs
IGRlbiAxMy4xMi4yMDE4LCAwODowMiArMDAwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IE1T
SV9FTiBvZiBpTVggUENJZSBSQyB3b3VsZCBiZSBhc3NlcnRlZCB3aGVuIFBDSUVQT1JUQlVTIGRy
aXZlciBpcw0KPiA+IHNlbGVjdGVkLg0KPiA+IFRodXMsIHRoZSBNU0kgd29ya3MgZmluZSBvbiBp
TVggUENJZSBiZWZvcmUuDQo+ID4gQXNzZXJ0IGl0IHVuY29uZGl0aW9uYWxseSB3aGVuIE1TSSBp
cyBzdXBwb3J0ZWQuDQo+ID4gT3RoZXJ3aXNlLCB0aGUgTVNJIHdvdWxkbid0IGJlIHRyaWdnZXJl
ZCBhbHRob3VnaCB0aGUgRVAgaXMgcHJlc2VudA0KPiA+IGFuZCB0aGUgTVNJcyBhcmUgYXNzaWdu
ZWQuDQo+IA0KPiBUaGFua3MgZm9yIGRpZ2dpbmcgaW50byB0aGlzIGlzc3VlLiBUaGlzIHNlZW1z
IGxpa2UgdGhlIHJpZ2h0IHdheSBmb3J3YXJkLg0KPiBIb3dldmVyLCBkaWQgeW91IHRlc3QgdGhp
cyB3aXRoIGRldmljZXMgdXNpbmcgbGVnYWN5IElSUXM/DQo+IEkuZS4gYm9vdGluZyB3aXRoICJu
b21zaSIgb24gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUgdG8gc2VlIGlmIGxlZ2FjeSBJUlFzIHN0
aWxsDQo+IHdvcmsgaWYgdGhpcyBiaXQgaXMgc2V0LCBvciBpZiB3ZSBuZWVkIHRvIGF2b2lkIHNl
dHRpbmcgdGhpcyB3aGVuIHRoZSB1c2VyDQo+IGV4cGxpY2l0bHkgcmVxdWVzdHMgdG8gZGlzYWJs
ZSBNU0lzPw0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQpbUmljaGFyZCBaaHVdIFRoYW5r
cyBmb3IgeW91ciByZXZpZXcuDQpUaGUgTGVnYWN5IElOVHggaXMgYnJva2VuLg0KVGhlIE1TSV9F
TiBiaXQgc2hvdWxkbid0IGJlIGFzc2VydGVkIHdoZW4gdGhlIHVzZXIgZXhwbGljaXRseSByZXF1
ZXN0cyB0byBkaXNhYmxlIE1TSXMuDQoNCkJUVywgcmVnYXJkaW5nIHRvIEJhcnVjaCdzIGNvbW1l
bnRzLCBpdCBzZWVtcyB0aGF0IGFsbCB0aGUgKElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kpIGNo
ZWNrIGluDQogdGhlIGR3YyBob3N0IGRyaXZlcnMgYXJlIG5vdCByZXF1aXJlZCBhbnltb3JlLCBz
aW5jZSB0aGUgZGVwZW5kcyBvbiBQQ0lfTVNJX0lSUV9ET01BSU4sIHJpZ2h0Pw0KDQoNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNyArKysrKysr
DQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IDI2MDg3YjMuLmQzZTQy
OTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBA
QCAtNzQsNiArNzQsNyBAQCBzdHJ1Y3QgaW14Nl9wY2llIHsNCj4gPiA+IMKgI2RlZmluZSBQSFlf
UExMX0xPQ0tfV0FJVF9VU0xFRVBfTUFYCTIwMA0KPiA+DQo+ID4gwqAvKiBQQ0llIFJvb3QgQ29t
cGxleCByZWdpc3RlcnMgKG1lbW9yeS1tYXBwZWQpICovDQo+ID4gPiArI2RlZmluZSBQQ0lfTVNJ
X0NBUAkJCQkweDUwDQo+ID4gPiDCoCNkZWZpbmUgUENJRV9SQ19MQ1IJCQkJMHg3Yw0KPiA+ID4g
wqAjZGVmaW5lIFBDSUVfUkNfTENSX01BWF9MSU5LX1NQRUVEU19HRU4xCTB4MQ0KPiA+ID4gwqAj
ZGVmaW5lIFBDSUVfUkNfTENSX01BWF9MSU5LX1NQRUVEU19HRU4yCTB4Mg0KPiA+IEBAIC05MjYs
NiArOTI3LDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiA+ICpwZGV2KQ0KPiA+ID4gwqAJc3RydWN0IHJlc291cmNlICpkYmlfYmFzZTsNCj4g
PiA+IMKgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiA+IMKg
CWludCByZXQ7DQo+ID4gPiArCXUxNiB2YWw7DQo+ID4NCj4gPiA+IMKgCWlteDZfcGNpZSA9IGRl
dm1fa3phbGxvYyhkZXYsIHNpemVvZigqaW14Nl9wY2llKSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiDC
oAlpZiAoIWlteDZfcGNpZSkNCj4gPiBAQCAtMTA3MCw2ICsxMDcyLDExIEBAIHN0YXRpYyBpbnQg
aW14Nl9wY2llX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+
IMKgCXJldCA9IGlteDZfYWRkX3BjaWVfcG9ydChpbXg2X3BjaWUsIHBkZXYpOw0KPiA+ID4gwqAJ
aWYgKHJldCA8IDApDQo+ID4gPiDCoAkJcmV0dXJuIHJldDsNCj4gPiA+ICsJaWYgKElTX0VOQUJM
RUQoQ09ORklHX1BDSV9NU0kpKSB7DQo+ID4gPiArCQl2YWwgPSBkd19wY2llX3JlYWR3X2RiaShw
Y2ksIFBDSV9NU0lfQ0FQICsNCj4gUENJX01TSV9GTEFHUyk7DQo+ID4gPiArCQl2YWwgfD0gUENJ
X01TSV9GTEFHU19FTkFCTEU7DQo+ID4gPiArCQlkd19wY2llX3dyaXRld19kYmkocGNpLCBQQ0lf
TVNJX0NBUCArIFBDSV9NU0lfRkxBR1MsIHZhbCk7DQo+ID4gPiArCX0NCj4gPg0KPiA+ID4gwqAJ
cmV0dXJuIDA7DQo+ID4gwqB9DQo=
