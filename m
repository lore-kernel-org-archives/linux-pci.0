Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ED5C43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8036D214D8
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 09:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q0YVRL29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfCLJe1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:34:27 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:42310
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfCLJe1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 05:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DliULZlHoGCdALALGUe0VQaht262WLGDHoVxeGpS0qU=;
 b=q0YVRL29ZxphA5WbyRk+I3+nfSPCZxRHt3mG/vdw4l7nV9KdfRlN5L/VPOYzZdAX2LyE9h3XcvAhRZ3V3qjMTfhTGmqUTuoUL124UoayKJEOe4ek64W91GOxBudl4/+eY0H3qy3KoWXkvtQXgYo9gJhcPPmy6Yik+9+rvUCz8tw=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5000.eurprd04.prod.outlook.com (20.177.33.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Tue, 12 Mar 2019 09:34:17 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 09:34:17 +0000
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
Thread-Index: AQHU1+1+Au0UBiXI7EyjDN9yTIIANKYGsYyAgAEIgVA=
Date:   Tue, 12 Mar 2019 09:34:17 +0000
Message-ID: <AM6PR04MB578187096D0CFD2B8D9C13FF84490@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-27-Zhiqiang.Hou@nxp.com>
 <20190311173439.GH214730@google.com>
In-Reply-To: <20190311173439.GH214730@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [120.244.120.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f32495a8-82e0-42b6-0cf3-08d6a6cde5df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5000;
x-ms-traffictypediagnostic: AM6PR04MB5000:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtBTTZQUjA0TUI1MDAwOzIzOmEvRW41cllna29xK2JxSTVuMlNGWXRkd3hF?=
 =?gb2312?B?ajZZK2sxZjNsenovc1hJcTdZYUs1Undqc1VnbXBHc2FSZlpjcUVXVXZsam9T?=
 =?gb2312?B?ejZXenVjblYxSmRqellMaTQrWUhEa1J4SnY3TFQ4cFdQa1ZTQmVJUEJXQ0ox?=
 =?gb2312?B?RkNxTTB3c0JaZW9rWFdtNnJqQVR3dHR5eHRoM0Z5MVZJbGdCNWtmWmJ4QUt0?=
 =?gb2312?B?anZ2V0NJK1pRMkVsUGxhUmp0SHlCNFp5blo2aWQ2ZnM3dzdNMEFTTkxSWVJz?=
 =?gb2312?B?MkowRkJ4RUlkWU42b0xNWncxYlFqV1ZMNE5tQTRTeWFObDBEY3F4cXpRNGpu?=
 =?gb2312?B?YnpSdEo2RVRORkdFTXNqN2xWSDdrZWlPemNWZ2diaTlUK1BrYjVGazhiMVg3?=
 =?gb2312?B?d0w0ek1iaEgxN2QyNUFHZnBFZEpEMDNVRVJIeWRtelE0Nkorclh5QzR2a3RX?=
 =?gb2312?B?WTdZanBvL25FbU9paGVENXl6MVY5S0lSMGx4MDUrSVYvalBOVXJobThOS2tH?=
 =?gb2312?B?Yit1QncrVUNoV3drWDF5TGVNYkwxZm5NemFqczVldU9zS0xxRldIbThqRk9Y?=
 =?gb2312?B?SngrN1BTcnlkczRKaDNDcWZEdzM0VXVBcFFvZnJXVDY3U0lVdEtHU201K1hE?=
 =?gb2312?B?ajYyVlhyN3ZyM3I0U0EvcDlDNzBsUnkxRnprQ1Vnd2h5ZC9yd0hnaVA2SVlh?=
 =?gb2312?B?bnFMUkNiRzNleGJDcUZiR0YvMDk3cTV6R3dMdEVsYSttVjlnVnpzRUxxU3pH?=
 =?gb2312?B?T1Ewck1FRDdNV3hhc1FzZGgxMldSVU5PZXRRa2lkUytCek9OcEJsendJbUlj?=
 =?gb2312?B?UVVVWDMzRVNTR1FGS3luWDU4Wm1Kcml5VEZFS3B6cHJWcFBDWHBPMUNBOU9k?=
 =?gb2312?B?eGIxeXA5THJIRVNsOGJ0OFBOK0NpZWl6d25wOVc2YWVtQnB0cUtMckNVd2tN?=
 =?gb2312?B?M0FNSTEwZTkrcU5yYWtqWVk3ODE0Qll4ei84c2tzTEhHY2E0NXQwUVJWUXlV?=
 =?gb2312?B?YkNmWjRRZzV2cXNpMzMzOVhVY1VoKytYY1ptZng3cUc2dFBtTjQ2b3FRRmt1?=
 =?gb2312?B?SEIwdFJjcVV6NS91OFlRTXkrNis2VTVrcGlWd01aZVlzakwyeHBQcVE4Sm1Z?=
 =?gb2312?B?MkNKR0ZpQ2YrRTVZUTFZYnFLdXBQOG5HcUFnQUV0ZlZ6T0JnNVNQU3cyZ2sy?=
 =?gb2312?B?SHUvMEJEdUtudSs0WWNEOWx2WW41RGxmQ2tnR2M0dEliVkNlMm43eVlnWCtX?=
 =?gb2312?B?NjNtVlBhUHVZUmJ5KzNPQ3hUYnhhT1ZLYnE3eWFlSUQ1dUV0dG1nRlk0Zzc4?=
 =?gb2312?B?aWJyVXFpTXUrRElpSGVwQXpnYytBU1J5UFhXODA4L0I4ZXN3OVo0a3p3Y3hr?=
 =?gb2312?B?akpqZDM2SVRiZCtjdms2Ujk5YUxvbEpPUmdSWVhJQkJNdHM1QUloVFdsNDky?=
 =?gb2312?B?TTlpSDU2N0pGR2NIMi9LY2x4VzJGNjNzSTZZRG9nNnRWVVRKTGtrRGpGWHhZ?=
 =?gb2312?B?elhqWTN2UFMxMjV3eFNQYkg5SHljNk00RXUrd1hFNGlRZnRjTFIwNUtWM1dN?=
 =?gb2312?B?NUUwMkRKcHBsMDZ2bDd0TmtIK3pSbm1aRzhydzJVWmQ3dDR0MjgwTXNaTlVZ?=
 =?gb2312?B?SXJXZXhnZUhJWnNMUGFtWFYwRlBaenZwckwwQXl5OGJrM1BhZXZ5SmJzS2xI?=
 =?gb2312?B?WEpQWlA1bmpNOTMxbXhBNUd5TzJDQld6MmwraGRVNmptRExpMC91WjFJQkIz?=
 =?gb2312?B?b05JTmFjdkhJUTcvZy9QUT09?=
x-microsoft-antispam-prvs: <AM6PR04MB50002FA0E2CA052376FCA68084490@AM6PR04MB5000.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39850400004)(136003)(13464003)(199004)(189003)(14454004)(25786009)(4326008)(8676002)(81156014)(81166006)(86362001)(74316002)(71200400001)(486006)(316002)(71190400001)(7416002)(54906003)(33656002)(305945005)(7736002)(2906002)(478600001)(446003)(476003)(11346002)(14444005)(229853002)(52536013)(5660300002)(99286004)(76176011)(6506007)(53546011)(102836004)(7696005)(97736004)(26005)(186003)(3846002)(68736007)(6116002)(8936002)(6916009)(9686003)(106356001)(256004)(105586002)(55016002)(66066001)(53936002)(6246003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5000;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AEc/Mb1ZMtiKGycvuUv/DD8MtbNPXBNO0P4XwPWyIVRNkEkrTpjSAnf39ztapXK9DEGsNSyCQ/8OaO6VHLzFt1KBg1U437sM6r7DBWqgT3qh0iM9a70pb5slARaaaRt8wY7Vj+XHN5G1J1ka0F7FfCYgxjcG3tUo8gyDF97fI3GkEgN9VrfxUTopJ4Rj+7QwyKmw0YfngVQ1eXEtZKBJSrSSDkfeiZHSCBzIGskvCOqKpvzo6orFQl4K2i/dX2u9M7o9jmBWkhI5oxtOId8zNjjMkSO/PE87Vn/WSKEKK/VIMGy3pRQ2YKWQoHCj5h+mJZcK72cdR8WmF5TgyCVwElfSvgElmDCzvELzl1Ly9U5Ahso0+9XVatzwwKSOaxQLuraL7XwKUWzA1QMdtcwkdsKFtUT0ub2fztfDuCtG2MY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32495a8-82e0-42b6-0cf3-08d6a6cde5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 09:34:17.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5000
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE5xOoz1MIxMsjVIDE6MzUNCj4gVG86IFoucS4gSG91
IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28u
aW47DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsN
Cj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+
IHdpbGwuZGVhY29uQGFybS5jb207IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0u
aC4gTGlhbg0KPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgWGlhb3dlaSBCYW8gPHhpYW93ZWku
YmFvQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NCAyNi8yOF0gUENJOiBtb2JpdmVp
bDogbHNfcGNpZV9nNDogYWRkIFdvcmthcm91bmQgZm9yDQo+IEEtMDExNDUxDQo+IA0KPiBPbiBN
b24sIE1hciAxMSwgMjAxOSBhdCAwOTozMzozMkFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4g
PiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gV2hl
biBMWDIgUENJZSBjb250cm9sbGVyIGlzIHNlbmRpbmcgbXVsdGlwbGUgc3BsaXQgY29tcGxldGlv
bnMgYW5kIEFDSw0KPiA+IGxhdGVuY3kgZXhwaXJlcyBpbmRpY2F0aW5nIHRoYXQgQUNLIHNob3Vs
ZCBiZSBzZW5kIGF0IHByaW9yaXR5Lg0KPiA+IEJ1dCBiZWNhdXNlIG9mIGxhcmdlIG51bWJlciBv
ZiBzcGxpdCBjb21wbGV0aW9ucyBhbmQgRkMgdXBkYXRlIERMTFAsDQo+ID4gdGhlIGNvbnRyb2xs
ZXIgZG9lcyBub3QgZ2l2ZSBwcmlvcml0eSB0byBBQ0sgdHJhbnNtaXNzaW9uLiBUaGlzDQo+ID4g
cmVzdWx0cyBpbnRvIEFDSyBsYXRlbmN5IHRpbWVyIHRpbWVvdXQgZXJyb3IgYXQgdGhlIGxpbmsg
cGFydG5lciBhbmQNCj4gPiB0aGUgcGVuZGluZyBUTFBzIGFyZSByZXBsYXllZCBieSB0aGUgbGlu
ayBwYXJ0bmVyIGFnYWluLg0KPiA+DQo+ID4gV29ya2Fyb3VuZDoNCj4gPiAxLiBSZWR1Y2UgdGhl
IEFDSyBsYXRlbmN5IHRpbWVvdXQgdmFsdWUgdG8gYSB2ZXJ5IHNtYWxsIHZhbHVlLg0KPiA+IDIu
IFJlc3RyaWN0IHRoZSBudW1iZXIgb2YgY29tcGxldGlvbnMgZnJvbSB0aGUgTFgyIFBDSWUgY29u
dHJvbGxlcg0KPiA+ICAgIHRvIDEsIGJ5IGNoYW5naW5nIHRoZSBNYXggUmVhZCBSZXF1ZXN0IFNp
emUgKE1SUlMpIG9mIGxpbmsgcGFydG5lcg0KPiA+ICAgIHRvIHRoZSBzYW1lIHZhbHVlIGFzIE1h
eCBQYWNrZXQgc2l6ZSAoTVBTKS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW1wbGVtZW50ZWQgcGFy
dCAxLCB0aGUgcGFydCAyIGNhbiBiZSBzZXQgYnkga2VybmVsDQo+ID4gcGFyYW1ldGVyICdwY2k9
cGNpZV9idXNfcGVyZicNCj4gDQo+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHlvdSdyZSBz
YXlpbmcgdGhhdCBMWDIxNjBBIFJldjEuMCB3aWxsIG9ubHkgd29yaw0KPiBjb3JyZWN0bHkgaWYg
eW91IGhhdmUgdGhpcyBwYXRjaCBhcHBsaWVkIEFORCB5b3UgYm9vdCB3aXRoDQo+ICJwY2k9cGNp
ZV9idXNfcGVyZiIuDQo+IA0KDQpZb3VyIHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdC4NCg0KPiBU
aGF0IG1pZ2h0IGJlIE9LIGlmIHRoZXNlIHJldiAxLjAgcGFydHMgYXJlIG9ubHkgdXNlZCBpbiB0
aGUgbGFiIGFuZCBhcmUgbmV2ZXINCj4gc2hpcHBlZCB0byBjdXN0b21lcnMuICBCdXQgaWYgdGhl
c2UgcGFydHMgYXJlIGV2ZXIgc2hpcHBlZCB0byBjdXN0b21lcnMsIEkNCj4gZG9uJ3QgdGhpbmsg
aXQncyBhY2NlcHRhYmxlIGZvciB0aGVtIHRvIGhhdmUgdG8gZmlndXJlIG91dCB0aGF0IHRoZXkg
bXVzdCBib290DQo+IHdpdGggInBjaT1wY2llX2J1c19wZXJmIi4gIFllcywgeW91IGNhbiBkb2N1
bWVudCB0aGF0IGluIHJlbGVhc2Ugbm90ZXMsIGJ1dA0KPiBpdCdzIHN0aWxsIGEgcG9vciB1c2Vy
IGV4cGVyaWVuY2UsIGFuZCB1c2VycyB3aWxsIGZvcmdldCwgYW5kIHRoZXkgd2lsbCBzZWUNCj4g
bXlzdGVyaW91cyBoYXJkLXRvLWRlYnVnIGlzc3Vlcy4NCj4gDQo+IE1heWJlIHRoZXJlJ3MgYSB3
YXkgZm9yIHlvdSB0byBhdXRvbWF0aWNhbGx5IHNldCB0aGF0IHBjaWVfYnVzX3BlcmYgbW9kZT8N
Cj4gV2l0aCBhIGRtZXNnIG5vdGUgdG8gaW5kaWNhdGUgdGhhdCB5b3UncmUgb3ZlcnJpZGluZyBh
bnkgbW9kZSB0aGUgdXNlciBtYXkNCj4gaGF2ZSBzZWxlY3RlZD8NCj4gDQoNCkFjdHVhbGx5IHdl
IGRvbid0IGhhdmUgYSB3YXkgdG8gc2V0IHRoZSBwY2llX2J1c19wZXJmIGF1dG9tYXRpY2FsbHkg
dW5kZXIgTGludXgsIHdlIGdpdmUgdGhpcyBwYXJhbWV0ZXIgaW4ga2VybmVsIGNtZGxpbmUuDQpE
byB5b3UgaGF2ZSBhbnkgYWR2aWNlIGFib3V0IGhvdyB0byBzZXQgdGhpcyBwYXJhbWV0ZXIgYXV0
b21hdGljYWxseSB1bmRlciBMaW51eD8NCg0KPiA+IFRoaXMgRVJSQVRBIGlzIG9ubHkgZm9yIExY
MjE2MEEgUmV2MS4wLCBhbmQgaXQgd2lsbCBiZSBmaXhlZCBpbg0KPiA+IFJldjIuMC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gVjQ6DQo+ID4gIC0gbm8gY2hhbmdlDQo+ID4NCj4gPiAgLi4uL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYyB8IDE1ICsrKysrKysrKysrKysr
Kw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaCAg
IHwgIDQgKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXll
cnNjYXBlLWdlbjQuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2kt
bGF5ZXJzY2FwZS1nZW40LmMNCj4gPiBpbmRleCBkMmM1ZGJiZDVlM2MuLjIwY2UxNDY3ODhjYSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXll
cnNjYXBlLWdlbjQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwv
cGNpLWxheWVyc2NhcGUtZ2VuNC5jDQo+ID4gQEAgLTgyLDEyICs4MiwyNyBAQCBzdGF0aWMgYm9v
bCBsc19wY2llX2c0X2lzX2JyaWRnZShzdHJ1Y3QgbHNfcGNpZV9nNA0KPiAqcGNpZSkNCj4gPiAg
CXJldHVybiBoZWFkZXJfdHlwZSA9PSBQQ0lfSEVBREVSX1RZUEVfQlJJREdFOyAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyB2b2lkIHdvcmthcm91bmRfQTAxMTQ1MShzdHJ1Y3QgbHNfcGNpZV9nNCAqcGNp
ZSkgew0KPiA+ICsJc3RydWN0IG1vYml2ZWlsX3BjaWUgKm12X3BjaSA9IHBjaWUtPnBjaTsNCj4g
PiArCXUzMiB2YWw7DQo+ID4gKw0KPiA+ICsJLyogU2V0IEFDSyBsYXRlbmN5IHRpbWVvdXQgKi8N
Cj4gPiArCXZhbCA9IGNzcl9yZWFkbChtdl9wY2ksIEdQRVhfQUNLX1JFUExBWV9UTyk7DQo+ID4g
Kwl2YWwgJj0gfihBQ0tfTEFUX1RPX1ZBTF9NQVNLIDw8IEFDS19MQVRfVE9fVkFMX1NISUZUKTsN
Cj4gPiArCXZhbCB8PSAoNCA8PCBBQ0tfTEFUX1RPX1ZBTF9TSElGVCk7DQo+ID4gKwljc3Jfd3Jp
dGVsKG12X3BjaSwgdmFsLCBHUEVYX0FDS19SRVBMQVlfVE8pOyB9DQo+ID4gKw0KPiA+ICBzdGF0
aWMgaW50IGxzX3BjaWVfZzRfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2kpICB7
DQo+ID4gIAlzdHJ1Y3QgbHNfcGNpZV9nNCAqcGNpZSA9IHRvX2xzX3BjaWVfZzQocGNpKTsNCj4g
Pg0KPiA+ICAJcGNpZS0+cmV2ID0gY3NyX3JlYWRiKHBjaSwgUENJX1JFVklTSU9OX0lEKTsNCj4g
Pg0KPiA+ICsJaWYgKHBjaWUtPnJldiA9PSBSRVZfMV8wKQ0KPiA+ICsJCXdvcmthcm91bmRfQTAx
MTQ1MShwY2llKTsNCj4gPiArDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5o
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0K
PiA+IGluZGV4IGFiNDNkZTVlNGIyYi4uZjBlMmU0YWUwOWI1IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiBAQCAt
ODUsNiArODUsMTAgQEANCj4gPiAgI2RlZmluZSBQQUJfQVhJX0FNQVBfUEVYX1dJTl9IKHdpbikJ
UEFCX1JFR19BRERSKDB4MGJhYywNCj4gd2luKQ0KPiA+ICAjZGVmaW5lIFBBQl9JTlRQX0FYSV9Q
SU9fQ0xBU1MJCTB4NDc0DQo+ID4NCj4gPiArI2RlZmluZSBHUEVYX0FDS19SRVBMQVlfVE8JCTB4
NDM4DQo+ID4gKyNkZWZpbmUgIEFDS19MQVRfVE9fVkFMX01BU0sJCTB4MWZmZg0KPiA+ICsjZGVm
aW5lICBBQ0tfTEFUX1RPX1ZBTF9TSElGVAkJMA0KPiA+ICsNCj4gPiAgI2RlZmluZSBQQUJfUEVY
X0FNQVBfQ1RSTCh3aW4pCQlQQUJfUkVHX0FERFIoMHg0YmEwLA0KPiB3aW4pDQo+ID4gICNkZWZp
bmUgIEFNQVBfQ1RSTF9FTl9TSElGVAkJMA0KPiA+ICAjZGVmaW5lICBBTUFQX0NUUkxfVFlQRV9T
SElGVAkJMQ0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==
