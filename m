Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46888 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbbCXQMG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Mar 2015 12:12:06 -0400
From: "Jiang, Dave" <dave.jiang@intel.com>
To: "mst@redhat.com" <mst@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yhlu.kernel.send@gmail.com" <yhlu.kernel.send@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jdmason@kudzu.us" <jdmason@kudzu.us>,
	"famz@redhat.com" <famz@redhat.com>
Subject: Re: [PATCH v3 07/10] ntb: drop pci_msi_off call on probe
Date: Tue, 24 Mar 2015 16:12:03 +0000
Message-ID: <1427213523.221225.30.camel@intel.com>
References: <1427211032-2270-1-git-send-email-mst@redhat.com>
	 <1427211032-2270-8-git-send-email-mst@redhat.com>
In-Reply-To: <1427211032-2270-8-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

T24gVHVlLCAyMDE1LTAzLTI0IGF0IDE2OjQyICswMTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IHBjaSBjb3JlIG5vdyBkaXNhYmxlcyBtc2kgb24gcHJvYmUgYXV0b21hdGljYWxseSwN
Cj4gZHJvcCB0aGlzIGZyb20gZGV2aWNlLXNwZWNpZmljIGNvZGUuDQo+IA0KPiBDYzogQmpvcm4g
SGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNv
bT4NCg0KQWNrZWQtYnk6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9udGIvbnRiX2h3LmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL250Yi9udGJfaHcuYyBiL2Ry
aXZlcnMvbnRiL250Yl9ody5jDQo+IGluZGV4IGNkMjliMTAuLjgyMjVjYmMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbnRiL250Yl9ody5jDQo+ICsrKyBiL2RyaXZlcnMvbnRiL250Yl9ody5jDQo+
IEBAIC0xMzEzLDggKzEzMTMsNiBAQCBzdGF0aWMgaW50IG50Yl9zZXR1cF9pbnR4KHN0cnVjdCBu
dGJfZGV2aWNlICpuZGV2KQ0KPiAgCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gbmRldi0+cGRldjsN
Cj4gIAlpbnQgcmM7DQo+ICANCj4gLQlwY2lfbXNpX29mZihwZGV2KTsNCj4gLQ0KPiAgCS8qIFZl
cmlmeSBpbnR4IGlzIGVuYWJsZWQgKi8NCj4gIAlwY2lfaW50eChwZGV2LCAxKTsNCj4gIA0K
