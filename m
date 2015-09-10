Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:47269 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbbIJQlx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 12:41:53 -0400
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
Subject: RE: [PATCH v2 1/3] PCI: spear13xx: fix addresses in
 dw_pcie_cfg_read and dw_pcie_cfg_write
Date: Thu, 10 Sep 2015 16:41:42 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1620C805@lhreml503-mbs>
References: <1441897138-23251-1-git-send-email-gabriele.paoloni@huawei.com>
	<1441897138-23251-2-git-send-email-gabriele.paoloni@huawei.com>
 <CAHM4w1kEnZv0_WssMKV3n+DvGhCzqgAJYnKrK37YW5WaUXDSdg@mail.gmail.com>
In-Reply-To: <CAHM4w1kEnZv0_WssMKV3n+DvGhCzqgAJYnKrK37YW5WaUXDSdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQcmF0eXVzaCBBbmFuZCBbbWFp
bHRvOnByYXR5dXNoLmFuYW5kQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAxMCwgMjAxNSA1OjMwIFBNDQo+IFRvOiBHYWJyaWVsZSBQYW9sb25pOyBCam9ybiBIZWxnYWFz
DQo+IENjOiBKaW5nb28gSGFuOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBXYW5nemhvdSAo
Qik7IFl1YW56aGljaGFuZzsNCj4gWmh1ZGFjYWk7IHpoYW5nanVrdW87IHFpdXpoZW5mYTsgTGln
dW96aHUgKEtlbm5ldGgpDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8zXSBQQ0k6IHNwZWFy
MTN4eDogZml4IGFkZHJlc3NlcyBpbg0KPiBkd19wY2llX2NmZ19yZWFkIGFuZCBkd19wY2llX2Nm
Z193cml0ZQ0KPiANCj4gSGkgR2FiLA0KPiANCj4gT24gVGh1LCBTZXAgMTAsIDIwMTUgYXQgODoy
OCBQTSwgR2FicmllbGUgUGFvbG9uaQ0KPiA8Z2FicmllbGUucGFvbG9uaUBodWF3ZWkuY29tPiB3
cm90ZToNCj4gPiBGcm9tOiBnYWJyaWVsZSBwYW9sb25pIDxnYWJyaWVsZS5wYW9sb25pQGh1YXdl
aS5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHkgc3BlYXIxM3h4IHBhc3NlcyB0aGUgd3JvbmcgImFk
ZHJlc3MiIGluIG1hbnkgY2FsbHMgdG8NCj4gPiBkd19wY2llX2NmZ19yZWFkIGFuZCBkd19wY2ll
X2NmZ193cml0ZTogdGhlIHBhc3NlZCBhZGRyZXNzIGlzDQo+ID4gYWx3YXlzIHBwLT5kYmlfYmFz
ZSwgdGhhdCBpcyB3cm9uZyBhcyBpdCBkb2VzIG5vdCBjb25zaWRlcg0KPiA+IHRoZSBvZmZzZXQg
dG8gYWNjZXNzIHRoZSByaWdodCByZWdpc3RlciBvZiB0aGUgUENJIGhlYWRlci4NCj4gPiBUaGlz
IHBhdGNoZXMgZml4ZXMgdGhlc2UgZnVuY3Rpb24gY2FsbHMgcGFzc2luZyB0aGUgYWRkcmVzcyB0
bw0KPiA+IGFjY2VzcyB0aGUgcmlnaHQgcmVnaXN0ZXIuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBl
ZmZvcnQsIGhvd2V2ZXIgdGhlcmUgd2VyZSBzb21lIG1vcmUgaXNzdWVzIHdpdGgNCj4gY3VycmVu
dCBpbXBsZW1lbnRhdGlvbi4NCj4gTGlrZSBQQ0lfRVhQX0RFVkNUTCBpcyBvbmx5IHR3byBieXRl
cyBvZiByZWdpc3Rlci4gTmV4dCB0d28gYnl0ZXMgYXJlDQo+IFBDSV9FWFBfREVWU1RTIHdoaWNo
IGlzIFJPLCBzbyB3cml0aW5nIDQgYnl0ZXMgYXQgb2Zmc2V0ICdleHBfY2FwX29mZg0KPiArIFBD
SV9FWFBfREVWQ1RMJyBpcyBub3QgY29ycmVjdC4NCj4gDQo+IEkgaGFkIHNlbnQgYSBwYXRjaCB0
byBjb3JyZWN0IGFsbCB0aGUgaXNzdWVzIHdpdGggY3VycmVudA0KPiBpbXBsZW1lbnRhdGlvbiBb
MV0uIFlvdSBjYW4gdGFrZSB0aGF0IGFzIHlvdXIgMXN0IHBhdGNoLg0KDQpPb3BzIFNvcnJ5LCBJ
IG1pc3NlZCB0aGF0IHBhdGNoIQ0KSSdsbCB0YWtlIGl0IGFzIHBhdGNoIDEsIE1hbnkgVGhhbmtz
DQoNCkdhYg0KDQo+IA0KPiBbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTUvOS83LzUNCg==
