Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BD2C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4800021019
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MDalrcJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfCMOyq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:54:46 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:45122
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfCMOyp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 10:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x0+x26wOohCwHfqX2EG+NnoaV7ZUj8Wnx4O9syiV50=;
 b=MDalrcJqvN8ZS+JUWZut4KmySbO8+KTQ9LaDXoJrDF8wfyZw5HbuzAiH+wl+LzGLv8TQ5KkY1YHcQUpX+yhSVTQrpQ5RWrGoXtipIAnWH28HTWlVxTX8Ks2RNVt/36hMpgbEppA7OSxpsK54vH6sHYm4vHHGbrrJxXDAotDW8sU=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4949.eurprd04.prod.outlook.com (20.177.35.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Wed, 13 Mar 2019 14:51:48 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 14:51:48 +0000
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
Subject: RE: [PATCHv4 26/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Topic: [PATCHv4 26/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Index: AQHU1+1+Au0UBiXI7EyjDN9yTIIANKYJqKMQ
Date:   Wed, 13 Mar 2019 14:51:48 +0000
Message-ID: <AM6PR04MB5781A68E3511D6ACCAA192E3844A0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-27-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190311093130.7209-27-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [120.244.120.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d31e38c-05d1-426f-9e21-08d6a7c36b9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4949;
x-ms-traffictypediagnostic: AM6PR04MB4949:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0TUI0OTQ5OzIzOnNoYWZmZ2tGaWJMeTJxWENOZjFMZXdMeVRL?=
 =?gb2312?B?Z1p6MlNKZlRBRWpVd2lzRE5PdzFUY1M2NUkwb3B3Nk5kK1hQT0NVOHJCYkpq?=
 =?gb2312?B?Zmk0NmxpNTltT0lwcVk1UnZZbzF6eFhhcHFzUWNWNXhPYisyWmpHZVh4bm1C?=
 =?gb2312?B?TG4vbEpHOEtBbkUyRUhvS29XVjdTTjNEelJOczRrR3pucWZpRDgxUzF5Z2hC?=
 =?gb2312?B?S2VNcDhrcXZjL2xYK29pd0tlSTRybnhCMHdZeS8vQ0Vzbk1oNzQ2VUdwOENF?=
 =?gb2312?B?R1B5Nzhvc2tlUnlhYVVySlJuU014dnRpWXA2S3JMeHdpa05yRkpRYzV0c3pT?=
 =?gb2312?B?azFCUnVZSVFuT3FSREIrYjlvS3NkSjVnTU1QUnNqcGQ4U29wdkJpQTdrTmYv?=
 =?gb2312?B?bVNxWDE1UXlyUC84c2dmc29na1ZadUVSUjd3ajFLWVZjK3RVTGdRKytXa1Bz?=
 =?gb2312?B?cCtCUjlCOS85UkNyOUwxTy9WdjQvUjhhMVFYaWxoRWk1RGtrMk1KNmwvWXFG?=
 =?gb2312?B?K0ZoTGVzeVFhTHJnY2tManY5ZDl5UURsTklyNzIrNjJlek1KLzN4d0VUNW8z?=
 =?gb2312?B?MU5UV2FadzhVNytINUxtQ0FqYUNiWC9OMG8wUytQUm5VbVdsdm9lQnBPdGxO?=
 =?gb2312?B?UElYc1Y4SlJvVXo1VHI4dXdMckJrdmwyN1lwd1Z0a082alp6WmRJUEs5ckxm?=
 =?gb2312?B?MVV3QzhIVm51ZTBrK0JZV0RmbDZnV0htam1tR1ZkdldlbFpkYjBGZDlFUnNr?=
 =?gb2312?B?MTZhb0tmcEx4OC8zMEtHbEc2NHpXWXozSy83YkRyUFRmYVJwRmNBOVBUMHhl?=
 =?gb2312?B?dkRnUDZrYytiMTFwZU9zUUZVamlYR3FSZlhYUG9VQjFJRUdrTDNNVmNQcXdC?=
 =?gb2312?B?QTNLWld0YkhzZTd4TTlHRmlKbG55QVAyNWVpUTF4ZHk2T2VTMU1mM0VmK0J1?=
 =?gb2312?B?TDdsZDB1bTYyV0Z5QngyVUJMTUpDVVRVT2EycWp2c2FHZ21CMDZVRjVwRUxM?=
 =?gb2312?B?RDhQYTFHeHlONmtYRUU3dHZla0tESlk1MXhyMmxCc0V6N01ZNmZKUDJsK1dG?=
 =?gb2312?B?OHNDbG9oTWlPQVdwYnB4eUJmUEhUMjlRRmpERzNNK3c2S04vdjBCY2QzbzVR?=
 =?gb2312?B?cktkMFRXU0VmMGFOY0RZSEw0ZXE4QWkzcFIxN0V2Y0xkS01WZkRNRHllSmEy?=
 =?gb2312?B?bFVYNzBpMmhMKzhEcWJGcU51emVZd1BlSERQN2lyaDFyUThHRFBZYWNtb0gr?=
 =?gb2312?B?c3BBWGR5QWZaakpobHdZdWpZcXE2N05ZRHNYWG5ZeVk5UHEvLzBmSEZJT2Rl?=
 =?gb2312?B?aE5KSkpYUFVZVVZTTXZuRC9qS2dhbUtnZmZJSkFTYVBwZkdIbVU1aHVIT2I1?=
 =?gb2312?B?VmVyVUl4UW56akJ4L0Ixc0c4bWtFdkUxZzZzRWg1cDZKSy9QVU0wSmh2VWdl?=
 =?gb2312?B?eDQ2c2JEYm5QM0VNQS9MYi8xSWRxc09VTE1BbWxUTjFqeTdpdlhSUGpnR3lz?=
 =?gb2312?B?cndWMFNhbzlneHA2TlhzV056NW5xV2ZiblcxcFFSZkpLWStJMEJqOEZ6QXJ1?=
 =?gb2312?B?R3FhOS9KQ0FWNUJNdTlmZGlKMzNpSWZXbXA2bXFsbW9tSUNaRHExUzUvVXhE?=
 =?gb2312?B?K2UwbEN3Sk9tNTFPakozUXNzdjQrRU5hK1prWG05NlFRNXRnMHBLVkpUcmJK?=
 =?gb2312?B?dDlmUXNsU0g5K0FTLys0ZWJoRkg3NHVaQ2R4aWd5VE1ld2U1TENDTWl6VGQ0?=
 =?gb2312?B?NEQwS2VJdm9oS0U3RDJxSVpIQ3J6SlNneWdQL0J6Q0wvejVTcE95TlFBSDhE?=
 =?gb2312?B?WGhFSWVyWndEc3p2OG4raTRMQ1h4c0xabXZSdWlVOWJzRUQ1UnVpZXhETzlB?=
 =?gb2312?Q?gfvmSoq37wQ=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB494978A97AF85D11CEEAA1AE844A0@AM6PR04MB4949.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(396003)(346002)(53754006)(199004)(189003)(13464003)(110136005)(316002)(26005)(478600001)(54906003)(11346002)(6246003)(446003)(476003)(9686003)(99286004)(106356001)(86362001)(53546011)(25786009)(71200400001)(6506007)(105586002)(3846002)(52536013)(14444005)(97736004)(6116002)(102836004)(256004)(71190400001)(2201001)(81166006)(68736007)(5660300002)(55016002)(81156014)(66066001)(8936002)(53936002)(33656002)(2906002)(74316002)(7416002)(14454004)(7736002)(4326008)(486006)(229853002)(7696005)(76176011)(305945005)(8676002)(6436002)(2501003)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4949;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yS8xgTS6i2OvgjKh8X1cId/EDvdiJFi8NBzyIKJAYzPP6b856UdKiRKcWYJidg95BYg9mlxspHeQfOKI6K6XSP23Fsc2Aygh+fKm2Bjn2NLTOkd64l6prosoC10lBzZCNDRI3ZFn7xv95i19g7eK8mpeI1mZ5zvDCG/JYdURyeDF+iFvTghS1xfKYoid+80eRxzBV2Spdvh8zi5j0viIHfYHw50lE17J4nhsKOSx5ARHZtHjqlWTIb3xRqfVe3lZbddY1PWVYyL7JThp5VjjvszH0nZassVGbE0eArzRIRouSwjKVh3mx0GXn4d+NioKJ4oHsTGXCV18wIqGSEUp1b1kmLqu5dVlahkmqBFGhI5AJCT/1QkDJhtK0l6CbN1Z7JeUVRv/59m99At6//BAZROlf1+xVCiZ6dsb1/nQMzs=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d31e38c-05d1-426f-9e21-08d6a7c36b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 14:51:48.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4949
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWxsLA0KDQpQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gsIHJldjEuMCB3aWxsIG5vdCBiZSBw
cm9kdWN0aW9uLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogWi5xLiBIb3UNCj4gU2VudDogMjAxOcTqM9TCMTHI1SAxNzozNA0K
PiBUbzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5p
bjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2ls
bC5kZWFjb25AYXJtLmNvbQ0KPiBDYzogTWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsg
TS5oLiBMaWFuDQo+IDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBYaWFvd2VpIEJhbyA8eGlhb3dl
aS5iYW9AbnhwLmNvbT47IFoucS4gSG91DQo+IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIdjQgMjYvMjhdIFBDSTogbW9iaXZlaWw6IGxzX3BjaWVfZzQ6IGFkZCBXb3Jr
YXJvdW5kIGZvcg0KPiBBLTAxMTQ1MQ0KPiANCj4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFu
Zy5Ib3VAbnhwLmNvbT4NCj4gDQo+IFdoZW4gTFgyIFBDSWUgY29udHJvbGxlciBpcyBzZW5kaW5n
IG11bHRpcGxlIHNwbGl0IGNvbXBsZXRpb25zIGFuZCBBQ0sNCj4gbGF0ZW5jeSBleHBpcmVzIGlu
ZGljYXRpbmcgdGhhdCBBQ0sgc2hvdWxkIGJlIHNlbmQgYXQgcHJpb3JpdHkuDQo+IEJ1dCBiZWNh
dXNlIG9mIGxhcmdlIG51bWJlciBvZiBzcGxpdCBjb21wbGV0aW9ucyBhbmQgRkMgdXBkYXRlIERM
TFAsIHRoZQ0KPiBjb250cm9sbGVyIGRvZXMgbm90IGdpdmUgcHJpb3JpdHkgdG8gQUNLIHRyYW5z
bWlzc2lvbi4gVGhpcyByZXN1bHRzIGludG8gQUNLDQo+IGxhdGVuY3kgdGltZXIgdGltZW91dCBl
cnJvciBhdCB0aGUgbGluayBwYXJ0bmVyIGFuZCB0aGUgcGVuZGluZyBUTFBzIGFyZQ0KPiByZXBs
YXllZCBieSB0aGUgbGluayBwYXJ0bmVyIGFnYWluLg0KPiANCj4gV29ya2Fyb3VuZDoNCj4gMS4g
UmVkdWNlIHRoZSBBQ0sgbGF0ZW5jeSB0aW1lb3V0IHZhbHVlIHRvIGEgdmVyeSBzbWFsbCB2YWx1
ZS4NCj4gMi4gUmVzdHJpY3QgdGhlIG51bWJlciBvZiBjb21wbGV0aW9ucyBmcm9tIHRoZSBMWDIg
UENJZSBjb250cm9sbGVyDQo+ICAgIHRvIDEsIGJ5IGNoYW5naW5nIHRoZSBNYXggUmVhZCBSZXF1
ZXN0IFNpemUgKE1SUlMpIG9mIGxpbmsgcGFydG5lcg0KPiAgICB0byB0aGUgc2FtZSB2YWx1ZSBh
cyBNYXggUGFja2V0IHNpemUgKE1QUykuDQo+IA0KPiBUaGlzIHBhdGNoIGltcGxlbWVudGVkIHBh
cnQgMSwgdGhlIHBhcnQgMiBjYW4gYmUgc2V0IGJ5IGtlcm5lbCBwYXJhbWV0ZXINCj4gJ3BjaT1w
Y2llX2J1c19wZXJmJw0KPiANCj4gVGhpcyBFUlJBVEEgaXMgb25seSBmb3IgTFgyMTYwQSBSZXYx
LjAsIGFuZCBpdCB3aWxsIGJlIGZpeGVkIGluIFJldjIuMC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+IC0tLQ0KPiBWNDoNCj4gIC0g
bm8gY2hhbmdlDQo+IA0KPiAgLi4uL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNj
YXBlLWdlbjQuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8ICA0ICsrKysNCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jDQo+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCj4gaW5kZXggZDJjNWRiYmQ1
ZTNjLi4yMGNlMTQ2Nzg4Y2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jDQo+IEBAIC04MiwxMiArODIsMjcg
QEAgc3RhdGljIGJvb2wgbHNfcGNpZV9nNF9pc19icmlkZ2Uoc3RydWN0IGxzX3BjaWVfZzQNCj4g
KnBjaWUpDQo+ICAJcmV0dXJuIGhlYWRlcl90eXBlID09IFBDSV9IRUFERVJfVFlQRV9CUklER0U7
ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgd29ya2Fyb3VuZF9BMDExNDUxKHN0cnVjdCBsc19wY2ll
X2c0ICpwY2llKSB7DQo+ICsJc3RydWN0IG1vYml2ZWlsX3BjaWUgKm12X3BjaSA9IHBjaWUtPnBj
aTsNCj4gKwl1MzIgdmFsOw0KPiArDQo+ICsJLyogU2V0IEFDSyBsYXRlbmN5IHRpbWVvdXQgKi8N
Cj4gKwl2YWwgPSBjc3JfcmVhZGwobXZfcGNpLCBHUEVYX0FDS19SRVBMQVlfVE8pOw0KPiArCXZh
bCAmPSB+KEFDS19MQVRfVE9fVkFMX01BU0sgPDwgQUNLX0xBVF9UT19WQUxfU0hJRlQpOw0KPiAr
CXZhbCB8PSAoNCA8PCBBQ0tfTEFUX1RPX1ZBTF9TSElGVCk7DQo+ICsJY3NyX3dyaXRlbChtdl9w
Y2ksIHZhbCwgR1BFWF9BQ0tfUkVQTEFZX1RPKTsgfQ0KPiArDQo+ICBzdGF0aWMgaW50IGxzX3Bj
aWVfZzRfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2kpICB7DQo+ICAJc3RydWN0
IGxzX3BjaWVfZzQgKnBjaWUgPSB0b19sc19wY2llX2c0KHBjaSk7DQo+IA0KPiAgCXBjaWUtPnJl
diA9IGNzcl9yZWFkYihwY2ksIFBDSV9SRVZJU0lPTl9JRCk7DQo+IA0KPiArCWlmIChwY2llLT5y
ZXYgPT0gUkVWXzFfMCkNCj4gKwkJd29ya2Fyb3VuZF9BMDExNDUxKHBjaWUpOw0KPiArDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21v
Yml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KPiBpbmRleCBhYjQzZGU1ZTRiMmIuLmYwZTJlNGFlMDli
NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1v
Yml2ZWlsLmgNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1v
Yml2ZWlsLmgNCj4gQEAgLTg1LDYgKzg1LDEwIEBADQo+ICAjZGVmaW5lIFBBQl9BWElfQU1BUF9Q
RVhfV0lOX0god2luKQlQQUJfUkVHX0FERFIoMHgwYmFjLA0KPiB3aW4pDQo+ICAjZGVmaW5lIFBB
Ql9JTlRQX0FYSV9QSU9fQ0xBU1MJCTB4NDc0DQo+IA0KPiArI2RlZmluZSBHUEVYX0FDS19SRVBM
QVlfVE8JCTB4NDM4DQo+ICsjZGVmaW5lICBBQ0tfTEFUX1RPX1ZBTF9NQVNLCQkweDFmZmYNCj4g
KyNkZWZpbmUgIEFDS19MQVRfVE9fVkFMX1NISUZUCQkwDQo+ICsNCj4gICNkZWZpbmUgUEFCX1BF
WF9BTUFQX0NUUkwod2luKQkJUEFCX1JFR19BRERSKDB4NGJhMCwgd2luKQ0KPiAgI2RlZmluZSAg
QU1BUF9DVFJMX0VOX1NISUZUCQkwDQo+ICAjZGVmaW5lICBBTUFQX0NUUkxfVFlQRV9TSElGVAkJ
MQ0KPiAtLQ0KPiAyLjE3LjENCg0K
