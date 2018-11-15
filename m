Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC4C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 18:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996B2146D
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 18:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="RdLInYPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5996B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeKPEqc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:46:32 -0500
Received: from mail-eopbgr770125.outbound.protection.outlook.com ([40.107.77.125]:14272
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeKPEqc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 23:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlANYFbd9mkg7r5Z8zBFmJXxRo5AOGR++lqQkSbKYyY=;
 b=RdLInYPadq09+zUIMOcUHWrlU67epn5j8lLkaxkGXZWVELCNFQNS+dYc/SK7nHal6nIHhK+0Y92klM1wbIeSDWBKl+Dn2U4JLuawwZPm+LNcdutmU9v0al0fAG5apAn35f8Paa1DuzZwa5gkH8QA+ddB6LeXL4nT9e5BiaUB4ds=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3721.namprd06.prod.outlook.com (10.167.236.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Thu, 15 Nov 2018 18:37:33 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 18:37:33 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "helgaas@google.com" <helgaas@google.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVPmEcAgAFeawCAADaPAA==
Date:   Thu, 15 Nov 2018 18:37:33 +0000
Message-ID: <1542307052.30311.531.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <1542220084.30311.453.camel@impinj.com>
         <a5f464c5-bc21-5986-7974-6fbabc450147@synopsys.com>
In-Reply-To: <a5f464c5-bc21-5986-7974-6fbabc450147@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3721;6:2h3VkSlcQnpSotbBYGX8MIqg3NiZ/XLzzb8sv1h3zHUAH419Z+2j9v6WXhzMDPzD9LZWkHpT6kzXwpJ113DyWRWjNL9kWtwXxuId+OrgfjLDJaXL9y6Gpge23xgXnUOEK9F74fOG5iNjL3YYFaYbc8mdl0w/hpnbF91A6Oa1S9o0jMgJjPlrk2yRi+Sj0e8uWKhq5aASd3mrjWjzU2zEzqlbhQNWU/u+QQkokHmrR4b60OPiSCFtqsNMpC+RCSNUqfGULvsiD7utZfpIkGnkMQ+gb8WwNGLa7h8WEieETv4Ne0yLMsX3R++J6yY/cF8m6vC2S+GZ4Y48m9qn9Icg+2h6tzL2tUOrZE3OIzpIISaePzjG+thWqYNyDtrd1LmFVHexd4IBNGdk+HapNYTE3PE98qj5LsibMroEGPllYvJNiQlkDVxjFsFeCqYbOcC5vwjJyft5+z7h/y1bZucnwA==;5:nA4ZtGaiw0AsvYRvJOT0fSTaKrond267dZTvU9/1XAe+F6ZjwnDAEfK1Sl6hyBT+Yd2dYgeEFUPC0Xc5CEFdqkh0R0H9RVrVlovcy3yoot5TSp2YrvGoojBUge2KRzwgj+fpCeYC9eY/hBfFjaRQVcn+RbAKM9MC7b6+3UOdk/o=;7:rizM07U1CZFrtjt/InUUqjunvJqQ8neTUqOkQgoNn8JyrKWPND2Lc6jvX16rjolg/yk6bpziz5p4P71cJA9B8LVltlC9y5jt+l7Ip4ycv76tHa31dGckDXuMxHYmk2UnVFc7AfOqn6LMgkG1H5h8Qg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1939b434-2c64-4bd3-39d9-08d64b296835
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3721;
x-ms-traffictypediagnostic: MWHPR0601MB3721:
x-microsoft-antispam-prvs: <MWHPR0601MB372198BD40C752F549831F29D3DC0@MWHPR0601MB3721.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3721;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3721;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(486006)(8676002)(186003)(8936002)(81156014)(81166006)(6246003)(71190400001)(71200400001)(36756003)(68736007)(229853002)(39060400002)(6506007)(4326008)(53936002)(66066001)(316002)(25786009)(305945005)(2616005)(446003)(476003)(478600001)(11346002)(54906003)(26005)(110136005)(2201001)(7736002)(14454004)(5660300001)(86362001)(6486002)(2906002)(2900100001)(106356001)(6116002)(99286004)(53546011)(105586002)(103116003)(97736004)(76176011)(6436002)(256004)(3846002)(4001150100001)(6512007)(2501003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3721;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WRzUOUAfldPmb5zdNChyUMzB6Jw6RHkyRQrhHlKlacuQt3quL2oJYG6tsLruDTmn/06rDPPC1NwD4vcVgvzlel9ADc0Xyz7rUErFyuercCiMrO0oHgewaXvChjvC6ZdtukXXMGo5R0NTJcomy8aOHW3P029mrW0nNakLeMAMV4/MxdbGR7v+hmM++Cp3PtftGf79rpdYKA4w/BYwRBORxgEsAaojvK0QWqv9eugF9GRdO8HVOGYFOHiUQTbZqKJtI//rJ9kN8wfjePcUCEqjT8D3p6j2T153I9bdwd8B9DX5T1GRRzc4YcObxMb8wHU9S8AlI84/1rapQM+PGVPQsNLDrxn3JJWkKneOAy+FemE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <61147431EAAC3F47AC1C9B2108E74054@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1939b434-2c64-4bd3-39d9-08d64b296835
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 18:37:33.2003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3721
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTE1IGF0IDE1OjIyICswMDAwLCBHdXN0YXZvIFBpbWVudGVsIHdyb3Rl
Og0KPiBPbiAxNC8xMS8yMDE4IDE4OjI4LCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gT24gVHVl
LCAyMDE4LTExLTEzIGF0IDIyOjU3ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gPiAN
Cj4gPiBOb3cgaXQgd29ya3MgYWdhaW4uICBSYWNlIHN0aWxsIHByZXNlbnQuICBJIGRvbid0IHNl
ZSB0aGUNCj4gPiBkd19wY2lfbXNpX2JvdHRvbV8odW4pbWFzayBtZXRob2RzIGV2ZXIgZ2V0IGNh
bGxlZC4gIEkgc2VlbSB0byByZWNhbGwNCj4gPiB0aGF0IHRoZXkgYXJlIGNhbGxlZCBhcyBhIHN1
YnN0aXR1dGUgaWYgZW5hYmxlL2Rpc2FibGUgYXJlIG5vdCBwcmVzZW50LA0KPiA+IGJ1dCBoYXZl
bid0IGNvbmZpcm1lZCB0aGF0LCB3aGljaCB3b3VsZCBleHBsYWluIHdoeSB0aGV5IGFyZSBub3Qg
Y2FsbGVkDQo+ID4gYWZ0ZXIgSSBhZGRlZCBlbmFibGUuDQo+IA0KPiBIdW0sIHRoaXMgcHJvYmFi
bHkgaXMgY29ycmVsYXRlZCB3aXRoIFsxXSB3aGVyZSBvbiB0aGUgZGVzY3JpYml0aW9uIHRoZSB0
aGlzDQo+IGVudW1lcmF0b3Igc2F5cyB0aGF0ICJPbmUgc2hvdCBkb2VzIG5vdCByZXF1aXJlIG1h
c2svdW5tYXNrIiBzZWUgWzJdDQoNClRoYXQgc2VlbXMgcmVhc29uYWJsZSB0aGVuLiAgSSd2ZSBz
YWlkIGJlZm9yZSB0aGF0IHdoaWxlIEkgdGhpbmsNCm1hc2tpbmcgY291bGQgYmUgYWRkZWQgaW4g
dGhlIGludGVycnVwdCBmbG93IHdpdGhvdXQgYnJlYWtpbmcgYW55dGhpbmcsDQpJIHRoaW5rIGl0
J3MgcmVkdW5kYW50IHRvIGRvIGl0IGF0IHRoaXMgbGF5ZXIuDQoNCkkgc3VzcGVjdCBpdCBtaWdo
dCBiZSBwb3NzaWJsZSBtYXNrL3VubWFzayB0aGUgaW50ZXJydXB0ICJtYW51YWxseSIsDQplLmcu
IFVJTyBkb2VzIHRoaXMgdG8gYWxsb3cgaGFuZGxpbmcgYSBsZXZlbCBpbnRlcnJ1cHQgZnJvbSB1
c2Vyc3BhY2UsDQphbmQgdGhhdCB3b3VsZCBiZSBhIHBhdGggdG8gcmVhY2ggdGhlIG1hc2sgbWV0
aG9kcy4=
