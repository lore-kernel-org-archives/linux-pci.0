Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1AC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 19:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D47B20857
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="aOoFaadV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfCATgc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:36:32 -0500
Received: from mail-eopbgr770127.outbound.protection.outlook.com ([40.107.77.127]:4038
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfCATgb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 14:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQSiZuUQaqt1hcJOWJeHbANtu9sRrSssvD6Vd08g1HU=;
 b=aOoFaadVL7pf8bWi6BppsR0nxRY/ZQpx+Bc5S285Kty3DG2ySO56n4cc6xSW5tqn8Yqp9HVDvfsAezW7gdIPx/8+Oqm3WapKukTK/Vu3EfaGxLS2yN+CUyWIiw1eYvqtQDuT7ztZtjSDX3l8vXULr42SaUx52rHp5iwHfk/W98Y=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3739.namprd06.prod.outlook.com (10.167.236.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 19:36:25 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::91d4:ba4b:1424:9452]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::91d4:ba4b:1424:9452%2]) with mapi id 15.20.1665.017; Fri, 1 Mar 2019
 19:36:25 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>
Subject: Re: [PATCH] PCI: imx6: Don't request "pci_aux" clock on i.MX7
Thread-Topic: [PATCH] PCI: imx6: Don't request "pci_aux" clock on i.MX7
Thread-Index: AQHU0Ayh2bGjKQJoHk2JSuqg2Tl3uaX3LAIA
Date:   Fri, 1 Mar 2019 19:36:25 +0000
Message-ID: <1551468984.6059.10.camel@impinj.com>
References: <20190301085559.18736-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190301085559.18736-1-andrew.smirnov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7f666f8-a8b6-44e1-fa26-08d69e7d313b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3739;
x-ms-traffictypediagnostic: MWHPR0601MB3739:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3739;20:XOzVL3TGeQIQdpG1k2QzFN81tAPy5cF1nCkaRkZqbSurvBD5wUEeri+JWjT9bb1D/JOYBK3Z0JVYTOmwbqTRYBxthP+SE0FaAQX8W4EAIRTUzMyUzW+CrIOR/LWw4Wn0SJUaA53BNKb/yxZGLiprHFcZTkFEGdyXbEJTb5GazL8=
x-microsoft-antispam-prvs: <MWHPR0601MB3739F1EB8AEB70A56459BB97D3760@MWHPR0601MB3739.namprd06.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(136003)(39850400004)(189003)(199004)(14454004)(11346002)(54906003)(478600001)(446003)(97736004)(8676002)(76176011)(81156014)(4326008)(68736007)(110136005)(106356001)(6486002)(7736002)(305945005)(6116002)(3846002)(81166006)(14444005)(6436002)(26005)(256004)(105586002)(8936002)(103116003)(186003)(99286004)(6512007)(66066001)(2501003)(6506007)(229853002)(36756003)(53936002)(5660300002)(4744005)(6246003)(71200400001)(25786009)(2616005)(71190400001)(86362001)(2906002)(486006)(102836004)(476003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3739;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I0QLzaefneLX3sTJNAj8mDr642vvIxcMIR27s32MvBltIfDJA1DgQJsFRUzwp0Uj2ZX2YPrYoncmIoR2GRkoSvvEgswlC2jrrloPWMz9769+uLpDpmxQYehmZTJJQAQmNm4ILXbIoCps8CeSpMOQEF/xyGACAGCsbsO+j1toxuCXgXf7fjRne2Zb8B25GoUcI+cEYW8QKWFodjOF4Ln1ETR+sxrMCVXBG9utFBjGnoV+NdG5m66rOh8KGJSO9cUyCa1hnLqBKNUvTGHswriEOPKEUukHEdbyk0mVTRC9wXLrvLw4zgxFzTNJgeCdBLsWee/vKfTaKQ5oM+jfAoZOqoqbRYYy7P6R8TqZjzQnOVhRDLnvClUeIEeQkJx7GW0gESwWJm00rfZSKwnf0URnigLNl7k4YF97JuA8cyjSxBM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6020E79C9031DE4B9390ACA2A2E25960@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f666f8-a8b6-44e1-fa26-08d69e7d313b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 19:36:25.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3739
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE5LTAzLTAxIGF0IDAwOjU1IC0wODAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gVGhlIGNsb2NrIGluIHF1ZXN0aW9uIGlzIG5vdCBwcmVzZW50IG9uIGkuTVg3LCBzbyBtb3Zl
IHRoZSBjb2RlDQo+IHJlcXVlc3RpbmcgaXQgaW50byBpLk1YOE1RLW9ubHkgcGF0aC4NCj4gDQo+
IEZpeGVzOiBlZWI2MWM0ZTg1MzAgKCJQQ0k6IGlteDY6IEFkZCBjb2RlIHRvIHJlcXVlc3QvY29u
dHJvbA0KPiAicGNpZV9hdXgiIGNsb2NrIGZvciBpLk1YOE1RIikNCj4gUmVwb3J0ZWQtYnk6IFRy
ZW50IFBpZXBobyA8dHBpZXBob0BpbXBpbmouY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
U21pcm5vdiA8YW5kcmV3LnNtaXJub3ZAZ21haWwuY29tPg0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8
YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gQ2M6IENocmlzIEhlYWx5IDxjcGhlYWx5QGdtYWlsLmNv
bT4NCj4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogVHJl
bnQgUGllcGhvIDx0cGllcGhvQGltcGluai5jb20+DQo+IENjOiBsaW51eC1pbXhAbnhwLmNvbQ0K
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZw0KDQpUZXN0ZWQgb24gbGludXgtbmV4dCwgaW14N2QgUENJLWUgYXBwZWFycyB0
byBiZSB3b3JraW5nIGZpbmUgbm93Lg0KDQpJdCdzIHRvbyBiYWQgZ2l0IGRpZmYgY2FuJ3QgcmVw
b3J0IHRoZSBjYXNlIGxhYmVsKHMpIGNvZGUgZmFsbHMgdW5kZXINCnRoZSBzYW1lIHdheSBpdCBj
YW4gKHVzdWFsbHkpIGdldCB0aGUgZnVuY3Rpb24gbmFtZS4gIEkgc2F3IHRoZQ0Kb3JpZ2luYWwg
Y29tbWl0IHdoZW4gaXQgd2FzIHBvc3RlZCBhbmQgZGlkbid0IG5vdGljZSBhbnl0aGluZyBteXNl
bGYNCmVpdGhlci4=
