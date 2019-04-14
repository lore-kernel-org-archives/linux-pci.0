Return-Path: <SRS0=uRTt=SQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE0C10F13
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39360218D3
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 11:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o9hC+vxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfDNLRC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:17:02 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:38784
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbfDNLRC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Apr 2019 07:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjybMDggbo1fJchh7LPQweBStiKq+yQvmgfjrZ9rPnQ=;
 b=o9hC+vxqTMlP6euvrdJJzoO/hMeZb6h52+og7QYMxy+xXOGfWlf0P8Ea/ihguEQ5+IEGWIWKNZoUy+W+wvOJzFO55nJKzOaUK0wrpM2GKp2Y/Rh27yD4PLlFpEuSh9yRdx/D1ydiY3v3kaJm+sBJhZVXgHymxAbhler2RFsC/KU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4229.eurprd04.prod.outlook.com (52.135.168.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Sun, 14 Apr 2019 11:16:18 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019
 11:16:18 +0000
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
Subject: RE: [EXT] Re: [PATCHv5 4/6] PCI: mobiveil: Add PCIe Gen4 RC driver
 for NXP Layerscape SoCs
Thread-Topic: [EXT] Re: [PATCHv5 4/6] PCI: mobiveil: Add PCIe Gen4 RC driver
 for NXP Layerscape SoCs
Thread-Index: AQHU8RV9MHdz0yaFRUW6+R/81XqWJaY4jg+AgAL1kJA=
Date:   Sun, 14 Apr 2019 11:16:18 +0000
Message-ID: <AM6PR04MB57812C408E832313DADAB248842A0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
 <20190412095332.41370-5-Zhiqiang.Hou@nxp.com>
 <20190412140041.GA141472@google.com>
In-Reply-To: <20190412140041.GA141472@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bf33b54-26e3-4f55-6a16-08d6c0ca9e00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4229;
x-ms-traffictypediagnostic: AM6PR04MB4229:
x-microsoft-antispam-prvs: <AM6PR04MB4229D7D1CF0B9122631C13B8842A0@AM6PR04MB4229.eurprd04.prod.outlook.com>
x-forefront-prvs: 00073DB75F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(136003)(346002)(366004)(39860400002)(396003)(376002)(13464003)(189003)(199004)(2906002)(52536014)(476003)(7696005)(53546011)(71200400001)(6506007)(99286004)(54906003)(11346002)(446003)(26005)(71190400001)(6436002)(55016002)(6246003)(97736004)(4326008)(86362001)(486006)(9686003)(316002)(53936002)(229853002)(81166006)(81156014)(305945005)(5660300002)(105586002)(6916009)(8936002)(68736007)(33656002)(66066001)(25786009)(8676002)(76176011)(478600001)(102836004)(3846002)(5024004)(256004)(106356001)(7416002)(74316002)(14454004)(14444005)(6116002)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4229;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8OtIuvPQNd4oljiwRRYuz3S6dng6LgkMATP9ho+XMISdsoIvLZSHTazHTnCGt7ynh+37RMECA6bKPrXvpAwn2Juf5BdkKidAsqQ35cFRWvQrioQubi3MFr9/vkWgOl0MdQXo2o9ldKLpqda4kVHjAI3Pkn8dcaO1S3gRrjoS6sX480BmK2xYJ0VdQyE7smKCEO+wwj+71OVjHsCifvUW/JesE6ByxTtxweB4Q9ILU9KiGJV+v/xa1z5d4EYGgEiuhrU5ompXBSC1mor6xDpCWTpk8yUePcsWnC7WSEPJJT0F5KSIH0QvJ7aF9up29eZBeQbxV2cl/ohSgsYqSr7DW/JraFfL/Uqjvufakpz04Hq80NASwGNHJsoTwfDJVXq+Q1+8+KhoZgrK4ucaTPTr3zekouUUvtUuc4QmhxnL6WE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf33b54-26e3-4f55-6a16-08d6c0ca9e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2019 11:16:18.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4229
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE55bm0NOaciDEy5pelIDIyOjAxDQo+IFRvOiBaLnEu
IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0
QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWls
LmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Ow0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIdjUgNC82XSBQQ0k6
IG1vYml2ZWlsOiBBZGQgUENJZSBHZW40IFJDIGRyaXZlciBmb3INCj4gTlhQIExheWVyc2NhcGUg
U29Dcw0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCB3YXMgY3JlYXRlZCBvdXRzaWRlIG9mIE5Y
UC4gRE8gTk9UIENMSUNLIGxpbmtzIG9yDQo+IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiAN
Cj4gT24gRnJpLCBBcHIgMTIsIDIwMTkgYXQgMDk6NTI6NTBBTSArMDAwMCwgWi5xLiBIb3Ugd3Jv
dGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0K
PiA+IFRoaXMgUENJZSBjb250cm9sbGVyIGlzIGJhc2VkIG9uIHRoZSBNb2JpdmVpbCBHUEVYIElQ
LCB3aGljaCBpcw0KPiA+IGNvbXBhdGlibGUgd2l0aCB0aGUgUENJIEV4cHJlc3PihKIgQmFzZSBT
cGVjaWZpY2F0aW9uLCBSZXZpc2lvbiA0LjAuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3Ug
WmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaW5naHVh
biBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gVjU6DQo+ID4gIC0g
Q29ycmVjdGVkIHRoZSBzdWJqZWN0Lg0KPiA+ICAtIENvcnJlY3RlZCAyIHR5cG9zLg0KPiA+ICAt
IFVwZGF0ZWQgdGhlIENvcHlyaWdodCBhbmQgZHJpdmVyIGRlc2NyaXB0aW9uLg0KPiA+ICAtIENo
YW5nZWQgdG8gdXNlIEJJVCh4KSB0byBkZWZpbmUgdmVyaW91cyBmdW5jdGlvbnMgb2YgcmVnaXN0
ZXIncyBiaXRzLg0KPiA+ICAtIFVuaWZpZWQgdGhlIGNhcGl0YWxpemF0aW9uIG9mIGVycm9yIGlu
Zm8uDQo+ID4gIC0gQ2hhbmdlZCB0aGUgSVJRIGhhbmRsZXIgbmFtZSB0byBsc19wY2llX2c0X2lz
cigpLg0KPiA+ICAtIENoYW5nZSAnaXJxJyB0byAnSVJRJyBpbiBlcnJvciBpbmZvLg0KPiA+ICAt
IFRyaW1tZWQgc29tZSBmdW5jdGlvbnMgd2l0aG91dCBmdW5jdGlvbmFsaXR5IGNoYW5nZS4NCj4g
Pg0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL0tjb25maWcgICAgICAgfCAg
MTAgKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxlICAgICAg
fCAgIDEgKw0KPiANCj4gPiAgLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpLWxheWVyc2NhcGUt
Z2VuNC5jIHwgMjU2DQo+ID4gKysrKysrKysrKysrKysrKysrDQo+IA0KPiBJIHdvdWxkIHByb2Jh
Ymx5IG5hbWUgdGhpcyAicGNpZS1sYXllcnNjYXBlLWdlbjQuYyIgKCJwY2llIiBpbnN0ZWFkIG9m
ICJwY2kiKSwNCj4gc2luY2UgdGhhdCdzIG1vcmUgdHlwaWNhbCBhbmQgdGhpcyByZWFsbHkgaXMg
UENJZS1zcGVjaWZpYy4NCg0KWWVzLCB0aGlzIGNhbiBiZSBhcnJhbmdlZCBpbiB2Ni4NCg0KPiAN
Cj4gPiArI2RlZmluZSBQQ0lFX1BGX0RCRyAgICAgICAgICAgICAgICAgIDB4N2ZjDQo+ID4gKyNk
ZWZpbmUgUEZfREJHX0xUU1NNX01BU0sgICAgICAgICAgICAweDNmDQo+ID4gKyNkZWZpbmUgUEZf
REJHX1dFICAgICAgICAgICAgICAgICAgICBCSVQoMzEpDQo+ID4gKyNkZWZpbmUgUEZfREJHX1BB
QlIgICAgICAgICAgICAgICAgICBCSVQoMjcpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIExTX1BDSUVf
RzRfTFRTU01fTDAgICAgICAgICAgMHgyZCAvKiBMMCBzdGF0ZSAqLw0KPiANCj4gTWF5YmUgcmVu
YW1lIHRoaXMgYW5kIG1vdmUgaXQgdG8gbWFrZSBpdCBvYnZpb3VzIHRoYXQgaXQncyByZWxhdGVk
IHRvDQo+IFBGX0RCR19MVFNTTV9NQVNLPw0KDQpZZXMsIHdpbGwgcmVuYW1lIGl0IGluIHY2Lg0K
DQo+IA0KPiA+ICsgICAgICAgICAgICAgZGV2X2VycihkZXYsICJQb2xsIFBBQlJTVCZQQUJBQ1Qg
dGltZW91dC5cbiIpOw0KPiANCj4gTm8gbmVlZCBmb3IgcHVuY3R1YXRpb24gYXQgZW5kIG9mIG1l
c3NhZ2VzLg0KDQpXaWxsIHJlbW92ZSB0aGVtIGluIHY2Lg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
