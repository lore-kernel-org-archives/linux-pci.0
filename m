Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:55104
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752667AbdHICwV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Aug 2017 22:52:21 -0400
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
CC: "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, "Roy Zang" <roy.zang@nxp.com>
Subject: RE: [PATCHv2 3/6] PCI: layerscape: use accessors to enable/disable
 DBI RO registers' write permission
Date: Wed, 9 Aug 2017 02:52:18 +0000
Message-ID: <AM5PR0402MB27714A7A3DDCF0B917E6601D848B0@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-4-git-send-email-Zhiqiang.Hou@nxp.com>
 <a7c1e517-4488-c979-fc13-e45fc78809be@synopsys.com>
In-Reply-To: <a7c1e517-4488-c979-fc13-e45fc78809be@synopsys.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgSm9hbywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGFjayENCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FvIFBpbnRvIFttYWlsdG86Sm9hby5QaW50b0BzeW5v
cHN5cy5jb21dDQo+IFNlbnQ6IDIwMTflubQ45pyIOOaXpSAyMDo0Ng0KPiBUbzogWi5xLiBIb3Ug
PHpoaXFpYW5nLmhvdUBueHAuY29tPjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IEpvYW8uUGludG9Ac3lub3Bz
eXMuY29tDQo+IENjOiBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkg
SHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47DQo+IFJveSBaYW5nIDxyb3kuemFuZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIdjIgMy82XSBQQ0k6IGxheWVyc2NhcGU6IHVzZSBhY2Nlc3Nv
cnMgdG8gZW5hYmxlL2Rpc2FibGUNCj4gREJJIFJPIHJlZ2lzdGVycycgd3JpdGUgcGVybWlzc2lv
bg0KPiANCj4gw4BzIDk6MjMgQU0gZGUgOC8zLzIwMTcsIFpoaXFpYW5nIEhvdSBlc2NyZXZldToN
Cj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4g
VXNlIHRoZSBhY2Nlc3NvcnMgaW5zdGVhZCBhY2Nlc3NpbmcgdGhlIERCSSByZWFkLW9ubHkgd3Jp
dGUgZW5hYmxlDQo+ID4gcmVnaXN0ZXIgZGlyZWN0bHkuIEFuZCB0aGUgU1RSRk1SMSBpcyBub3Qg
cmVhZC1vbmx5IHJlZ2lzdGVyLCBzbyBtb3ZlDQo+ID4gaXQgb3V0IGZyb20gdGhlIHdyaXRlLWVu
YWJsZSBicmFja2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlx
aWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBWMjoNCj4gPiAgLSBOZXcgcGF0Y2ggc3Bs
aXQgZnJvbSBwYXRjaCB2MSAzLzMuDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvZHdjL3BjaS1sYXll
cnNjYXBlLmMgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2R3Yy9w
Y2ktbGF5ZXJzY2FwZS5jDQo+ID4gYi9kcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVyc2NhcGUuYw0K
PiA+IGluZGV4IGZkODYxMjguLjA5MDU2YTYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
ZHdjL3BjaS1sYXllcnNjYXBlLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9kd2MvcGNpLWxheWVy
c2NhcGUuYw0KPiA+IEBAIC0zMyw3ICszMyw2IEBADQo+ID4NCj4gPiAgLyogUEVYIEludGVybmFs
IENvbmZpZ3VyYXRpb24gUmVnaXN0ZXJzICovDQo+ID4gICNkZWZpbmUgUENJRV9TVFJGTVIxCQkw
eDcxYyAvKiBTeW1ib2wgVGltZXIgJiBGaWx0ZXIgTWFzaw0KPiBSZWdpc3RlcjEgKi8NCj4gPiAt
I2RlZmluZSBQQ0lFX0RCSV9ST19XUl9FTgkweDhiYyAvKiBEQkkgUmVhZC1Pbmx5IFdyaXRlIEVu
YWJsZQ0KPiBSZWdpc3RlciAqLw0KPiA+DQo+ID4gIHN0cnVjdCBsc19wY2llX2RydmRhdGEgew0K
PiA+ICAJdTMyIGx1dF9vZmZzZXQ7DQo+ID4gQEAgLTE1NSwxMSArMTU0LDEyIEBAIHN0YXRpYyB2
b2lkIGxzX3BjaWVfaG9zdF9pbml0KHN0cnVjdCBwY2llX3BvcnQgKnBwKQ0KPiA+ICAJc3RydWN0
IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9wcChwcCk7DQo+ID4gIAlzdHJ1Y3QgbHNf
cGNpZSAqcGNpZSA9IHRvX2xzX3BjaWUocGNpKTsNCj4gPg0KPiA+IC0JaW93cml0ZTMyKDEsIHBj
aS0+ZGJpX2Jhc2UgKyBQQ0lFX0RCSV9ST19XUl9FTik7DQo+ID4gKwlkd19wY2llX2RiaV9yb193
cl9lbihwY2kpOw0KPiA+ICAJbHNfcGNpZV9maXhfY2xhc3MocGNpZSk7DQo+ID4gIAlsc19wY2ll
X2NsZWFyX211bHRpZnVuY3Rpb24ocGNpZSk7DQo+ID4gKwlkd19wY2llX2RiaV9yb193cl9kaXMo
cGNpKTsNCj4gPiArDQo+ID4gIAlsc19wY2llX2Ryb3BfbXNnX3RscChwY2llKTsNCj4gPiAtCWlv
d3JpdGUzMigwLCBwY2ktPmRiaV9iYXNlICsgUENJRV9EQklfUk9fV1JfRU4pOw0KPiA+ICB9DQo+
ID4NCj4gPiAgc3RhdGljIGludCBsc19wY2llX21zaV9ob3N0X2luaXQoc3RydWN0IHBjaWVfcG9y
dCAqcHAsDQo+ID4NCj4gDQo+IEFja2VkLUJ5OiBKb2FvIFBpbnRvIDxqcGludG9Ac3lub3BzeXMu
Y29tPg0KDQotIFpoaXFpYW5nDQo=
