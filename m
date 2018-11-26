Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A39EC43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9D020862
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="Fg1XKATU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9D020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeK0DBa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:01:30 -0500
Received: from mail-eopbgr810122.outbound.protection.outlook.com ([40.107.81.122]:29326
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbeK0DBa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Nov 2018 22:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WhetD+ZFQ0Z9ypT61pxJVy/q9ykcBG2vohHxt6pBX0=;
 b=Fg1XKATUSx9AAxIxIXZUvU0ZcdS2/74PuElRT7PISQzooaFjfBeZfRJTIBz6FxEMBi3vLFWuUT4VttR9za9Ic6gjc7UxA7Y1uvelJ4+HwOLaaqnKKJrwFzA6F3CTI0b7poH6iRBaEYSCfPUiJtqmuzKEyDvhNXwJYAzIGgLmejc=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3732.namprd06.prod.outlook.com (52.132.101.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Mon, 26 Nov 2018 16:06:55 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 16:06:55 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@google.com" <helgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICADLahgIAASXEAgAADZ4CABkBzgA==
Date:   Mon, 26 Nov 2018 16:06:54 +0000
Message-ID: <1543248401.18519.24.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
         <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
         <20181122162616.GA17826@e107981-ln.cambridge.arm.com>
         <1d83d4e5-3cfc-3fc4-f875-c25b5ae3284f@arm.com>
In-Reply-To: <1d83d4e5-3cfc-3fc4-f875-c25b5ae3284f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3732;6:kBgJulegnb4ENKrkX4HIbDy4rXoH6EPl1N4vFcF+qprf/x8XhJBOch8bf0YeaWtvc325Nm+f5oWYwGq6dHLtqHqf3+uIh+aPWZbuttCh3FZf4PiiJTaSqJJHHnrH48iM5yow/vnExUC4W4jxKl93ZymoKeSFGWl6ywzFLHzGhGybgaTEdzIdkih4Hgg14TdYgFWjgfQAvvBX+Udc5Pm8YxW140LSvcrRdwwzkg7Crw61Aw51i4jm7NsBKKrq5bZ+Ij6xu2G5uNCJ3HaXZDeQtPcK8Ix9lSrZ0cNV3Fi73o5FYjgdCjchiKSkIoSp1iCIRswiqAyBtkRV9jvsFmNUt/Gxv6PjDTtb7Qb5/kflkBXe8mXNoBwgAKFqyb2ls1Wo2jtpUPEH8674yc4h+XNTs9xLAUwJVrhj+yD1nBrvU24ZRJ870hhrsxu6CujEUQzLJFi1LkEDBSXtKQoZzcJhCA==;5:d2tfLRn6KPLqP7z2IleNzJ99Nh0U5eR8WM8RUF4SGYX4cNfcI8k1hgBi6XoutuS2T82dOTZkI8Otm6WadIkO3T61FszKfq+7h6+Ql22z6JNzCIcBEPsC8pAU3VZFQ5dT2HlZj9zG46gST3xzwBmlkluFy2znFCxAJ4gWcON3SCc=;7:ygyH/hkBBq9kRZfnxkKYpzxUlt5bB+EDTBWR193tZi4tZkZCTjTzO+4jh14d6lc0W1gro40bZjd/VXqg/TO51DsTI3TIsXPzTYGJc8JWAdQjXwZgYJ+y0/ZKft2wXd1WzK5l4HN/TLRC5bEB8uJFsA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 80679ec0-4268-4ee2-1dd7-08d653b92fb2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3732;
x-ms-traffictypediagnostic: CY4PR0601MB3732:
x-microsoft-antispam-prvs: <CY4PR0601MB37327EAC74A01B1464DBE565D3D70@CY4PR0601MB3732.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3732;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3732;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39840400004)(136003)(396003)(366004)(189003)(199004)(97736004)(93886005)(66066001)(102836004)(229853002)(316002)(6506007)(54906003)(110136005)(6436002)(25786009)(36756003)(71200400001)(39060400002)(14454004)(305945005)(76176011)(99286004)(5660300001)(71190400001)(256004)(86362001)(7736002)(26005)(53936002)(106356001)(186003)(6486002)(478600001)(103116003)(2906002)(4326008)(4001150100001)(105586002)(3846002)(6246003)(2616005)(8676002)(81166006)(2501003)(81156014)(6116002)(6512007)(8936002)(476003)(2201001)(68736007)(11346002)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3732;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TKK+8uBXpMWVv4o4TOPhDtTSkk7HTD4Qn4/59IN4oa99l8O/AroAkkUatYSPfXbwjupCxxwxiNDwkMamhMoxD+NcT6Bkbh28rhWhqxGR1KJBqQRXEtEFmZQyZgB0d+slm4NpyKCqUbU1md8EPD5tlzCOt+wzgiT25u4QzFMGp4csvgmINjvGYrmArKl467DFFtbPPhl0aoLsWF3T8ICpU0DiG8KnAddR76ogqPbpa+elvIKVXe+55fS4UCrajMUpAOUgu0LtkLLOKO6nQiUEPurbTGpNhqte3mZHbImj2FCMZnH7F5cYYhO+hWijCj1fEETRoTntfbtexrQsVTPN7WdS+h2DG6F41XSlK8mrizc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6622DC79B36E6749A47D36B03E8DD66C@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80679ec0-4268-4ee2-1dd7-08d653b92fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 16:06:55.1579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3732
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTIyIGF0IDE2OjM4ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IA0KPiBUbyBhZGQgdG8gTG9yZW56bydzIGNvbW1lbnQsIHdlJ3JlIHRyeWluZyBoYXJkIHRvIGhh
dmUgYSAqbWluaW1hbCogZml4DQo+IHRoYXQgY2FuIGJlIGVhc2lseSBiYWNrcG9ydGVkLiBDaGFu
Z2luZyB2YXJpYWJsZSBhbmQgZmllbGQgbmFtZXMgYXMgd2VsbA0KPiBhcyBmbGlwcGluZyB0aGUg
c2VtYW50aWMgb2Ygb3RoZXIgYml0cyBvZiB0aGUgZHJpdmVyIG1ha2VzIGl0IGhhcmRlciB0bw0K
PiByZXZpZXcsIGFuZCBjZXJ0YWlubHkgZG9lc24ndCBoZWxwIGdldHRpbmcgdGhpbmdzIGJhY2tw
b3J0ZWQgdG8gc3RhYmxlDQo+IChzZWUgdGhlIHN0YWJsZSBrZXJuZWwgcnVsZXMpLg0KPiANCj4g
SSdkIHN1Z2dlc3QgdGhpcyBraW5kIG9mIHJlcGFpbnRpbmcgaXMgYmV0dGVyIGtlcHQgYXMgYSBz
ZXBhcmF0ZSBwYXRjaA0KPiBhbmQgbWVyZ2VkIHNlcGFyYXRlbHkuDQoNCklmIHlvdSB3YW50IGEg
bWluaW1hbCBmaXggdG8gYmFja3BvcnQsIHlvdSBzaG91bGQganVzdCB1c2UgbXkgb3JpZ2luYWwN
CnBhdGNoIGZvciA0LjE1LTQuMTkgc3RhYmxlIHNlcmllcy4gIEl0J3MgYSBvbmUgbGluZSBjaGFu
Z2UgdG8gZml4IHRoZQ0KcmVhbCBidWcuDQoNCkl0J2xsIGJlIGZhciBlYXNpZXIgdG8gYmFja3Bv
cnQgdG8gPCA0LjE3LCAgd2hlcmUgdGhlIGhpZXJhcmNoaWNhbCBpcnENCmRvbWFpbiBzdHVmZiB3
YXNuJ3QgdXNlZCBpbiB0aGlzIHBhcnQgb2YgdGhlIGRyaXZlci4NCg0KSWYgeW91IGZvbGxvdyB0
aGUgY29udHJvbCBmbG93IG9mIGFuIGlycSwgeW91J2xsIHNlZSB0aGF0IGl0IEFDS3MgdGhlDQpp
cnEgYXQgdGhlIHNhbWUgcG9pbnQgYXMgcHV0dGluZyB0aGUgYWNrIGluIGEgbmV3IGlycV9hY2sg
bWV0aG9kIGRvZXMuDQoNCldoaWxlIHRoZSBkcml2ZXIgc2hvdWxkbid0IGVuYWJsZSBvciBkaXNh
YmxlIG9uIG1hc2ssIHRoYXQncyBhbHNvIGEgbmV3DQpidWcgZnJvbSA0LjE3IHRoYXQgZG9lc24n
dCBuZWVkIHRvIGJlIGZpeGVkIGluIGVhcmxpZXIgdmVyc2lvbnMuDQoNCkl0J3MgdW5saWtlbHkg
dG8gY29tZSB1cCwgaW4gNC4xNyssIHNpbmNlIHRoZSBtYXNrIG1ldGhvZHMgZG9uJ3QgZ2V0DQp1
c2VkIGluIG5vcm1hbCBpcnEgZmxvdy4gIFN0aWxsIGEgYnVnLg==
