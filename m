Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1478646779.7430.66.camel@kernel.crashing.org>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Rutland <mark.rutland@arm.com>, "zhichang.yuan"
 <yuanzhichang@hisilicon.com>
Date: Wed, 09 Nov 2016 10:12:59 +1100
In-Reply-To: <20161108114953.GB15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linuxarm@huawei.com, lorenzo.pieralisi@arm.com, arnd@arndb.de,
 xuwei5@hisilicon.com, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, minyard@acm.org, marc.zyngier@arm.com,
 liviu.dudau@arm.com, john.garry@huawei.com, zourongrong@gmail.com,
 robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com,
 zhichang.yuan02@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, olof@lixom.net
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gVHVlLCAyMDE2LTExLTA4IGF0IDExOjQ5ICswMDAwLCBNYXJrIFJ1dGxhbmQgd3JvdGU6Cj4g
Cj4gTXkgdW5kZXJzdGFuZGluZyBvZiBJU0EgKHdoaWNoIG1heSBiZSBmbGF3ZWQpIGlzIHRoYXQg
aXQncyBub3QgcGFydCBvZgo+IHRoZSBQQ0kgaG9zdCBicmlkZ2UsIGJ1dCByYXRoZXIgb24geDg2
IGl0IGhhcHBlbnMgdG8gc2hhcmUgdGhlIElPIHNwYWNlCj4gd2l0aCBQQ0kuCgpTb3J0LW9mLiBP
biBzb21lIHN5c3RlbXMgaXQgYWN0dWFsbHkgZ29lcyB0aHJvdWdoIFBDSSBhbmQgdGhlcmUncyBh
ClBDSS0+SVNBIGJyaWRnZSB0aGF0IHVzZXMgc3Vic3RyYWN0aXZlIGRlY29kaW5nIHRvIHRoZSBs
ZWdhY3kgZGV2aWNlcy4KCj4gU28sIGhvdyBhYm91dCB0aGlzIGJlY29tZXM6Cj4gCj4gwqAgSGlz
aWxpY29uIEhpcDA2IFNvQ3MgaW1wbGVtZW50IGEgTG93IFBpbiBDb3VudCAoTFBDKSBjb250cm9s
bGVyLCB3aGljaAo+IMKgIHByb3ZpZGVzIGFjY2VzcyB0byBzb21lIGxlZ2FjeSBJU0EgZGV2aWNl
cy4KPiAKPiBJIGJlbGlldmUgdGhhdCB3ZSBjb3VsZCB0aGVvcmV0aWNhbGx5IGhhdmUgbXVsdGlw
bGUgaW5kZXBlbmRlbnQgTFBDL0lTQQo+IGJ1c3NlcywgYXMgaXMgcG9zc2libGUgd2l0aCBQQ0kg
b24gIXg4NiBzeXN0ZW1zLiBJZiB0aGUgY3VycmVudCBJU0EgY29kZQo+IGFzc3VtZXMgYSBzaW5n
bGV0b24gYnVzLCBJIHRoaW5rIHRoYXQncyBzb21ldGhpbmcgdGhhdCBuZWVkcyB0byBiZSBmaXhl
ZAo+IHVwIG1vcmUgZ2VuZXJpY2FsbHkuCj4gCj4gSSBkb24ndCBzZWUgd2h5IHdlIHNob3VsZCBu
ZWVkIGFueSBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgY29kZSBoZXJlLiBXaHkKPiBjYW4gd2Ugbm90
IGZpeCB1cCB0aGUgSVNBIGJ1cyBjb2RlIGluIGRyaXZlcnMvb2YvYWRkcmVzcy5jIHN1Y2ggdGhh
dCBpdAo+IGhhbmRsZXMgbXVsdGlwbGUgSVNBIGJ1cyBpbnN0YW5jZXMsIGFuZCB0cmFuc2xhdGVz
IGFsbCBzdWItZGV2aWNlCj4gYWRkcmVzc2VzIHJlbGF0aXZlIHRvIHRoZSBzcGVjaWZpYyBidXMg
aW5zdGFuY2U/CgpXaGF0IGluIHRoYXQgY29kZSBwcmV2ZW50cyB0aGF0IHRvZGF5ID8KCkNoZWVy
cywKQmVuLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
