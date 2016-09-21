Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <4340181.AghlmQIy28@wuerfel> <57D96701.4050700@hisilicon.com>
 <5525856.MfDSSsiP5d@wuerfel>
From: zhichang <zhichang.yuan02@gmail.com>
Message-ID: <815bebc1-96c9-2131-930d-bccdd4bf1c55@gmail.com>
Date: Wed, 21 Sep 2016 18:12:28 +0800
MIME-Version: 1.0
In-Reply-To: <5525856.MfDSSsiP5d@wuerfel>
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
 kantyzc@163.com
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

CgpPbiAyMDE25bm0MDnmnIgxNeaXpSAwNTozMywgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBX
ZWRuZXNkYXksIFNlcHRlbWJlciAxNCwgMjAxNiAxMTowNDozMyBQTSBDRVNUIHpoaWNoYW5nLnl1
YW4gd3JvdGU6Cj4+IFRoZSA4MjUwX2hpc2lfbHBjLmMgc3VwcG9ydCBib3RoIEFDUEkgYW5kIGR0
cyBzaW1pbGFyIHRvIDgyNTBfZHcgOgo+Pgo+PiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgaHNfbHBjODI1MF9kcml2ZXIgPSB7Cj4+ICsgICAgICAgLmRyaXZlciA9IHsKPj4gKyAgICAg
ICAgICAgICAgIC5uYW1lICAgICAgICAgICA9ICJoaXNpLWxwYy11YXJ0IiwKPj4gKyAgICAgICAg
ICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IGhzODI1MF9vZl9tYXRjaCwKPj4gKyAgICAgICAgICAg
ICAgIC5hY3BpX21hdGNoX3RhYmxlID0gQUNQSV9QVFIoaHM4MjUwX2FjcGlfbWF0Y2gpLAo+Pgo+
PiBTbywgSSBhbSBhIGxpdHRsZSBjb25mdXNlZCB3aHkgd2UgbmVlZCB0byBzdXBwb3J0IGR0cyBp
biA4MjUwX29mLmMgYW5kIHN1cHBvcnQgQUNQSSBpbiBhbm90aGVyCj4+IGRyaXZlciBmaWxlLgo+
Pgo+IAo+IEFmdGVyIGxvb2tpbmcgYWdhaW4sIEknbSBwcmV0dHkgc3VyZSB0aGF0IGRyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfcG5wLmMKPiB3aWxsIGhhbmRsZSB0aGUgQUNQSSBjYXNlIHdp
dGhvdXQgbW9kaWZpY2F0aW9ucywgeW91IGp1c3QgbmVlZCB0byBhZGFwdAo+IHRoZSA4MjUwX29m
IGRyaXZlciB0byBoYW5kbGUgSU9SRVNPVVJDRV9JTyBwb3J0cy4gVGhpcyB3aWxsIGJlIHJlcXVp
cmVkCj4gYW55d2F5IHdpdGggdGhlIG5leHQgdmVyc2lvbiBvbmNlIHRoZSBMUEMgYnJpZGdlIGlz
IG9uIHRoZSBQQ0kgYnVzLgo+IAoKWWVzLiBZb3UgYXJlIHJpZ2h0LgoKV2hlbiB0aGUgaW5kaXJl
Y3RJTyBwYXRjaCBpcyBhY2NlcHRlZCwgbm8gbXVjaCBjaGFuZ2VzIG5lZWRlZCBpbiB0aGVzZSB0
d28gZmlsZSB0byBzdXBwb3J0IExQQyBVQVJULgoKQlRXLCB3aGF0IGlzIHlvdXIgdGFyZ2V0IHRv
IGNoYW5nZSB0aGVzZSB0d28gZmlsZXMgdG8gc3VwcG9ydCBMUEMgdWFydD8KRG8geW91IHRoaW5r
IHdlIGRvbid0IG5lZWQgdG8gYWRkIG1hbnkgbmV3IGMgZmlsZXM/PwoKQmVzdCwKWmhpY2hhbmcK
CgoKPiAJQXJuZAo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
