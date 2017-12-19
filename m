Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 19 Dec 2017 08:51:25 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 21/26] backlight: deprecate pci_get_bus_and_slot()
Message-ID: <20171219085125.55qsifnhh7u57ucv@dell>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-22-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1513661883-28662-22-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Jingoo Han <jingoohan1@gmail.com>, timur@codeaurora.org,
 "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gVHVlLCAxOSBEZWMgMjAxNywgU2luYW4gS2F5YSB3cm90ZToKCj4gcGNpX2dldF9idXNfYW5k
X3Nsb3QoKSBpcyByZXN0cmljdGl2ZSBzdWNoIHRoYXQgaXQgYXNzdW1lcyBkb21haW49MCBhcwo+
IHdoZXJlIGEgUENJIGRldmljZSBpcyBwcmVzZW50LiBUaGlzIHJlc3RyaWN0cyB0aGUgZGV2aWNl
IGRyaXZlcnMgdG8gYmUKPiByZXVzZWQgZm9yIG90aGVyIGRvbWFpbiBudW1iZXJzLgo+IAo+IEdl
dHRpbmcgcmVhZHkgdG8gcmVtb3ZlIHBjaV9nZXRfYnVzX2FuZF9zbG90KCkgZnVuY3Rpb24gaW4g
ZmF2b3Igb2YKPiBwY2lfZ2V0X2RvbWFpbl9idXNfYW5kX3Nsb3QoKS4KPiAKPiBIYXJkLWNvZGlu
ZyB0aGUgZG9tYWluIGFzIDAuCj4gCj4gU2lnbmVkLW9mZi1ieTogU2luYW4gS2F5YSA8b2theWFA
Y29kZWF1cm9yYS5vcmc+Cj4gQWNrZWQtYnk6IEppbmdvbyBIYW4gPGppbmdvb2hhbjFAZ21haWwu
Y29tPgo+IEFja2VkLWJ5OiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8u
b3JnPgo+IC0tLQo+ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9hcHBsZV9ibC5jIHwgMiArLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCkFwcGxpZWQs
IHRoYW5rcy4KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxp
bmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGlu
YXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
