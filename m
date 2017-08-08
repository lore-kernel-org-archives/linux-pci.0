Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 7 Aug 2017 20:56:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v9 0/4] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
Message-ID: <20170808015602.GH16580@bhelgaas-glaptop.roam.corp.google.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <20170806.204744.1934067595236180060.davem@davemloft.net>
 <588b378c-249a-36b0-8890-769258fbb708@huawei.com>
 <20170807.141448.1388035794329323595.davem@davemloft.net>
MIME-Version: 1.0
In-Reply-To: <20170807.141448.1388035794329323595.davem@davemloft.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, gabriele.paoloni@huawei.com, asit.k.mallick@intel.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linuxarm@huawei.com,
 alexander.duyck@gmail.com, ashok.raj@intel.com, jeffrey.t.kirsher@intel.com,
 dingtianhong@huawei.com, ganeshgr@chelsio.com, Bob.Shaw@amd.com,
 leedom@chelsio.com, patrick.j.cramer@intel.com, bhelgaas@google.com,
 werner@chelsio.com, linux-arm-kernel@lists.infradead.org, amira@mellanox.com,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, David.Laight@aculab.com,
 Suravee.Suthikulpanit@amd.com, robin.murphy@arm.com, l.stach@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gTW9uLCBBdWcgMDcsIDIwMTcgYXQgMDI6MTQ6NDhQTSAtMDcwMCwgRGF2aWQgTWlsbGVyIHdy
b3RlOgo+IEZyb206IERpbmcgVGlhbmhvbmcgPGRpbmd0aWFuaG9uZ0BodWF3ZWkuY29tPgo+IERh
dGU6IE1vbiwgNyBBdWcgMjAxNyAxMjoxMzoxNyArMDgwMAo+IAo+ID4gSGkgRGF2aWTvvJoKPiA+
IAo+ID4gSSB0aGluayBuZXR3b3JraW5nIHRyZWUgbWVyZ2UgaXQgaXMgYSBiZXR0ZXIgY2hvaWNl
LCBhcyBpdCBtYWlubHkgdXNlZCB0byB0ZWxsIHRoZSBOSUMKPiA+IGRyaXZlcnMgaG93IHRvIHVz
ZSB0aGUgUmVsYXhlZCBPcmRlcmluZyBBdHRyaWJ1dGUsIGFuZCBsYXRlciB3ZSBuZWVkIHNlbmQg
cGF0Y2ggdG8gZW5hYmxlCj4gPiBSTyBmb3IgaXhnYmUgZHJpdmVyIGJhc2Ugb24gdGhpcyBwYXRj
aC4gQnV0IEkgYW0gbm90IHN1cmUgd2hldGhlciBCam9ybiBoYXMgc29tZSBvZiBoaXMgb3duCj4g
PiB2aWV3LiA6KQo+ID4gCj4gPiBIaSBCam9ybjoKPiA+IAo+ID4gQ291bGQgeW91IGhlbHAgcmV2
aWV3IHRoaXMgcGF0Y2ggb3IgZ2l2ZSBzb21lIGZlZWRiYWNrID8KPiAKPiBJJ20gc3RpbGwgd2Fp
dGluZyBvbiB0aGlzLi4uCj4gCj4gQmpvcm4/CgpJIHdhcyBvbiB2YWNhdGlvbiBGcmlkYXktdG9k
YXksIGJ1dCBJJ2xsIGxvb2sgYXQgdGhpcyBzZXJpZXMgdGhpcyB3ZWVrLgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
