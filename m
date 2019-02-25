Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B1BC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B1D20C01
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EGHIG0Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBYQQB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:16:01 -0500
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:44674
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727684AbfBYQQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Feb 2019 11:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGLa2k9YsnTeZFIz1dDYSF/K6gmNbvxwZ1GtcmzI0is=;
 b=EGHIG0ZkRH0S+s0RWkyy7HcTW/I/JUKE/z1IjGX4N1OibFwkKFW8DvrENaxI9i1VemZ5jf190u55QAOty5+wRLpKfiW8MEeSV6Isv1wYAp2XXjwAgNbWctTNyA6CJSU92/dJnlfwtPIl+xkvozdUmh37VNGzostiLOfQ2zZTmJ8=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5407.eurprd04.prod.outlook.com (20.178.121.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Mon, 25 Feb 2019 16:15:58 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:15:58 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH v7] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v7] PCI: imx6: limit DBI register length
Thread-Index: AQHUzSODW0/vA8vEpkW1nQhcvwMCJKXwsHAA
Date:   Mon, 25 Feb 2019 16:15:57 +0000
Message-ID: <34b23c031a8e0964b3e87a6252dd5cefaa62cc95.camel@nxp.com>
References: <20190225160226.11924-1-stefan@agner.ch>
In-Reply-To: <20190225160226.11924-1-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9811dafd-a3f5-4a40-a593-08d69b3c86bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5407;
x-ms-traffictypediagnostic: VI1PR04MB5407:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1NDA3OzIzOnArY2toK0ZEaFRKOU8ya2RBanlSQmtuaU1h?=
 =?utf-8?B?NXRVcGZEVUwxZ2RjejEyYjRzcHhEM1VRUTNzMGc3R0trT2VCV2I5Y3dac1lu?=
 =?utf-8?B?dGUzeWUvT0trbmc4TE11YkhJTzlPL1k0R3k0UG1CRlJGaXhqLy9yalVJeW92?=
 =?utf-8?B?SGhKcUJBUnJ1Qno4bENjbHVEYk4xL2xkbmtaTWhsUVVNc0V6dWxRd0lzdTND?=
 =?utf-8?B?Q2N4WEg1WTEwQkpPbHQrU05lOVFQYjdtZ0lMNklYZTRTOXdYaEhmMzZEVncw?=
 =?utf-8?B?bHZBZHZ5YUdHQ1lJZU1oQ3Y3ZnlyNWxzSlVEYjQrMXE2RVpIbDE3bVh1UE84?=
 =?utf-8?B?WDlISFJobEo3SVBmYXgrUERreHRBNUFQNEUzN0JzU21zRWpVVHg0WTlwTW1Q?=
 =?utf-8?B?VnBHUzkrZTFyTmN2NXE4WEp2UUxsbGRCZjJyQnNBNzVQckpQZU8zdEN6b0VZ?=
 =?utf-8?B?bTNUYUZwc25XVm1XTDNST0N2SE9RaE9MM0pPQUszTHpxT0Q1WVczZUtDdmx4?=
 =?utf-8?B?N3FVeFh3dFovVVRMUDBCNlhwclp0RHUxcEpRU1YwcDROeVdEczZ0SndMZ1Uz?=
 =?utf-8?B?ZFFUeGRHVUVSVmNuS3JLUWEvQWlYNDB0UmlZUE1VMFFwU1lkNWNRYnhrdXpV?=
 =?utf-8?B?RWNLMlZnS1RNSDMycjE0aDlqenJJQmZxWUVlWmpXTmdHRkNDOHBSSEFtMllV?=
 =?utf-8?B?Szd4RmtsUHRpdW80MWVqT01Md1hYZnZUcmZLRm9WM0V6SWF6ODZXWmVjb1Uy?=
 =?utf-8?B?ZkM4Vlc0eVVLY3VoalZjSng5M2Eyc2hLaEFKRWFabjZDVGJWMTNQemIyMDNM?=
 =?utf-8?B?c0lLWGhLREVURElkMlFPYmM3SnR2NDdLNjRSbVpkSkpVRjRoWmpuQnR4MXhn?=
 =?utf-8?B?VUl0YkM3WDBweHIxS3ZGQVJPVkdJTVErWjdaSW02bUJvVW4yWmRXTXFQSW1t?=
 =?utf-8?B?ZlRYSnRHVkY3a0NqM1oyL1U3ZHJsa2Z0UHBxdGkvS1VFVnc3aTZ6SjBLeUZ2?=
 =?utf-8?B?WnhYU25IaVU4bGVLRFAyU1FQbVN6R0hhQ2dndGRhZ2hkM1dYYUVmV3hTOWVu?=
 =?utf-8?B?UXhmTUVyREwyTHR4RjhWcENnZXhJa2xHSUtKb3dEaGhJRWxlY0tPUm5BM0xs?=
 =?utf-8?B?VndpN3VaU2Z0S1k0bUxjZnVDb0daRHlrR1NDTmtQU1RFeVg4cnorUTZScytX?=
 =?utf-8?B?cjExWW5kRlVzVXovWjdKTEFpcDRJeTdKZHNNWmU4bzd2eHZlbHd2YUJuNHkx?=
 =?utf-8?B?Yktva3FjRTJYZmdTMUU5WEk0NHpUYllkNnJJc1lKazdLVkNOZHJtNE9Ob3pH?=
 =?utf-8?B?SXc0Ky9rSEY5VEdhZlpxK21hbERzK1RHa3hyblVEMGRWSUNMZEFLeUl2L0Ix?=
 =?utf-8?B?UUx6YzdiUTZwZjB0WXVCNndlR3RHMjE0QWJGQ2cxblh4d1VMa0YrTHp1N09s?=
 =?utf-8?B?WDNEZFBnK3d1dG9BSFo3S3ZhTVpOUk9mZW5NdkZMaUpXOG1BQklRYjdmRmNN?=
 =?utf-8?B?WGlkbURDOTRKaHpVU1Y4Yld3cXJWSUg5alFxajhWZzJnTklwam82ejlVdS83?=
 =?utf-8?B?R2twamI1WGEvRElKR3l2S0N4czFMYWtwaTZMTTRqYmROdXdROWxjd0pWRURS?=
 =?utf-8?B?MUpEUmsrOFI1cGJ5OWtoYzM1RWVSYnpJcEs1bURCd2pFV3NTMzAvSUpodW40?=
 =?utf-8?B?by9XclFhc0VBS29aYmwydUJTT2dHOU1NSGJsb3RpYTN1QVFPWjllR0FCK3VI?=
 =?utf-8?B?b1lDTkI4dmJUUHh2YTI0TzhaTWJYKzlHU0RIdTEyNU9RY242THVsQkc1SUZk?=
 =?utf-8?B?TkRCM0JVNUJXT1JKb0FVUkl5VUYvNkRDME1tdE9mUDZhSmc9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB5407ECDBA213ECE11D426CB5EE7A0@VI1PR04MB5407.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(186003)(97736004)(14454004)(6116002)(3846002)(4326008)(25786009)(105586002)(106356001)(50226002)(36756003)(8936002)(316002)(2501003)(54906003)(118296001)(2351001)(11346002)(44832011)(476003)(446003)(2616005)(478600001)(486006)(5640700003)(305945005)(6486002)(256004)(99286004)(14444005)(8676002)(6916009)(7736002)(6512007)(86362001)(81166006)(1730700003)(81156014)(66066001)(5660300002)(2906002)(53936002)(68736007)(6246003)(6436002)(6506007)(102836004)(76176011)(71190400001)(26005)(229853002)(71200400001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5407;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PBrU8InmuptC8aLjpepXmVQfxaty4hmqZRIk1DGm6g0fRuhsrn4m0dNcv3syOrZA63rzvwyaqQLdbRRtUvSZxKKwalk4dUbVcPDovzpDiEhNsuo2tvgrnOAAgMsyIdL99gxOc5aR+LGM6WN8S9e6U/wRYdo2u/JhY1pFqnjC2kgG73MFX0H4W9bTlTCTpqhXIYyTLY3I8JBeVHdWjYKXdLiiQpAIHO2Bi+TSLEjMb35Pd+PbfaHUfDlsQPwEiEv+N+mwbhbk32s4mtsMe+nWM7hhGFCE3GNSUEgdKUrU9wMQr0v1towleaWxQ9sl7IEufz962quwbfMxAI7D4E0SDrik9VWAJPRg0j43HnZvXaAmd8S9mal4yT0yR36j3T43cdUk18eTxRwCHqgufq8PaBrYaBNYXgZdsugNNGyzvTc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3988F5B1D50DD4982713F5C3D647B13@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9811dafd-a3f5-4a40-a593-08d69b3c86bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:15:57.8940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5407
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTI1IGF0IDE3OjAyICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzIGFuZCBsaW1pdCBjb25maWcg
c3BhY2UgdG8gaXRzDQo+IGxlbmd0aC4gVGhpcyBtYWtlcyBzdXJlIHRoYXQgdGhlIGtlcm5lbCBk
b2VzIG5vdCBhY2Nlc3MgcmVnaXN0ZXJzDQo+IGJleW9uZCB0aGF0IHBvaW50LCBhdm9pZGluZyB0
aGUgZm9sbG93aW5nIGFib3J0IG9uIGEgaS5NWCA2UXVhZDoNCj4gDQo+ICtzdGF0aWMgdm9pZCBp
bXg2X3BjaWVfcXVpcmsoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgcGNp
X2J1cyAqYnVzID0gZGV2LT5idXM7DQo+ICsJc3RydWN0IHBjaWVfcG9ydCAqcHAgPSBidXMtPnN5
c2RhdGE7DQo+ICsNCj4gKwlpZiAoYnVzLT5udW1iZXIgPT0gcHAtPnJvb3RfYnVzX25yKSB7DQo+
ICsJCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fcHAocHApOw0KPiArCQlz
dHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUgPSB0b19pbXg2X3BjaWUocGNpKTsNCj4gKw0KPiAr
CQkvKg0KPiArCQkgKiBMaW1pdCBjb25maWcgbGVuZ3RoIHRvIGF2b2lkIHRoZSBrZXJuZWwgcmVh
ZGluZyBiZXlvbmQNCj4gKwkJICogdGhlIHJlZ2lzdGVyIHNldCBhbmQgY2F1c2luZyBhbiBhYm9y
dCBvbiBpLk1YIDZRdWFkDQo+ICsJCSAqLw0KPiArCQlpZiAoaW14Nl9wY2llLT5kcnZkYXRhLT5k
YmlfbGVuZ3RoKQ0KPiArCQkJZGV2LT5jZmdfc2l6ZSA9IGlteDZfcGNpZS0+ZHJ2ZGF0YS0+ZGJp
X2xlbmd0aDsNCj4gKwl9DQo+ICt9DQo+ICtERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZF
TkRPUl9JRF9TWU5PUFNZUywgMHhhYmNkLCBpbXg2X3BjaWVfcXVpcmspOw0KDQpUaGlzIGxvb2tz
IGxpa2UgYSBkZWZhdWx0IGZyb20gU1lOT1BTWVMgc28gaXQgbGlrZWx5IHJ1biBvbiBvdGhlciBT
T0NzDQp1c2luZyB0aGUgRGVzaWduV2FyZSBQQ0kgSVAgYW5kIGNyYXNoIGJlY2F1c2Ugb2YgdGhv
c2UgdW5jaGVja2VkIGNhc3RzLg0KDQpUaGVyZSBtaWdodCBhbHNvIGJlIHNvbWUgd2F5IHRvIGNv
bmZpZ3VyZSBwY2kgaWRzIGJlZm9yZSBib290IChub3QNCnN1cmUsIGRpZG4ndCBjaGVjaykuDQoN
Ck1heWJlIHlvdSBzaG91bGQgY2hlY2sgdGhlIGRldmljZSBkcml2ZXIgbmFtZSBpbiB0aGUgcXVp
cmsgZnVuY3Rpb24/DQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA0K
