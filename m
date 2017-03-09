Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:41504
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753919AbdCIJ1g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Mar 2017 04:27:36 -0500
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Primoz Fiser <primoz.fiser@norik.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Quick question on PCI EP framework
Date: Thu, 9 Mar 2017 09:11:59 +0000
Message-ID: <AM5PR0402MB2850F8EB13CE89B7C97C70A78C210@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <bc702b72-bf0f-d894-6408-40f4e721057e@norik.com>
 <58C115ED.9040305@ti.com>
In-Reply-To: <58C115ED.9040305@ti.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hvbiBWaWpheSBBYnJh
aGFtIEkgW21haWx0bzpraXNob25AdGkuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMDks
IDIwMTcgNDo0NCBQTQ0KPiBUbzogUHJpbW96IEZpc2VyIDxwcmltb3ouZmlzZXJAbm9yaWsuY29t
PjsgUmljaGFyZCBaaHUNCj4gPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVjYXMgU3RhY2ggPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+OyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogUXVpY2sgcXVlc3Rpb24gb24gUENJIEVQIGZyYW1ld29yaw0KPiANCj4gK1Jp
Y2hhcmQgWmh1LCBMdWNhcyBTdGFjaCwgbGludXgtcGNpDQo+IA0KPiBIaSBQcmltb3osDQo+IA0K
PiBPbiBUaHVyc2RheSAwOSBNYXJjaCAyMDE3IDAxOjQ4IFBNLCBQcmltb3ogRmlzZXIgd3JvdGU6
DQo+ID4gSGVsbG8gS2lzaG9uLA0KPiA+DQo+ID4gSSBoYXZlIGEgcXVpY2sgcXVlc3Rpb24gb24g
bmV3bHkgcmVsZWFzZWQgUENJIEVQIGZyYW1ld29yayBieSB5b3UhDQo+ID4NCj4gPiBGaXJzdCBv
ZiBhbGwsIHRoYW5rIHlvdSBmb3IgcHJvdmlkaW5nIHN1Y2ggYSBjb21wcmVoZW5zaXZlIGZyYW1l
d29yay4NCj4gPg0KPiA+IEFuZCBoZXJlIGlzIG15IHF1ZXN0aW9uLCBpcyBpLk1YNlEgd2l0aCBk
ZXNpZ253YXJlIFBDSWUgSVAgY2FwYWJsZSBvZg0KPiA+IHByb3ZpZGluZyBFUCBmdW5jdGlvbmFs
aXR5IHRocm91Z2ggeW91ciBmcmFtZXdvcms/IERvIHdlIG5lZWQgc3BlY2lmaWMgSVANCj4gY29y
ZSB2ZXJzaW9uPw0KPiANCj4gSSdtIG5vdCBzdXJlIG9mIHRoZSBleGFjdCB2ZXJzaW9uIHVzZWQg
aW4gaS5NWDZRLiBSaWNoYXJkIFpodSBvciBMdWNhcyBTdGFjaA0KPiB3aG8gbWFpbnRhaW4gdGhl
IFBDSSBkcml2ZXIgbWlnaHQgaGF2ZSB0aGF0IGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gSWYgeWVz
LCB3ZSBwcm9iYWJseSBuZWVkIHRvIHBvcnQgc3R1ZmYgZnJvbSBkcmE3eHggcmlnaHQ/DQo+IA0K
PiBZZXMsIEkgdGhpbmsgc29tZSBwb3J0aW5nIHdpbGwgYmUgcmVxdWlyZWQgKGRlc2lnbndhcmUg
Y29yZSBkcml2ZXIgYWxyZWFkeQ0KPiBzdXBwb3J0cyBFUCBtb2RlIG9ubHkgdGhlIGkuTVhRIHNw
ZWNpZmljIHBhcnQgaGF2ZSB0byBiZSBtb2RpZmllZCkuDQo+IA0KPiBUaGFua3MNCj4gS2lzaG9u
DQoNCkhpIEtpc2hvbjoNClRoYW5rcyBmb3IgeW91ciBpbmZvcm1hdGlvbi4NCmlNWDZRIFBDSWUg
aGFzIHRoZSBFUCBmdW5jdGlvbiwgYW5kIGl0J3MgZGVzaWdud2FyZSBJUCB2ZXJzaW9uIGlzIDMu
ODAuDQoNCkJlc3QgUmVnYXJkcw0KaG9uZ3hpbmcgemh1DQpMaW51eCBCU1AgdGVhbQ0KT2ZmaWNl
OiA4Ni0yMS0yODkzNzE4OQ0KRW1haWw6IGhvbmd4aW5nLnpodUBueHAuY29tDQoNCg==
