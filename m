Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0118.outbound.protection.outlook.com ([65.55.169.118]:22547
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750868AbaJBCkN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 22:40:13 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>,
	"linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v4 10/10] ARM: imx6sx: enable pcie on imx6sx sdb board
Date: Thu, 2 Oct 2014 02:40:10 +0000
Message-ID: <28E9FA64-81D5-42C2-ABCA-8B72239EC6AA@freescale.com>
References: <1412069804-17162-1-git-send-email-r65037@freescale.com>
	<1412069804-17162-11-git-send-email-r65037@freescale.com>,<CAOMZO5A3Bdxdspc_UnJcQ-DVrmUXQCKW0W08msnDs7TELzXEJg@mail.gmail.com>
In-Reply-To: <CAOMZO5A3Bdxdspc_UnJcQ-DVrmUXQCKW0W08msnDs7TELzXEJg@mail.gmail.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

WWVzLCAgUENJRV9QV1JfRU4gd291bGQgYmUgYWRkZWQgbGF0ZXIuDQpUaGFua3MsIEZhYmlvLg0K
DQpCZXN0IHJlZ2FyZHMNClJpY2hhcmQNCg0KPiDU2iAyMDE0xOoxMNTCMcjVo6zJz87nMTI6MjGj
rCJGYWJpbyBFc3RldmFtIiA8ZmVzdGV2YW1AZ21haWwuY29tPiDQtLXAo7oNCj4gDQo+IEhpIFJp
Y2hhcmQsDQo+IA0KPj4gT24gVHVlLCBTZXAgMzAsIDIwMTQgYXQgNjozNiBBTSwgUmljaGFyZCBa
aHUgPHI2NTAzN0BmcmVlc2NhbGUuY29tPiB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6IFJpY2hh
cmQgWmh1IDxyNjUwMzdAZnJlZXNjYWxlLmNvbT4NCj4+IC0tLQ0KPj4gYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnN4LXNkYi5kdHMgfCAxMyArKysrKysrKysrKysrDQo+PiAxIGZpbGUgY2hhbmdlZCwg
MTMgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnN4LXNkYi5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c3gtc2RiLmR0cw0KPj4gaW5k
ZXggYTM5ODBkOS4uMjk3NjkxMyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZzeC1zZGIuZHRzDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c3gtc2RiLmR0cw0K
Pj4gQEAgLTI1MSw2ICsyNTEsMTMgQEANCj4+ICAgICAgICB9Ow0KPj4gfTsNCj4+IA0KPj4gKyZw
Y2llIHsNCj4+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICsgICAgICAg
cGluY3RybC0wID0gPCZwaW5jdHJsX3BjaWU+Ow0KPj4gKyAgICAgICByZXNldC1ncGlvID0gPCZn
cGlvMiAwIDA+Ow0KPj4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4gDQo+IFRo
ZXJlIGlzIGFsc28gR1BJTzJfMSB3aGljaCBpcyB0aGUgUENJRV9QV1JfRU4gc2lnbmFsIGFuZCBz
aG91bGQgYmUNCj4gYWRkZWQgYXMgYSBHUElPIGNvbnRyb2xsZWQgcmVndWxhdG9yLg0K
