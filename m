Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
 <20170516140943.ps2yufiukz6iurpl@latitude>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <f5f8de4a-73a1-a32f-2736-2a7e64bfaa1a@codeaurora.org>
Date: Wed, 17 May 2017 10:47:30 +0530
MIME-Version: 1.0
In-Reply-To: <20170516140943.ps2yufiukz6iurpl@latitude>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 frowand.list@gmail.com, m.szyprowski@samsung.com, linux-arch@vger.kernel.org,
 lorenzo.pieralisi@arm.com, tn@semihalf.com, joro@8bytes.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-arm-msm@vger.kernel.org,
 robh+dt@kernel.org, bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com,
 robin.murphy@arm.com
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGksCgpPbiA1LzE2LzIwMTcgNzozOSBQTSwgSm9uYXRoYW4gTmV1c2Now6RmZXIgd3JvdGU6Cj4g
SGksIEkgaGF2ZSBhIGZldyBzdWdnZXN0aW9ucyBvbiBob3cgdG8gbWFrZSB0aGlzIGNvbW1pdCBt
ZXNzYWdlIG1vcmUKPiByZWFkYWJsZToKPiAKPiBPbiBUdWUsIE1heSAxNiwgMjAxNyBhdCAxMDo1
NDoxM0FNICswNTMwLCBTcmljaGFyYW4gUiB3cm90ZToKPj4gV2hpbGUgcmV0dXJuaW5nIEVQUk9C
RV9ERUZFUiBmb3IgaW9tbXUgbWFzdGVycwo+IAo+IEFkZCBhIGNvbW1hIGF0IHRoZSBlbmQgb2Yg
dGhpcyBsaW5lCj4gCj4+IHRha2UgaW4gdG8gYWNjb3VudCBvZiBpb21tdSBub2RlcyB0aGF0IGNv
dWxkIGJlCj4gCj4gcy9pbiB0by9pbnRvLwo+IHMvb2YgaW9tbXUvb2ZfaW9tbXUvCj4gCgpvaywg
d2lsbCBjb3JyZWN0IHRoZSBhYm92ZS4KClJlZ2FyZHMsCiBTcmljaGFyYW4KCj4+IG1hcmtlZCBp
biBEVCBhcyAnc3RhdHVzPWRpc2FibGVkJywgaW4gd2hpY2ggY2FzZQo+PiBzaW1wbHkgcmV0dXJu
IE5VTEwgYW5kIGxldCB0aGUgbWFzdGVyJ3MgcHJvYmUKPj4gY29udGludWUgcmF0aGVyIHRoYW4g
ZGVmZXJyaW5nLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTcmljaGFyYW4gUiA8c3JpY2hhcmFuQGNv
ZGVhdXJvcmEub3JnPgo+PiBUZXN0ZWQtYnk6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0u
Y29tPgo+PiBBY2tlZC1ieTogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+Cj4gCj4g
Cj4gVGhhbmtzLAo+IEpvbmF0aGFuIE5ldXNjaMOkZmVyCj4gCgotLSAKIlFVQUxDT01NIElORElB
LCBvbiBiZWhhbGYgb2YgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1i
ZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlvbgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
