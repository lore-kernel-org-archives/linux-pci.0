Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF230C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1F62173C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 13:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mf/ha0U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfBZN12 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:27:28 -0500
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:13319
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfBZN12 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Feb 2019 08:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txlEcljegN5mqkt8F1f/ZiILK0wigoN/AJtI0pUecfc=;
 b=mf/ha0U0C7T8YTjIjonOfoNVHUn9zqpmS8yeq1q6elL70EMAxmVC0m1d5NjgL9uh2OoxE5hViVuydrQF59Kpq33fq8HWKSYtvDL1N/J+LE0UrnZAEv1nqwBC4qIqTmN5XvewKTz2hHXsT5O6lKC1qHlb2x/xHyDk0JNerizaEho=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5293.eurprd04.prod.outlook.com (20.177.51.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Tue, 26 Feb 2019 13:26:43 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 13:26:43 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH v8] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v8] PCI: imx6: limit DBI register length
Thread-Index: AQHUzdQmLnbyxVa2okayGnNos090W6XyEhqA
Date:   Tue, 26 Feb 2019 13:26:43 +0000
Message-ID: <38ffc6dffee2ccc70db07efcd04acdeb5b73ebc1.camel@nxp.com>
References: <20190226130649.5148-1-stefan@agner.ch>
In-Reply-To: <20190226130649.5148-1-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 087c3a50-1ebc-4ada-0460-08d69bee0c88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5293;
x-ms-traffictypediagnostic: VI1PR04MB5293:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1MjkzOzIzOjBKOEVrZ0ZtNkhCcDY2dysvRXpSNGpvRlB0?=
 =?utf-8?B?WjF3RWVsZ2hMbWVUdHVlK2lCRWNSRXJCSnFpSjdMUkJHSGozT2FaNHJsOTh4?=
 =?utf-8?B?TVNCdVBCc3htT1ljOGVSaW9FdHcxK0FTSjhYR3BwOXNBbHBhZkVlakRkZ1h2?=
 =?utf-8?B?MUFPSUZjN0JvWFR3b0Fwd3VVWGZpSFRZWUdBUi9nUVg4WURGQUpWYUthUjc5?=
 =?utf-8?B?MzRmWlpOdmtZYmV4UWw4N0tKeFY1RGlsSGdqNGNlblJwdXlzOTcvSGxjWU9t?=
 =?utf-8?B?bFo3YVNzT2dZK09OOGQ2cUE0T0JNdERnMkoxajJkRnNRQnZlKzZtaU96aUVn?=
 =?utf-8?B?KzVCY2ZrcTJ5YThjdzRoSkM0ckJUZHB5M1g5TXFzSFBMaFEvN1lnaEVnN2Q3?=
 =?utf-8?B?TmZoWGwxc3FweGtTdWlhS3E0dE5lZzdDNmttVHY0dmpNR3BSR09VbmxFUVZX?=
 =?utf-8?B?SXJUaHR4bERDeW9kSWpoOWJveXdiY2NkbVhBb2xUZ29QQ280QVYxNTczK3Ju?=
 =?utf-8?B?dUFOT0JOSmc3aVRHaVgwL0lvWFUwUW5IS2JNS1RCMGwzaXVBVWxBZ0dBeEZN?=
 =?utf-8?B?RGU5UlFxdjdma1ZWb1lsYXl3UDc5ZlJwMlQyUEt2UnpKSGV5S0YxRXNHazdM?=
 =?utf-8?B?RThwMlgyZjNzV0dUTHN6Q09OQ0MxRHlkaW5xZkV3RWVnNHBuTUdkeHY1ek03?=
 =?utf-8?B?aGVrajdibnFxbS9UaHpNVWpIVTlKYVVRZ1g4bDVrOEk0bjZvQmV2Z2ZHbENi?=
 =?utf-8?B?dHRyNzZaVEdYbjhRT29sdWFEZGdmaXF5TlJlSEFIUDM4OXQ3aFEvOUZwd3R0?=
 =?utf-8?B?c29tWE1oUGpaODZmMmlEdWhOYkRsbjJGc1FyVng0U2hJaDJjWm9iTWJHS2Rp?=
 =?utf-8?B?R0N1ZnphTGtQaGdRdmduMzdGZzF4TkhFUGFqUjJQait1cnZYZnArM096K3dQ?=
 =?utf-8?B?N01Pd1ViMmJDUjl6RlR3VnRLbzRoZ0thRGdMajJ0U0NuWlBDQlBOU0ZsQW8z?=
 =?utf-8?B?SDFaMDQ3Rm9XUi9UYVRwU243dHZDU3RBbmh2RXF5MGFKSXc4RjJKNVRCNzE5?=
 =?utf-8?B?blcremZkcXkzbys0MzBCMjgrY0NXYzFUUDNzQ2t6WlpYa1dPVEI5NGErVTJl?=
 =?utf-8?B?SWszZXZkaDRDT01RMGdCdEFpWnJWRnZNNjNicjNQZTZ5akplR3J4YWtwaS9C?=
 =?utf-8?B?R3RSa2xYcTIxUnV0SEIxOXBvUE96L1hISWpRYW1aN1k4c1cvL1AxYzBQckxF?=
 =?utf-8?B?eFZNVG5nVk9Zc0lZc0U0VXNNY2VrVHd6cTlEVU5LMGY1UitwcjNWc0FVcUZR?=
 =?utf-8?B?L2FXcnlLcDEzd0tIM0VzNTVaT1o1bzBHYXd5K0poYzdGOUxkSDhoN3pza2J3?=
 =?utf-8?B?U1NWY2gwOWtaRFRuUkxWRGxNS3lZck50dkthcjJYMEp3ekJNTkY3czJ1QnJV?=
 =?utf-8?B?WkVORkg1MTF2NFZaNjNoRVJwYnBveW42WUlVcmh3R28rZExlVllDTHVhZHFE?=
 =?utf-8?B?dEFETUZQZUZObW5VR21Hbk5WdmVnZ1NYOE1TeHJQdFVpOUlWNFNjSzRDMDdX?=
 =?utf-8?B?VVd6VmRoTU54VXh2cmxWeGQxWkd1U09CS3NZcGdabmdrMVd4c3l5bUxldmZQ?=
 =?utf-8?B?dFhaUU04aXk3Snk1clo5TVAwc0dJcG8veXhtNm1OMTJSWFRFVE9aN3JUZnhG?=
 =?utf-8?B?dHBEaXpONUNUa2FhR3AveCtOS0g0VlNia0tjRVQ3c3NrQ0ZURkwrTVhwekRD?=
 =?utf-8?B?TmlwYVB1cktVdzJJUllIQmJYcFBDSVBzVFBaZS9xblBERVVIVnB0ZHBqcFBr?=
 =?utf-8?B?SEhRRWxyNERqQk1VL1JiSXYrQU9Vd0xNSk1XZ2h5aEQ4bkFJZnVXZ1NuQUV4?=
 =?utf-8?Q?ApDtp7b7hNw=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB52932C1909790F6DB76F1D42EE7B0@VI1PR04MB5293.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(6246003)(14444005)(5660300002)(14454004)(6436002)(186003)(26005)(256004)(6506007)(8676002)(86362001)(316002)(68736007)(478600001)(3846002)(66066001)(71190400001)(2906002)(71200400001)(6116002)(99286004)(6486002)(102836004)(4744005)(6512007)(50226002)(76176011)(4326008)(54906003)(81156014)(229853002)(106356001)(2501003)(6916009)(97736004)(44832011)(53936002)(25786009)(105586002)(118296001)(476003)(5640700003)(2351001)(2616005)(36756003)(8936002)(486006)(446003)(305945005)(11346002)(81166006)(7736002)(1730700003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5293;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: opL+0kQD5IXEwekZSkX8Kj4DJOVAS0gPbC9i8XTiawYzJeBq7sE6T/hVyOG+/n4G2tajI0nBbq8vT50IDi2TbcxYYa2AryblJx1bSKG1H+dRwsYfgrV6UAprxjVUZ7wgC9467elzg2HCS871Lsh5aTtFy4CWR+731vTJszCqJ94k3INiMBSw/PEUCZio7AwDBHOI2xrFFIVDW7ZU5Whe+1hTsCI90emSVb5lLVePffEkQN41+DN/jDwRBE5LIJQ5DAjRh8t/meTPPgQqeInjtyIZnR38GeZu4ehu38DLiqbbKm8LxK3aC5H1yRMIjzqDcMGMsEGF7DXwh5f1WdXm0qOAvRtcFqiINkxKycaCD/hbLDzVQXM+tZzBZobTDWCRbGE6ZMqtz8OUIqoXSmaYJjbo4syr2wHTpc66ncvcx/0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFBDE2EE94C98B4E8036389F5D3144C0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087c3a50-1ebc-4ada-0460-08d69bee0c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 13:26:43.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5293
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTI2IGF0IDE0OjA2ICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzIGFuZCBsaW1pdCBjb25maWcg
c3BhY2UgdG8gaXRzDQo+IGxlbmd0aC4gVGhpcyBtYWtlcyBzdXJlIHRoYXQgdGhlIGtlcm5lbCBk
b2VzIG5vdCBhY2Nlc3MgcmVnaXN0ZXJzDQo+IGJleW9uZCB0aGF0IHBvaW50LCBhdm9pZGluZyB0
aGUgZm9sbG93aW5nIGFib3J0IG9uIGEgaS5NWCA2UXVhZDoNCj4gIA0KPiArc3RhdGljIHZvaWQg
aW14Nl9wY2llX3F1aXJrKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IHBj
aV9idXMgKmJ1cyA9IGRldi0+YnVzOw0KPiArCXN0cnVjdCBwY2llX3BvcnQgKnBwID0gYnVzLT5z
eXNkYXRhOw0KPiArDQo+ICsJLyogQnVzIHBhcmVudCBpcyB0aGUgUENJIGJyaWRnZSwgaXRzIHBh
cmVudCBpcyB0aGlzIHBsYXRmb3JtIGRyaXZlciAqLw0KPiArCWlmICghYnVzLT5kZXYucGFyZW50
IHx8ICFidXMtPmRldi5wYXJlbnQtPnBhcmVudCkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJLyog
TWFrZSBzdXJlIHdlIG9ubHkgcXVpcmsgZGV2aWNlcyBhc3NvY2lhdGVkIHdpdGggdGhpcyBkcml2
ZXIgKi8NCj4gKwlpZiAoYnVzLT5kZXYucGFyZW50LT5wYXJlbnQtPmRyaXZlciAhPSAmaW14Nl9w
Y2llX2RyaXZlci5kcml2ZXIpDQo+ICsJCXJldHVybjsNCg0KVGhpcyBsb29rcyBsaWtlIGl0IHdv
dWxkIGJlIGVub3VnaCB0byBwcmV2ZW50IGludGVyZmVyaW5nIHdpdGggb3RoZXINCmR3Yy1iYXNl
ZCBwY2kgZHJpdmVycy4NCg0KUmV2aWV3ZWQtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5j
cmVzdGV6QG54cC5jb20+DQo=
