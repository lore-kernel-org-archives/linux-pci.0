Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9040C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 11:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6157320862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 11:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnhVNm/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6157320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeKFUom (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:44:42 -0500
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:14080
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbeKFUol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 15:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xftnl+4QSuifQ0+giAbxFLhURawMQjGTyHZfg1lcAOo=;
 b=NnhVNm/I5IHUdEeJqWR0kb/TLdgeGw2aTYwYAwHVEPtWYblBYbFYNQCgCJi70DZ572H90TxwYwbEIivwLPjPU8+9qzjnhgQ3J7M8HHyq/4OZphloctVoChnV/yx0fRTXEyjsIHF4yX3MAwvSS3jCPTLaiydoiS3PMLiuClQeotU=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5969.eurprd04.prod.outlook.com (20.178.113.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Tue, 6 Nov 2018 11:19:54 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::a059:70be:9c00:a3c4%2]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 11:19:54 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx: Add imx6sx suspend/resume support
Thread-Topic: [PATCH] PCI: imx: Add imx6sx suspend/resume support
Thread-Index: AQHUXy28c0CMdC4ep0yd8bBw3iPcCKU61cEAgAfxKQA=
Date:   Tue, 6 Nov 2018 11:19:53 +0000
Message-ID: <50557a2f8b265d74734a6fbda79a5c4ef6b33038.camel@nxp.com>
References: <e57884e2dbc429918db81662ddbafe22c472385c.1539019758.git.leonard.crestez@nxp.com>
         <AM0PR04MB42907F7BFDBF9648381DED49EECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
         <1541066574.3593.1.camel@pengutronix.de>
In-Reply-To: <1541066574.3593.1.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5969;6:RaHSP1JRSDJJfKeHUYJ6QS3jzGNUtUbGYk8jc3Pe7cfyJSdoTZUQCcWUgkSD00QahZ50WNNYNGhy1JyM4V3AtRccdsfnvrhqP7NQLYTE7kYnMqhqq17Mbnxj0b8vVvTWm2i5EIdovjWGc7YdAumYe3pbnHw1uS6rSeKft09+qX/cBQT8bWXHwJKLum0y8lLmdk26X47qeHvNw7DO6X4MuBWYGB5FFuHteF1RgXkIwaPMel73pXc1X260/RoI1zq4XkXXMHvK4pnmfNhS1UQbDFXekoaElGlLnQSFe1o4cS+pH9rpvbwuxligybHgTMWGjlZ6P2sEdzK79PBPXl/91uYl8G7j5x1mrPXZGH+QcaufGTs92zQSNtJOsGTaFGio4QJ4i/AIS/DgBIULQ0QxygyXmGBao0zlRNg3yOBX36blOQpLyzJQXkekWNatZlf2++uzSQhejW8yhhW+hhIrgg==;5:QY7JxSQ1kpVyf47pVQLwY0BKQ5A0CGmMWCrHJ/Sw85+hpEb3Tlb2hoIXdu/UU3fq3sSJ2Qc/Msv7TlEW0+fumIcPCYtptzEoufDZfOXs/BVkxruQBos3yDq6fnSSnoCWx15UQsv1LX246q6eovRjqs0EndOv31oQnxMWus5fR3Q=;7:M67Yil4OZWYw8ot4AzgzWlGo/34H96FXmLeTN/hhttXYptHbSgBJwCYtwBPc+jdzvVm5eAvosCzW4gE/zFApyahzRZashAE0akC5WJu9d9stWtmyWY/qiUWSB0yn4RlV8epYqCA/URQvGyYqiLHdKw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 88917c77-4ec7-4cd7-fcca-08d643d9c6b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5969;
x-ms-traffictypediagnostic: AM0PR04MB5969:
x-microsoft-antispam-prvs: <AM0PR04MB5969928535AA1E8F78920D10EECB0@AM0PR04MB5969.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5969;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5969;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(186003)(86362001)(6246003)(7416002)(54906003)(36756003)(50226002)(71200400001)(71190400001)(14444005)(81156014)(6512007)(8676002)(2201001)(305945005)(8936002)(7736002)(110136005)(25786009)(99286004)(66066001)(26005)(14454004)(966005)(15650500001)(4326008)(39060400002)(102836004)(6506007)(53546011)(6306002)(76176011)(316002)(53936002)(256004)(2906002)(6486002)(2501003)(106356001)(6636002)(6436002)(2900100001)(229853002)(478600001)(5660300001)(476003)(2616005)(81166006)(68736007)(44832011)(3846002)(6116002)(4001150100001)(97736004)(446003)(486006)(11346002)(105586002)(118296001)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5969;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QRqObcMxdb5UMkTDsocpzJxe0fWubjtfs7TsVZ3s9VmkcWHi9KrsTQSL2pu8YVMuKK+KLs14pA+HVnycHE5pRNjVmw0IifxgehOc9NN4QnnDC97KS3PkOmlBbdTtwIzapbDLaqjPS/8qnj3PvJB4goPoEn/pqbVSBmBCo0yrvKXnfA7bj0tWZ6i4duyGflM6d9koSTPpGOp2wiri2+ayFmk74pSkuEto2yFAjKJFbKiFnKbLOOlyQIMDRIZvgZndUo71VqsXZj1Oita/IqawsoCxZDGKwPZvQwZ6md5NPkorxUC5Qbc0iT2Vtz/ScpQ4Zu/z3CUBZ4HqMRHjVsCPCXKP/J9c4SeKZHqwPfvBWgs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E610026F38C3644A2767367A7AAAF8A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88917c77-4ec7-4cd7-fcca-08d643d9c6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 11:19:53.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5969
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTAxIGF0IDExOjAyICswMTAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSBMZW9uYXJkLA0KPiANCj4gT24gV2VkLCAyMDE4LTEwLTMxIGF0IDExOjAyICswMDAwLCBM
ZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gT24gMTAvOC8yMDE4IDg6MzggUE0sIExlb25hcmQg
Q3Jlc3RleiB3cm90ZToNCj4gPiA+IEVuYWJsZSBQQ0kgc3VzcGVuZC9yZXN1bWUgc3VwcG9ydCBv
biBpbXg2c3ggc29jcy4gVGhpcyBpcyBzaW1pbGFyIHRvDQo+ID4gPiBpbXg3ZCB3aXRoIGEgZmV3
IGRpZmZlcmVuY2VzOg0KPiA+ID4gDQo+ID4gPiAqIFRoZSBQTV9UdXJuX09mZiBiaXQgaXMgZXhw
b3NlZCB0aHJvdWdoIGFuIElPTVVYIEdQUiwgbGlrZSBhbGwgb3RoZXINCj4gPiA+IHBjaWUgY29u
dHJvbCBiaXRzIG9uIDZzeC4NCj4gPiA+ICogVGhlIHBjaWVfaW5ib3VuZF9heGkgY2xrIG5lZWRz
IHRvIGJlIHR1cm5lZCBvZmYgaW4gc3VzcGVuZC4gT24gcmVzdW1lDQo+ID4gPiBpdCBpcyByZXN0
b3JlZCB2aWEgcmVzdW1lIC0+IGRlYXNzZXJ0X2NvcmVfcmVzZXQgLT4gZW5hYmxlX3JlZl9jbGsu
DQo+ID4gPiANCj4gPiA+IE1vc3Qgb2YgdGhlIHJlc3VtZSBsb2dpYyBpcyBzaGFyZWQgd2l0aCB0
aGUgaW5pdGlhbCByZXNldCBhZnRlciBwcm9iZS4NCg0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBT
b21lIHZhcmlhbnRzIGhhdmUgYSB0dXJub2ZmIHJlc2V0IGluIERUIHdoaWxlDQo+ID4gPiArCSAq
IG90aGVycyBwb2tlIGF0IGlvbXV4YyByZWdpc3RlcnMuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwlp
ZiAoaW14Nl9wY2llLT50dXJub2ZmX3Jlc2V0KSB7DQo+ID4gPiArCQlyZXNldF9jb250cm9sX2Fz
c2VydChpbXg2X3BjaWUtPnR1cm5vZmZfcmVzZXQpOw0KPiA+ID4gKwkJcmVzZXRfY29udHJvbF9k
ZWFzc2VydChpbXg2X3BjaWUtPnR1cm5vZmZfcmVzZXQpOw0KPiA+ID4gKwl9IGVsc2UgaWYgKGlt
eDZfcGNpZS0+dmFyaWFudCA9PSBJTVg2U1gpIHsNCj4gPiA+ICsJCXJlZ21hcF91cGRhdGVfYml0
cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxMiwNCj4gPiA+ICsJCQkJSU1YNlNY
X0dQUjEyX1BDSUVfUE1fVFVSTl9PRkYsDQo+ID4gPiArCQkJCUlNWDZTWF9HUFIxMl9QQ0lFX1BN
X1RVUk5fT0ZGKTsNCj4gPiA+ICsJCXJlZ21hcF91cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4
Y19ncHIsIElPTVVYQ19HUFIxMiwNCj4gPiA+ICsJCQkJSU1YNlNYX0dQUjEyX1BDSUVfUE1fVFVS
Tl9PRkYsIDApOw0KPiA+ID4gKwl9IGVsc2Ugew0KPiA+ID4gKwkJZGV2X2VycihkZXYsICJQTUVf
VHVybl9PZmYgbm90IGltcGxlbWVudGVkXG4iKTsNCj4gPiA+ICsJCXJldHVybjsNCj4gPiA+ICsJ
fQ0KPiANCj4gSSdkIHVzZSBzd2l0Y2goaW14Nl9wY2llLT52YXJpYW50KSBmb3IgY29uc2lzdGVu
Y3kgd2l0aCB0aGUgb3RoZXIgcGxhY2VzDQo+IHdoZXJlIGRpZmZlcmVudCB2YXJpYW50cyBuZWVk
IHRvIGJlIGhhbmRsZWQgc2VwYXJhdGVseS4NCg0KWWVzLCB0aGlzIG1ha2VzIHNlbnNlLiBCdXQg
dGhlIG9ubHkgdGhpbmcgaGFuZGxlIGFzIGEgdmFyaWFudCBoZXJlDQp3b3VsZCBiZSA2c3ggaXRz
ZWxmLCBmb3IgN2QgaWYgKGlteDZfcGNpZS0+dHVybm9mZl9yZXNldCkgc3RpbGwgbWFrZXMNCnNl
bnNlLg0KDQpUaGlzIGRyaXZlciBoYXMgcXVpdGUgYSBsb3Qgb2YgbG9uZyBmdW5jdGlvbnMgd2l0
aCBzd2l0Y2ggc3RhdGVtZW50cywNCm1heWJlIHNvbWUgZGF5IGl0IHNob3VsZCBiZSBjb252ZXJ0
ZWQgdG8gdXNlIGEgcGVyLXNvYyBvcHMgc3RydWN0dXJlPw0KDQo+ID4gPiBAQCAtNzkwLDIyICs4
MDcsMzUgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2Nsa19kaXNhYmxlKHN0cnVjdCBpbXg2X3Bj
aWUgKmlteDZfcGNpZSkNCj4gPiA+ICAgew0KPiA+ID4gICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJl
KGlteDZfcGNpZS0+cGNpZSk7DQo+ID4gPiAgIAljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9w
Y2llLT5wY2llX3BoeSk7DQo+ID4gPiAgIAljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2ll
LT5wY2llX2J1cyk7DQo+ID4gPiAgIA0KPiA+ID4gLQlpZiAoaW14Nl9wY2llLT52YXJpYW50ID09
IElNWDdEKSB7DQo+ID4gPiArCXN3aXRjaCAoaW14Nl9wY2llLT52YXJpYW50KSB7DQo+ID4gPiAr
CWNhc2UgSU1YNlNYOg0KPiA+ID4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+
cGNpZV9pbmJvdW5kX2F4aSk7DQo+ID4gPiArCQlicmVhazsNCj4gPiA+ICsJY2FzZSBJTVg3RDoN
Cj4gPiA+ICAgCQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14Nl9wY2llLT5pb211eGNfZ3ByLCBJT01V
WENfR1BSMTIsDQo+ID4gPiAgIAkJCQkgICBJTVg3RF9HUFIxMl9QQ0lFX1BIWV9SRUZDTEtfU0VM
LA0KPiA+ID4gICAJCQkJICAgSU1YN0RfR1BSMTJfUENJRV9QSFlfUkVGQ0xLX1NFTCk7DQo+ID4g
PiArCQlicmVhazsNCj4gPiA+ICsJZGVmYXVsdDoNCj4gPiA+ICsJCWJyZWFrOw0KPiA+ID4gICAJ
fQ0KPiANCj4gVGhpcyBkaXNhYmxlcyB0aGUgcmVmIGNsb2NrLiBTaG91bGQgdGhpcyBiZSBzcGxp
dCBpbnRvIGEgc2VwYXJhdGUNCj4gZnVuY3Rpb24gaW14Nl9wY2llX2Rpc2FibGVfcmVmX2Nsaygp
IGZvciBzeW1tZXRyeSB3aXRoIHRoZSBhbHJlYWR5DQo+IGV4aXN0aW5nIGlteDZfcGNpZV9lbmFi
bGVfcmVmX2NsaygpID8NCg0KTm90IHN1cmUuIFRoZSBzeW1tZXRyeSB3b3VsZCBiZSBsaW1pdGVk
IGJlY2F1c2UgZW5hYmxpbmcgcmVxdWlyZW1lbnRzDQphcmUgbW9yZSBzdHJpbmdlbnQgdGhhbiBz
aHV0ZG93bi4NCg0KRm9yIGV4YW1wbGUgdGhlIG1pcnJvciBvcGVyYXRpb24gb24gaW14N2QgaXMg
ZG9uZSBpbiBpbml0X3BoeSBpbnN0ZWFkDQpvZiBlbmFibGVfcmVmX2Nsay4gSSBkaWRuJ3QgdGVz
dCBidXQgSSBleHBlY3QgdGhhdCBtb3ZpbmcgcmVmY2xrDQpzZWxlY3Rpb24gYXJvdW5kIG1pZ2h0
IHZpb2xhdGUgSFcgaW5pdCBzZXF1ZW5jaW5nIHJlcXVpcmVtZW50cyBzbyBJJ2QNCnJhdGhlciBu
b3QgcG9rZSBhdCB0aGlzLg0KDQo+IFRoYXQgY291bGQgdGhlbiBhbHNvIGJlIHVzZWQgdG8gZGlz
YWJsZSBwY2llX2luYm91bmRfYXhpIGluIHRoZSBlcnJvcg0KPiBwYXRoIG9mIGlteDZfcGNpZV9k
ZWFzc2VydF9jb3JlX3Jlc2V0KCkuDQoNCk5vdCBzdXJlLCBjbG9jayBkaXNhYmxpbmcgb24gZXJy
b3IgaXMgYWxzbyBjb21wbGljYXRlZC4NCg0KSW4gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVz
ZXQgdGhlcmUgaXMgbm8gZXJyb3IgcGF0aCBhZnRlcg0KZW5hYmxlX3JlZl9jbGsgc28gdGhlcmUg
d291bGQgYmUgbm93aGVyZSB0byBjYWxsIGRpc2FibGVfcmVmX2Nsaw0Kb3V0c2lkZSBzdXNwZW5k
LiBJbiB0aGVvcnkgaW14N2QgcGh5IHBsbCBjb3VsZCBmYWlsIHRvIGxvY2sgYnV0IHdlIGp1c3QN
CnByaW50IHNvbWV0aGluZyBpbnN0ZWFkIG9mIHByb3BhZ2F0aW5nIHRoZSBlcnJvci4NCg0KSWYg
aW14Nl9wY2llX2VzdGFibGlzaF9saW5rIGZhaWxzIGNsb2NrcyBjb3VsZCBiZSB0dXJuZWQgb2Zm
LiBJdCBtYWtlcw0Kc2Vuc2UgdG8gc2F2ZSBwb3dlciBpZiBubyBwY2llIGNhcmQgaXMgaW5zZXJ0
ZWQsIHJpZ2h0PyBUaGlzIGlzIHdoYXQNCnRoZSBpbXggdmVuZG9yIHRyZWUgZG9lcyBidXQgbXkg
dW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoaXMgZG9lcyBub3QNCnBhc3MgY29tcGxpYW5jZSB0ZXN0
aW5nIHNvIEknZCByYXRoZXIgbm90IHVwc3RyZWFtIHRoaXMgYmVoYXZpb3IuDQoNClNlZSBodHRw
czovL3NvdXJjZS5jb2RlYXVyb3JhLm9yZy9leHRlcm5hbC9pbXgvbGludXgtaW14L3RyZWUvZHJp
dmVycy9wY2kvaG9zdC9wY2ktaW14Ni5jP2g9aW14XzQuOS44OF8yLjAuMF9nYSNuMTM3OA0KDQpD
dXR0aW5nIHBvd2VyIGlmIHRoZSBwY2kgc2xvdCBpcyBlbXB0eSBzZWVtcyB3b3J0aHdoaWxlIGJ1
dCBicm93c2luZw0KdGhyb3VnaCBvdGhlciBkd2MtcGNpIGltcGxlbWVudGF0aW9ucyBhbmQgdGhl
eSBkb24ndCBzZWVtIHRvIGRvIHRoaXMNCmVpdGhlci4NCg0KSW5zdGVhZCBjbG9ja3Mgc2hvdWxk
IHN0YXkgb24gaWYgbGluayBmYWlscywgSSBndWVzcyB0aGlzIGlzIGENCnJlcXVpcmVtZW50IGZv
ciBob3RwbHVnPw0KDQotLQ0KUmVnYXJkcywNCkxlb25hcmQNCg==
