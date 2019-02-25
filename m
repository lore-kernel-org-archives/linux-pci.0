Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B6C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E73C20C01
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="GJrZjmdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfBYQw6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:52:58 -0500
Received: from mail-eopbgr760114.outbound.protection.outlook.com ([40.107.76.114]:51456
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728192AbfBYQw5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Feb 2019 11:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X6PjT5Hqi+k020SHvk/vjg76T+Wc/18YnJXxuZI2JA=;
 b=GJrZjmdYKMtN2ar8bXH6oAAzI1UVrUT6L7ojL8oKhhfm+ee2bVn7oy9tSXs2vITipmuRtMEhY+Qfp3J6GfzvIEHIFRPEuCvqxxo6bv0HLcWf7skuhC/co99FRa3hVyjpa3A+K4ehDvCsvh2vsLM9hbAkE9mDJsorS6VmtUA1PXc=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3610.namprd06.prod.outlook.com (10.167.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:52:53 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:52:53 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
CC:     "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v7] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v7] PCI: imx6: limit DBI register length
Thread-Index: AQHUzSOEeO7CYkJQpk2Rbr2V/AwTL6XwsICAgAAKUAA=
Date:   Mon, 25 Feb 2019 16:52:52 +0000
Message-ID: <1551113572.3075.172.camel@impinj.com>
References: <20190225160226.11924-1-stefan@agner.ch>
         <34b23c031a8e0964b3e87a6252dd5cefaa62cc95.camel@nxp.com>
In-Reply-To: <34b23c031a8e0964b3e87a6252dd5cefaa62cc95.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c01c23dc-b754-4381-bda9-08d69b41aef7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3610;
x-ms-traffictypediagnostic: MWHPR0601MB3610:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3610;20:EdJvUED1H2GoDdrhilSE0esX0EZc49oZQErNtwNbGSpObFSRh462mik4UiM+ZmPlFfmuVRueIYS8FlgGFjswJ/sSL0xBYtLpiO2fVbVfcUz2LwCFbTgR8paUKce3b9KOcpy1Ig+01mZ9QAq660qq09r7JjaKL/0ex7P89AmDrZ0=
x-microsoft-antispam-prvs: <MWHPR0601MB361049F79390A93F36435384D37A0@MWHPR0601MB3610.namprd06.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(39840400004)(376002)(199004)(189003)(8676002)(6512007)(3846002)(5660300002)(103116003)(186003)(486006)(2616005)(7736002)(478600001)(305945005)(6436002)(26005)(4326008)(476003)(316002)(7416002)(6116002)(106356001)(105586002)(25786009)(68736007)(11346002)(446003)(6246003)(14454004)(71190400001)(102836004)(36756003)(256004)(6506007)(8936002)(86362001)(2906002)(14444005)(81156014)(229853002)(81166006)(2501003)(76176011)(97736004)(66066001)(99286004)(110136005)(53936002)(54906003)(71200400001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3610;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8UUkSCyIFzM/NbCHWi0blOeeG49E2WVSmKLEmjULRzS7SSlvtJCIPC7pdGwRfAbdlQfnbBPzCAdVjaCUGSU0E8MPRt8iDJDdIIhHHIXS7M1RmQC27JzG2F0+cf95t+kcZq+45EDtlHgH012mCZgdI74q9kvQZeJ1Jt6VCgapz3e6yzIprF0wogmXn+j1rRIb+PV2flm4L5S+WU/ZBdkGrm3LqUwysLjZFJ0GbEggRXbeNy4DXf8QP1J5Cwfhme3CfN4etD3NfyJRTHgAqg59OFmXAT2SHCB8psNRl5hF0aw8l5FpcHjYimeV2Q9Qb33sJspTQdFu1p0B/kBSU3qaQdoZaDexoWCTwBo77uk1aGiiwY82CMy5X9jKovbNAIGkTJGkG6YQdhkjnWS/69+sMIDIq2sRBWiVjPKxSUBaY0U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72AE21DAB962F14CB271A592FFF0E1D3@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01c23dc-b754-4381-bda9-08d69b41aef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:52:52.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3610
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTI1IGF0IDE2OjE1ICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6
DQo+IE9uIE1vbiwgMjAxOS0wMi0yNSBhdCAxNzowMiArMDEwMCwgU3RlZmFuIEFnbmVyIHdyb3Rl
Og0KPiA+IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzIGFuZCBsaW1pdCBj
b25maWcgc3BhY2UgdG8gaXRzDQo+ID4gbGVuZ3RoLiBUaGlzIG1ha2VzIHN1cmUgdGhhdCB0aGUg
a2VybmVsIGRvZXMgbm90IGFjY2VzcyByZWdpc3RlcnMNCj4gPiBiZXlvbmQgdGhhdCBwb2ludCwg
YXZvaWRpbmcgdGhlIGZvbGxvd2luZyBhYm9ydCBvbiBhIGkuTVggNlF1YWQ6DQo+ID4gDQo+ID4g
K3N0YXRpYyB2b2lkIGlteDZfcGNpZV9xdWlyayhzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3QgcGNpX2J1cyAqYnVzID0gZGV2LT5idXM7DQo+ID4gKwlzdHJ1Y3QgcGNp
ZV9wb3J0ICpwcCA9IGJ1cy0+c3lzZGF0YTsNCj4gPiArDQo+ID4gKwlpZiAoYnVzLT5udW1iZXIg
PT0gcHAtPnJvb3RfYnVzX25yKSB7DQo+ID4gKwkJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3
X3BjaWVfZnJvbV9wcChwcCk7DQo+ID4gKwkJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0g
dG9faW14Nl9wY2llKHBjaSk7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogTGltaXQgY29u
ZmlnIGxlbmd0aCB0byBhdm9pZCB0aGUga2VybmVsIHJlYWRpbmcgYmV5b25kDQo+ID4gKwkJICog
dGhlIHJlZ2lzdGVyIHNldCBhbmQgY2F1c2luZyBhbiBhYm9ydCBvbiBpLk1YIDZRdWFkDQo+ID4g
KwkJICovDQo+ID4gKwkJaWYgKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+ZGJpX2xlbmd0aCkNCj4gPiAr
CQkJZGV2LT5jZmdfc2l6ZSA9IGlteDZfcGNpZS0+ZHJ2ZGF0YS0+ZGJpX2xlbmd0aDsNCj4gPiAr
CX0NCj4gPiArfQ0KPiA+ICtERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9T
WU5PUFNZUywgMHhhYmNkLCBpbXg2X3BjaWVfcXVpcmspOw0KPiANCj4gVGhpcyBsb29rcyBsaWtl
IGEgZGVmYXVsdCBmcm9tIFNZTk9QU1lTIHNvIGl0IGxpa2VseSBydW4gb24gb3RoZXIgU09Dcw0K
PiB1c2luZyB0aGUgRGVzaWduV2FyZSBQQ0kgSVAgYW5kIGNyYXNoIGJlY2F1c2Ugb2YgdGhvc2Ug
dW5jaGVja2VkIGNhc3RzLg0KDQpZZXMsIGl0J3MgdXNlZCBvbiBJTVg3ZCB0b28uICBCdXQgaXQn
cyB3b3JzZSB0aGFuIHRoYXQsIHRoZXJlJ3MgYSBVU0INCmNvbnRyb2xsZXIgY29yZSB0aGF0IHVz
ZXMgdGhlIHNhbWUgdmVuZG9yIGFuZCBkZXZpY2UgaWQsDQpQQ0lfREVWSUNFX0lEX1NZTk9QU1lT
X0hBUFNVU0IzLiAgVGhlIHF1aXJrIGZvciB0aGF0IG9uZSB1c2VzIGNsYXNzID09DQpQQ0lfQ0xB
U1NfU0VSSUFMX1VTQl9ERVZJQ0UgdG8gYXZvaWQgbWF0Y2hpbmcgdGhpcyBQQ0ktZSBJUC4gIFNl
ZQ0KdGhyZWFkICJQQ0k6IENoZWNrIGZvciBVU0IgeEhDSSBjbGFzcyBmb3IgSEFQUyBwbGF0Zm9y
bSI=
