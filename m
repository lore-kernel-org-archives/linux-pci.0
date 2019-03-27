Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E514C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 02:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCCD20811
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 02:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m833RcT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfC0CLR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:11:17 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:39241
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730441AbfC0CLR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 22:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjG9eQjhJkxY8MRuuKAF91SlkJUcRuJFemIgcjm4nE4=;
 b=m833RcT/Oz9YARZTSw0bi7I5v9EHUq28uT/cldch3P7ZovNQ6FxWwzLccIBhbtA1Y4i9IAFjpjyqyoGAN7+Zzpl1wZvVDBW+IIDLbMH3Z26nYh1E6F3nqoFzBXSH7NIOLMlRI6YLLKQ3nilE+wpKV+W3JEfDSsXe0y0qGEO3iZ0=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 02:11:13 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 02:11:13 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv4 00/28] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv4 00/28] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHU1+z8oUtBku7HKUGEtP8v8oioHaYeRVIAgACOOoA=
Date:   Wed, 27 Mar 2019 02:11:13 +0000
Message-ID: <AM6PR04MB5781A99C7DD26F525E7E9A1C84580@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190326173730.GC10666@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190326173730.GC10666@e107981-ln.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a576d353-908e-4979-83eb-08d6b2597cb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4008;
x-ms-traffictypediagnostic: AM6PR04MB4008:
x-microsoft-antispam-prvs: <AM6PR04MB4008A5B08D12AC4A5E6DCEF984580@AM6PR04MB4008.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(136003)(376002)(346002)(39860400002)(396003)(366004)(189003)(13464003)(199004)(186003)(26005)(5660300002)(86362001)(99286004)(7696005)(476003)(55016002)(14454004)(76176011)(229853002)(9686003)(68736007)(53546011)(102836004)(446003)(11346002)(6506007)(486006)(52536014)(71190400001)(71200400001)(6116002)(6916009)(2906002)(7416002)(3846002)(7736002)(8936002)(305945005)(8676002)(81156014)(81166006)(74316002)(14444005)(66066001)(256004)(105586002)(106356001)(316002)(6246003)(53936002)(4326008)(54906003)(33656002)(6436002)(25786009)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4008;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e2TyfGea+96Kh77MnCqbYLXKBRyqN6j5SBfpOAWUivjjhpKFhVkTTNb49ONSbs7ApmMI+ZMr1eJQo8136uxX05q15tO9PbdL0KqfYqgcWYHGW0Z94HoIr6kGGglHU/vvxfosedGC8f98M5iQZxbl4YG2muerO6n8iAsvfzeyMu6Cqpjeg9kbkt4ksoTt82utFsfUAnjgzU5+T6yVL2DqyUfVNJxNm11V5vj9xA9u4TPKr2/bNFJsSwXM/6rer34D0agFY1MC9T81WfwHgptwQEbT+FN1rWzNSxDUI3V6M7AWAL6KO/EmxAzyssgTFl67BByC3Fs6OMyTlyPWQ33WSTtYuS/TyZvsBwuoydM7L3rCsgNSeRSZqzCzth4OedYsvTaNj2uVijTJEMVsEejsPOg69a8YUt0tj1+HD46Kft8=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a576d353-908e-4979-83eb-08d6b2597cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 02:11:13.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4008
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tPg0KPiBTZW50OiAyMDE5xOoz1MIyN8jVIDE6MzgNCj4gVG86IFoucS4gSG91
IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdv
b2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGwu
c3VicmFobWFueWFAbW9iaXZlaWwuY28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaQ0K
PiA8bGVveWFuZy5saUBueHAuY29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVh
Y29uQGFybS5jb207DQo+IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlh
biA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsNCj4gWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2NCAwMC8yOF0gUENJOiByZWZhY3RvciBNb2Jp
dmVpbCBkcml2ZXIgYW5kIGFkZCBQQ0llIEdlbjQNCj4gZHJpdmVyIGZvciBOWFAgTGF5ZXJzY2Fw
ZSBTb0NzDQo+IA0KPiBPbiBNb24sIE1hciAxMSwgMjAxOSBhdCAwOToyOTo1NEFNICswMDAwLCBa
LnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAu
Y29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2Jp
dmVpbCBkcml2ZXIgYW5kIGFkZCBQQ0llDQo+ID4gc3VwcG9ydCBmb3IgTlhQIExheWVyc2NhcGUg
c2VyaWVzIFNvQ3MgaW50ZWdyYXRlZCBNb2JpdmVpbCdzIFBDSWUgR2VuNA0KPiA+IGNvbnRyb2xs
ZXIuDQo+ID4NCj4gPiBIb3UgWmhpcWlhbmcgKDI4KToNCj4gPiAgIFBDSTogbW9iaXZlaWw6IHVu
aWZvcm0gdGhlIHJlZ2lzdGVyIGFjY2Vzc29ycw0KPiA+ICAgUENJOiBtb2JpdmVpbDogZm9ybWF0
IHRoZSBjb2RlIHdpdGhvdXQgZnVuY3Rpb24gY2hhbmdlDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBj
b3JyZWN0IHRoZSByZXR1cm5lZCBlcnJvciBudW1iZXINCj4gPiAgIFBDSTogbW9iaXZlaWw6IHJl
bW92ZSBmbGFnIE1TSV9GTEFHX01VTFRJX1BDSV9NU0kNCj4gPiAgIFBDSTogbW9iaXZlaWw6IGNv
cnJlY3QgUENJIGJhc2UgYWRkcmVzcyBpbiBNRU0vSU8gb3V0Ym91bmQgd2luZG93cw0KPiA+ICAg
UENJOiBtb2JpdmVpbDogcmVwbGFjZSB0aGUgcmVzb3VyY2UgbGlzdCBpdGVyYXRpb24gZnVuY3Rp
b24NCj4gPiAgIFBDSTogbW9iaXZlaWw6IHVzZSBXSU5fTlVNXzAgZXhwbGljaXRseSBmb3IgQ0ZH
IG91dGJvdW5kIHdpbmRvdw0KPiA+ICAgUENJOiBtb2JpdmVpbDogdXNlIHRoZSAxc3QgaW5ib3Vu
ZCB3aW5kb3cgZm9yIE1FTSBpbmJvdW5kDQo+IHRyYW5zYWN0aW9ucw0KPiA+ICAgUENJOiBtb2Jp
dmVpbDogY29ycmVjdCBpbmJvdW5kL291dGJvdW5kIHdpbmRvdyBzZXR1cCByb3V0aW5lcw0KPiA+
ICAgUENJOiBtb2JpdmVpbDogZml4IHRoZSBJTlR4IHByb2Nlc3MgZXJyb3INCj4gPiAgIFBDSTog
bW9iaXZlaWw6IG9ubHkgZml4IHVwIHRoZSBDbGFzcyBDb2RlIGZpZWxkDQo+ID4gICBQQ0k6IG1v
Yml2ZWlsOiBtb3ZlIG91dCB0aGUgbGluayB1cCB3YWl0aW5nIGZyb20gbW9iaXZlaWxfaG9zdF9p
bml0DQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBtb3ZlIGlycSBjaGFpbmVkIGhhbmRsZXIgc2V0dXAg
b3V0IG9mIERUIHBhcnNlDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBpbml0aWFsaXplIFByaW1hcnkv
U2Vjb25kYXJ5L1N1Ym9yZGluYXRlIGJ1cyBudW1iZXINCj4gPiAgIGR0LWJpbmRpbmdzOiBwY2k6
IG1vYml2ZWlsOiBjaGFuZ2UgZ3Bpb19zbGF2ZSBhbmQgYXBiX2NzciB0byBvcHRpb25hbA0KPiA+
ICAgUENJOiBtb2JpdmVpbDogcmVmYWN0b3IgTW9iaXZlaWwgUENJZSBIb3N0IEJyaWRnZSBJUCBk
cml2ZXINCj4gPiAgIFBDSTogbW9iaXZlaWw6IGZpeCB0aGUgY2hlY2tpbmcgb2YgdmFsaWQgZGV2
aWNlDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBhZGQgbGluayB1cCBjb25kaXRpb24gY2hlY2sNCj4g
PiAgIFBDSTogbW9iaXZlaWw6IGNvbnRpbnVlIHRvIGluaXRpYWxpemUgdGhlIGhvc3QgdXBvbiBu
byBQQ0llIGxpbmsNCj4gPiAgIFBDSTogbW9iaXZlaWw6IGRpc2FibGVkIElCIGFuZCBPQiB3aW5k
b3dzIHNldCBieSBib290bG9hZGVyDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBhZGQgQnl0ZSBhbmQg
SGFsZi1Xb3JkIHdpZHRoIHJlZ2lzdGVyIGFjY2Vzc29ycw0KPiA+ICAgUENJOiBtb2JpdmVpbDog
bWFrZSBtb2JpdmVpbF9ob3N0X2luaXQgY2FuIGJlIHVzZWQgdG8gcmUtaW5pdCBob3N0DQo+ID4g
ICBkdC1iaW5kaW5nczogcGNpOiBBZGQgTlhQIExheWVyc2NhcGUgU29DcyBQQ0llIEdlbjQgY29u
dHJvbGxlcg0KPiA+ICAgUENJOiBtb2JpdmVpbDogYWRkIFBDSWUgR2VuNCBSQyBkcml2ZXIgZm9y
IE5YUCBMYXllcnNjYXBlIFNvQ3MNCj4gPiAgIFBDSTogbW9iaXZlaWw6IGxzX3BjaWVfZzQ6IGFk
ZCBXb3JrYXJvdW5kIGZvciBBLTAxMTU3Nw0KPiA+ICAgUENJOiBtb2JpdmVpbDogbHNfcGNpZV9n
NDogYWRkIFdvcmthcm91bmQgZm9yIEEtMDExNDUxDQo+ID4gICBhcm02NDogZHRzOiBmcmVlc2Nh
bGU6IGx4MjE2MGE6IGFkZCBwY2llIERUIG5vZGVzDQo+ID4gICBhcm02NDogZGVmY29uZmlnOiBF
bmFibGUgQ09ORklHX1BDSV9MQVlFUlNDQVBFX0dFTjQNCj4gPg0KPiA+ICAuLi4vYmluZGluZ3Mv
cGNpL2xheWVyc2NhcGUtcGNpLWdlbjQudHh0ICAgICAgfCAgNTIgKysNCj4gPiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL21vYml2ZWlsLXBjaWUudHh0IHwgICAyICsNCj4gPiAgTUFJTlRB
SU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICstDQo+ID4gIC4u
Li9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSB8IDE2MyArKysrDQo+
ID4gIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAx
MSArLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAgICAg
fCAgIDIgKy0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmlnICAg
ICAgIHwgIDM0ICsNCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9NYWtlZmls
ZSAgICAgIHwgICA1ICsNCj4gPiAgLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpLWxheWVyc2Nh
cGUtZ2VuNC5jIHwgMzA2ICsrKysrKysNCj4gPiAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9wY2ll
LW1vYml2ZWlsLWhvc3QuYyAgfCA2NDAgKysrKysrKysrKysrKw0KPiA+IC4uLi9jb250cm9sbGVy
L21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5jICB8ICA1NCArKw0KPiA+ICAuLi4vcGNpL2Nv
bnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jICAgfCAyNDYgKysrKysNCj4gPiAgLi4u
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaCAgIHwgMjI5ICsrKysrDQo+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jICAgICAgICB8IDg2MSAt
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMTUgZmlsZXMgY2hhbmdlZCwgMTc0MyBpbnNlcnRpb25z
KCspLCA4NzMgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdlbjQudHh0DQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL0tjb25m
aWcNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvTWFrZWZpbGUNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0DQo+ID4gZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWls
LWhvc3QuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuYw0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1v
Yml2ZWlsLmgNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1tb2JpdmVpbC5jDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBpcyBhIG1peHR1cmUgb2Yg
Zml4ZXMsIHJlZmFjdG9yaW5nIGFuZCBkZXZlbG9wbWVudCBhbmQgdG8gYmUNCj4gZnJhbmsgaXQg
aXMgYSBiaXQgaGFyZCB0byByZXZpZXcuIEtlZXBpbmcgaW4gbWluZCBhbGwgdGhlIHJldmlldyBj
b21tZW50cw0KPiBhbHJlYWR5IHJlY2VpdmVkIGFuZCB0aGF0IEkgZXhwZWN0IHlvdSB0byBpbnRl
Z3JhdGUsIGRvIHlvdSBtaW5kIHNwbGl0dGluZyBpdCBpbg0KPiBsb2dpY2FsIHNlcmllcyBlYWNo
IG9uZSBzZXJ2aW5nIGEgc3BlY2lmaWMgcHVycG9zZSAoZWcgZml4ZXMsIExheWVyc2NhcGUgc3Vw
cG9ydCwNCj4gZXRjLikgPw0KPiANCj4gTGV0J3Mgc3RhcnQgd2l0aCBwb3N0aW5nIGFuZCBtZXJn
aW5nIHRoZSBmaXhlcyBmaXJzdC4NCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24sIGFuZCB3
aWxsIHNwbGl0IHRoZW0uDQoNCj4gDQo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2guDQo+IA0KPiBMb3Jl
bnpvDQoNClRoYW5rcywNClpoaXFpYW5nDQo=
