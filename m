Return-Path: <gabriele.paoloni@huawei.com>
Return-Path: <gabriele.paoloni@huawei.com>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        "liudongdong (C)"
	<liudongdong3@huawei.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        "tn@semihalf.com"
	<tn@semihalf.com>
CC: "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "Liviu.Dudau@arm.com"
	<Liviu.Dudau@arm.com>,
        "ddaney@caviumnetworks.com"
	<ddaney@caviumnetworks.com>,
        Wangyijing <wangyijing@huawei.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linaro-acpi@lists.linaro.org"
	<linaro-acpi@lists.linaro.org>,
        "jcm@redhat.com" <jcm@redhat.com>,
        "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>,
        "dhdang@apm.com"
	<dhdang@apm.com>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "cov@codeaurora.org" <cov@codeaurora.org>,
        "Chenxin (Charles)"
	<charles.chenxin@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [RFC PATCH V2 1/2] ACPI/PCI: Match PCI config space accessors
 against platfrom specific ECAM quirks
Date: Mon, 13 Jun 2016 14:29:01 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F782E15@lhreml507-mbx>
References: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
 <1465822923-33599-2-git-send-email-liudongdong3@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F782C86@lhreml507-mbx>
 <575EBD13.8080808@codeaurora.org>
In-Reply-To: <575EBD13.8080808@codeaurora.org>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

