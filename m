Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30890C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F39213A2
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 10:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RDGGIYuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F39213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeKZVJs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:09:48 -0500
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:7693
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbeKZVJs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Nov 2018 16:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCOyXzLmDFAVrGvEWdnNUMmLk1AHxKENryPsW5+Fdsc=;
 b=RDGGIYuZwEmKeDvy5O4LSFtmy4IGXGFwYsRmCxXgHn2z9P0zYCMm5WwFduc/t8uIckmSIHIFXX5Jnxnzqn2F8xF68/yr+q2WA7pCdoCwu9RqZjET/oBbjMqmx20XY7Wb2o1yeN0zaTmakjuXoxHLTA3neLm9rxp+fMhdLkqnG3k=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB3966.eurprd04.prod.outlook.com (10.171.182.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 10:16:04 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 10:16:04 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUgPIBCDcLlZpcCkW2XhKPKNSgDqVY+ScAgAAPJoCAABjoAIAIvvGA
Date:   Mon, 26 Nov 2018 10:16:04 +0000
Message-ID: <ee74fde8e40a0ca40bd8b69755c9b0919f779b13.camel@nxp.com>
References: <20181120165626.26424-1-stefan@agner.ch>
         <20181120165626.26424-2-stefan@agner.ch>
         <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
         <1542741198.30311.608.camel@impinj.com>
         <268e109e1c6b309454bd5a313078894c@agner.ch>
In-Reply-To: <268e109e1c6b309454bd5a313078894c@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3966;6:KO05rrK2z0+u+BGxvT6ewxTO4+IS7vvVwj/IZJ//kLKUwEOAzwwvmDq9af+r/g6gm/rQWv/Js8H7DPAavuwVBoy5O6zdxlobSd1+g5Q49BelLiW8Q72um+gdIYRWFkaONZ5Jd5qucAWIUIzc6QSQbAYX6MORbfE9jT+d++oskebCLPgvgSWcJa2qyc+XbgJ9j6FOECPRLOGOzwoQaWYz8KLOeHI5+HUa8RYzgOHsH+dyJHKqcQKRa9fKui+dd9ozRdKENE7IzpXByjFkIEGW+tSN0UM64n3zeozBn7/NZFqii8Av+nrdN7SInz6RUwj5KrULnCYUVZmHzgnqSKB61rLoUZcOY9OwfF6HHLNsrDzS/LfTE0ZMVGfh0l1HtvZUBn9QNh4UsgNOHXPQsOJwsUczYPOg5RdotQe2FJUyGlCYfqNb2d7O51M96CzqX+WbiHopXY8PnipuZxfwoLXRMg==;5:YDATvbsOfIH6nJkyDXnPJ6H+AFemXkeb0LycYGwO80PgaKbTCWSogvKf2d3qef40KYG3nk7XF9So1Vd561+ziPzlB353SzUVNQ5HBE4MKH8F1Z4Xm7f8n25N8VCVrdmzKoGuOFSCeKbQFiSFkwsRVVyRsYnXbL0alKE5knZ7HTg=;7:aZScFl1pp38nJMUrJ4jSmUGx6Ja6TQJWU0fzy41fBI23OXpLsdp4lqVFLuB04NhDDSD95a510Otg0U6nNR+9Hun08+FqKIhXDo+gqxERABd01ejN+aTiKk1F9J4HqUHKH6J7dzlewNuaafAiZe+1AQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6977e617-24d0-431e-30f0-08d653882c8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3966;
x-ms-traffictypediagnostic: VI1PR04MB3966:
x-microsoft-antispam-prvs: <VI1PR04MB39663E82A7749D7391309AF9EED70@VI1PR04MB3966.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231443)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3966;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3966;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(106356001)(105586002)(7416002)(44832011)(2906002)(39060400002)(229853002)(36756003)(118296001)(2501003)(6436002)(4326008)(4001150100001)(6486002)(305945005)(14454004)(86362001)(99286004)(97736004)(3846002)(81156014)(81166006)(478600001)(8676002)(110136005)(316002)(66066001)(93886005)(54906003)(50226002)(53936002)(476003)(2616005)(5660300001)(486006)(446003)(6246003)(11346002)(6512007)(8936002)(25786009)(53546011)(186003)(6506007)(7736002)(26005)(6116002)(71190400001)(71200400001)(2201001)(68736007)(256004)(76176011)(102836004)(14444005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3966;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pyHbiYakXtMeJrD4HjRWDpTZmhsjEqtv2yFIhyTmamShRO6F5bejx5p8OZhVF/S/jaGZtd3anNkzh0Afth1VBQdunXThpH0jnUW+LWVz7omyRiwXbeNbbTi2awxUag+qQKeVtVcQmtU5jrGvIPxBdmsdV5FC/4FVqkeA/9PF5yI5gFWFB4SXdMoJYgixIlE8w/cKvGNjM+N8Hjz93dfxCHbmcwkqDj3HpYoUO/NiHCfAvYxVrSRl3OrRN3nwJ7+3CyWOB8+8bnCCHuu1Rqh8hVZqKsXo7D0YyY2U9JNqHPPn9v9baKxkzznFQPG+V5xCUpJYHRwJkThzidrPpEvAH5t07/anY3rkTPmaylidJFA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDFD5A1691CA9649B1CB64D5A4C944EB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6977e617-24d0-431e-30f0-08d653882c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 10:16:04.6560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3966
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTIwIGF0IDIxOjQyICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDIwLjExLjIwMTggMjA6MTMsIFRyZW50IFBpZXBobyB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MTgtMTEtMjAgYXQgMTg6MTkgKzAwMDAsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToNCj4gPiA+IE9u
IFR1ZSwgMjAxOC0xMS0yMCBhdCAxNzo1NiArMDEwMCwgU3RlZmFuIEFnbmVyIHdyb3RlOg0KPiA+
ID4gPiBEZWZpbmUgdGhlIGxlbmd0aCBvZiB0aGUgREJJIHJlZ2lzdGVycy4gVGhpcyBtYWtlcyBz
dXJlIHRoYXQNCj4gPiA+ID4gdGhlIGtlcm5lbCBkb2VzIG5vdCBhY2Nlc3MgcmVnaXN0ZXJzIGJl
eW9uZCB0aGF0IHBvaW50LCBhdm9pZGluZw0KPiA+ID4gPiB0aGUgZm9sbG93aW5nIGFib3J0IG9u
IGEgaS5NWCA2UXVhZDoNCj4gPiA+ID4gICAjIGNhdA0KPiA+ID4gPiAvc3lzL2RldmljZXMvc29j
MC9zb2MvMWZmYzAwMC5wY2llL3BjaTAwMDBcOjAwLzAwMDBcOjAwXDowMC4wL2NvbmZpZw0KPiA+
ID4gPiAgIFsgIDEwMC4wMjE0MzNdIFVuaGFuZGxlZCBmYXVsdDogaW1wcmVjaXNlIGV4dGVybmFs
IGFib3J0ICgweDE0MDYpDQo+ID4gPiA+IGF0IDB4YjZlYTcwMDANCj4gPiA+ID4gICAuLi4NCj4g
PiA+ID4gICBbICAxMDAuMDU2NDIzXSBQQyBpcyBhdCBkd19wY2llX3JlYWQrMHg1MC8weDg0DQo+
ID4gPiA+ICAgWyAgMTAwLjA2MDc5MF0gTFIgaXMgYXQgZHdfcGNpZV9yZF9vd25fY29uZisweDQ0
LzB4NDgNCj4gPiA+IA0KPiA+ID4gSSBkb24ndCBrbm93IGV4YWN0bHkgd2hlcmUgdGhpcyBsaW1p
dGF0aW9uIGNvbWVzIGZyb20sIEkgY2FuIGluZGVlZA0KPiA+ID4gcmVwcm9kdWNlIGEgc3RhY2sg
ZHVtcCB3aGVuIGR1bXBpbmcgcGNpIGNvbmZpZyBmcm9tIC9zeXMvDQo+ID4gPiANCj4gPiA+IFVu
Zm9ydHVuYXRlbHkgdGhpcyBzZWVtcyB0byBibG9jayBhY2Nlc3MgdG8gcmVnaXN0ZXJzIHVzZWQg
Zm9yDQo+ID4gPiBmdW5jdGlvbmFsaXR5IGxpa2UgaW50ZXJydXB0cy4gRm9yIGV4YW1wbGUgZHdf
aGFuZGxlX21zaV9pcnEgZG9lczoNCj4gPiA+IA0KPiA+ID4gCWR3X3BjaWVfcmRfb3duX2NvbmYo
cHAsIFBDSUVfTVNJX0lOVFIwX1NUQVRVUyArDQo+ID4gPiAJCQkgICAgKGkgKiBNU0lfUkVHX0NU
UkxfQkxPQ0tfU0laRSksDQo+ID4gPiAJCQkgICAgNCwgJnZhbCk7DQo+ID4gPiANCj4gPiA+IHdo
ZXJlIFBDSV9NU0lfSU5UUjBfU1RBVFVTIGlzIDB4ODMwLiBUaGVyZSBhcmUgbW9yZSBhY2Nlc3Nl
cyBsaWtlIHRoaXMuDQo+ID4gDQo+ID4gT24gSU1YN2QsIHRoZXJlIGFyZSBzaWduaWZpY2FudCBi
bG9ja3Mgb2YgMDBzIGluIHRoZSBjb25maWcgc3BhY2UsIGFuZA0KPiA+IGFsbCAweGZmIGF0IDB4
YjUwIG9uIHVwLg0KPiA+IA0KPiA+IEkuZS4sIHNpZ25pZmljYW50IHBvcnRpb25zIGFyZSBlbXB0
eSwgaW4gdGhlIG1pZGRsZSBvZiB0aGUgY29uZmlnDQo+ID4gc3BhY2UsIG5vdCBqdXN0IGF0IHRo
ZSBlbmQuDQo+ID4gDQo+ID4gQnV0IHRoZXkgY2FuIGJlIHJlYWQgd2l0aG91dCBwcm9ibGVtLg0K
PiA+IA0KPiA+IFBlcmhhcHMgaW14NnEgYWJvcnRzIG9uIGEgcmVhZCBvZiBhbiB1bmltcGxlbWVu
dGVkIGFkZHJlc3MgaW5zdGVhZCBvZg0KPiA+IHJldHVybmluZyB6ZXJvcyBsaWtlIGlteDdkLiAg
SW4gdGhhdCBjYXNlIGl0IHJlYWxseSBuZWVkcyBzb21ldGhpbmcNCj4gPiBtb3JlIGNvbXBsZXgg
dG8gcHJldmVudCBhYm9ydCB0aGFuIGp1c3QgYSBsZW5ndGguDQo+IA0KPiBZZWFoIGl0IHNlZW1z
IHRob3NlIFNvQ3MgYmVoYXZlIGRpZmZlcmVudGx5Lg0KPiANCj4gRGVzY3JpYmluZyBhIHJlZ2lz
dGVyIHNldCB3aXRoIGhvbGVzIHdpbGwgZ2V0IGNvbXBsaWNhdGVkLCBJIGd1ZXNzIGl0DQo+IHdv
dWxkIGFzayBmb3IgYSByZWdtYXAuLi4NCg0KVGhlIFBvcnRMb2dpYyBhcmVhIHNlZW1zIHRvIGJl
IGFsd2F5cyBhdCAweDcwMC0weEEwMCwgdGhlcmUgYXJlIGRlZmluZXMNCmZvciBpdC4gU28gdGhp
cyB3b3VsZCBvbmx5IHJlcXVpcmUgb25lIGFkZGl0aW9uYWwgcmFuZ2UsIG5vIHJlZ21hcA0Kc3R1
ZmYuDQoNCkkgZG9uJ3Qga25vdyBpZiBtYWtpbmcgcG9ydGxvZ2ljIGFjY2Vzc2libGUgdG8gdXNl
cnNwYWNlIGlzIHVzZWZ1bC4gSW4NCnRoZW9yeSBzb21lYm9keSBjb3VsZCByZWFkIGRlYnVnIERX
QyByZWdpc3RlcnMgdmlhIC9zeXMvYmxhaC9jb25maWcsDQpidXQgdGhlcmUgYXJlIGJldHRlciB3
YXlzIHRvIHJlYWQgSFcgcmVnaXN0ZXJzIGZyb20gdXNlcnNwYWNlLg0KDQpCcm93c2luZyB0aHJv
dWdoIHRoZSBkb2NzIEkgY2FuJ3QgZmluZCBzdHVmZiBsaWtlIHJlYWRzIHdpdGggc2lkZS0NCmVm
ZmVjdHMgc28gSSBjYW4ndCBzYXkgdGhhdCBpdCdzIGhhcm1mdWwgZWl0aGVyLg0KDQo+ID4gSXQg
YWxzbyBzZWVtcyB0byBtZSB0aGF0IHRoaXMgZG9lc24ndCBuZWVkIHRvIGJlIGluIHRoZSBpbnRl
cm5hbCBwY2kNCj4gPiBjb25maWcgYWNjZXNzIGZ1bmN0aW9ucy4gIFRoZSBkcml2ZXIgc2hvdWxk
bid0IGJlIHJlYWRpbmcgcmVnaXN0ZXJzDQo+ID4gdGhhdCBkb24ndCBleGlzdCBhbnl3YXkuICBJ
dCdzIHJlYWxseSBhYm91dCB0cnlpbmcgdG8gZml4IHN5c2ZzIGFjY2Vzcw0KPiA+IHRvIHJlZ2lz
dGVycyB0aGF0IGRvbid0IGV4aXN0LiAgU28gbWF5YmUgaXQgc2hvdWxkIGJlIGRvbmUgdGhlcmUu
DQo+IA0KPiBUaGF0IHdhcyBteSBmaXJzdCBhcHByb2FjaA0KDQpEb2luZyBpdCBvbiBhIHBlci1z
b2MgYmFzaXMgaXMgYmV0dGVyLCB0aGlzIHNlZW1zIHRvIGFmZmVjdCBib3RoIDZxIGFuZA0KNnFw
ICh0aG9zZSBhcmUgZGlzdGluY3QhKSBidXQgbm90IG90aGVycy4NCg0KVGhlIHBjaSBjb25maWcg
YXJlYSBmcm9tIHVzZXJzcGFjZSBpcyBhY2Nlc3NlZCB0aHJvdWdoIHBjaV9vcHMucmVhZCA9DQpk
d19wY2llX3JkX2NvbmYgd2hpbGUgaW50ZXJuYWwgYWNjZXNzZXMgZ28gdGhyb3VnaCBkd19wY2ll
X3JkX293bl9jb25mLg0KU28gbW92aW5nIHRoZSBkYmlfbGVuZ3RoIGNoZWNrIHVwIG9uZSBsZXZl
bCB3b3VsZCB3b3JrIGVhc2lseS4NCg0KV2hhdCBhYm91dCBhc3NpZ25pbmcgdG8gcGNpX2Rldi0+
Y2ZnX3NpemUgZnJvbSBwcm9iZSBjb2RlPw0KVW5mb3J0dW5hdGVseSB0aGVyZSBkb2Vzbid0IHNl
ZW0gdG8gYmUgYW55IHN0cmFpZ2h0LWZvcndhcmQgd2F5IHRvIGRvDQp0aGF0IGZyb20gaW14Nl9w
Y2llIG9yIGV2ZW4gZHdfcGNpZSwgYnV0IG1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZz8NCg0K
LS0NClJlZ2FyZHMsDQpMZW9uYXJkDQo=
