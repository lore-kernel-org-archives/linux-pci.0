Return-Path: <SRS0=OZOd=CT=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=OZOd=CT=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sinan Kaya' <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Oza Pawandeep <poza@codeaurora.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"timur@codeaurora.org" <timur@codeaurora.org>, Gabriele Paoloni
	<gabriele.paoloni@huawei.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dongdong Liu <liudongdong3@huawei.com>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
Date: Tue, 21 Nov 2017 16:25:09 +0000
Message-ID: <de047a7ce7334daab4e53ea4e8444421@AcuMS.aculab.com>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
 <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
In-Reply-To: <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

RnJvbTogU2luYW4gS2F5YQ0KPiBTZW50OiAxNiBOb3ZlbWJlciAyMDE3IDE0OjA0DQouLi4NCj4g
VGhlIGlzc3VlIGlzIHR3byBpbmRlcGVuZGVudCBzb2Z0d2FyZSBlbnRpdGllcyBhcmUgdHJ5aW5n
IHRvIHJlY292ZXIgdGhlIFBDSWUNCj4gbGluayBzaW11bHRhbmVvdXNseS4gQUVSIGFuZCBEUEMg
aGF2ZSB0d28gZGlmZmVyZW50IGFwcHJvYWNoZXMgdG8gbGluayByZWNvdmVyeS4NCj4gDQo+IEFF
UiBtYWtlcyBhIGNhbGxiYWNrIGludG8gdGhlIGVuZHBvaW50IGRyaXZlcnMgZm9yIG5vbi1mYXRh
bCBlcnJvcnMgYW5kIGhvcGUNCj4gdGhhdCBlbmRwb2ludCBkcml2ZXIgY2FuIHJlY292ZXIgdGhl
IGxpbmsuIEFFUiBhbHNvIG1ha2VzIGEgY2FsbGJhY2sgaW4gdGhlDQo+IGZhdGFsIGVycm9yIGNh
c2UgYnV0IHJlc2V0cyB0aGUgbGluayB2aWEgc2Vjb25kYXJ5IGJ1cyByZXNldC4NCj4gDQo+IFRo
ZSBEUEMgb24gdGhlIG90aGVyIGhhbmQgc3RvcHMgdGhlIGRyaXZlcnMgaW1tZWRpYXRlbHkgc2lu
Y2UgSFcgdG9vayBjYXJlIG9mDQo+IGxpbmsgZGlzYWJsZS4gKEVuZHBvaW50IHJlZ2lzdGVyIHJl
YWRzIHJldHVybiB+MCBhdCB0aGlzIHBvaW50LikNCg0KV2hhdCBoYXBwZW5zIGlmIHRoZSAndXNl
cicgZHJpdmVyIGRvZXNuJ3QgZGVmaW5lIHRoZSBlcnJvciByZXBvcnRpbmcgY2FsbGJhY2tzPw0K
SXQgbWlnaHQgYmUgaGFyZGVuZWQgYWdhaW5zdCB0aGUgfjB1IHJldHVybnMgZnJvbSByZWFkcyAt
IHNvIG5vdCBPT1BTLg0KSXQgbWlnaHQgYmUgYXBwcm9wcmlhdGUgdG8gY2FsbCB0aGUgcmVtb3Zl
KCkgZnVuY3Rpb24gaW5zdGVhZC4NCg0KPiBEUEMgZHJpdmVyIGNsZWFycw0KPiB0aGUgaW50ZXJy
dXB0IGZyb20gdGhlIERQQyBjYXBhYmlsaXR5IGFuZCBicmluZ3MgdGhlIGxpbmsgdXAgYXQgdGhl
IGVuZC4gRnVsbA0KPiBlbnVtZXJhdGlvbi9yZXNjYW4gZm9sbG93cyB0aGlzIHByb2NlZHVyZSB0
byBnbyBiYWNrIHRvIGZ1bmN0aW9uaW5nIHN0YXRlLg0KDQpUaGF0IG1pZ2h0IG5vdCBiZSBhIGdv
b2QgaWRlYSwgdmVyeSBsaWtlbHkgaXQgd2lsbCBmYWlsIGFnYWluIGltbWVkaWF0ZWx5Lg0KDQoJ
RGF2aWQNCg0K
