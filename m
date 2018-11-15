Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DEEC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 02:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA9C22360
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 02:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GpelNMeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA9C22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeKONFv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:05:51 -0500
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:27461
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKONFv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 08:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjBCqNarYVjyR1KgpghC9xegaSNp+XOPw0y6nznenR4=;
 b=GpelNMeCvd4Ia21UsfGc4NIi2gCH2Wmu0iewDLrS+7BY9qTtuE8ss3ViFF6Fdtfk/hcPkanSmDNzliSLTO++7RZfrBO11+HiupPKJSViESMfNtueSZYl5xiEtx07a4retn3JYWH9rKHyD+udNx3Iei5QqGHzdBx8bivn1VCTAWA=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4118.eurprd04.prod.outlook.com (52.135.168.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 15 Nov 2018 02:59:48 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 02:59:48 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 10/23] PCI: mobiveil: fix the INTx process error
Thread-Topic: [PATCH 10/23] PCI: mobiveil: fix the INTx process error
Thread-Index: AQHUddNxtNgB2s9yF0+e35QgaH10F6VQMUIg
Date:   Thu, 15 Nov 2018 02:59:48 +0000
Message-ID: <AM6PR04MB5781A186E0F6D9C0E7BABAF384DC0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-11-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181106131807.29951-11-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4118;6:ma0uaWTk3G3TZlS+Ks2dC6A83NG1w7xpDCS0ry9twY5upGQAIRpG9x/DHoBsCMBjkLuziJoT3wC0hDc+cYkbOLRo9ekB/xey/RgAS5810FYJSxNwfFwF0FcWqvsJgShb0awWpGZThxa2YmdtjFNiJEk2oJI4UPM/63VKI4yssiwneNmWMPpfqgLTGiF5wSZKDU1KcVo33UrXvxTlyB4y/vZxZ4KIA728SX+5D+Ac/OOpIkq1yqcO+TOQRBEDHxXVFD/c6J5JBdFAGaCf/eflCB3xxaTsJwyaiaGXU4IpXPwUhdxcFhLdSsCvr/Q85eWmduWAbMorEYmRzXzmJqXvgvDGFQQqxOmWU8eorl+vW+Zjd5OYRhSDrg3XYn25qJUezjY77DJ98yLoiasOXd1rtnXw2MZDrS6uzYDwmBbnmusoRS509905KMjcvrX8I4HK27TdGtHWoHOfvZUUH5+N+Q==;5:HN6Nt79A/n0PJehLthFJjNNq4plTfX0fvbbPz67UPIANWZo3lgSL8SxkeOAY6HRAhjcnfn4vg1K7pptMprIuBPMzi2rBJ41Q/PAfjoziXohDnBM2ie79ScQ/IRjYuFa1cgAIzk6URpoHyKlKF21cz1QgmlKgI+8YUx8gGivnP6o=;7:2rtC7iiURcDkBkzx+KrXlwn+RkUgJkfl5+BXll0RUNfNC3f8qaLQjVeT6ywIrOzsvwbJ+OJ1cM7NsjP/IUAFYEKre2rDQwW8yJKLy8+0jaCYJmU3XwSv+3TNVrX+1Wxa7wvQLi/eSk56T7/vjyfVOA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 446dab62-8f1b-47a3-da98-08d64aa667ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4118;
x-ms-traffictypediagnostic: AM6PR04MB4118:
x-microsoft-antispam-prvs: <AM6PR04MB4118398436D7524F550A866A84DC0@AM6PR04MB4118.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(211936372134217)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4118;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4118;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(13464003)(7736002)(97736004)(5660300001)(33656002)(105586002)(106356001)(2900100001)(14454004)(66066001)(4326008)(25786009)(81156014)(81166006)(8676002)(8936002)(68736007)(2501003)(7416002)(9686003)(99286004)(2906002)(6436002)(476003)(486006)(55016002)(11346002)(446003)(71190400001)(53936002)(2201001)(229853002)(6246003)(478600001)(71200400001)(6506007)(186003)(86362001)(256004)(6116002)(3846002)(54906003)(110136005)(74316002)(305945005)(316002)(102836004)(7696005)(76176011)(53546011)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4118;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nzwaGFIJl0Q+dAQWgBxrfNRmMjgAk0FjJPh/vy1o0qPlR8MFbcPMLehJpONyvs7zl2aHkru0GL5OJyeBWu6hz+xlHCtmWZ6MRBloPZVoWuycmsHMcpVv3L54BV+ksZVNelkdj089RC7gOrEb4qK6oiRWcoitNZ7HUjJfvJBBSOvxxDSqPP1xyhOVBvfMjvBbOue2XHER4ndC711HIM9OAgn9a+k9eRWlwTSsuhHhvx9QifFPXGpaUiizOeO/fCAYOiLO2vN1hnAYlOlRkn4PmmChnh1sERBIPScaFbz876UZopj7c9RdrPQn665+Ojd1uHt0r9lT73Od/UWzrWcl/nYjSLoMm+E9Qnr2wFecB8Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446dab62-8f1b-47a3-da98-08d64aa667ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 02:59:48.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4118
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3VicmFobWFueWEsDQoNCkFzIE5YUCBkb2VzIG5vdCBpbnRlZ3JhdGUgTW9iaXZlaWwncyBJ
TlR4IGFuZCBNU0kgaW50ZXJydXB0IGNvbnRyb2xsZXIsIEkgYW0gdW5hYmxlIHRvIHRlc3QgdGhp
cyBmaXguDQpDYW4geW91IGhlbHAgdG8gdGVzdCB0aGlzIGZpeD8NCg0KVGhhbmtzLA0KWmhpcWlh
bmcNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWi5xLiBIb3UNCj4gU2Vu
dDogMjAxOMTqMTHUwjbI1SAyMToyMA0KPiBUbzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbC5z
dWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+
IDxsZW95YW5nLmxpQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IENjOiBN
aW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxp
YW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPjsgWi5xLiBIb3UN
Cj4gPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMTAvMjNdIFBDSTog
bW9iaXZlaWw6IGZpeCB0aGUgSU5UeCBwcm9jZXNzIGVycm9yDQo+IA0KPiBGcm9tOiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiANCj4gSW4gdGhlIGxvb3AgYmxvY2ssIHRo
ZXJlIGlzIG5vdCBjb2RlIGNoYW5nZSB0aGUgbG9vcCBrZXksIHRoaXMgcGF0Y2ggdXBkYXRlZA0K
PiB0aGUgbG9vcCBrZXkgYnkgcmUtcmVhZCB0aGUgSU5UeCBzdGF0dXMgcmVnaXN0ZXIuDQo+IA0K
PiBUaGlzIHBhdGNoIGFsc28gY2hhbmdlIHRvIGNsZWFyIHRoZSBoYW5kbGVkIElOVHggc3RhdHVz
Lg0KPiANCj4gTm90ZTogTmVlZCBNViB0byB0ZXN0IHRoaXMgY2hhbmdlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyB8IDEzICsrKysrKysrKy0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4g
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiBpbmRleCBkMDMzOTI5
NDA5NDQuLjg4NGM5Zjk1Mzc0ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLW1vYml2ZWlsLmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1v
Yml2ZWlsLmMNCj4gQEAgLTM2MSw2ICszNjEsNyBAQCBzdGF0aWMgdm9pZCBtb2JpdmVpbF9wY2ll
X2lzcihzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+ICAJLyogSGFuZGxlIElOVHggKi8NCj4gIAlp
ZiAoaW50cl9zdGF0dXMgJiBQQUJfSU5UUF9JTlRYX01BU0spIHsNCj4gIAkJc2hpZnRlZF9zdGF0
dXMgPSBjc3JfcmVhZGwocGNpZSwgUEFCX0lOVFBfQU1CQV9NSVNDX1NUQVQpOw0KPiArCQlzaGlm
dGVkX3N0YXR1cyAmPSBQQUJfSU5UUF9JTlRYX01BU0s7DQo+ICAJCXNoaWZ0ZWRfc3RhdHVzID4+
PSBQQUJfSU5UWF9TVEFSVDsNCj4gIAkJZG8gew0KPiAgCQkJZm9yX2VhY2hfc2V0X2JpdChiaXQs
ICZzaGlmdGVkX3N0YXR1cywgUENJX05VTV9JTlRYKSB7IEBADQo+IC0zNzIsMTIgKzM3MywxNiBA
QCBzdGF0aWMgdm9pZCBtb2JpdmVpbF9wY2llX2lzcihzdHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQo+
ICAJCQkJCWRldl9lcnJfcmF0ZWxpbWl0ZWQoZGV2LCAidW5leHBlY3RlZCBJUlEsDQo+IElOVCVk
XG4iLA0KPiAgCQkJCQkJCSAgICBiaXQpOw0KPiANCj4gLQkJCQkvKiBjbGVhciBpbnRlcnJ1cHQg
Ki8NCj4gLQkJCQljc3Jfd3JpdGVsKHBjaWUsDQo+IC0JCQkJCSAgIHNoaWZ0ZWRfc3RhdHVzIDw8
IFBBQl9JTlRYX1NUQVJULA0KPiArCQkJCS8qIGNsZWFyIGludGVycnVwdCBoYW5kbGVkICovDQo+
ICsJCQkJY3NyX3dyaXRlbChwY2llLCAxIDw8IChQQUJfSU5UWF9TVEFSVCArIGJpdCksDQo+ICAJ
CQkJCSAgIFBBQl9JTlRQX0FNQkFfTUlTQ19TVEFUKTsNCj4gIAkJCX0NCj4gLQkJfSB3aGlsZSAo
KHNoaWZ0ZWRfc3RhdHVzID4+IFBBQl9JTlRYX1NUQVJUKSAhPSAwKTsNCj4gKw0KPiArCQkJc2hp
ZnRlZF9zdGF0dXMgPSBjc3JfcmVhZGwocGNpZSwNCj4gKwkJCQkJCSAgIFBBQl9JTlRQX0FNQkFf
TUlTQ19TVEFUKTsNCj4gKwkJCXNoaWZ0ZWRfc3RhdHVzICY9IFBBQl9JTlRQX0lOVFhfTUFTSzsN
Cj4gKwkJCXNoaWZ0ZWRfc3RhdHVzID4+PSBQQUJfSU5UWF9TVEFSVDsNCj4gKwkJfSB3aGlsZSAo
c2hpZnRlZF9zdGF0dXMgIT0gMCk7DQo+ICAJfQ0KPiANCj4gIAkvKiByZWFkIGV4dHJhIE1TSSBz
dGF0dXMgcmVnaXN0ZXIgKi8NCj4gLS0NCj4gMi4xNy4xDQoNCg==
