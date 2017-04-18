Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 18 Apr 2017 12:03:50 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
Message-ID: <20170418110350.GA1941@red-moon>
References: <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
 <20170412141654.GA17774@n2100.armlinux.org.uk>
 <20170412144109.GB6842@red-moon>
 <1492036240.7236.80.camel@kernel.crashing.org>
 <20170412224555.GB17774@n2100.armlinux.org.uk>
 <1492044780.7236.87.camel@kernel.crashing.org>
 <20170418085732.GA23882@red-moon>
 <1492511808.25766.91.camel@kernel.crashing.org>
MIME-Version: 1.0
In-Reply-To: <1492511808.25766.91.camel@kernel.crashing.org>
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

On Tue, Apr 18, 2017 at 08:36:48PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-18 at 09:57 +0100, Lorenzo Pieralisi wrote:
> > I can add a defined(pgprot_nonposted) to pci_remap_iospace() if that's
> > not too ugly (I suspect Bjorn is thrilled about it :)), that plus
> > the Kconfig option for ioremap_nopost() should complete this series.
> > =

> > int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > {
> > #if defined(PCI_IOBASE) && defined(CONFIG_MMU) && defined(pgprot_nonpos=
ted)
> > =A0=A0=A0=A0=A0=A0=A0=A0unsigned long vaddr =3D (unsigned long)PCI_IOBA=
SE + res->start;
> > =

> > =A0=A0=A0=A0=A0=A0=A0=A0if (!(res->flags & IORESOURCE_IO))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> > =

> > =A0=A0=A0=A0=A0=A0=A0=A0if (res->end > IO_SPACE_LIMIT)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL
> > =A0=A0=A0=A0=A0=A0=A0=A0return ioremap_page_range(vaddr, vaddr + resour=
ce_size(res), phys_addr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pgprot_nonposted(PAGE_KERNEL));
> > #else
> > =A0=A0=A0=A0=A0=A0=A0=A0/* this architecture does not have memory mappe=
d I/O space,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 so this function should never be called =
*/
> > =A0=A0=A0=A0=A0=A0=A0=A0WARN_ONCE(1, "This architecture does not suppor=
t memory mapped I/O\n");
> > =A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> > #endif
> =

> The above would effectively disable mmap'ing of IO space for any
> architecture that doesn't have pgprot_nonposted... so everybody except
> ARM. Thus breaking a number of systems that have been working fine for
> years.

pci_remap_iospace() is used on ARM/ARM64 only AFAICT I do not understand
what I would actually break (and I am not sure at all how well PCI IO
space is tested on ARM/ARM64 machines anyway).

> I fail to see the point....
> =

> I think you are giving the whole non-posted stuff way more importance
> than it deserves. It's originally a kludge Intel did to PCI because it
> well with their synchronous IO space, which was itself a remnant of
> pre-history that should have long died.
> =

> In the specific case of PCI (again I'm not talking about the general
> case of pgprot/ioremap_nonposted), we have routinely been "violating"
> that rule, at least on the CPU -> PCI Bridge path (the PCI bridge
> itself tends to respect it though I've seen exceptions) for decades
> without any adverse effect.
> =

> I don't think there's much code (if any) out there which actually
> relies on the non-posted characteristics of IO space.
> =

> I don't care *that* much mind you, we dropped IO space on PCI with
> POWER8, but it would break stuff on existing older machines such as
> PowerMacs for no good reason.

Again, the change above should not break anything.

> respect the "non-posted" semantics of IO and be done with it.

I can do that too (or leave IO space alone, I do not care either).

> Is there any other practical use of non-posted mappings ? Config space
> I suppose, though here mostly PCI host bridges handle it by doing a
> read back in the config ops...

I started by adding a pci_remap_cfgspace() interface. Bjorn did not
like it to be PCI specific so I made it a generic one. I am not aware
of any other non-posted writes ioremap requirements apart from config
space.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
