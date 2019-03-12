Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF17EC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5C22173C
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AOh2ERQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfCLJSE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:18:04 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:13553
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfCLJSE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 05:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCJ5f+eARLq07wGsHsmlmV68/8VsmtWq7gxZyFaT3vE=;
 b=AOh2ERQqMwhmgOdD1dfWIJTPd9vEN+CBz9WtoAktOBIzywb+3tVVaN6l44hylrQcP8mIZzB0OqAXRBo12kCMv6m0rwWf4GcKvwwTM5f3/WmYG2yjqGtF6BvbBxjL+MowJ2g/yVc+ncmVmfUl/SvryoDlQP0PawAEoGHk5pO3au8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4741.eurprd04.prod.outlook.com (20.177.32.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 09:17:53 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 09:17:53 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: RE: [PATCHv4 11/28] PCI: mobiveil: only fix up the Class Code field
Thread-Topic: [PATCHv4 11/28] PCI: mobiveil: only fix up the Class Code field
Thread-Index: AQHU1+0xoaV/Y9GqOUGCpK8QyE26hqYGeYAAgAD0oPA=
Date:   Tue, 12 Mar 2019 09:17:53 +0000
Message-ID: <AM6PR04MB5781498315C6B69EB2586B9D84490@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-12-Zhiqiang.Hou@nxp.com>
 <20190311141401.GG214730@google.com>
In-Reply-To: <20190311141401.GG214730@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [120.244.120.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26fc7561-cedf-4d5f-7fda-08d6a6cb9b41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4741;
x-ms-traffictypediagnostic: AM6PR04MB4741:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0TUI0NzQxOzIzOmFkNW1ScHRhcXlNZ0xralJPcVFydDUwRnVM?=
 =?gb2312?B?cUlhV05EVkVZbWl0MW1lSUlVWVdRWlZleU1RN0Z3WmFoSlBmTjkwdkNLNTRi?=
 =?gb2312?B?YkhaNEVxelBUdFl2bWVtQzNZY3pBdExTdzNaUmVPVjFwUU5vVzhUdGRacW1W?=
 =?gb2312?B?OERnQUtyWXlvM1BrMjJmWTNtMHl6ektXQW15VTJuNXRKK21teXo2S3MvYzUw?=
 =?gb2312?B?Q1h3Ym83OStJaVNvWmJObGd3dTFQaEJKb2liSXUvbStjcytqRUN3L1lOZmc0?=
 =?gb2312?B?TXYycnl0bXRhODRNcUZ0RmVUT0tEaVJLRXRZVG90VWtCejBYQ2VxVXp3OFFt?=
 =?gb2312?B?WFhzQUpkNlFPSG9zeHNzWnB2NFVSN2hzaU12K1JmWlY5Vmw3am1veE4zRUFD?=
 =?gb2312?B?L2wvTEZOWWFkdFYzdkRsN3liVGo3Z01OQ3Bnc0xlNUtKcFdBQWVHTXR0dWpy?=
 =?gb2312?B?MEt2S0RrL2NzZTlKd3MvQkNidmZEdjIzalk0elcrTHFOK3h6VlM4VXd4bzhC?=
 =?gb2312?B?NFFLcWUvMU9qOHhJQnNFMnFqVS9nRUVxdjB5ZURrUHI4MEo5NldHdmlRTmVz?=
 =?gb2312?B?NnByczNUZjBlbVlod1c1VjZTRm9JdHR0SGhVUmVxbzhSWHVaZktkNkZ6WUgy?=
 =?gb2312?B?aUt0ckdxR21oSktuM091NEpqVFRpL0hHbTJwMWxGdlZLd3FsUkZqN1hIMjZa?=
 =?gb2312?B?Si9jelhLbTdFckhxMlN6MnpXUDM3WWRKVm9CNDUwUE14bWowRm5kUWpyaUhE?=
 =?gb2312?B?bnhadU5SbGcvRXU5djZWcEppcXNXbDNFaENMTHhaczRRdkxHSDBBV0s1L09t?=
 =?gb2312?B?S1FFdFh6c0FNRmtyOThUTFJSbDB0c0dibFc4NjVmUG1aU1NzV2tVSTJUM3U4?=
 =?gb2312?B?RHBEdkRaMXI5R0QwQjhSblhKWC91RjJmVngyUVVRY3dvUXRBaVNvRmlzaGJv?=
 =?gb2312?B?Q3NZcGE3WllVYzF2MTl5cFgzMzcxdEVweEh5amxVOWppV3RUOWQ4NTZkRVpr?=
 =?gb2312?B?cmROcTRtWGYzcjdnR0RCdUV0ZCtldWF1K2tVMDlNamhDVGp5VmF4QXpnUEd0?=
 =?gb2312?B?a1NLdHUzalZoSjdxWXphQlU5bzBaU2pObjhsTXZJeDBleHlzZSszMzRyNDQ1?=
 =?gb2312?B?NG1QbGpqdlVTaURIMzVqSnh0ZXJmSTEyR0dyak1oY0NmcjdxTEZ2ZGxrcWti?=
 =?gb2312?B?SjZ4bmJzUGpkR2tjMFlUSWV1N3hUbUNoQnlnZlRncEcybS9kYkhJQWV5TWlo?=
 =?gb2312?B?MXgwTjhHcXZDU0hoUG9yZ2VNc2EwWDZDbjc2Tm1BWjQ2U2FqV2ViWEk3bnU0?=
 =?gb2312?B?NkFmRzNCVkVKSVNhMVR2V25PcERKWUp5ZW9UQXdXdXlhbkJmZGk5ZlluQVdD?=
 =?gb2312?B?VzVwM1lSSXAzU2VVT0FwckNMTkJWRjZvSjN6TlVBaWR4azQwUnFEV1IxK0F0?=
 =?gb2312?B?V1crQTdXS1RhSkZHT3BhWVdjeTJFTnN6OXpnSGRVRlVaRHQ1aWNzanZVREl1?=
 =?gb2312?B?UGF3Sk1wcXgyVGVTWEFwUmpCS1YvYXRyaGtCUjBHMzY5bGVsUm10WEFhSjBu?=
 =?gb2312?B?SU9KN3pvbVJTTGh5UlBVU2gvSytHSllxTjRiTnBMYjlHVkg2UGk3NXZmWk9N?=
 =?gb2312?B?UFdrbXZJL3l4cEx5OVVTTzJIQ1dTVDMwZjIrR2ZnVzVlV3o1emRFc2N0UGJr?=
 =?gb2312?B?UEh4aFJvU2swUkVuZ0krM0FXdHVPODI5TXROUWZYdmFzRjlMRGd2aWhxY2s4?=
 =?gb2312?B?dGNsREZFS0lwOG5hdUxaUT09?=
x-microsoft-antispam-prvs: <AM6PR04MB4741B87493146134D777627384490@AM6PR04MB4741.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(54534003)(13464003)(189003)(199004)(81166006)(25786009)(81156014)(478600001)(86362001)(229853002)(6436002)(5660300002)(8676002)(316002)(99286004)(186003)(486006)(6246003)(52536013)(71190400001)(14454004)(97736004)(8936002)(7696005)(4326008)(76176011)(7416002)(476003)(102836004)(446003)(11346002)(53546011)(6506007)(71200400001)(2906002)(305945005)(6116002)(74316002)(68736007)(3846002)(7736002)(53936002)(9686003)(66066001)(55016002)(54906003)(26005)(33656002)(106356001)(256004)(105586002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4741;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MBlQnXuNIZtY7tJdIJm1xkDjaRGm9ZGKnl7Wf0ID4fTXz/TiEaVoUnwtePGz1o+T19MRUxxqde+1tji/4B+YEX8lF7mgxghLP9/QZ64kDrrCnyi/VzhCdSOgTdCrQznCkB9w6UrUgT3sCoAYrd6bxdMMUMplbQoUYyoklchV3MNQQ/aYf8o7TIeVnvQESZ82MugwGzqIvJ1li2ZLZ5N/bd6gjfukieXkK+Z34jEBjDujomvNfk5t+qhzXmxj6mk5uKTqftgStGP/pf98PtjhZMHNzuWbOk+oFXxeeiZo9E7l75iaPyfsoD6Gmuy1j7ZQi6cOav08IQkMFbuWgYOZTGlKKrWy2s/wWrGrU0n7OQwUuWpacJNBxf/AqHh5R01lApzHrLavEDAKXQHC7RabstOZKeEJqEjmAY5unXAWzAo=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fc7561-cedf-4d5f-7fda-08d6a6cb9b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 09:17:53.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4741
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE5xOoz1MIxMcjVIDIyOjE0DQo+IFRvOiBaLnEuIEhv
dSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtl
cm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNv
LmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47
DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0K
PiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBN
LmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFvd2Vp
LmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjQgMTEvMjhdIFBDSTogbW9iaXZl
aWw6IG9ubHkgZml4IHVwIHRoZSBDbGFzcyBDb2RlIGZpZWxkDQo+IA0KPiBPbiBNb24sIE1hciAx
MSwgMjAxOSBhdCAwOTozMToyM0FNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBI
b3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gRml4IHVwIHRoZSBD
bGFzcyBDb2RlIHRvIFBDSSBicmlkZ2UsIGRvIG5vdCBjaGFuZ2UgdGhlIFJldmlzaW9uIElELg0K
PiA+IEFuZCBtb3ZlIHRoZSBmaXh1cCB0byBtb2JpdmVpbF9ob3N0X2luaXQgZnVuY3Rpb24uDQo+
IA0KPiBBZGQgcGFyZW5zIGFmdGVyIGZ1bmN0aW9uIG5hbWUuDQo+IA0KPiBQbGVhc2UgZXhwbGFp
biB3aHkgdGhpcyBjaGFuZ2UgaXMgbmVlZGVkLiAgRG9lcyBpdCBmaXggYSBidWc/DQo+IA0KPiBE
b2VzIHRoaXMgZml4IHRoZSBwcm9ibGVtIHRoYXQgdGhlIFBDSSBjb3JlIGRpZG4ndCBjb3JyZWN0
bHkgaWRlbnRpZnkgdGhlIGRldmljZQ0KPiBhcyBhIGJyaWRnZSBiZWNhdXNlIGl0IGlkZW50aWZp
ZWQgYnJpZGdlcyBieSBjbGFzcyBjb2RlIGluc3RlYWQgb2YgaGVhZGVyIHR5cGU/DQo+IA0KPiBU
aGF0IHByb2JsZW0gKnNob3VsZCogYmUgZml4ZWQgYnkgYjJmYjVjYzU3NDY5ICgiUENJOiBSZWx5
IG9uIGNvbmZpZyBzcGFjZQ0KPiBoZWFkZXIgdHlwZSwgbm90IGNsYXNzIGNvZGUiKSwgd2hpY2gg
aXMgbm93IHVwc3RyZWFtLg0KPiANCj4gWW91IG1pZ2h0IHN0aWxsIHdhbnQgdGhpcyBjbGFzcyBj
b2RlIGNoYW5nZSBzbyB0aGF0IGxzcGNpIHNob3dzIHRoZSBjb3JyZWN0DQo+IHRoaW5nLiAgVGhh
dCdzIGZpbmUsIGJ1dCB0aGUgY2hhbmdlbG9nIHNob3VsZCBzYXkgd2h5IHdlJ3JlIGRvaW5nIGl0
Lg0KPg0KDQpTdWJyYWhtYW55YSdzIG9yaWdpbmFsIHBhdGNoIGlzIHRvIGZpeHVwICdDbGFzcyBD
b2RlJyBmaWVsZCwgYnV0IGl0IGFsc28gZml4ZWQgdGhlICdSZXZpc2lvbiBJRCcgZmllbGQuIFRo
aXMgcGF0Y2ggaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIHRoZSBmaXh1cCBvZiAnUmV2aXNpb24gSUQn
IGZpZWxkLg0KDQo+ID4gRml4ZXM6IDlhZjZiY2IxMWUxMiAoIlBDSTogbW9iaXZlaWw6IEFkZCBN
b2JpdmVpbCBQQ0llIEhvc3QgQnJpZGdlIElQDQo+ID4gZHJpdmVyIikNCj4gDQo+IE1ha2UgdGhp
cyAiRml4ZXM6IiBsaW5lIGEgc2luZ2xlIGxpbmUgYWdhaW4uDQo+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IE1pbmdodWFuIExpYW4gPE1pbmdodWFuLkxpYW5AbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTog
U3VicmFobWFueWEgTGluZ2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQo+ID4g
LS0tDQo+ID4gVjQ6DQo+ID4gIC0gbm8gY2hhbmdlDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCA5ICsrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+IGluZGV4IDc4ZTU3NWU3MWY0ZC4uOGVl
ZTFhYjdlZTI0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
b2JpdmVpbC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWls
LmMNCj4gPiBAQCAtNjUzLDYgKzY1MywxMiBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2hvc3RfaW5p
dChzdHJ1Y3QgbW9iaXZlaWxfcGNpZQ0KPiAqcGNpZSkNCj4gPiAgCQkJCSAgIHR5cGUsIHJlc291
cmNlX3NpemUod2luLT5yZXMpKTsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJLyogZml4dXAgZm9yIFBD
SWUgY2xhc3MgcmVnaXN0ZXIgKi8NCj4gPiArCXZhbHVlID0gY3NyX3JlYWRsKHBjaWUsIFBBQl9J
TlRQX0FYSV9QSU9fQ0xBU1MpOw0KPiA+ICsJdmFsdWUgJj0gMHhmZjsNCj4gPiArCXZhbHVlIHw9
IChQQ0lfQ0xBU1NfQlJJREdFX1BDSSA8PCAxNik7DQo+ID4gKwljc3Jfd3JpdGVsKHBjaWUsIHZh
bHVlLCBQQUJfSU5UUF9BWElfUElPX0NMQVNTKTsNCj4gPiArDQo+ID4gIAkvKiBzZXR1cCBNU0kg
aGFyZHdhcmUgcmVnaXN0ZXJzICovDQo+ID4gIAltb2JpdmVpbF9wY2llX2VuYWJsZV9tc2kocGNp
ZSk7DQo+ID4NCj4gPiBAQCAtODk2LDkgKzkwMiw2IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfcGNp
ZV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCWdvdG8gZXJy
b3I7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCS8qIGZpeHVwIGZvciBQQ0llIGNsYXNzIHJlZ2lzdGVy
ICovDQo+ID4gLQljc3Jfd3JpdGVsKHBjaWUsIDB4MDYwNDAyYWIsIFBBQl9JTlRQX0FYSV9QSU9f
Q0xBU1MpOw0KPiA+IC0NCj4gPiAgCS8qIGluaXRpYWxpemUgdGhlIElSUSBkb21haW5zICovDQo+
ID4gIAlyZXQgPSBtb2JpdmVpbF9wY2llX2luaXRfaXJxX2RvbWFpbihwY2llKTsNCj4gPiAgCWlm
IChyZXQpIHsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQoNClRoYW5rcywNClpoaXFpYW5nDQo=
