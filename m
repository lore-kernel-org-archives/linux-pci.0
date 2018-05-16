Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To: Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
 <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9f8ea8f6-6005-1b46-4d75-4f89e04ad9c1@codeaurora.org>
Date: Wed, 16 May 2018 14:41:12 -0400
MIME-Version: 1.0
In-Reply-To: <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
 Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gNS8xNi8yMDE4IDI6MzEgUE0sIFRpbXVyIFRhYmkgd3JvdGU6Cj4gT24gMDUvMTYvMjAxOCAw
MToyMyBQTSwgU2luYW4gS2F5YSB3cm90ZToKPj4gK8KgwqDCoMKgwqDCoMKgIHdpbl9zdGFydCA9
IHdpbmRvdy0+cmVzLT5zdGFydCAtIHdpbmRvdy0+b2Zmc2V0Owo+IAo+IENhbiB5b3UgZ3VhcmFu
dGVlIHRoYXQgd2luZG93LT5yZXMtPnN0YXJ0IGlzIGFsd2F5cyA+PSB3aW5kb3ctPm9mZnNldD8K
PiAKClJlc291cmNlIG9mZnNldCBpcyBnZW5lcmFsbHkgMCB3aGVuIG5vdCB0cmFuc2xhdGluZyBv
ciBhIHBvc2l0aXZlIG51bWJlcgp0aGF0IHlvdSBzdWJ0cmFjdCBmcm9tIHRoZSByZXNvdXJjZSBz
dGFydCB0byByZWFjaCB0byB0aGUgdHJhbnNsYXRpbmcgd2luZG93LgoKSGF2aW5nIGEgYmlnZ2Vy
IG9mZnNldCB0aGFuIHJlc291cmNlIHN0YXJ0IHNob3VsZCBiZSBjb25zaWRlcmVkIGEgQklPUyBi
dWcuCgo+PiArwqDCoMKgwqDCoMKgwqAgd2luX3NpemUgPSB3aW5kb3ctPnJlcy0+ZW5kIC0gd2lu
ZG93LT5yZXMtPnN0YXJ0ICsgMTsKPiAKPiBVc2UgcmVzb3VyY2Vfc2l6ZSgpIGluc3RlYWQuCj4g
CgpJJ2xsIGZpeCBpdC4KCi0tIApTaW5hbiBLYXlhClF1YWxjb21tIERhdGFjZW50ZXIgVGVjaG5v
bG9naWVzLCBJbmMuIGFzIGFuIGFmZmlsaWF0ZSBvZiBRdWFsY29tbSBUZWNobm9sb2dpZXMsIElu
Yy4KUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGlzIGEgbWVtYmVyIG9mIHRoZSBDb2RlIEF1
cm9yYSBGb3J1bSwgYSBMaW51eCBGb3VuZGF0aW9uIENvbGxhYm9yYXRpdmUgUHJvamVjdC4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
