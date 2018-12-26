Return-Path: <SRS0=zpRJ=PD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D61AC43387
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 19:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E668B214D8
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 19:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="pcvuZwoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeLZTpv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:45:51 -0500
Received: from mail-eopbgr820138.outbound.protection.outlook.com ([40.107.82.138]:50461
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbeLZTpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Dec 2018 14:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug5ndkpkhhUCDSt/gN9KmVoybbEQhZ4UMKvv6mKeCjA=;
 b=pcvuZwoQVaaWqmaOVhNg0kDwY7n1xAEb5lLa99EOl7wqQHZh/gBmBUmwhWKgseH7ieACXHHc6rgs5y+V7cFnCHTWmpX45+TC4OJce2I+Wba3XhZZTYH8aFhO+UulPRC7feD3dEzQ9nacu6+VVvAttpPxyYo4LeCzzD6IQduqz+c=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3723.namprd06.prod.outlook.com (10.167.236.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 26 Dec 2018 19:45:47 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd%7]) with mapi id 15.20.1471.019; Wed, 26 Dec 2018
 19:45:47 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "TheSven73@googlemail.com" <TheSven73@googlemail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUmOZXutAsHiyvt06v7QdQeB+h1KWRdWMA
Date:   Wed, 26 Dec 2018 19:45:47 +0000
Message-ID: <1545853546.7501.10.camel@impinj.com>
References: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3723;6:w1sCqZFwsDsnJ1RCP90JgzWYIqMicwW0stKM4lby+qSHSKvzkiL/Neb0r3fNpqXWXZRSVo/9xOF597T9QGvozH9lZo+Oh09TV0CXId019R/eHyR+l1IhEKlFf7ai2GRf9jvSmkIcE0JWOCvRlsZv3seleFB0G50eCVzVK4OgCV/m/39E5UUcZbF09V+/sB9wfaagEFH2QzYxwS+R1ycB1Pbnm1JqcoixxZXOi1nrWT6ohuCy9oFYdVp+qK1sDZk+YP5nKG/qRvCFx3MhR34GDOgeKgCHcRuJGur3UsOfE4S+qMk4yEd0ee5BQN9jXVN+l6+7Z2gpfgdfN4D8xi9E0KhF8WYBLZpbJQlvUQenBAEmR8/PSm7A0EZAZDSIzzVq1ZcAdu14fuS+E9V9L01xzQQWsyi5WMWv4y3xaUBz0ltVs2Zxog2QTLFd/jVl4leAnLnWurv7w9fhom/IjCP0Uw==;5:o6W2gT8nsC7FKOdOokGjbecj7wUftZObY9XXokfvHmOMxA0l3SlSAf+W1mbvA9CAgS2U+T0bJxba5t0yD5JxLLrfBioaKQH9fpzcjDp0JzQR4+ecwMAjkBxtRHGPUyO+ksn1lAFaNT7MfI5ptdUmULdOdUtRsyTJIk0tr/yGWd0=;7:HjBtMIJIyHbgrT3r3IVvJZEI9lM9Gc6cFhDrZPsa9ZQX31zSnFZTTc/VEntt7G7UtX0P9oa79Y66wQJZxCqmej4PbUPCjyJ6k7zKeM4SinStxbL/LOWqSCK1n67xJy/j6ztoMnze1Z+UQbNWtSgncA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 204c7f3d-c64b-4ebf-47a2-08d66b6abb6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3723;
x-ms-traffictypediagnostic: MWHPR0601MB3723:
x-microsoft-antispam-prvs: <MWHPR0601MB372347DE702A693FF2850AB1D3B50@MWHPR0601MB3723.namprd06.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3723;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3723;
x-forefront-prvs: 0898A6E028
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39840400004)(136003)(189003)(199004)(229853002)(6436002)(6486002)(14454004)(71200400001)(71190400001)(478600001)(5660300001)(25786009)(2501003)(97736004)(316002)(4001150100001)(103116003)(36756003)(54906003)(2906002)(68736007)(110136005)(106356001)(105586002)(66066001)(6116002)(3846002)(4326008)(53936002)(305945005)(26005)(99286004)(6506007)(2201001)(102836004)(76176011)(39060400002)(446003)(81156014)(81166006)(186003)(86362001)(486006)(7736002)(11346002)(476003)(6246003)(8936002)(2616005)(14444005)(8676002)(256004)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3723;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IQj2r1nOdy3x2RanTgdJXzakp8M3y6K1iEaUXMpK0tSgxMd/EnceUeesmGcb+ajuIkn/jB522eG3e/gup9BeQEpP5xka3exRHYHf9fCLeLobNEjnmR8IdYu3Loy+wCo098nZajiOKsl1ADg3ftT4mgxutUODHD1jkwJukVq/HLP0U0fDkEoU7I89Zr+1ZtijL/syEjXZyBBEjrSu2vbRTuwZqUdKM2FKT8XDijHlVf3uDYhF+1zpHCnTidMRa5YJJGpTt6osXxzjBV7GvIL70JCyOPuOZwB4tu6tolrOHWVYVVTYA7Cv4EM9ILhUboTa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7F13E18FCF7F94FBBF8E40D22AA66A1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204c7f3d-c64b-4ebf-47a2-08d66b6abb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2018 19:45:47.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3723
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE4LTEyLTIxIGF0IDA0OjMzICswMDAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4g
VGhlIE1TSSBFbmFibGUgYml0IGluIHRoZSBNU0kgQ2FwYWJpbGl0eSAoUENJZSByNC4wLCBzZWMg
Ny43LjEuMikNCj4gY29udHJvbHMgd2hldGhlciBhIEZ1bmN0aW9uIGNhbiByZXF1ZXN0IHNlcnZp
Y2UgdXNpbmcgTVNJLg0KPiANCj4gaS5NWDYgUm9vdCBQb3J0cyBpbXBsZW1lbnQgdGhlIE1TSSBD
YXBhYmlsaXR5IGFuZCBtYXkgdXNlIE1TSSB0bw0KPiByZXF1ZXN0IHNlcnZpY2UgZm9yIGV2ZW50
cyBsaWtlIFBNRSwgaG90cGx1ZywgQUVSLCBldGMuICBJbg0KPiBhZGRpdGlvbiwgb24gaS5NWDYs
IHRoZSBNU0kgRW5hYmxlIGJpdCBjb250cm9scyBkZWxpdmVyeSBvZiBNU0kNCj4gaW50ZXJydXB0
cyBmcm9tIGNvbXBvbmVudHMgYmVsb3cgdGhlIFJvb3QgUG9ydC4NCj4gDQo+IFByaW9yIHRvIGNv
bW1pdCBmM2ZkZmM0YWMzYTIgKCJQQ0k6IFJlbW92ZSBob3N0IGRyaXZlciBLY29uZmlnDQo+IHNl
bGVjdGlvbg0KPiBvZiBDT05GSUdfUENJRVBPUlRCVVMiKSwgZW5hYmxpbmcgQ09ORklHX1BDSV9J
TVg2IGF1dG9tYXRpY2FsbHkgYWxzbw0KPiBlbmFibGVkIENPTkZJR19QQ0lFUE9SVEJVUywgYW5k
IHdoZW4gcG9ydGRydiBjbGFpbWVkIHRoZSBSb290IFBvcnRzLA0KPiBpdCBzZXQgdGhlIE1TSSBF
bmFibGUgYml0IHNvIGl0IGNvdWxkIHVzZSBQTUUsIGhvdHBsdWcsIEFFUiwgZXRjLg0KPiBBcyBh
IHNpZGUgZWZmZWN0LCB0aGF0IGFsc28gZW5hYmxlZCBkZWxpdmVyeSBvZiBNU0kgaW50ZXJydXB0
cyBmcm9tDQo+IGRvd25zdHJlYW0gY29tcG9uZW50cy4NCj4gDQo+IEFmdGVyIGYzZmRmYzRhYzNh
MiwgdGhlIGlteDZxLXBjaWUgZHJpdmVyIGNhbiBvcGVyYXRlIHdpdGhvdXQNCj4gcG9ydGRydiwg
YnV0IHRoYXQgbWVhbnMgaW14NnEtcGNpZSBtdXN0IHNldCB0aGUgTVNJIEVuYWJsZSBiaXQNCj4g
aXRzZWxmIGlmIGRvd25zdHJlYW0gY29tcG9uZW50cyB1c2UgTVNJLg0KPiANCj4gRml4ZXM6IGYz
ZmRmYzRhYzNhMiAoIlBDSTogUmVtb3ZlIGhvc3QgZHJpdmVyIEtjb25maWcgc2VsZWN0aW9uIG9m
DQo+IENPTkZJR19QQ0lFUE9SVEJVUyIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpo
dSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5z
dGFjaEBwZW5ndXRyb25peC5kZT4NCj4gVGVzdGVkLWJ5OiBTdmVuIFZhbiBBc2Jyb2VjayA8VGhl
U3ZlbjczQGdvb2dsZW1haWwuY29tPg0KPiBBY2tlZC1ieTogTG9yZW56byBQaWVyYWxpc2kgPGxv
cmVuem8ucGllcmFsaXNpQGFybS5jb20+DQoNClRlc3RlZCBvbiBJTVg3ZCwgYWxsb3dzIE1TSSB0
byB3b3JrIHdpdGhvdXQgZW5hYmxpbmcgUENJRVBPUlRCVVMsIHdoaWNoDQpmYWlscyB3aXRob3V0
IHRoaXMgcGF0Y2guDQo=