SGkgU2luYW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW5hbiBL
YXlhIFttYWlsdG86b2theWFAY29kZWF1cm9yYS5vcmddDQo+IFNlbnQ6IDEzIEp1bmUgMjAxNiAx
NTowMw0KPiBUbzogR2FicmllbGUgUGFvbG9uaTsgbGl1ZG9uZ2RvbmcgKEMpOyBoZWxnYWFzQGtl
cm5lbC5vcmc7DQo+IGFybmRAYXJuZGIuZGU7IHdpbGwuZGVhY29uQGFybS5jb207IGNhdGFsaW4u
bWFyaW5hc0Bhcm0uY29tOw0KPiByYWZhZWxAa2VybmVsLm9yZzsgaGFuanVuLmd1b0BsaW5hcm8u
b3JnOyBMb3JlbnpvLlBpZXJhbGlzaUBhcm0uY29tOw0KPiBqY2hhbmRyYUBicm9hZGNvbS5jb207
IHRuQHNlbWloYWxmLmNvbQ0KPiBDYzogcm9iZXJ0LnJpY2h0ZXJAY2F2aXVtbmV0d29ya3MuY29t
OyBtd0BzZW1paGFsZi5jb207DQo+IExpdml1LkR1ZGF1QGFybS5jb207IGRkYW5leUBjYXZpdW1u
ZXR3b3Jrcy5jb207IFdhbmd5aWppbmc7DQo+IFN1cmF2ZWUuU3V0aGlrdWxwYW5pdEBhbWQuY29t
OyBtc2FsdGVyQHJlZGhhdC5jb207IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGluYXJvLQ0KPiBhY3BpQGxp
c3RzLmxpbmFyby5vcmc7IGpjbUByZWRoYXQuY29tOyBhbmRyZWEuZ2FsbG9AbGluYXJvLm9yZzsN
Cj4gZGhkYW5nQGFwbS5jb207IGplcmVteS5saW50b25AYXJtLmNvbTsgY292QGNvZGVhdXJvcmEu
b3JnOyBDaGVueGluDQo+IChDaGFybGVzKTsgTGludXhhcm0NCj4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggVjIgMS8yXSBBQ1BJL1BDSTogTWF0Y2ggUENJIGNvbmZpZyBzcGFjZQ0KPiBhY2Nlc3Nv
cnMgYWdhaW5zdCBwbGF0ZnJvbSBzcGVjaWZpYyBFQ0FNIHF1aXJrcw0KPiANCj4gT24gNi8xMy8y
MDE2IDk6NTQgQU0sIEdhYnJpZWxlIFBhb2xvbmkgd3JvdGU6DQo+ID4gQXMgeW91IGNhbiBzZWUg
aGVyZSBMaXVkb25nZG9uZyBoYXMgcmVwbGFjZWQgb2VtX3JldmlzaW9uIHdpdGgNCj4gPiBvZW1f
dGFibGVfaWQuDQo+ID4NCj4gPiBOb3cgaXQgc2VlbXMgdGhhdCB0aGVyZSBhcmUgc29tZSBwbGF0
Zm9ybXMgdGhhdCBoYXZlIGFscmVhZHkgc2hpcHBlZA0KPiA+IHVzaW5nIGEgbWF0Y2hpbmcgYmFz
ZWQgb24gdGhlIG9lbV9yZXZpc2lvbiAocmlnaHQgSm9uPykNCj4gPg0KPiA+IEhvd2V2ZXIgSSBn
dWVzcyB0aGF0IGlmIGluIEZXIHRoZXkgaGF2ZSBkZWZpbmVkIG9lbV90YWJsZV9pZCBwcm9wZXJs
eQ0KPiA+IHRoZXkgc2hvdWxkIGJlIGFibGUgdG8gdXNlIHRoaXMgbWVjaGFuaXNtIHdpdGhvdXQg
bmVlZGluZyB0byBhIEZXDQo+IHVwZGF0ZS4NCj4gPg0KPiA+IENhbiB0aGVzZSB2ZW5kb3JzIGNv
bmZpcm0gdGhpcz8NCj4gPg0KPiA+IFRvbWFzeiBkbyB5b3UgdGhpbmsgdGhpcyBjYW4gd29yayBm
b3IgQ2F2aXVtIFRodW5kZXI/DQo+ID4NCj4gPiBUaGFua3MNCj4gPg0KPiA+IEdhYg0KPiANCj4g
V2h5IG5vdCBoYXZlIGFsbCB0aHJlZSBvZiB0aGVtPw0KPiANCj4gVGhlIGluaXRpYWwgYXBwcm9h
Y2ggd2FzIE9FTSBpZCBhbmQgcmV2aXNpb24gaWQuDQo+IA0KPiBKZWZmIEh1Z28gaW5kaWNhdGVk
IHRoYXQgYWRkaXRpb24gKG5vdCByZW1vdmluZyBhbnkgb3RoZXIgZmllbGRzKSBvZg0KPiB0YWJs
ZSBpZA0KPiB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UuDQoNCk1tbSBmcm9tIGxhc3QgZW1haWwgb2Yg
SmVmZiBIdWdvIG9uICJbUkZDIFBBVENIIDEvM10gcGNpLCBhY3BpOiBNYXRjaA0KUENJIGNvbmZp
ZyBzcGFjZSBhY2Nlc3NvcnMgYWdhaW5zdCBwbGF0ZnJvbSBzcGVjaWZpYyBFQ0FNIHF1aXJrcy4i
DQoNCkkgcXVvdGU6DQoNCiAiVXNpbmcgdGhlIE9FTSByZXZpc2lvbiANCiBmaWVsZCBkb2VzIG5v
dCBzZWVtIHRvIGJlIGFwcHJvcHJpYXRlIHNpbmNlIHRoZXNlIGFyZSBkaWZmZXJlbnQgDQogcGxh
dGZvcm1zIGFuZCB0aGUgcmV2aXNpb24gZmllbGQgYXBwZWFycyB0byBiZSBmb3IgdGhlIHB1cnBv
c2Ugb2YgDQogdHJhY2tpbmcgZGlmZmVyZW5jZXMgd2l0aGluIGEgc2luZ2xlIHBsYXRmb3JtLiAg
VGhlcmVmb3JlLCBDb3YgaXMgDQogcHJvcG9zaW5nIHVzaW5nIHRoZSBPRU0gdGFibGUgaWQgYXMg
YSBtZWNoYW5pc20gdG8gZGlzdGluZ3Vpc2gNCiBwbGF0Zm9ybSBBIChuZWVkcyBxdWlyayBhcHBs
aWVkKSB2cyBwbGF0Zm9ybSBCIChubyBxdWlya3MpIGZyb20gdGhlDQogc2FtZSBPRU0uIg0KDQpT
byBpdCBsb29rcyB0byBtZSB0aGF0IGhlIHBvaW50ZWQgb3V0IHRoYXQgdXNpbmcgdGhlIE9FTSBy
ZXZpc2lvbiBmaWVsZA0KaXMgd3JvbmcuLi5hbmQgdGhpcyBpcyB3aHkgSSBoYXZlIGFza2VkIGlm
IHJlcGxhY2luZyBpdCB3aXRoIHRoZSB0YWJsZQ0KaWQgY2FuIHdvcmsgZm9yIG90aGVyIHZlbmRv
cnMuLi4uDQoNClRoYW5rcw0KDQpHYWINCg0KDQo+IA0KPiAtLQ0KPiBTaW5hbiBLYXlhDQo+IFF1
YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBvbiBiZWhhbGYgb2YgUXVhbGNvbW0gSW5ub3ZhdGlv
biBDZW50ZXIsDQo+IEluYy4NCj4gUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMg
YSBtZW1iZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGENCj4gTGludXggRm91bmRhdGlvbiBDb2xs
YWJvcmF0aXZlIFByb2plY3QNCg==
