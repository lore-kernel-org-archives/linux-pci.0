Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0051.outbound.protection.outlook.com ([104.47.2.51]:11344
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750724AbeCMEXC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 00:23:02 -0400
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Sinan Kaya <okaya@codeaurora.org>, "hch@lst.de" <hch@lst.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Date: Tue, 13 Mar 2018 04:22:53 +0000
Message-ID: <HE1PR0401MB24250A8631823FB3108EA62CE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org>
In-Reply-To: <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2luYW4gS2F5YSBbbWFp
bHRvOm9rYXlhQGNvZGVhdXJvcmEub3JnXQ0KPiBTZW50OiBNb25kYXksIE1hcmNoIDEyLCAyMDE4
IDIyOjE0DQo+IFRvOiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT47IGhjaEBsc3Qu
ZGU7DQo+IHJvYmluLm11cnBoeUBhcm0uY29tOyBsaW51eEBhcm1saW51eC5vcmcudWs7IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IGJoZWxn
YWFzQGdvb2dsZS5jb20NCj4gQ2M6IGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb207IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOw0KPiBqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tOyBs
aW51cy53YWxsZWlqQGxpbmFyby5vcmc7IGpvaGFuQGtlcm5lbC5vcmc7DQo+IG1zdWNoYW5la0Bz
dXNlLmRlOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpb21tdUBsaXN0cy5saW51eC0N
Cj4gZm91bmRhdGlvbi5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZG1hLW1hcHBpbmc6IG1vdmUgZG1hIGNvbmZpZ3VyYXRpb24gdG8gYnVzDQo+
IGluZnJhc3RydWN0dXJlDQo+IA0KPiBPbiAzLzEyLzIwMTggMTE6MjQgQU0sIE5pcHVuIEd1cHRh
IHdyb3RlOg0KPiA+ICsJaWYgKGRtYV9kZXYtPm9mX25vZGUpIHsNCj4gPiArCQlyZXQgPSBvZl9k
bWFfY29uZmlndXJlKGRldiwgZG1hX2Rldi0+b2Zfbm9kZSk7DQo+ID4gKwl9IGVsc2UgaWYgKGhh
c19hY3BpX2NvbXBhbmlvbihkbWFfZGV2KSkgew0KPiA+ICsJCWF0dHIgPSBhY3BpX2dldF9kbWFf
YXR0cih0b19hY3BpX2RldmljZV9ub2RlKGRtYV9kZXYtDQo+ID5md25vZGUpKTsNCj4gPiArCQlp
ZiAoYXR0ciAhPSBERVZfRE1BX05PVF9TVVBQT1JURUQpDQo+ID4gKwkJCXJldCA9IGFjcGlfZG1h
X2NvbmZpZ3VyZShkZXYsIGF0dHIpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBjaV9wdXRfaG9z
dF9icmlkZ2VfZGV2aWNlKGJyaWRnZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArdm9pZCBwY2lfZG1hX2RlY29uZmlndXJlKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiArew0KPiA+ICsJb2ZfZG1hX2RlY29uZmlndXJlKGRldik7DQo+ID4gKwlhY3BpX2Rt
YV9kZWNvbmZpZ3VyZShkZXYpOw0KPiA+ICt9DQo+IA0KPiBJc24ndCB0aGlzIG9uZSBvciB0aGUg
b3RoZXIgb25lIGJ1dCBub3QgYm90aD8NCj4gDQo+IFNvbWV0aGluZyBsaWtlOg0KPiANCj4gaWYg
KGRldi0+b2Zfbm9kZSkNCj4gCW9mX2RtYV9kZWNvbmZpZ3VyZShkZXYpOw0KPiBlbHNlDQo+IAlh
Y3BpX2RtYV9kZWNvbmZpZ3VyZShkZXYpOw0KPiANCj4gc2hvdWxkIHdvcmsuDQoNCkkgdW5kZXJz
dGFuZCB5b3VyIHBvaW50LiBTZWVtcyByZWFzb25hYmxlIGFzIHdlIHNob3VsZCBub3QgZXhwZWN0
DQp0aGUgJ29mL2FjcGkgRE1BIGRlY29uZmlndXJlJyBBUEkgdG8gbm90IGZhaWwgd2hlbiB0aGV5
IGFyZSBub3QgY29uZmlndXJlZC4NCg0KQnV0LCBoZXJlIHdlIHdvdWxkIGFsc28gbmVlZCB0byBn
ZXQgZG1hX2RldmljZSAoanVzdCBhcyB3ZSBnZXQgaW4NCidwY2lfZG1hX2NvbmZpZ3VyZScpIGFu
ZCBuZWVkIGEgY2hlY2sgb24gaXQgYXMgZm9yIFBDSSB0aGVyZSAnb2Zfbm9kZScNCmlzIHByZXNl
bnQgaW4gdGhlIGRtYV9kZXYuDQoNCklsbCB1cGRhdGUgdGhpcyBpbiB2MiwgYW5kIGFsc28gbWFr
ZSBzaW1pbGFyIGNoYW5nZXMgZm9yIHBsYXRmb3JtIGFuZCBBTUJBIGJ1cy4NCg0KVGhhbmtzLA0K
TmlwdW4NCg0KPiANCj4gLS0NCj4gU2luYW4gS2F5YQ0KPiBRdWFsY29tbSBEYXRhY2VudGVyIFRl
Y2hub2xvZ2llcywgSW5jLiBhcyBhbiBhZmZpbGlhdGUgb2YgUXVhbGNvbW0NCj4gVGVjaG5vbG9n
aWVzLCBJbmMuDQo+IFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBpcyBhIG1lbWJlciBvZiB0
aGUgQ29kZSBBdXJvcmEgRm9ydW0sIGEgTGludXgNCj4gRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZl
IFByb2plY3QuDQo=
