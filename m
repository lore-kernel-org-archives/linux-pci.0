Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4114C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7324620851
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="LR46wcTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7324620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeKTLdA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:33:00 -0500
Received: from mail-eopbgr760117.outbound.protection.outlook.com ([40.107.76.117]:52928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeKTLdA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 06:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxrHdg68JH/gFla3Ku/TLiDm3GiA8YRmpj0OLgbDNPE=;
 b=LR46wcTKOa1k2uQ24dqK4zSEzoy4dylJSEqFlPWPvqMEBhL8/Xm9Sm8rhIRhofAeP4ZcYJtcELgJGHrzJvGnPFFTaFaSEjPFk0mdtsUSvQXYVhDf8fZjeqVB8b2zlcnNElLi9w19A//fmjszMqoa5LxQfhPGxOnCODS1AOBBxtk=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3761.namprd06.prod.outlook.com (52.132.101.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 20 Nov 2018 01:06:24 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%5]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 01:06:24 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUf+wekJAOTeBt1UC5el66NNl6l6VX2qmA
Date:   Tue, 20 Nov 2018 01:06:24 +0000
Message-ID: <1542675983.30311.575.camel@impinj.com>
References: <20181119094144.4127-1-stefan@agner.ch>
         <20181119094144.4127-2-stefan@agner.ch>
In-Reply-To: <20181119094144.4127-2-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3761;6:nQ8mKw9xmrfuff9bghl2epu2E7j6EQwz45HDEFzv/DBuKhG6jGKp+38fKfJGqA4yPKlleS4iDc43ZvPKQl96Xy9Gn7O4CoXq27U+GCCdvqYo9dg3IkZX/0TahkC4pO8Ki8CcK0JMGBmrj8taQH0AwkJY5rKzkp6uKgh96HW0EQ9broPqFoUCSn9O9maQizOXRalj9w2R5XYMm8ptBkwhIlBJscOcGaDXb39UKKKA25K8IubJaX1eu/AQr9/KRhXEBMQj08Zs8bBD7146k/dE8Hzx0bM7kRtCiAK/S9v8HoDYdTuHr2gS753DT72xa5vOtUVSR1h3Nv8zRGv7X33tTWDTgIiPwCoOU3YaR7gFLKvMfVt0ufGZ0iql4PYUrUsBjQaj/F2WD6pHIToyjrUSiiFjHnAE647QT74qg1hea+9grJKdZnC83aXa6hUj7YjHgfYPG8trP1z4dqjaSM7uwA==;5:FO35Z4TH4gGuA4SiFZ5//wFp1reuTRfPEgiqg8MGU2D8zZYuwm0N6+cbC4R8MuuiZMcCM2OaMqGC5sFI/ErvwGSLCLCLzaQPD+o6FEWjXgmS0MeTO06qtq0JiCLdGyfebEMd+zJsp4NIrd/RoioOjinW56dbUwo39Wt+Vi1XBek=;7:GQzMSI9XLjeLyO9OAcq27XHk95Xf0MI3Wv1LcR2GnNPLXxgIq0iwAWFGxmBi1xnSSbkiImUatIOoaTBnqSaxSL4IJ89A2PB7HWgTta5XxWf77ijKLSItEQ6vAr5d4857vjuZLT+OPNLP6LmK4wpyZw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5afa3d2c-59a8-463c-a93a-08d64e846460
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3761;
x-ms-traffictypediagnostic: CY4PR0601MB3761:
x-microsoft-antispam-prvs: <CY4PR0601MB3761ED40FB73EA3AEDAC5515D3D90@CY4PR0601MB3761.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3761;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3761;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(4001150100001)(2906002)(6486002)(86362001)(66066001)(14444005)(26005)(6512007)(14454004)(6436002)(256004)(71190400001)(71200400001)(478600001)(3846002)(4326008)(6116002)(305945005)(7736002)(25786009)(97736004)(53936002)(229853002)(8676002)(81166006)(81156014)(6246003)(39060400002)(5660300001)(8936002)(6506007)(106356001)(105586002)(446003)(110136005)(54906003)(76176011)(186003)(68736007)(11346002)(103116003)(486006)(2900100001)(2501003)(102836004)(2201001)(2616005)(476003)(36756003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3761;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CPrjJtZe6AZ5W2XhYPeGZ1/c/2y539l/ZqnZ9cuUA3WtCWzy4jjoa/cyWmmBU7yGxF/CUx8hcZukxSXnB2Y86NEBvTv0qvcHDPfx4WSjKSJr/EDvsBB02A88YZF+2uV2CWrlz4zhpEobH82AxHLsLowP27vTDb8q/fnP8V17m9PLuUGsr7C/fV4/5yHZ/I3MP+DiR21vI/XOMZnzVwXijy5Y8DVs8+Ku/Ci6O3aVf8KO6xR0NBy7n/nAq8orn3OAmoeKC21yzaXJR7xahOQZpGRC+odo2nXoJnvZ9Hw6c1wmJx/FsJzFqugsqOuLVmsjCtAWcF/CZJtVb88kl8qxGB0zEwbzSq1EC6e+KNYKHUo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <10657E00CA3329488BC27AD7640EC32F@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afa3d2c-59a8-463c-a93a-08d64e846460
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 01:06:24.5116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3761
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDEwOjQxICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzLiBUaGlzIG1ha2VzIHN1cmUg
dGhhdA0KPiB0aGUga2VybmVsIGRvZXMgbm90IGFjY2VzcyByZWdpc3RlcnMgYmV5b25kIHRoYXQg
cG9pbnQsIGF2b2lkaW5nDQo+IHRoZSBmb2xsb3dpbmcgYWJvcnQgb24gYSBpLk1YIDZRdWFkOg0K
PiAgICMgY2F0DQo+IC9zeXMvZGV2aWNlcy9zb2MwL3NvYy8xZmZjMDAwLnBjaWUvcGNpMDAwMFw6
MDAvMDAwMFw6MDBcOjAwLjAvY29uZmlnDQo+ICAgWyAgMTAwLjAyMTQzM10gVW5oYW5kbGVkIGZh
dWx0OiBpbXByZWNpc2UgZXh0ZXJuYWwgYWJvcnQgKDB4MTQwNikNCj4gYXQgMHhiNmVhNzAwMA0K
PiAgIC4uLg0KPiAgIFsgIDEwMC4wNTY0MjNdIFBDIGlzIGF0IGR3X3BjaWVfcmVhZCsweDUwLzB4
ODQNCj4gICBbICAxMDAuMDYwNzkwXSBMUiBpcyBhdCBkd19wY2llX3JkX293bl9jb25mKzB4NDQv
MHg0OA0KPiAgIC4uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEFnbmVyIDxzdGVmYW5A
YWduZXIuY2g+DQoNCkFmdGVyIHVwZGF0aW5nIHRoaXMgZm9yIHY0LjIwLXJjMiwgdGVzdGVkIG9u
IElNWCA3ZCwgY29uZmlnIHNwYWNlDQphY2Nlc3Mgd29ya3MgYXMgYmVmb3JlLg0KDQpUZXN0ZWQt
Ynk6IFRyZW50IFBpZXBobyA8dHBpZXBob0BpbXBpbmouY29tPg0KDQo=
