Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0115.outbound.protection.outlook.com ([207.46.100.115]:48064
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756914AbaJICyB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Oct 2014 22:54:01 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: RE: [PATCH v4 02/10] PCI: imx6: add imx6sx pcie support
Date: Thu, 9 Oct 2014 02:53:59 +0000
Message-ID: <47f86e0cc3c44de7a8124cff706830bf@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1412068796-16931-1-git-send-email-r65037@freescale.com>
 <1412068796-16931-3-git-send-email-r65037@freescale.com>
 <CAErSpo5Uw-5cYA2xVe-S09D7adxiAEEHY9atCgNJZqfBDTX6MQ@mail.gmail.com>
In-Reply-To: <CAErSpo5Uw-5cYA2xVe-S09D7adxiAEEHY9atCgNJZqfBDTX6MQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJqb3JuIEhlbGdhYXMgW21h
aWx0bzpiaGVsZ2Fhc0Bnb29nbGUuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAwOSwg
MjAxNCAxOjEwIEFNDQo+IFRvOiBaaHUgUmljaGFyZC1SNjUwMzcNCj4gQ2M6IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7IEd1byBTaGF3bi1SNjUwNzM7IEZhYmlvIEVzdGV2YW07IEx1Y2FzIFN0
YWNoOw0KPiB0aGFydmV5QGdhdGV3b3Jrcy5jb207IFpodSBSaWNoYXJkLVI2NTAzNw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0IDAyLzEwXSBQQ0k6IGlteDY6IGFkZCBpbXg2c3ggcGNpZSBzdXBw
b3J0DQo+IA0KPiBbK2NjIEhvbmctWGluZy5aaHUsIC1jYyBsaW51eC1wY2ktb3duZXJdDQo+IA0K
PiBIaSBSaWNoYXJkLA0KPiANCj4gSSBhc3N1bWUgdGhlc2UgZW1haWwgYWRkcmVzc2VzOg0KPiAN
Cj4gICBSaWNoYXJkIFpodSA8cjY1MDM3QGZyZWVzY2FsZS5jb20+DQo+ICAgSG9uZy1YaW5nLlpo
dUBmcmVlc2NhbGUuY29tIDxIb25nLVhpbmcuWmh1QGZyZWVzY2FsZS5jb20+DQo+IA0KPiBhcmUg
cmVhbGx5IHRoZSBzYW1lIHBlcnNvbi4gIElmIHNvLCB3b3VsZCB5b3UgbWluZCB1c2luZyBvbmUg
b2YgdGhlbQ0KPiBjb25zaXN0ZW50bHksIG9yIGF0IGxlYXN0IHVzaW5nIHRoZSBzYW1lIGRpc3Bs
YXkgbmFtZSAoIlJpY2hhcmQgWmh1Ig0KPiBvciAiSG9uZy1YaW5nLlpodSIpPyAgSXQncyBjb25m
dXNpbmcgdG8gZm9sbG93IGEgY29udmVyc2F0aW9uIHdoZW4gb25lIHBlcnNvbg0KPiB1c2VzIHNl
dmVyYWwgbmFtZXMuDQo+IA0KW1JpY2hhcmRdIE9rLCBubyBwcm9ibGVtLg0KDQo+IEFsc28sIHRo
ZXJlJ3Mgbm8gbmVlZCB0byBjYzogbGludXgtcGNpLW93bmVyQHZnZXIua2VybmVsLm9yZy4gIFRo
YXQgZG9lc24ndCBnbw0KPiBhbnl3aGVyZSwgYXMgZmFyIGFzIEkga25vdy4gIGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmcgaXMgZW5vdWdoLg0KPiANCj4gQmpvcm4NCltSaWNoYXJkXSBVbmRlcnN0
YW5kLiBUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0K
