Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Nov 2017 08:13:42 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH V3 24/29] backlight: deprecate pci_get_bus_and_slot()
Message-ID: <20171128081342.qvylfa6p5rvqoyxk@dell>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-25-git-send-email-okaya@codeaurora.org>
 <000001d367b8$726bd7f0$574387d0$@gmail.com>
MIME-Version: 1.0
In-Reply-To: <000001d367b8$726bd7f0$574387d0$@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Daniel Thompson' <daniel.thompson@linaro.org>,
 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org,
 "'open list:FRAMEBUFFER LAYER'" <linux-fbdev@vger.kernel.org>,
 'open list' <linux-kernel@vger.kernel.org>,
 'Sinan Kaya' <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gTW9uLCAyNyBOb3YgMjAxNywgSmluZ29vIEhhbiB3cm90ZToKPiBPbiBNb25kYXksIE5vdmVt
YmVyIDI3LCAyMDE3IDExOjU4IEFNLCBTaW5hbiBLYXlhIHdyb3RlOgo+ID4gCj4gPiBwY2lfZ2V0
X2J1c19hbmRfc2xvdCgpIGlzIHJlc3RyaWN0aXZlIHN1Y2ggdGhhdCBpdCBhc3N1bWVzIGRvbWFp
bj0wIGFzCj4gPiB3aGVyZSBhIFBDSSBkZXZpY2UgaXMgcHJlc2VudC4gVGhpcyByZXN0cmljdHMg
dGhlIGRldmljZSBkcml2ZXJzIHRvIGJlCj4gPiByZXVzZWQgZm9yIG90aGVyIGRvbWFpbiBudW1i
ZXJzLgo+IAo+IEkgdGhpbmsgdGhhdCB0aGlzIHdpbGwgYmUgdXNlZnVsLiBJIGludHJvZHVjZWQg
bXVsdGkgZG9tYWlucyBpbnRvCj4gQVJNLWJhc2VkIFBDSWUgZHJpdmVyLiAoZS5nLiBkb21haW4g
MCwgYW5kIGRvbWFpbiAxKSBTbywgQVBJcyB0byBjaG9vc2UKPiBkb21haW4gd2lsbCBiZSB1c2Vk
IGxhdGVyLgo+IAo+ID4gCj4gPiBHZXR0aW5nIHJlYWR5IHRvIHJlbW92ZSBwY2lfZ2V0X2J1c19h
bmRfc2xvdCgpIGZ1bmN0aW9uIGluIGZhdm9yIG9mCj4gPiBwY2lfZ2V0X2RvbWFpbl9idXNfYW5k
X3Nsb3QoKS4KPiA+IAo+ID4gSGFyZC1jb2RpbmcgdGhlIGRvbWFpbiBhcyAwLgo+ID4gCj4gPiBB
Y2tlZC1ieTogRGFuaWVsIFRob21wc29uIDxkYW5pZWwudGhvbXBzb25AbGluYXJvLm9yZz4KPiA+
IFNpZ25lZC1vZmYtYnk6IFNpbmFuIEtheWEgPG9rYXlhQGNvZGVhdXJvcmEub3JnPgo+IAo+IEFj
a2VkLWJ5OiBKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdtYWlsLmNvbT4KCkkgY2FuJ3QgYXBwbHkg
dGhpcy4KCkl0IGxvb2tzIGxpa2UgSSB3YXMgbWlzc2luZyBmcm9tIHRoZSBsaXN0IG9mIGFkZHJl
c3NlZXMuCgpQbGVhc2UgcmVzZW5kIHYzIHdpdGggYWxsIHRoZSBBY2tzIHlvdSd2ZSBhY3F1aXJl
ZC4KCj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9hcHBsZV9ibC5jIHwgMiAr
LQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4g
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvYXBwbGVfYmwuYwo+ID4g
Yi9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9hcHBsZV9ibC5jCj4gPiBpbmRleCBkODQzMjk2Li42
YTM0YWI5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvYXBwbGVfYmwu
Ywo+ID4gKysrIGIvZHJpdmVycy92aWRlby9iYWNrbGlnaHQvYXBwbGVfYmwuYwo+ID4gQEAgLTE0
Myw3ICsxNDMsNyBAQCBzdGF0aWMgaW50IGFwcGxlX2JsX2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KmRldikKPiA+ICAJc3RydWN0IHBjaV9kZXYgKmhvc3Q7Cj4gPiAgCWludCBpbnRlbnNpdHk7Cj4g
PiAKPiA+IC0JaG9zdCA9IHBjaV9nZXRfYnVzX2FuZF9zbG90KDAsIDApOwo+ID4gKwlob3N0ID0g
cGNpX2dldF9kb21haW5fYnVzX2FuZF9zbG90KDAsIDAsIDApOwo+ID4gCj4gPiAgCWlmICghaG9z
dCkgewo+ID4gIAkJcHJfZXJyKCJ1bmFibGUgdG8gZmluZCBQQ0kgaG9zdFxuIik7Cj4gCj4gCgot
LSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBUZWFtIExlYWQK
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBM
aW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
