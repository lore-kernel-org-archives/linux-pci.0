Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:64219 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbaBUA7M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 19:59:12 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1B00B91MQMGR60@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 21 Feb 2014 09:59:10 +0900 (KST)
Date: Fri, 21 Feb 2014 00:59:09 +0000 (GMT)
From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/1] Designware:RC BARs setup related fix
To: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"spear-devel@list.st.com" <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Reply-to: jg1.han@samsung.com
MIME-version: 1.0
Content-type: text/plain; charset=euc-kr
MIME-version: 1.0
Message-id: <10133227.11261392944347149.JavaMail.weblogic@epml01>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gRmViIDE5LCAyMDE0IDIxOjA0IChHTVQrMDk6MDApLCBNb2hpdCBLdW1hciB3cml0ZToNCj4g
VGhlIFN5bm9wc3lzICBQQ0llIGNvcmUgcHJvdmlkZXMgb25lIHBhaXIgb2YgMzItYml0IEJBUnMg
KEJBUiAwIGFuZCBCQVIgMSkuDQo+IFRoZSBCQVJzIGNhbiAgYmUgY29uZmlndXJlZCBhcyBmb2xs
b3dzOg0KPiANCj4gLSBPbmUgNjQtYml0IEJBUjogQkFScyAwIGFuZCAxIGFyZSBjb21iaW5lZCB0
byBmb3JtIGEgc2luZ2xlIDY0LWJpdCBCQVIuDQo+IC0gVHdvIDMyLWJpdCBCQVJzOiBCQVJzIDAg
YW5kIDEgYXJlIHR3byBpbmRlcGVuZGVudCAzMi1iaXQgQkFScw0KPiANCj4gVGhpcyBwYXRjaCBj
b3JyZWN0cyA2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUgbWVtb3J5IEJBUiBjb25maWd1cmF0aW9u
DQo+IGltcGxlbWVudGVkIGluIGR3IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1vaGl0
IEt1bWFyIDxtb2hpdC5rdW1hckBzdC5jb20+DQo+IENjOiBQcmF0eXVzaCBBbmFuZCA8cHJhdHl1
c2guYW5hbmRAc3QuY29tPg0KPiBDYzogSmluZ29vIEhhbiA8amcxLmhhbkBzYW1zdW5nLmNvbT4N
Cj4gQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IENjOiBzcGVhci1kZXZlbEBs
aXN0LnN0LmNvbQ0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KDQpJIHdvcmtzIHBy
b3Blcmx5IG9uIEV4eW5vcyBwbGF0ZnJvbS4NCg0KQWNrZWQtYnk6IEppbmdvbyBIYW4gPGpnMS5o
YW5Ac2Ftc3VuZy5jb20+DQoNCkJlc3QgcmVnYXJkcywNCkppbmdvbyBIYW4NCg0KPiAtLS0NCj4g
IGRyaXZlcnMvcGNpL2hvc3QvcGNpZS1kZXNpZ253YXJlLmMgfCAgICAyICstDQo+ICAxIGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSk=


