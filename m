Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1492005119.7236.62.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Wed, 12 Apr 2017 23:51:59 +1000
In-Reply-To: <20170412113124.GZ17774@n2100.armlinux.org.uk>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

T24gV2VkLCAyMDE3LTA0LTEyIGF0IDEyOjMxICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggd3JvdGU6Cj4gZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBzaG91bGQgZmFpbCBpZiBpdCdzIG5v
dCBzdXBwb3J0YWJsZSBvbiBhbGwKPiBhcmNoaXRlY3R1cmVzLsKgIEhvd2V2ZXIsIHdoZW4gd2Ug
aGF2ZSBleGlzdGluZyBkcml2ZXJzIHVzaW5nIGFuCj4gaW50ZXJmYWNlIHRoYXQgZG9lc24ndCBw
cm92aWRlIHRoZSBzZW1hbnRpY3MgdGhleSBhbHJlYWR5IHJlcXVpcmUsCj4gdGhlbiBpdCBtYWtl
cyBubyBzZW5zZSB0byBlZmZlY3RpdmVseSBicmVhayB0aGVzZSBkcml2ZXJzIG9uIGEgcmFuZ2UK
PiBvZiBleGlzdGluZyBhcmNoaXRlY3R1cmVzLgo+IAo+IFRoZSBxdWVzdGlvbiByZWFsbHkgaXMg
LSB3aGF0J3MgdGhlIGJlc3Qgd2F5IHRvIHNvbHZlIHRoZSBwcm9ibGVtCj4gd2l0aAo+IGV4aXN0
aW5nIGRyaXZlcnMgd2l0aG91dCBicmVha2luZyB0aGVtLsKgIEkgc3VzcGVjdCB0aGF0LCBzYWRs
eSwgdGhlCj4gb25seSByZWFsaXN0aWMgd2F5IGZvcndhcmQgaGVyZSBpcyB2aWEgdGhlIGxpdHRl
ci1kcml2ZXJzLXdpdGgtaWZkZWZzCj4gYXBwcm9hY2ggc2luY2UgeW91IGRvbid0IGxpa2UgcHJv
dmlkaW5nIGEgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiB0aGF0Cj4gaXMgY29tcGF0aWJsZSB3aXRo
IHdoYXQgdGhlc2UgZHJpdmVycyBhcmUgYWxyZWFkeSBkb2luZy4KClRoZW4gbWFrZSBpb3JlbWFw
X25vcG9zdCByZXR1cm4gTlVMTCB3aGVuIHRoZSBhcmNoIGRvZXNuJ3QgaGF2ZSAKdGhlIHJpZ2h0
IHNlbWFudGljLgoKVGhlIGRyaXZlciB0aGFuIGNhbiAqY2hvc2UqIHRvIGVpdGhlciBzaWxlbnRs
eSBmYWxsYmFjayB0byBpb3JlbWFwLAp3aGljaCBoYXMgc2VydmVkIHVzIHdlbGwgZm9yIGEgbG9u
ZyB0aW1lIGRlc3BpdGUgYmVpbmcgdGhlb3JpY2FsbHkgaW4KdmlvbGF0aW9uIG9mIHRoZSBzcGVj
LCBvciBkbyBmdW5ueSB0aGluZ3MgbGlrZSByZWFkIGJhY2sgc29tZSByZWdpc3RlcgphZnRlciBl
dmVyeSBjb25maWcgd3JpdGUgdG8gZW5zdXJlIG9yZGVyaW5nIGV0Yy4uLgoKSSBtdWNoIHByZWZl
ciB0aGF0IGFwcHJvYWNoIHRoYW4gaGF2aW5nIHNvbWUgZ2VuZXJpYyBpb3JlbWFwIGZ1bmN0aW9u
CnRoYXQgZXhwb3NlcyBhIHNlbWFudGljIHRoYXQgc2lsZW50bHkgcHJvdmlkZXMgYSB3ZWFrZXIg
b25lIG9uIHNvbWUKYXJjaGl0ZWN0dXJlLgoKQXQgbGVhc3Qgd2UgbWFrZSB0aGUgZmFpbHVyZSBl
eHBsaWNpdCwgYW5kIHRoZSBkcml2ZXIgY2FuIHRha2UKYWx0ZXJuYXRlIChwb3NzaWJseSBzdWIt
b3B0aW1hbCkgYWN0aW9uIGlmIGl0IGNob29zZXMgdG8gZG8gc28uCgpDaGVlcnMsCkJlbi4KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
