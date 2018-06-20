Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:52956 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFTTKG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 15:10:06 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC: "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] ARC: Add PCIe support for ARC HSDK platform
Date: Wed, 20 Jun 2018 19:09:59 +0000
Message-ID: <ba16de7195ab84cc6f29f1a7ec2844dbc202392d.camel@synopsys.com>
References: <9f41b2f9d6da018563fa35aee462ddb60afd922f.1529505192.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <9f41b2f9d6da018563fa35aee462ddb60afd922f.1529505192.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgR3VzdGF2bywNCg0KT24gV2VkLCAyMDE4LTA2LTIwIGF0IDE3OjM2ICswMTAwLCBHdXN0YXZv
IFBpbWVudGVsIHdyb3RlOg0KPiBBZGQgUENJIHN1cHBvcnQgdG8gdGhlIEFSQyBIU0RLIHBsYXRm
b3JtIGFsbG93aW5nIHRvIHVzZSB0aGUgZ2VuZXJpYyBQQ0kNCj4gc2V0dXAgZnVuY3Rpb25zLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBz
eW5vcHN5cy5jb20+DQo+IC0tLQ0KPiBDaGFuZ2UgdjEtPnYyOg0KPiAgLSBTcGxpdCBpbml0aWFs
IHBhdGNoLCBmb2xsb3dpbmcgQWxleGV5IEJyb2RraW4gc3VnZ2VzdGlvbi4NCj4gDQo+ICBhcmNo
L2FyYy9wbGF0LWhzZGsvS2NvbmZpZyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvcGxhdC1oc2RrL0tjb25maWcgYi9h
cmNoL2FyYy9wbGF0LWhzZGsvS2NvbmZpZw0KPiBpbmRleCAxOWFiM2NmLi41NTZiYzVlIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FyYy9wbGF0LWhzZGsvS2NvbmZpZw0KPiArKysgYi9hcmNoL2FyYy9w
bGF0LWhzZGsvS2NvbmZpZw0KPiBAQCAtOSwzICs5LDQgQEAgbWVudWNvbmZpZyBBUkNfU09DX0hT
REsNCj4gIAlib29sICJBUkMgSFMgRGV2ZWxvcG1lbnQgS2l0IFNPQyINCj4gIAlzZWxlY3QgQ0xL
X0hTREsNCj4gIAlzZWxlY3QgUkVTRVRfSFNESw0KPiArCXNlbGVjdCBNSUdIVF9IQVZFX1BDSQ0K
DQpBZGRpbmcgQmpvcm4gYW5kIGxpbnV4LXBjaSBtYWlsaW5nIGxpc3RzLCBvdGhlcndpc2UuLi4N
Cg0KQWNrZWQtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBzeW5vcHN5cy5jb20+DQoNCg==
