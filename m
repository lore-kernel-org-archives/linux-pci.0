Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25AEC10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9C820850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gTa1KfWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLJxW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:53:22 -0400
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:5486
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfDLJxV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 05:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RTncIWMmjsCsLE3bA8aw2LHEs30CA7sWq7SFCx7Z3U=;
 b=gTa1KfWU7PQSydN0+8Xe81IpB/nuc5sxh0809bcK8D92RU8FZuqHj1V+s3Ool2isSX6Kfhu9lCkOoUvjuAwl+lVVgJeN+LWiOedQ1SFuwYJWKE5sxejA5TMgx6AqimWXkF+AsOlztrgHMX+Tq4myD1AWlkDM6dxwyMRZuoEstEI=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6262.eurprd04.prod.outlook.com (20.179.7.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Fri, 12 Apr 2019 09:52:50 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 09:52:50 +0000
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
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv5 3/6] dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
 controller
Thread-Topic: [PATCHv5 3/6] dt-bindings: PCI: Add NXP Layerscape SoCs PCIe
 Gen4 controller
Thread-Index: AQHU8RV4mssqZqffhUekLb/ZVTllIw==
Date:   Fri, 12 Apr 2019 09:52:41 +0000
Message-ID: <20190412095332.41370-4-Zhiqiang.Hou@nxp.com>
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84d27a7f-7a61-4966-a423-08d6bf2c9a8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6262;
x-ms-traffictypediagnostic: AM6PR04MB6262:
x-microsoft-antispam-prvs: <AM6PR04MB626231DB5589578CC46D775A84280@AM6PR04MB6262.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(68736007)(81156014)(3846002)(66066001)(26005)(76176011)(81166006)(86362001)(2201001)(102836004)(186003)(386003)(7736002)(50226002)(7416002)(8676002)(2906002)(6506007)(8936002)(305945005)(5660300002)(6116002)(4326008)(476003)(478600001)(25786009)(486006)(256004)(2616005)(105586002)(71190400001)(446003)(110136005)(6512007)(11346002)(1076003)(53936002)(14454004)(52116002)(6436002)(6486002)(71200400001)(54906003)(2501003)(36756003)(106356001)(6666004)(316002)(99286004)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6262;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dNa7OUek3Fx4KHp3D4WY7UVBIzsQND42yxlsu+zIkFHeo/00/nhcKGJcCtMoohufoVKlngKFmiy/ePOw6bZxAz4bApe+OHFXUIDnO0MW9NJBBAxcrAekLIzRaiEcDkzpEzkAmvbmh1zCduCAlVbU1lPW6jciJwncmcuoc6w/Egxsj4hg6eTFqB5d4v7E6Dx28KZNohKVbUKQxsqu11SBIBgxl/X0hSMOUOdeaHW9qyadoXv2+ZDTXUlMsqrjSMLYdnH0m5TTgsya0fNevZoftkuLU7fethikBUWmZbhDgEKZPLqGvFSgHmNyMFofqPX0rqOhgv1KTVqYXDc6pHPfxrlvzhpsCGJRD9OC+5DDz93a6n+/pytjOdM2oaBdDAXqv2RohlINAQyQt/yTFusVTp17RQ8lRsFvxkgSLeZ13wA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d27a7f-7a61-4966-a423-08d6bf2c9a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 09:52:41.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6262
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KQWRkIFBDSWUgR2Vu
NCBjb250cm9sbGVyIERUIGJpbmRpbmdzIG9mIE5YUCBMYXllcnNjYXBlIFNvQ3MuDQoNClNpZ25l
ZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQpSZXZpZXdlZC1i
eTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KVjU6DQogLSBDb3JyZWN0ZWQg
dGhlIHN1YmplY3QuDQoNCiAuLi4vYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdlbjQudHh0
ICAgICAgfCA1MiArKysrKysrKysrKysrKysrKysrDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDggKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2ktZ2VuNC50eHQNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2ktZ2VuNC50eHQg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdl
bjQudHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5iNDBmYjVk
MTVkM2QNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2ktZ2VuNC50eHQNCkBAIC0wLDAgKzEsNTIgQEANCitOWFAg
TGF5ZXJzY2FwZSBQQ0llIEdlbjQgY29udHJvbGxlcg0KKw0KK1RoaXMgUENJZSBjb250cm9sbGVy
IGlzIGJhc2VkIG9uIHRoZSBNb2JpdmVpbCBQQ0llIElQIGFuZCB0aHVzIGluaGVyaXRzIGFsbA0K
K3RoZSBjb21tb24gcHJvcGVydGllcyBkZWZpbmVkIGluIG1vYml2ZWlsLXBjaWUudHh0Lg0KKw0K
K1JlcXVpcmVkIHByb3BlcnRpZXM6DQorLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiB0aGUg
cGxhdGZvcm0gaWRlbnRpZmllciBzdWNoIGFzOg0KKyAgImZzbCxseDIxNjBhLXBjaWUiDQorLSBy
ZWc6IGJhc2UgYWRkcmVzc2VzIGFuZCBsZW5ndGhzIG9mIHRoZSBQQ0llIGNvbnRyb2xsZXIgcmVn
aXN0ZXIgYmxvY2tzLg0KKyAgImNzcl9heGlfc2xhdmUiOiBCcmlkZ2UgY29uZmlnIHJlZ2lzdGVy
cw0KKyAgImNvbmZpZ19heGlfc2xhdmUiOiBQQ0llIGNvbnRyb2xsZXIgcmVnaXN0ZXJzDQorLSBp
bnRlcnJ1cHRzOiBBIGxpc3Qgb2YgaW50ZXJydXB0IG91dHB1dHMgb2YgdGhlIGNvbnRyb2xsZXIu
IE11c3QgY29udGFpbiBhbg0KKyAgZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gdGhlIGludGVycnVw
dC1uYW1lcyBwcm9wZXJ0eS4NCistIGludGVycnVwdC1uYW1lczogSXQgY291bGQgaW5jbHVkZSB0
aGUgZm9sbG93aW5nIGVudHJpZXM6DQorICAiaW50ciI6IFRoZSBpbnRlcnJ1cHQgdGhhdCBpcyBh
c3NlcnRlZCBmb3IgY29udHJvbGxlciBpbnRlcnJ1cHRzDQorICAiYWVyIjogQXNzZXJ0ZWQgZm9y
IGFlciBpbnRlcnJ1cHQgd2hlbiBjaGlwIHN1cHBvcnQgdGhlIGFlciBpbnRlcnJ1cHQgd2l0aA0K
Kwkgbm9uZSBNU0kvTVNJLVgvSU5UeCBtb2RlLGJ1dCB0aGVyZSBpcyBpbnRlcnJ1cHQgbGluZSBm
b3IgYWVyLg0KKyAgInBtZSI6IEFzc2VydGVkIGZvciBwbWUgaW50ZXJydXB0IHdoZW4gY2hpcCBz
dXBwb3J0IHRoZSBwbWUgaW50ZXJydXB0IHdpdGgNCisJIG5vbmUgTVNJL01TSS1YL0lOVHggbW9k
ZSxidXQgdGhlcmUgaXMgaW50ZXJydXB0IGxpbmUgZm9yIHBtZS4NCistIGRtYS1jb2hlcmVudDog
SW5kaWNhdGVzIHRoYXQgdGhlIGhhcmR3YXJlIElQIGJsb2NrIGNhbiBlbnN1cmUgdGhlIGNvaGVy
ZW5jeQ0KKyAgb2YgdGhlIGRhdGEgdHJhbnNmZXJyZWQgZnJvbS90byB0aGUgSVAgYmxvY2suIFRo
aXMgY2FuIGF2b2lkIHRoZSBzb2Z0d2FyZQ0KKyAgY2FjaGUgZmx1c2gvaW52YWxpZCBhY3Rpb25z
LCBhbmQgaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2Ugc2lnbmlmaWNhbnRseS4NCistIG1zaS1wYXJl
bnQgOiBTZWUgdGhlIGdlbmVyaWMgTVNJIGJpbmRpbmcgZGVzY3JpYmVkIGluDQorICBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvbXNpLnR4dC4N
CisNCitFeGFtcGxlOg0KKw0KKwlwY2llQDM0MDAwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJmc2ws
bHgyMTYwYS1wY2llIjsNCisJCXJlZyA9IDwweDAwIDB4MDM0MDAwMDAgMHgwIDB4MDAxMDAwMDAg
ICAvKiBjb250cm9sbGVyIHJlZ2lzdGVycyAqLw0KKwkJICAgICAgIDB4ODAgMHgwMDAwMDAwMCAw
eDAgMHgwMDAwMTAwMD47IC8qIGNvbmZpZ3VyYXRpb24gc3BhY2UgKi8NCisJCXJlZy1uYW1lcyA9
ICJjc3JfYXhpX3NsYXZlIiwgImNvbmZpZ19heGlfc2xhdmUiOw0KKwkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDEwOCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgLyogQUVSIGludGVycnVwdCAqLw0KKwkJ
CSAgICAgPEdJQ19TUEkgMTA4IElSUV9UWVBFX0xFVkVMX0hJR0g+LCAvKiBQTUUgaW50ZXJydXB0
ICovDQorCQkJICAgICA8R0lDX1NQSSAxMDggSVJRX1RZUEVfTEVWRUxfSElHSD47IC8qIGNvbnRy
b2xsZXIgaW50ZXJydXB0ICovDQorCQlpbnRlcnJ1cHQtbmFtZXMgPSAiYWVyIiwgInBtZSIsICJp
bnRyIjsNCisJCSNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KKwkJI3NpemUtY2VsbHMgPSA8Mj47DQor
CQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KKwkJYXBpby13aW5zID0gPDg+Ow0KKwkJcHBpby13aW5z
ID0gPDg+Ow0KKwkJZG1hLWNvaGVyZW50Ow0KKwkJYnVzLXJhbmdlID0gPDB4MCAweGZmPjsNCisJ
CW1zaS1wYXJlbnQgPSA8Jml0cz47DQorCQlyYW5nZXMgPSA8MHg4MjAwMDAwMCAweDAgMHg0MDAw
MDAwMCAweDgwIDB4NDAwMDAwMDAgMHgwIDB4NDAwMDAwMDA+Ow0KKwkJI2ludGVycnVwdC1jZWxs
cyA9IDwxPjsNCisJCWludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCisJCWludGVycnVw
dC1tYXAgPSA8MDAwMCAwIDAgMSAmZ2ljIDAgMCBHSUNfU1BJIDEwOSBJUlFfVFlQRV9MRVZFTF9I
SUdIPiwNCisJCQkJPDAwMDAgMCAwIDIgJmdpYyAwIDAgR0lDX1NQSSAxMTAgSVJRX1RZUEVfTEVW
RUxfSElHSD4sDQorCQkJCTwwMDAwIDAgMCAzICZnaWMgMCAwIEdJQ19TUEkgMTExIElSUV9UWVBF
X0xFVkVMX0hJR0g+LA0KKwkJCQk8MDAwMCAwIDAgNCAmZ2ljIDAgMCBHSUNfU1BJIDExMiBJUlFf
VFlQRV9MRVZFTF9ISUdIPjsNCisJfTsNCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5U
QUlORVJTDQppbmRleCAxMDEzZTc0YjE0ZjIuLjJkMThjNzIxMzk5MSAxMDA2NDQNCi0tLSBhL01B
SU5UQUlORVJTDQorKysgYi9NQUlOVEFJTkVSUw0KQEAgLTExODM1LDYgKzExODM1LDE0IEBAIEw6
CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KIFM6CU1haW50YWluZWQNCiBG
Oglkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy8qbGF5ZXJzY2FwZSoNCiANCitQQ0kgRFJJVkVS
IEZPUiBOWFAgTEFZRVJTQ0FQRSBHRU40IENPTlRST0xMRVINCitNOglIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KK0w6CWxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCitMOgls
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCitTOglNYWludGFpbmVkDQorRjoJ
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaS1nZW40
LnR4dA0KK0Y6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaWJlaWwvcGNpLWxheWVyc2NhcGUt
Z2VuNC5jDQorDQogUENJIERSSVZFUiBGT1IgR0VORVJJQyBPRiBIT1NUUw0KIE06CVdpbGwgRGVh
Y29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPg0KIEw6CWxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcN
Ci0tIA0KMi4xNy4xDQoNCg==
