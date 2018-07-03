Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To: poza@codeaurora.org
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
Date: Tue, 3 Jul 2018 09:31:24 -0400
MIME-Version: 1.0
In-Reply-To: <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Keith Busch <keith.busch@intel.com>, Lukas Wunner <lukas@wunner.de>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gNy8zLzIwMTggOToyNSBBTSwgU2luYW4gS2F5YSB3cm90ZToKPj4gd2hhdCBpZiB3ZSBvbmx5
IGhhdmUgY29uZGl0aW9uYWwgZW51bWVyYXRpb24gP8KgIChsZWF2aW5nIHJlbW92aW5nIGRldmlj
ZXMgZm9sbG93ZWQgYnkgU0JSIGFzIGlzKSA/Cj4+ClNvcnJ5LCBJIHRoaW5rIEkgZGlkbid0IHF1
aXRlIGdldCB5b3VyIHF1ZXN0aW9uLiAKCkFyZSB5b3UgYXNraW5nIGFib3V0IHRoZSBlbnVtZXJh
dGlvbiBmb2xsb3dpbmcgbGluayB1cCB3aGlsZSBrZWVwaW5nIHRoZQpjdXJyZW50IGNvZGUgYXMg
aXM/CgpJc3N1ZSBpcyBvYnNlcnZpbmcgaG90cGx1ZyBsaW5rIGRvd24gZXZlbnQgaW4gdGhlIG1p
ZGRsZSBvZiBBRVIgcmVjb3ZlcnkgYXMgaW4KbXkgcHJldmlvdXMgcmVwbHkuCgpJZiB3ZSBtYXNr
IGhvdHBsdWcgaW50ZXJydXB0cyBiZWZvcmUgc2Vjb25kYXJ5IGJ1cyByZXNldCB2aWEgbXkgcGF0
Y2gsCnRoZW4gaG90cGx1ZyBkcml2ZXIgd2lsbCBub3Qgb2JzZXJ2ZSBib3RoIGxpbmsgdXAgYW5k
IGxpbmsgZG93biBpbnRlcnJ1cHRzLgoKSWYgd2UgZG9uJ3QgbWFzayBob3RwbHVnIGludGVycnVw
dHMsIHdlIGhhdmUgYSByYWNlIGNvbmRpdGlvbi4KCkkgaG9wZSBJIGFuc3dlcmVkIHlvdXIgcXVl
c3Rpb24uCgotLSAKU2luYW4gS2F5YQpRdWFsY29tbSBEYXRhY2VudGVyIFRlY2hub2xvZ2llcywg
SW5jLiBhcyBhbiBhZmZpbGlhdGUgb2YgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuClF1YWxj
b21tIFRlY2hub2xvZ2llcywgSW5jLiBpcyBhIG1lbWJlciBvZiB0aGUgQ29kZSBBdXJvcmEgRm9y
dW0sIGEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZlIFByb2plY3QuCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
