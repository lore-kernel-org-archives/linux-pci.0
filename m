Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C42AC43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0E82171F
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OnbWj24M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfCMOv0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:51:26 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:64742
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfCMOvY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 10:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl/XGSPg25lOckPzw69botyyZLDzbWl6Kfykpc5SFok=;
 b=OnbWj24MkkUi8Cf0JhjvJBeCRxpTDzVIchZQhmHMgw8a9pJUROnjqrvulj8R0lgNh5QZ2Q3O95kzt1H6Y/UZrtMdxAg6MRMUfvfx3S2SkCsJLBQjPTdCKjCvq3Vd2X19+VA/pO4/bXRtnnHTAgm2VO39Xjf8+r9poYkguTkL6hU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4869.eurprd04.prod.outlook.com (20.177.34.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 14:51:19 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 14:51:19 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv4 25/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Topic: [PATCHv4 25/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Thread-Index: AQHU1+14+TCeS3tabUCUvLQeJSezBKYJp9Jw
Date:   Wed, 13 Mar 2019 14:51:19 +0000
Message-ID: <AM6PR04MB5781514DF1025990FEAFC126844A0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-26-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-26-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [120.244.120.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6389a87-8e9e-4914-66c6-08d6a7c35a89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4869;
x-ms-traffictypediagnostic: AM6PR04MB4869:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0TUI0ODY5OzIzOjRIL0l4WkpJTTNtZ3NJT1ZwYkUxbllML3R6?=
 =?gb2312?B?UHNvME5uNEVobEQ3MEFzZHErdERKa0xHeHphSGxlUDQyREFJdTRpZVVwdDVG?=
 =?gb2312?B?SCt5QTlxakp1QmpUZ29ZSHJ0WEE0N3JtbmhraWQzbm5wcnYxaXFvL2UwUHdR?=
 =?gb2312?B?RHVyb1dNdEFjNC9HUGZMdVA0VXkzeUFtOHlqYXlpeFRKS09xcGtRTHA1R2NH?=
 =?gb2312?B?WHJKdTNSdWRLMTFOYThwbkZQaGF2TURJRTV1N3RHVEtDaUQwOVpOTEdGZFdC?=
 =?gb2312?B?ZnhSSjRyNml0aGNpc2ovd3RmK0t6K3dzRnZuSjhvTjdPU3Y5b1hpVkZJRDhE?=
 =?gb2312?B?bUpWR2hYOVlBcjJZd25ZSDlzci9kY3dSdFlLUU93dFhybHlZUlhBM3hLK3oz?=
 =?gb2312?B?UmhicDNYcWw1dWh3SmRKcWZadE9jTE5WWmdwOXlPc1RvYXAzZHloSHJWQXhQ?=
 =?gb2312?B?VDlpRTNSN1NWaHpqT0NsT0g5QnVQajdpclltazlaVk1PUy9VYmlKM3VlSXYz?=
 =?gb2312?B?Q3hPN0VCTDBxSHNMTWFlbUtRUERFOXFRcUVpbUNCdUdjY3F2S3dPTWo0Uk1z?=
 =?gb2312?B?aUV3dmZSYW9mcHlTMVJmM2xmT1NsL3kza09NMlRBNHRkM0ZDdUdZNW1Ha01D?=
 =?gb2312?B?d2ozZlRPUWEyZkpVZThKek5taWxHNTArM3pTVHd1dmRuOXJBSEpCK3ZvUmFT?=
 =?gb2312?B?enRsZHo0cnlTUTdFRFZKQXJ2OWxjWElianExUzNPL281alpZZUZSRzdYT2E4?=
 =?gb2312?B?dlBiMWRuOFRCV1ZWMndSaloyYjhVVDhIY0Y3a0FqTVU1NFp0MWJERVhZeVpv?=
 =?gb2312?B?cXlXYVpTUlRwdEZsNVE5UnBmV2VKcy9BZm81MkYrRHF6NHpPanJMU00rL0Qz?=
 =?gb2312?B?SGV2SUdmR0QraVhTbk1JMVFuUVJVRDBMUVZoTWxrWm5XYW1hcGNEb3Nka21n?=
 =?gb2312?B?Y2RrZzFWSVNUbEFveHFZL05CVlNVRkREb1YzelZHNUMzKzBNMDBISGZBOFRF?=
 =?gb2312?B?eWh5bGFoVDZhYVZZY2p5TTAzTG13NjFQOFd0cXA2UzkrZWdUQ1pyZ0pqWmM5?=
 =?gb2312?B?a21aWlhTRTd6b0RYOC9PbDFlZmdOMkVhMVk2bTF6aUZXcVNwdE1mNUI0YWp1?=
 =?gb2312?B?YjZ4dzJsQW8vWXdWQW1KZWQ1VlJTdnh1MTlUVEJOQXVyYUIyOENYazJhZFVI?=
 =?gb2312?B?RWtGeTJ1R2loc1hKeWI4OVBxNjNXak9GOVFhaUNubGp5WWxkTm10aFk3dTht?=
 =?gb2312?B?MHhSR2RSbU0yOHlac0VjSS83VERwcy9CQ0RYLzZLdTZxdGloWnVsS3ZRUDlL?=
 =?gb2312?B?L3VhN1FVQnk5N3FqdDlzZTlBM2o5alhDUVlwU1I4bUNDYUFZQW1FdXQxZlFW?=
 =?gb2312?B?VEZBck5xazA4SXZPSllETDlML2h3UXUvTHRTREtlclVpMURyZXQ5dStFS202?=
 =?gb2312?B?SVppSFBIQ0wxNTBYeS84K3h5TGpTOExhOE0vZ0owbm9CME9JakFrVUx1V2Fw?=
 =?gb2312?B?RXladXBlbDZFNGdLZmFtcWYveElwNnR6NC9qSUNLbmNTSmkxQW5yRlBlam1S?=
 =?gb2312?B?RDBSbm82MWNBbUxlZWp4bUZCL0ExZ1RyemNkdmo1L2dhMjVYN1Z5dlpkUDRu?=
 =?gb2312?B?T1NiMEQvU0pFN1l2TnpqZmEvS2NJNVRyRjl1VlFaTkM4dVV1VlgxSVQ3Wm14?=
 =?gb2312?B?dUFxaHhTUTFKMWRBSFpVZjBFTkhHMUNYNUNydlZwRGhldm1uYXJyODltcXVF?=
 =?gb2312?B?Y01xTE93bzNFNDdGeTU4dzhsN0pyaXkxMy9TcUJ4NlhhV2czbVkrOTZudEcv?=
 =?gb2312?B?eDI5N2prRElseXBudEF3cGg0VjkxQUwwZUNJTGVqT1JPazNYZ0ZtV012WjBP?=
 =?gb2312?Q?Iynw6ba1SYi+u6lXVsdLY4+bL928mhVi?=
x-microsoft-antispam-prvs: <AM6PR04MB4869DE9503EBF1192DD9EEFB844A0@AM6PR04MB4869.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(189003)(13464003)(53754006)(199004)(186003)(68736007)(7416002)(99286004)(66066001)(7696005)(14444005)(478600001)(6436002)(6246003)(54906003)(55016002)(316002)(110136005)(9686003)(33656002)(105586002)(8676002)(74316002)(71200400001)(476003)(71190400001)(2501003)(53936002)(81166006)(26005)(81156014)(6116002)(8936002)(14454004)(256004)(11346002)(486006)(7736002)(52536013)(3846002)(4326008)(76176011)(2906002)(2201001)(305945005)(229853002)(53546011)(97736004)(6506007)(5660300002)(86362001)(446003)(102836004)(6346003)(25786009)(106356001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4869;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3PHRp78rNAORYP3AlyzhQ1vMkGI/NJocCDsqrfpW8xSa0BOnYvEbNAtJ91dbe23vGlwDtGsra82jpyfwMisACSqmH94QDj3IIuP4Cw4V/7ON91IObGiWCAjsJmQNyX5FOWt0RFKqplfiO7aFvqenF7vCwThF5atUZoT4B4hmNqsgO3Uu3jgNlIdhCdgIU9hqND5W2Fbx3FIfFOVL4f6Djhd0vWhYXDHFfpxtD9y0ls5eCHuhX3hpfKOWnSrSDdicXUjUSsaoXf7/nj0xgQGmrrWtit/ChJ1TbpG2Gf/E2bdIypTpwBTOyMVhC20crXE7V+WwJ1o1465nxE05dRkW7fXuu3f+juYWlYVor7ZU821y2C28gyHpsvFTm2ttjjzKx9obI6cEylsEuYSidfPvw+pIMEcDxAINbQI4po20l7w=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6389a87-8e9e-4914-66c6-08d6a7c35a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 14:51:19.7588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4869
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWxsLA0KDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIHJldjEuMCB3aWxsIG5vdCBiZSBw
cm9kdWN0aW9uLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IFoucS4gSG91DQo+IFNlbnQ6IDIwMTnE6jPUwjExyNUgMTc6MzMNCj4g
VG86IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9y
ZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW47
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgbG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwu
ZGVhY29uQGFybS5jb20NCj4gQ2M6IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0u
aC4gTGlhbg0KPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgWGlhb3dlaSBCYW8gPHhpYW93ZWku
YmFvQG54cC5jb20+OyBaLnEuIEhvdQ0KPiA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSHY0IDI1LzI4XSBQQ0k6IG1vYml2ZWlsOiBsc19wY2llX2c0OiBhZGQgV29ya2Fy
b3VuZCBmb3INCj4gQS0wMTE1NzcNCj4gDQo+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcu
SG91QG54cC5jb20+DQo+IA0KPiBQQ0llIGNvbmZpZ3VyYXRpb24gYWNjZXNzIHRvIG5vbi1leGlz
dGVudCBmdW5jdGlvbiB0cmlnZ2VyZWQgU0VSUk9SIGludGVycnVwdA0KPiBleGNlcHRpb24uDQo+
IA0KPiBXb3JrYXJvdW5kOg0KPiBEaXNhYmxlIGVycm9yIHJlcG9ydGluZyBvbiBBWEkgYnVzIGR1
cmluZyB0aGUgVmVuZG9yIElEIHJlYWQgdHJhbnNhY3Rpb25zIGluDQo+IGVudW1lcmF0aW9uLg0K
PiANCj4gVGhpcyBFUlJBVEEgaXMgb25seSBmb3IgTFgyMTYwQSBSZXYxLjAsIGFuZCBpdCB3aWxs
IGJlIGZpeGVkIGluIFJldjIuMC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8
WmhpcWlhbmcuSG91QG54cC5jb20+DQo+IC0tLQ0KPiBWNDoNCj4gIC0gbm8gY2hhbmdlDQo+IA0K
PiAgLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jIHwgMzcNCj4g
KysrKysrKysrKysrKysrKysrKyAgLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVp
bC1ob3N0LmMgIHwgMTcNCj4gKysrKysrKystDQo+ICAuLi4vcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvcGNpZS1tb2JpdmVpbC5oICAgfCAgMyArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCj4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYw0KPiBpbmRleCAxNzRj
YmNhYzQwNTkuLmQyYzVkYmJkNWUzYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCj4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCj4gQEAgLTIyLDggKzIy
LDEzIEBADQo+IA0KPiAgI2luY2x1ZGUgInBjaWUtbW9iaXZlaWwuaCINCj4gDQo+ICsjZGVmaW5l
IFJFVl8xXzAJCQkJKDB4MTApDQo+ICsNCj4gIC8qIExVVCBhbmQgUEYgY29udHJvbCByZWdpc3Rl
cnMgKi8NCj4gICNkZWZpbmUgUENJRV9MVVRfT0ZGCQkJKDB4ODAwMDApDQo+ICsjZGVmaW5lIFBD
SUVfTFVUX0dDUgkJCSgweDI4KQ0KPiArI2RlZmluZSBQQ0lFX0xVVF9HQ1JfUlJFCQkoMCkNCj4g
Kw0KPiAgI2RlZmluZSBQQ0lFX1BGX09GRgkJCSgweGMwMDAwKQ0KPiAgI2RlZmluZSBQQ0lFX1BG
X0lOVF9TVEFUCQkoMHgxOCkNCj4gICNkZWZpbmUgUEZfSU5UX1NUQVRfUEFCUlNUCQkoMzEpDQo+
IEBAIC00MSw2ICs0Niw3IEBAIHN0cnVjdCBsc19wY2llX2c0IHsNCj4gIAlzdHJ1Y3QgbW9iaXZl
aWxfcGNpZSAqcGNpOw0KPiAgCXN0cnVjdCBkZWxheWVkX3dvcmsgZHdvcms7DQo+ICAJaW50IGly
cTsNCj4gKwl1OCByZXY7DQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBpbmxpbmUgdTMyIGxzX3BjaWVf
ZzRfbHV0X3JlYWRsKHN0cnVjdCBsc19wY2llX2c0ICpwY2llLCB1MzIgb2ZmKSBAQA0KPiAtNzYs
NiArODIsMTUgQEAgc3RhdGljIGJvb2wgbHNfcGNpZV9nNF9pc19icmlkZ2Uoc3RydWN0IGxzX3Bj
aWVfZzQgKnBjaWUpDQo+ICAJcmV0dXJuIGhlYWRlcl90eXBlID09IFBDSV9IRUFERVJfVFlQRV9C
UklER0U7ICB9DQo+IA0KPiArc3RhdGljIGludCBsc19wY2llX2c0X2hvc3RfaW5pdChzdHJ1Y3Qg
bW9iaXZlaWxfcGNpZSAqcGNpKSB7DQo+ICsJc3RydWN0IGxzX3BjaWVfZzQgKnBjaWUgPSB0b19s
c19wY2llX2c0KHBjaSk7DQo+ICsNCj4gKwlwY2llLT5yZXYgPSBjc3JfcmVhZGIocGNpLCBQQ0lf
UkVWSVNJT05fSUQpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBp
bnQgbHNfcGNpZV9nNF9saW5rX3VwKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2kpICB7DQo+ICAJ
c3RydWN0IGxzX3BjaWVfZzQgKnBjaWUgPSB0b19sc19wY2llX2c0KHBjaSk7IEBAIC0xODgsMTIg
KzIwMywzNCBAQA0KPiBzdGF0aWMgdm9pZCBsc19wY2llX2c0X3Jlc2V0KHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykNCj4gIAlsc19wY2llX2c0X3JlaW5pdF9odyhwY2llKTsNCj4gIH0NCj4gDQo+
ICtzdGF0aWMgaW50IGxzX3BjaWVfZzRfcmVhZF9vdGhlcl9jb25mKHN0cnVjdCBwY2lfYnVzICpi
dXMsIHVuc2lnbmVkIGludA0KPiBkZXZmbiwNCj4gKwkJCQkgICBpbnQgd2hlcmUsIGludCBzaXpl
LCB1MzIgKnZhbCkNCj4gK3sNCj4gKwlzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpID0gYnVzLT5z
eXNkYXRhOw0KPiArCXN0cnVjdCBsc19wY2llX2c0ICpwY2llID0gdG9fbHNfcGNpZV9nNChwY2kp
Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlpZiAocGNpZS0+cmV2ID09IFJFVl8xXzAgJiYgd2hl
cmUgPT0gUENJX1ZFTkRPUl9JRCkNCj4gKwkJbHNfcGNpZV9nNF9sdXRfd3JpdGVsKHBjaWUsIFBD
SUVfTFVUX0dDUiwNCj4gKwkJCQkgICAgICAwIDw8IFBDSUVfTFVUX0dDUl9SUkUpOw0KPiArDQo+
ICsJcmV0ID0gcGNpX2dlbmVyaWNfY29uZmlnX3JlYWQoYnVzLCBkZXZmbiwgd2hlcmUsIHNpemUs
IHZhbCk7DQo+ICsNCj4gKwlpZiAocGNpZS0+cmV2ID09IFJFVl8xXzAgJiYgd2hlcmUgPT0gUENJ
X1ZFTkRPUl9JRCkNCj4gKwkJbHNfcGNpZV9nNF9sdXRfd3JpdGVsKHBjaWUsIFBDSUVfTFVUX0dD
UiwNCj4gKwkJCQkgICAgICAxIDw8IFBDSUVfTFVUX0dDUl9SUkUpOw0KPiArDQo+ICsJcmV0dXJu
IHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBtb2JpdmVpbF9ycF9vcHMgbHNfcGNp
ZV9nNF9ycF9vcHMgPSB7DQo+ICAJLmludGVycnVwdF9pbml0ID0gbHNfcGNpZV9nNF9pbnRlcnJ1
cHRfaW5pdCwNCj4gKwkucmVhZF9vdGhlcl9jb25mID0gbHNfcGNpZV9nNF9yZWFkX290aGVyX2Nv
bmYsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW9iaXZlaWxfcGFiX29wcyBs
c19wY2llX2c0X3BhYl9vcHMgPSB7DQo+ICAJLmxpbmtfdXAgPSBsc19wY2llX2c0X2xpbmtfdXAs
DQo+ICsJLmhvc3RfaW5pdCA9IGxzX3BjaWVfZzRfaG9zdF9pbml0LA0KPiAgfTsNCj4gDQo+ICBz
dGF0aWMgaW50IF9faW5pdCBsc19wY2llX2c0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpIGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3Bj
aWUtbW9iaXZlaWwtaG9zdC5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9w
Y2llLW1vYml2ZWlsLWhvc3QuYw0KPiBpbmRleCBlOGQwYzQ5ODkwMTMuLjVmNTFiYzJkZDZkNyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2
ZWlsLWhvc3QuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUt
bW9iaXZlaWwtaG9zdC5jDQo+IEBAIC03OSw5ICs3OSwyMCBAQCBzdGF0aWMgdm9pZCBfX2lvbWVt
ICptb2JpdmVpbF9wY2llX21hcF9idXMoc3RydWN0DQo+IHBjaV9idXMgKmJ1cywNCj4gIAlyZXR1
cm4gcGNpZS0+cnAuY29uZmlnX2F4aV9zbGF2ZV9iYXNlICsgd2hlcmU7ICB9DQo+IA0KPiArc3Rh
dGljIGludCBtb2JpdmVpbF9wY2llX2NvbmZpZ19yZWFkKHN0cnVjdCBwY2lfYnVzICpidXMsIHVu
c2lnbmVkIGludCBkZXZmbiwNCj4gKwkJCQkgICAgIGludCB3aGVyZSwgaW50IHNpemUsIHUzMiAq
dmFsKSB7DQo+ICsJc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUgPSBidXMtPnN5c2RhdGE7DQo+
ICsJc3RydWN0IHJvb3RfcG9ydCAqcnAgPSAmcGNpZS0+cnA7DQo+ICsNCj4gKwlpZiAoYnVzLT5u
dW1iZXIgPiBycC0+cm9vdF9idXNfbnIgJiYgcnAtPm9wcy0+cmVhZF9vdGhlcl9jb25mKQ0KPiAr
CQlyZXR1cm4gcnAtPm9wcy0+cmVhZF9vdGhlcl9jb25mKGJ1cywgZGV2Zm4sIHdoZXJlLCBzaXpl
LCB2YWwpOw0KPiArDQo+ICsJcmV0dXJuIHBjaV9nZW5lcmljX2NvbmZpZ19yZWFkKGJ1cywgZGV2
Zm4sIHdoZXJlLCBzaXplLCB2YWwpOyB9DQo+ICBzdGF0aWMgc3RydWN0IHBjaV9vcHMgbW9iaXZl
aWxfcGNpZV9vcHMgPSB7DQo+ICAJLm1hcF9idXMgPSBtb2JpdmVpbF9wY2llX21hcF9idXMsDQo+
IC0JLnJlYWQgPSBwY2lfZ2VuZXJpY19jb25maWdfcmVhZCwNCj4gKwkucmVhZCA9IG1vYml2ZWls
X3BjaWVfY29uZmlnX3JlYWQsDQo+ICAJLndyaXRlID0gcGNpX2dlbmVyaWNfY29uZmlnX3dyaXRl
LA0KPiAgfTsNCj4gDQo+IEBAIC0zMDksNiArMzIwLDEwIEBAIGludCBtb2JpdmVpbF9ob3N0X2lu
aXQoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUsDQo+IGJvb2wgcmVpbml0KQ0KPiAgCXZhbHVl
IHw9IChQQ0lfQ0xBU1NfQlJJREdFX1BDSSA8PCAxNik7DQo+ICAJY3NyX3dyaXRlbChwY2llLCB2
YWx1ZSwgUEFCX0lOVFBfQVhJX1BJT19DTEFTUyk7DQo+IA0KPiArCS8qIFBsYXRmb3JtIHNwZWNp
ZmljIGhvc3QgaW5pdCAqLw0KPiArCWlmIChwY2llLT5vcHMtPmhvc3RfaW5pdCkNCj4gKwkJcmV0
dXJuIHBjaWUtPm9wcy0+aG9zdF9pbml0KHBjaWUpOw0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICB9
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ll
LW1vYml2ZWlsLmgNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9i
aXZlaWwuaA0KPiBpbmRleCAwY2NkNmNlZTVmOGYuLmFiNDNkZTVlNGIyYiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gQEAg
LTE0NSw2ICsxNDUsOCBAQCBzdHJ1Y3QgbW9iaXZlaWxfbXNpIHsJCQkvKiBNU0kgaW5mb3JtYXRp
b24NCj4gKi8NCj4gDQo+ICBzdHJ1Y3QgbW9iaXZlaWxfcnBfb3BzIHsNCj4gIAlpbnQgKCppbnRl
cnJ1cHRfaW5pdCkoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpOw0KPiArCWludCAoKnJlYWRf
b3RoZXJfY29uZikoc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuLA0KPiAr
CQkJICAgICAgIGludCB3aGVyZSwgaW50IHNpemUsIHUzMiAqdmFsKTsNCj4gIH07DQo+IA0KPiAg
c3RydWN0IHJvb3RfcG9ydCB7DQo+IEBAIC0xNjAsNiArMTYyLDcgQEAgc3RydWN0IHJvb3RfcG9y
dCB7DQo+IA0KPiAgc3RydWN0IG1vYml2ZWlsX3BhYl9vcHMgew0KPiAgCWludCAoKmxpbmtfdXAp
KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKTsNCj4gKwlpbnQgKCpob3N0X2luaXQpKHN0cnVj
dCBtb2JpdmVpbF9wY2llICpwY2llKTsNCj4gIH07DQo+IA0KPiAgc3RydWN0IG1vYml2ZWlsX3Bj
aWUgew0KPiAtLQ0KPiAyLjE3LjENCg0K
