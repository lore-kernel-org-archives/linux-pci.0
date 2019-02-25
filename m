Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51BDC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB7020643
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nARC/xyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfBYOrr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:47:47 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:44544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbfBYOrq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Feb 2019 09:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRGO2QOIC3iWLWceNFj3hoYYCzaqjk6QZ7pkeqybV3o=;
 b=nARC/xyRE86oGUdz6LVQOYKKGjYlEkyhzTXV60NJkpQNF1B0Gwk2Sa0RwLpfsiu824cEu7T6b4sUk6oyGlTFipZe2wzhwbxPlaWuYDTGm34KniNMvSzl8REF9r/2qGdFXoPSTQhdddNMF3okTeamSj4H6n0bRymZp5mf/DnrYDg=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB2957.eurprd04.prod.outlook.com (10.170.228.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 14:47:30 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 14:47:30 +0000
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
Subject: Re: [PATCH v6] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v6] PCI: imx6: limit DBI register length
Thread-Index: AQHUzRYFfG3BBpei4EOgQcykm2G7xaXwl9WA
Date:   Mon, 25 Feb 2019 14:47:30 +0000
Message-ID: <cc1df497422f38649b8d62cba794ed4ad7aa6619.camel@nxp.com>
References: <20190225142537.29042-1-stefan@agner.ch>
In-Reply-To: <20190225142537.29042-1-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8d195ce-c9fa-45a6-edd7-08d69b302b0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2957;
x-ms-traffictypediagnostic: VI1PR04MB2957:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIyOTU3OzIzOkxxUEYrc0RZYzBrdFAyajJsU0VTMDViZzQx?=
 =?utf-8?B?WnlwS0RZT1RKVGFqaU9YcGlMcEhhYXdrV3dKeWRyZVEwV0liR3k2TytDVEor?=
 =?utf-8?B?WDVQWkl3WFFEM0FwQzRQV3VJR1VINEd2SGw0NFo3bzFQZEFMeXpRaHR3eWFX?=
 =?utf-8?B?aFRGSFF6MVRETGlUNEh3SVZqbFVpeStvSDI3ZFVpT1o2a1c4TUxLTGtiL0cy?=
 =?utf-8?B?VHRaRnlTN21OOEcxU3FDbUlMeUdIV3JFNFFPZy9VVFQxZDFQS3lIdmdrVThC?=
 =?utf-8?B?TFFZT0JtM0dlVndkcGU4YzBmb09aTzdmT1RsUG9tYnVub2FocGNNMjNaT0Nn?=
 =?utf-8?B?QmhnUWtSSm12QkdyVG1ZZVl1eFQwOXdqNnZodzdrdzJMUUF0cXhsWFBYWmQv?=
 =?utf-8?B?bVU4NjNIbHBlUkUwSVUxNGcrUGw5VGVoY3c1NEJzajNYeFVHNFJYUWtyVWNX?=
 =?utf-8?B?WGQ0UXcyMFRjM1lydHJrNE1PQXBxaHBRbElOaDFUS2grQ1YvQ3BScE5wT1M4?=
 =?utf-8?B?Q2lRLytGME1LYm1TMXV3bE11SGFCeWVkV0RkWGpHSnA2MjlhSTZLVWd2bFBN?=
 =?utf-8?B?T21yTFJqSjYvWGgybU1ubkxKSndDbDByZjQyS2JyeE81dkUwQzYwWkx1UHNP?=
 =?utf-8?B?M3hzaFIwVTBpOUJXbHZCcFA3NG5Wc2RkL0lGU0tiaXczMytUVnBJNDU2K1Fx?=
 =?utf-8?B?NzdlVGtRQmtseTJRakhnZEZhbzRBN1A3MlpkVWhDb1dBQkZRLzJDWDBxaXVY?=
 =?utf-8?B?bmtXdFVQYVkySmtXZUlMUWZwd3BxSlJsWWhpUTdqU2xURGJOdWdDR3MyRVV4?=
 =?utf-8?B?Qk11T05reGVpVUNTRjBLRlAxSkE3Q3V3TUkxbTUrZVhPNkIzeE4vZ3Yxekhj?=
 =?utf-8?B?MUhiN1hqQ0lSajl2YjVnOU5XNkhQeWtxQXFkK0R1d3hSSytPaVNOU2FTNW0r?=
 =?utf-8?B?NHBQcnNnNVFuZDZlT2ZyZmVyU3J0bElNdkprMmZNWjQvRzYzN3o1U0xVdU9W?=
 =?utf-8?B?L1JmMkphQ1VnMm5KL2ZjNlR2ZTJhRjNOU2FuVnpVb09TaFlXeGNVNlMzMlZK?=
 =?utf-8?B?TjV3RU1aNlQ4VFRkRDREZFdBVElWUHUzRDhNQjlSQ1pMMU1PVUk1K0ZUcDRo?=
 =?utf-8?B?OVNSSmFJc0VEVEtXYWczNXo0RW5UaWovZ3hnVXRlQzFPcXFMWkYrd1JhL2h0?=
 =?utf-8?B?N3h3WkJaSElROEFSWUFGcG52eWlEQWtoTldTWHlIdkxVdmtxOS9oMHgxeGdx?=
 =?utf-8?B?M01tYWRyQW1rNmZEWE0rUHBYMkJGOW9pL1lnL1l1cHRucGo0N0ozSVhvaDdE?=
 =?utf-8?B?Mis1bzJ6K2JqWFUrc25HK2pEVXYvWEZ6eGJ1T2x3a1FRUENsd21QWDBGbGVE?=
 =?utf-8?B?aVh4SWVxcFg2d1VYVEo0NVNvUlVKTHdmU2krRnN4WmVaeGxqcWZ0empkS2lX?=
 =?utf-8?B?ZThyY21HNzhYMDFIQWFGbCtaQmNMeEdMb3Q5L3dXTHJnS1VMYkZEL2xzNmd4?=
 =?utf-8?B?Qm1Ra0k0QXE0TE5ZQW9HK0hiTjVIQ2wyY1Z6TU1JYWQzS0doemFLWFhaWmRu?=
 =?utf-8?B?RHZtN1BLS0lYTTNhNVJFdWY2SEgrVGRoVGFuQnRsRVVvUzEvaVZXUUw1MVh2?=
 =?utf-8?B?VHFjWUF4K0tGVjk4N1ZpSUZKK0lKcWswQW9ib01JdExobE5hcmpoNmxKRTJh?=
 =?utf-8?B?Q0tsYzBZUXYrSUVCaWx2R05UVDFVc0w2bHpJZHVHZ2phdElnMmcxTVJqUm9i?=
 =?utf-8?B?cnBZRHY2QVA5d0psL2MzWlpzaVQ3elNTUGo4ZmMzTzdLWEEvL3NXTmJoMXUz?=
 =?utf-8?B?Q01oZmw2MWFhVk8zd0h5N1RqdWwxOFdialNQaHI0a2JSNEE9PQ==?=
