Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82437C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1A2082E
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l9iWghtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA1A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeJYSAa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:00:30 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:16288
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbeJYSA3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 14:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+78gKe+T5FIDq8+lbh+eUhAhsw3/1ylAu+gt9Z9i+I=;
 b=l9iWghtY5SBSpGVyItnMAGgHgTuPfERGmb8FqJtea5T9F+3eg4h8z4udCzYAtiYhnpVQRqqqeOJWqCvjv3nlzvlS4dyW39zP9p0amFtcfviqinlzCTC8cI/M7FeqhFkG24JjHXE03ekwaGAmgCHE0arZGefoF5IriC4SEQPUE5g=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0950.eurprd04.prod.outlook.com (10.161.195.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Thu, 25 Oct 2018 09:28:31 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:28:31 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible
 string
Thread-Topic: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible
 string
Thread-Index: AQHUXrUsqUPt1f5/7Umz+kJz90iNNaUjhB+AgAxIg8A=
Date:   Thu, 25 Oct 2018 09:28:31 +0000
Message-ID: <DB5PR04MB1221E4B46FBE26DD52E9020D84F70@DB5PR04MB1221.eurprd04.prod.outlook.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-3-Zhiqiang.Hou@nxp.com> <20181017135323.GA31980@bogus>
In-Reply-To: <20181017135323.GA31980@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0950;6:e8KtYmC+NXWYI6gU0RaUydIc5f9iivP73iQ0JbLFA/72XbA2aF5bhnskQ/gKGbMfSzxLyQhJPsbi6orVkpoyhunQOyVq9ZRVAqzekJNxbQlRU7sH6C59CQvRuZl7jX8lGdFYWGfyLAnkqtDgyO8LUv+jIoLoZKZThZLy0QIRfhfxfXN9aBCYN2vA424IMgrPElLEcsTee+Ln5lQUvVul0hic2iYJoiPHXLjMMnnfEKGMPjWjZ2T4bcFlE2dRZ5Zc18wXOBAw+wwt1Mj8tEh7FneavU3b5ECqgJz9IqKptooY49eBAEk5GW4kPFbHERIrBTzEVNPoQsN8Nzo80VCT2D8bf1sAJYPdcf5fiKV6UPTLXqR2zuAAvEM3PLPG7LtFo+/XpOInzy+vZQsBscsc3bsRA+jcGDb0q1+H+0Ng3DwY3nWYO0Oec5AJG4WqMDMpmWNzPxM4vEbQlLFHzeryoA==;5:cHkzP1EQ1v/C3EcP51FD9HX3WEKulMdh/lqBeF9XNfxJpHQEpsIOVqxo9kdFiU1el+KFHU4OE2LssarWoVoLUztqYM9j9Y/9qJzolypIa27Miz+ma4542LfqRsRqyZwK1H5UpwHZkrfPtVgg/Lz7LBNd/28A/YGc7gG3VITDsQI=;7:D2PPggUhWWmmkRbAl8IetrXdwcTz8N+MzYK0m9uG7c1zbWwIgK6iiIL/Y17RhDUtmlmr+LEBxSNv7t7oB8jGGP5oHm59UNYQGF6DfHUC/G65L/6URkDTmoxFw2+wGSgJddGvy6zPRepMZ5rxZtzhow==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9f7f7ced-5073-414a-4185-08d63a5c3a7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0950;
x-ms-traffictypediagnostic: DB5PR04MB0950:
x-microsoft-antispam-prvs: <DB5PR04MB0950B962CB983800D3BDA7D384F70@DB5PR04MB0950.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(180628864354917)(211936372134217)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0950;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0950;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(13464003)(189003)(446003)(476003)(55016002)(11346002)(229853002)(7736002)(74316002)(305945005)(6436002)(2906002)(66066001)(102836004)(186003)(33656002)(81156014)(81166006)(8676002)(8936002)(26005)(5660300001)(68736007)(5250100002)(6916009)(486006)(97736004)(256004)(2900100001)(106356001)(105586002)(99286004)(7696005)(316002)(25786009)(14454004)(86362001)(6506007)(76176011)(478600001)(71200400001)(53546011)(54906003)(53936002)(71190400001)(6246003)(3846002)(6116002)(9686003)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0950;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gj2hTJTH42yWblWhfTjuviYqF19sEd4geTCCU0BWGwCNIxMY1r82NmfchWaTiweXO4fr5DQiI98SqN8OER3AEPyctiI6/Y7zlewvNskwXbyxHPJS9ekUVEAXi4cHyb8dI1NHQLDxEzSYHK9OEshhuiEV0bq3KjigPQirqzs0DyNFM3TE2PmGnA4f9ky+x4EBlV4frvV/GzNT0L+IJQvkDdX0zclfSOPq9wjd9kedGunP5ln5ySz37MfhNk03E25RAWxwoH1AidSzq0WvEIayhSiDCo9oovgyCSu08v6Hr30xlCqZltldxI4rXfpfWob6uJ++A2FznW9NEihLzUNwd8gAfe9lX3cJOTH2ogRucFA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7f7ced-5073-414a-4185-08d63a5c3a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:28:31.1034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0950
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpUaGFua3MgUm9iIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTjE6jEw1MIxN8jVIDIxOjUz
DQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IG1h
cmsucnV0bGFuZEBhcm0uY29tOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBNaW5na2FpIEh1IDxt
aW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzRdIGRvYy9sYXllcnNjYXBlLXBjaTogcmVtb3ZlZCB1
bnN1aXRhYmxlIGNvbXBhdGlibGUNCj4gc3RyaW5nDQo+IA0KPiBPbiBNb24sIE9jdCAwOCwgMjAx
OCBhdCAxMToxNDoyNkFNICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogSG91
IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gDQo+IFNpbWlsYXIgY29tbWVudHMg
b24gdGhpcyBvbmUgdG9vLg0KPiANCj4gPg0KPiA+IFJlbW92ZWQgdGhlIGNvbXBhdGlibGUgc3Ry
aW5nICJzbnBzLGR3LXBjaWUiLCBpdCBpcyBmb3IgdGhlIHJlZmVyZW5jZQ0KPiA+IHBsYXRmb3Jt
IGRyaXZlciBmb3IgUENJIFJDIElQIFByb3RveXBpbmcgS2l0cyBiYXNlZCBvbiB0aGUgQVJDIFNE
UCwgc28NCj4gPiBpdCBpcyBub3Qgc3VpdGFibGUgZm9yIGFsbCBwbGF0Zm9ybSB3aXRoIGRlc2ln
bndhcmUgUENJZSBjb250cm9sbGVyLA0KPiA+IGFuZCBwbGF0Zm9ybSB2ZW5kb3JzIGhhdmUgdGhl
bXNlbHZlcycgZHJpdmVycy4NCj4gPg0KPiA+IFRoZSBjb21wYXRpYmxlIHN0cmluZyAic25zcCxk
dy1wY2llIiB3YXMgYWRkZWQgYnkgbWlzdGFrZSBhbmQgaXQncyBub3QNCj4gPiBtYXRjaGVkIHRo
YXQgdGltZSwgYnV0IGl0IGlzIG1hdGNoZWQgYmVjYXVzZSBwY2llIGRyaXZlcnMgaGFzIGJlZW4N
Cj4gPiBjb2xsZWN0ZWQgcmVjZW50bHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dCB8IDYgKysrLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9s
YXllcnNjYXBlLXBjaS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+ID4gaW5kZXggNWViMWMyMDI5MzJmLi45YjJiOGQ2
NmQxZjQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9sYXllcnNjYXBlLXBjaS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dA0KPiA+IEBAIC0xMyw4ICsxMyw4IEBA
IGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gIC0gY29t
cGF0aWJsZTogc2hvdWxkIGNvbnRhaW4gdGhlIHBsYXRmb3JtIGlkZW50aWZpZXIgc3VjaCBhczoN
Cj4gPiAtICAgICAgICAiZnNsLGxzMTAyMWEtcGNpZSIsICJzbnBzLGR3LXBjaWUiDQo+ID4gLSAg
ICAgICAgImZzbCxsczIwODBhLXBjaWUiLCAiZnNsLGxzMjA4NWEtcGNpZSIsICJzbnBzLGR3LXBj
aWUiDQo+ID4gKyAgICAgICAgImZzbCxsczEwMjFhLXBjaWUiDQo+ID4gKyAgICAgICAgImZzbCxs
czIwODBhLXBjaWUiLCAiZnNsLGxzMjA4NWEtcGNpZSINCj4gPiAgICAgICAgICAiZnNsLGxzMjA4
OGEtcGNpZSINCj4gPiAgICAgICAgICAiZnNsLGxzMTA4OGEtcGNpZSINCj4gPiAgICAgICAgICAi
ZnNsLGxzMTA0NmEtcGNpZSINCj4gPiBAQCAtMzYsNyArMzYsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPiA+ICBFeGFtcGxlOg0KPiA+DQo+ID4gIAlwY2llQDM0MDAwMDAgew0KPiA+IC0JCWNv
bXBhdGlibGUgPSAiZnNsLGxzMTAyMWEtcGNpZSIsICJzbnBzLGR3LXBjaWUiOw0KPiA+ICsJCWNv
bXBhdGlibGUgPSAiZnNsLGxzMTAyMWEtcGNpZSI7DQo+ID4gIAkJcmVnID0gPDB4MDAgMHgwMzQw
MDAwMCAweDAgMHgwMDAxMDAwMCAgIC8qIGNvbnRyb2xsZXIgcmVnaXN0ZXJzDQo+ICovDQo+ID4g
IAkJICAgICAgIDB4NDAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMjAwMD47IC8qIGNvbmZpZ3VyYXRp
b24gc3BhY2UNCj4gKi8NCj4gPiAgCQlyZWctbmFtZXMgPSAicmVncyIsICJjb25maWciOw0KPiA+
IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
