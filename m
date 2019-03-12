Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A7C43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 03:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B630C20842
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 03:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FMeZQkVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfCLDRJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:17:09 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:13824
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbfCLDRJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 23:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXamlMobhv/K66uPpe6di/fEu3011kDOdwB9ZWecZUM=;
 b=FMeZQkVaS7eA2Ph98uA5CPdZffCpL8Za2YpCI9eKEdGypbYMo1294Z4+3jiVTfYpmGp9kQujmq0uGSLPCo5K75a3RbqdcnwggE0uM/Jw687f7iRXuM3HKcxprjKQR4NwUJILw8Gajq1MnD8NmYJsUK1K4i0qFqUgUvvB4Y+67hQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4869.eurprd04.prod.outlook.com (20.177.34.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 03:17:03 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 03:17:03 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv4 23/28] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4  controller
Thread-Topic: [PATCHv4 23/28] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4  controller
Thread-Index: AQHU2FdqnfXZfmLJD0yOCJR0F7GmX6YHUcfg
Date:   Tue, 12 Mar 2019 03:17:03 +0000
Message-ID: <AM6PR04MB5781CBCE876031C73D0A4E3B84490@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-24-Zhiqiang.Hou@nxp.com> <20190311221142.GA11898@bogus>
In-Reply-To: <20190311221142.GA11898@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [120.244.120.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d61ab8d5-5b53-4779-5807-08d6a69932f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4869;
x-ms-traffictypediagnostic: AM6PR04MB4869:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0TUI0ODY5OzIzOmFGc1JxbHVINUE2bXpZcXZKQWZuSytiMDBQ?=
 =?gb2312?B?bDc5SzFuRFBUWVdIZElROGwxdWlWZzVtZWxzQzhFU2M5Z0VLaDFMOFZSNDBm?=
 =?gb2312?B?b0puZnpraFJHbjlxTGovdVhjNmVTVThOcEZMd3YvYWhGUG5Gd1cvZG5zQVlh?=
 =?gb2312?B?dkFTbXdWRTRHN3hYOVZGWm1PRW1FOWZnWTQ3d0lpb0RQeUlHVkxaLzBjYmlJ?=
 =?gb2312?B?b0pYM3lHR1JBVXh0RWF5cHJMTFo1WDVkenlVdy8zaGgzNVJjVHJuMjBBNDNP?=
 =?gb2312?B?Mkpjd0k4OHRxOVVpbGdVU1dKTzlwVjZkMlNYNHJKbWJyQThRSmJBblpRREs3?=
 =?gb2312?B?cHhkZ21PRzJoWllsM0pPN0J0eEYrME5wWng1VVhlSDNycGJxamlOcTVTT3Jl?=
 =?gb2312?B?QkhzRnZwRjlKVHJUK2o5cFI1RVlORXBVSzVCb3ovNXB4NlVsVU1iV0UxK1Nz?=
 =?gb2312?B?RzIxdlRBL0xrbTdULytrc1ljZFpob0p6RXlUeEFhRmlFeVhEcEdqNm5CT2Zj?=
 =?gb2312?B?VTV5ZHVsVldkSHgrQVNiTVhmMGlIWmNrK0NjOEhydWJMajBQTDh4UXltajl6?=
 =?gb2312?B?RnpaOE5qOVcwVkd2RHdhUzFxZjJUb0tuMDZmL1JiV3BFaVJadlpVY3ZmMzVV?=
 =?gb2312?B?L0pkWWZhTE93VXB4RU84ZGtTay85aWFkeGhHeG00cTZxOFJFeUhiSzlDalpo?=
 =?gb2312?B?ZUdmOXdHbUVTM0ZualFiNVpxZ2hQcURKaUlFWTVRbmk2QlBxQVhib2ZGVW1u?=
 =?gb2312?B?Ui9hZnR5blQ1bVVtVVVzRzJlYmxPMjlEcjNmM1gzalU4MDBoMktQQ1VNNEJw?=
 =?gb2312?B?NXptUXJkenNGc3lyeFRuSEp2N1ZJSGJzN2NsdEtWSEhpeEJzOFgwdVZ2YmxJ?=
 =?gb2312?B?MmdGRUM3d1BWRlNDYlhJSGloTFN2SWpxVFM3T2VpUEFtUDRSZVJSeWVlcEJl?=
 =?gb2312?B?SjFkVDlwK0VTeFlYV1VSTkloM1hseUZ4TW14MmFsOGtIcjg4NzZSd1hJdDFj?=
 =?gb2312?B?NG1OYklrKzczUkQrVEY5YlpBZWxzWCtEZTFOVnluYkk4MkpybGNGNG1mUFN5?=
 =?gb2312?B?NG5FeWJHSTk5R0NzMytWVnRhU2ZvUmVCRU5YaStway9EMWMxMnhvUDdsMGMy?=
 =?gb2312?B?cm5EbksxNkxBSHd0Y05ZQU1oRTZsMytUcVFyT2F3YzYxUU9yZFQvZi92aUdC?=
 =?gb2312?B?S1NOZ2hnSUVhbk5ISGlQdU83MzNEZE5SNmdSb1hkR29HTjdpWEZucDh4NGdo?=
 =?gb2312?B?U2lxcC9nYWZqb0VJZDV3NlB3VHo3WWkrVE90MlRTUTRibUtsaFNyZURFQWNo?=
 =?gb2312?B?a1Y5bUgydmgxOVdvNHdzSjdwSjlSRW80eEtNMTRrRytkbWlZME12VlhQZ0NM?=
 =?gb2312?B?ckhVU3Y0Z1l5SFVyUUpKQzlRTnpOdlVWYSs3ZmtCcU0zTmc4d1FJanVJOVFw?=
 =?gb2312?B?V2JmYjY5YkFjMnJ6NnBaeVFXbHRVSGpiT1dMVkE0YjRJTFpsUzBtRnVpbi9L?=
 =?gb2312?B?WHB0dkdEZkR6ZlNRQVRkVUJoTHpYWURYOWt2V25YanhpQXU4dURpSnd0dGda?=
 =?gb2312?B?Mm5YNGdOTVhXR1JieFgvK05LK0Z0OE9RZFBhZkVwTUxGM3dHcExwVC9HMEpk?=
 =?gb2312?B?RWdWOFFpZ2xLdVNmeG9NQ1pXaUhZWlUyQ3dvOVpZdDlONUVTeitpK1lmSXQ5?=
 =?gb2312?B?T3pNaFlwSDZ6Z2R1ZjJCQjlvT3luME8wRVU4bDJXNkVqM2E0dCs5NCtJVlRO?=
 =?gb2312?Q?crnhSk3JEsEJWZNQPhmm5cM6xc02mgLPAOhds=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB486917ACA9DAB2FC97A194BC84490@AM6PR04MB4869.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(13464003)(199004)(68736007)(186003)(99286004)(66066001)(256004)(7696005)(6436002)(478600001)(6246003)(55016002)(54906003)(316002)(105586002)(33656002)(9686003)(8676002)(74316002)(476003)(71200400001)(53936002)(71190400001)(81166006)(26005)(81156014)(6116002)(8936002)(14454004)(6916009)(486006)(11346002)(52536013)(7736002)(102836004)(6346003)(3846002)(76176011)(2906002)(4326008)(305945005)(229853002)(53546011)(97736004)(6506007)(25786009)(446003)(86362001)(5660300002)(106356001)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4869;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y6BhQxI0MHytpFuryEJlcLZSDjwON8jw344CDfYDQzWfMex3ILl1vABAzgx3Sa3h4Qvdp4oi1ZaPHdOjSV8PbQ9NE5bRn8wM6Wgo0o6ccgUm/pEF6H4S7GTqajBS9ftYxR50KWOfDyGCMVPUC7/Jf7HW512C/RDBAAYir+XWBLJLHtGj35463eDnStE4KV9Wcm9/zWqNXkU/oKoS7RtJVHgTe57QZmTryJ5jCBUvY5aX0G7B2XDrSV0mtxUplY9eGF5GJqL7LpWCqK8FkfDLwLMQXNaKxllZVYI0JBmzZwDSNRNnTKmtWc73F1Y8aBgE4X5mNMHWrAzsg6aVfcxnt7jigLRs3FtgjziWAwvnPl87c1lBKXilo6sXwreWUse+VwIUhA4nk5Zp/97EuuiVxzkiaL5G8MTRTTScSpiCipU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61ab8d5-5b53-4779-5807-08d6a69932f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 03:17:03.4036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4869
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJy
aW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE5xOoz1MIxMsjVIDY6MTIN
Cj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5k
QGFybS5jb207DQo+IGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW47IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IExlbyBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgbG9yZW56by5waWVyYWxpc2lA
YXJtLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207
IE1pbmdrYWkgSHUNCj4gPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbiA8bWluZ2h1YW4u
bGlhbkBueHAuY29tPjsgWGlhb3dlaSBCYW8NCj4gPHhpYW93ZWkuYmFvQG54cC5jb20+OyBaLnEu
IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NCAyMy8y
OF0gZHQtYmluZGluZ3M6IHBjaTogQWRkIE5YUCBMYXllcnNjYXBlIFNvQ3MgUENJZQ0KPiBHZW40
IGNvbnRyb2xsZXINCj4gDQo+IE9uIE1vbiwgMTEgTWFyIDIwMTkgMDk6MzM6MDUgKzAwMDAsICJa
LnEuIEhvdSIgd3JvdGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhw
LmNvbT4NCj4gPg0KPiA+IEFkZCBQQ0llIEdlbjQgY29udHJvbGxlciBEVCBiaW5kaW5ncyBvZiBO
WFAgTGF5ZXJzY2FwZSBTb0NzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5n
IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBWNDoNCj4gPiAgLSBubyBjaGFu
Z2UNCj4gPg0KPiA+ICAuLi4vYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdlbjQudHh0ICAg
ICAgfCA1Mg0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDYwIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaS1nZW40LnR4dA0KPiA+
DQo+IA0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5n
IG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4gdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRj
aGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdp
bGwgZG8gdGhhdCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0K
PiANCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5
IGFuZCB3aGF0IGNoYW5nZWQuDQoNClNvcnJ5LCBJIG1pc3NlZCB5b3VyIFJldmlld2VkLWJ5IHRh
ZyBpbiB0aGlzIHBhdGNoLCB3aWxsIHJlLXNlbmQgdGhpcyBwYXRjaCBhZGRpbmcgdGhlIGxvc3Qg
dGFnLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
