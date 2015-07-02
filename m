Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:2070 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbGBHZO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2015 03:25:14 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: James Morse <james.morse@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	"Arnd Bergmann" <arnd@arndb.de>, Liviu Dudau <Liviu.Dudau@arm.com>,
	"kishon@ti.com" <kishon@ti.com>,
	"xobs@kosagi.com" <xobs@kosagi.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v3 2/5] PCI: designware: Add ARM64 support
Date: Thu, 2 Jul 2015 07:24:40 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D4EC38@lhreml503-mbs>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
 <1435743817-19083-3-git-send-email-wangzhou1@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
 <5593F899.6050306@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E6A2@lhreml503-mbs>
 <55942441.3050705@arm.com>
In-Reply-To: <55942441.3050705@arm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtcGNpLW93bmVy
QHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LXBjaS0NCj4gb3duZXJAdmdlci5rZXJuZWwu
b3JnXSBPbiBCZWhhbGYgT2YgSmFtZXMgTW9yc2UNCj4gU2VudDogMDEgSnVseSAyMDE1IDE4OjMz
DQo+IFRvOiBHYWJyaWVsZSBQYW9sb25pOyBXYW5nemhvdSAoQik7IEJqb3JuIEhlbGdhYXM7IEpp
bmdvbyBIYW47IFByYXR5dXNoDQo+IEFuYW5kOyBBcm5kIEJlcmdtYW5uOyBMaXZpdSBEdWRhdTsg
a2lzaG9uQHRpLmNvbTsgeG9ic0Brb3NhZ2kuY29tOyBtLQ0KPiBrYXJpY2hlcmkyQHRpLmNvbTsg
TWluZ2h1YW4uTGlhbkBmcmVlc2NhbGUuY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBZdWFuemhpY2hhbmc7IFpodWRhY2FpOyB6aGFuZ2p1a3VvOw0KPiBx
aXV6aGVuZmE7IExpZ3Vvemh1IChLZW5uZXRoKQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIv
NV0gUENJOiBkZXNpZ253YXJlOiBBZGQgQVJNNjQgc3VwcG9ydA0KPiANCj4gR2FicmllbGUgUGFv
bG9uaSB3cm90ZToNCj4gPj4gQm90aCBzZXJpZXMgYXJlIGFwcGxpZWQgdG8gdjQuMSwgdXNlIHRo
ZSBzYW1lIC5jb25maWcgZmlsZSwgYW5kIHRoZQ0KPiA+PiBzYW1lIGR0Yi4NCj4gPj4gSSB3aWxs
IGludmVzdGlnYXRlIGZ1cnRoZXIuDQo+ID4+DQo+ID4+IChSZS10ZXN0aW5nIHYyIHdvcmtzLCBz
byB0aGlzIGlzbid0IGFuIGludGVyaW0gaGFyZHdhcmUgZmFpbHVyZSkNCj4gPg0KPiA+IFRoaXMg
aXMgYSBiaXQgd2VpcmQuLi4uDQo+ID4NCj4gPiBQYXRjaCAyLzUgaXMgdGhlIG9ubHkgb25lIHRo
YXQgYWZmZWN0IHBsYXRmb3JtcyBkaWZmZXJlbnQgZnJvbQ0KPiBIaXNpbGljb24NCj4gPg0KPiA+
IFRoZSBvbmx5IGRpZmZlcmVuY2UgYmV0d2VlbiBWMyBwYXRjaFsyLzVdIGFuZCB2MiBwYXRjaFsy
LzRdIGlzDQo+IA0KPiBCZXR3ZWVuIHYzOjIvNSBhbmQgeW91ciByZXBsYWNlbWVudCBmb3IgdjI6
Mi80LCB3aGljaCBhcnJpdmVkIGFmdGVyIEkNCj4gaGFkDQo+IHRlc3RlZCB0aGUgdjIgc2VyaWVz
LiBBcyB0aGUgcGF0Y2ggaGFzIGJlZW4gcmVwbGFjZWQgd2l0aCBhIGRpZmZlcmVudA0KPiBvbmUg
LQ0KPiBuZWl0aGVyICd0ZXN0ZWQtYnknIGlzIHRydWUgYW55IG1vcmUuDQoNClNvcnJ5IEkgbWlz
cmVhZCB5b3VyIHByZXZpb3VzIGVtYWlsDQoNCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlIEJBUiBj
b250YWluaW5nIHRoZSBicmlkZ2Ugd2luZG93IGlzIG5vdCBiZWluZyBhc3NpZ25lZCwNCj4gc28g
bm8gZGV2aWNlcyBvbiBidXMgMSBhcmUgZGlzY292ZXJlZC4NCg0KQ2FuIHlvdSBjb25maXJtIHRo
ZSBkdHNpIHlvdSBhcmUgdXNpbmcuLi4iaW14NnFkbC5kdHNpIiA/DQoNClRoYW5rcw0KDQpHYWIN
Cg0KPiANCj4gSSB3aWxsIHNlbmQgdGhlIGZ1bGwgdjIgYW5kIHYzIGRtZXNnIG91dHB1dCBzZXBh
cmF0ZWx5Lg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEphbWVzDQo+IA0KPiAtLQ0KPiBUbyB1
bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGlu
dXgtcGNpIiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2Vy
bmVsLm9yZw0KPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3Jn
L21ham9yZG9tby1pbmZvLmh0bWwNCg==
