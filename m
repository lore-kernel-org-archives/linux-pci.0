Return-Path: <SRS0=piPB=QZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61542C43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1966B218C3
	for <linux-pci@archiver.kernel.org>; Mon, 18 Feb 2019 07:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KyBNylBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfBRHP2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:15:28 -0500
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:19626
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727098AbfBRHP2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Feb 2019 02:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6Xtw05WaUuXRNd/x58wF0BJvqVQg7ll5G8WFa4TwAQ=;
 b=KyBNylBPu4pWBsaRLTT8UYkFMW3IyGha5uiColPvk34TIzhk719ynJ6zfE+y4DhHjpvffRlxOcXQ7nr76KI2Idub+ORto8AGlwM2fgw8YB4jutZ+bLlBfpreMnKeM8y1EkYnVpqzSGHiFureTyibF+P5hcBnMbZGEe6/hHem3po=
Received: from VI1PR04MB5792.eurprd04.prod.outlook.com (20.178.204.10) by
 VI1PR04MB4319.eurprd04.prod.outlook.com (52.134.122.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 07:15:22 +0000
Received: from VI1PR04MB5792.eurprd04.prod.outlook.com
 ([fe80::2092:3c87:6c03:be2d]) by VI1PR04MB5792.eurprd04.prod.outlook.com
 ([fe80::2092:3c87:6c03:be2d%2]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 07:15:22 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Topic: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Thread-Index: AQHUt6oS419VgGFb5EOSmkHnfUrSZqXV59SAgAAZtICADzja4A==
Date:   Mon, 18 Feb 2019 07:15:22 +0000
Message-ID: <VI1PR04MB57927A11B589323E30E45BF884630@VI1PR04MB5792.eurprd04.prod.outlook.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
 <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
 <20190208141315.GU7268@google.com>
In-Reply-To: <20190208141315.GU7268@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca3825d2-e8d7-4872-7807-08d69570d8ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4319;
x-ms-traffictypediagnostic: VI1PR04MB4319:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtWSTFQUjA0TUI0MzE5OzIzOmdxekJEK2Q3OUlEckFHb3lNYWhKR2g5Y2hw?=
 =?gb2312?B?ci9nakFFMnU1UFJVaDZLQjV5NkNMSnJGU3RCK3ROZE5vbjlDYTFTMFRTSGNR?=
 =?gb2312?B?bEluZzV0b0dyZEZmSE1DMzAzZTZyU2thSGhzWTJsYzVmQW5UbFlNK2xKUDRZ?=
 =?gb2312?B?a3llNTh0T2xoWmxBU3dmRDh6d25uWWtvRDUwRVpJLzlqbmRCRlVUK09aQzVr?=
 =?gb2312?B?cEhBUi9ubjYreFZWYXAzVi92TFdyRzNFdDRiMFBXaFozN29uOWdITE9FVkVa?=
 =?gb2312?B?OTJQK04vMlY5QVB1eDhLb3JJVVpiZDZpdlBvNzBIa0x1eGo1dWRuSGpnSUJs?=
 =?gb2312?B?ei9JOExiU1VLNEJtT1N2R1hIUWptTHprbkhJZWhaa29hWk9MaUNkSWpyVFZm?=
 =?gb2312?B?SFVxOFlUc2sxS1ErZStxQVZCTVpnY0dCQmFhbGg4RUtocXFvMHJCT0VvUUg0?=
 =?gb2312?B?U0MvS2h3N0xhQ1RVUzRIMjVwL0tSYmhYaWZlMTdNNGovSGtadUZ3NUJ6QmlZ?=
 =?gb2312?B?VnNnaGZQejBmVVJGTDdJQlg2MklyNDh5d3FsOElsMm9pbFg4TmVFdXdlcDc3?=
 =?gb2312?B?S1A1aUF4ekM5Q24yYXRCQllYSzlOOHBIOFpzakRmV2N4TWl0bmdBSjA4S0ps?=
 =?gb2312?B?TU9ERWh5Mkt1UUFXd1NVNkZ1c2s1OStWblFlVjdCM3QwZm1ZUmZaZjVnQ2lB?=
 =?gb2312?B?RkhaajZaNXdvTGtobEI2ZWloQjlWZ2F2M1ZueFJHMkJhSWxlK0ZBZ0JFaFJq?=
 =?gb2312?B?MVlaNXJNME1Ua3pHcTFYZ3ZONHRBdUNMZTdSS0JwZTlVbWcvOFpLNnhGZVFI?=
 =?gb2312?B?ZTBab1M5MTdXbTNzVDlqeTcvTXNwMXF3WVM5M2RFYmozZkwwb3ZpZTRRTlY5?=
 =?gb2312?B?dlJETWh6c1Zyd2loSHZRQmprTTBUQ3NwNi9aNUdQQUx0SEg4QVdUV0t5RFBZ?=
 =?gb2312?B?UjdEYlB1b1ErQkt5aElsNk1SNGNSYm5SVG1wQVZGZGFnQ1JPd0o0OVFwVFpx?=
 =?gb2312?B?Ty9aaE1JTGo3TzNrZ3lZdzQ0VS9uaVZyNm1KRzFVNnRVS21tL0Ivdy9yVVRM?=
 =?gb2312?B?L0xPOU9rUWRoLzlPZThpMHUrMWg0MTZpZWVwbW5kcDNaZmhlV3FJd0MvbGgy?=
 =?gb2312?B?LzZ6ZXM3UTgrckQ2cG1jamJ6VzJlL0I5NVlOa1dEKzl1WnhKMktHN1hVVm9y?=
 =?gb2312?B?dUlMbU9wSzczaXdmZnRYQUlPaGNFWjQzNjJhRXpwUks4Y3ZGM08wajRvckg3?=
 =?gb2312?B?bEdZdW9sR1B2UGNMbDFjYkdQQ0RZTmFwRWpmcGRvbFJhSit3WTlSZ3BTREtR?=
 =?gb2312?B?WnAwL2hzQ3dseXV4T1dtNWs2ZlBKZ2FreGFFN2NNSEhCYmN1WmdIaWRXS0JX?=
 =?gb2312?B?MktqQzF3L3k1RjhEYitYamJpL2krd2xIZy94M0J0TjNiaGdNUzRzWmRITWhD?=
 =?gb2312?B?UnhBN3BiNEdaOGtFMC9OMXNOVUxYZ25qZmVEWXJEVXJRL2lON3hmZVYrSEpi?=
 =?gb2312?B?Z3NvYUlYNU9RdFJTWW9ITHJXL1VZT25SdW9kMyttb3dTb20zWGJYS3NjNTha?=
 =?gb2312?B?N0ZwdXNIdTFHelhnR0xjRGpoVTFFbFhNNlI0cnZpUjdSZlJUUTBmQUZvWTli?=
 =?gb2312?B?dWhRSm1UQ0UzQzQyMEZBZFVFK2ZtRi8rL0JTUmM2cWFNOE9JZTBidjZMNE5l?=
 =?gb2312?B?ZVA2QnI1WlJsNW9yaUhGZUZiN1hwaDlYY21QY3I0enFBS0dHMjZ0MWROQWdQ?=
 =?gb2312?Q?aZ7bEf3F+zJSdm+2f4Kkkkm5W5qzrwreji1YA=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB43198EBC461878DC52C86D3784630@VI1PR04MB4319.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(13464003)(105586002)(97736004)(14454004)(6246003)(7416002)(229853002)(106356001)(74316002)(7736002)(8936002)(9686003)(55016002)(33656002)(4326008)(186003)(53936002)(26005)(102836004)(6506007)(71190400001)(71200400001)(25786009)(53546011)(6436002)(11346002)(256004)(305945005)(478600001)(486006)(476003)(2906002)(68736007)(8676002)(446003)(76176011)(110136005)(54906003)(5660300002)(86362001)(5024004)(6116002)(66066001)(316002)(7696005)(3846002)(14444005)(99286004)(81156014)(93886005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4319;H:VI1PR04MB5792.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tZJdWmlXxbxTJPxAkNCpxJhm16B7utduCHOX/3YlwD6Wsmvrbps+h0XciRY8YapSO0nXHpKNvfHqrjqrNCn9CuWYpTAJwsLR99dk5J3lnU/drx3c1X2fvvQ61JlORskpedDSNWadD8983VyDCEtJnFmxVc6WkKdwqnx5viQTKV6lk1oH6GyJto/LnqrkURA0CKkiiHOPv+0XgpDecew90p+e21rPZH2FMNT0YWxqCN/Iplzmzxa4r1i1KGZgFrvdz4M/10LpMS0Ns0gLlkgn/+ZS/5EmuiFcLVlok12JwX41khW1mPXqW4XCkzjPd61zjuUj1l+y/Z7UdQE0WadS5RxoXFk4L6ySdHUrQ/nruUAsPG9Ewfxyx4QJWYCit+yO0PEuBk7urOjd3LjwSm3+84OLNAhaBhdK/KujY9yFXZY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3825d2-e8d7-4872-7807-08d69570d8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 07:15:22.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4319
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IDIwMTnE6jLUwjjI1SAyMjoxMw0KPiBUbzogU3VicmFobWFueWEgTGlu
Z2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQo+IENjOiBaLnEuIEhvdSA8emhp
cWlhbmcuaG91QG54cC5jb20+OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IFhpYW93ZWkgQmFvDQo+
IDx4aWFvd2VpLmJhb0BueHAuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgd2lsbC5k
ZWFjb25AYXJtLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGVvIExpIDxs
ZW95YW5nLmxpQG54cC5jb20+OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47
IHJvYmgrZHRAa2VybmVsLm9yZzsgTWluZ2thaSBIdQ0KPiA8bWluZ2thaS5odUBueHAuY29tPjsg
Y2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgVGhvbWFzIFBldGF6em9uaQ0KPiA8dGhvbWFz
LnBldGF6em9uaUBib290bGluLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSHYzIDE3LzI3XSBQ
Q0k6IG1vYml2ZWlsOiBmaXggdGhlIGNoZWNraW5nIG9mIHZhbGlkIGRldmljZQ0KPiANCj4gWytj
YyBUaG9tYXNdDQo+IA0KPiBPbiBGcmksIEZlYiAwOCwgMjAxOSBhdCAwNjoxMToxNVBNICswNTMw
LCBTdWJyYWhtYW55YSBMaW5nYXBwYSB3cm90ZToNCj4gPiBPbiBUdWUsIEphbiAyOSwgMjAxOSBh
dCAxOjQwIFBNIFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiA+DQo+
ID4gPiBBdm9pZCB0byBpc3N1ZSBDRkcgdHJhbnNhY3Rpb25zIHRvIGxpbmsgcGFydG5lciB3aGVu
IHRoZSBQQ0llIGxpbmsNCj4gPiA+IGlzIG5vdCB1cC4gQW5kIGFsbG93IENGRyB0cmFuc2FjdGlv
bnMgdG8gYWxsIGZ1bmN0aW9ucyBvZiBFbmRwb2ludA0KPiA+ID4gaW1wbGVtZW50ZWQgbXVsdGlw
bGUgZnVuY3Rpb25zLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA5YWY2YmNiMTFlMTIgKCJQQ0k6IG1v
Yml2ZWlsOiBBZGQgTW9iaXZlaWwgUENJZSBIb3N0IEJyaWRnZQ0KPiA+ID4gSVAgZHJpdmVyIikN
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+
DQo+ID4gPiBSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiBWMzoNCj4gPiA+ICAtIE5vIGNoYW5nZQ0KPiA+ID4NCj4gPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jIHwg
NiArKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMNCj4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLWhvc3QuYw0KPiA+ID4gaW5kZXggZGM1MzI0ZDk0
NDY2Li4xYWU4MmU3OTA1NjIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jDQo+ID4gPiBAQCAtMjks
NiArMjksMTAgQEAgc3RhdGljIGJvb2wgbW9iaXZlaWxfcGNpZV92YWxpZF9kZXZpY2Uoc3RydWN0
DQo+ID4gPiBwY2lfYnVzICpidXMsIHVuc2lnbmVkIGludCBkZXZmbikgIHsNCj4gPiA+ICAgICAg
ICAgc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUgPSBidXMtPnN5c2RhdGE7DQo+ID4gPg0KPiA+
ID4gKyAgICAgICAvKiBJZiB0aGVyZSBpcyBubyBsaW5rLCB0aGVuIHRoZXJlIGlzIG5vIGRldmlj
ZSAqLw0KPiA+ID4gKyAgICAgICBpZiAoYnVzLT5udW1iZXIgPiBwY2llLT5ycC5yb290X2J1c19u
cg0KPiAmJiAhbW9iaXZlaWxfcGNpZV9saW5rX3VwKHBjaWUpKQ0KPiA+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCj4gPiA+ICsNCj4gPiA+ICAgICAgICAgLyogT25seSBvbmUgZGV2
aWNlIGRvd24gb24gZWFjaCByb290IHBvcnQgKi8NCj4gPiA+ICAgICAgICAgaWYgKChidXMtPm51
bWJlciA9PSBwY2llLT5ycC5yb290X2J1c19ucikgJiYgKGRldmZuID4gMCkpDQo+ID4gPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gQEAgLTM3LDcgKzQxLDcgQEAgc3RhdGlj
IGJvb2wgbW9iaXZlaWxfcGNpZV92YWxpZF9kZXZpY2Uoc3RydWN0DQo+IHBjaV9idXMgKmJ1cywg
dW5zaWduZWQgaW50IGRldmZuKQ0KPiA+ID4gICAgICAgICAgKiBEbyBub3QgcmVhZCBtb3JlIHRo
YW4gb25lIGRldmljZSBvbiB0aGUgYnVzIGRpcmVjdGx5DQo+ID4gPiAgICAgICAgICAqIGF0dGFj
aGVkIHRvIFJDDQo+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gLSAgICAgICBpZiAoKGJ1cy0+cHJp
bWFyeSA9PSBwY2llLT5ycC5yb290X2J1c19ucikgJiYgKGRldmZuID4gMCkpDQo+ID4gPiArICAg
ICAgIGlmICgoYnVzLT5wcmltYXJ5ID09IHBjaWUtPnJwLnJvb3RfYnVzX25yKSAmJg0KPiA+ID4g
KyAoUENJX1NMT1QoZGV2Zm4pID4gMCkpDQo+IA0KPiA+IGhlcmUgY2hhbmdlICJwcmltYXJ5IiB0
byAibnVtYmVyIiwgYXMgaXQncyBhIGJ1ZyBpbiB0aGUgb3JpZ2luYWwgZHJpdmVyIHRvby4NCj4g
DQo+IFRoaXMgbG9va3MgbGlrZSBpdCBzaG91bGQgYmUgc3BsaXQgaW50byB0d28gcGF0Y2hlczog
KDEpIGNoZWNraW5nIGZvciBsaW5rIHVwLCBhbmQNCj4gKDIpIGNoZWNraW5nIHJvb3RfYnVzX25y
Lg0KDQpZZXMsIHdpbGwgc3BsaXQgdGhpcyBwYXRjaCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+
IEFuZCBpZiB5b3UgbWVhbiAiYnVzLT5wcmltYXJ5ID09IHBjaWUtPnJwLnJvb3RfYnVzX25yIiBp
cyBhIGJ1ZyBpbg0KPiBwY2ktYWFyZHZhcmsuYywgdG9vLCBpdCBpcyBpbXBlcmF0aXZlIHRvIGZp
eCB0aGF0IGJ1ZyBhbHNvICh3aXRoIGEgc2VwYXJhdGUgcGF0Y2gpLg0KDQpJdCBpcyBub3QgYSBi
dWcsIGJ1dCB0aGUgYnVnIGlzIHRvIGxpbWl0IG11bHRpcGxlIGZ1bmN0aW9uIEVQIChkZXZmbiA+
IDApLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
