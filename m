Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA44C04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C6D2082B
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="aNKtgha8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C6D2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbeLFUUS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:20:18 -0500
Received: from mail-eopbgr750099.outbound.protection.outlook.com ([40.107.75.99]:37907
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbeLFUUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 15:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9eliro8QS7lXIM0GF4ySg+5dSdoikSEeyYZXNc70fY=;
 b=aNKtgha8aNH1bCQo8pigplhSR/wCrnRBBxC7PXho9VMNwOl6ldtJefUqZ9L1Tt5fAQZQAhm7M3lPzoR56W9HZ2Te53VIofF+0lY1s8/L0fFe6evofLEDUcG7G5QX5+As/WQBJzIQS+DeMlQtAnjCUP8snqUzTxsFO4hW1d6aasM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3625.namprd06.prod.outlook.com (10.167.236.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 20:20:01 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 20:20:01 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
Thread-Topic: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on
 PCIEPORTBUS
Thread-Index: AQHUjTfBbQvVAJ6kdke01R/lWmbrWaVxgowAgAClJAA=
Date:   Thu, 6 Dec 2018 20:20:01 +0000
Message-ID: <1544127600.18519.175.camel@impinj.com>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
         <1544092136.3709.57.camel@pengutronix.de>
In-Reply-To: <1544092136.3709.57.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3625;6:TD5+BQkZ66rTM/cVfgiYSuHCZr/vB9NjH4uUnlLWQtDM8+KYlJjBDl79frbdE0voFyZuZRi6khrRjsan0AefIqo61UsY4t4V74/zEHYLVXAMEwRABprsIndoojyV7HX3fbNw955YOqgSBEctspTJLK2HnkM7mNsDyGEHmqPiLWlAiIWCGxtPp1v13wc6bBAZim+8jqWcAUtOInr92lgbsznuq+tLo9bmF3lbeQ/2D4a63d4cqvyn90RDktzQypb8j8aJUYpaE8W7uMwBD8HiIqUrwUETh0cDG6pZYSv/OR8Sclwg8TPyvojwc3F9+LKBEc1lfnidPkgqL0GuRwVp1CjQMFzwog+5OzT+gFQxq3v/3vdM6y2NIikvop/MdEdkmAqqKWl7OmdpkFUbRanXut+T3p+RVEFsRY/LSWAx/+Q8Wlq0YRyELxY2lhSTLQ/uiOE+Tzs/1+bnqy7CA3pq7Q==;5:izPJUL8Bpd1pJYyOkY0+e1lWkaL4JMyR6Ihk+oEq+N7E/kjLvqn62+8C+AE6MM+edeCbp7Pp1bSSkqFJ8bby5j23OeqUugue15vJeAEr+zg6oHLJpx8QzjMFx/IGPxw6+uhM1bmCj6J74y/3qXRr40oJC21TXt3y1SdT5gO6sJM=;7:hQSjBUaUI/031Ad//vlpX8yPA6+EJ7oP+NoWD8WkAmMte2O4loC2Auo8ZVB4raGhZoEcNubpA2AnZ3sSrHcnlcBN18XOTW1OVkmZ4rKL+eYRbComRLyIt+38OcWubeduSFSel3PRBCsKei+w38QD9w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1b7f2a6c-bad8-44b6-bc25-08d65bb8338a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3625;
x-ms-traffictypediagnostic: MWHPR0601MB3625:
x-microsoft-antispam-prvs: <MWHPR0601MB36259BCF7E262A97852893AAD3A90@MWHPR0601MB3625.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3625;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3625;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39850400004)(396003)(346002)(136003)(376002)(189003)(199004)(2616005)(11346002)(446003)(966005)(476003)(14454004)(66066001)(76176011)(7416002)(4326008)(8936002)(105586002)(486006)(2501003)(478600001)(6486002)(6436002)(6116002)(39060400002)(5660300001)(3846002)(71200400001)(71190400001)(305945005)(5024004)(99286004)(68736007)(2906002)(229853002)(316002)(103116003)(6512007)(86362001)(256004)(106356001)(53936002)(186003)(2201001)(54906003)(6246003)(8676002)(97736004)(81156014)(6306002)(26005)(7736002)(81166006)(25786009)(110136005)(102836004)(6506007)(36756003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3625;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Xjzv7B7aprDrA0GrybGQgk/Ahxda41amJNmDK5I11dPRgdK8r4efXSnUeR/5dy57wn420rr16qsWXm2xi3DiTmck6rp8+r0cO2cY/NdVciCsLwC32ZryPv4d+4rgyKDgoO0aGuiyqsuAr1nhy3EWKjcfThqrwIDED2W0OPs2QOOfsyV7sz9pxeIJVh+GJrbEGPqmiP3eShfYYS0riKedp09jBV+oQfQB4PO65yd2aIZj9B2QgYlkLtIdbF5KECQbBU+JKQ+fWN7MlNvh6gnr9l2xFUPEvXs7bmu0C3YvgLpeDZQH8DrTwIuS8aLgIf2dKPtL1FjvxjvH0aBfSBKg2nLRYqo+OPk1OaFWOv+whwA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B4DF0C2968DBE4793149EDF8E3E488F@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7f2a6c-bad8-44b6-bc25-08d65bb8338a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 20:20:01.5233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3625
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTEyLTA2IGF0IDExOjI4ICswMTAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzo0NSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Og0KPiA+IEJ1aWxkaW5nIGEga2VybmVsIHdpdGggQ09ORklHX1BDSV9JTVg2PXksIGJ1
dCBDT05GSUdfUENJRVBPUlRCVVM9bg0KPiA+IHByb2R1Y2VzIGEgc3lzdGVtIHdoZXJlIGJ1aWx0
LWluIFBDSUUgYnJpZGdlICgxNmMzOmFiY2QpIGlzbid0DQo+ID4gYm91bmQNCj4gPiB0byBwY2ll
cG9ydCBkcml2ZXIuIFRoaXMsIGluIHR1cm4sIHJlc3VsdHMgaW4gYSBQQ0lFIGJ1cyB0aGF0IGlz
DQo+ID4gY2FwYWJsZSBvZiBlbnVtZXJhdGluZyBhdHRhY2hlZCBQQ0lFIGRldmljZSwgYnV0IGxh
Y2tzIGZ1bmN0aW9uYWwNCj4gPiBpbnRlcnJ1cHQgc3VwcG9ydC4NCj4gDQo+IFRoaXMgaXMgb2Rk
LiBBRkFJSyBQQ0kgcG9ydCBzZXJ2aWNlcyBhcmUgYSB0b3RhbGx5IG9wdGlvbmFsIHRoaW5nIGFu
ZA0KPiB0aGVtIGJlaW5nIGFic2VudCBzaG91bGQgbm90IGxlYWQgdG8gYSBub24tZnVuY3Rpb25h
bCBQQ0kgYnVzLiBTbyBJDQo+IHdvdWxkIHJlYWxseSBsaWtlIHRvIHNlZSBzb21lIGRlZXBlciBh
bmFseXNpcyB3aGF0IGlzIGdvaW5nIG9uIGhlcmUuDQoNCkkgbm90aWNlZCB0aGlzIHByZXZpb3Vz
bHksIA0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtcGNpL21zZzc3ODQwLmh0
bWwNCg0KV2hhdCBoYXBwZW5lZCB3YXMgdGhhdCBQQ0lFUE9SVEJVUyAqd2FzKiBzZWxlY3RlZCBi
eSBhbGwgdGhlIHBsYXRmb3JtDQpkd2MgZHJpdmVycyBhbmQgdGhvc2Ugc2VsZWN0aW9ucyB3ZXJl
IHJlbW92ZWQgaW46DQoNCmNvbW1pdCBmM2ZkZmM0YWMzYTI2ODY1ZTg0NjI3YTdmZTA4YTkwNjA4
MWU1YWJjDQpBdXRob3I6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQpEYXRl
OiAgIEZyaSBNYXkgMTggMTU6MDg6MzYgMjAxOCAtMDUwMA0KDQogICAgUENJOiBSZW1vdmUgaG9z
dCBkcml2ZXIgS2NvbmZpZyBzZWxlY3Rpb24gb2YgQ09ORklHX1BDSUVQT1JUQlVTDQogICAgDQog
ICAgSG9zdCBicmlkZ2UgZHJpdmVycyBkbyBub3QgdXNlIHRoZSBwb3J0ZHJ2IGludGVyZmFjZXMg
KHN0cnVjdCBwY2llX2RldmljZSwNCiAgICBzdHJ1Y3QgcGNpZV9wb3J0X3NlcnZpY2VfZHJpdmVy
LCBwY2llX3BvcnRfc2VydmljZV9yZWdpc3RlcigpLCBldGMpLCBhbmQNCiAgICB0aGV5IHNob3Vs
ZCBub3Qgc2VsZWN0IENPTkZJR19QQ0lFUE9SVEJVUy4NCg0KSSBlbmNvdW50ZXJlZCB0aGlzIHdo
ZW4gYSBrZXJuZWwgZGVmY29uZmlnIHRoYXQgcHJldmlvdXNseSB0dXJuZWQgb24NClBDSUVQT1JU
QlVTIHN0b3BwZWQgdHVybmluZyBpbiBvbiwgcmVzdWx0aW5nIGluIHRoZSBzaXR1YXRpb24gdGhh
dA0KQW5kcmV5IGRlc2NyaWJlczogIG5vIGVycm9ycywgZGV2aWNlIHByZXNlbnQsIGJ1dCBubyBN
U0kgaW50ZXJydXB0cy4NCg0KVGhlIGluIGtlcm5lbCBkZWZjb25maWdzIChtaW5lIG5vdCBiZWlu
ZyBvbmUgb2YgdGhvc2UpIGZvciBhbGwgdGhlIGR3Yw0KcGNpZSB1c2VycyBzaG91bGQgcHJvYmFi
bHkgYmUgcmVmcmVzaGVkIHRvIGVuYWJsZSBwY2llcG9ydGJ1cy4NCg0KSXQgc2VlbXMgYXBwcm9w
cmlhdGUgdGhhdCB0aGUgcG9ydCBzZXJ2aWNlcyBhcmUgb3B0aW9uYWwgYW5kIGl0J3MNCnVuZm9y
dHVuYXRlIHRoYXQgdGhlIGtlcm5lbCBkZWZjb25maWcgc3lzdGVtIHJlc29sdmVzIGluIHRoZSBj
aGFuZ2UgaW4NCnRoaXMgbWFubmVyLCB2cyBrZWVwaW5nIHBjaWVwb3J0YnVzIG9uIGJ5IGRlZmF1
bHQuICBJIGRvIGtub3cgd2h5IGl0IGlzDQp0aGlzIHdheSBhbmQgSSBkb24ndCB0aGluayB0aGVy
ZSBpcyBhbnkgZ3JlYXQgc29sdXRpb24gdGhlcmUuDQoNCkl0IGhhcyBuZXZlciBiZWVuIGNsZWFy
IHRvIG1lIHdoeSBwY2llcG9ydGJ1cyB3YXMgbmVjZXNzYXJ5IGZvciBNU0ku
