Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 18 Apr 2017 09:57:32 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
Message-ID: <20170418085732.GA23882@red-moon>
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
MIME-Version: 1.0
In-Reply-To: <1492044780.7236.87.camel@kernel.crashing.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 10:53:00AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2017-04-12 at 23:45 +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 13, 2017 at 08:30:40AM +1000, Benjamin Herrenschmidt wrote:
> > > My point with nopost() is that it's never ok to silently downgrade it.
> > > Code written with the assumption that there is no posting will be
> > > *incorrect* if posting happens. We do live with that "bug" today inde=
ed
> > > but once we have that accessors we might start growing more code that
> > > relies on the specific attribute that things aren't posted and will be
> > > wrong on all the archs providing the default implementation.
> > > =

> > > This is why I insist that pgprot_nopost() if it exists globally, shou=
ld
> > > return NULL when the semantic cannot be provided.
> > =

> > Now you're not talking sense.=A0=A0pgprot_nopost() does _not_ return a =
pointer.
> > You're talking here as if you're still talking about ioremap_nopost().
> > So, I think you're confused.
> =

> Nah, just "typo", I meant ioremap_nopost.
> =

> > > > > Just like the proposed ioremap_nopost(), pgprot_nonposted() is gi=
ven a
> > > > > default implementation that uses pgprot_noncached().=A0 Maybe we =
should
> > > > > also make pci_remap_iospace() fail if pgprot_nonposted() is not d=
efined
> > > > > by the architecture?
> > > =

> > > Or we *document* that mmap of IO space can result in something that is
> > > partially non-posted.
> > =

> > Oh, so we _can_ provide an interface that has weaker semantics than it
> > should provided we document it.
> > =

> > It's insane to have different behaviours from these two interfaces, yet
> > you seem to have said exactly that in your reply.
> >
> > It's actually worse than that - what you've just said is that it's okay
> > for userspace to map IO space with weaker semantics than the PCI
> > specification states, but it's not okay for kernel space to do that.
> =

> That is not what I'm saying. What I'm saying is that it's not ok to
> provide a generic mapping attribute that silently happens to be weaker
> than documented on some architectures.
> =

> The PCI part is orthogonal. How do you handle PCI in absence of that
> attribute is a separate problem (which is probably a matter of just
> documenting things).

I can add a defined(pgprot_nonposted) to pci_remap_iospace() if that's
not too ugly (I suspect Bjorn is thrilled about it :)), that plus
the Kconfig option for ioremap_nopost() should complete this series.

int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
{
#if defined(PCI_IOBASE) && defined(CONFIG_MMU) && defined(pgprot_nonposted)
	unsigned long vaddr =3D (unsigned long)PCI_IOBASE + res->start;

	if (!(res->flags & IORESOURCE_IO))
		return -EINVAL;

	if (res->end > IO_SPACE_LIMIT)
		return -EINVAL
	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
				  pgprot_nonposted(PAGE_KERNEL));
#else
	/* this architecture does not have memory mapped I/O space,
	   so this function should never be called */
	WARN_ONCE(1, "This architecture does not support memory mapped I/O\n");
	return -ENODEV;
#endif
}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
