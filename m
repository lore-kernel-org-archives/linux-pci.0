Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB29C04EBF
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F75214C1
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="TnuWmSMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F75214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbeLCUbl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:31:41 -0500
Received: from mail-eopbgr760135.outbound.protection.outlook.com ([40.107.76.135]:12096
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeLCUbl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 15:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu+oXtGSoj+Pil9kThwUBdIeXELgNyj7RVsHwD3/OiU=;
 b=TnuWmSMglnunDmkzMoqqqpKQkSpMWy96KM5Xs486drw2eFLUW0FtMmJGBCL3rfgasbk1KfjIiYTlLLv56hCC5qdoiSUIZobzYdtOKxJtEbPjgtqZMu/gu+8hnNZTcb4alwl5riUi9HzW+NNw4lQEbFBI8asAaTW8eb4NelyPb0Y=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3609.namprd06.prod.outlook.com (10.167.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 20:31:33 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 20:31:33 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "niklas.cassel@linaro.org" <niklas.cassel@linaro.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVahvGAgBAjLwCAAkhRgIAAKRkAgABMboCAAC8aAA==
Date:   Mon, 3 Dec 2018 20:31:33 +0000
Message-ID: <1543869092.18519.134.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <693b46a1-18ea-ef94-ca18-8d3c23698986@mm-sol.com>
         <20181201235058.GA21020@centauri.lan>
         <20181203104218.GB6090@e107981-ln.cambridge.arm.com>
         <20181203130924.GA5105@centauri.lan>
         <20181203174257.GA13670@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181203174257.GA13670@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3609;6:g93hEDkl8leePLcLkZprvPsoSnSbNF4jZ/JUPr3Gd/5d2PnH7RU8ho8tyG/sS6t1Nwx0BqVEtKEMxYQvckVmrlfRfCZa0u+wJdMRf59CKXpY+lIKfJzfzXa1YyR3+PxEVaWj6k463X1kS4PlakK+8c1+3MdoG736sbjuqulL+EKUGnhZDeDSAktNNW4Jj9rUZV8zBafhShtp1YcI1nzTQ9Z6M7x0QYsqOV2jj+gCzquo7m0BzrCyiwNrnKg5LPSFh5DUR0ErVkBzHKcVxIjobwMdLRbNV4AVBAfP1atCKQlI/wLayG3ih39WhGR/ls4yqwg5khbLSsA6WtvLr+KGnpHOrJd5bqq3usWsE5E3VoGW24ra3m5gZuyUUBmTg6ZuP8d3uha0XS4jJlA1RE98wwp4W1Ht6oUNcR/GeHJIiOt/llxzoj0xB3V/d9fnF8h2IyJ/mXenTelmHiPRc66zwA==;5:VO2deMYAs5hR5T/u/n6pt1PpicIF9Ta+JEIx/yh+iZrxK9bz47Ocm9wf8j0QIGp6WkkLgoKZd5nJcxGOBnCK3ChH9bUhFwbkMwwbX1gtMK4qzgVEKAe+vOkbRPBZjjnf2OYTnWgiFA2k0n4o+J52iDQvNMQldT8hyrE64gpQGEE=;7:3yapL+wPbEr7yd3eteEkJi0gbmRK1ukcQSKiqUGOJoCHTE1IA6RJEDDAXavaNxZ7We1RLoKYC4+VEAj4XXmQSPjcmz2Ait5ilgq3d91iv7vNzC8hNfZMMYCGFNe9T8CpXacNcbNQV8PGL6VElbQaHg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 493c62dd-7b0b-4cda-83e1-08d6595e509f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3609;
x-ms-traffictypediagnostic: MWHPR0601MB3609:
x-microsoft-antispam-prvs: <MWHPR0601MB3609D8287CDA225781EDC5ECD3AE0@MWHPR0601MB3609.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3609;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3609;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39850400004)(346002)(366004)(199004)(189003)(229853002)(6436002)(14454004)(97736004)(26005)(186003)(53936002)(7416002)(102836004)(25786009)(6246003)(86362001)(6486002)(2906002)(478600001)(11346002)(2616005)(486006)(476003)(14444005)(71190400001)(256004)(446003)(71200400001)(76176011)(110136005)(54906003)(105586002)(6116002)(106356001)(81156014)(81166006)(36756003)(103116003)(99286004)(93886005)(8676002)(6506007)(39060400002)(4326008)(2501003)(305945005)(7736002)(66066001)(316002)(8936002)(68736007)(5660300001)(6512007)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3609;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LnYZj4sXm/+4L//k1IOtfcIdEmDKWk77wcsXyn1BQBFHvWnztObWyTMxFDgZ+VnLoWpdB9njq7RXNe5rKlcUjMPih/n/yoxOxvKPQVby8ZvxMKxEtvMXTt1I9TFDhfkNQchIqKohWeY+fjReda8jERdjNWa101S7ovvcAo4y7LTJEKkRTer6+Sp2BpiE5NbuHwgUbleOm38HtHZOaSP3oQiaGT5rnK4Dey3M8sI8wDTW73iSZaMET1ajorzzdB3yZAtVrp9Fg20WMb5pIiuI+RG6KMTsXV6Jy/8T116eERZ6vOASlz52zMbdHZIQSzHGVTdMRk6NJDFow2EZ8KrmCLNjXZ478nbD4XRyd1NySZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <202435A68FE12A4DB2AFA23C3A3082BC@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493c62dd-7b0b-4cda-83e1-08d6595e509f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 20:31:33.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3609
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTAzIGF0IDE3OjQyICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gDQo+IA0KPiBJIG5lZWQgbW9yZSB0ZXN0aW5nIGRvbmUsIEkgZW5jb3VyYWdlIG90aGVy
IERXQyBtYWludGFpbmVycyB0byB0ZXN0IG15DQo+IGJyYW5jaCBhYm92ZS4gSSBhbSBtdWxsaW5n
IG92ZXIgaXQgYnV0IEkgbWF5IGNvbnNpZGVyIHRoaXMgdjQuMjENCj4gbWF0ZXJpYWwgaWYgSSBk
byBub3QgZ2V0IGVub3VnaCB0ZXN0aW5nIGRvbmUgdGhpcyB3ZWVrLg0KDQpUaGVyZSdzIGEgZmFy
IHNpbXBsZXIgcGF0Y2ggd2l0aCBmZXdlciBzaWRlIGVmZmVjdHMuICBJIHN0aWxsIGZhaWwgdG8N
CnNlZSB3aHkgcmV2ZXJ0aW5nIHRoZSBidWcgaW4gPCA0LjIxIGFuZCBkb2luZyBhIHByb3BlciBz
ZXJpZXMgaW4gNC4yMQ0KaXMgc28gYmFkLCB2cyBrZWVwaW5nIDwgNC4yMSBicm9rZW4gYW5kIGRv
aW5nIGEgcHJvcGVyIHNlcmllcyBpbiA0LjIxLg0KDQpJIHRoaW5rIHRoaXMgc2VyaWVzIGhhcyBm
bGF3cy4NCg0KMS4gSXQgZG9lc24ndCBhZGRyZXNzIHRoZSBrZXlzdG9uZSBwbGF0Zm9ybSBhcHBh
cmVudGx5IGRpc2FibGluZyB0aGUNCmludGVycnVwdCBpbiB3aGF0IHNob3VsZCBiZSBhIG1hc2su
ICBKdXN0IHJ1bm5pbmcgdGhlIGF0aDEwayBkcml2ZXINCndpbGwgbm90IHNob3cgdGhpcy4gIEl0
IHdpbGwgcmVxdWlyZSBzb21ldGhpbmcgdG8gYWN0dWFsbHkgbWFzayB0aGUNCmludGVycnVwdCBh
dCB0aGUgZHdjIG1zaSBsYXllciBhbmQgb2JzZXJ2ZSB0aGF0IGFuIE1TSSB0aGF0IGFycml2ZXMN
CndoaWxlIG1hc2tlZCBpcyBsb3N0IG9uIHVubWFzay4gIEFuZCBvbmx5IGtleXN0b25lIGhhcyBh
IHBsYXRmb3JtDQptZXRob2Qgd2hpY2ggZG9lcyB0aGlzLg0KDQoyLiBJdCBlbmFibGVzIGFsbCBN
U0lzIG9uIHN0YXJ0dXAuICBUaGlzIHdpbGwgY2hhbmdlIHRoZSBiZWhhdmlvciBpZg0Kc29tZXRo
aW5nIGdlbmVyYXRlcyBhIE1TSSB3aGljaCBoYXMgbm90IGJlZW4gZW5hYmxlZC4gIFRoYXQgd291
bGQgbm90DQpiZSBub3JtYWwsIGJ1dCBwb3NzaWJseSBhbiBlZGdlIGNhc2Ugd2l0aCBjZXJ0YWlu
IGhhcmR3YXJlIGNvbWluZyBvdXQNCm9mIGFuIHNvZnQtcmVzZXQgb3IgcG93ZXIgc2F2ZS4gIEp1
c3QgcnVubmluZyB0aGUgYXRoMTBrIGRyaXZlciBpcyBub3QNCmdvaW5nIHRvIHRlc3QgdGhpcyBh
dCBhbGwuDQoNCjMuIEkgYW0gdW5jb252aW5jZWQgdGhlIG5ldyBsb2NrIGluIHRoZSBpcnEgYWNr
IGZhc3QgcGF0aCBkb2VzIGFueXRoaW5nDQpvdGhlciB0aGFuIGFkZCBhZGRpdGlvbmFsIGlycSBs
YXRlbmN5Lg0K
