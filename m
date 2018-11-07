Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B7C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 04:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7602086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 04:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzUZ29GA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7602086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbeKGN6D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 08:58:03 -0500
Received: from mail-ve1eur01on0044.outbound.protection.outlook.com ([104.47.1.44]:31824
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387839AbeKGN6D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 08:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbXj3+yf2algdIN8KgDX8nM5y2isENqetCSxq7iGXSY=;
 b=jzUZ29GAMN4XUcrO6pSasccMasssmv/KgBYgSgHdcgk8l/LFnU0vmq0YStwqNrPMlCvWXdAg3jAHDqHtpkw+zWcXPt2JH5Ru1EY6DwIkT2/N/q/kuWtmPnsoj+j7swDWd2//iMCx5tgOi64FI59fG1AwXTHrAoaRhuWZ4kpV1DQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5461.eurprd04.prod.outlook.com (20.178.93.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 04:29:19 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 04:29:19 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH v2 3/4] dts/arm/ls1021a: Clean PCIe controller compatible
 strings
Thread-Topic: [PATCH v2 3/4] dts/arm/ls1021a: Clean PCIe controller compatible
 strings
Thread-Index: AQHUbEgOmENJU84lvUu8AoxrcxdgO6UyBLqAgBHHDdA=
Date:   Wed, 7 Nov 2018 04:29:19 +0000
Message-ID: <AM6PR04MB5781A4335A41AF4DC9D1D87884C40@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com>
 <20181025094929.29481-4-Zhiqiang.Hou@nxp.com>
 <CADRPPNQRofR6Upe6_pTNm-bqt0HMVWBOXyYSH8xGvD2g7_nwCA@mail.gmail.com>
In-Reply-To: <CADRPPNQRofR6Upe6_pTNm-bqt0HMVWBOXyYSH8xGvD2g7_nwCA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5461;6:8ppMcx1C03hfxO4KJsjYqSZ/y1gErFZ5u2TOKACO3k96cUz5FpTIWNQkbs5gQRXSBBBVqH+WCB67xcqbORCrZzQDOrhCfnlDYzb71O7EFc7U+WF/DrwUwxI3cIe2Q5xq/7CSEprEqmRl1kR6Q4EvFpmq4PN9NW2maXwv9gFdhv8id+XlGEbLJte/UcpOapriO0TmSAChAzd9sC2DJ1J/cCOSkSHUSeBgynS3BUgk0oPQygjt2+/vS3z5BwlRstPx/IDJnUM/bL6F5cesz0YHeM1x5I6B+gNRDkY7huifDvKK/wJx0TRhWcF5gC7yTWbuO5RxXJD5aQ7iAlxwKlDfclHcTM5USej60ELZNhTvBvFPqlJ3XdArgBa7OsWvsKmlwdUzidARA9+xJsoKIixXPEh/xVNsnh67wldyjU77TRwVNVuAh9wAu9SsyE2k4adzPGIx+ApTjVydviYwUtqjfg==;5:ovBjNhcJe6ydd6P0x0EIGxErtk+jdrEVIOMvaQUGt2KuTQWv/m3UPGP3XzfNdUZiJg2qacD6MQP+xPyix4s3W+rHMjeiMtrdHRNpMhjgsq4r5FrqIyO9S7MnAA2cFkzPmomZdpycviWrZesfAw7SHhDi9NL73n8C2B3l83pqpfc=;7:5OXN/r0k78xphCvxnqvu1I8rdQkeUn9frTBKCVzwxKJ4n3b3A2GgbQuWG2yhlYX6z8mg3dbDr/RVvx0GykJ0n9+D6o4bMjo56Vk646/nnvXgJ/cYuLCIQng7FHzmTvHPvUNP8gt3uBftLDLiMp9D8w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a913d28-b44b-41fc-1c66-08d6446995ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5461;
x-ms-traffictypediagnostic: AM6PR04MB5461:
x-microsoft-antispam-prvs: <AM6PR04MB54614708F73EF463131F03A584C40@AM6PR04MB5461.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(180628864354917)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5461;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5461;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(136003)(376002)(396003)(13464003)(199004)(189003)(71200400001)(53936002)(2906002)(7696005)(14454004)(81156014)(81166006)(55016002)(3846002)(4326008)(68736007)(105586002)(9686003)(8676002)(86362001)(76176011)(6116002)(54906003)(316002)(6436002)(8936002)(25786009)(99286004)(478600001)(229853002)(106356001)(2900100001)(11346002)(476003)(446003)(33656002)(186003)(74316002)(486006)(66066001)(6862004)(256004)(5660300001)(102836004)(6506007)(7736002)(97736004)(53546011)(6636002)(71190400001)(305945005)(6246003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5461;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cQOPHQw/dLoSvaZOHpAfxrIXdw3JW1qaLTH4NuUxz5wRmBrqJRE58B4JLy9CMWtLPibO1OdmpHV49GYpSWGdaZAcMH5HrxOvUrAOZ81IA95fVNo/dSuUadX3LHZ3jlUVVTGISOubYIluqmW/HAMhNq2+m/zuaMe0YhC0EDapnVrbLvzVUlSlUeS63CsqAy6SLWTSnznOStGwHHL3AAO54yl07Y5IbpCGZdJK953g7BqqdWEu8giAYeCJPr7lAi2RFLjoR6ZAdA0aA9NvC8x/vDPj8GuGjHD3CnULvveCYl0j7BypIlpgg5THsSZYuSI7CG3GZyBR8kU+kYQ2sei9/N0bmGZLL9efw+2iXaKltfA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a913d28-b44b-41fc-1c66-08d6446995ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 04:29:19.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5461
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTGVvLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWWFuZyA8bGVveWFuZy5saUBueHAuY29tPg0K
PiBTZW50OiAyMDE45bm0MTDmnIgyN+aXpSA0OjU4DQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcu
aG91QG54cC5jb20+DQo+IENjOiBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1Y
QyBBUk0gQVJDSElURUNUVVJFDQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRA0KPiBE
RVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBSb2IgSGVy
cmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgTWFyayBSdXRsYW5kDQo+IDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEJqb3JuIEhlbGdh
YXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBNaW5na2FpDQo+IEh1IDxtaW5na2FpLmh1QG54cC5j
b20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAzLzRdIGR0cy9hcm0vbHMxMDIxYTogQ2xlYW4gUENJZSBjb250cm9sbGVyDQo+IGNv
bXBhdGlibGUgc3RyaW5ncw0KPiANCj4gT24gVGh1LCBPY3QgMjUsIDIwMTggYXQgNDo1MiBBTSBa
LnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+IHdyb3RlOg0KPiANCj4gVGhlIGNvcnJlY3Qg
cHJlZml4IGZvciBhcm0gZHRzIHBhdGNoZXMgc2hvdWxkIGJlOiAiQVJNOiBkdHM6IGxzMTAyMWE6
DQo+IC4uLiIsIGFuZCBpdCBzaG91bGQgYmUgYmV0dGVyIHRvIG1lbnRpb24gdGhlIHN0cmluZyBy
ZW1vdmVkIGluIHRoZSB0aXRsZSB0b28uDQoNCldpbGwgY29ycmVjdCBpdCBpbiB2My4NCg0KPiAN
Cj4gPg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4N
Cj4gPiBSZW1vdmVkIHRoZSB3cm9uZyBjb21wYXRpYmxlIHN0cmluZyAic25wcyxkdy1wY2llIiwg
aW4gY2FzZSBtYXRjaA0KPiA+IGluY29ycmVjdCBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IFYy
Og0KPiA+ICAtIG5vIGNoYW5nZQ0KPiA+DQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEu
ZHRzaSB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAy
MWEuZHRzaQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS5kdHNpIGluZGV4IGJkZDZl
NjZhNzlhZC4uMWFhYTMyODhhNDUwDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvbHMxMDIxYS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS5k
dHNpDQo+ID4gQEAgLTcxNiw3ICs3MTYsNyBAQA0KPiA+ICAgICAgICAgICAgICAgICB9Ow0KPiA+
DQo+ID4gICAgICAgICAgICAgICAgIHBjaWVAMzQwMDAwMCB7DQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHMxMDIxYS1wY2llIiwNCj4gInNucHMsZHctcGNp
ZSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHMxMDIx
YS1wY2llIjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMCAweDAzNDAw
MDAwIDB4MCAweDAwMDEwMDAwDQo+IC8qIGNvbnRyb2xsZXIgcmVnaXN0ZXJzICovDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4NDAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMjAw
MD47DQo+IC8qIGNvbmZpZ3VyYXRpb24gc3BhY2UgKi8NCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICByZWctbmFtZXMgPSAicmVncyIsICJjb25maWciOyBAQCAtNzM5LDcNCj4gKzczOSw3DQo+
ID4gQEANCj4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICBw
Y2llQDM1MDAwMDAgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
ZnNsLGxzMTAyMWEtcGNpZSIsDQo+ICJzbnBzLGR3LXBjaWUiOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGxzMTAyMWEtcGNpZSI7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDB4MDAgMHgwMzUwMDAwMCAweDAgMHgwMDAxMDAwMA0KPiAv
KiBjb250cm9sbGVyIHJlZ2lzdGVycyAqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAweDQ4IDB4MDAwMDAwMDAgMHgwIDB4MDAwMDIwMDA+Ow0KPiAvKiBjb25maWd1cmF0aW9u
IHNwYWNlICovDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gInJlZ3Mi
LCAiY29uZmlnIjsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQoNClRoYW5rcywNClpoaXFpYW5n
DQo=
