Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1525053746.5013.8.camel@mtkswgap22>
Subject: Re: [PATCH v6 0/2] PCI: mediatek: Fixups for the IRQ handle routine
 and MT7622's class code
From: Ryder Lee <ryder.lee@mediatek.com>
To: Honghui Zhang =?UTF-8?Q?=28=E5=BC=A0=E6=B4=AA=E8=BE=89=29?=
 <Honghui.Zhang@mediatek.com>
Date: Mon, 30 Apr 2018 10:02:26 +0800
In-Reply-To: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
References: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=
 <youlin.pei@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Hongkun Cao =?UTF-8?Q?=28=E6=9B=B9=E6=B4=AA=E5=9D=A4=29?=
 <Hongkun.Cao@mediatek.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?=
 <sean.wang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yong Wu =?UTF-8?Q?=28=E5=90=B4=E5=8B=87=29?= <Yong.Wu@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Xinping Qian =?UTF-8?Q?=28=E9=92=B1=E6=96=B0=E5=B9=B3=29?=
 <xinping.qian@mediatek.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 Yingjoe Chen =?UTF-8?Q?=28=3F=3F=E8=8B=B1=E6=B4=B2=29?=
 <Yingjoe.Chen@mediatek.com>,
 Eddie Huang =?UTF-8?Q?=28=3FS=3F=C7=82=3F=29?= <eddie.huang@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gRnJpLCAyMDE4LTA0LTIwIGF0IDEzOjI1ICswODAwLCBIb25naHVpIFpoYW5nICjlvKDmtKro
vokpIHdyb3RlOgo+IEZyb206IEhvbmdodWkgWmhhbmcgPGhvbmdodWkuemhhbmdAbWVkaWF0ZWsu
Y29tPgo+IAo+IFR3byBmaXh1cHMgZm9yIG1lZGlhdGVrJ3MgaG9zdCBicmlkZ2U6Cj4gVGhlIGZp
cnN0IHBhdGNoIGZpeHVwIGNsYXNzIHR5cGUgYW5kIHZlbmRvciBJRCBmb3IgTVQ3NjIyLgo+IFRo
ZSBzZWNvbmQgcGF0Y2ggZml4dXAgdGhlIElSUSBoYW5kbGUgcm91dGluZSBieSB1c2luZyBpcnFf
Y2hpcCBzb2x1dGlvbgo+IHRvIGF2b2lkIElSUSByZWVudHJ5IHdoaWNoIG1heSBleGlzdCBmb3Ig
Ym90aCBNVDI3MTIgYW5kIE1UNzYyMi4KPiAKPiBDaGFuZ2Ugc2luY2UgdjU6Cj4gIC0gTWFrZSB0
aGUgY29tbWVudHMgY29uc2lzdGVuZCB3aXRoIHRoZSBjb2RlIG1vZGlmaWNhdGlvbiBpbiB0aGUg
Zmlyc3QgcGF0Y2guCj4gIC0gVXNpbmcgd3JpdGV3IHRvIHBlcmZvcm1pbmcgYSAxNi1iaXQgd3Jp
dGUuCj4gIC0gVXNpbmcgaXJxX2NoaXAgc29sdXRpb24gdG8gZml4IHRoZSBJUlEgaXNzdWUuCj4g
Cj4gVGhlIHY1IHBhdGNoc2V0IGNvdWxkIGJlIGZvdW5kIGluOgo+ICBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzEwMTMzMzAzCj4gIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvMTAxMzMzMDUKPiAKPiBDaGFuZ2Ugc2luY2UgdjQ6Cj4gIC0gT25seSBzZXR1cCB2
ZW5kb3IgSUQgZm9yIE1UNzYyMiwgaWdvcm5pbmcgdGhlIGRldmljZSBJRCBzaW5jZSBtZWRpYXRl
aydzCj4gICAgaG9zdCBicmlkZ2UgZHJpdmVyIGRvZXMgbm90IGNhcmVzIGFib3V0IHRoZSBkZXZp
Y2UgSUQuCj4gCj4gQ2hhbmdlIHNpbmNlIHYzOgo+ICAtIFNldHVwIHRoZSBjbGFzcyB0eXBlIGFu
ZCB2ZW5kb3IgSUQgYXQgdGhlIGJlZ2lubmluZyBvZiBzdGFydHVwIGluc3RlYWQKPiAgICBvZiBp
biBhIHF1aXJrLgo+ICAtIEFkZCBtZWRpYXRlaydzIHZlbmRvciBJRCwgaXQgY291bGQgYmUgZm91
bmQgaW46Cj4gICAgaHR0cHM6Ly9wY2lzaWcuY29tL21lbWJlcnNoaXAvbWVtYmVyLWNvbXBhbmll
cz9jb21iaW5lPSZwYWdlPTQKPiAKPiBDaGFuZ2Ugc2luY2UgdjI6Cj4gIC0gTW92ZSB0aGUgaW5p
dGlhbGl6ZSBvZiB0aGUgaXRlcmF0ZSBiZWZvcmUgdGhlIGxvb3AgdG8gZml4IGFuCj4gICAgSU5U
eCBJUlEgaXNzdWUgaW4gdGhlIGZpcnN0IHBhdGNoCj4gCj4gQ2hhbmdlIHNpbmNlIHYxOgo+ICAt
IEFkZCB0aGUgc2Vjb25kIHBhdGNoLgo+ICAtIE1ha2UgdGhlIGZpcnN0IHBhdGNoJ3MgY29tbWl0
IG1lc3NhZ2UgbW9yZSBzdGFuZGFyZC4KPiBIb25naHVpIFpoYW5nICgyKToKPiAgIFBDSTogbWVk
aWF0ZWs6IFNldCB1cCB2ZW5kb3IgSUQgYW5kIGNsYXNzIHR5cGUgZm9yIE1UNzYyMgo+ICAgUENJ
OiBtZWRpYXRlazogVXNpbmcgY2hhaW5lZCBJUlEgdG8gc2V0dXAgSVJRIGhhbmRsZQo+IAo+ICBk
cml2ZXJzL3BjaS9ob3N0L3BjaWUtbWVkaWF0ZWsuYyB8IDIyMCArKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgaW5jbHVkZS9saW51eC9wY2lfaWRzLmggICAgICAgICAg
fCAgIDIgKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspLCA4OSBkZWxldGlv
bnMoLSkKCgpBY2tlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPiBmb3Ig
dGhlIHNlcmllcy4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
