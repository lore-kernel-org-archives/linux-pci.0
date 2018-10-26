Return-Path: <SRS0=XYt1=NG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F6C46475
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 02:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8CB20824
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 02:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZTp6vpTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8CB20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeJZKzd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:55:33 -0400
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:37193
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbeJZKzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Oct 2018 06:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2agYtwIjxiizdp+Pg+XI9Y6DA6y8YM3iO7RwDA6f0w=;
 b=ZTp6vpTocQRv2/r+Djp2BSdnCBex1ZE89SBFtaSqquzo454npQnzrCL2B65qp2icGux16SUFoVhwAZs5qhO7RWSy8nXbiGtp1NP08v+ULfZmS/uis52TMiQLw/viCx1R/+R2x9KQscz8hqR7Ckw8GPaaeWwxqKrjDHcEbR+cwRw=
Received: from AM3PR04MB1217.eurprd04.prod.outlook.com (10.163.6.150) by
 AM3PR04MB402.eurprd04.prod.outlook.com (10.242.112.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 02:20:22 +0000
Received: from AM3PR04MB1217.eurprd04.prod.outlook.com
 ([fe80::3827:91fe:2ec2:a8b4]) by AM3PR04MB1217.eurprd04.prod.outlook.com
 ([fe80::3827:91fe:2ec2:a8b4%2]) with mapi id 15.20.1250.032; Fri, 26 Oct 2018
 02:20:22 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Thread-Topic: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Thread-Index: AQHUbEA3bQ9DeLR/KUmsy7zvrJJQ86Uv+XIAgADQnOA=
Date:   Fri, 26 Oct 2018 02:20:21 +0000
Message-ID: <AM3PR04MB121709BD837D4E5EA3E28B1A84F00@AM3PR04MB1217.eurprd04.prod.outlook.com>
References: <20181025085323.8819-1-Zhiqiang.Hou@nxp.com>
 <20181025134522.GE214775@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181025134522.GE214775@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB402;6:eMsSTZdSVPT8P2CsPpZ32eKBZvKnrLzPa1Jh2l1yxbes0uMjmeHayOgTfGtiTx56w8Km7V8R7SYfP1RbYDDXmXNb+U5KgeY58PszSEAJ0I101QDenq9F6s3p7889c6b3PUSpQJQB0SimNWtmC7Kd1qa2xGHnATn2FiRLYCOzvzlZ8K15Li2Mb34SHWJJ1rzdAbxjXjfNY4LnyBE3zZnUO/rmyMRJtmhRKWnUllsrpNknweQxi4ufddJp3A41XOHKboG+KU9T6dTCQgbYhLtkxbL1Qc028V/63pXnIboH1rrHLmbaccbOo7P5pJKksawqpNv2d/0v27DYQAfQtvLurothdjfACoe19sNOy2rgxLxxLYrKXJHjr8LCMQKMR7yNmDfbEcoamtNDYjthgWIrPSER1XAPLDuSP+bBDJjfT846+BbyWg/t3APOeJldamMT3GqID1Yibu9a5YKE3egAlQ==;5:awTM8jmIVQpX1F3lXRWrpcZSV3mb9pJkgk5jlvrbm/Eh42tedWTjMLvD4uZa3EQp59AbXV0rzxndvWkjtcZ3XzczAsdYAsyyKz9w10YQ+BnVUeslKIsR8gN/Gu+SuPDzBVV60hIdpaPAQlPTE+zWKzg0HObEiCRYcCsB/MJfwQM=;7:0jyjioRUTuwDivTo9nROzdCfyDeV5ByCk+6+SmEF8RXlZ2PZoG1XdM3xANNSx+NDN0sYYEKt7WI7nvTsEsbX4dMVj/amIKfZoeBURj4Yqtso4KYsChJdLa/eRvD2tOxwrcjeOMrRxLLnEJCq+NDx0w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b0612517-302b-49a5-55e8-08d63ae994f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB402;
x-ms-traffictypediagnostic: AM3PR04MB402:
x-microsoft-antispam-prvs: <AM3PR04MB4026ECEE990912D01E9CA5C84F00@AM3PR04MB402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(211936372134217)(180628864354917)(788757137089)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR04MB402;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB402;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39850400004)(366004)(13464003)(199004)(189003)(53546011)(186003)(8676002)(11346002)(6506007)(6916009)(229853002)(102836004)(74316002)(5660300001)(106356001)(476003)(5250100002)(6246003)(71190400001)(71200400001)(446003)(26005)(97736004)(486006)(76176011)(105586002)(86362001)(7696005)(2900100001)(316002)(54906003)(53936002)(6116002)(3846002)(25786009)(33656002)(66066001)(99286004)(4326008)(478600001)(305945005)(256004)(14444005)(81166006)(55016002)(9686003)(81156014)(8936002)(68736007)(14454004)(6436002)(2906002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB402;H:AM3PR04MB1217.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ToQrpuCsvMXeZenzgu9lygDEQx0c7hVgZ6Um7KvegbAoon44A16uZC+AgLRxmvO1j/UJLLB2R0K3biBj7EBUFGLRcIxpY7sG2UrwBEYvD88HfYAlKKWROQ6NzQEnlEykRZ8CVjwXZ9a8oE7FzryA1v8rO5y0pULLWFwiWPhgBQMaVs4TLZTo6wLydg+UDnWP4s3PvxekuCrR0Uyifu60ZflkVg3geUzmxelR5/qAaxfdt7SbuCM5cz+8IwCc+qhMu6iAISc9fDLSIlqM1kWuddgG7L1ZdAdBuze0eD071bV7pBUVz3DeDwS6qb417gakCCqbMsKrozrQ312LtT0ZZmgy7TQZG0kQRxp4P+zJ/94=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0612517-302b-49a5-55e8-08d63ae994f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 02:20:21.9660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB402
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IDIwMTjE6jEw1MIyNcjVIDIxOjQ1DQo+IFRvOiBaLnEuIEhvdSA8emhp
cWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tOyBSb3kgWmFuZw0KPiA8cm95LnphbmdAbnhwLmNvbT47IE0uaC4g
TGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0kv
TGF5ZXJzY2FwZTogZml4IHdyb25nbHkgaW52b2tpbmcgb2Ygb3V0Ym91bmQNCj4gd2luZG93IGRp
c2FibGUgYWNjZXNzb3INCj4gDQo+ICAgJCBnaXQgbG9nIC0tb25lbGluZSAtLWZvbGxvdyBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS5jIHwNCj4gaGVhZA0KPiAgIDZl
MDgzMmZhNDMyZSBQQ0k6IENvbGxlY3QgYWxsIG5hdGl2ZSBkcml2ZXJzIHVuZGVyIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvDQo+ICAgM2Y0M2NjYzRlYTFiIFBDSTogZHdjOiBSZW1vdmUgb2xkIE1T
SSBJUlFzIEFQSQ0KPiAgIDhjZmFiM2NmNjNjZiBQQ0k6IEFkZCBTUERYIEdQTC0yLjAgdG8gcmVw
bGFjZSBHUEwgdjIgYm9pbGVycGxhdGUNCj4gICA4NGQ4OTdkNjk5MzggUENJOiBsYXllcnNjYXBl
OiBDaGFuZ2UgZGVmYXVsdCBlcnJvciByZXNwb25zZSBiZWhhdmlvcg0KPiAgIGEzMzViMTIyYmEy
NyBQQ0k6IGxheWVyc2NhcGU6IEFkZCBzdXBwb3J0IGZvciBsczEwMTJhDQo+ICAgMDNmYzYxMzRj
MjYwIFBDSTogbGF5ZXJzY2FwZTogQWRkIHN1cHBvcnQgZm9yIGxzMTA4OGENCj4gICA4Zjg5MzU3
MDk0ZTYgUENJOiBsYXllcnNjYXBlOiBBZGQgc3VwcG9ydCBmb3IgbHMyMDg4YQ0KPiAgIGMzZjkw
OTM5ODgyNyBQQ0k6IGxheWVyc2NhcGU6IFJlbW92ZSB1bm5lY2Vzc2FyeSBjbGFzcyBjb2RlIGZp
eHVwDQo+ICAgZTQ0YWJmZWQ2ZmNiIFBDSTogZHdjOiBBZGQgYWNjZXNzb3JzIGZvciB3cml0ZSBw
ZXJtaXNzaW9uIG9mIERCSQ0KPiByZWFkLW9ubHkgcmVnaXN0ZXJzDQo+ICAgNGEyNzQ1ZDc2MGZh
IFBDSTogbGF5ZXJzY2FwZTogRGlzYWJsZSBvdXRib3VuZCB3aW5kb3dzIGNvbmZpZ3VyZWQgYnkN
Cj4gYm9vdGxvYWRlcg0KPiANCj4gTWFrZSB5b3VycyBtYXRjaCwgZS5nLiwgIlBDSTogbGF5ZXJz
Y2FwZTogQ2FsbCBkd19wY2llX2Rpc2FibGVfYXR1KCkNCj4gY29ycmVjdGx5Ig0KPiANCg0KWWVz
LCB3aWxsIHVuaWZvcm0gdGhlIHN1YmplY3QgaW4gdjIuDQoNCj4gT24gVGh1LCBPY3QgMjUsIDIw
MTggYXQgMDg6NTM6MzdBTSArMDAwMCwgWi5xLiBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogSG91IFpo
aXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgaXNzdWUgaXMgaW50
cm9kdWNlZCBieSBjb21taXQgNGEyNzQ1ZDc2MGZhYyAoIlBDSTogbGF5ZXJzY2FwZToNCj4gPiBE
aXNhYmxlIG91dGJvdW5kIHdpbmRvd3MgY29uZmlndXJlZCBieSBib290bG9hZGVyIikuDQo+IA0K
PiBDb252ZW50aW9uYWwgY29tbWl0IHJlZmVyZW5jZToNCj4gDQo+ICAgJCBnaXQgLS1uby1wYWdl
ciBzaG93IC1zIC0tYWJicmV2LWNvbW1pdCAtLWFiYnJldj0xMiAtLXByZXR0eT1mb3JtYXQ6IiVo
DQo+IChcIiVzXCIpJW4iIDRhMjc0NWQ3NjBmYWMNCj4gICA0YTI3NDVkNzYwZmEgKCJQQ0k6IGxh
eWVyc2NhcGU6IERpc2FibGUgb3V0Ym91bmQgd2luZG93cyBjb25maWd1cmVkIGJ5DQo+IGJvb3Rs
b2FkZXIiKQ0KPiANCg0KV2lsbCBjb3JyZWN0IHRoZSBjb21taXQgSUQgbGVuZ3RoLg0KDQo+IEhv
bHkgY293LCB0aGlzIGhhcyBiZWVuIGJyb2tlbiBzaW5jZSB2NC4xNC4gIElmIGZpeGluZyB0aGlz
IG1ha2VzIGEgZGlmZmVyZW5jZSwNCj4geW91IG1pZ2h0IHdhbnQgdG8gdGFnIGl0IGZvciBzdGFi
bGUuDQo+IA0KDQpIb3cgY2FuIEkgdGFnIGl0IGZvciBzdGFibGU/DQoNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS5jIHwgMiArLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS5jDQo+
ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS5jDQo+ID4gaW5k
ZXggNjlmM2YxYTVhNzgyLi5iMjA4NTk4OGRiZWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLmMNCj4gPiBAQCAtODgsNyArODgsNyBAQCBz
dGF0aWMgdm9pZCBsc19wY2llX2Rpc2FibGVfb3V0Ym91bmRfYXR1cyhzdHJ1Y3QNCj4gbHNfcGNp
ZSAqcGNpZSkNCj4gPiAgCWludCBpOw0KPiA+DQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgUENJRV9J
QVRVX05VTTsgaSsrKQ0KPiA+IC0JCWR3X3BjaWVfZGlzYWJsZV9hdHUocGNpZS0+cGNpLCBEV19Q
Q0lFX1JFR0lPTl9PVVRCT1VORCwgaSk7DQo+ID4gKwkJZHdfcGNpZV9kaXNhYmxlX2F0dShwY2ll
LT5wY2ksIGksIERXX1BDSUVfUkVHSU9OX09VVEJPVU5EKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyBpbnQgbHMxMDIxX3BjaWVfbGlua191cChzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+IC0t
DQo+ID4gMi4xNy4xDQo+ID4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==
