Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422BC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 21:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F11F20854
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 21:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="dJs2j+iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfB1VYD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:24:03 -0500
Received: from mail-eopbgr780103.outbound.protection.outlook.com ([40.107.78.103]:6962
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbfB1VYC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 16:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atD21Yvso/DT9MIkHVV51VF+49Mqr6vKMvGE/q0f/bQ=;
 b=dJs2j+iwrwIans/t9N34SWxIb5dqOxlazJnt3q35J/pfoGlF9WZH3roj/T02/xb1lXS3P4bjm9OZfKfiWa1VaxeI4rUcvDIBEIrj9VTmPAjwFC7/3rQ7QHSmhjT8Eabc3PEFrGBfyqB3AMjeZpUPT8bliQGI56YSb+nwtj8Wuk8=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3643.namprd06.prod.outlook.com (10.167.236.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 21:23:58 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::91d4:ba4b:1424:9452]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::91d4:ba4b:1424:9452%2]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 21:23:58 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: imx6: Add code to request/control "pcie_aux"
 clock for i.MX8MQ
Thread-Topic: [PATCH 2/2] PCI: imx6: Add code to request/control "pcie_aux"
 clock for i.MX8MQ
Thread-Index: AQHUwnV/PjSm2eLZQ0exQOr536QHtaXb59YAgBnrEoA=
Date:   Thu, 28 Feb 2019 21:23:58 +0000
Message-ID: <1551389037.6059.3.camel@impinj.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
         <20190212015108.16952-3-andrew.smirnov@gmail.com>
         <1549964166.2546.21.camel@pengutronix.de>
In-Reply-To: <1549964166.2546.21.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea86cf2-c3cb-41b7-859e-08d69dc30d2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3643;
x-ms-traffictypediagnostic: MWHPR0601MB3643:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3643;20:0UUOa2p5TGQiSGknWseMCwuDANNl/TGY3VG01QcVpkVEdb6JE1BWRZnKW73k4KJtpTJwGY9gsJD3+CMUTMDR5ceK9lbwS9m6sR5uiqrySxekeCJd1DfYoGZa3Qk3AI5JIGh9PUM1PRcp5ajh5qJe/lkTyLTrn8ibboF2n5nu2X8=
x-microsoft-antispam-prvs: <MWHPR0601MB36434EB7BEDF8A5F6B37EF5ED3750@MWHPR0601MB3643.namprd06.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39850400004)(136003)(189003)(199004)(446003)(11346002)(2616005)(110136005)(476003)(8936002)(2501003)(486006)(106356001)(186003)(68736007)(105586002)(316002)(54906003)(103116003)(5660300002)(97736004)(2906002)(305945005)(478600001)(71200400001)(53936002)(2201001)(99286004)(6436002)(66066001)(6512007)(6486002)(71190400001)(256004)(6246003)(229853002)(81156014)(81166006)(102836004)(25786009)(4326008)(6506007)(7416002)(26005)(76176011)(7736002)(3846002)(8676002)(86362001)(14454004)(36756003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3643;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: irE5sLP9fR6+c8x1kXUal/ppDPzwDLdhgnIahUlcmnTdrXD9fGOmoY/0zQ8F/Nl8wtDfrdAtD87lp6vjTqAJMcC8JG2B95otNQF2tiQB9emxLC8V4EOh7Fr7gUtkZXzCzzxI5vV4Y7HM1UeI+XjmvlSu9OqhKWN1tud8r2Shn9+n8F8GCKxXC/7Oa/rfIbeY4S5Ye3mKOPJPDLPkYLamiLY05v2F89rjiaN7Yt7ueVaCrIwhclqrazHsaIm1azqv/0m3XkdOLypUK1Vr/pv4ERXKzhQPOlxSS17VQMPOIdqsav5sAVYksfTGxUfV1uAD+o3ow01yNG3SJJUbj8n8+vMJF8xxRzL7UhtOLDVlNLyG0e68cCi51VdS8bu7CZ9pdaW5KfmJWaDDWQqq5KeBl1skPAMdRrj5H+uH2MdNtxo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E751255E04A9D749A2A778E78952A053@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea86cf2-c3cb-41b7-859e-08d69dc30d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 21:23:58.3392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3643
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTEyIGF0IDEwOjM2ICswMTAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTW9udGFnLCBkZW4gMTEuMDIuMjAxOSwgMTc6NTEgLTA4MDAgc2NocmllYiBBbmRyZXkgU21p
cm5vdjoNCj4gPiBQQ0llIElQIGJsb2NrIGhhcyBhZGRpdGlvbmFsIGNsb2NrLCAicGNpZV9hdXgi
LCB0aGF0IG5lZWRzIHRvIGJlDQo+ID4gY29udHJvbGxlZCBieSB0aGUgZHJpdmVyLiBBZGQgY29k
ZSB0byBzdXBwb3J0IHRoYXQuDQoNClRoaXMgYnJlYWtzIGlNWDdkLg0KDQo+ID4gDQo+ID4gQEAg
LTEwNDksNiArMTA1OSwxMiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQg
UENJRSBBUFBTIHJlc2V0IGNvbnRyb2xcbiIpOw0KPiA+ICAJCQlyZXR1cm4gUFRSX0VSUihpbXg2
X3BjaWUtPmFwcHNfcmVzZXQpOw0KPiA+ICAJCX0NCj4gPiArDQo+ID4gKwkJaW14Nl9wY2llLT5w
Y2llX2F1eCA9IGRldm1fY2xrX2dldChkZXYsICJwY2llX2F1eCIpOw0KPiA+ICsJCWlmIChJU19F
UlIoaW14Nl9wY2llLT5wY2llX2F1eCkpIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJwY2llX2F1
eCBjbG9jayBzb3VyY2UgbWlzc2luZyBvciBpbnZhbGlkXG4iKTsNCj4gPiArCQkJcmV0dXJuIFBU
Ul9FUlIoaW14Nl9wY2llLT5wY2llX2F1eCk7DQo+ID4gKwkJfQ0KPiA+ICAJCWJyZWFrOw0KPiA+
ICAJZGVmYXVsdDoNCj4gPiAgCQlicmVhazsNCg0KT25lIGNhbid0IHNlZSBlbm91Z2ggY29udGV4
dCBpbiB0aGUgcGF0Y2ggYWJvdmUsIGJ1dCBpbiBsaW51eC1uZXh0IHRoaXMNCnNlY3Rpb24gaXMg
dW5kZXINCg0KICAgICAgICAgY2FzZSBJTVg3RDoNCiAgICAgICAgIGNhc2UgSU1YOE1ROg0KDQpJ
dCdzIGJlaW5nIGFwcGxpZWQgdG8gaW14N2QgYW5kIG5vdCBqdXN0IGlteDhtcSBhbmQgc28gYnJl
YWtzIGJlY2F1c2UNCmlteDdkIGR0cyBmaWxlcyBkb24ndCBoYXZlIHRoaXMgY2xvY2suICBOb3Qg
c3VyZSBpZiB0aGlzIGlzIGEgYnVnIGluDQp0aGlzIGNvbW1pdCBvciBzb21lIGtpbmQgb2YgbWVy
Z2UvcmViYXNlIG1pc3Rha2UuDQoNCg==
