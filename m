Return-Path: <SRS0=OBGU=7G=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=OBGU=7G=arm.com=lorenzo.pieralisi@kernel.org>
Date: Fri, 4 Aug 2017 16:08:54 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>,
	Paul Burton <paul.burton@imgtec.com>, Rich Felker <dalias@libc.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Henderson <rth@twiddle.net>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Chris Metcalf <cmetcalf@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Matthew Minter <matt@masarand.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: Re: [RFT PATCH 0/9] PCI: Remove pci_fixup_irqs()
Message-ID: <20170804150854.GA14270@red-moon>
References: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
 <20170803213503.GA20308@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170803213503.GA20308@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 04:35:03PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 31, 2017 at 05:37:48PM +0100, Lorenzo Pieralisi wrote:
> > The pci_fixup_irqs() function allocates IRQs for all PCI devices present
> > in a system; those PCI devices possibly belong to different PCI bus trees
> > (and possibly rooted at different host bridges) and may well be enabled
> > (ie probed and bound to a driver) by the time pci_fixup_irqs() is called
> > when probing a given host bridge driver.
> > 
> > Furthermore, current kernel code relying on pci_fixup_irqs() to
> > assign legacy PCI IRQs to devices does not work at all for
> > hotplugged devices in that the code carrying out the IRQ fixup
> > is called at host bridge driver probe time, which just cannot take
> > into account devices hotplugged after system has booted.
> > 
> > The introduction of map/swizzle functions hook in struct pci_host_bridge
> > allows to define per-bridge map/swizzle functions, that can be used at
> > device probe time in PCI core code to allocate IRQs for a given device
> > (through pci_assign_irq()).
> > 
> > This series converts all arches still relying on pci_fixup_irqs() to
> > the new pci_scan_root_bus_bridge() API and consequently remove
> > pci_fixup_irqs() from the kernel in that it is not used anymore.
> > 
> > Compile tested only, I do not have the necessary hardware.
> 
> Yay!  I applied this to pci/irq-fixups for v4.14.
> 
> Huge thanks to both Matthew and Lorenzo for all the hard work it took
> to make this happen!

Thank you (and Matt), I hope this will be enough to prevent people from
using pci_fixup_irqs() from now on :)

I would appreciate help in testing this series - it is a mechanical
change but that does not mean I have not added regressions - hopefully
CC'ed maintainers can help with that and -next exposure too.

Thank you !
Lorenzo

> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Tanmay Inamdar <tinamdar@apm.com>
> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > Cc: Chris Metcalf <cmetcalf@mellanox.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Matthew Minter <matt@masarand.com>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> > 
> > Lorenzo Pieralisi (7):
> >   sh/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ mapping
> >     hooks
> >   alpha/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
> >     mapping hooks
> >   m68k/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
> >     mapping hooks
> >   MIPS/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
> >     mapping hooks
> >   tile/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
> >     mapping hooks
> >   unicore32/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
> >     mapping hooks
> >   sparc/PCI: Replace pci_fixup_irqs() call with PCI host bridge IRQ
> >     mapping hooks
> > 
> > Matthew Minter (2):
> >   sh/PCI: Remove __init optimisations from IRQ mapping functions/data
> >   PCI: Remove pci_fixup_irqs() function
> > 
> >  arch/alpha/kernel/pci.c                 | 27 ++++++++++++++++------
> >  arch/alpha/kernel/sys_nautilus.c        | 31 +++++++++++++++++++++----
> >  arch/m68k/coldfire/pci.c                | 36 +++++++++++++++++++++++++----
> >  arch/mips/pci/pci-legacy.c              | 24 +++++++++++++------
> >  arch/sh/drivers/pci/fixups-cayman.c     |  2 +-
> >  arch/sh/drivers/pci/fixups-dreamcast.c  |  2 +-
> >  arch/sh/drivers/pci/fixups-r7780rp.c    |  2 +-
> >  arch/sh/drivers/pci/fixups-rts7751r2d.c |  6 ++---
> >  arch/sh/drivers/pci/fixups-sdk7780.c    |  4 ++--
> >  arch/sh/drivers/pci/fixups-se7751.c     |  2 +-
> >  arch/sh/drivers/pci/fixups-sh03.c       |  2 +-
> >  arch/sh/drivers/pci/fixups-snapgear.c   |  2 +-
> >  arch/sh/drivers/pci/fixups-titan.c      |  4 ++--
> >  arch/sh/drivers/pci/pci.c               | 41 ++++++++++++++++++++-------------
> >  arch/sh/drivers/pci/pcie-sh7786.c       |  2 +-
> >  arch/sparc/kernel/leon_pci.c            | 24 ++++++++++++++-----
> >  arch/tile/kernel/pci.c                  | 21 +++++++++++++----
> >  arch/tile/kernel/pci_gx.c               | 21 +++++++++++++----
> >  arch/unicore32/kernel/pci.c             | 35 ++++++++++++++++++++++++----
> >  drivers/pci/setup-irq.c                 | 24 -------------------
> >  include/linux/pci.h                     |  2 --
> >  21 files changed, 216 insertions(+), 98 deletions(-)
> > 
> > -- 
> > 2.10.0
> > 
