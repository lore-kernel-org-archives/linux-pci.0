Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C7C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 07:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE50520849
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 07:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o4XjiWB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE50520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeLMHWX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:22:23 -0500
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:42080
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbeLMHWW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 02:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQd1/jkIEZmKkYUNVksZCqycpYCDyqwXRQIw3GmJ7cM=;
 b=o4XjiWB1Wet+yBMFMc+LoZ4Q0FwD+0H1AhSSYdIGJ7AXoHyq4Nw6h3Th7QhG/8doI077HNuqPC+qb0B9ioqlL1CH445WxIi/cCQ6Mh3vdKQ3c8VP94GM1+UGaCF0/gnESbgpN01cTGiFEmPVhjCWSl8ZhP/B5c3d3IPLBESFvrA=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3553.eurprd04.prod.outlook.com (52.133.45.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 13 Dec 2018 07:22:17 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 07:22:17 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Baruch Siach <baruch@tkos.co.il>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: imx: make msi work without pcieportbus
Thread-Topic: [PATCH] PCI: imx: make msi work without pcieportbus
Thread-Index: AQHUkqwvGziAch1e1EiTcyWLiZ4Ke6V8Nw+AgAAMRTA=
Date:   Thu, 13 Dec 2018 07:22:17 +0000
Message-ID: <AM0PR0402MB3570595FE5822DECFD785AA28CA00@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1544681043-3792-1-git-send-email-hongxing.zhu@nxp.com>
 <874lbi6ih4.fsf@tkos.co.il>
In-Reply-To: <874lbi6ih4.fsf@tkos.co.il>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3553;6:bi9Sbv4XVcJzZvjxtoFkufx4qB8quzPpnbnjEAYglpsd9NIeSsWgZQ4UIp7Q+FB9XN1SvfHyjWT/bIhekC8bjkLkRk+BL2f283P1EktLCW7K30rgJDkHvI9YbpYzmEIeICgvaybINXhxm2uEXJFo2MEx6ehFyqmA1+R0v16FjUqC7rT+HbXr2GzydSYzZLblq0rK3DcaCVp8CXz4bF+OGgLyCAcUuvemLePltzQTyl87XSKsU7gOh/GNvHGMRIB+GEWUYV+P4i573GMyyAGNzIoWrtyd/7BBC9/XnGQVDav8/Tb6lKk/3WVEDM/LQENt3NOGyJgCkvAufMIaz+wFIvAmZOUNE/wPlfFZ3/G18m6e+5qJPIYOeOcMsH6i93rDZA4cv0P/U32DuwKXpF3blrw/QsgDDNO6ddhpT4Ltdsya4bM2fDnITB5+3wvRPkOaDnnNm/g+wO6oBnTIsDXSKw==;5:27AIc9lyIYuUv3mgJn+yYU9RkDdF8oK794XD1U3Orl9gs9ao4KepLtbacIHNUQ9lshUmdUkpXFgo49P7j6XGRB2Iwb8tDadKxjSmP3p/4y2Bb2bLsz4LfGZC/he2kpHDAwnZ0Xlqu8j55Us0N9kZhc3xl13E9rRzon1++2u91Z4=;7:7VJo/HJt/m6ktyE8oKVAG/3y3QlW6Qo8BwLE17OAz61EzVkQWorOIuLmJ8ZzQh9TkU5L8lAhN4hCqwnkedUk7ooX4L5a6J2iSInF5+MGluPIksJ+M57vIyJk24kFiwFCHYtA0z23V+NTcP2VmKJw2A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d4036e1c-ba4b-4f2a-9446-08d660cbb689
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3553;
x-ms-traffictypediagnostic: AM0PR0402MB3553:
x-microsoft-antispam-prvs: <AM0PR0402MB3553AE98946798B2977028498CA00@AM0PR0402MB3553.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231475)(944501520)(4982022)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3553;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3553;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(366004)(13464003)(199004)(189003)(66066001)(54906003)(316002)(229853002)(6436002)(6916009)(8676002)(8936002)(5660300001)(81156014)(81166006)(74316002)(305945005)(7736002)(25786009)(76176011)(33656002)(6246003)(99286004)(7696005)(6506007)(53546011)(102836004)(966005)(6306002)(9686003)(11346002)(446003)(486006)(2906002)(14454004)(71200400001)(71190400001)(53936002)(186003)(26005)(256004)(476003)(14444005)(478600001)(4326008)(575784001)(105586002)(86362001)(106356001)(68736007)(45080400002)(97736004)(3846002)(55016002)(6116002)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3553;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sCx5be1lRgSd+ntgjuHNL/znPpyBUHRDPCCwU1kzFHYn2elWCjrCk3XIfh9bEscFv2RcYKibM0DbzrXxIxny9eiAqo/Sn3ZBnxsuQjPrpFyH9lLumbcSwLrBiZQJvFW9h0aOWczA+C6+agtNvBvhBVNSWUkxxwq2GtqhoUbcghB0l5eBRsiF+qHaymhWyYL6GU4iIU/ez8UFzvzGr+BatkCghulIzyCTrjOAi17J9DDwG6GP86HRaw649VeDYJ8PknnUnYSIZFgxWUbZqFDsa45mrERbO94bCXPikiGEMFHXvsOX2Toc6rkpsalij24Z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4036e1c-ba4b-4f2a-9446-08d660cbb689
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 07:22:17.5700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3553
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhcnVjaCBTaWFjaCBbbWFp
bHRvOmJhcnVjaEB0a29zLmNvLmlsXQ0KPiBTZW50OiAyMDE4xOoxMtTCMTPI1SAxNDozNw0KPiBU
bzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gbC5zdGFjaEBwZW5ndXRyb25p
eC5kZTsgYW5kcmV3LnNtaXJub3ZAZ21haWwuY29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJOiBpbXg6IG1ha2Ug
bXNpIHdvcmsgd2l0aG91dCBwY2llcG9ydGJ1cw0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IFRo
YW5rcyBmb3IgZGVidWdnaW5nIHRoaXMgaXNzdWUuIE9uZSBxdWVzdGlvbiBiZWxvdy4NCj4gDQo+
IFJpY2hhcmQgWmh1IHdyaXRlczoNCj4gPiBNU0lfRU4gb2YgaU1YIFBDSWUgUkMgd291bGQgYmUg
YXNzZXJ0ZWQgd2hlbiBQQ0lFUE9SVEJVUyBkcml2ZXIgaXMNCj4gPiBzZWxlY3RlZC4NCj4gPiBU
aHVzLCB0aGUgTVNJIHdvcmtzIGZpbmUgb24gaU1YIFBDSWUgYmVmb3JlLg0KPiA+IE1ha2UgYSBk
b3VibGUgY2hlY2sgb24gdGhpcyBiaXQsIGFuZCBhc3NlcnQgaXQgd2hlbiBpdCBpcyBub3Qgc2V0
IGFuZA0KPiA+IE1TSSBpcyBzdXBwb3J0ZWQuDQo+ID4gT3RoZXJ3aXNlLCB0aGUgTVNJIHdvdWxk
bid0IGJlIHRyaWdnZXJlZCBhbHRob3VnaCB0aGUgRVAgaXMgcHJlc2VudA0KPiA+IGFuZCB0aGUg
TVNJcyBhcmUgYXNzaWduZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMgfCAxMCArKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+IGluZGV4IDI2MDg3YjMuLjZjM2U1NmIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNzQsNiArNzQsNyBAQCBzdHJ1Y3Qg
aW14Nl9wY2llIHsNCj4gPiAgI2RlZmluZSBQSFlfUExMX0xPQ0tfV0FJVF9VU0xFRVBfTUFYCTIw
MA0KPiA+DQo+ID4gIC8qIFBDSWUgUm9vdCBDb21wbGV4IHJlZ2lzdGVycyAobWVtb3J5LW1hcHBl
ZCkgKi8NCj4gPiArI2RlZmluZSBQQ0lfTVNJX0NBUAkJCQkweDUwDQo+ID4gICNkZWZpbmUgUENJ
RV9SQ19MQ1IJCQkJMHg3Yw0KPiA+ICAjZGVmaW5lIFBDSUVfUkNfTENSX01BWF9MSU5LX1NQRUVE
U19HRU4xCTB4MQ0KPiA+ICAjZGVmaW5lIFBDSUVfUkNfTENSX01BWF9MSU5LX1NQRUVEU19HRU4y
CTB4Mg0KPiA+IEBAIC05MjYsNiArOTI3LDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiAgCXN0cnVjdCByZXNvdXJjZSAq
ZGJpX2Jhc2U7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7
DQo+ID4gIAlpbnQgcmV0Ow0KPiA+ICsJdTE2IHZhbDsNCj4gPg0KPiA+ICAJaW14Nl9wY2llID0g
ZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCppbXg2X3BjaWUpLCBHRlBfS0VSTkVMKTsNCj4gPiAg
CWlmICghaW14Nl9wY2llKQ0KPiA+IEBAIC0xMDcwLDYgKzEwNzIsMTQgQEAgc3RhdGljIGludCBp
bXg2X3BjaWVfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXJl
dCA9IGlteDZfYWRkX3BjaWVfcG9ydChpbXg2X3BjaWUsIHBkZXYpOw0KPiA+ICAJaWYgKHJldCA8
IDApDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiArCWlmIChJU19FTkFCTEVEKENPTkZJR19QQ0lf
TVNJKSkgew0KPiA+ICsJCXZhbCA9IGR3X3BjaWVfcmVhZHdfZGJpKHBjaSwgUENJX01TSV9DQVAg
KyBQQ0lfTVNJX0ZMQUdTKTsNCj4gPiArCQlpZiAoKHZhbCAmIFBDSV9NU0lfRkxBR1NfRU5BQkxF
KSA9PSAwKSB7DQo+ID4gKwkJCXZhbCB8PSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRTsNCj4gDQo+IFdo
eSBub3QgYXNzZXJ0IHRoZSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRSBmbGFnIHVuY29uZGl0aW9uYWxs
eSBoZXJlPw0KW1JpY2hhcmQgWmh1XSBUaGFua3MgZm9yIHlvdXIga2luZGx5IHJldmlldy4NCkl0
J3MgbW9yZSBlZmZpY2llbnQgdG8gc2V0IGl0IHVuY29uZGl0aW9uYWxseS4NCkkgd291bGQgY2hh
bmdlIGl0IGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiArCQkJZHdfcGNpZV93cml0ZXdfZGJp
KHBjaSwgUENJX01TSV9DQVAgKw0KPiA+ICsJCQkJCVBDSV9NU0lfRkxBR1MsIHZhbCk7DQo+ID4g
KwkJfQ0KPiA+ICsJfQ0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiANCj4gYmFydWNo
DQo+IA0KPiAtLQ0KPiANCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGYmFydQ0KPiBjaC5zaWFjaC5uYW1lJTJGYmxvZyUy
RiZhbXA7ZGF0YT0wMiU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvDQo+IG0lN0NlOWQ4YTk0
M2U5MGY0MDU1ZjQxNzA4ZDY2MGM1NTgwMSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+IGM1
YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODAyNzk4MDQzOTU3ODA2JmFtcDtzZGF0YT1oaDRpY2hkUGNH
QTANCj4gTjFvbTRBZFpJT2FFWDNIRTJycFc2allsOG0xRiUyRldFJTNEJmFtcDtyZXNlcnZlZD0w
DQo+IH4uIC5+ICAgVGsgT3BlbiBTeXN0ZW1zDQo+ID19LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tb29PLS1VLS1Pb28tLS0tLS0tLS0tLS17PQ0KPiAgICAt
IGJhcnVjaEB0a29zLmNvLmlsIC0gdGVsOiArOTcyLjUyLjM2OC40NjU2LA0KPiBodHRwczovL2Vt
ZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3
d3cNCj4gLnRrb3MuY28uaWwmYW1wO2RhdGE9MDIlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5j
b20lN0NlOWQ4YTk0M2UNCj4gOTBmNDA1NWY0MTcwOGQ2NjBjNTU4MDElN0M2ODZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzANCj4gJTdDMCU3QzYzNjgwMjc5ODA0Mzk1NzgwNiZhbXA7
c2RhdGE9YXdRQWFGdk45JTJCNjNJeE9vbmFveDdPDQo+IEp4Wm9UdFNISkdGTktTWEVLUEtzbyUz
RCZhbXA7cmVzZXJ2ZWQ9MCAtDQo=
