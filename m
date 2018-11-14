Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E17C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5267B214F1
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="ZHZZqqcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5267B214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbeKOFF6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:05:58 -0500
Received: from mail-eopbgr700116.outbound.protection.outlook.com ([40.107.70.116]:22934
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeKOFF5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 00:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+Qzl3cSmz+rLN3XOjsUXBIgRV56mWDj645JP8nfi4c=;
 b=ZHZZqqcVDz3qaG15QCQntaoLgD42YuVSeIMNfJkiHVXxhItedfrx/EbiWQo2TnVLEXsqWCj76klRKNeNIdps5nWLRd+QcBh0QdHjYmd1tT40BushVeSRAwxef3jHwhOja8zjF1Nj6/aJYWhnnkBMqTpfML60KdwqiykxYPQFCBk=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3689.namprd06.prod.outlook.com (10.167.236.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 14 Nov 2018 19:01:30 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 19:01:30 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@google.com" <helgaas@google.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH 3/3] PCI: designware: Move interrupt acking into the
 proper callback
Thread-Topic: [PATCH 3/3] PCI: designware: Move interrupt acking into the
 proper callback
Thread-Index: AQHUe6RNprPTewfMeU2ZLN8O0EAvUKVPoZ2A
Date:   Wed, 14 Nov 2018 19:01:30 +0000
Message-ID: <1542222089.30311.456.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <20181113225734.8026-4-marc.zyngier@arm.com>
In-Reply-To: <20181113225734.8026-4-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3689;6:EZ1iFJRu+27ELnfI7rhw/rBINjSqn/JdiO89h9ymx71ewmOePAnWD9WoIkndEfqLIw22H9PZPXRWyud5Gw+PrHcZSmqpNyYWtQv/JwF2B4MHfMdssbYlQ9Qet4yOf7XCZBmO8CZUJ4jJwKq2JOTREAH/4q3ED61+lWHrPNt9zmDn4paLP3Iu8KqEtH46CyOJK5omM+FzDhb+Eo9g7jwG+N8mpxW8jkv/iFX2sD5W8iHuZPi1NajOOWu5t9to3wdOQZyUf9G7Ur9ZB2eNsgI2ebIeJXiu/fyXcsWt3iYPJ8uNSE01bnxUFJ2J3rsLkngldtP2ZqjPxYMnjeoh/gN64wRODGVOxX7jmlMD8Oyz1WzwLqbXZSmzbRfDlk4CzjUSTqYELowCxSPMiik8hkVCaaYBoC8OWT45XGwKmDxAZo9Qlgm9r9Ne0aBmuYRr+zPpc9zn04ACAv3siJjV6i9kRg==;5:iugRAgxE345CJ+h+eQj+OrlywenTJApZG6swNQIHueAJBqIag2l370NJLn6vZKIS0oMajgZufu9UXL4qJN4vauH00rWvyq/Y1ooAw+pm3zULOInuiQmnTmnYHSMoFKhwnyLhQag90Z57s144ultxU+vohcMF7BvE0TxPbPjS5FA=;7:+EbTeJxMD1d9xFZ6XQpiT1+mZpW99xryYMI1687ujRxxdNttSR2nL/fn0G20dAhE90Er0/avTkEjPpALBsNTcGqAKQ1PdVXIYQeI7v6B6o6Uz1KjD6CddmCSehKjBc0wfgF61qO+mFlBChhj82mC8A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5c205cf8-e45e-4d34-2050-08d64a63962f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3689;
x-ms-traffictypediagnostic: MWHPR0601MB3689:
x-microsoft-antispam-prvs: <MWHPR0601MB368956624C4ECD8E14D3D895D3C30@MWHPR0601MB3689.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3689;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3689;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39850400004)(396003)(366004)(346002)(199004)(189003)(25786009)(110136005)(54906003)(316002)(103116003)(6246003)(8676002)(81166006)(81156014)(4326008)(97736004)(36756003)(305945005)(5660300001)(7736002)(66066001)(71190400001)(71200400001)(6116002)(186003)(2906002)(2201001)(256004)(14444005)(53936002)(3846002)(6512007)(86362001)(39060400002)(6436002)(106356001)(4001150100001)(476003)(105586002)(486006)(102836004)(76176011)(14454004)(229853002)(11346002)(2616005)(8936002)(478600001)(2900100001)(6506007)(6486002)(68736007)(446003)(26005)(2501003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3689;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 16U2QwA7+73L9162jOsF9GkVpJniuP01gctV5lTXAxNrHmHLTSYHd8ntztoIjqjfsOCOkDtjFU6gnMMKpOxfNxYZSK1y081jiFaeH3knh7thsw3OactK1kWdxkZm4c3TQHGkswoHglhKXQu1xqSYA0wsptZ0Jq4jQls7NONPZ2+ImMYxLxkRyHk+RWIwYpQjUd2fvbZiaOj5opmfskByhRDYwuCt7X1Yi7kz00Ssbcf0Rj8CUcVVtHZuthZK2AoO/xJdeuUJJqNEckwyc02nrKyzx/RSbDm6MxdpyZpbNDz4smHYxnt1vG2Yz/SfjzK4I0FhGkEVVcCCFd1QrGCwL9mXj/vhtfZkSY8v7Pu2Nag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEAEDEF38F43394384E0F176B19F6094@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c205cf8-e45e-4d34-2050-08d64a63962f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 19:01:30.0551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3689
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTEzIGF0IDIyOjU3ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IFRoZSB3cml0ZSB0byB0aGUgc3RhdHVzIHJlZ2lzdGVyIGlzIHJlYWxseSBhbiBBQ0sgZm9yIHRo
ZSBIVywNCj4gYW5kIHNob3VsZCBiZSB0cmVhdGVkIGFzIHN1Y2ggYnkgdGhlIGRyaXZlci4gTGV0
J3MgbW92ZSBpdCB0byB0aGUNCj4gaXJxX2FjayBjYWxsYmFjaywgd2hpY2ggd2lsbCBwcmV2ZW50
IHBlb3BsZSBmcm9tIG1vdmluZyBpdCBhcm91bmQNCj4gaW4gb3JkZXIgdG8gcGFwZXIgb3ZlciBv
dGhlciBidWdzLg0KPiANCj4gIA0KPiAgc3RhdGljIHZvaWQgZHdfcGNpX2JvdHRvbV9hY2soc3Ry
dWN0IGlycV9kYXRhICpkKQ0KPiAgew0KPiAtCXN0cnVjdCBtc2lfZGVzYyAqbXNpID0gaXJxX2Rh
dGFfZ2V0X21zaV9kZXNjKGQpOw0KPiAtCXN0cnVjdCBwY2llX3BvcnQgKnBwOw0KPiArCXN0cnVj
dCBwY2llX3BvcnQgKnBwICA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGQpOw0KPiArCXVu
c2lnbmVkIGludCByZXMsIGJpdCwgY3RybDsNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAg
DQo+IC0JcHAgPSBtc2lfZGVzY190b19wY2lfc3lzZGF0YShtc2kpOw0KPiArCWN0cmwgPSBkLT5o
d2lycSAvIE1BWF9NU0lfSVJRU19QRVJfQ1RSTDsNCj4gKwlyZXMgPSBjdHJsICogTVNJX1JFR19D
VFJMX0JMT0NLX1NJWkU7DQo+ICsJYml0ID0gZC0+aHdpcnEgJSBNQVhfTVNJX0lSUVNfUEVSX0NU
Ukw7DQo+ICANCj4gIAlyYXdfc3Bpbl9sb2NrX2lycXNhdmUoJnBwLT5sb2NrLCBmbGFncyk7DQo+
ICANCj4gKwlkd19wY2llX3dyX293bl9jb25mKHBwLCBQQ0lFX01TSV9JTlRSMF9TVEFUVVMgKyBy
ZXMsIDQsIDEgPDwgYml0KTsNCg0KRG9lcyB0aGlzIG5lZWQgdG8gYmUgaW5zaWRlIHRoZSBsb2Nr
PyAgVGhlIHNpbmdsZSB3cml0ZSBzaG91bGQgYWxsb3cNCmZvciBhbiBhdG9taWMgY2xlYXIgd2l0
aG91dCBuZWVkIGZvciBhIGxvY2suDQoNCg0KPiArDQo+ICAJaWYgKHBwLT5vcHMtPm1zaV9pcnFf
YWNrKQ0KPiAgCQlwcC0+b3BzLT5tc2lfaXJxX2FjayhkLT5od2lycSwgcHApOw0KDQpBbmQgY291
bGRuJ3QgdGhlIGxvY2sgYmUgaW5zaWRlIHRoZSBpZiBoZXJlLCBzbyB0aGF0IGl0IGlzIG5ldmVy
IHRha2VuDQppZiB0aGVyZSBpcyBubyBwbGF0Zm9ybSBzcGVjaWZpYyBoYW5kbGVyPw0K
