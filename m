Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39173C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D711C20832
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="JOgq3msc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D711C20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbeK2HDt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:03:49 -0500
Received: from mail-eopbgr820111.outbound.protection.outlook.com ([40.107.82.111]:20790
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbeK2HDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 02:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe4gi7qVa9yuHRdwSvFPGXtwLq9oDmU+kKb91geP/HA=;
 b=JOgq3msc6iopEnpOkVCco082VRthm+MmMACgsFw0tSePhQWp3+GI7U6qPzNBAa3cV10oYS50xND7yuo8L2TVzmC8De5SHqyEzd2o8iYdMQiQp0R4FdowK9sokCD5iHx9IZysiVfFeHWmz6Jy073ON/K0bNvBG+6+fGQXKn5Ud4E=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3676.namprd06.prod.outlook.com (10.167.236.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 20:00:58 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 20:00:57 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
Subject: Re: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
Thread-Topic: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
Thread-Index: AQHUhx3olr351tELyESJsCCkW3sxWqVlXTUAgAAspICAAA/GAIAAAkyA
Date:   Wed, 28 Nov 2018 20:00:57 +0000
Message-ID: <1543435257.18519.98.camel@impinj.com>
References: <20181128132554.28139-1-stefan@agner.ch>
         <ff476784-b79e-18bf-5870-4365c8377deb@arm.com>
         <1543431377.18519.94.camel@impinj.com>
         <f7096d74-9097-771d-1a4b-f6665b3689d4@arm.com>
In-Reply-To: <f7096d74-9097-771d-1a4b-f6665b3689d4@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3676;6:v6JTvzh3/MtpQrCimmPiKqwtbSkzPfxGI+JRswEHRF+OY60Vxo/JWAWGBtfbXRf9yldgZBBCH5JASt7K8Em9+yVYHYyIWm7SWqhbcjJLMP7c9ES+h7SOF6cz6G/p6j1cdEhOnE2heWRpKYOgCcjBYBkAm3hIW3aPcl+ZmrYduNWP8g4EiHZey3U1MRfwa8QKrtk+Q+PtIfwVYiMEWPV2zLVB9rC2JHP3DFemwnYVf1TAd3Ufh4S7+L3Eg+snKHxRnQB0sVeElyE6W3R6i5/4cQGtLM9D5i/pN5GuFTdP70LHn+mgGRjfYqzEGWIyli6PbRjfBeHRK84Tk7YDsuF8AHIdUojjlGrmRKOWD02sZnm/yrAlxpQ13eRHzfcNMm7GMBGgJVJuRNLndbFkfymtoen4KAYNs/JhP51OoOwFQ1NOpG6QDsnwc+Sr2x5te0V7vw+4eNdaFtMIq2VWYXPxHg==;5:+AegMvZWrP+aStX1Uu12Nsn56CwxKd3PDnR/1noWORP9xRxPPmLVss4eAcu/C0h+OhkR40AD+HHxXTVh8ObrFZJLYwxCTORA1s30e9wuXB+C97OMx9CFZ6bxJFJLxgey/CGCRdIaWs/VihI3oL+TnzbfiGhgY+QVXMV/tDelx28=;7:tFhDZzKiYvwNpEZPP0+36lyuUbbczocjm1yqqY59TrXRTVmKfYC+grfz9AXgvyALP6v2dm1nWVvUNvhFNzxqbg/RX87xzcafkcbbvuH1Zi5fwnYnOWknw3PAY7X8tSrgXy4x6wC2TnauNxaTP80pIQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2590e1d6-2704-41d8-f018-08d6556c3692
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3676;
x-ms-traffictypediagnostic: MWHPR0601MB3676:
x-microsoft-antispam-prvs: <MWHPR0601MB367653E88B9412F61DF6E11CD3D10@MWHPR0601MB3676.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3676;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3676;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(5660300001)(39060400002)(6436002)(6512007)(71190400001)(478600001)(71200400001)(2201001)(14454004)(7736002)(305945005)(229853002)(68736007)(53936002)(476003)(2616005)(86362001)(11346002)(486006)(99286004)(110136005)(54906003)(103116003)(316002)(7416002)(186003)(2906002)(97736004)(4326008)(2501003)(446003)(6486002)(81156014)(6506007)(81166006)(53546011)(76176011)(256004)(14444005)(66066001)(102836004)(8936002)(4001150100001)(36756003)(6246003)(106356001)(8676002)(105586002)(26005)(25786009)(6116002)(3846002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3676;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J/AckUXvEuqWjaM+Jor+jE2QmCiWKCef2o5PKCbnRyP6kO/wRPM2ZYOnCONSWj4XeMLeH7tInW/IMeSiF9UDiOpcXZUJCPJ2blr7z0gueeAA2GIm0IZx0GWBJgdCuXEB1ywuJYh4skWT8ZfN+lneG5gh1MCnPThv50xlwnPRizYcVlx4VKnzt76Dfw8B/fYmKANN7UNjm+50Rlpan2lIpbHgPQpwyvg5S26sOAM5r/25gy/KBKv4MbC/9kalW4J9DfTy5Sk5I66vlEt5FnGnNfhY+ssmx0z8FhvxvtYE3JKl9HKSSPkWxo3Qopkv8qPSPcLWXs3VIhcWLyL0XExRZih5e37ggQiB2FEknuVr2cI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <776E00413C28E548AA1A0EEF40A3AE33@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2590e1d6-2704-41d8-f018-08d6556c3692
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 20:00:57.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3676
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTI4IGF0IDE5OjUyICswMDAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDI4LzExLzIwMTggMTg6NTYsIFRyZW50IFBpZXBobyB3cm90ZToNCj4gPiBPbiBXZWQsIDIw
MTgtMTEtMjggYXQgMTY6MTYgKzAwMDAsIFJvYmluIE11cnBoeSB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gPiAgICANCj4gPiA+ID4gK3N0YXRpYyBpbnQgaW14NnFfcGNpZV9hYm9ydF9oYW5kbGVyX3Ro
dW1iMih1bnNpZ25lZCBsb25nIGFkZHIsDQo+ID4gPiA+ICsJCXVuc2lnbmVkIGludCBmc3IsIHN0
cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcg
cGMgPSBpbnN0cnVjdGlvbl9wb2ludGVyKHJlZ3MpOw0KPiA+ID4gPiArCXVuc2lnbmVkIGxvbmcg
aW5zdHIgPSAqKHVuc2lnbmVkIGxvbmcgKilwYzsNCj4gPiA+ID4gKwl1bnNpZ25lZCBsb25nIHRo
dW1iMl9pbnN0ciA9DQo+ID4gPiA+IF9fbWVtX3RvX29wY29kZV90aHVtYjE2KGluc3RyKTsNCj4g
PiA+ID4gKwlpbnQgcmVnID0gdGh1bWIyX2luc3RyICYgNzsNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
CWlmICghX19vcGNvZGVfaXNfdGh1bWIxNihpbnN0ciAmIDB4MDAwMGZmZmZVTCkpDQo+ID4gPiA+
ICsJCXJldHVybiAxOw0KPiA+ID4gDQo+ID4gPiBUaGVyZSBhcmUgcGxlbnR5IG9mIDMyLWJpdCBU
aHVtYiBlbmNvZGluZ3Mgb2YgdmFyaW91cyBMRFIvU1RSDQo+ID4gPiB2YXJpYW50cywNCj4gPiA+
IGFuZCBJIGRvdWJ0IHdlIGNhbiBndWFyYW50ZWUgdGhhdCB0aGUgb2Zmc2V0LCB0YXJnZXQgcmVn
aXN0ZXIsDQo+ID4gPiBhbmQvb3INCj4gPiA+IGFkZHJlc3NpbmcgbW9kZSBmb3IgYSBjb25maWcg
c3BhY2UgYWNjZXNzIHdpbGwgKmFsd2F5cyogc3VpdCB0aGUNCj4gPiA+IChyZWxhdGl2ZWx5IGxp
bWl0ZWQpIDE2LWJpdCBvbmVzLg0KPiA+IA0KPiA+IEl0IG1pZ2h0IGJlIHRoZSBjYXNlIHRoYXQg
UExEL1BMSSwgMzItYml0IHRodW1iMiBpbnN0cnVjdGlvbnMsDQo+ID4gY291bGQNCj4gPiB0cmln
Z2VyIGFuIGFib3J0IHRvby4NCj4gDQo+IFByZWxvYWQgaW5zdHJ1Y3Rpb25zIHNob3VsZG4ndCBj
YXVzZSBhICpzeW5jaHJvbm91cyogYWJvcnQsIHdoaWNoIGlzIA0KPiB3aGF0IHdlJ3JlIHRyYXBw
aW5nIGhlcmUsIGFuZCB0aGV5IGNvdWxkIG9ubHkgcmVzdWx0IGluIGFuIGFzeW5jaHJvbm91cyAN
Cj4gYWJvcnQgY29taW5nIGJhY2sgbGF0ZXIgaWYgdGhlIGFkZHJlc3MgaXMgbWFwcGVkIGFzIE5v
cm1hbCBtZW1vcnksIHdoaWNoIA0KPiBpdCByZWFsbHkgc2hvdWxkbid0IGJlIGluIHRoaXMgY2Fz
ZS4gRnJhbmtseSBlaXRoZXIgd2F5LCBhbnlvbmUgZXZlbiANCj4gdGhpbmtpbmcgYWJvdXQgdHJ5
aW5nIHRvIHB1bGwgUENJIGNvbmZpZyBzcGFjZSBpbnRvIGRhdGEgY2FjaGVzLCBsZXQgDQo+IGFs
b25lIGluc3RydWN0aW9uIGNhY2hlcywgcHJvYmFibHkgZGVzZXJ2ZXMgZXZlcnl0aGluZyB0aGV5
IGdldCA7KQ0KDQpJdCB3b3VsZCBiZSBlYXN5IHRvIGRvIGZyb20gdXNlcnNwYWNlLiAgbW1hcCB0
aGUgY29uZmlnIHNwYWNlIGF0dHJpYnV0ZQ0KaW4gc3lzZnMsIGFuZCB0aGVuIGNhbGwgcGxhaW4g
b2xkIGdsaWJjIG1lbWNweSgpIG9uIGl0IHRvIGNvcHkgdG8NCm5vcm1hbCByYW0uICBzdHJsZW4o
KSwgbWVtY3B5KCksIGV0Yy4gYXJlIGNvZGVkIHdpdGggcGxkIGluc3RydWN0aW9ucy4=
