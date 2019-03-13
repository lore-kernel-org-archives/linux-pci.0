Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB04C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE4721019
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 14:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZzWaqxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfCMOuD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:50:03 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:56046
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbfCMOuC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Mar 2019 10:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqYR95lEcfXiN9lEXGQoZKnhDoJfmKFwfA7u3OmJTMw=;
 b=hZzWaqxXYFP9hcwFootwl6EoZ2fZI3oEMgkJVHbe+PpZ/41VLZZWNmAzDvggMqVGQMhy+P+rNxmECkLFYAPi1lHCKthxzKnGowfHPz/zy+EgeVjNSQpbXNaQxOjtTyLHv5Z9ZXd0g6oufnEY93lCtpk+z3G9JRzJF/PayjmYSB8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5830.eurprd04.prod.outlook.com (20.179.2.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 13 Mar 2019 14:49:55 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1709.011; Wed, 13 Mar 2019
 14:49:55 +0000
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
Subject: RE: [PATCHv4 26/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Topic: [PATCHv4 26/28] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Thread-Index: AQHU1+1+Au0UBiXI7EyjDN9yTIIANKYGsYyAgAEIgVCAAEbWAIABpD5w
Date:   Wed, 13 Mar 2019 14:49:54 +0000
Message-ID: <AM6PR04MB57819D27C1F4E8A0BFD6E2C5844A0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-27-Zhiqiang.Hou@nxp.com>
 <20190311173439.GH214730@google.com>
 <AM6PR04MB578187096D0CFD2B8D9C13FF84490@AM6PR04MB5781.eurprd04.prod.outlook.com>
 <20190312133452.GA210027@google.com>
In-Reply-To: <20190312133452.GA210027@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [120.244.120.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 269bf46b-8aad-4d5f-9dc4-08d6a7c32814
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5830;
x-ms-traffictypediagnostic: AM6PR04MB5830:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI1ODMwOzIzOmhVaS9MbGNCUXZoSDdEdURiMmt1MEs3blZj?=
 =?utf-8?B?MkpMbE1nZzh5Q0ZGbno0UXErcS9uMGZIWkJITXBuVmU3VGF4elg0Y3Jsejha?=
 =?utf-8?B?VW4vUysyc0NyUzZPYWlmbHVzRzNOQWN6bUI1UmloVE5QVVNaUjJTN3hHVXoz?=
 =?utf-8?B?ZFhtMFN5dWY2YzMrVHZVRmNNQVNLY3VyRUVyL3lKMnBZTDlydW1pQlREM2V5?=
 =?utf-8?B?Y094QUNOVVdXeE0yRzJzVDAybkYwVkU0UWNTMXp2NmY0NU8xTGdiS09uNHZx?=
 =?utf-8?B?NEFUVXg3cElna2VrYkpnWGcxNE1TMzlGNTlkdUw4K0NKVmVZcHN2MHZ6bEpZ?=
 =?utf-8?B?OE55K0ZwZHpEVE1rcUFuSlhrdGhmbjdvTUEvaXo2cVJJNXhPaE5wQ3NEWXpR?=
 =?utf-8?B?Vkt1bHF5WG4vZHJORTVESnl0SWo5MmtPN29KRXZBS0pzdCswdHVQbUhsZm5F?=
 =?utf-8?B?aDdGTnljUEt2Rjg3SWVrNGZQTU9KV2pjMGdqc2M1MkFtZmp1R3d1MG5NaU8w?=
 =?utf-8?B?emQ1cW85cDJLaW1mWlhjYXZLNzVvZElJWGtZYzhiZE52Rjg4UG9IenVpdnJP?=
 =?utf-8?B?WXZ4ODRsQlNPMGs2dWVEN1JUN05nSjdkMGlQRUFvd1psQXZnY3FkZHkrbTJN?=
 =?utf-8?B?Z2xHbXRvVUFxMjQ0Z3FuWDdRaTdqMjBBaDhEV2twV3ZJRzd5OFBJRzJQM0VW?=
 =?utf-8?B?ZTZldVN3c0hSTEdGOXRRUWVxNW9xOGFlbGY2MjAzRlJlaGZhOVN4MUpaeHFE?=
 =?utf-8?B?YURXZExzN010N1VCNHNYQkluemtHL1QyR1hBZXpCTmsrTmZXZG1vbTMwQi9o?=
 =?utf-8?B?eFhUOTJYYU1JME9TYUd1SEhqem9OZGIrNkc5UU1mR00zUFdTa2RwZVNodFg4?=
 =?utf-8?B?VW8zbDF0clhtcEgrcVdHV1BpaThWN0ZOZlA0MkdteHBITEpOb3N1dU0ycVRx?=
 =?utf-8?B?MEpCQXBQc3MvTEdpYmw4QTRFT2EyYmNwT05hU1ExdVo0VVZ4RTVyN2kyUWU0?=
 =?utf-8?B?UUFGWG9sQk4vUGx0YktrQ2h5VVZJSjQ3SmsrYjQxRnlLdlZHdVRDdFJPZmxj?=
 =?utf-8?B?QjhFcUZSMWJHNlljNHlUVVBaMlMrMFNVZ0tuZUovamtCcHZjNElEdTdGdUFo?=
 =?utf-8?B?bW9FM1JVZkxSR25Kc2dnWjdIRkxMVXhjRGtWVVRNZ283TUJuNVdyZVMvK1Nl?=
 =?utf-8?B?a1M0Z1BGOURrUWFUc2tqTFF1OXpoV0tpZUlaZmtvVDVGNTlqQWo2WnpqSXlM?=
 =?utf-8?B?YkRjODFoQW0zOUVPeWpOT0puQWZwTnJTTDZVaTdQODZ2d21lcjdIMWVNV0oy?=
 =?utf-8?B?cDVuby9PM3BoN3RQdFk4eGVpZmtoUFpqL0ZYVTBCQ014SXpCdk42OGNkSWcw?=
 =?utf-8?B?eU9JMXpmUStwdEtkcjhWSnFLRVdmMFZnRUtYR2xyQTNOa2U1YUtwbGJWdmJU?=
 =?utf-8?B?a00wYndSbENNQmEvc0FKSVRwdy8rWUpUMXUyL2pTMHJrUys3UW5xVTU2eDVL?=
 =?utf-8?B?MnBjd0VVUzVIL1ZrbXMrZ09wc0kwdUh1V0IrdkFmSXVoUWVManp0aERzeXlp?=
 =?utf-8?B?b3c1YkRrVVduOE5RcXZFWUxpaHZHOW83SUlvY0srZFRSZVpBUm5VUSt6dGF1?=
 =?utf-8?B?U29jMFRWdmZiYXBXOERJM1pZbjN5ckZzTW92Q01maEdIc21QVkZGS0ZtYzlt?=
 =?utf-8?B?bmliaTMxQzhTN0tDQ2pUYSt3NTJnK0NrNnNuSnQxdktHUXUxelkzMTl0c1Nt?=
 =?utf-8?Q?rW+sm0UuXIiEDHilzgCmlGvyT37AGNHh8vYPc=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5830F497ABB822E3FCC09E24844A0@AM6PR04MB5830.eurprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(13464003)(189003)(199004)(86362001)(74316002)(93886005)(229853002)(14454004)(52536013)(6916009)(8936002)(256004)(14444005)(5660300002)(26005)(71200400001)(71190400001)(105586002)(106356001)(3846002)(305945005)(6116002)(7736002)(486006)(7416002)(8676002)(2906002)(99286004)(54906003)(81156014)(66066001)(81166006)(68736007)(186003)(11346002)(6246003)(476003)(55016002)(478600001)(53546011)(6436002)(4326008)(76176011)(6506007)(97736004)(53936002)(102836004)(33656002)(316002)(25786009)(446003)(9686003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5830;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AI9T+9C92lJuPeopeGcWxuKiNpwX2nnGTbchZ4t2Cpxad5dm0pKi1HUDEAW4UeLMndWBWwXO1BEkM/7dVtc6cBU2EFEkuUMizqepotyUinORTyJRm+icLJUwkWwtmeSsMQ8Lqiw0Spnok0u4LAc7FQ18xUgFh1rpK0L/Y0/ss8MzCZTpMdrnFnA4rTTgN4eW8xp0sOHm5sWrixOjekwE0+sRUt6LnuVms0LyeHF6oPxRQqOiIqQB28wrJXWVvevZ6yBeG9bZdlS7vLO9lPcnG6mtRODy+HuZnpfTFiJtmSKhnfWblq5DSy5hts6iDBWFgULVbh24drIuIbFpzWpXukwUphYasDOZS54Le+lsIM9jqVEbGUXXLvKMKGOW09JGeJMteSbZOZH/6+J57VBgfHiTxRB9DXgJta6OjB1MbMY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269bf46b-8aad-4d5f-9dc4-08d6a7c32814
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 14:49:55.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5830
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE55bm0M+aciDEy5pelIDIxOjM1DQo+IFRvOiBaLnEu
IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0
QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWls
LmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Ow0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjQgMjYvMjhdIFBDSTogbW9i
aXZlaWw6IGxzX3BjaWVfZzQ6IGFkZCBXb3JrYXJvdW5kIGZvcg0KPiBBLTAxMTQ1MQ0KPiANCj4g
T24gVHVlLCBNYXIgMTIsIDIwMTkgYXQgMDk6MzQ6MTdBTSArMDAwMCwgWi5xLiBIb3Ugd3JvdGU6
DQo+ID4gSGkgQmpvcm4sDQo+ID4NCj4gPiBUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMh
DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBCam9y
biBIZWxnYWFzIFttYWlsdG86aGVsZ2Fhc0BrZXJuZWwub3JnXQ0KPiA+ID4gU2VudDogMjAxOeW5
tDPmnIgxMuaXpSAxOjM1DQo+ID4gPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29t
Pg0KPiA+ID4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gcm9iaCtkdEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IHJvYmgrbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5j
by5pbjsNCj4gPiA+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAu
Y29tPjsNCj4gPiA+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tOw0KPiA+ID4gd2lsbC5kZWFjb25AYXJtLmNvbTsgTWluZ2thaSBIdSA8bWluZ2thaS5o
dUBueHAuY29tPjsgTS5oLiBMaWFuDQo+ID4gPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgWGlh
b3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENI
djQgMjYvMjhdIFBDSTogbW9iaXZlaWw6IGxzX3BjaWVfZzQ6IGFkZA0KPiA+ID4gV29ya2Fyb3Vu
ZCBmb3INCj4gPiA+IEEtMDExNDUxDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBNYXIgMTEsIDIwMTkg
YXQgMDk6MzM6MzJBTSArMDAwMCwgWi5xLiBIb3Ugd3JvdGU6DQo+ID4gPiA+IEZyb206IEhvdSBa
aGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IFdoZW4gTFgy
IFBDSWUgY29udHJvbGxlciBpcyBzZW5kaW5nIG11bHRpcGxlIHNwbGl0IGNvbXBsZXRpb25zIGFu
ZA0KPiA+ID4gPiBBQ0sgbGF0ZW5jeSBleHBpcmVzIGluZGljYXRpbmcgdGhhdCBBQ0sgc2hvdWxk
IGJlIHNlbmQgYXQgcHJpb3JpdHkuDQo+ID4gPiA+IEJ1dCBiZWNhdXNlIG9mIGxhcmdlIG51bWJl
ciBvZiBzcGxpdCBjb21wbGV0aW9ucyBhbmQgRkMgdXBkYXRlDQo+ID4gPiA+IERMTFAsIHRoZSBj
b250cm9sbGVyIGRvZXMgbm90IGdpdmUgcHJpb3JpdHkgdG8gQUNLIHRyYW5zbWlzc2lvbi4NCj4g
PiA+ID4gVGhpcyByZXN1bHRzIGludG8gQUNLIGxhdGVuY3kgdGltZXIgdGltZW91dCBlcnJvciBh
dCB0aGUgbGluaw0KPiA+ID4gPiBwYXJ0bmVyIGFuZCB0aGUgcGVuZGluZyBUTFBzIGFyZSByZXBs
YXllZCBieSB0aGUgbGluayBwYXJ0bmVyIGFnYWluLg0KPiA+ID4gPg0KPiA+ID4gPiBXb3JrYXJv
dW5kOg0KPiA+ID4gPiAxLiBSZWR1Y2UgdGhlIEFDSyBsYXRlbmN5IHRpbWVvdXQgdmFsdWUgdG8g
YSB2ZXJ5IHNtYWxsIHZhbHVlLg0KPiA+ID4gPiAyLiBSZXN0cmljdCB0aGUgbnVtYmVyIG9mIGNv
bXBsZXRpb25zIGZyb20gdGhlIExYMiBQQ0llIGNvbnRyb2xsZXINCj4gPiA+ID4gICAgdG8gMSwg
YnkgY2hhbmdpbmcgdGhlIE1heCBSZWFkIFJlcXVlc3QgU2l6ZSAoTVJSUykgb2YgbGluayBwYXJ0
bmVyDQo+ID4gPiA+ICAgIHRvIHRoZSBzYW1lIHZhbHVlIGFzIE1heCBQYWNrZXQgc2l6ZSAoTVBT
KS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBpbXBsZW1lbnRlZCBwYXJ0IDEsIHRoZSBw
YXJ0IDIgY2FuIGJlIHNldCBieSBrZXJuZWwNCj4gPiA+ID4gcGFyYW1ldGVyICdwY2k9cGNpZV9i
dXNfcGVyZicNCj4gPiA+DQo+ID4gPiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB5b3UncmUg
c2F5aW5nIHRoYXQgTFgyMTYwQSBSZXYxLjAgd2lsbA0KPiA+ID4gb25seSB3b3JrIGNvcnJlY3Rs
eSBpZiB5b3UgaGF2ZSB0aGlzIHBhdGNoIGFwcGxpZWQgQU5EIHlvdSBib290IHdpdGgNCj4gPiA+
ICJwY2k9cGNpZV9idXNfcGVyZiIuDQo+ID4NCj4gPiBZb3VyIHVuZGVyc3RhbmRpbmcgaXMgY29y
cmVjdC4NCj4gPg0KPiA+ID4gVGhhdCBtaWdodCBiZSBPSyBpZiB0aGVzZSByZXYgMS4wIHBhcnRz
IGFyZSBvbmx5IHVzZWQgaW4gdGhlIGxhYiBhbmQNCj4gPiA+IGFyZSBuZXZlciBzaGlwcGVkIHRv
IGN1c3RvbWVycy4gIEJ1dCBpZiB0aGVzZSBwYXJ0cyBhcmUgZXZlciBzaGlwcGVkDQo+ID4gPiB0
byBjdXN0b21lcnMsIEkgZG9uJ3QgdGhpbmsgaXQncyBhY2NlcHRhYmxlIGZvciB0aGVtIHRvIGhh
dmUgdG8NCj4gPiA+IGZpZ3VyZSBvdXQgdGhhdCB0aGV5IG11c3QgYm9vdCB3aXRoICJwY2k9cGNp
ZV9idXNfcGVyZiIuICBZZXMsIHlvdQ0KPiA+ID4gY2FuIGRvY3VtZW50IHRoYXQgaW4gcmVsZWFz
ZSBub3RlcywgYnV0IGl0J3Mgc3RpbGwgYSBwb29yIHVzZXINCj4gPiA+IGV4cGVyaWVuY2UsIGFu
ZCB1c2VycyB3aWxsIGZvcmdldCwgYW5kIHRoZXkgd2lsbCBzZWUgbXlzdGVyaW91cw0KPiBoYXJk
LXRvLWRlYnVnIGlzc3Vlcy4NCj4gDQo+IFNpbmNlIHlvdSBkaWRuJ3QgcmVzcG9uZCBoZXJlLCBJ
IGFzc3VtZSB0aGVzZSByZXYgMS4wIHBhcnRzIGhhdmUgYmVlbiBvciB3aWxsDQo+IGJlIHNoaXBw
ZWQgdG8gZW5kIHVzZXJzPyAgUGxlYXNlIGNvbmZpcm0uDQo+IA0KDQpEb3VibGUgY2hlY2tlZCB3
aXRoIHRoZSBtYXJrZXRpbmcgYW5kIHByb2plY3QgbWFuYWdlciwgdGhlIHJldjEuMCB3aWxsIG5v
dCBiZSBzaGlwcGVkIHRvIGVuZCB1c2Vycywgc28gcGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoIGFu
ZCBJIHdpbGwgc3RvcCB0byBzZW5kIGFsbCByZXYxLjAgd29ya2Fyb3VuZCBwYXRjaGVzLg0KDQo+
ID4gPiBNYXliZSB0aGVyZSdzIGEgd2F5IGZvciB5b3UgdG8gYXV0b21hdGljYWxseSBzZXQgdGhh
dCBwY2llX2J1c19wZXJmDQo+IG1vZGU/DQo+ID4gPiBXaXRoIGEgZG1lc2cgbm90ZSB0byBpbmRp
Y2F0ZSB0aGF0IHlvdSdyZSBvdmVycmlkaW5nIGFueSBtb2RlIHRoZQ0KPiA+ID4gdXNlciBtYXkg
aGF2ZSBzZWxlY3RlZD8NCj4gPg0KPiA+IEFjdHVhbGx5IHdlIGRvbid0IGhhdmUgYSB3YXkgdG8g
c2V0IHRoZSBwY2llX2J1c19wZXJmIGF1dG9tYXRpY2FsbHkNCj4gPiB1bmRlciBMaW51eCwgd2Ug
Z2l2ZSB0aGlzIHBhcmFtZXRlciBpbiBrZXJuZWwgY21kbGluZS4gIERvIHlvdSBoYXZlDQo+ID4g
YW55IGFkdmljZSBhYm91dCBob3cgdG8gc2V0IHRoaXMgcGFyYW1ldGVyIGF1dG9tYXRpY2FsbHkg
dW5kZXIgTGludXg/DQo+IA0KPiBUaGUgYmVhdXR5IG9mIExpbnV4IGJlaW5nIG9wZW4tc291cmNl
IGlzIHRoYXQgaWYgeW91IG5lZWQgc29tZXRoaW5nIHRoYXQNCj4gZG9lc24ndCBleGlzdCwgeW91
IGFyZSBlbXBvd2VyZWQgdG8gY3JlYXRlIGl0Lg0KPiANCj4gV2UgZG8gaGF2ZSBvbmUgcGxhY2Ug
YWxyZWFkeSAoY25zM3h4eF9wY2llX2h3X2luaXQoKSkgdGhhdCBleHBsaWNpdGx5IHNldHMNCj4g
cGNpZV9idXNfY29uZmlnLiAgWW91IG1pZ2h0IGJlIGFibGUgdG8gZG8gc29tZXRoaW5nIHNpbWls
YXIuDQo+DQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UhDQogDQo+ID4gPiA+IFRoaXMgRVJSQVRB
IGlzIG9ubHkgZm9yIExYMjE2MEEgUmV2MS4wLCBhbmQgaXQgd2lsbCBiZSBmaXhlZCBpbg0KPiA+
ID4gPiBSZXYyLjAuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFu
ZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBWNDoNCj4gPiA+
ID4gIC0gbm8gY2hhbmdlDQo+ID4gPiA+DQo+ID4gPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvbW9i
aXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jIHwgMTUNCj4gKysrKysrKysrKysrKysrDQo+ID4g
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaCAgIHwg
IDQgKysrKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4g
PiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWls
L3BjaS1sYXllcnNjYXBlLWdlbjQuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jDQo+ID4gPiA+IGluZGV4IGQyYzVkYmJkNWUz
Yy4uMjBjZTE0Njc4OGNhIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYw0KPiA+ID4gPiBA
QCAtODIsMTIgKzgyLDI3IEBAIHN0YXRpYyBib29sIGxzX3BjaWVfZzRfaXNfYnJpZGdlKHN0cnVj
dA0KPiA+ID4gPiBsc19wY2llX2c0DQo+ID4gPiAqcGNpZSkNCj4gPiA+ID4gIAlyZXR1cm4gaGVh
ZGVyX3R5cGUgPT0gUENJX0hFQURFUl9UWVBFX0JSSURHRTsgIH0NCj4gPiA+ID4NCj4gPiA+ID4g
K3N0YXRpYyB2b2lkIHdvcmthcm91bmRfQTAxMTQ1MShzdHJ1Y3QgbHNfcGNpZV9nNCAqcGNpZSkg
ew0KPiA+ID4gPiArCXN0cnVjdCBtb2JpdmVpbF9wY2llICptdl9wY2kgPSBwY2llLT5wY2k7DQo+
ID4gPiA+ICsJdTMyIHZhbDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCS8qIFNldCBBQ0sgbGF0ZW5j
eSB0aW1lb3V0ICovDQo+ID4gPiA+ICsJdmFsID0gY3NyX3JlYWRsKG12X3BjaSwgR1BFWF9BQ0tf
UkVQTEFZX1RPKTsNCj4gPiA+ID4gKwl2YWwgJj0gfihBQ0tfTEFUX1RPX1ZBTF9NQVNLIDw8IEFD
S19MQVRfVE9fVkFMX1NISUZUKTsNCj4gPiA+ID4gKwl2YWwgfD0gKDQgPDwgQUNLX0xBVF9UT19W
QUxfU0hJRlQpOw0KPiA+ID4gPiArCWNzcl93cml0ZWwobXZfcGNpLCB2YWwsIEdQRVhfQUNLX1JF
UExBWV9UTyk7IH0NCj4gPiA+ID4gKw0KPiA+ID4gPiAgc3RhdGljIGludCBsc19wY2llX2c0X2hv
c3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpKSAgew0KPiA+ID4gPiAgCXN0cnVjdCBs
c19wY2llX2c0ICpwY2llID0gdG9fbHNfcGNpZV9nNChwY2kpOw0KPiA+ID4gPg0KPiA+ID4gPiAg
CXBjaWUtPnJldiA9IGNzcl9yZWFkYihwY2ksIFBDSV9SRVZJU0lPTl9JRCk7DQo+ID4gPiA+DQo+
ID4gPiA+ICsJaWYgKHBjaWUtPnJldiA9PSBSRVZfMV8wKQ0KPiA+ID4gPiArCQl3b3JrYXJvdW5k
X0EwMTE0NTEocGNpZSk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ID4g
IH0NCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiA+ID4gaW5kZXggYWI0M2RlNWU0YjJiLi5m
MGUyZTRhZTA5YjUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gPiA+IEBAIC04NSw2ICs4NSwxMCBA
QA0KPiA+ID4gPiAgI2RlZmluZSBQQUJfQVhJX0FNQVBfUEVYX1dJTl9IKHdpbikNCj4gCVBBQl9S
RUdfQUREUigweDBiYWMsDQo+ID4gPiB3aW4pDQo+ID4gPiA+ICAjZGVmaW5lIFBBQl9JTlRQX0FY
SV9QSU9fQ0xBU1MJCTB4NDc0DQo+ID4gPiA+DQo+ID4gPiA+ICsjZGVmaW5lIEdQRVhfQUNLX1JF
UExBWV9UTwkJMHg0MzgNCj4gPiA+ID4gKyNkZWZpbmUgIEFDS19MQVRfVE9fVkFMX01BU0sJCTB4
MWZmZg0KPiA+ID4gPiArI2RlZmluZSAgQUNLX0xBVF9UT19WQUxfU0hJRlQJCTANCj4gPiA+ID4g
Kw0KPiA+ID4gPiAgI2RlZmluZSBQQUJfUEVYX0FNQVBfQ1RSTCh3aW4pCQlQQUJfUkVHX0FERFIo
MHg0YmEwLA0KPiA+ID4gd2luKQ0KPiA+ID4gPiAgI2RlZmluZSAgQU1BUF9DVFJMX0VOX1NISUZU
CQkwDQo+ID4gPiA+ICAjZGVmaW5lICBBTUFQX0NUUkxfVFlQRV9TSElGVAkJMQ0KPiA+ID4gPiAt
LQ0KPiA+ID4gPiAyLjE3LjENCj4gPiA+ID4NCj4gPg0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
