Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v9 0/4] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
To: David Miller <davem@davemloft.net>, <bhelgaas@google.com>,
 <helgaas@kernel.org>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <20170806.204744.1934067595236180060.davem@davemloft.net>
From: Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <588b378c-249a-36b0-8890-769258fbb708@huawei.com>
Date: Mon, 7 Aug 2017 12:13:17 +0800
MIME-Version: 1.0
In-Reply-To: <20170806.204744.1934067595236180060.davem@davemloft.net>
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
 linux-pci@vger.kernel.org, ganeshgr@chelsio.com, Bob.Shaw@amd.com,
 leedom@chelsio.com, patrick.j.cramer@intel.com, werner@chelsio.com,
 linux-arm-kernel@lists.infradead.org, amira@mellanox.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David.Laight@aculab.com,
 Suravee.Suthikulpanit@amd.com, robin.murphy@arm.com, l.stach@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

CgpPbiAyMDE3LzgvNyAxMTo0NywgRGF2aWQgTWlsbGVyIHdyb3RlOgo+IEZyb206IERpbmcgVGlh
bmhvbmcgPGRpbmd0aWFuaG9uZ0BodWF3ZWkuY29tPgo+IERhdGU6IFNhdCwgNSBBdWcgMjAxNyAx
NToxNTowOSArMDgwMAo+IAo+PiBTb21lIGRldmljZXMgaGF2ZSBwcm9ibGVtcyB3aXRoIFRyYW5z
YWN0aW9uIExheWVyIFBhY2tldHMgd2l0aCB0aGUgUmVsYXhlZAo+PiBPcmRlcmluZyBBdHRyaWJ1
dGUgc2V0LiAgVGhpcyBwYXRjaCBzZXQgYWRkcyBhIG5ldyBQQ0llIERldmljZSBGbGFnLAo+PiBQ
Q0lfREVWX0ZMQUdTX05PX1JFTEFYRURfT1JERVJJTkcsIGEgc2V0IG9mIFBDSSBRdWlya3MgdG8g
Y2F0Y2ggc29tZSBrbm93bgo+PiBkZXZpY2VzIHdpdGggUmVsYXhlZCBPcmRlcmluZyBpc3N1ZXMs
IGFuZCBhIHVzZSBvZiB0aGlzIG5ldyBmbGFnIGJ5IHRoZQo+PiBjeGdiNCBkcml2ZXIgdG8gYXZv
aWQgdXNpbmcgUmVsYXhlZCBPcmRlcmluZyB3aXRoIHByb2JsZW1hdGljIFJvb3QgQ29tcGxleAo+
PiBQb3J0cy4KPj4KPj4gSXQncyBiZWVuIHllYXJzIHNpbmNlIEkndmUgc3VibWl0dGVkIGtlcm5l
bC5vcmcgcGF0Y2hlcywgSSBhcHBvbGdpc2UgZm9yIHRoZQo+PiBhbG1vc3QgY2VydGFpbiBzdWJt
aXNzaW9uIGVycm9ycy4KPiAKPiBXaGljaCB0cmVlIHNob3VsZCBtZXJnZSB0aGlzPyAgVGhlIFBD
SSB0cmVlIG9yIG15IG5ldHdvcmtpbmcgdHJlZT8KPiAKCkhpIERhdmlk77yaCgpJIHRoaW5rIG5l
dHdvcmtpbmcgdHJlZSBtZXJnZSBpdCBpcyBhIGJldHRlciBjaG9pY2UsIGFzIGl0IG1haW5seSB1
c2VkIHRvIHRlbGwgdGhlIE5JQwpkcml2ZXJzIGhvdyB0byB1c2UgdGhlIFJlbGF4ZWQgT3JkZXJp
bmcgQXR0cmlidXRlLCBhbmQgbGF0ZXIgd2UgbmVlZCBzZW5kIHBhdGNoIHRvIGVuYWJsZQpSTyBm
b3IgaXhnYmUgZHJpdmVyIGJhc2Ugb24gdGhpcyBwYXRjaC4gQnV0IEkgYW0gbm90IHN1cmUgd2hl
dGhlciBCam9ybiBoYXMgc29tZSBvZiBoaXMgb3duCnZpZXcuIDopCgpIaSBCam9ybjoKCkNvdWxk
IHlvdSBoZWxwIHJldmlldyB0aGlzIHBhdGNoIG9yIGdpdmUgc29tZSBmZWVkYmFjayA/CgpUaGFu
a3MKRGluZwo+IC4KPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
