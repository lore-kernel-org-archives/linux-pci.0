Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:40736
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750718AbdHRF2e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Aug 2017 01:28:34 -0400
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
CC: "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, "Roy Zang" <roy.zang@nxp.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Subject: RE: [PATCHv3 6/9] PCI: designware: add accessors for write permission
 of DBI read-only registers
Date: Fri, 18 Aug 2017 05:28:31 +0000
Message-ID: <AM5PR0402MB27710AF77716D55F03B4B59384800@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1502859419-33696-7-git-send-email-Zhiqiang.Hou@nxp.com>
 <83b0ad83-bb8f-a899-86b3-7be910eb4b51@mm-sol.com>
 <VI1PR0402MB278292DAC81D4A49964FEC1B84830@VI1PR0402MB2782.eurprd04.prod.outlook.com>
 <6fe4dcd2-4a85-5ccc-292a-8aacca75657d@mm-sol.com>
In-Reply-To: <6fe4dcd2-4a85-5ccc-292a-8aacca75657d@mm-sol.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgU3RhbmltaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3Rh
bmltaXIgVmFyYmFub3YgW21haWx0bzpzdmFyYmFub3ZAbW0tc29sLmNvbV0NCj4gU2VudDogMjAx
N+W5tDjmnIgxN+aXpSAxOToyNg0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29t
PjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgamlu
Z29vaGFuMUBnbWFpbC5jb207IEpvYW8uUGludG9Ac3lub3BzeXMuY29tDQo+IENjOiBNLmguIExp
YW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNv
bT47DQo+IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPjsgbmlrbGFzLmNhc3NlbEBheGlzLmNv
bTsNCj4gamVzcGVyLm5pbHNzb25AYXhpcy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSHYzIDYv
OV0gUENJOiBkZXNpZ253YXJlOiBhZGQgYWNjZXNzb3JzIGZvciB3cml0ZQ0KPiBwZXJtaXNzaW9u
IG9mIERCSSByZWFkLW9ubHkgcmVnaXN0ZXJzDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDA4LzE3LzIw
MTcgMDY6MDMgQU0sIFoucS4gSG91IHdyb3RlOg0KPiA+IEhpIFN0YW5pbWlyLA0KPiA+DQo+ID4g
VGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IFN0YW5pbWlyIFZhcmJhbm92IFttYWlsdG86c3ZhcmJhbm92QG1t
LXNvbC5jb21dDQo+ID4+IFNlbnQ6IDIwMTflubQ45pyIMTbml6UgMTk6MzQNCj4gPj4gVG86IFou
cS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4+IGJoZWxnYWFzQGdvb2dsZS5jb207IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBKb2Fv
LlBpbnRvQHN5bm9wc3lzLmNvbQ0KPiA+PiBDYzogTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54
cC5jb20+OyBNaW5na2FpIEh1DQo+ID4+IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8
cm95LnphbmdAbnhwLmNvbT47DQo+ID4+IG5pa2xhcy5jYXNzZWxAYXhpcy5jb207IGplc3Blci5u
aWxzc29uQGF4aXMuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2MyA2LzldIFBDSTogZGVz
aWdud2FyZTogYWRkIGFjY2Vzc29ycyBmb3Igd3JpdGUNCj4gPj4gcGVybWlzc2lvbiBvZiBEQkkg
cmVhZC1vbmx5IHJlZ2lzdGVycw0KPiA+Pg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4gT24gMDgvMTYv
MjAxNyAwNzo1NiBBTSwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+Pj4gRnJvbTogSG91IFpoaXFp
YW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPj4+DQo+ID4+PiBUaGUgcmVhZC1vbmx5IERC
SSByZWdpc3RlcnMgY2FuIGJlIHdyaXR0ZW4gb3ZlciB0aGUgREJJIHdoZW4gc2V0IHRoZQ0KPiA+
Pj4gIldyaXRlIHRvIFJPIFJlZ2lzdGVycyBVc2luZyBEQkkiIChEQklfUk9fV1JfRU4pIGZpZWxk
IG9mIHRoZQ0KPiA+Pj4gTUlTQ19DT05UUk9MXzFfT0ZGIHJlZ2lzdGVyLg0KPiA+Pj4NCj4gPj4+
IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4+
PiAtLS0NCj4gPj4+IFYzOg0KPiA+Pj4gIC0gTm8gY2hhbmdlDQo+ID4+Pg0KPiA+Pj4gIGRyaXZl
cnMvcGNpL2R3Yy9wY2llLWRlc2lnbndhcmUuaCB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPj4+IGIv
ZHJpdmVycy9wY2kvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4+PiBpbmRleCA3MzY2YzgxLi4w
YzVmODc0IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9wY2kvZHdjL3BjaWUtZGVzaWdud2Fy
ZS5oDQo+ID4+PiArKysgYi9kcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPj4+
IEBAIC03Niw2ICs3Niw5IEBADQo+ID4+PiAgI2RlZmluZSBQQ0lFX0FUVV9GVU5DKHgpCQkoKCh4
KSAmIDB4NykgPDwgMTYpDQo+ID4+PiAgI2RlZmluZSBQQ0lFX0FUVV9VUFBFUl9UQVJHRVQJCTB4
OTFDDQo+ID4+Pg0KPiA+Pj4gKyNkZWZpbmUgUENJRV9NSVNDX0NPTlRST0xfMV9PRkYJCTB4OEJD
DQo+ID4+PiArI2RlZmluZSBQQ0lFX0RCSV9ST19XUl9FTgkJKDB4MSA8PCAwKQ0KPiA+Pg0KPiA+
PiBEb2VzIHRob3NlIHJlZ2lzdGVycyBleGlzdCBmb3IgZHdjIHZlcnNpb24gNC4wMWE/DQo+ID4N
Cj4gPiBKb2FvLCBjYW4geW91IGhlbHAgdG8gY2hlY2sgdGhpcz8NCj4gPiBJIHJlZmVycmVkIHRv
IERlc2lnbldhcmUgY29yZXMgUENJIEV4cHJlc3MgY29udHJvbGxlciBkYXRhYm9vayB2ZXJzaW9u
DQo+IDQuMjFhLg0KPiA+IFRoZSBGcmVlc2NhbGUgTGF5ZXJzY2FwZSBpbXBsZW1lbnQgZG9lcyBu
b3QgZXhwb3J0IHRoZSB2ZXJzaW9uIG9mDQo+IGRlc2lnbndhcmUgUENJZSBjb250cm9sbGVyLCBJ
IGRvbid0IGtub3cgd2hpY2ggdmVyc2lvbnMgaGF2ZSB0aG9zZSByZWdpc3RlcnMsDQo+IGlmIGl0
IGRvZXMgbm90IHdvcmsgb24gcWNvbSBwbGF0Zm9ybSwgSSB3aWxsIHJlbW92ZSB0aGUgcWNvbSBy
ZWxhdGVkIGNoYW5nZXMuDQo+IA0KPiBJdCB3b24ndCB3b3JrIG9uIHR3byBvZiB0aGUgc3VwcG9y
dGVkIFNvQ3Mgc28gSSdkIHByZWZlciB0byBkcm9wIHFjb20NCj4gY2hhbmdlcyBmb3Igbm93Lg0K
DQpXaWxsIGRyb3AgdGhlbSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNClpoaXFpYW5nDQo=
