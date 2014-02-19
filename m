Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16843 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbaBSIaQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Feb 2014 03:30:16 -0500
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	Joerg Roedel <joro@8bytes.org>,
	"Dutt, Sudeep" <sudeep.dutt@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Stephen Hemminger" <stephen@networkplumber.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Brown, Aaron F" <aaron.f.brown@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: RE: [PATCH v2 2/4] mei: Add include of <linux/irqreturn.h>
Date: Wed, 19 Feb 2014 08:29:52 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B1AF74107@HASMSX106.ger.corp.intel.com>
References: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140218205946.11014.13654.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140218205946.11014.13654.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQoNCj4gDQo+IFdlIGN1cnJlbnRseSBpbmNsdWRlIDxsaW51eC9pcnFyZXR1cm4uaD4gaW4gPGxp
bnV4L3BjaS5oPiwgYnV0IEknbSBhYm91dCB0bw0KPiByZW1vdmUgdGhhdCBmcm9tIGxpbnV4L3Bj
aS5oLCBzbyBhZGQgZXhwbGljaXQgaW5jbHVkZXMgd2hlcmUgbmVlZGVkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL21pc2MvbWVpL2h3LW1lLmggfCAgICAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvaHctbWUuaCBi
L2RyaXZlcnMvbWlzYy9tZWkvaHctbWUuaA0KPiBpbmRleCA4MGJkODI5ZmJkOWEuLjg5M2Q1MTE5
ZmE5YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL21laS9ody1tZS5oDQo+ICsrKyBiL2Ry
aXZlcnMvbWlzYy9tZWkvaHctbWUuaA0KPiBAQCAtMjAsNiArMjAsNyBAQA0KPiAgI2RlZmluZSBf
TUVJX0lOVEVSRkFDRV9IXw0KPiANCj4gICNpbmNsdWRlIDxsaW51eC9tZWkuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9pcnFyZXR1cm4uaD4NCj4gICNpbmNsdWRlICJtZWlfZGV2LmgiDQo+ICAjaW5j
bHVkZSAiY2xpZW50LmgiDQoNCg0KT2theS4NCj4gDQoNCg==
