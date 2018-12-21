Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022EAC43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 18:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AAB21927
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="aZoDlWPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbeLUSz0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:55:26 -0500
Received: from mail-eopbgr800104.outbound.protection.outlook.com ([40.107.80.104]:47264
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731021AbeLUSz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Dec 2018 13:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxBrD12U554td+V8VY5muoceZvmxzGHekiIQXDQ9UW4=;
 b=aZoDlWPNtaYF0CIJUqr7Ys/oA0tszfXquhaxeImCeqqpnvPpfD7JxIeS5UnJ6QHsVqQAOo+8gCGvbjcvbe+js2BaA53fV/7qBPxnpxLYqcSA1pvl6q+fYRAOLl+LEzp9no/4mkeMET1dvEpvWdsjTzb01M5CHnnqK0YjtbvRQCU=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 18:55:21 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd%6]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 18:55:21 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
Subject: Re: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
Thread-Topic: [PATCH 09/21] PCI: imx6: Drop imx6_pcie_link_up()
Thread-Index: AQHUmP7/jDHJh57tPEeBrh7TyaTulKWJi3IA
Date:   Fri, 21 Dec 2018 18:55:21 +0000
Message-ID: <1545418520.22930.82.camel@impinj.com>
References: <20181221072716.29017-1-andrew.smirnov@gmail.com>
         <20181221072716.29017-10-andrew.smirnov@gmail.com>
In-Reply-To: <20181221072716.29017-10-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3708;6:n2psTfFqnZw2aBb6nBVCDP7sWyMBoPwGZpctToDqt2FYYJH1zpsdjYGULxvzN1ZoFgQ+uZK+U4WvlOmgzGCAulMuWuPT8J19NiPahqgV0ZMELhPZDL2zS5Ka+31yzIhQgJylZufoBXIPUWpgoKvbLVnedAC0gv/RfExsdSZr9Dr2LIVw/GueVivi0P1kW4vlgO+DmG6yqCKciI5fYpf9tI7Yo3IORtRtCyvBBAU5tKcdLj0meMYsVMbuuYoUuYgylUBRB6oqD+fEad/nhFhJEcJwPTiNyrlz22wS3i47TX0wQp0dN0zH4ZQf1BveKjGupoA2OBm2bReHxcNiskExppQneWJI1SzaBw9s4lsQXZoVm8YyX7e1ETiG/VwzL+ENHrxiAJEG4XVLRnGTEaloDLJxnFstsoeFzC43ZvtZCtz8shKFkGN3LJXCkC8mLT6aqVkTT3fFerGzg9VMcKAnMg==;5:J6tB6SEfSCjTc3m/CZaSEfeeHyxepbEERGQSFgXhBAnQYz/FYiLeCUJwq+rJ458wjMDoEMPswWOWjqKveOhyltU/ENb6AssXcm0X7XO2Yrk75Fbnfs7dtMNM2tzDA6bvszAKwHLIl+5l+mzOdQOc5l6L5YTDXRhOuQ90Q+821xw=;7:5jPA4GRrWPtLwqQOhErcBN8Fp2RVlAmMIElPUS0kQN8Kh1RwvqmEdZiVH5LMwYDd9y3bFmbSXJ5ACy9G1cV0qNpJl/pPbsb9pCz3MDOUppIo4dfsFUgOfEA0wdI8c07VJWMeUtCBQQiWosb0bK8PmQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 43e915ba-c6e3-4d82-6680-08d66775dbd3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3708;
x-ms-traffictypediagnostic: MWHPR0601MB3708:
x-microsoft-antispam-prvs: <MWHPR0601MB3708585E480FFC8A7DC5CE0DD3B80@MWHPR0601MB3708.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3708;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3708;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(3846002)(476003)(54906003)(110136005)(6116002)(7736002)(229853002)(2616005)(26005)(99286004)(11346002)(446003)(4326008)(256004)(305945005)(6512007)(8936002)(8676002)(76176011)(53936002)(186003)(6506007)(36756003)(5660300001)(81156014)(81166006)(39060400002)(478600001)(2906002)(97736004)(14454004)(7416002)(71190400001)(106356001)(103116003)(86362001)(4001150100001)(25786009)(68736007)(102836004)(2501003)(105586002)(6246003)(66066001)(71200400001)(316002)(6436002)(486006)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3708;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1Q8KNRJTTf3xGb2ul0oBiqpeLwAreMCJqYAPqQhyqYni9kCC/m29w59D7m4kxWJMXmejvlhWfx400EkuUbYs8IAV/pVtEDhMbkpQAQSmDv/CBmCYiFslXd7LCX+AFX9iiskCscgkxcCa2vTCeKVgduwH0/i7iZfjq5SMJiEqbncflp5cGEVPJn68toiECzeKAcpIGJxNX5RKOJ8sFo3nD+Ynq3en6gDnSX34LxyKSSpvX5M0ehR8ljcUuuXY2cSRNF5HarAsua4UFUiixf9kKSD8LaonWNexBaziL+MnFv7hxDvGKSLimNkH8KKg3MtT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF6B630FB853014DBFAE6E38AA55AD80@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e915ba-c6e3-4d82-6680-08d66775dbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 18:55:21.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3708
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTEyLTIwIGF0IDIzOjI3IC0wODAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gVW50aWwgY29tbWl0IDRkMTA3ZDNiNWE2OCAoIlBDSTogaW14NjogTW92ZSBsaW5rIHVwIGNo
ZWNrIGludG8NCj4gaW14Nl9wY2llX3dhaXRfZm9yX2xpbmsoKSIpIHRoZSBkcml2ZXIgcmVsaWVk
IG9uIGJvdGggTElOS19VUCBhbmQNCj4gTElOS19JTl9UUkFJTklORyB0byBkZXRlcm1pbmUgaWYg
UENJRSBsaW5rIHdhcyB1cC4NCg0KSSd2ZSBhbHJlYWR5IGdvdCBhIHBhdGNoIGluIHRoYXQgZml4
ZWQgdGhpcyBpc3N1ZS4gIFF1ZXVlZCBmb3IgNC4xOSBhbmQNCjQuMTQgc3RhYmxlLg0KDQpUaGUg
cHJvYmxlbSB3YXMgY3JlYXRlZCBieSA4ODZiYzVjZWI1Y2MgaW4gb25lIGJyYW5jaCBhbmQgYnkN
CjRkMTA3ZDNiNWE2OCBvbiBhbm90aGVyIGJyYW5jaCwgdGhhdCB3aGVuIG1lcmdlZCBpbiA1NjJk
ZjVjODUyMWUsIHRoZQ0KbWVyZ2Uga2VwdCBzb21lIHBpZWNlcyBmcm9tIGVhY2ggY29tbWl0IGFu
ZCBkcm9wcGVkIG90aGVyIHBpZWNlcywgd2hpY2gNCnJlc3VsdGVkIGluIHRoaXMgY2hlY2sgZ2V0
dGluZyBkcm9wcGVkLg0K
