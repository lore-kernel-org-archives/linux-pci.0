Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FE0C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCA32184E
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDwWbwcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBRHOT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:14:19 -0500
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:51730
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727098AbfBRHOS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Feb 2019 02:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4sFvRsDcc6K3ea+qmYYrDSyZv/2/3Y8R9KngDcz5K4=;
 b=DDwWbwcgW1mS74UWcp+acW9g7D4Hhl5y6+Q1gYnJ5EBFTj9wAwe6ErDnGbEWiEin1v6JdONu8N1amRNUH73oayB2IDXJnghbVSxJf8UJWtwn4cFd5JClt8O5TJi2IxYXjUVYjwYwLZt6JtfDUU2zWIRG4LN2RsUSVAbc0HEcdD8=
Received: from VI1PR04MB5792.eurprd04.prod.outlook.com (20.178.204.10) by
 VI1PR04MB4319.eurprd04.prod.outlook.com (52.134.122.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 07:14:12 +0000
Received: from VI1PR04MB5792.eurprd04.prod.outlook.com
 ([fe80::2092:3c87:6c03:be2d]) by VI1PR04MB5792.eurprd04.prod.outlook.com
 ([fe80::2092:3c87:6c03:be2d%2]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 07:14:12 +0000
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
Subject: RE: [PATCHv3 25/27] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Topic: [PATCHv3 25/27] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Index: AQHUt6ovZBcKHJqyUUSJmvZsRQEfiqXV6zIAgA9XvFA=
Date:   Mon, 18 Feb 2019 07:14:12 +0000
Message-ID: <VI1PR04MB5792B69499AAC2493756BD8D84630@VI1PR04MB5792.eurprd04.prod.outlook.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-26-Zhiqiang.Hou@nxp.com>
 <CAFZiPx24PEE6LnUaY5MiQ_QDLbwkF-BvWe8s9ycUDVH-dN2_xg@mail.gmail.com>
In-Reply-To: <CAFZiPx24PEE6LnUaY5MiQ_QDLbwkF-BvWe8s9ycUDVH-dN2_xg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd4abb1c-11a7-420f-ebc7-08d69570af35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4319;
x-ms-traffictypediagnostic: VI1PR04MB4319:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0MzE5OzIzOndMM1JhWmVKM1RLNXlKakNvVWtqNjBqbkFm?=
 =?utf-8?B?Q0h6UlkvdW1sbzVWV0NuQnpURVZscUVueElkYnM3V0dKdlRWUTlHYjUrTG8x?=
 =?utf-8?B?K2x3a2xUNlFPUUpXZmd0bzU4VVE3SmFDQ0pYUUgzSjBvOHFzSCs4RUY2ankz?=
 =?utf-8?B?czdSMnJtc3VsTmRycjRpWFJGREpmcEpoUkhEMzVEWm1reG5SRldlcGRhaVVa?=
 =?utf-8?B?YWhnYjF3Y0xGQkhicUlQdStEVGZ5WC9RQXlNd25OaGI0aVpCWFFOaExHVHQ5?=
 =?utf-8?B?Z0I4UldmVHJsL1ArRnl0RktjdkJneHBYcmRaOTlYZXk4Tlg4bkdNRzVJS3RL?=
 =?utf-8?B?REtvSGNOZUcxY2IyaGdtV25haksrQmRSV2ZUS0xPZEpzMUxIOElNQWZ0TnZa?=
 =?utf-8?B?NElmanBXY21sOEE3UjlyQ1ZDbmZQRXlKQ05uMDh6czlvbVphQWVEbnowakRU?=
 =?utf-8?B?YmVNRXpOYmtHOGZEdUhkd0Y2b0c1bmhGT2dzWnNWNU16NVEzcHFrdDREenVi?=
 =?utf-8?B?Z3EybEpIZkdkWUgySXIrVUVQUTBtbGRuSTdDUHMraHVaaVNkQjIyOXFzQ2sr?=
 =?utf-8?B?RWZsczllOGZENDE4L1lzd09DNU44L2k3NEtMbUE0MEl2bGtlMGplWlJCcnNj?=
 =?utf-8?B?cTNrZkcwUEtDYWltZFcvT2hyaU1SL3drM1FjaWJVUFlPUzQ4aVRxWE9McmJq?=
 =?utf-8?B?b0N3cGFHMVNuL2NuZ3kzQ2xRanpQVCtWVHgvT3N0NjNUS0tWV3R3a29MbDlX?=
 =?utf-8?B?Yzg0c0pTd2Z1TUROc2Y1Nmc4Q21GZEZXRHNPem9pd05nZWN5TEx3YjhkMHRs?=
 =?utf-8?B?VEFicWZaYWlkaGlIR1JWMWlleXFUNEJJUzVBSXgxQ2x0SmVzWmE1b05xV2du?=
 =?utf-8?B?NGZxUzBnc2Zuci9HYktwdUFYUEhxbGxKVlNtWHY3MVoyOXUzeHV1cjl1L0dJ?=
 =?utf-8?B?Z3FhOWNHQ2hpbE55T3dGOFMvb1Q3UjlCOEgzUDRUamNhRlRKZVgwL053dFVO?=
 =?utf-8?B?WStJME1vTFNQRE5EeEc2R1dLbEgwVDI5My9EWGF0SVBQSUpvVlUvL0xQQ01i?=
 =?utf-8?B?Z0RaUUhsSmVJRUJISDNEN1h1RDNyL3RnRkM2S1BtYk9lTC92RUJNc1hyM0hk?=
 =?utf-8?B?dHlYSS9EajFEQ3Y3eTVEU09EbzlTc2pmbjZRNzhzdlIvV0M5OWZQSXRTVlpY?=
 =?utf-8?B?clpadmNGcDA3MWFoSGdCNjdaSVM4bzJMK016N3NHRms2alFkU2Z0TnQwWVF2?=
 =?utf-8?B?RytvS0RGWDZTQVVsQU44NzNqcFFjQkZaTzBpYXRjcmNFMm1QRVRQR1p6SDlx?=
 =?utf-8?B?aVdPYWpMZjk2eUNlMXlMWUhYR1lUR3VLKytiT0VpekJKbE8yUnlDZm9WL1FE?=
 =?utf-8?B?RG1VZFJNTGF2WWtaYVY3bENXMUM4QXVQY1p2VHplWWo2djd5NitIeVl0clNo?=
 =?utf-8?B?SllYUmRmREN4a09DaDdCd2VwbXowcGFUTmVnT2s2QzdsYnVMNG9uZHVnOC9W?=
 =?utf-8?B?Wm9vOFlld2VQMVhLSnZkZDQreWJDMitZVWdoMlVpTENvMklVRE53RWI2QnFR?=
 =?utf-8?B?dWtiU1dHQ2FmYnpVQ2VPMERFbS9ZMXdYaEFIaWEwUW9YenNmOWhVanAxSzlz?=
 =?utf-8?B?UTZIL25ab0g3OFZoNGZIMUxUK1ZiNWZkY1hkTzR6NUozaWhNcmgzeUhzTXJI?=
 =?utf-8?B?RkUwUEtRQVkyQlNIRGRrSWx1Z0I2WFNBUElhMWZLN2JNSDdqR0RoQ1ZuZVVj?=
 =?utf-8?B?MVo5dDB4aEN3cm5Yc3I4M1MvU2hRMU16UFJJS1FncmQzWG8xR1I0MG0wb1ZH?=
 =?utf-8?Q?GKnrgcJCtBmnp?=
x-microsoft-antispam-prvs: <VI1PR04MB43191F076F9190B706360B6184630@VI1PR04MB4319.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(13464003)(105586002)(97736004)(14454004)(6246003)(966005)(7416002)(229853002)(6306002)(45080400002)(106356001)(74316002)(7736002)(8936002)(9686003)(55016002)(33656002)(4326008)(186003)(53936002)(26005)(102836004)(6506007)(71190400001)(71200400001)(25786009)(53546011)(6436002)(11346002)(6916009)(256004)(305945005)(478600001)(486006)(476003)(2906002)(68736007)(8676002)(446003)(76176011)(54906003)(5660300002)(86362001)(6116002)(66066001)(316002)(7696005)(3846002)(14444005)(99286004)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4319;H:VI1PR04MB5792.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /eSUMF2GX4+XsMOIfePgauYeLvHERyy6HEO4GdUUrBJTR2tXtmqXpE/9ERoeePVkgibGJDjtC2+7lG6s/NS3odOLp84zHtnofuH5S11MrIF4qb4pUjHhIkUMJFqxloFuO0BALTswr0mFOe+XpFsP1KQaD/oQ1kKU9SVVkX4ZEpqyGxjl3Bv7ftuhRAZ1u4ld2Pp1bLdkfE3e+y8cK487O4K3o5Yk7f3VJb3zSeZWU46sa3IUVdy07GXjA6z0K6nWOuwc2bpQJj+bdUKK1pCBSN93jclbHCkov04wssv84NLEU6QQvwKUJ2YS4llNNOBEgEK4dGoT4ImHdAntDPyPjEX3NE33LP9CdlXUjc+qLQzs5vPwzLyGtpW3lSASVWGXMFV3wBBMhVdjhrvw7tjWaHMGybo7pkX+tl3/7LN30Tk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4abb1c-11a7-420f-ebc7-08d69570af35
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 07:14:12.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4319
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3ViYnUsDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJy
YWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gU2VudDogMjAxOeW5tDLmnIg45pelIDIwOjUzDQo+
IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBh
cm0uY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Ow0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjMgMjUvMjddIFBDSTogbW9i
aXZlaWw6IGxzX3BjaWVfZzQ6IGFkZCBXb3JrYXJvdW5kIGZvcg0KPiBBLTAxMTQ1MQ0KPiANCj4g
WlEsDQo+IA0KPiBPbiBUdWUsIEphbiAyOSwgMjAxOSBhdCAxOjQxIFBNIFoucS4gSG91IDx6aGlx
aWFuZy5ob3VAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gV2hlbiBMWDIgUENJZSBjb250cm9sbGVyIGlz
IHNlbmRpbmcgbXVsdGlwbGUgc3BsaXQgY29tcGxldGlvbnMgYW5kIEFDSw0KPiA+IGxhdGVuY3kg
ZXhwaXJlcyBpbmRpY2F0aW5nIHRoYXQgQUNLIHNob3VsZCBiZSBzZW5kIGF0IHByaW9yaXR5Lg0K
PiA+IEJ1dCBiZWNhdXNlIG9mIGxhcmdlIG51bWJlciBvZiBzcGxpdCBjb21wbGV0aW9ucyBhbmQg
RkMgdXBkYXRlIERMTFAsDQo+ID4gdGhlIGNvbnRyb2xsZXIgZG9lcyBub3QgZ2l2ZSBwcmlvcml0
eSB0byBBQ0sgdHJhbnNtaXNzaW9uLiBUaGlzDQo+ID4gcmVzdWx0cyBpbnRvIEFDSyBsYXRlbmN5
IHRpbWVyIHRpbWVvdXQgZXJyb3IgYXQgdGhlIGxpbmsgcGFydG5lciBhbmQNCj4gPiB0aGUgcGVu
ZGluZyBUTFBzIGFyZSByZXBsYXllZCBieSB0aGUgbGluayBwYXJ0bmVyIGFnYWluLg0KPiA+DQo+
ID4gV29ya2Fyb3VuZDoNCj4gPiAxLiBSZWR1Y2UgdGhlIEFDSyBsYXRlbmN5IHRpbWVvdXQgdmFs
dWUgdG8gYSB2ZXJ5IHNtYWxsIHZhbHVlLg0KPiA+IDIuIFJlc3RyaWN0IHRoZSBudW1iZXIgb2Yg
Y29tcGxldGlvbnMgZnJvbSB0aGUgTFgyIFBDSWUgY29udHJvbGxlcg0KPiA+ICAgIHRvIDEsIGJ5
IGNoYW5naW5nIHRoZSBNYXggUmVhZCBSZXF1ZXN0IFNpemUgKE1SUlMpIG9mIGxpbmsgcGFydG5l
cg0KPiA+ICAgIHRvIHRoZSBzYW1lIHZhbHVlIGFzIE1heCBQYWNrZXQgc2l6ZSAoTVBTKS4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50ZWQgcGFydCAxLCB0aGUgcGFydCAyIGNhbiBiZSBz
ZXQgYnkga2VybmVsDQo+ID4gcGFyYW1ldGVyICdwY2k9cGNpZV9idXNfcGVyZicNCj4gPg0KPiA+
IFRoaXMgRVJSQVRBIGlzIG9ubHkgZm9yIExYMjE2MEEgUmV2MS4wLCBhbmQgaXQgd2lsbCBiZSBm
aXhlZCBpbg0KPiA+IFJldjIuMC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFu
ZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gVjM6DQo+ID4gIC0gSW50ZWdy
YXRlZCB3aXRob3V0IGNoYW5nZSBmcm9tDQo+ID4NCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGcGF0Yw0KPiA+DQo+IGh3
b3JrLm96bGFicy5vcmclMkZwYXRjaCUyRjEwMDY3OTYlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3po
aXFpYW4NCj4gZy5ob3UlDQo+ID4NCj4gNDBueHAuY29tJTdDOTAwNjRkNThhODI2NDMyMDcyYzEw
OGQ2OGRjNDA3OWQlN0M2ODZlYTFkM2JjMmI0Yw0KPiA2ZmE5MmNkOTkNCj4gPg0KPiBjNWMzMDE2
MzUlN0MwJTdDMCU3QzYzNjg1MjI3MDQxNTQ0NDQ0MiZhbXA7c2RhdGE9ZjBQckVmOSUyRmYlMg0K
PiBGJTJCJTJGaA0KPiA+IFRwYWNaWXBzN0hIb2RYd01ZUExOM01COHZhcVVmNCUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPiA+DQo+ID4gIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJz
Y2FwZS1nZW40LmMgfCAxNSArKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8ICA0ICsrKysNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCj4gPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jDQo+ID4gaW5k
ZXggZDJjNWRiYmQ1ZTNjLi4yMGNlMTQ2Nzg4Y2EgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCj4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYw0KPiA+
IEBAIC04MiwxMiArODIsMjcgQEAgc3RhdGljIGJvb2wgbHNfcGNpZV9nNF9pc19icmlkZ2Uoc3Ry
dWN0IGxzX3BjaWVfZzQNCj4gKnBjaWUpDQo+ID4gICAgICAgICByZXR1cm4gaGVhZGVyX3R5cGUg
PT0gUENJX0hFQURFUl9UWVBFX0JSSURHRTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCB3b3Jr
YXJvdW5kX0EwMTE0NTEoc3RydWN0IGxzX3BjaWVfZzQgKnBjaWUpIHsNCj4gPiArICAgICAgIHN0
cnVjdCBtb2JpdmVpbF9wY2llICptdl9wY2kgPSBwY2llLT5wY2k7DQo+ID4gKyAgICAgICB1MzIg
dmFsOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIFNldCBBQ0sgbGF0ZW5jeSB0aW1lb3V0ICovDQo+
ID4gKyAgICAgICB2YWwgPSBjc3JfcmVhZGwobXZfcGNpLCBHUEVYX0FDS19SRVBMQVlfVE8pOw0K
PiA+ICsgICAgICAgdmFsICY9IH4oQUNLX0xBVF9UT19WQUxfTUFTSyA8PCBBQ0tfTEFUX1RPX1ZB
TF9TSElGVCk7DQo+ID4gKyAgICAgICB2YWwgfD0gKDQgPDwgQUNLX0xBVF9UT19WQUxfU0hJRlQp
Ow0KPiA+ICsgICAgICAgY3NyX3dyaXRlbChtdl9wY2ksIHZhbCwgR1BFWF9BQ0tfUkVQTEFZX1RP
KTsgfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBsc19wY2llX2c0X2hvc3RfaW5pdChzdHJ1Y3Qg
bW9iaXZlaWxfcGNpZSAqcGNpKSAgew0KPiA+ICAgICAgICAgc3RydWN0IGxzX3BjaWVfZzQgKnBj
aWUgPSB0b19sc19wY2llX2c0KHBjaSk7DQo+ID4NCj4gPiAgICAgICAgIHBjaWUtPnJldiA9IGNz
cl9yZWFkYihwY2ksIFBDSV9SRVZJU0lPTl9JRCk7DQo+ID4NCj4gPiArICAgICAgIGlmIChwY2ll
LT5yZXYgPT0gUkVWXzFfMCkNCj4gPiArICAgICAgICAgICAgICAgd29ya2Fyb3VuZF9BMDExNDUx
KHBjaWUpOw0KPiA+ICsNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWls
LmgNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5o
DQo+ID4gaW5kZXggYWI0M2RlNWU0YjJiLi5mMGUyZTRhZTA5YjUgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KPiA+IEBA
IC04NSw2ICs4NSwxMCBAQA0KPiA+ICAjZGVmaW5lIFBBQl9BWElfQU1BUF9QRVhfV0lOX0god2lu
KSAgICBQQUJfUkVHX0FERFIoMHgwYmFjLA0KPiB3aW4pDQo+ID4gICNkZWZpbmUgUEFCX0lOVFBf
QVhJX1BJT19DTEFTUyAgICAgICAgIDB4NDc0DQo+ID4NCj4gPiArI2RlZmluZSBHUEVYX0FDS19S
RVBMQVlfVE8gICAgICAgICAgICAgMHg0MzgNCj4gPiArI2RlZmluZSAgQUNLX0xBVF9UT19WQUxf
TUFTSyAgICAgICAgICAgMHgxZmZmDQo+ID4gKyNkZWZpbmUgIEFDS19MQVRfVE9fVkFMX1NISUZU
ICAgICAgICAgIDANCj4gPiArDQo+ID4gICNkZWZpbmUgUEFCX1BFWF9BTUFQX0NUUkwod2luKSAg
ICAgICAgIFBBQl9SRUdfQUREUigweDRiYTAsDQo+IHdpbikNCj4gPiAgI2RlZmluZSAgQU1BUF9D
VFJMX0VOX1NISUZUICAgICAgICAgICAgMA0KPiA+ICAjZGVmaW5lICBBTUFQX0NUUkxfVFlQRV9T
SElGVCAgICAgICAgICAxDQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KPiBhZ2FpbiwgY2FuIHdl
IGF2b2lkIGVycmF0YSBudW1iZXIgb24gcGF0Y2ggdGl0bGUgYW5kIGhhdmUgYSBicmllZiB0aXRs
ZQ0KPiBpbnN0ZWFkPw0KDQpHZW5lcmFsbHkgd2UgZG8gbm90IHB1dCB0aGUgRVJSQVRBIGRlc2Ny
aXB0aW9uIGJ1dCBvbmx5IHRoZSBFUlJBVEEgbnVtYmVyIGludG8gdGhlIEVSUkFUQSBwYXRjaCBz
dWJqZWN0Lg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
