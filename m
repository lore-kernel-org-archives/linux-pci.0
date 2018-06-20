Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V2] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
To: Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org
References: <1529460886-23722-1-git-send-email-okaya@codeaurora.org>
 <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <843fd601-0b81-d29f-0aa8-13a261a0b931@codeaurora.org>
Date: Tue, 19 Jun 2018 23:04:38 -0400
MIME-Version: 1.0
In-Reply-To: <dafc272d-0748-90ee-5d34-be5b2a2e5725@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gNi8xOS8yMDE4IDExOjAyIFBNLCBUaW11ciBUYWJpIHdyb3RlOgo+IE9uIDYvMTkvMTggOTox
NCBQTSwgU2luYW4gS2F5YSB3cm90ZToKPj4gK8KgwqDCoCBpZiAoIShjYXAgJiBQQ0lfRVhQX0RF
VkNBUDJfRTJFVExQKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gKwo+PiArwqDCoMKg
IGRldi0+ZWV0bHBfcHJlZml4ID0gMTsKPiAKPiBIb3cgYWJvdXQ6Cj4gCj4gwqDCoMKgwqBpZiAo
Y2FwICYgUENJX0VYUF9ERVZDQVAyX0UyRVRMUCkKPiDCoMKgwqDCoMKgwqDCoCBkZXYtPmVldGxw
X3ByZWZpeCA9IDE7Cj4gCgpCb3RoIHdvcmtzLiBJJ2xsIHdhaXQgdW50aWwgSSBnZXQgbW9yZSBm
ZWVkYmFjay4KCi0tIApTaW5hbiBLYXlhClF1YWxjb21tIERhdGFjZW50ZXIgVGVjaG5vbG9naWVz
LCBJbmMuIGFzIGFuIGFmZmlsaWF0ZSBvZiBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4KUXVh
bGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGlzIGEgbWVtYmVyIG9mIHRoZSBDb2RlIEF1cm9yYSBG
b3J1bSwgYSBMaW51eCBGb3VuZGF0aW9uIENvbGxhYm9yYXRpdmUgUHJvamVjdC4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
