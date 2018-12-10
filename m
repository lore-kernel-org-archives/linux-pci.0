Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B49C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 20:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAF12084C
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 20:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="PS2N20rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAF12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeLJUeX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:34:23 -0500
Received: from mail-eopbgr710119.outbound.protection.outlook.com ([40.107.71.119]:40000
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbeLJUeW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 15:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5vruQAKx+XQnyUoZnKJlmzN4BLl+ED+bi7hhET3uWA=;
 b=PS2N20rkH34Swk5DwM+7+G9y+edzH+ClO9Zmav72GC8EA0COLAAb/ad/fNH9FqHQb7zfJ3rW0fOHbvqKevnS3rpL4HJrtX1wanHx2mbBLk86qiniTjbjR6PR7Y3XWf0iUJCEE21pWzzPxZ3g0pJRbxjBXaEoP1cVJLd/sSGWTjI=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3754.namprd06.prod.outlook.com (10.167.236.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 20:34:15 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%5]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 20:34:15 +0000
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
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqV4UIWAgAAg9wCAAARLAIAAIl0A
Date:   Mon, 10 Dec 2018 20:34:15 +0000
Message-ID: <1544474054.18519.199.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <20181210161753.GA12563@e107981-ln.cambridge.arm.com>
         <1544465752.18519.188.camel@impinj.com>
         <bf6cf5c9-6f82-79b3-c23e-05c48bf9f0f2@arm.com>
In-Reply-To: <bf6cf5c9-6f82-79b3-c23e-05c48bf9f0f2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3754;6:tGyRbeY+fYa4N/A6oRrWWhftHDjlmFZkyE2Or9MVsqJJIqOQFnac5kEK2dLcm8bXW5Kbl+OD5R6HMc9GdYnBe6mWL837D9Bxd+E7o42/HcmSqlGOQtQtRjnGUzSrHIFVjv30S2F7mhMDV/tOS+SmoqXFwkbvZjPjQ6k7iNK2lWEt0qlDLte0u++gLnufxZAyjmvSNJsq3vdpAOshl4l1KpGa+/0HdHXNREBNwjl1y1PAWewHct3Sfm41XvuksAePOv/g3qjw4p5AdwCmOaHZQzPlqi9Vb/WrPxh03AwRgnVY7548c6+uAlld5SZntKyg1iU/KNKRSHf9r/Y75oySiRSwITiLmp3I8rqFzPuFW4sausPO51PECQtbF61e5c8lBsemzvLFNILZc/79Y1htKX30iQeemXnLoF/FqnKGkVoUwwDr76FW7kWp0G/uoJRIG9SBcLv+dYZjrjVnLZf3Zw==;5:By0nE71aAiCH5sZuEufJwUWWC2PMLWJfFPkxcBSKX2/aHR0nkn439hczt8ulkBdhNJVeCaRW1lzho9zM4MHYNEXMWsqRUaPO9/t3jUoo85a5SQg1zXtgKE0mZlOy8Q6+1IkKPyCim6zH+eXat4u7Z617TcPwthd2NY/bBCpjUWI=;7:F49JtW3rBxeEEZ6du2VgreCEXvfq1T7sqXPzudEqp8okcoqnvi79x4c+mfhvfoQ1Hn1QDfYWvBrnCKphpSTSwFoqiQPn4Qr7WgZDTByWHJ8ViypWtyKY159bFUnjwfu4vxdkkGAgcqXtCmvRFl1aVg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 13c75766-0dc6-422f-feca-08d65ededa3d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3754;
x-ms-traffictypediagnostic: MWHPR0601MB3754:
x-microsoft-antispam-prvs: <MWHPR0601MB3754185D6CACC5F265F7EEE2D3A50@MWHPR0601MB3754.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3754;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3754;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(6512007)(3846002)(476003)(8676002)(103116003)(6436002)(7736002)(305945005)(36756003)(2616005)(102836004)(6506007)(2201001)(14454004)(53936002)(4326008)(106356001)(68736007)(54906003)(99286004)(316002)(86362001)(256004)(14444005)(110136005)(6486002)(6116002)(486006)(229853002)(478600001)(2501003)(5660300001)(105586002)(186003)(8936002)(39060400002)(93886005)(97736004)(81156014)(2906002)(81166006)(71190400001)(66066001)(25786009)(71200400001)(76176011)(6246003)(26005)(446003)(11346002)(4001150100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3754;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8znKSR5+g9kd9pnqON9RmzjA1lSoRgj1FWHVkP2Tknnbu5k55LtC5wqqHeO8O1DtnEwbddwNkffPKVn1vr+uWUAQif9zaV6UgDNhOo5gx1K9rNkkxLvnV32UJ5KH+mFB+Y6BNjt063OUhhYx6UKrji9HHhtHiDsuqnhSLG+FYfprROrHmDn7DMT4yLbS5fkw3oumiwwHdkqnBa8/HmL8hNW8k4BiqCG2xYTg/OllyofPgo+xt7f9JbyUhMazDrUQ9TbyDcU38NVYTPJFEMq9YlZVkjJ7zTkXhDCQC2n++eWU3Q/XOJ3rZoEe1O3KBipT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <010292E0C6498348ACB3229F203BD7BE@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c75766-0dc6-422f-feca-08d65ededa3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 20:34:15.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3754
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTEwIGF0IDE4OjMxICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IA0KPiA+IEkgaGFkIGNvbmNlcm5zIGFib3V0IHdoYXQgYXBwZWFycyB0byBiZSBhbiB1bm5lY2Vz
c2FyeSBleHRyYSBsb2NrIHRha2VuDQo+ID4gYmVmb3JlIGhhbmRsaW5nIGFuIGludGVycnVwdCBh
bmQgZW5hYmxpbmcgYWxsIE1TSXMgZXZlbiBpZiBub3RoaW5nIGhhcw0KPiA+IHRyaWVkIHRvIGVu
YWJsZSB0aGVtLg0KPiANCj4gUmVnYXJkaW5nIHRoZSBsb2NrOiBJJ20gcXVpdGUgcHV6emxlZCB0
aGF0IHlvdSBjb25zaWRlciBpdA0KPiAidW5uZWNlc3NhcnkiLCBnaXZlbiB0aGF0IGFsbCB0aGUg
RFdDIGNhbGxiYWNrcyBleHBlY3Qgc3VjaCBhIGxvY2tpbmcuIEkNCj4gc3VzcGVjdCB5b3UgYXJl
IGNvbnNpZGVyaW5nIGZyb20gYSBwdXJlIHBlcmZvcm1hbmNlIGFuZ2xlLCBhbmQgSSdkDQo+IHN1
Z2dlc3QgdGhhdCB5b3UgcG9zdCBudW1iZXJzIHNob3dpbmcgdGhlIHVuYWNjZXB0YWJsZSBvdmVy
aGVhZCBvZiBhbg0KPiBvdGhlcndpc2UgdW5jb250ZW5kZWQgbG9jay4NCg0KVGhlIGRpZmZlcmVu
Y2UgaXMgdGhhdCB0aGUgb3RoZXIgY2FsbGJhY2tzIGNhbiBiZSBjYWxsZWQgb3V0c2lkZSB0aGUN
CnBhdGggb2YgaGFuZGxpbmcgYW4gaW50ZXJydXB0LiAgQW55IHRocmVhZCBjb3VsZCBwb3NzaWJs
eSBtYWtlIGEgY2FsbA0KdG8gbWFzayB0aGUgaW50ZXJydXB0IGF0IGFueSB0aW1lLCBzbyB0aGUg
bG9jayBpcyBuZWVkZWQuDQoNCkJ1dCB0aGUgYWNrIGlzIG9ubHkgY2FsbGVkIGluIHRoZSBwYXRo
IG9mIGhhbmRsaW5nIGFuIGlycS4gIFRoYXQncyB3aHkNCml0cyBkaWZmZXJlbnQuICBUaGVyZSdz
IGFscmVhZHkgYSBzeXN0ZW0gaW5zdXJpbmcgdGhhdCBjYWxsYmFjayBpcyBub3QNCmNhbGxlZCBy
ZWVudHJhbnRseS4gIElmIHRoZSBsb2NrIHdhcyBldmVyIHRha2VuIHdoZW4gaXQgd2FzIGF0dGVt
cHRlZA0KdG8gYmUgbG9ja2VkLCB0aGVuIHdlJ2QgYWxyZWFkeSBiZSBicm9rZW4uDQoNCj4gQXMg
Zm9yIGVuYWJsaW5nIGFsbCBNU0lzIHVwZnJvbnQsIHNhbWUgdGhpbmcuIFBsZWFzZSBkZW1vbnN0
cmF0ZSBob3cNCj4gaGFybWZ1bCBpdCBpcywgZ2l2ZW4gdGhhdCB0aGV5IGFyZSBhbGwgbWFza2Vk
IGJ5IGRlZmF1bHQsIGNvbnNpc3RlbnRseQ0KPiB3aXRoIHdoYXQgb3RoZXIgaW50ZXJydXB0IGNv
bnRyb2xsZXJzIGFyZSBkb2luZy4NCg0KV2l0aG91dCBhbnkgaW5mb3JtYXRpb24gb24gdGhlIGNv
bnRyb2xsZXIsIHdobyBrbm93cyB3aGF0IHRoZQ0KZGlmZmVyZW5jZXMgYmV0d2VlbiBhIG1hc2tl
ZCBhbmQgZW5hYmxlZCB2cyBhIGRpc2FibGVkIG1zaSBhcmU/ICBJDQpkb24ndCBrbm93IHRoZXJl
IGlzIGEgZGlmZmVyZW5jZSwgYnV0IG9uIHRoZSBvdGhlciBoYW5kLCB5b3UgZG9uJ3Qga25vdw0K
dGhlcmUgaXNuJ3QuICBJdCdzIGxpa2UgYSBkb3plbiBsaW5lcyBvZiBjb2RlIHRvIG5vdCBjaGFu
Z2UgdGhlDQpiZWhhdmlvci4NCg==
