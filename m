Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH -next] PCI: rockchip: Add missing of_node_put() in
 rockchip_pcie_init_irq_domain()
To: Wei Yongjun <weiyj.lk@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Wenrui Li <wenrui.li@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <87c39739-c9d0-b307-5256-591ef7324ffa@rock-chips.com>
Date: Tue, 18 Oct 2016 08:50:28 +0800
MIME-Version: 1.0
In-Reply-To: <1476716242-31684-1-git-send-email-weiyj.lk@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

5ZyoIDIwMTYvMTAvMTcgMjI6NTcsIFdlaSBZb25nanVuIOWGmemBkzoKPiBGcm9tOiBXZWkgWW9u
Z2p1biA8d2VpeW9uZ2p1bjFAaHVhd2VpLmNvbT4KPgo+IFRoaXMgbm9kZSBwb2ludGVyIGlzIHJl
dHVybmVkIGJ5IG9mX2dldF9uZXh0X2NoaWxkKCkgd2l0aCByZWZjb3VudAo+IGluY3JlbWVudGVk
IGluIHRoaXMgZnVuY3Rpb24uIG9mX25vZGVfcHV0KCkgb24gaXQgYmVmb3JlIGV4aXR0aW5nCj4g
dGhpcyBmdW5jdGlvbiBvbiBlcnJvci4KPgo+IFRoaXMgaXMgZGV0ZWN0ZWQgYnkgQ29jY2luZWxs
ZSBzZW1hbnRpYyBwYXRjaC4KClRoYW5rcyBmb3IgZml4aW5nIHRoaXMuCgpBY2tlZC1ieTogU2hh
d24gTGluIDxzaGF3bi5saW5Acm9jay1jaGlwcy5jb20+Cgo+Cj4gU2lnbmVkLW9mZi1ieTogV2Vp
IFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvcGNpL2hv
c3QvcGNpZS1yb2NrY2hpcC5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpZS1yb2NrY2hpcC5jIGIvZHJp
dmVycy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmMKPiBpbmRleCBlMGIyMmRhLi5hYjg4ODU5IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpZS1yb2NrY2hpcC5jCj4gKysrIGIvZHJp
dmVycy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmMKPiBAQCAtOTQ5LDYgKzk0OSw3IEBAIHN0YXRp
YyBpbnQgcm9ja2NoaXBfcGNpZV9pbml0X2lycV9kb21haW4oc3RydWN0IHJvY2tjaGlwX3BjaWUg
KnJvY2tjaGlwKQo+ICAJCQkJCQkgICAgJmludHhfZG9tYWluX29wcywgcm9ja2NoaXApOwo+ICAJ
aWYgKCFyb2NrY2hpcC0+aXJxX2RvbWFpbikgewo+ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRv
IGdldCBhIElOVHggSVJRIGRvbWFpblxuIik7Cj4gKwkJb2Zfbm9kZV9wdXQoaW50Yyk7Cj4gIAkJ
cmV0dXJuIC1FSU5WQUw7Cj4gIAl9Cj4KPiAtLQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBs
aXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1wY2kiIGluCj4gdGhlIGJvZHkg
b2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcKPiBNb3JlIG1ham9yZG9t
byBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwKPgoK
Ci0tIApCZXN0IFJlZ2FyZHMKU2hhd24gTGluCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
