Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B35DC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0014C218AD
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZxlNoBsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfBRHEV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:04:21 -0500
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:26571
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbfBRHEV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Feb 2019 02:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGDk1pFhillSNsAT7eFYuQX9ON+t7O0N8lTkPmpJyNE=;
 b=ZxlNoBsOG+mzLM7vnApf9SfG/I69Z4j0KFUTd27nZwwQdlc/tdBIOb3z5vmx4hRKCio3C3iXLA0laNfOe8rYXKFbQLU2loaUcSz9n1k2XxZzw36IHxBoeE4l7mSVRnAAaQ8WBAPXJ9bw7VGrg5XmA2Fwho2D+7YwVsdraIJl7KU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4853.eurprd04.prod.outlook.com (20.177.33.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 07:04:15 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 07:04:15 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Topic: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Index: AQHUt6oS419VgGFb5EOSmkHnfUrSZqXV59SAgAjbZcA=
Date:   Mon, 18 Feb 2019 07:04:15 +0000
Message-ID: <AM6PR04MB5781241443F27BD8241097B284630@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
 <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
In-Reply-To: <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c73fae7-bd27-44be-1dd7-08d6956f4afb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4853;
x-ms-traffictypediagnostic: AM6PR04MB4853:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0ODUzOzIzOjZ5Z055Q3U1elBPREFJdHZ1Z0NiMFRNMElH?=
 =?utf-8?B?RE1LcVJKWUt3bjVqeHlvSXFHMkVaaU14RWd2UEQyYmdNUDNTMFhFQ1V3Uk9r?=
 =?utf-8?B?YlVNczN1Mi8rT3NER3U1ZFpzb2syL0JjbmZKbTY0eWJycnNpWXVTNzhmRDFJ?=
 =?utf-8?B?eXNFU3RLR3krSkhsYTNRbjZsUUlTekZKMHA4eCtTMzJrV20ydmFybVhLMWIr?=
 =?utf-8?B?RGxZL2lNOStZUXBDeE9YVGFEd1NLNVFVSkRIcFJVdHpXV1VTSFRHMytLdW1T?=
 =?utf-8?B?SkVYdHhDWlhCbjlqNUVTdDgwdnJnYkhraFIwNG1mT0R0c0U3bW1scjQ2Q1Yy?=
 =?utf-8?B?dGVvREt0UW9OUHZ2UmpyQUV6U2Z2QmxEMUpGNHM1ejcxOG1vcVpyK3JNRldy?=
 =?utf-8?B?Z2J1THNEUGRhZHR0WkNHeHhoTHFOOUFoNXZmQ1ZGWDUyRnBBT3VWRXBDcStn?=
 =?utf-8?B?bWt4SlUrYXZ6a1AvSVk3eFErODI0a3lFcTJ6bjJ2VWFGalVVRFc5ZEdqVHZE?=
 =?utf-8?B?UkE0TmZYNTIzbHR5Ym4vTENkd0l6Wm9yMVJpNUZHdXIwb2ltOTdqbFljc3NI?=
 =?utf-8?B?aFhGYW40cHRKTlNUTTNiRXNVajVNbmdrT0pIWjVnUjRHWU1jNUlsY213TVNu?=
 =?utf-8?B?b3h2U3lSTEVsVDZZdFBMMUhiQ0ZlTU92d1drUXJtMWlyUWNlbnFPR3Y2SkZt?=
 =?utf-8?B?Wm9GcVlzbzU2Zk5SbERaM0gwd24zQlZHbDJzYmxsYUNZSnNsMlNDRVlEWkhN?=
 =?utf-8?B?bWx2bEVmWnpIWHVML0YyMmRuMnphVnhVRGJrWmczemc0enZuckZxRzRBTDlB?=
 =?utf-8?B?WHZ6cEtJaVlGSWIwTG4ramxxUjlRMnhCUEJFdzJPSWg3SS9HSFplaEZDN2hF?=
 =?utf-8?B?MEZsc2NsdjlqdEpzUzlETFVMOFQraUZvQ0JKcVZXRVV4VmJTQ0I1b2htVkg4?=
 =?utf-8?B?cWRXdUdqeW5NU2NuMjY3RHB5Rkp0dDNlOS9JL2Vna3FVZDM2WngxUlkxOWdx?=
 =?utf-8?B?dkY0MFlIdUhHQUpyT3AyWnRPNGFRSFNpOTM4SDZaWlRWQzloaXc5NkdwQjky?=
 =?utf-8?B?OVR5bDNWVDI1WFBoWWVEeFhuczRlRU1qdEUzd0FTTCtsWTY1bCtYZHlsOUtt?=
 =?utf-8?B?THcxVDNpUUFLUkR2MWtLN2JzeTh5TU1PQ1R3SkRNWktZRjJVUk9QYzFEQ2hT?=
 =?utf-8?B?eEErbzBJQ0VZMUVGZVRYaXBoUThoMElEZHdZUmdOa29MbFdpY3BHcFV1dmw2?=
 =?utf-8?B?MTFJQ09EYkliOEx2Tm9WU0svemlKMGNaZkxZMlhVWjBnVHNEWWcwNHlVdmN4?=
 =?utf-8?B?RE1OOW93NFpKbWFGS3BUcHJFc20xSWJBL2R2N3NoTSsrWWNPcUhYUmFscER5?=
 =?utf-8?B?YmFVMTM2SkthQzZBOWxoeVRPdmF4OVRKTmdrVXl5TTVSQkZvQnd4Z3EzVzRI?=
 =?utf-8?B?eHVtM1VnMXdIVHhOakRrcjlqUWJTQituMnFNVzJZZUF2T0FmRHBub085VnIz?=
 =?utf-8?B?a2F3TnYvRWNlNlVOUCs3RXVyZ3ZiMzVlZmJCdW9aaVFKdXdBckZLQ3pEdktQ?=
 =?utf-8?B?eWsxaS96U2FnYkRrQTlSZGxEQm5YZVpaRkxWVHlOS1dvaExzR3hQWjZ6YnU0?=
 =?utf-8?B?WE1nTE5mSUswMDd6MXVKSFRLLzVWQnJqK212d0NCQ2MrSXk4OW9XWk50M25z?=
 =?utf-8?B?MzlBMStQVzMzOTg1UUtEVFprdEFSVGRuSWlXYVIvY2gydkV3aVF0ZXZIV0tZ?=
 =?utf-8?B?MjQrdVNCdDE1NjdnbmN2QT09?=
x-microsoft-antispam-prvs: <AM6PR04MB4853F395481DCCDABA38741E84630@AM6PR04MB4853.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(13464003)(99286004)(54906003)(68736007)(316002)(6436002)(6916009)(6116002)(3846002)(53546011)(6506007)(7696005)(14454004)(76176011)(7416002)(66066001)(71200400001)(71190400001)(229853002)(53936002)(6246003)(25786009)(5660300002)(4326008)(14444005)(5024004)(256004)(2906002)(105586002)(106356001)(186003)(446003)(74316002)(7736002)(305945005)(97736004)(8676002)(26005)(8936002)(81156014)(86362001)(81166006)(33656002)(486006)(478600001)(476003)(11346002)(55016002)(102836004)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4853;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uDFVsxM+47FMdcmACXVnXkRAm0Gj4UDyBRsk/f50hmnJRTDp2jRUtA5ETfptSfOJpSxgw8zVLL4ohwW9XFn5JQfyh/HMf3LE0Gqj8BYPiUbXT7NkescYJM43WFtQX20R2WX5qTSeIbWfI34TdRhFoxx8nNdQnPV6QtgLjua4wlpCQkCDS+maQPoU4ypq6IGqkZZm5npAFZAFlbYOjEXeUI6kBo4gyQzRGStdewrS2P6r83mzMoQDH4JeyemkRR0eXyN1LJiBb9eDncJyLs0qLc9B7ShW5dbwa/+1szxb5hhv6m1f7J3CnW3TMZiIMnAQEQBoj9EFhlxyXx/blhaaM+qjd4ibFCZFnuWzG6gN83/MKvIpJ6niLp5EmLjURPYXIQxFX7GkV9F9FxGGwF7YSbkNNFIkDwarCm9xLbbBEP0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c73fae7-bd27-44be-1dd7-08d6956f4afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 07:04:15.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4853
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3ViYnUsDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJy
YWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gU2VudDogMjAxOeW5tDLmnIg45pelIDIwOjQxDQo+
IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Ow0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjMgMTcvMjddIFBDSTogbW9i
aXZlaWw6IGZpeCB0aGUgY2hlY2tpbmcgb2YgdmFsaWQgZGV2aWNlDQo+IA0KPiBaUSwNCj4gDQo+
IE9uIFR1ZSwgSmFuIDI5LCAyMDE5IGF0IDE6NDAgUE0gWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBu
eHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91
QG54cC5jb20+DQo+ID4NCj4gPiBBdm9pZCB0byBpc3N1ZSBDRkcgdHJhbnNhY3Rpb25zIHRvIGxp
bmsgcGFydG5lciB3aGVuIHRoZSBQQ0llIGxpbmsgaXMNCj4gPiBub3QgdXAuIEFuZCBhbGxvdyBD
RkcgdHJhbnNhY3Rpb25zIHRvIGFsbCBmdW5jdGlvbnMgb2YgRW5kcG9pbnQNCj4gPiBpbXBsZW1l
bnRlZCBtdWx0aXBsZSBmdW5jdGlvbnMuDQo+ID4NCj4gPiBGaXhlczogOWFmNmJjYjExZTEyICgi
UENJOiBtb2JpdmVpbDogQWRkIE1vYml2ZWlsIFBDSWUgSG9zdCBCcmlkZ2UgSVANCj4gPiBkcml2
ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1pbmdodWFuIExpYW4gPE1pbmdodWFuLkxpYW5AbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiBWMzoNCj4gPiAgLSBObyBjaGFuZ2UNCj4gPg0KPiA+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jIHwgNiArKysrKy0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1t
b2JpdmVpbC1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNp
ZS1tb2JpdmVpbC1ob3N0LmMNCj4gPiBpbmRleCBkYzUzMjRkOTQ0NjYuLjFhZTgyZTc5MDU2MiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9i
aXZlaWwtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9w
Y2llLW1vYml2ZWlsLWhvc3QuYw0KPiA+IEBAIC0yOSw2ICsyOSwxMCBAQCBzdGF0aWMgYm9vbCBt
b2JpdmVpbF9wY2llX3ZhbGlkX2RldmljZShzdHJ1Y3QNCj4gPiBwY2lfYnVzICpidXMsIHVuc2ln
bmVkIGludCBkZXZmbikgIHsNCj4gPiAgICAgICAgIHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2ll
ID0gYnVzLT5zeXNkYXRhOw0KPiA+DQo+ID4gKyAgICAgICAvKiBJZiB0aGVyZSBpcyBubyBsaW5r
LCB0aGVuIHRoZXJlIGlzIG5vIGRldmljZSAqLw0KPiA+ICsgICAgICAgaWYgKGJ1cy0+bnVtYmVy
ID4gcGNpZS0+cnAucm9vdF9idXNfbnINCj4gJiYgIW1vYml2ZWlsX3BjaWVfbGlua191cChwY2ll
KSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsNCj4gPiAgICAgICAg
IC8qIE9ubHkgb25lIGRldmljZSBkb3duIG9uIGVhY2ggcm9vdCBwb3J0ICovDQo+ID4gICAgICAg
ICBpZiAoKGJ1cy0+bnVtYmVyID09IHBjaWUtPnJwLnJvb3RfYnVzX25yKSAmJiAoZGV2Zm4gPiAw
KSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+IEBAIC0zNyw3ICs0MSw3
IEBAIHN0YXRpYyBib29sIG1vYml2ZWlsX3BjaWVfdmFsaWRfZGV2aWNlKHN0cnVjdCBwY2lfYnVz
DQo+ICpidXMsIHVuc2lnbmVkIGludCBkZXZmbikNCj4gPiAgICAgICAgICAqIERvIG5vdCByZWFk
IG1vcmUgdGhhbiBvbmUgZGV2aWNlIG9uIHRoZSBidXMgZGlyZWN0bHkNCj4gPiAgICAgICAgICAq
IGF0dGFjaGVkIHRvIFJDDQo+ID4gICAgICAgICAgKi8NCj4gPiAtICAgICAgIGlmICgoYnVzLT5w
cmltYXJ5ID09IHBjaWUtPnJwLnJvb3RfYnVzX25yKSAmJiAoZGV2Zm4gPiAwKSkNCj4gPiArICAg
ICAgIGlmICgoYnVzLT5wcmltYXJ5ID09IHBjaWUtPnJwLnJvb3RfYnVzX25yKSAmJiAoUENJX1NM
T1QoZGV2Zm4pDQo+ID4gKyA+IDApKQ0KPiBoZXJlIGNoYW5nZSAicHJpbWFyeSIgdG8gIm51bWJl
ciIsIGFzIGl0J3MgYSBidWcgaW4gdGhlIG9yaWdpbmFsIGRyaXZlciB0b28uDQoNCk5vLCBJIHRo
aW5rIGl0IHNob3VsZCBub3QgY2hhbmdlIHRvICJudW1iZXIiLCBhcyB0aGlzIGlzIHRvIGNoZWNr
IHRoZSBFUCBkaXJlY3RseSBhdHRhY2hlZCB0byBSQywgc28gaWYgd2UgY2hhbmdlIGl0IHRvICJi
dXMtPm51bWJlciIsIHRoZSAicGNpZS0+cnAucm9vdF9idXNfbnIiIHNob3VsZCBiZSBjaGFuZ2Vk
IHRvICJwY2llLT5ycC5yb290X2J1c19uciArMSIgY29ycmVzcG9uZGluZ2x5Lg0KDQo+IA0KPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiAgICAgICAgIHJldHVybiB0
cnVlOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==
