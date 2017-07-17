Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
 "'Jisheng Zhang'" <jszhang@marvell.com>, <bhelgaas@google.com>
References: <20170713103527.1642-1-jszhang@marvell.com>
 <1df044ef-1daf-0b60-da30-a6a45215f275@synopsys.com>
In-Reply-To: <1df044ef-1daf-0b60-da30-a6a45215f275@synopsys.com>
Subject: Re: [PATCH] PCI: dwc: designware: test PCIE_ATU_ENABLE bit to check
 enabled or not
Date: Mon, 17 Jul 2017 15:32:43 -0400
Message-ID: <000b01d2ff33$76d4fad0$647ef070$@gmail.com>
MIME-Version: 1.0
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

T24gTW9uZGF5LCBKdWx5IDE3LCAyMDE3IDU6MjggQU0sIEpvYW8gUGludG8gd3JvdGU6Cj4gCj4g
SGksCj4gCj4gw4BzIDExOjM1IEFNIGRlIDcvMTMvMjAxNywgSmlzaGVuZyBaaGFuZyBlc2NyZXZl
dToKPiA+IFRoZSBBVFUgQ1RSTDIgcmVnaXN0ZXIgaXMgMzIgYml0LCBiZXNpZGVzIHRoZSBlbmFi
bGUgYml0LCBvdGhlciBiaXRzCj4gPiBtYXkgYWxzbyBiZSBzZXQuIFRvIGNoZWNrIHdoZXRoZXIg
dGhlIEFUVSBpcyBlbmFibGVkIG9yIG5vdCwgd2Ugc2hvdWxkCj4gPiB0ZXN0IHRoZSBlbmFibGUg
aXQuCgpUbyBKaXNoZW5nIFpoYW5nLAoKdHlwbyBzL2l0L2JpdAoKInRlc3QgdGhlIGVuYWJsZSBp
dC4iICAtLS0+ICJ0ZXN0IHRoZSBlbmFibGUgYml0LiIKCgpQbGVhc2UgZml4IHRoaXMgdHlwbywg
YW5kIHNlbmQgaXQgYWdhaW4uClR5cGUgaXMgY29uZnVzaW5nLgoKCkJlc3QgcmVnYXJkcywKSmlu
Z29vIEhhbgoKCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0Bt
YXJ2ZWxsLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvcGNpL2R3Yy9wY2llLWRlc2lnbndhcmUu
YyB8IDIgKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZHdjL3BjaWUtZGVzaWdud2FyZS5j
IGIvZHJpdmVycy9wY2kvZHdjL3BjaWUtCj4gZGVzaWdud2FyZS5jCj4gPiBpbmRleCAwZTAzYWYy
NzkyNTkuLjZiZjBiNDA5MDUwYSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2R3Yy9wY2ll
LWRlc2lnbndhcmUuYwo+ID4gKysrIGIvZHJpdmVycy9wY2kvZHdjL3BjaWUtZGVzaWdud2FyZS5j
Cj4gPiBAQCAtMTc3LDcgKzE3Nyw3IEBAIHZvaWQgZHdfcGNpZV9wcm9nX291dGJvdW5kX2F0dShz
dHJ1Y3QgZHdfcGNpZSAqcGNpLAo+IGludCBpbmRleCwgaW50IHR5cGUsCj4gPiAgCSAqLwo+ID4g
IAlmb3IgKHJldHJpZXMgPSAwOyByZXRyaWVzIDwgTElOS19XQUlUX01BWF9JQVRVX1JFVFJJRVM7
IHJldHJpZXMrKykKPiB7Cj4gPiAgCQl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVf
QVRVX0NSMik7Cj4gPiAtCQlpZiAodmFsID09IFBDSUVfQVRVX0VOQUJMRSkKPiA+ICsJCWlmICh2
YWwgJiBQQ0lFX0FUVV9FTkFCTEUpCj4gPiAgCQkJcmV0dXJuOwo+ID4KPiA+ICAJCXVzbGVlcF9y
YW5nZShMSU5LX1dBSVRfSUFUVV9NSU4sIExJTktfV0FJVF9JQVRVX01BWCk7Cj4gPgo+IE1ha2Ug
c2Vuc2UsIHR1cm4gaXQgbW9yZSBhY2N1cmF0ZS4gVGhhbmtzIQo+IAo+IEFja2VkLWJ5OiBKb2Fv
IFBpbnRvIDxqcGludG9Ac3lub3BzeXMuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
