Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32971 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938AbaCXE2v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Mar 2014 00:28:51 -0400
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Mon, 24 Mar 2014 12:02:32 +0800
Subject: RE: [PATCH V2 0/2] PCI: dessignware: fixes and cleanup
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FE74A982@EAPEX1MAIL1.st.com>
References: <cover.1392904207.git.mohit.kumar@st.com>
In-Reply-To: <cover.1392904207.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGVsbG8gQmpvcm4sDQoNClBscyBsb29rIGlmIHRoZXNlIHNtYWxsIHBhdGNoZXMgY2FuIGFsc28g
YmUgcGlja2VkIGZvciB5b3VyIHRyZWUuDQoNClRoYW5rcw0KTW9oaXQNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNb2hpdCBLVU1BUiBEQ0cNCj4gU2VudDogVGh1cnNk
YXksIEZlYnJ1YXJ5IDI3LCAyMDE0IDExOjMxIEFNDQo+IFRvOiBiaGVsZ2Fhc0Bnb29nbGUuY29t
DQo+IENjOiBNb2hpdCBLVU1BUiBEQ0c7IEppbmdvbyBIYW47IHNwZWFyLWRldmVsOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBWMiAwLzJdIFBDSTogZGVzc2ln
bndhcmU6IGZpeGVzIGFuZCBjbGVhbnVwDQo+IA0KPiBUaGlzIHBhdGNoc2V0IGZpeGVzIGlBVFUg
cHJvZ3JhbW1pbmcgc2VxdWVuY2UgYW5kIGNvcnJlY3Qgc29tZQ0KPiBjb21tZW50cy4NCj4gDQo+
IENoYW5nZXMgc3NpbmNlIHYxOg0KPiAJLSBDaGFuZ2Ugc3N1YmplY3QgbGluZSB3aXRoIHByb3Bl
ciBzcGFjaW5nDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNb2hpdCBLdW1hciA8bW9oaXQua3VtYXJA
c3QuY29tPg0KPiBDYzogSmluZ29vIEhhbiA8amcxLmhhbkBzYW1zdW5nLmNvbT4NCj4gQ2M6IEJq
b3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IENjOiBzcGVhci1kZXZlbEBsaXN0
LnN0LmNvbQ0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiANCj4gTW9oaXQgS3Vt
YXIgKDIpOg0KPiAgIFBDSTogZGVzaWdud2FyZTogRml4IGNvbW1lbnQgZm9yIHNldHRpbmcgbnVt
YmVyIG9mIGxhbmVzDQo+ICAgUENJOiBkZXNpZ253YXJlOiBGaXggaUFUVSBwcm9ncmFtbWluZyBm
b3IgY2ZnMSwgaW8gYW5kIG1lbSB2aWV3cG9ydA0KPiANCj4gIGRyaXZlcnMvcGNpL2hvc3QvcGNp
ZS1kZXNpZ253YXJlLmMgfCAgICA4ICsrKystLS0tDQo+ICAxIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDEuNy4zLjQNCg0K
