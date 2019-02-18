Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72970C10F02
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C42C218D3
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dz05ZSPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfBRHDf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:03:35 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:63568
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728539AbfBRHDd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Feb 2019 02:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3vE5kfdIGSqs/MG84oSIV3vwZA12g7XAba0clmT2cA=;
 b=dz05ZSPCm8QkzIcVVJF3dH1dLxO+nukXP9a3FNtK754q/jk6hc5bb/qe5Q326X+FFW+XS5IQYyC4FdN17bfNVHMG/4MULdtYnfryxyPBYUWyotTD1GpplWCUGIhRFSjaWeuWZJyk8pcU//Ie9g16eLMxZsIu0KNeb4Mm5+ssKPo=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4439.eurprd04.prod.outlook.com (20.177.39.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 18 Feb 2019 07:03:29 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 07:03:29 +0000
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
Subject: RE: [PATCHv3 04/27] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCHv3 04/27] PCI: mobiveil: remove flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHUt6nfsD9iNbAFAUaq30Vq7P8rlKXQwjeAgBR7P1A=
Date:   Mon, 18 Feb 2019 07:03:28 +0000
Message-ID: <AM6PR04MB57819B7666061E9D23D6C44F84630@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-5-Zhiqiang.Hou@nxp.com>
 <CAFZiPx0aiLkVrqVxmyLRcVZJ0G=+60vED4cJOfAo=18DDnOtcA@mail.gmail.com>
In-Reply-To: <CAFZiPx0aiLkVrqVxmyLRcVZJ0G=+60vED4cJOfAo=18DDnOtcA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94255b00-37ae-450c-e316-08d6956f2f93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4439;
x-ms-traffictypediagnostic: AM6PR04MB4439:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NDM5OzIzOmpNNzBiZ1NTUERxZ3BoNHhQRmI1NjZrT2RY?=
 =?utf-8?B?dUd0b29vYUlUNzdCdGRXaTQzc0tTUlM4N0RLc2I1bUxQeUUrbytmRVBLMGVW?=
 =?utf-8?B?NWVEVHpUSnRpZ05PM0ZFVDVxTFVIMHI1ZCt3VlVMRDJZWU10cXJRYTVLN09J?=
 =?utf-8?B?OTlyc1IxcmRHb2tiWVBJRkRJc0d0b3FvbktyQjM3K1A4enYrbjlOU0wzUkZw?=
 =?utf-8?B?TmN3M2FvWVBrQmtjRVhMcUc3VE5hcktQVDJjY2l3aW9PczkrNktqUkwxd0c0?=
 =?utf-8?B?SUhrc1FrbGN0Z3lpWWUrSWc3aTVWaEdFTkZpdW1xNDljMi9waUxaaDdjRWpq?=
 =?utf-8?B?Tm9kbGFQNDdNWitOdklxWHFVMURCOHN4aGFqd3VzQW5rTXo4RVB5LzltM3hy?=
 =?utf-8?B?M3F5emlvVmVCT1cwMjRGRk5DdTh2MmhPOXpSVG51ZmxzVWZSWUtvV3g4Qi9W?=
 =?utf-8?B?K0hOSmpiL1VMQ0tCL1JqVnE3RkhhV211akVpenJTalB4NVZWcy94a1luTHpE?=
 =?utf-8?B?akpwT0lMdzNDdHAzWkRmK0V0MnVEd2kwUjF1V2RuWC8zNXhyaG16bGswdGNE?=
 =?utf-8?B?OHlkd1pWYnQ0cGZQYWdjT0FxWjdCNGJQbEx2c0N6RVRTTkIyajdhdUY2cy9F?=
 =?utf-8?B?VnQyYlNUQmdmaVo5WW9tTWhieHMrdSttbHJtZTNDc2hQWUJoRXc4alJXU3Zr?=
 =?utf-8?B?R245V1AyN0lGUnR6M0tmd0E4d2xxc0xta0xhcFNVWXJXM0pFbEQrclhVdnY3?=
 =?utf-8?B?dHQ3cnZDWk01dnNvNjZxWkgyVk96bWxiWHpqOVNRa21wMFJtRmdXa0hzbEZS?=
 =?utf-8?B?bXNkd3RaaVVvcURCYnh6ek90TmZlRE54bjlTdnFSSmlaUkpYZlJaemNUL1po?=
 =?utf-8?B?THY2YzFRUUlnckdSTFpkdURhVDY0c0JCZW15Y2NxWXdUek12dzVoay96RHMx?=
 =?utf-8?B?M2kyRS9JU2V2V21wYm9sb2lGMU0wQk1lZU81TTN0SncwS2h2Wk41VzU4Vktk?=
 =?utf-8?B?bGlOaE5OQ1lrdFJheVJKOE1nZWRObkdQNFNYdlUyOTFmM1JYWElyOXVQYWxF?=
 =?utf-8?B?aUtIVUQrQU1hYXVKdWtJZmc4YktNUGFLaFVWVDJpVk0vTWRMeEwxdjFaRFJQ?=
 =?utf-8?B?N0J5SllaUEM4ZnhncEQybGFxd0xJT0JLYkpYNUtvY0M3elA1RVI2ZE1kRzd6?=
 =?utf-8?B?cDBOR2ZVdmlqck5MVmEycVMzbUlGeVNmc3RRNEZDcmlSVHh0K3VHZXFNYXlZ?=
 =?utf-8?B?RzJodmt6Sjh6b3lDdkZsQjFIQitFeVRLRk91eFBDZ0JCWUlVVHlWclplRTNO?=
 =?utf-8?B?NUVMSWNUV1Q2NjFaZEcrNjZ0R28vNGVqOVFCWFRzSWJmTmovTENkbW40dzdr?=
 =?utf-8?B?V3F6WVp0SEM2MUpoK1F1SFh1NWF1aTFEUlozbUNVckFZVy9vL2RzUGRjaDFE?=
 =?utf-8?B?RExtOVBaR1JlRldCZVh0QUpua05RN25GZUo0clFDdkhoWlVEanNHNHlYRENQ?=
 =?utf-8?B?SVduejRUY1FXVVh1VlVBWnZ0ZGVBbHlCVHV1RG4vUi8zaVdnektYMXlEQ0tM?=
 =?utf-8?B?WUhGZ2lzR1Q5dmQ5eE9zcGJNVzJmeExiQlNUU1JicWR3UGRObUYvQ0lBdDBW?=
 =?utf-8?B?L2lKb0x3NU9DMERIMWNLSlc1eGZWdjE1d0MyaVUvU0NPS3poelg3YlQ3akFI?=
 =?utf-8?Q?Dm7/g06i4kdOwvm8BnfvqyRrKxSEPxfUWHuZyw0?=
