Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC] PCI: dwc: designware: allow customize unroll registers'
 readl/writel
To: Jisheng Zhang <jszhang@marvell.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20170713184837.541ccf26@xhacker> <20170713185213.0b04a4fc@xhacker>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <825636e2-f685-738e-46d9-bbc483e95606@synopsys.com>
Date: Mon, 17 Jul 2017 09:59:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170713185213.0b04a4fc@xhacker>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGkgSmlzaGVuZywKCsOAcyAxMTo1MiBBTSBkZSA3LzEzLzIwMTcsIEppc2hlbmcgWmhhbmcgZXNj
cmV2ZXU6Cj4gT24gVGh1LCAxMyBKdWwgMjAxNyAxODo0ODozNyArMDgwMCBKaXNoZW5nIFpoYW5n
IHdyb3RlOgo+IAo+PiBIaSBKb2FvLCBKaW5nb28sCj4+Cj4+IE5vdywgdGhlIFBDSUVfR0VUX0FU
VV9PVVRCX1VOUl9SRUdfT0ZGU0VUIG1hY3JvIGlzIGRlZmluZWQgYXM6Cj4+Cj4+IC8qIFJlZ2lz
dGVyIGFkZHJlc3MgYnVpbGRlciAqLwo+PiAjZGVmaW5lIFBDSUVfR0VUX0FUVV9PVVRCX1VOUl9S
RUdfT0ZGU0VUKHJlZ2lvbikgICAgICAgIFwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgKCgw
eDMgPDwgMjApIHwgKChyZWdpb24pIDw8IDkpKQo+Pgo+PiBJIGhhdmUgb25lIHF1ZXN0aW9uOiB3
aGVyZSBkb2VzIHRoZSAoMHgzIDw8IDIwKSBjb21lIGZyb20/IDJNQiBzcGFjZSwgYSBiaXQKCkZy
b20sIHRoZSBQQ0llIENvcmUgNC44MCB5b3UgaGF2ZSB0aGUgbmV3IGZlYXR1cmUgVW5yb2xsLCB3
aGljaCB3YXMgZGV2ZWxvcGVkCmZvciBib3RoIGlBVFUgYW5kIERNQS4KVG8gaW5mb3JtIHRoZSBD
b3JlIHRoYXQgeW91IHdhbnQgdG8gYWNjZXNzIGFuIFVucm9sbCByZWdpc3RlciBhZGRyZXNzLCBi
aXRzIDIwCmFuZCAyMSBtdXN0IGJlIHNldCwgYW5kIHRoYXRzIHdoZXJlIDB4MyBjb21lcyBmcm9t
LgoKSWYgaXQgaXMgbm90IGNsZWFyIHBsZWFzZSBsZXQgbWUga25vdy4KCj4gCj4gc29ycnksIHR5
cG8uICgweDMgPDwgMjApIHNob3VsZCBiZSAzTUIuCj4gCj4+IGxhcmdlLiBBbmQgSSBkaWRuJ3Qg
ZmluZCBpdCBpbiB0aGUgZGF0YWJvb2suIElzIGl0IHBsYXRmb3JtIHNwZWNpZmljPwo+PiBJZiB5
ZXMsIEkgd2FudCB0byBjb29rIG9uZSBwYXRjaCB0byBjdXN0b21pemUgdW5yb2xsIHJlZ2lzdGVy
cycgcmVhZGwvd3JpdGVsLgo+Pgo+PiBBbmQgaG93IGRvZXMgKDB4MyA8PCAyMCkgZW5hYmxlIERC
STIgYWNjZXNzPwo+Pgo+PiBUaGFua3MgaW4gYWR2YW5jZSwKPj4gSmlzaGVuZwo+IAoKVGhhbmtz
LApKb2FvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
