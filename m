Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1492036240.7236.80.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux
 <linux@armlinux.org.uk>
Date: Thu, 13 Apr 2017 08:30:40 +1000
In-Reply-To: <20170412144109.GB6842@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>,
 linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Bjorn Helgaas <bhelgaas@google.com>, Stafford Horne <shorne@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Niklas Cassel <nks@flawful.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Ley Foon Tan <lftan@altera.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gV2VkLCAyMDE3LTA0LTEyIGF0IDE1OjQxICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToKPiA+ID4gQXQgbGVhc3Qgd2UgbWFrZSB0aGUgZmFpbHVyZSBleHBsaWNpdCwgYW5kIHRoZSBk
cml2ZXIgY2FuIHRha2UKPiA+ID4gYWx0ZXJuYXRlIChwb3NzaWJseSBzdWItb3B0aW1hbCkgYWN0
aW9uIGlmIGl0IGNob29zZXMgdG8gZG8gc28uCj4gPiAKPiA+IFRoZSBzYW1lIHBvaW50cyBhcHBs
eSB0byB0aGluZ3MgbGlrZSBwZ3Byb3Rfd3JpdGVjb21iaW5lKCksCj4gPiBwZ3Byb3Rfbm9uY2Fj
aGVkKCksIHBncHJvdF9kZXZpY2UoKS7CoCBUaGVuIHRoZXJlJ3MgYWxzbyBwZ3Byb3Rfbm9ucG9z
dGVkKCkKPiA+IHRoYXQgdGhpcyBzZXJpZXMgYWxzbyBpbnRyb2R1Y2VzLgoKTm8uIHBncHJvdF93
cml0ZWNvbWJpbmUoKSBzaWxlbnRseSBmYWxsaW5nIGJhY2sgdG8gc2ltcGx5IG5vbi1jYWNoZWQg
aXMKb2sgYXMgd2UgYXJlbid0ICJ3ZWFrZW5pbmciIHRoZSBvcmRlcmluZyBydWxlcyBzaWxlbnRs
eSBoZXJlLiBTb21ldGhpbmcKdGhhdCBpcyBjb3JyZWN0IHdpdGggd3JpdGVjb21iaW5lIHdpbGwg
YWxzbyB3b3JrIHdpdGhvdXQuIEl0J3MganVzdCBhbgpvcHRpbWlzYXRpb24uIE5vdCBjb3JyZWN0
bmVzcy4KClRoaW5ncyBsaWtlIG5vbmNhY2hlZCgpIG11c3Qgb2YgY291cnNlIGJlIGhvbm9yZWQs
IGFuZCBJIGRvbid0IHRoaW5rCndlIGhhdmUgYSBjYXNlIGFueXdoZXJlIHdoZXJlIGl0IGlzbid0
LgoKTXkgcG9pbnQgd2l0aCBub3Bvc3QoKSBpcyB0aGF0IGl0J3MgbmV2ZXIgb2sgdG8gc2lsZW50
bHkgZG93bmdyYWRlIGl0LgpDb2RlIHdyaXR0ZW4gd2l0aCB0aGUgYXNzdW1wdGlvbiB0aGF0IHRo
ZXJlIGlzIG5vIHBvc3Rpbmcgd2lsbCBiZQoqaW5jb3JyZWN0KiBpZiBwb3N0aW5nIGhhcHBlbnMu
IFdlIGRvIGxpdmUgd2l0aCB0aGF0ICJidWciIHRvZGF5IGluZGVlZApidXQgb25jZSB3ZSBoYXZl
IHRoYXQgYWNjZXNzb3JzIHdlIG1pZ2h0IHN0YXJ0IGdyb3dpbmcgbW9yZSBjb2RlIHRoYXQKcmVs
aWVzIG9uIHRoZSBzcGVjaWZpYyBhdHRyaWJ1dGUgdGhhdCB0aGluZ3MgYXJlbid0IHBvc3RlZCBh
bmQgd2lsbCBiZQp3cm9uZyBvbiBhbGwgdGhlIGFyY2hzIHByb3ZpZGluZyB0aGUgZGVmYXVsdCBp
bXBsZW1lbnRhdGlvbi4KClRoaXMgaXMgd2h5IEkgaW5zaXN0IHRoYXQgcGdwcm90X25vcG9zdCgp
IGlmIGl0IGV4aXN0cyBnbG9iYWxseSwgc2hvdWxkCnJldHVybiBOVUxMIHdoZW4gdGhlIHNlbWFu
dGljIGNhbm5vdCBiZSBwcm92aWRlZC4gVGhhdCB3YXkgdGhlcmUgaXMgYQpjbGVhciBsaW5lIGlu
IHRoZSBzYW5kLiBJZiB0aGUgZHJpdmVyIGNob3NlcyB0byBvcGVyYXRlIHdpdGggcG9zdGVkCm5v
bi1jYWNoZWQgYW55d2F5LCB0aGVuIG1ha2UgaXQgYW4gZXhwbGljaXQgZHJpdmVyIGNob2ljZS4K
Cj4gPiBJZiBpb3JlbWFwX25vcG9zdCgpIGlzIG5vdCBwb3NzaWJsZSBvbiBhbiBhcmNoaXRlY3R1
cmUsIHRoZW4KPiA+IHBncHJvdF9ub25wb3N0ZWQoKSB3b24ndCBiZSBwb3NzaWJsZSBlaXRoZXIg
LSBidXQgeW91J3ZlIG1hZGUgbm8KPiA+IG1lbnRpb24gb2YgdGhhdCBzbyBmYXIuCgpSaWdodC4g
SXQncyBub3Qgb24gbW9zdCBpbiBmYWN0LgoKPiA+IEp1c3QgbGlrZSB0aGUgcHJvcG9zZWQgaW9y
ZW1hcF9ub3Bvc3QoKSwgcGdwcm90X25vbnBvc3RlZCgpIGlzIGdpdmVuIGEKPiA+IGRlZmF1bHQg
aW1wbGVtZW50YXRpb24gdGhhdCB1c2VzIHBncHJvdF9ub25jYWNoZWQoKS7CoCBNYXliZSB3ZSBz
aG91bGQKPiA+IGFsc28gbWFrZSBwY2lfcmVtYXBfaW9zcGFjZSgpIGZhaWwgaWYgcGdwcm90X25v
bnBvc3RlZCgpIGlzIG5vdCBkZWZpbmVkCj4gPiBieSB0aGUgYXJjaGl0ZWN0dXJlPwoKT3Igd2Ug
KmRvY3VtZW50KiB0aGF0IG1tYXAgb2YgSU8gc3BhY2UgY2FuIHJlc3VsdCBpbiBzb21ldGhpbmcg
dGhhdCBpcwpwYXJ0aWFsbHkgbm9uLXBvc3RlZC4KCj4gWWVzLCBJIHdhcyBhYm91dCB0byBtZW50
aW9uIHRoYXQgYW5kIHlvdSBhcmUgcmlnaHQsIEkgc2hvdWxkIGRlYWwgd2l0aAo+IHRoYXQgdG9v
IHVuZm9ydHVuYXRlbHkuIEJUVywgSSBoYXZlIG5vdCBwb3N0ZWQgdGhlIGRyaXZlcnMgdG8gbWFr
ZSB0aGUKPiByZXZpZXcgZWFzaWVyIChpZSBpdCB3b3VsZCBhZGQgMjAgbW9yZSBwYXRjaGVzIHRv
IGFuIGFscmVhZHkgbWFzc2l2ZQo+IHBhdGNoIHNlcmllcyAtIHRoYXQgd2lsbCBiZSB0cmltbWVk
IHdoZW4gdGhlIGFzbS1nZW5lcmljIGluY2x1ZGUgaXMKPiByZW1vdmVkIGZyb20gYXJjaGVzIGFj
Y29yZGluZyB0byB0aGlzIGRpc2N1c3Npb24pLgo+IAo+IFRoYW5rcywKPiBMb3JlbnpvCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