x-microsoft-antispam-prvs: <AM6PR04MB44390AF2142E985F1BBEF91284630@AM6PR04MB4439.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(13464003)(446003)(102836004)(71190400001)(68736007)(26005)(105586002)(86362001)(6506007)(53546011)(71200400001)(186003)(486006)(11346002)(106356001)(76176011)(99286004)(7696005)(476003)(14444005)(256004)(5660300002)(97736004)(55016002)(81166006)(81156014)(8936002)(6916009)(6436002)(53936002)(8676002)(66066001)(229853002)(9686003)(6116002)(3846002)(6246003)(4326008)(74316002)(33656002)(7736002)(316002)(25786009)(7416002)(54906003)(478600001)(305945005)(2906002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4439;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bGU4DFXnCYe+dTj32npEBNoYFwQdUa359XZLrVeANxgdOpA8/CIY0+KRY0N2ufp615e0hLvV4q11zx5zdr4ptH6q5SjHCvgKmCYcdbBVJV3f0R12HoUW4Xuivjzs5kCD1RB5ez5urXdTCzrDp20LkuLkiQD8dzrNWmgmAlc4njZO41hiHED+B+Kl+dUpjhGMZHfXpis4pBRRiThX9znVegkpzcmQtQuZOToXq9MHuApJ1Oaqike9pcZeqv+EJSJggI27FXcvEA7CLO+/zLf6Ip4wq573f8pTmInQYkEBLDJHuYhH6t+n8UWuD94gV3UYrZETFsJQmOOxJjtTCl9ZHZ36XxQolwQL6HOxX6wcs59O1ynWyC+xC9rZGet8ClU49BI8i+REnvl9Hr8AD8zSRzauoMdHz5ezJMx9WxM0Q6Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94255b00-37ae-450c-e316-08d6956f2f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 07:03:29.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4439
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3ViYnUsDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJy
YWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gU2VudDogMjAxOeW5tDLmnIg15pelIDE0OjA1DQo+
IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Ow0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjMgMDQvMjddIFBDSTogbW9i
aXZlaWw6IHJlbW92ZSBmbGFnDQo+IE1TSV9GTEFHX01VTFRJX1BDSV9NU0kNCj4gDQo+IFpoaXFp
YW5nLA0KPiB3aHkgYXJlIHdlIHJlbW92aW5nIG11bHRpLU1TSSBzdXBwb3J0ID8NCj4gd2hhdCBm
dW5jdGlvbmFsaXR5IHRoaXMgZHJpdmVyIGlzIG5vdCBwcm92aWRpbmcgdG8gc3VwcG9ydCBpdCA/
DQoNCkluIHRoZSBmdW5jdGlvbiBtb2JpdmVpbF9pcnFfbXNpX2RvbWFpbl9hbGxvYygpIHRoZXJl
IGlzIGEgY2hlY2sgYWJvdXQgdGhlIG51bWJlciBvZiBJUlFzIHRvIGFsbG9jYXRlOiBXQVJOX09O
KG5yX2lycXMgIT0gMSk7DQpUaGlzIGlzIGEgcGFyYWRveCBhZ2FpbnN0IHRoZSBmbGFnICJNU0lf
RkxBR19NVUxUSV9QQ0lfTVNJIi4NCg0KPiANCj4gVGhhbmtzLg0KPiANCj4gT24gVHVlLCBKYW4g
MjksIDIwMTkgYXQgMTozOCBQTSBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4g
Pg0KPiA+IFRoZSBjdXJyZW50IGNvZGUgZG9lcyBub3Qgc3VwcG9ydCBtdWx0aXBsZSBNU0lzLCBz
byByZW1vdmUgdGhlDQo+ID4gY29ycmVzcG9uZGluZyBmbGFnIGZyb20gdGhlIG1zaV9kb21haW5f
aW5mbyBzdHJ1Y3R1cmUuDQo+ID4NCj4gPiBGaXhlczogMWU5MTNlNTgzMzVmICgiUENJOiBtb2Jp
dmVpbDogQWRkIE1TSSBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcg
PFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaW5naHVhbiBMaWFuIDxN
aW5naHVhbi5MaWFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gVjM6DQo+ID4gIC0gTm8gY2hhbmdl
DQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCAyICst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+IGluZGV4
IDU2MzIxMGU3MzFkMy4uYTBkZDMzN2M2MjE0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiBAQCAtNzAzLDcgKzcwMyw3IEBAIHN0YXRpYyBzdHJ1
Y3QgaXJxX2NoaXAgbW9iaXZlaWxfbXNpX2lycV9jaGlwID0gew0KPiA+DQo+ID4gIHN0YXRpYyBz
dHJ1Y3QgbXNpX2RvbWFpbl9pbmZvIG1vYml2ZWlsX21zaV9kb21haW5faW5mbyA9IHsNCj4gPiAg
ICAgICAgIC5mbGFncyAgPSAoTVNJX0ZMQUdfVVNFX0RFRl9ET01fT1BTIHwNCj4gTVNJX0ZMQUdf
VVNFX0RFRl9DSElQX09QUyB8DQo+ID4gLSAgICAgICAgICAgICAgICAgIE1TSV9GTEFHX01VTFRJ
X1BDSV9NU0kgfCBNU0lfRkxBR19QQ0lfTVNJWCksDQo+ID4gKyAgICAgICAgICAgICAgICAgIE1T
SV9GTEFHX1BDSV9NU0lYKSwNCj4gPiAgICAgICAgIC5jaGlwICAgPSAmbW9iaXZlaWxfbXNpX2ly
cV9jaGlwLA0KPiA+ICB9Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KVGhhbmtzLA0K
WmhpcWlhbmcNCg==
