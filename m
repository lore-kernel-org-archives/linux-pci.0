Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: rockchip: fix uninitialized variable use
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
References: <20160922094018.2138640-1-arnd@arndb.de>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <440300d4-1d96-4f38-870b-c026b8fb5b2c@rock-chips.com>
Date: Fri, 23 Sep 2016 08:15:05 +0800
MIME-Version: 1.0
In-Reply-To: <20160922094018.2138640-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="gbk"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGkgQXJuZCwKCtTaIDIwMTYvOS8yMiAxNzozOSwgQXJuZCBCZXJnbWFubiDQtLXAOgo+IFRoZSBu
ZXdseSBhZGRlZCBwY2llLXJvY2tjaGlwIGRyaXZlciBmYWlscyB0byBpbml0aWFsaXplIHRoZQo+
IGlvX3NpemUgdmFyaWFibGUgaWYgdGhlIERUIGRvZXNuJ3QgcHJvdmlkZSByYW5nZXMgZm9yIHRo
ZSBQQ0kKPiBJL08gc3BhY2UsIGFzIGZvdW5kIGJ5IGJ1aWxkaW5nIGl0IHdpdGggLVdtYXliZS11
bmluaXRpYWxpemVkOgo+Cj4gZHJpdmVycy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmM6IEluIGZ1
bmN0aW9uICdyb2NrY2hpcF9wY2llX3Byb2JlJzoKPiBkcml2ZXJzL3BjaS9ob3N0L3BjaWUtcm9j
a2NoaXAuYzoxMDA3OjY6IHdhcm5pbmc6ICdpb19zaXplJyBtYXkgYmUgdXNlZCB1bmluaXRpYWxp
emVkIGluIHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0aWFsaXplZF0KPgoKU2VlbXMgbGlr
ZSB3ZSBtaXNzIHRoaXMgd2hlbiByZWZhY3RvcmluZyB0aGUgY29kZSBhIGJpdC4KVGhhbmtzIGZv
ciBmaXhpbmcgaXQuCgpBY2tlZC1ieTogU2hhd24gTGluIDxzaGF3bi5saW5Acm9jay1jaGlwcy5j
b20+Cgo+IFRoaXMgYWRkcyBhbiBhcHByb3ByaWF0ZSBpbml0aWFsaXphdGlvbiBpbW1lZGlhdGVs
eSBpbiBmcm9udCBvZgo+IHRoZSBsb29wLCBzbyB0aGUgaW9fc2l6ZSBpcyB6ZXJvIGFzIGV4cGVj
dGVkIGFmdGVyd2FyZHMgZm9yIHRoYXQKPiBjYXNlLgo+Cj4gRml4ZXM6IGFiZTE3MTgxYjE2ZiAo
IlBDSTogcm9ja2NoaXA6IEFkZCBSb2NrY2hpcCBQQ0llIGNvbnRyb2xsZXIgc3VwcG9ydCIpCj4g
U2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiAtLS0KPiAgZHJp
dmVycy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmMgfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvaG9zdC9wY2llLXJvY2tj
aGlwLmMgYi9kcml2ZXJzL3BjaS9ob3N0L3BjaWUtcm9ja2NoaXAuYwo+IGluZGV4IGMzNTkzZTYz
M2NjZC4uOGJlZGMxZTFlZjgwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2hvc3QvcGNpZS1y
b2NrY2hpcC5jCj4gKysrIGIvZHJpdmVycy9wY2kvaG9zdC9wY2llLXJvY2tjaGlwLmMKPiBAQCAt
MTA3OCw2ICsxMDc4LDcgQEAgc3RhdGljIGludCByb2NrY2hpcF9wY2llX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAkJZ290byBlcnJfdnBjaWU7Cj4KPiAgCS8qIEdldCB0
aGUgSS9PIGFuZCBtZW1vcnkgcmFuZ2VzIGZyb20gRFQgKi8KPiArCWlvX3NpemUgPSAwOwo+ICAJ
cmVzb3VyY2VfbGlzdF9mb3JfZWFjaF9lbnRyeSh3aW4sICZyZXMpIHsKPiAgCQlzd2l0Y2ggKHJl
c291cmNlX3R5cGUod2luLT5yZXMpKSB7Cj4gIAkJY2FzZSBJT1JFU09VUkNFX0lPOgo+CgoKLS0g
CkJlc3QgUmVnYXJkcwpTaGF3biBMaW4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
