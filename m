Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:54303 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbIWQ1G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 12:27:06 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v3 2/3] PCI: designware: change dw_pcie_cfg_write() and
 dw_pcie_cfg_read()
Date: Wed, 23 Sep 2015 16:26:52 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1622BC61@lhreml503-mbb>
References: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
	<1441964307-126942-3-git-send-email-gabriele.paoloni@huawei.com>
	<20150918205301.GM25767@google.com>
 <CAHM4w1nid7RgrNoJxN5g7sQHKEnbZaDK9pMCe+XZ6m0xXEiarA@mail.gmail.com>
In-Reply-To: <CAHM4w1nid7RgrNoJxN5g7sQHKEnbZaDK9pMCe+XZ6m0xXEiarA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtcGNpLW93bmVy
QHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LXBjaS0NCj4gb3duZXJAdmdlci5rZXJuZWwu
b3JnXSBPbiBCZWhhbGYgT2YgUHJhdHl1c2ggQW5hbmQNCj4gU2VudDogU2F0dXJkYXksIFNlcHRl
bWJlciAxOSwgMjAxNSA0OjExIEFNDQo+IFRvOiBCam9ybiBIZWxnYWFzDQo+IENjOiBHYWJyaWVs
ZSBQYW9sb25pOyBKaW5nb28gSGFuOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBXYW5nemhv
dQ0KPiAoQik7IFl1YW56aGljaGFuZzsgWmh1ZGFjYWk7IHpoYW5nanVrdW87IHFpdXpoZW5mYTsg
TGlndW96aHUgKEtlbm5ldGgpDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8zXSBQQ0k6IGRl
c2lnbndhcmU6IGNoYW5nZSBkd19wY2llX2NmZ193cml0ZSgpDQo+IGFuZCBkd19wY2llX2NmZ19y
ZWFkKCkNCj4gDQo+IE9uIFNhdCwgU2VwIDE5LCAyMDE1IGF0IDI6MjMgQU0sIEJqb3JuIEhlbGdh
YXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSXMgdGhlcmUgcmVh
bGx5IGFueSB2YWx1ZSBpbiBrZWVwaW5nICJhZGRyIiBhbmQgIndoZXJlIiBzZXBhcmF0ZT8NCj4g
DQo+IE5vdyB3ZSBkbyBub3QgY2FyZSBvZiBidWdneSBTT0NzIHdoaWNoIGNvdWxkIGhhdmUgaXNz
dWVzIHdpdGggbm9uIHdvcmQNCj4gYWxpZ25lZCBhZGRyZXNzIHJlYWQuIElmIHRoZXJlIGlzIGFu
eSBzdWNoIFNPQywgdGhlbiB0aGV5IGNhbiBoYXZlDQo+IHRoZWlyIG93biBhY2Nlc3Nvci4NCj4g
U28sIEkgZG8gbm90IHNlZSBhbnkgdmFsdWUgb2Yga2VlcGluZyAid2hlcmUiLg0KPiANCj4gPiBk
d19wY2llX2NmZ193cml0ZSgpIGNsZWFybHkgZG9lc24ndCBjYXJlOyBpdCBqdXN0IGFkZHMgdGhl
bSB0b2dldGhlci4NCj4gSQ0KPiA+IGRvbid0IHRoaW5rIGR3X3BjaWVfY2ZnX3JlYWQoKSBuZWVk
cyB0byBjYXJlIGVpdGhlcjogaXQgY291bGQgcm91bmQNCj4gdGhlDQo+ID4gYWRkcmVzcyBkb3du
IHRvIGEgMzItYml0IGJvdW5kYXJ5IGFuZCB1c2UgdGhlIGRpZmZlcmVuY2UgdG8gY29tcHV0ZQ0K
PiB0aGUNCj4gPiBtYXNrIGFuZCBzaGlmdC4NCj4gPg0KPiA+IFNvIEknbSBwcm9wb3Npbmcgc29t
ZXRoaW5nIGxpa2UgdGhpczoNCj4gPg0KPiA+ICAgaW50IGR3X3BjaWVfY2ZnX3JlYWQodm9pZCBf
X2lvbWVtICphZGRyLCBpbnQgc2l6ZSwgdTMyICp2YWwpDQo+ID4gICBpbnQgZHdfcGNpZV9jZmdf
d3JpdGUodm9pZCBfX2lvbWVtICphZGRyLCBpbnQgc2l6ZSwgdTMyIHZhbCkNCg0KT2sgQWdyZWVk
DQoNCldpbGwgZG8gaW4gdjQNCg0KR2FiDQoNCj4gDQo+IEFncmVlZC4NCj4gDQo+IH5QcmF0eXVz
aA0KPiAtLQ0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAi
dW5zdWJzY3JpYmUgbGludXgtcGNpIiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFq
b3Jkb21vQHZnZXIua2VybmVsLm9yZw0KPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8v
dmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg==
