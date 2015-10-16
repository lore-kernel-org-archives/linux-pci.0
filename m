Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: "majun (F)" <majun258@huawei.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
Date: Fri, 16 Oct 2015 13:07:05 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E16248DEC@lhreml503-mbs>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1624783E@lhreml503-mbs>
 <561FE4CE.4090505@arm.com>
In-Reply-To: <561FE4CE.4090505@arm.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgta2VybmVsLQ0KPiBvd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBNYXJjIFp5bmdpZXINCj4gU2VudDogVGh1cnNkYXksIE9jdG9i
ZXIgMTUsIDIwMTUgNjozOSBQTQ0KPiBUbzogR2FicmllbGUgUGFvbG9uaTsgVGhvbWFzIEdsZWl4
bmVyOyBKaWFuZyBMaXU7IEphc29uIENvb3Blcg0KPiBDYzogbWFqdW4gKEYpOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZD
IDQvN10gZ2VuaXJxL21zaTogTWFrZSB0aGUgLnByZXBhcmUgY2FsbGJhY2sNCj4gcmV1c2FibGUN
Cj4gDQo+IE9uIDE1LzEwLzE1IDE4OjI0LCBHYWJyaWVsZSBQYW9sb25pIHdyb3RlOg0KPiA+IEhp
IE1hcmMNCj4gPg0KPiA+IEl0IGxvb2tzIGxpa2UgdGhpcyBwYXRjaCBmYWlscyB0byBhcHBseSB0
byA0LjMtcmM1Li4uLg0KPiANCj4gV2hpY2ggaXMgYnkgZGVzaWduLiBUcnkgdGlwL2lycS9jb3Jl
Lg0KDQpPb3BzIHNvcnJ5LCBnb3QgaXQhDQoNClRoYW5rcywgYXBwbGllcyBvayB0byB0aXAvaXJx
L2NvcmUNCg0KR2FiDQoNCg0KPiANCj4gCU0uDQo+IC0tDQo+IEphenogaXMgbm90IGRlYWQuIEl0
IGp1c3Qgc21lbGxzIGZ1bm55Li4uDQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBs
aXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1rZXJuZWwiDQo+IGluDQo+IHRo
ZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQo+IE1vcmUg
bWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8u
aHRtbA0KPiBQbGVhc2UgcmVhZCB0aGUgRkFRIGF0ICBodHRwOi8vd3d3LnR1eC5vcmcvbGttbC8N
Cg==
