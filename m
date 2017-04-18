Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1492511808.25766.91.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Tue, 18 Apr 2017 20:36:48 +1000
In-Reply-To: <20170418085732.GA23882@red-moon>
References: <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
 <1492036240.7236.80.camel@kernel.crashing.org>
 <20170412224555.GB17774@n2100.armlinux.org.uk>
 <1492044780.7236.87.camel@kernel.crashing.org>
 <20170418085732.GA23882@red-moon>
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
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
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

T24gVHVlLCAyMDE3LTA0LTE4IGF0IDA5OjU3ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToKPiBJIGNhbiBhZGQgYSBkZWZpbmVkKHBncHJvdF9ub25wb3N0ZWQpIHRvIHBjaV9yZW1hcF9p
b3NwYWNlKCkgaWYgdGhhdCdzCj4gbm90IHRvbyB1Z2x5IChJIHN1c3BlY3QgQmpvcm4gaXMgdGhy
aWxsZWQgYWJvdXQgaXQgOikpLCB0aGF0IHBsdXMKPiB0aGUgS2NvbmZpZyBvcHRpb24gZm9yIGlv
cmVtYXBfbm9wb3N0KCkgc2hvdWxkIGNvbXBsZXRlIHRoaXMgc2VyaWVzLgo+IAo+IGludCBwY2lf
cmVtYXBfaW9zcGFjZShjb25zdCBzdHJ1Y3QgcmVzb3VyY2UgKnJlcywgcGh5c19hZGRyX3QgcGh5
c19hZGRyKQo+IHsKPiAjaWYgZGVmaW5lZChQQ0lfSU9CQVNFKSAmJiBkZWZpbmVkKENPTkZJR19N
TVUpICYmIGRlZmluZWQocGdwcm90X25vbnBvc3RlZCkKPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgbG9uZyB2YWRkciA9ICh1bnNpZ25lZCBsb25nKVBDSV9JT0JBU0UgKyByZXMtPnN0YXJ0Owo+
IAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIShyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9JTykpCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiAKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKHJlcy0+ZW5kID4gSU9fU1BBQ0VfTElNSVQpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTAo+IMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gaW9yZW1hcF9wYWdlX3JhbmdlKHZhZGRyLCB2YWRkciArIHJlc291cmNlX3NpemUocmVzKSwg
cGh5c19hZGRyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZ3Byb3Rfbm9ucG9zdGVkKFBBR0VfS0VSTkVMKSk7Cj4g
I2Vsc2UKPiDCoMKgwqDCoMKgwqDCoMKgLyogdGhpcyBhcmNoaXRlY3R1cmUgZG9lcyBub3QgaGF2
ZSBtZW1vcnkgbWFwcGVkIEkvTyBzcGFjZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbyB0aGlz
IGZ1bmN0aW9uIHNob3VsZCBuZXZlciBiZSBjYWxsZWQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgV0FS
Tl9PTkNFKDEsICJUaGlzIGFyY2hpdGVjdHVyZSBkb2VzIG5vdCBzdXBwb3J0IG1lbW9yeSBtYXBw
ZWQgSS9PXG4iKTsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9ERVY7Cj4gI2VuZGlmCgpU
aGUgYWJvdmUgd291bGQgZWZmZWN0aXZlbHkgZGlzYWJsZSBtbWFwJ2luZyBvZiBJTyBzcGFjZSBm
b3IgYW55CmFyY2hpdGVjdHVyZSB0aGF0IGRvZXNuJ3QgaGF2ZSBwZ3Byb3Rfbm9ucG9zdGVkLi4u
IHNvIGV2ZXJ5Ym9keSBleGNlcHQKQVJNLiBUaHVzIGJyZWFraW5nIGEgbnVtYmVyIG9mIHN5c3Rl
bXMgdGhhdCBoYXZlIGJlZW4gd29ya2luZyBmaW5lIGZvcgp5ZWFycy4KCkkgZmFpbCB0byBzZWUg
dGhlIHBvaW50Li4uLgoKSSB0aGluayB5b3UgYXJlIGdpdmluZyB0aGUgd2hvbGUgbm9uLXBvc3Rl
ZCBzdHVmZiB3YXkgbW9yZSBpbXBvcnRhbmNlCnRoYW4gaXQgZGVzZXJ2ZXMuIEl0J3Mgb3JpZ2lu
YWxseSBhIGtsdWRnZSBJbnRlbCBkaWQgdG8gUENJIGJlY2F1c2UgaXQKd2VsbCB3aXRoIHRoZWly
IHN5bmNocm9ub3VzIElPIHNwYWNlLCB3aGljaCB3YXMgaXRzZWxmIGEgcmVtbmFudCBvZgpwcmUt
aGlzdG9yeSB0aGF0IHNob3VsZCBoYXZlIGxvbmcgZGllZC4KCkluIHRoZSBzcGVjaWZpYyBjYXNl
IG9mIFBDSSAoYWdhaW4gSSdtIG5vdCB0YWxraW5nIGFib3V0IHRoZSBnZW5lcmFsCmNhc2Ugb2Yg
cGdwcm90L2lvcmVtYXBfbm9ucG9zdGVkKSwgd2UgaGF2ZSByb3V0aW5lbHkgYmVlbiAidmlvbGF0
aW5nIgp0aGF0IHJ1bGUsIGF0IGxlYXN0IG9uIHRoZSBDUFUgLT4gUENJIEJyaWRnZSBwYXRoICh0
aGUgUENJIGJyaWRnZQppdHNlbGYgdGVuZHMgdG8gcmVzcGVjdCBpdCB0aG91Z2ggSSd2ZSBzZWVu
IGV4Y2VwdGlvbnMpIGZvciBkZWNhZGVzCndpdGhvdXQgYW55IGFkdmVyc2UgZWZmZWN0LgoKSSBk
b24ndCB0aGluayB0aGVyZSdzIG11Y2ggY29kZSAoaWYgYW55KSBvdXQgdGhlcmUgd2hpY2ggYWN0
dWFsbHkKcmVsaWVzIG9uIHRoZSBub24tcG9zdGVkIGNoYXJhY3RlcmlzdGljcyBvZiBJTyBzcGFj
ZS4KCkkgZG9uJ3QgY2FyZSAqdGhhdCogbXVjaCBtaW5kIHlvdSwgd2UgZHJvcHBlZCBJTyBzcGFj
ZSBvbiBQQ0kgd2l0aApQT1dFUjgsIGJ1dCBpdCB3b3VsZCBicmVhayBzdHVmZiBvbiBleGlzdGlu
ZyBvbGRlciBtYWNoaW5lcyBzdWNoIGFzClBvd2VyTWFjcyBmb3Igbm8gZ29vZCByZWFzb24uCgpJ
J2QgcmF0aGVyIHdlIGRvY3VtZW50IHRoYXQgbW1hcCdpbmcgSU8gc3BhY2UgdmlhIHN5c2ZzIGRv
ZXNuJ3QgZnVsbHkKcmVzcGVjdCB0aGUgIm5vbi1wb3N0ZWQiIHNlbWFudGljcyBvZiBJTyBhbmQg
YmUgZG9uZSB3aXRoIGl0LgoKSXMgdGhlcmUgYW55IG90aGVyIHByYWN0aWNhbCB1c2Ugb2Ygbm9u
LXBvc3RlZCBtYXBwaW5ncyA/IENvbmZpZyBzcGFjZQpJIHN1cHBvc2UsIHRob3VnaCBoZXJlIG1v
c3RseSBQQ0kgaG9zdCBicmlkZ2VzIGhhbmRsZSBpdCBieSBkb2luZyBhCnJlYWQgYmFjayBpbiB0
aGUgY29uZmlnIG9wcy4uLgoKQ2hlZXJzLApCZW4uCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
