Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B328DC43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9272147C
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eh3RDGDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfCLJmn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:42:43 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:33195
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfCLJmn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 05:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OgG1QvdDkk1POhRqYdn6QsKQliIkYdpaeMZM9dOt7I=;
 b=Eh3RDGDg5jSt07Iz4mz2QuyEbQVTLJa9nIf7/g1bJGnpbLSMVwnu4hbPZderphG46xkLwFSxY+CplqLNFKTIaRoSDqRRUpD17XbxLtyyGTlnbYrjEw3gufVZRjZXPGs1OSV60Jdc96jdVnlp9/3K2e0XYpy5DNqFDFegiIj1Ng0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4054.eurprd04.prod.outlook.com (52.135.167.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 09:42:36 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 09:42:36 +0000
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
Subject: RE: [PATCHv4 23/28] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Topic: [PATCHv4 23/28] dt-bindings: pci: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Index: AQHU1+1u2iPsWkLxw02FlhClA/G34KYHvxAg
Date:   Tue, 12 Mar 2019 09:42:36 +0000
Message-ID: <AM6PR04MB57811882B16E9DA956A515E684490@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-24-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-24-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [120.244.120.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f6386bb-0c9c-4c9f-e11a-08d6a6cf0f52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4054;
x-ms-traffictypediagnostic: AM6PR04MB4054:
x-microsoft-antispam-prvs: <AM6PR04MB4054C891DBB4177F8139D82B84490@AM6PR04MB4054.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(376002)(136003)(366004)(346002)(39860400002)(396003)(53754006)(189003)(199004)(13464003)(110136005)(33656002)(26005)(54906003)(2501003)(478600001)(66066001)(316002)(8676002)(81156014)(81166006)(74316002)(71200400001)(7736002)(305945005)(229853002)(6436002)(4326008)(97736004)(14454004)(71190400001)(106356001)(9686003)(53936002)(446003)(11346002)(105586002)(8936002)(186003)(68736007)(55016002)(256004)(7416002)(6246003)(476003)(486006)(52536013)(99286004)(2201001)(86362001)(3846002)(6116002)(102836004)(25786009)(76176011)(6506007)(53546011)(2906002)(5660300002)(7696005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4054;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1+nI4ji24tHlTqRW7YI/+1GUYOgPbREnQbnZHiatnf5IcyjB6oOTojwQyqhoUaK/vcC48rkcwc7f2Smek98/8DK3+Y+9dcU1LFe/1ipoYaiyciDJrUKdOhJCaIKlrihzXnATcgAexQi2KPWQWfqZRWRv3NRDPic2B3grGSgWp2z3cedxae6Ov8XL7KA6eDhIh5Qy3bsgB5ud1u05h0+J4ojTbqNELTcTVGfNe4ZPLIn2WUR94UbBDELx0tTe9Dp/fsgVWyPF4Ve2LctuQWMsNUtOK1GgknjWO8oD6Bh0DtKq9HTDERDUnMMNrAjSIcRlkqQqQnen+Er7vQworEp9FJRWT+dcF/RzNv6c1pzCcLHLFWlyaGa82/QtS9XLjjBddmML9tPPmn3hxEB3+2hfQtH0H45Td+ts+ij9YU/4RPM=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6386bb-0c9c-4c9f-e11a-08d6a6cf0f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 09:42:36.4604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4054
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWxsLA0KDQpQbGVhc2UgaWdub3JlIHRoaXMsIGhhcyByZS1zZW50IGl0IGFkZGluZyBsb3N0
IFJldmlld2VkLWJ5IHRhZy4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaLnEuIEhvdQ0KPiBTZW50OiAyMDE5xOoz1MIxMcjVIDE3
OjMzDQo+IFRvOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBsLnN1YnJhaG1hbnlhQG1vYml2ZWls
LmNvLmluOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNv
bT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
OyB3aWxsLmRlYWNvbkBhcm0uY29tDQo+IENjOiBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5j
b20+OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4
aWFvd2VpLmJhb0BueHAuY29tPjsgWi5xLiBIb3UNCj4gPHpoaXFpYW5nLmhvdUBueHAuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0h2NCAyMy8yOF0gZHQtYmluZGluZ3M6IHBjaTogQWRkIE5YUCBMYXll
cnNjYXBlIFNvQ3MgUENJZQ0KPiBHZW40IGNvbnRyb2xsZXINCj4gDQo+IEZyb206IEhvdSBaaGlx
aWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+IA0KPiBBZGQgUENJZSBHZW40IGNvbnRyb2xs
ZXIgRFQgYmluZGluZ3Mgb2YgTlhQIExheWVyc2NhcGUgU29Dcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+IC0tLQ0KPiBWNDoNCj4g
IC0gbm8gY2hhbmdlDQo+IA0KPiAgLi4uL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaS1nZW40
LnR4dCAgICAgIHwgNTIgKysrKysrKysrKysrKysrKysrKw0KPiAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDYwIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdlbjQudHh0DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNj
YXBlLXBjaS1nZW40LnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvbGF5ZXJzY2FwZS1wY2ktZ2VuNC50eHQNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5iNDBmYjVkMTVkM2QNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdlbjQu
dHh0DQo+IEBAIC0wLDAgKzEsNTIgQEANCj4gK05YUCBMYXllcnNjYXBlIFBDSWUgR2VuNCBjb250
cm9sbGVyDQo+ICsNCj4gK1RoaXMgUENJZSBjb250cm9sbGVyIGlzIGJhc2VkIG9uIHRoZSBNb2Jp
dmVpbCBQQ0llIElQIGFuZCB0aHVzIGluaGVyaXRzDQo+ICthbGwgdGhlIGNvbW1vbiBwcm9wZXJ0
aWVzIGRlZmluZWQgaW4gbW9iaXZlaWwtcGNpZS50eHQuDQo+ICsNCj4gK1JlcXVpcmVkIHByb3Bl
cnRpZXM6DQo+ICstIGNvbXBhdGlibGU6IHNob3VsZCBjb250YWluIHRoZSBwbGF0Zm9ybSBpZGVu
dGlmaWVyIHN1Y2ggYXM6DQo+ICsgICJmc2wsbHgyMTYwYS1wY2llIg0KPiArLSByZWc6IGJhc2Ug
YWRkcmVzc2VzIGFuZCBsZW5ndGhzIG9mIHRoZSBQQ0llIGNvbnRyb2xsZXIgcmVnaXN0ZXIgYmxv
Y2tzLg0KPiArICAiY3NyX2F4aV9zbGF2ZSI6IEJyaWRnZSBjb25maWcgcmVnaXN0ZXJzDQo+ICsg
ICJjb25maWdfYXhpX3NsYXZlIjogUENJZSBjb250cm9sbGVyIHJlZ2lzdGVycw0KPiArLSBpbnRl
cnJ1cHRzOiBBIGxpc3Qgb2YgaW50ZXJydXB0IG91dHB1dHMgb2YgdGhlIGNvbnRyb2xsZXIuIE11
c3QNCj4gK2NvbnRhaW4gYW4NCj4gKyAgZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gdGhlIGludGVy
cnVwdC1uYW1lcyBwcm9wZXJ0eS4NCj4gKy0gaW50ZXJydXB0LW5hbWVzOiBJdCBjb3VsZCBpbmNs
dWRlIHRoZSBmb2xsb3dpbmcgZW50cmllczoNCj4gKyAgImludHIiOiBUaGUgaW50ZXJydXB0IHRo
YXQgaXMgYXNzZXJ0ZWQgZm9yIGNvbnRyb2xsZXIgaW50ZXJydXB0cw0KPiArICAiYWVyIjogQXNz
ZXJ0ZWQgZm9yIGFlciBpbnRlcnJ1cHQgd2hlbiBjaGlwIHN1cHBvcnQgdGhlIGFlciBpbnRlcnJ1
cHQgd2l0aA0KPiArCSBub25lIE1TSS9NU0ktWC9JTlR4IG1vZGUsYnV0IHRoZXJlIGlzIGludGVy
cnVwdCBsaW5lIGZvciBhZXIuDQo+ICsgICJwbWUiOiBBc3NlcnRlZCBmb3IgcG1lIGludGVycnVw
dCB3aGVuIGNoaXAgc3VwcG9ydCB0aGUgcG1lIGludGVycnVwdA0KPiB3aXRoDQo+ICsJIG5vbmUg
TVNJL01TSS1YL0lOVHggbW9kZSxidXQgdGhlcmUgaXMgaW50ZXJydXB0IGxpbmUgZm9yIHBtZS4N
Cj4gKy0gZG1hLWNvaGVyZW50OiBJbmRpY2F0ZXMgdGhhdCB0aGUgaGFyZHdhcmUgSVAgYmxvY2sg
Y2FuIGVuc3VyZSB0aGUNCj4gK2NvaGVyZW5jeQ0KPiArICBvZiB0aGUgZGF0YSB0cmFuc2ZlcnJl
ZCBmcm9tL3RvIHRoZSBJUCBibG9jay4gVGhpcyBjYW4gYXZvaWQgdGhlDQo+ICtzb2Z0d2FyZQ0K
PiArICBjYWNoZSBmbHVzaC9pbnZhbGlkIGFjdGlvbnMsIGFuZCBpbXByb3ZlIHRoZSBwZXJmb3Jt
YW5jZSBzaWduaWZpY2FudGx5Lg0KPiArLSBtc2ktcGFyZW50IDogU2VlIHRoZSBnZW5lcmljIE1T
SSBiaW5kaW5nIGRlc2NyaWJlZCBpbg0KPiArICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvbXNpLnR4dC4NCj4gKw0KPiArRXhhbXBsZToNCj4g
Kw0KPiArCXBjaWVAMzQwMDAwMCB7DQo+ICsJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtcGNp
ZSI7DQo+ICsJCXJlZyA9IDwweDAwIDB4MDM0MDAwMDAgMHgwIDB4MDAxMDAwMDAgICAvKiBjb250
cm9sbGVyIHJlZ2lzdGVycw0KPiAqLw0KPiArCQkgICAgICAgMHg4MCAweDAwMDAwMDAwIDB4MCAw
eDAwMDAxMDAwPjsgLyogY29uZmlndXJhdGlvbiBzcGFjZQ0KPiAqLw0KPiArCQlyZWctbmFtZXMg
PSAiY3NyX2F4aV9zbGF2ZSIsICJjb25maWdfYXhpX3NsYXZlIjsNCj4gKwkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDEwOCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogQUVSDQo+IGludGVycnVwdCAq
Lw0KPiArCQkJICAgICA8R0lDX1NQSSAxMDggSVJRX1RZUEVfTEVWRUxfSElHSD4sIC8qIFBNRSBp
bnRlcnJ1cHQNCj4gKi8NCj4gKwkJCSAgICAgPEdJQ19TUEkgMTA4IElSUV9UWVBFX0xFVkVMX0hJ
R0g+OyAvKiBjb250cm9sbGVyDQo+IGludGVycnVwdCAqLw0KPiArCQlpbnRlcnJ1cHQtbmFtZXMg
PSAiYWVyIiwgInBtZSIsICJpbnRyIjsNCj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+ICsJ
CSNzaXplLWNlbGxzID0gPDI+Ow0KPiArCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiArCQlhcGlv
LXdpbnMgPSA8OD47DQo+ICsJCXBwaW8td2lucyA9IDw4PjsNCj4gKwkJZG1hLWNvaGVyZW50Ow0K
PiArCQlidXMtcmFuZ2UgPSA8MHgwIDB4ZmY+Ow0KPiArCQltc2ktcGFyZW50ID0gPCZpdHM+Ow0K
PiArCQlyYW5nZXMgPSA8MHg4MjAwMDAwMCAweDAgMHg0MDAwMDAwMCAweDgwIDB4NDAwMDAwMDAg
MHgwDQo+IDB4NDAwMDAwMDA+Ow0KPiArCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiArCQlp
bnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAgNz47DQo+ICsJCWludGVycnVwdC1tYXAgPSA8MDAw
MCAwIDAgMSAmZ2ljIDAgMCBHSUNfU1BJIDEwOQ0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4g
KwkJCQk8MDAwMCAwIDAgMiAmZ2ljIDAgMCBHSUNfU1BJIDExMA0KPiBJUlFfVFlQRV9MRVZFTF9I
SUdIPiwNCj4gKwkJCQk8MDAwMCAwIDAgMyAmZ2ljIDAgMCBHSUNfU1BJIDExMQ0KPiBJUlFfVFlQ
RV9MRVZFTF9ISUdIPiwNCj4gKwkJCQk8MDAwMCAwIDAgNCAmZ2ljIDAgMCBHSUNfU1BJIDExMg0K
PiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKwl9Ow0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5F
UlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCAxMDEzZTc0YjE0ZjIuLjJkMThjNzIxMzk5MSAxMDA2
NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTExODM1
LDYgKzExODM1LDE0IEBAIEw6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiAgUzoJTWFpbnRhaW5lZA0KPiAgRjoJZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvKmxheWVy
c2NhcGUqDQo+IA0KPiArUENJIERSSVZFUiBGT1IgTlhQIExBWUVSU0NBUEUgR0VONCBDT05UUk9M
TEVSDQo+ICtNOglIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiArTDoJbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiArTDoJbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+ICtTOglNYWludGFpbmVkDQo+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdlbjQudHh0DQo+ICtGOglkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL21vYmliZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYw0KPiArDQo+ICBQQ0kg
RFJJVkVSIEZPUiBHRU5FUklDIE9GIEhPU1RTDQo+ICBNOglXaWxsIERlYWNvbiA8d2lsbC5kZWFj
b25AYXJtLmNvbT4NCj4gIEw6CWxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0NCj4gMi4x
Ny4xDQoNCg==
