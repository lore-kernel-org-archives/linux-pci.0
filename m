Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50087.outbound.protection.outlook.com ([40.107.5.87]:44399
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754503AbdHYDUu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 23:20:50 -0400
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, "Roy Zang" <roy.zang@nxp.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Subject: RE: [PATCHv4 7/9] PCI: layerscape: use accessors to enable/disable
 DBI RO registers' write permission
Date: Fri, 25 Aug 2017 03:20:47 +0000
Message-ID: <AM5PR0402MB27710F07F62FF307A8EE5F4F849B0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
 <20170823060856.9387-8-Zhiqiang.Hou@nxp.com>
 <20170824171445.GQ31858@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170824171445.GQ31858@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE3xOo41MIyNcjVIDE6MTUNCj4gVG86IFoucS4gSG91
IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBKb2FvLlBpbnRv
QHN5bm9wc3lzLmNvbTsgTS5oLiBMaWFuDQo+IDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBNaW5n
a2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZw0KPiA8cm95LnphbmdAbnhwLmNv
bT47IHN2YXJiYW5vdkBtbS1zb2wuY29tOyBuaWtsYXMuY2Fzc2VsQGF4aXMuY29tOw0KPiBqZXNw
ZXIubmlsc3NvbkBheGlzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjQgNy85XSBQQ0k6IGxh
eWVyc2NhcGU6IHVzZSBhY2Nlc3NvcnMgdG8gZW5hYmxlL2Rpc2FibGUNCj4gREJJIFJPIHJlZ2lz
dGVycycgd3JpdGUgcGVybWlzc2lvbg0KPiANCj4gT24gV2VkLCBBdWcgMjMsIDIwMTcgYXQgMDI6
MDg6NTRQTSArMDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFu
ZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBVc2UgdGhlIGFjY2Vzc29ycyBpbnN0
ZWFkIGFjY2Vzc2luZyB0aGUgREJJIHJlYWQtb25seSB3cml0ZSBlbmFibGUNCj4gPiByZWdpc3Rl
ciBkaXJlY3RseS4NCj4gDQo+IFRoaXMgcGF0Y2ggYW5kIHRoZSBwcmV2aW91cyBvbmUgKHRoYXQg
YWRkZWQgZHdfcGNpZV9kYmlfcm9fd3JfZW4oKSkgc2hvdWxkDQo+IGJlIHNxdWFzaGVkIHRvZ2V0
aGVyLiAgVGhhdCB3YXkgaXQncyBvYnZpb3VzIHRoYXQgdGhlIG5ldyBjb2RlIGhlcmUgaXMNCj4g
ZXF1aXZhbGVudCB0byB0aGUgb2xkIGNvZGUNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24s
IHdpbGwgbWVyZ2UgdGhlbSB0b2dldGhlci4NCg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpo
aXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiBBY2tlZC1CeTogSm9hbyBQaW50byA8
anBpbnRvQHN5bm9wc3lzLmNvbT4NCj4gPiAtLS0NCj4gPiBWNDoNCj4gPiAgLSBubyBjaGFuZ2UN
Cj4gPg0KPiA+ICBkcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVyc2NhcGUuYyB8IDUgKystLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVyc2NhcGUuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvZHdjL3BjaS1sYXllcnNjYXBlLmMNCj4gPiBpbmRleCA0NGE2MDNkYjIxN2Eu
LjBjMTMzMGZjZTAxZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVy
c2NhcGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2R3Yy9wY2ktbGF5ZXJzY2FwZS5jDQo+ID4g
QEAgLTMzLDcgKzMzLDYgQEANCj4gPg0KPiA+ICAvKiBQRVggSW50ZXJuYWwgQ29uZmlndXJhdGlv
biBSZWdpc3RlcnMgKi8NCj4gPiAgI2RlZmluZSBQQ0lFX1NUUkZNUjEJCTB4NzFjIC8qIFN5bWJv
bCBUaW1lciAmIEZpbHRlciBNYXNrDQo+IFJlZ2lzdGVyMSAqLw0KPiA+IC0jZGVmaW5lIFBDSUVf
REJJX1JPX1dSX0VOCTB4OGJjIC8qIERCSSBSZWFkLU9ubHkgV3JpdGUgRW5hYmxlDQo+IFJlZ2lz
dGVyICovDQo+ID4NCj4gPiAgI2RlZmluZSBQQ0lFX0lBVFVfTlVNCQk2DQo+ID4NCj4gPiBAQCAt
MTQ1LDEwICsxNDQsMTAgQEAgc3RhdGljIGludCBsc19wY2llX2hvc3RfaW5pdChzdHJ1Y3QgcGNp
ZV9wb3J0ICpwcCkNCj4gPiAgCSAqLw0KPiA+ICAJbHNfcGNpZV9kaXNhYmxlX291dGJvdW5kX2F0
dXMocGNpZSk7DQo+ID4NCj4gPiAtCWlvd3JpdGUzMigxLCBwY2ktPmRiaV9iYXNlICsgUENJRV9E
QklfUk9fV1JfRU4pOw0KPiA+ICsJZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNpKTsNCj4gPiAgCWxz
X3BjaWVfZml4X2NsYXNzKHBjaWUpOw0KPiA+ICAJbHNfcGNpZV9jbGVhcl9tdWx0aWZ1bmN0aW9u
KHBjaWUpOw0KPiA+IC0JaW93cml0ZTMyKDAsIHBjaS0+ZGJpX2Jhc2UgKyBQQ0lFX0RCSV9ST19X
Ul9FTik7DQo+ID4gKwlkd19wY2llX2RiaV9yb193cl9kaXMocGNpKTsNCj4gPg0KPiA+ICAJbHNf
cGNpZV9kcm9wX21zZ190bHAocGNpZSk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTQuMQ0KPiA+DQoN
ClRoYW5rcywNClpoaXFpYW5nDQo=
