Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1492044780.7236.87.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Thu, 13 Apr 2017 10:53:00 +1000
In-Reply-To: <20170412224555.GB17774@n2100.armlinux.org.uk>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
 <1492036240.7236.80.camel@kernel.crashing.org>
 <20170412224555.GB17774@n2100.armlinux.org.uk>
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

T24gV2VkLCAyMDE3LTA0LTEyIGF0IDIzOjQ1ICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggd3JvdGU6Cj4gT24gVGh1LCBBcHIgMTMsIDIwMTcgYXQgMDg6MzA6NDBBTSArMTAwMCwgQmVu
amFtaW4gSGVycmVuc2NobWlkdCB3cm90ZToKPiA+IE15IHBvaW50IHdpdGggbm9wb3N0KCkgaXMg
dGhhdCBpdCdzIG5ldmVyIG9rIHRvIHNpbGVudGx5IGRvd25ncmFkZSBpdC4KPiA+IENvZGUgd3Jp
dHRlbiB3aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlcmUgaXMgbm8gcG9zdGluZyB3aWxsIGJl
Cj4gPiAqaW5jb3JyZWN0KiBpZiBwb3N0aW5nIGhhcHBlbnMuIFdlIGRvIGxpdmUgd2l0aCB0aGF0
ICJidWciIHRvZGF5IGluZGVlZAo+ID4gYnV0IG9uY2Ugd2UgaGF2ZSB0aGF0IGFjY2Vzc29ycyB3
ZSBtaWdodCBzdGFydCBncm93aW5nIG1vcmUgY29kZSB0aGF0Cj4gPiByZWxpZXMgb24gdGhlIHNw
ZWNpZmljIGF0dHJpYnV0ZSB0aGF0IHRoaW5ncyBhcmVuJ3QgcG9zdGVkIGFuZCB3aWxsIGJlCj4g
PiB3cm9uZyBvbiBhbGwgdGhlIGFyY2hzIHByb3ZpZGluZyB0aGUgZGVmYXVsdCBpbXBsZW1lbnRh
dGlvbi4KPiA+IAo+ID4gVGhpcyBpcyB3aHkgSSBpbnNpc3QgdGhhdCBwZ3Byb3Rfbm9wb3N0KCkg
aWYgaXQgZXhpc3RzIGdsb2JhbGx5LCBzaG91bGQKPiA+IHJldHVybiBOVUxMIHdoZW4gdGhlIHNl
bWFudGljIGNhbm5vdCBiZSBwcm92aWRlZC4KPiAKPiBOb3cgeW91J3JlIG5vdCB0YWxraW5nIHNl
bnNlLsKgwqBwZ3Byb3Rfbm9wb3N0KCkgZG9lcyBfbm90XyByZXR1cm4gYSBwb2ludGVyLgo+IFlv
dSdyZSB0YWxraW5nIGhlcmUgYXMgaWYgeW91J3JlIHN0aWxsIHRhbGtpbmcgYWJvdXQgaW9yZW1h
cF9ub3Bvc3QoKS4KPiBTbywgSSB0aGluayB5b3UncmUgY29uZnVzZWQuCgpOYWgsIGp1c3QgInR5
cG8iLCBJIG1lYW50IGlvcmVtYXBfbm9wb3N0LgoKPiA+ID4gPiBKdXN0IGxpa2UgdGhlIHByb3Bv
c2VkIGlvcmVtYXBfbm9wb3N0KCksIHBncHJvdF9ub25wb3N0ZWQoKSBpcyBnaXZlbiBhCj4gPiA+
ID4gZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiB0aGF0IHVzZXMgcGdwcm90X25vbmNhY2hlZCgpLsKg
IE1heWJlIHdlIHNob3VsZAo+ID4gPiA+IGFsc28gbWFrZSBwY2lfcmVtYXBfaW9zcGFjZSgpIGZh
aWwgaWYgcGdwcm90X25vbnBvc3RlZCgpIGlzIG5vdCBkZWZpbmVkCj4gPiA+ID4gYnkgdGhlIGFy
Y2hpdGVjdHVyZT8KPiA+IAo+ID4gT3Igd2UgKmRvY3VtZW50KiB0aGF0IG1tYXAgb2YgSU8gc3Bh
Y2UgY2FuIHJlc3VsdCBpbiBzb21ldGhpbmcgdGhhdCBpcwo+ID4gcGFydGlhbGx5IG5vbi1wb3N0
ZWQuCj4gCj4gT2gsIHNvIHdlIF9jYW5fIHByb3ZpZGUgYW4gaW50ZXJmYWNlIHRoYXQgaGFzIHdl
YWtlciBzZW1hbnRpY3MgdGhhbiBpdAo+IHNob3VsZCBwcm92aWRlZCB3ZSBkb2N1bWVudCBpdC4K
PiAKPiBJdCdzIGluc2FuZSB0byBoYXZlIGRpZmZlcmVudCBiZWhhdmlvdXJzIGZyb20gdGhlc2Ug
dHdvIGludGVyZmFjZXMsIHlldAo+IHlvdSBzZWVtIHRvIGhhdmUgc2FpZCBleGFjdGx5IHRoYXQg
aW4geW91ciByZXBseS4KPgo+IEl0J3MgYWN0dWFsbHkgd29yc2UgdGhhbiB0aGF0IC0gd2hhdCB5
b3UndmUganVzdCBzYWlkIGlzIHRoYXQgaXQncyBva2F5Cj4gZm9yIHVzZXJzcGFjZSB0byBtYXAg
SU8gc3BhY2Ugd2l0aCB3ZWFrZXIgc2VtYW50aWNzIHRoYW4gdGhlIFBDSQo+IHNwZWNpZmljYXRp
b24gc3RhdGVzLCBidXQgaXQncyBub3Qgb2theSBmb3Iga2VybmVsIHNwYWNlIHRvIGRvIHRoYXQu
CgpUaGF0IGlzIG5vdCB3aGF0IEknbSBzYXlpbmcuIFdoYXQgSSdtIHNheWluZyBpcyB0aGF0IGl0
J3Mgbm90IG9rIHRvCnByb3ZpZGUgYSBnZW5lcmljIG1hcHBpbmcgYXR0cmlidXRlIHRoYXQgc2ls
ZW50bHkgaGFwcGVucyB0byBiZSB3ZWFrZXIKdGhhbiBkb2N1bWVudGVkIG9uIHNvbWUgYXJjaGl0
ZWN0dXJlcy4KClRoZSBQQ0kgcGFydCBpcyBvcnRob2dvbmFsLiBIb3cgZG8geW91IGhhbmRsZSBQ
Q0kgaW4gYWJzZW5jZSBvZiB0aGF0CmF0dHJpYnV0ZSBpcyBhIHNlcGFyYXRlIHByb2JsZW0gKHdo
aWNoIGlzIHByb2JhYmx5IGEgbWF0dGVyIG9mIGp1c3QKZG9jdW1lbnRpbmcgdGhpbmdzKS4KCkJU
Vy4gSXMgY29uZmlnIHNwYWNlIGFsc28gbm9uLXBvc3RlZCBvbiBJbnRlbCB3aXRoIG1tY29uZmln
ID8gSSBkaWRuJ3QKdGhpbmsgdGhleSBjb3VsZCBkbyBub24gcG9zdGVkIE1NSU8gc3RvcmVzLCBi
dXQgbWF5YmUgSSdtIHdyb25nLgoKPiBFc3BlY2lhbGx5IGFzIHVzZXJzcGFjZSBjYW4ndCBrbm93
IHdoYXQgc2VtYW50aWNzIGl0cyBnb2luZyB0byBlbmQgdXAKPiB3aXRoLCB0aGlzIHNlZW1zIHRv
IGJlIGEgdmVyeSBzdHJhbmdlIHN0YW5jZSB0byB0YWtlLgoKVGhhdCdzIHdoeSB3ZSBkb2N1bWVu
dCB0aGF0IHRoZSB1c2Vyc3BhY2UgaW50ZXJmYWNlIGZvciAqUENJKiBpcwpyZWxheGVkLgoKPiBJ
J2Qgc2F5IHRoYXQgaWYgd2UgY2FuJ3Qgb2ZmZXIgdGhlIG5vLXBvc3RpbmcgYmVoYXZpb3VyIHRo
YXQgUENJCj4gc3BlY2lmaWVzLCB0aGVuIHdlIHNob3VsZG4ndCBiZSBleHBvc2luZyBJTyBtYXBw
aW5ncyB0byB1c2Vyc3BhY2UuCgpJIHN0cm9uZ2x5IGRpc2FncmVlLiBXZSd2ZSBiZWVuIGRvaW5n
IGl0IGZvciBkZWNhZGVzIGFuZCBpdCB3b3JrcwpmaW5lIGluIHByZXR0eSBtdWNoIGFsbCBjYXNl
cy4KCk5vdGUgYWxzbyB0aGF0IHNvbWUgcGxhdGZvcm1zIChpbmNsdWRpbmcgc29tZSBwb3dlcnBj
IGFmYWlrKSBkbyBwcm92aWRlCnRoZSBub24tcG9zdGVkIGJlaGF2aW91ciwgc2ltcGx5IG5vdCBh
cyBhIG1hcHBpbmcgYXR0cmlidXRlLiBJbnRlcm5hbApmYWJyaWNzIGFyZW4ndCBuZWNlc3Nhcmls
eSBkb2luZyBwb3N0ZWQgd3JpdGVzIGFuZCBzb21lIGJyaWRnZXMgd2lsbApob2xkIHRoZSByZXNw
b25zZSBmb3Igbm9uLXBvc3RlZCByZXF1ZXN0cy4KCkFueXdheSwgSSBkb24ndCBvYmplY3QgdG8g
dHJ5aW5nIHRvIGltcHJvdmUgY29tcGxpYW5jZSB3aXRoIHRoZSBzcGVjCm9uIGFyY2ggdGhhdCBo
YXZlIHN1Y2ggYSBtYXBwaW5nIGF0dHJpYnV0ZS4gQnV0IEkgZG8gb2JqZWN0IHRvIGhhdmluZwph
IGdlbmVyaWMgbWFwcGluZyBhdHRyaWJ1dGUgKHRoYXQgaXNuJ3QgZnVuZGFtZW50YWxseSBhIFBD
SSB0aGluZykgdGhhdApzaWxlbnRseSBkb3duZ3JhZGVzIHRvIHNvbWV0aGluZyB3ZWFrZXIuCgpC
ZW4uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
