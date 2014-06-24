Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0181.outbound.protection.outlook.com ([207.46.163.181]:23522
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751206AbaFXXCI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jun 2014 19:02:08 -0400
From: Matthew Garrett <matthew.garrett@nebula.com>
To: "bonbons@linux-vserver.org" <bonbons@linux-vserver.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH 1/2 v2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Date: Tue, 24 Jun 2014 23:02:05 +0000
Message-ID: <1403650924.9762.16.camel@x230>
References: <20140514224339.7f8be3a9@neptune.home>
	 <20140527234255.GJ11907@google.com>	<20140602201650.35f0e936@neptune.home>
	 <20140602201926.4d476818@neptune.home>
	 <20140625005501.7ff7e982@neptune.home>
In-Reply-To: <20140625005501.7ff7e982@neptune.home>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkLCAyMDE0LTA2LTI1IGF0IDAwOjU1ICswMjAwLCBCcnVubyBQcsOpbW9udCB3cm90ZToN
Cg0KPiBXaXRoIGludHJvZHVjdGlvbiBvZiBzeXNmYi9zaW1wbGVmYi9zaW1wbGVkcm0gZWZpZmIg
aXMgZ2V0dGluZyBvYnNvbGV0ZQ0KPiB3aGlsZSBoYXZpbmcgbmF0aXZlIGRyaXZlcnMgZm9yIHRo
ZSBHUFUgYWxzbyBtYWtlcyBzZWxlY3RpbmcNCj4gc3lzZmIvZWZpZmIgb3B0aW9uYWwuDQo+IA0K
DQpCb3RoIGxvb2sgZ29vZCB0byBtZS4NCg0KQWNrZWQtYnk6IE1hdHRoZXcgR2FycmV0dCA8bWF0
dGhldy5nYXJyZXR0QG5lYnVsYS5jb20+DQoNCi0tIA0KTWF0dGhldyBHYXJyZXR0IDxtYXR0aGV3
LmdhcnJldHRAbmVidWxhLmNvbT4NCg==
