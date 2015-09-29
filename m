Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:48925 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964828AbbI2NI5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 09:08:57 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Pratyush Anand <pratyush.anand@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [PATCH v4 0/3] PCI: designware: change dw_pcie_cfg_write() and
 dw_pcie_cfg_read()
Date: Tue, 29 Sep 2015 13:08:44 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E16236A55@lhreml503-mbs>
References: <1443526447-228817-1-git-send-email-gabriele.paoloni@huawei.com>
 <CAHM4w1mKMxy_MyZuSa_+pt3zF1Oi_gXYgMLUJAni3HLDRQmyFw@mail.gmail.com>
In-Reply-To: <CAHM4w1mKMxy_MyZuSa_+pt3zF1Oi_gXYgMLUJAni3HLDRQmyFw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHJhdHl1c2ggQW5hbmQg
W21haWx0bzpwcmF0eXVzaC5hbmFuZEBnbWFpbC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRl
bWJlciAyOSwgMjAxNSAxOjA4IFBNDQo+IFRvOiBHYWJyaWVsZSBQYW9sb25pDQo+IENjOiBCam9y
biBIZWxnYWFzOyBKaW5nb28gSGFuOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBXYW5nemhv
dSAoQik7DQo+IFl1YW56aGljaGFuZzsgWmh1ZGFjYWk7IHpoYW5nanVrdW87IHFpdXpoZW5mYTsg
TGlndW96aHUgKEtlbm5ldGgpDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC8zXSBQQ0k6IGRl
c2lnbndhcmU6IGNoYW5nZSBkd19wY2llX2NmZ193cml0ZSgpDQo+IGFuZCBkd19wY2llX2NmZ19y
ZWFkKCkNCj4gDQo+IEhpIEdhYiwNCj4gDQo+IE9uIFR1ZSwgU2VwIDI5LCAyMDE1IGF0IDU6MDQg
UE0sIEdhYnJpZWxlIFBhb2xvbmkNCj4gPGdhYnJpZWxlLnBhb2xvbmlAaHVhd2VpLmNvbT4gd3Jv
dGU6DQo+ID4gRnJvbTogZ2FicmllbGUgcGFvbG9uaSA8Z2FicmllbGUucGFvbG9uaUBodWF3ZWku
Y29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaHNldDoNCj4gPiAxKSBmaXhlcyBhIGJ1ZyBpbiBzcGVh
cjEzeHggd2hlbiBjYWxsaW5nIGR3X3BjaWVfY2ZnX3JlYWQgYW5kDQo+ID4gICAgZHdfcGNpZV9j
Zmdfd3JpdGUgdXNpZ24gdGhlIHBhdGNoIGZyb20gUHJhdHl1c2ggaW4NCj4gPiAgICBodHRwczov
L2xrbWwub3JnL2xrbWwvMjAxNS85LzcvNQ0KPiANCj4gSSB0aGluaywgeW91IGZvcmdvdCB0byB0
YWtlIHRoaXMsIGFuZCByZXBsYWNlZCB3aXRoIGFub3RoZXIgdmVyc2lvbi4NCj4gV2UgaGF2ZSBh
bHJlYWR5IGRpc2N1c3NlZCBbMV0gdGhhdCwgd2h5IHRoZSB2ZXJzaW9uIGFkZGVkIGluIHRoaXMN
Cj4gc2VyaWVzIGlzIG5vdCBwcmVmZXJhYmxlLg0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91
IHNlZSBhbnkgaXNzdWUgaW4gdGFraW5nIFsyXS4NCg0KU29ycnkgeW91J3JlIGNvbXBsZXRlbHkg
cmlnaHQhDQoNCkkndmUganVzdCBtZXNzZWQgdXAgd2l0aCBteSBpbnRlcm5hbCBicmFuY2hlcy4N
Cg0KV2lsbCByZS1zZW5kIHdpdGggdjUNCg0KQXBvbG9naWVzIGFnYWluDQoNCj4gDQo+IFRoYW5r
cw0KPiANCj4gflByYXR5dXNoDQo+IA0KPiBbMV0gaHR0cDovL3d3dy5zcGluaWNzLm5ldC9saXN0
cy9saW51eC1wY2kvbXNnNDQ0NDAuaHRtbA0KPiBbMl0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MTUvOS83LzUNCg==