x-microsoft-antispam-prvs: <VI1PR04MB2957D896F7B105006AC75A7BEE7A0@VI1PR04MB2957.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(6506007)(26005)(476003)(3846002)(118296001)(486006)(186003)(6116002)(316002)(4326008)(54906003)(11346002)(25786009)(102836004)(229853002)(2351001)(2906002)(86362001)(68736007)(5640700003)(6486002)(2616005)(6246003)(446003)(6436002)(76176011)(99286004)(5660300002)(66066001)(6916009)(6512007)(2501003)(71190400001)(71200400001)(105586002)(53936002)(106356001)(44832011)(8936002)(50226002)(1730700003)(81156014)(81166006)(8676002)(97736004)(7736002)(305945005)(478600001)(256004)(14444005)(14454004)(36756003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2957;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dbIr7OLRchi/OXVPbG/Ri88fRWC5x1fNVDFHKPaXg9l9JT/e7jdExNAAf0UPi1++rjgzglLWwmbbQkxGgkE6UPk1irCosi/N3AgHME1pRNgoP5SHN2tTD+OIcUeVPaIONeWxBgUnE2JjkzQnZX3w98OVKVCzP8peQjvJU0dR+rHVIoKI3axP3I3W4f9Ev9CrZ0Ua6AKUnbuG9lf5LRhsf28dXm9etWf93ugZ1zhVLoEBhiZ+3RW5Bd4zjhP36XQNQ8nE05z4iOSygp8FNClTUwWnAUbGSQQUJZ7htXcS00EOD7LF50Jw4kqt5+K5dF7ER7l6UhjK7n6KxEQR0+aZCX4JbvgTE092yeyDazpBjYlfNsET0Iv8Mba2i+Yl4huGaN8auL7n2K5bLpy2171SzV84fmOzwFvqYlC7FHXV9rQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DE4D9B46A52AA478E629E29FACD6DF2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d195ce-c9fa-45a6-edd7-08d69b302b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 14:47:30.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2957
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTI1IGF0IDE1OjI1ICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzIGFuZCBsaW1pdCBjb25maWcg
c3BhY2UgdG8gaXRzDQo+IGxlbmd0aC4gVGhpcyBtYWtlcyBzdXJlIHRoYXQgdGhlIGtlcm5lbCBk
b2VzIG5vdCBhY2Nlc3MgcmVnaXN0ZXJzDQo+IGJleW9uZCB0aGF0IHBvaW50LCBhdm9pZGluZyB0
aGUgZm9sbG93aW5nIGFib3J0IG9uIGEgaS5NWCA2UXVhZDoNCj4gICAjIGNhdCAvc3lzL2Rldmlj
ZXMvc29jMC9zb2MvMWZmYzAwMC5wY2llL3BjaTAwMDBcOjAwLzAwMDBcOjAwXDowMC4wL2NvbmZp
Zw0KPiAgIFsgIDEwMC4wMjE0MzNdIFVuaGFuZGxlZCBmYXVsdDogaW1wcmVjaXNlIGV4dGVybmFs
IGFib3J0ICgweDE0MDYpIGF0IDB4YjZlYTcwMDANCj4gICAuLi4NCj4gICBbICAxMDAuMDU2NDIz
XSBQQyBpcyBhdCBkd19wY2llX3JlYWQrMHg1MC8weDg0DQo+ICAgWyAgMTAwLjA2MDc5MF0gTFIg
aXMgYXQgZHdfcGNpZV9yZF9vd25fY29uZisweDQ0LzB4NDgNCj4gIA0KPiArc3RhdGljIHZvaWQg
aW14Nl9wY2llX3F1aXJrKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICt7DQo+ICsJc3RydWN0IHBj
aV9idXMgKmJ1cyA9IGRldi0+YnVzOw0KPiArCXN0cnVjdCBwY2llX3BvcnQgKnBwID0gYnVzLT5z
eXNkYXRhOw0KPiArDQo+ICsJaWYgKGJ1cy0+bnVtYmVyID09IHBwLT5yb290X2J1c19ucikgew0K
PiArCQlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX3BwKHBwKTsNCj4gKwkJ
c3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gdG9faW14Nl9wY2llKHBjaSk7DQo+ICsNCj4g
KwkJLyoNCj4gKwkJICogTGltaXQgY29uZmlnIGxlbmd0aCB0byBhdm9pZCB0aGUga2VybmVsIHJl
YWRpbmcgYmV5b25kDQo+ICsJCSAqIHRoZSByZWdpc3RlciBzZXQgYW5kIGNhdXNpbmcgYW4gYWJv
cnQgb24gaS5NWCA2UXVhZA0KPiArCQkgKi8NCj4gKwkJZGV2LT5jZmdfc2l6ZSA9IGlteDZfcGNp
ZS0+ZHJ2ZGF0YS0+ZGJpX2xlbmd0aDsNCj4gKwl9DQo+ICt9DQo+ICtERUNMQVJFX1BDSV9GSVhV
UF9IRUFERVIoUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgaW14Nl9wY2llX3F1aXJrKTsNCg0KQXJl
IHlvdSBzdXJlIHRoYXQgdGhpcyBxdWlyayBpcyBvbmx5IGFwcGxpZWQgdG8gaW14Ni1wY2llPw0K
U3VwZXJmaWNpYWxseSBpdCBsb29rcyBsaWtlIGl0IHdvdWxkIGFwcGx5IHRvIGFsbCBQQ0kgcm9v
dHMgYW5kIHRoaXMNCmNvdWxkIGJlIGEgcHJvYmxlbSBvbiBjb25maWdzIHdoaWNoIGVuYWJsZSBh
bGwgZHJpdmVycywgbGlrZSBhcm02NC4NCg0KTWF5YmUgdGhlIGxpbmtlciBtYWdpYyBpbnNpZGUg
REVDTEFSRV9QQ0lfRklYVVAgZGVhbHMgd2l0aCB0aGF0LCBpbg0KdGhhdCBjYXNlIEkgYXBvbG9n
aXplLg0KDQotLQ0KUmVnYXJkcywNCkxlb25hcmQNCg==
