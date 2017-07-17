Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: dwc: designware: test PCIE_ATU_ENABLE bit to check
 enabled or not
To: Jisheng Zhang <jszhang@marvell.com>, <jingoohan1@gmail.com>,
 <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>
References: <20170713103527.1642-1-jszhang@marvell.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <1df044ef-1daf-0b60-da30-a6a45215f275@synopsys.com>
Date: Mon, 17 Jul 2017 10:27:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170713103527.1642-1-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

SGksCgrDgHMgMTE6MzUgQU0gZGUgNy8xMy8yMDE3LCBKaXNoZW5nIFpoYW5nIGVzY3JldmV1Ogo+
IFRoZSBBVFUgQ1RSTDIgcmVnaXN0ZXIgaXMgMzIgYml0LCBiZXNpZGVzIHRoZSBlbmFibGUgYml0
LCBvdGhlciBiaXRzCj4gbWF5IGFsc28gYmUgc2V0LiBUbyBjaGVjayB3aGV0aGVyIHRoZSBBVFUg
aXMgZW5hYmxlZCBvciBub3QsIHdlIHNob3VsZAo+IHRlc3QgdGhlIGVuYWJsZSBpdC4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBKaXNoZW5nIFpoYW5nIDxqc3poYW5nQG1hcnZlbGwuY29tPgo+IC0tLQo+
ICBkcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNpZ253YXJlLmMgfCAyICstCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9kd2MvcGNpZS1kZXNpZ253YXJlLmMgYi9kcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNp
Z253YXJlLmMKPiBpbmRleCAwZTAzYWYyNzkyNTkuLjZiZjBiNDA5MDUwYSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3BjaS9kd2MvcGNpZS1kZXNpZ253YXJlLmMKPiArKysgYi9kcml2ZXJzL3BjaS9k
d2MvcGNpZS1kZXNpZ253YXJlLmMKPiBAQCAtMTc3LDcgKzE3Nyw3IEBAIHZvaWQgZHdfcGNpZV9w
cm9nX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNpLCBpbnQgaW5kZXgsIGludCB0eXBl
LAo+ICAJICovCj4gIAlmb3IgKHJldHJpZXMgPSAwOyByZXRyaWVzIDwgTElOS19XQUlUX01BWF9J
QVRVX1JFVFJJRVM7IHJldHJpZXMrKykgewo+ICAJCXZhbCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBj
aSwgUENJRV9BVFVfQ1IyKTsKPiAtCQlpZiAodmFsID09IFBDSUVfQVRVX0VOQUJMRSkKPiArCQlp
ZiAodmFsICYgUENJRV9BVFVfRU5BQkxFKQo+ICAJCQlyZXR1cm47Cj4gIAo+ICAJCXVzbGVlcF9y
YW5nZShMSU5LX1dBSVRfSUFUVV9NSU4sIExJTktfV0FJVF9JQVRVX01BWCk7Cj4gCk1ha2Ugc2Vu
c2UsIHR1cm4gaXQgbW9yZSBhY2N1cmF0ZS4gVGhhbmtzIQoKQWNrZWQtYnk6IEpvYW8gUGludG8g
PGpwaW50b0BzeW5vcHN5cy5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
