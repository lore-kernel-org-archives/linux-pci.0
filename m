Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <e5d9d89e79f8ec37b6337e54912f49a0b0856874.camel@baylibre.com>
Subject: Re: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Hanjie Lin <hanjie.lin@amlogic.com>, Kishon Vijay Abraham I <kishon@ti.com>
Date: Thu, 16 Aug 2018 10:33:39 +0200
In-Reply-To: <2b87e834-41e3-e418-95f0-c6d695cd8b3f@amlogic.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
 <486e8ab477cc22ff231d2e18d7de22efba2c5abd.camel@baylibre.com>
 <2b87e834-41e3-e418-95f0-c6d695cd8b3f@amlogic.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org,
 Yue Wang <yue.wang@amlogic.com>, linux-pci@vger.kernel.org,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gVGh1LCAyMDE4LTA4LTE2IGF0IDExOjA1ICswODAwLCBIYW5qaWUgTGluIHdyb3RlOgo+IAo+
IE9uIDIwMTgvOC8xNCAxODo0MSwgSmVyb21lIEJydW5ldCB3cm90ZToKPiA+IE9uIFR1ZSwgMjAx
OC0wOC0xNCBhdCAwMjoxMiAtMDQwMCwgSGFuamllIExpbiB3cm90ZToKPiA+ID4gRnJvbTogWXVl
IFdhbmcgPHl1ZS53YW5nQGFtbG9naWMuY29tPgo+ID4gPiAKPiA+ID4gVGhlIE1lc29uLVBDSUUt
UEhZIGNvbnRyb2xsZXIgc3VwcG9ydHMgdGhlIDUtR2JwcyBkYXRhIHJhdGUKPiA+ID4gb2YgdGhl
IFBDSSBFeHByZXNzIEdlbiAyIHNwZWNpZmljYXRpb24gYW5kIGlzIGJhY2t3YXJkY29tcGF0aWJs
ZQo+ID4gPiB3aXRoIHRoZSAyLjUtR2JwcyBHZW4gMS4xIHNwZWNpZmljYXRpb24gd2l0aCBvbmx5
Cj4gPiA+IGluZmVycmVkIGlkbGUgZGV0ZWN0aW9uIHN1cHBvcnRlZCBvbiBBTUxPR0lDIFNvQ3Mu
Cj4gPiAKPiA+IEl0IGxvb2tzIGxpa2UgdGhlIHNvbGUgcHVycG9zZSBvZiB0aGlzIGRyaXZlciBp
cyB0byBwcm92aWRlIHRoZSByZXNldCBsaW5lcyB0bwo+ID4gcGNpZSBkcml2ZXIuCj4gPiAKPiA+
IEkgd29uZGVyIHdoeSB3ZSBuZWVkIHRoaXMgPyBDYW4ndCB0aGUgcGNpZSBkcml2ZXIgY2xhaW0g
dGhlIHJlc2V0IGxpbmVzIGl0c2VsZi4KPiA+IAo+ID4gQWxzbywgYW4gaW5pdCBvZiB0aGlzIHBo
eSB3aWxsIGFsd2F5cyByZXNldCBib3RoIHBvcnQuIFdoYXQgd2lsbCBoYXBwZW4gaWYgdGhlCj4g
PiBmaXJzdCBwb3J0IGlzIGluIHVzZSBhbmQgdGhlIDJuZCBwb3J0IGNvbWVzIHVwID8/IAo+ID4g
Cj4gPiBMb29rcyB0aGUgdGhlIHBjaWUgZHJpdmVyIHNob3VsZCBjbGFpbSAnYXBiJyBhbmQgJ3Bo
eScgcmVzZXQgbGluZXMgYXMgInNoYXJlZCIKPiA+IHJlc2V0IGFuZCB0aGUgcmVxdWlyZWQgJ3Bv
cnQnIGFzICdleGNsdXNpdmUnCj4gPiAKPiAKPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2Uu
Cj4gCj4gWWVzLCAnYXBiJyBhbmQgJ3BoeScgcmVzZXQgbGluZXMgYXJlIHNoYXJlZCwgYW5kIOKA
mHBvcnQnIHJlc2V0IGxpbmUgaXMgZXhjbHVzaXZlLgo+IElmIHdlIGhhbmRsZSBhbGwgcmVzZXQg
bGluZXMgZHVyaW5nIHRoZSBmaXJzdCBwb3J0IGluaXRpYWwgc2VxdWVuY2UsIAo+IGFuZCB3aGVu
IHRoZSBzZWNvbmQgcG9ydCBjb21lcyB1cCwgd2Ugd2lsbCBkbyBub3RoaW5nIGFib3V0IHRoZSBy
ZXN0IGxpbmVzLCAKPiBhbmQgZG9uJ3QgbmVlZCBhIGV4dHJhIEFQSSB0byBkbyDigJhwb3J0JyBy
ZXNldDsKCldpdGggd2hpY2ggb3RoZXIgZHJpdmVyIGFyZSB5b3VyIGNvbnRyb2wgc2hhcmVkID8K
Ckxvb2tzIGl0IGlzIHRoZSBhbnN3ZXIgaXMgbm9uZSBzaW5jZSB0aGlzIHBoeSBkcml2ZXIgd2ls
bCByZXNldCBib3RoIHBvcnQKYWxyZWFkeSwgZXZlbiBpZiBvbmUgaXMgdXNlZC4KCkluIHRoaXMg
Y2FzZSB0aGUgZmFjdCB0aGF0IHlvdSBhcmUgdXNpbmcgc2hhcmVkIGNvbnRyb2wgaXMganVzdCBh
YnVzaW5nIHRoZQpmcmFtZXdvcmsgdG8gcmVzZXQgb25jZS4KCkFzIGZhciBhcyBJIGNhbiB0ZWxs
LCB0aGlzIGRyaXZlciBtYWtlcyBubyBzZW5zZS4gVGhlIGFwcHJvcHJpYXRlIHJlc2V0IGxpbmVz
CnNob3VsZCBiZSBnaXZlbiBkaXJlY3RseSB0byB5b3VyIHBjaWUgZHJpdmVyLiAKCgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
