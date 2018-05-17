Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To: Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
 <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <6e875491-38a9-f7cf-92d7-53698299403a@codeaurora.org>
Date: Thu, 17 May 2018 09:05:28 -0400
MIME-Version: 1.0
In-Reply-To: <74ae2347-464c-ddc1-3cb9-f928692e792f@arm.com>
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

T24gNS8xNy8yMDE4IDY6MTcgQU0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gK8KgwqDCoCB9Cj4+
ICsKPiAKPiBJcyB0aGlzIG5vdCBwcmV0dHkgbXVjaCBqdXN0IHBjaWJpb3NfYnVzX3RvX3Jlc291
cmNlKCk/Cj4KCkFncmVlZCwgbGV0IG1lIGNvbnZlcnQgdGhlIGNvZGUgdG8gdXNlIHBjaWJpb3Nf
YnVzX3RvX3Jlc291cmNlKCkgQVBJLgpJIHdhc24ndCBhd2FyZSBvZiBpdHMgZXhpc3RlbmNlLgog
Cj4gUm9iaW4uCgoKLS0gClNpbmFuIEtheWEKUXVhbGNvbW0gRGF0YWNlbnRlciBUZWNobm9sb2dp
ZXMsIEluYy4gYXMgYW4gYWZmaWxpYXRlIG9mIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLgpR
dWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gaXMgYSBtZW1iZXIgb2YgdGhlIENvZGUgQXVyb3Jh
IEZvcnVtLCBhIExpbnV4IEZvdW5kYXRpb24gQ29sbGFib3JhdGl2ZSBQcm9qZWN0LgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
