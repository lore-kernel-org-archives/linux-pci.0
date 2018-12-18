Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD6C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C6A2133F
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 08:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WQAW03xH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeLRIyl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:54:41 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:46304
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeLRIyk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 03:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDFsE9MzEXWYxTH886l0FwATo2KAS3kZrunXM5qgnk=;
 b=WQAW03xHpuWTAUZCr7JbsS00CX2CbaQRQiMSsSAH4Myw6376Bl6/C5ZO6J1gE73A3Xo/yMRsfjvo+Ar524Zg6p5pb0b1Fz5FB54tVcO+RZ40D8lTwSsHg1Mp5OXXunkIofPnyXI+oSDuqjk2YY17ivCp10ahRc04SPhCpqAB5Ts=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Tue, 18 Dec 2018 08:54:37 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 08:54:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Thread-Topic: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Thread-Index: AQHUlqsEL0ralr2LcEeLxz6y6GsB66WEMUIA
Date:   Tue, 18 Dec 2018 08:54:36 +0000
Message-ID: <9ba5927dd322732b73f1fa0852ec20fdf918ba7b.camel@nxp.com>
References: <20181218082329.GB440@kadam>
In-Reply-To: <20181218082329.GB440@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3247;6:L3PFK0zdamQawAfGhwVYIMDLb1bkDLbqGnXVAdWrWKFlGBDngcwT66pfZPuMAQxJOz1E8xiNgGm+lVAj0odxlj4zqI8mcytvAECcOTCkNFVUBpOhTXjEDyCqZgID5EEDv/GpmV8sqmxnEyHuMqEV2PeK2Ectpb2GrpvyrakMFZGb11kJdVnRDaPRxUUw0jkWQgQu2MDgY/ROB8bNS9Jrt5PzYTKd0ublI8/g9xz69bfp97s7dAV39i6nnh7BI20tsntMLYWAtqBJ/e/aBrSkJNj1nv1x+hWXrYjf7wTD5aOVB80D1/dSDqxCMqGH9+hSlfojRdcEXH8qWcgkLIC2uqbjTSNHL+oDUOo+VtWJf2GT8+NreoqB4SIndYDEyhXKLfWhR8D3x976dn2O/bE+lF2Cvksl1UOO5PMu4oQc2YHoWU1jM6rF2eM6rc0hFuSp0bPAQ6Ju9n6CAZha0ICvpw==;5:6LjoPFTrfD9K6E1pCaCOxUa7BhX9RHBLzpJIAXF8JB01O/Sax0sun2M1MpRwbHwEMwYamTmKsP4I1KG76UzpyZJX145nvevSxCSkDLIfj+th41JocexsoFq0hRSNFpQ8ENVIxq0/Z8BolrnnW6dt2Z0FFtrTxgCV4+KYxJLW07E=;7:Fc73ggdKH8iVqMM6vidnbdGNbavQknTm3pAxGBhi0sc9bFs1+DyB+y03n4k8lgDhkycWP7VL5TkwEk7kPjKI2TBo7V7egRMD9gEm6OO6fp+IMEbNC+DvrGgZHDS2yHIfehC4bGMdH0PAQ3CmlPM3jA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 407e27a0-19a8-4d43-3759-08d664c67039
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3247;
x-ms-traffictypediagnostic: VI1PR04MB3247:
x-microsoft-antispam-prvs: <VI1PR04MB32478BBFA6420664E68B7294EEBD0@VI1PR04MB3247.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3247;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3247;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(199004)(189003)(256004)(26005)(476003)(97736004)(66066001)(110136005)(118296001)(5660300001)(11346002)(54906003)(2616005)(2906002)(316002)(446003)(102836004)(76176011)(6506007)(7736002)(4001150100001)(486006)(478600001)(186003)(99286004)(2501003)(81166006)(81156014)(8936002)(44832011)(8676002)(4326008)(305945005)(25786009)(6246003)(14454004)(68736007)(36756003)(6486002)(6512007)(86362001)(6436002)(106356001)(105586002)(229853002)(71190400001)(6116002)(53936002)(71200400001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3247;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2iclC2E9h5JqERGMmVMeyd3idZeaTTnAomDgS+1xvinDHFQrwOsZ+rdslMM/IimjZLjtM6n4Fs31rDPY/8lH3cZ9Qz89FrkO9anbnGEaguPugbxJWXPQ0wf6VlAnmOfR3etqOdT+66RpHCIZEeX8pKfPBGNaU5DcnwUW6m4OvKXbIyqEhfrCUMB+Agg/KGfQ0yun4VzYMHJCxYSn4BefUUyAvxvpXDltHARYVtfDQ3t7WXBsfcSi9WQ0yfyT4BKeKfg12kvh2K6amyx6bSI++flSj3EVAl9QIICjHAongR2AON4MxyckUX39WW6UsZdY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDA3C0846313CB4A995BA11C6D3EDF86@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407e27a0-19a8-4d43-3759-08d664c67039
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 08:54:36.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3247
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTEyLTE4IGF0IDExOjIzICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGUgZGV2aWNlX2xpbmtfYWRkKCkgZnVuY3Rpb24gZG9lc24ndCByZXR1cm4gZXJyb3IgcG9p
bnRlcnMsIGl0IHJldHVybnMNCj4gTlVMTCBpZiB0aGVyZSBpcyBhbiBlcnJvci4NCj4gDQo+IEZp
eGVzOiA3YTY5OTExNTliY2QgKCJQQ0k6IGlteDogQWRkIG11bHRpLXBkIHN1cHBvcnQiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQoN
ClJldmlld2VkLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0K
DQpJIGFzc3VtZSB0aGlzIHdhcyBmb3VuZCB3aXRoIGEgc3RhdGljIGNoZWNrZXI/DQo=
