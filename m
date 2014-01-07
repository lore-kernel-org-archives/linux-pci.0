Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:12596
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756122AbaAGJvz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jan 2014 04:51:55 -0500
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC: Scott Wood <scottwood@freescale.com>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Roy Zang <tie-fei.zang@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] pci: Fix root port bus->self is NULL
Date: Tue, 7 Jan 2014 09:51:34 +0000
Message-ID: <80033eb36b0f40d682aeecc8b99dbd95@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <52CBBA86.7020401@huawei.com> <52CBC0B6.1090904@linux.intel.com>
In-Reply-To: <52CBC0B6.1090904@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMvcGNpL3Byb2Jl
LmMgaW5kZXgNCj4gPj4gMzhlNDAzZC4uN2YyZDFhYiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9wY2kvcHJvYmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+ID4+IEBAIC0x
NDcyLDYgKzE0NzIsOSBAQCBpbnQgcGNpX3NjYW5fc2xvdChzdHJ1Y3QgcGNpX2J1cyAqYnVzLCBp
bnQgZGV2Zm4pDQo+ID4+ICAJaWYgKCFkZXYtPmlzX2FkZGVkKQ0KPiA+PiAgCQlucisrOw0KPiA+
Pg0KPiA+PiArCWlmIChwY2lfcGNpZV90eXBlKGRldikgPT0gUENJX0VYUF9UWVBFX1JPT1RfUE9S
VCkNCj4gPj4gKwkJYnVzLT5zZWxmID0gZGV2Ow0KPiA+DQo+ID4gSW4gdGhpcyBjYXNlLCBidXMg
aXMgdGhlIHBjaSByb290IGJ1cyBJIHRoaW5rLCBzbyB3aHkgc2V0IGJ1cy0+c2VsZiA9IHJvb3QN
Cj4gcG9ydCA/DQo+ID4gImJ1cy0+c2VsZiIgc2hvdWxkIHBvaW50ZXIgdG8gdGhlIHBjaSBkZXZp
Y2UgdGhhdCBicmlkZ2Ugb3V0IHRoaXMgYnVzLg0KPiBZZXMsIHRoaXMgcGF0Y2ggc2VlbXMgd3Jv
bmcuIElmIGRldiBpcyByb290IHBvcnQsIGJ1cyBzaG91bGQgYmUgcm9vdCBidXMsIHNvIHdlDQo+
IHNob3VsZG4ndCBzZXQgcm9vdF9idXMtPnNlbGYgPSBwY2lfZGV2X29mX3Jvb3RfcG9ydC4NCj4g
DQpXaHkgdGhlIHJvb3QgYnVzLT5zZWxmIHBvaW50ZXIgdG8gdGhlIGJyaWRnZT8NCklmIGNoaWxk
IGJ1cyBjcmVhdGUgZnJvbSByb290IGJ1cywgdGhlIGNoaWxkLT5zZWxmIHdpbGwgZ2V0IHRoZSBi
cmlkZ2Uocm9vdCBwb3J0KSBwY2kgZGV2aWNlLg0KDQo+IEFjdHVhbGx5IFBDSSBjb3JlIGhhcyBj
b3JyZWN0bHkgc2V0dXAgcGNpX2J1cy0+c2VsZiBmb3Igc2Vjb25kYXJ5IGJ1cyBvZiBQQ0llDQo+
IHJvb3QgcG9ydC4NClllcywgcmlnaHQuIEJ1dCB0aGUgcm9vdC1idXMtPnNlbGYgaXMgTlVMTC4g
SSB0aGluayB0aGUgcm9vdCBidXMgc2hvdWxkIGdldCByb290IHBvcnQNCnBjaSBkZXZpY2UgZm9y
IGl0c2VsZi4gSWYgdGhlcmUgaXMgbm8gYnJpZGdlIGF0IGJvYXJkIGhvdyB0byBnZXQgdGhlIHJv
b3QgcG9ydCBkZXZpY2U/DQoNCi1Eb25nc2hlbmcNCg0KPiANCj4gVGhhbmtzIQ0KPiBHZXJyeQ0K
PiANCg0K
