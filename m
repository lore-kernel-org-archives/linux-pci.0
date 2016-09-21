Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: zhichang <zhichang.yuan02@gmail.com>
Subject: Re: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
Date: Wed, 21 Sep 2016 21:29:22 +0200
Message-ID: <4518414.hTLWuvFlBl@wuerfel>
In-Reply-To: <815bebc1-96c9-2131-930d-bccdd4bf1c55@gmail.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5525856.MfDSSsiP5d@wuerfel> <815bebc1-96c9-2131-930d-bccdd4bf1c55@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, john.garry@huawei.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 linuxarm@huawei.com, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 benh@kernel.crashing.org, zourongrong@gmail.com, liviu.dudau@arm.com,
 kantyzc@163.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMTYgNjoxMjoyOCBQTSBDRVNUIHpoaWNoYW5n
IHdyb3RlOgo+IE9uIDIwMTblubQwOeaciDE15pelIDA1OjMzLCBBcm5kIEJlcmdtYW5uIHdyb3Rl
Ogo+ID4gT24gV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMTYgMTE6MDQ6MzMgUE0gQ0VTVCB6
aGljaGFuZy55dWFuIHdyb3RlOgo+ID4+IFRoZSA4MjUwX2hpc2lfbHBjLmMgc3VwcG9ydCBib3Ro
IEFDUEkgYW5kIGR0cyBzaW1pbGFyIHRvIDgyNTBfZHcgOgo+ID4+Cj4gPj4gK3N0YXRpYyBzdHJ1
Y3QgcGxhdGZvcm1fZHJpdmVyIGhzX2xwYzgyNTBfZHJpdmVyID0gewo+ID4+ICsgICAgICAgLmRy
aXZlciA9IHsKPiA+PiArICAgICAgICAgICAgICAgLm5hbWUgICAgICAgICAgID0gImhpc2ktbHBj
LXVhcnQiLAo+ID4+ICsgICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBoczgyNTBfb2Zf
bWF0Y2gsCj4gPj4gKyAgICAgICAgICAgICAgIC5hY3BpX21hdGNoX3RhYmxlID0gQUNQSV9QVFIo
aHM4MjUwX2FjcGlfbWF0Y2gpLAo+ID4+Cj4gPj4gU28sIEkgYW0gYSBsaXR0bGUgY29uZnVzZWQg
d2h5IHdlIG5lZWQgdG8gc3VwcG9ydCBkdHMgaW4gODI1MF9vZi5jIGFuZCBzdXBwb3J0IEFDUEkg
aW4gYW5vdGhlcgo+ID4+IGRyaXZlciBmaWxlLgo+ID4+Cj4gPiAKPiA+IEFmdGVyIGxvb2tpbmcg
YWdhaW4sIEknbSBwcmV0dHkgc3VyZSB0aGF0IGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBf
cG5wLmMKPiA+IHdpbGwgaGFuZGxlIHRoZSBBQ1BJIGNhc2Ugd2l0aG91dCBtb2RpZmljYXRpb25z
LCB5b3UganVzdCBuZWVkIHRvIGFkYXB0Cj4gPiB0aGUgODI1MF9vZiBkcml2ZXIgdG8gaGFuZGxl
IElPUkVTT1VSQ0VfSU8gcG9ydHMuIFRoaXMgd2lsbCBiZSByZXF1aXJlZAo+ID4gYW55d2F5IHdp
dGggdGhlIG5leHQgdmVyc2lvbiBvbmNlIHRoZSBMUEMgYnJpZGdlIGlzIG9uIHRoZSBQQ0kgYnVz
Lgo+ID4gCj4gCj4gWWVzLiBZb3UgYXJlIHJpZ2h0Lgo+IAo+IFdoZW4gdGhlIGluZGlyZWN0SU8g
cGF0Y2ggaXMgYWNjZXB0ZWQsIG5vIG11Y2ggY2hhbmdlcyBuZWVkZWQgaW4gdGhlc2UgdHdvIGZp
bGUgdG8gc3VwcG9ydCBMUEMgVUFSVC4KPiAKPiBCVFcsIHdoYXQgaXMgeW91ciB0YXJnZXQgdG8g
Y2hhbmdlIHRoZXNlIHR3byBmaWxlcyB0byBzdXBwb3J0IExQQyB1YXJ0Pwo+IERvIHlvdSB0aGlu
ayB3ZSBkb24ndCBuZWVkIHRvIGFkZCBtYW55IG5ldyBjIGZpbGVzPz8KCkkgdGhpbmsgYnkgbW9k
aWZ5aW5nIDgyNTBfb2YuYywgeW91IHNob3VsZCBiZSBhYmxlIHRvIG1ha2UgYW55IFVBUlQgb24K
c29tZSBMUEMgYnVzIHdvcmssIHJlZ2FyZGxlc3Mgb2Ygd2hhdCBjb250cm9sbGVyIGlzIHVzZWQu
CgpUaGUgQUNQSSB2ZXJzaW9uICg4MjUwX3BucC5jKSBzaG91bGRuJ3QgbmVlZCBhbnkgY2hhbmdl
cyBhdCBhbGwgaWYgSQpyZWFkIHRoYXQgY29ycmVjdGx5LgoKCUFybmQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
