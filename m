Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7C4C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 01:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F60520874
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 01:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="HFipYgHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLTBW5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:22:57 -0500
Received: from mail-eopbgr740101.outbound.protection.outlook.com ([40.107.74.101]:17011
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbeLTBW5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 20:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHJSiqcMQxG/aqO+mzGu/H2GdnflQqdrCw9YYUtmhFw=;
 b=HFipYgHBluDrDRp0aDk2trS0bQSz6lhgcqz9kqyiMj5bwfTPkm1Oq/NSsVpFVzlai/AovvA+56Maah5te+YUGriQnXS9DAJrk789AiW6s19ooarDO3LxNCp0MhLCED6c6CAITb1iQhawGlCg0Ax1w+uvL/9IgvNwbtCsFRgE3r8=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3721.namprd06.prod.outlook.com (10.167.236.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Thu, 20 Dec 2018 01:22:52 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::24d2:3a2c:20ed:7cfd%6]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 01:22:51 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Topic: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Thread-Index: AQHUloc4EyB/jPStRUyDq4OW+MrDYaWE/zeAgAHO4ICAAAnkgA==
Date:   Thu, 20 Dec 2018 01:22:51 +0000
Message-ID: <1545268969.22930.77.camel@impinj.com>
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
         <20181218040702.29231-4-andrew.smirnov@gmail.com>
         <20181218151533.GA2922@bogus>
         <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
         <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
         <CAHQ1cqEMxxo9JGN5be4XQWAtPz7nC2JyLCr3qasnD5QK7_hOYQ@mail.gmail.com>
In-Reply-To: <CAHQ1cqEMxxo9JGN5be4XQWAtPz7nC2JyLCr3qasnD5QK7_hOYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3721;6:IYShTawWmHrB0u6/5093DDHFrYHjNeuvJV1KQ6hSrZShUSfBw2AfnjXcy+7INdkW+LvSn/U7a548lZZt/lz+fsgpn+1hpEF7J3OvW12wzUfdX9nTb4H2A3b0dffCB6YjBgk23/7Z827U+CZlmOODuXkzA6gLpBhjI2uNsBL9wJeWpOlTdJIvdzhBIoSs4f33jn2NeBPuW1POA3wfM6zzO8F5ejTKgrWqbaXiPIW+FFxRqe7t6IY5h64/x7EoBf2f7Sjv12Mo7n+ul8WBp/QWeNdUvHqvtkGZdM8vvikWBtGiHB9x0WsUF3eTM8wV6C23ayv/xIgWpvGEM7xhiAliYEDf/6UxWdPlkomdpkhl4dYmSideFAD94WRoVWnuEj6nLd4nXAPkkaiBXf9A2SbeLC0IgzrN+MwwAemWhL5JZa5zg+U4jsl9h4IDhclSwgVceabxyzEfnsDLJ8xL0zDnHA==;5:te1VzsV52awN4VjZPU+NV84ebSmzOfCJ69ECoBCJXnoqUtbwvtb8CmJzgDaRfOXqw1wclIwMhTUXCNqNu5kPE1p7OlL34FswrNveGtx9YgypUqSf6ftJXTLi5Hh/5ing3rc2PWHXzxf9BV3o2zGIpo0uuoB4fHxYYknJywRo1RQ=;7:4LPfKnnFIXiazYHdkZKb7bMaj7P36T0MChIc3xcaY1QBdDJTLe2ufQApENyNGD/DlHLJkGwaIB0VHHY1Z0FQhd8mWRnAddHLR0BdepZ0UUSUPCJD4aBsWmeF+rtXtty6/bWXQxPYlA7jvkeLUbq4rw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cde7f651-5ee1-42f2-8b04-08d66619a8ef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3721;
x-ms-traffictypediagnostic: MWHPR0601MB3721:
x-microsoft-antispam-prvs: <MWHPR0601MB3721B9BB6E55ED10696428E2D3BF0@MWHPR0601MB3721.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3721;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3721;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39840400004)(376002)(366004)(396003)(189003)(199004)(26005)(53936002)(6116002)(25786009)(3846002)(68736007)(5660300001)(102836004)(81166006)(86362001)(186003)(478600001)(2906002)(229853002)(8676002)(6506007)(6512007)(7736002)(305945005)(71200400001)(71190400001)(486006)(6486002)(99286004)(39060400002)(14454004)(106356001)(4001150100001)(76176011)(7416002)(4326008)(2501003)(256004)(93886005)(14444005)(36756003)(103116003)(97736004)(476003)(2616005)(11346002)(6436002)(110136005)(54906003)(105586002)(8936002)(81156014)(66066001)(6246003)(316002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3721;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e8r0V9OZWI4h9NMo1OWJauPX+WIfQecOnIegA9bTCsuLLIdm3w1KSDUvBQMA4o9wRjspaB4i18j9K6jlS708+FsZwG+G9KDpZyWQTvdoqeGoQJaeTCV5+RO3g4y76Nw8Yxz7Hzx1aia2t1giYRRwFWmG5gb0Iik7yIhMXhjQ1BXjjEs+fTEM621ey6SvlI474E5KBgsISyTBKu0S9aaIh4WapCQjmgNb0bPwVddwGcX22bdGlZIgUVGK/DYthHgzYyii/Sb794/jfqOIXS4k+fGxCxrKPfggfyCojiXWu9Kldu5HzfavmRCzGNqgU+iS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F57C2BFF224B7843B60ABC715CD776CA@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde7f651-5ee1-42f2-8b04-08d66619a8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 01:22:51.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3721
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTEyLTE5IGF0IDE2OjQ3IC0wODAwLCBBbmRyZXkgU21pcm5vdiB3cm90ZToN
Cj4gDQo+ID4gPiBUaGlzIHNlcmllcyBpbml0aWFsbHkgYWRkZWQgZXhwbGljaXQgb2Zmc2V0cyBi
dXQgSSBzdWdnZXN0ZWQgYSBzaW5nbGUNCj4gPiA+ICJjb250cm9sbGVyLWlkIiBiZWNhdXNlOg0K
PiA+ID4gICAqIFRoZXJlIGFyZSBtdWx0aXBsZSBiaXQgYW5kIGJ5dGUgb2Zmc2V0cw0KPiA+ID4g
ICAqIE90aGVyIGlteDggU09DcyBhbHNvIGhhdmUgMnggcGNpZSB3aXRoIG90aGVyIGJpdC9ieXRl
IG9mZnNldHMNCj4gPiA+IA0KPiA+ID4gSGlkaW5nIHRoaXMgYmVoaW5kIGEgY29tcGF0aWJsZSBz
dHJpbmcgYW5kIHNpbmdsZSAiY29udHJvbGxlci1pZCIgc2VlbQ0KPiA+ID4gcHJlZmVyYWJsZSB0
byBlbGFib3JhdGluZyByZWdpc3RlciBtYXBzIGluIGR0IGJpbmRpbmdzLiBJdCBhbHNvIG1ha2Vz
DQo+ID4gPiB1cGdyYWRlcyBzaW1wbGVyOiBpZiBmZWF0dXJlcyBhcmUgYWRkZWQgd2hpY2ggdXNl
IG90aGVyIGJpdHMgdGhlcmUgaXMgbm8NCj4gPiA+IG5lZWQgdG8gZGVzY3JpYmUgdGhlbSBpbiBE
VCBhbmQgZGVhbCB3aXRoIGNvbXBhdGliaWxpdHkgaGVhZGFjaGVzLg0KPiA+IA0KPiA+IFlvdSBh
bHJlYWR5IGhhdmUgYW4gaWQgZm9yIHRoZSBjb250cm9sbGVyczogdGhlIGFkZHJlc3MuIFVzZSB0
aGF0IGlmDQo+ID4geW91IGRvbid0IHdhbnQgdG8gcHV0IHRoZSByZWdpc3RlciBvZmZzZXRzIGlu
IERULg0KPiA+IA0KPiANCj4gTHVjYXMsIGFyZSB5b3Ugb24gYm9hcmQgd2l0aCB0aGlzPw0KDQpE
b2VzIGFkZHJlc3MgaGVyZSBtZWFuIHRoZSBhZGRyZXNzIGZyb20gdGhlIGNvbnRyb2xsZXIncyBy
ZWcgcHJvcGVydHk/DQogDQpIb3cgZG8geW91IG1hcCB0aGF0IGFkZHJlc3MgdG8gdGhlIGNvbnRy
b2xsZXIncyBpbmRleD8gIEEgZ2lhbnQgdGFibGUNCm9mIGV2ZXJ5IHNvYyBzbyB0aGUgc29jIHR5
cGUgcGx1cyBjb250cm9sbGVyIHJlZ2lzdGVyIGFkZHJlc3MgcGFpciB0aGFuDQpjYW4gYmUgbG9v
a2VkIHVwIGluIHRoZSBkcml2ZXI/DQoNCkkuZS4sIG9uIGlNWDhNUSB0aGUgY29udHJvbGxlciBh
dCAweDMzODAwMDAwIGlzIGNvbnRyb2xsZXIgMCBhbmQgc28gb24NCmZvciBldmVyeSBwb3NzaWJs
ZSBTb0MgYWRkcmVzcyBjb21iaW5hdGlvbj8NCg0KTm90IHJlYWxseSBhIGZhbiBvZiB0aGF0Lg0K
DQpUaGUgc2l0dWF0aW9uIGhlcmUgaXMgdGhhdCBzb21lIHJlZ2lzdGVycyBmb3IgdGhlc2UgY29u
dHJvbGxlcnMgYXJlDQppbnRlcmxlYXZlZCwgcmlnaHQ/ICBJLmUuLCB0aGVyZSdzIG9uZSByZWdp
c3RlciBzb21ld2hlcmUgd2hlcmUgYml0IDANCm1lYW5zIGVuYWJsZSBjb250cm9sbGVyIDAgYW5k
IGJpdCAxIG1lYW5zIGVuYWJsZSBjb250cm9sbGVyIDEgYW5kIHNvDQpvbi4NCg0KSXNuJ3QgY2Vs
bC1pbmRleCBhbHJlYWR5IHRoZSBzdGFuZGFyZCBkZXZpY2UgdHJlZSBwcm9wZXJ0eSBmb3IgdGhp
cw0Ka2luZCBvZiBzZXR1cD8NCg0KSSBrbm93IGNlbGwtaW5kZXggd2FzIGhpc3RvcmljYWxseSBh
bHNvIChhYil1c2VkIGluIGFuIGF0dGVtcHQgdG8NCnByb3ZpZGUgYSBmaXhlZCBrZXJuZWwgZGV2
aWNlIGVudW1lcmF0aW9uIG9yZGVyLCBzb21ldGhpbmcgbm93IGhhbmRsZWQNCmJldHRlciBieSBj
aG9zZW4gbm9kZSBhbGlhc2VzLg0KDQoNCg==
