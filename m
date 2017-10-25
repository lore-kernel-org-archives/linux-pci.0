Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 25 Oct 2017 12:23:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <jim2101024@gmail.com>
Subject: Re: [PATCH 6/8] PCI: host: brcmstb: add MSI capability
Message-ID: <20171025172310.GN21840@bhelgaas-glaptop.roam.corp.google.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-7-git-send-email-jim2101024@gmail.com>
 <5406ab92-c1da-f6fa-083d-82d1027130ea@gmail.com>
 <CANCKTBvAqu-godc03BiAt+9hxAoWABLVCtBzaA9ZWLJgXnQ3Fg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANCKTBvAqu-godc03BiAt+9hxAoWABLVCtBzaA9ZWLJgXnQ3Fg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux-MIPS <linux-mips@linux-mips.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoph Hellwig <hch@lst.de>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 linux-pci <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
 Gregory Fong <gregory.0xf0@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, Scott Branden <sbranden@broadcom.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ray, Scott, Jon]

On Wed, Oct 25, 2017 at 11:28:07AM -0400, Jim Quinlan wrote:
> On Tue, Oct 24, 2017 at 2:57 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Hi Jim,
> >
> > On 10/24/2017 11:15 AM, Jim Quinlan wrote:
> >> This commit adds MSI to the Broadcom STB PCIe host controller. It does
> >> not add MSIX since that functionality is not in the HW.  The MSI
> >> controller is physically located within the PCIe block, however, there
> >> is no reason why the MSI controller could not be moved elsewhere in
> >> the future.
> >>
> >> Since the internal Brcmstb MSI controller is intertwined with the PCIe
> >> controller, it is not its own platform device but rather part of the
> >> PCIe platform device.
> >>
> >> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> >> ---
> >>  drivers/pci/host/Kconfig           |  12 ++
> >>  drivers/pci/host/Makefile          |   1 +
> >>  drivers/pci/host/pci-brcmstb-msi.c | 318 +++++++++++++++++++++++++++++++++++++
> >>  drivers/pci/host/pci-brcmstb.c     |  72 +++++++--
> >>  drivers/pci/host/pci-brcmstb.h     |  26 +++
> >>  5 files changed, 419 insertions(+), 10 deletions(-)
> >>  create mode 100644 drivers/pci/host/pci-brcmstb-msi.c
> >>
> >> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> >> index b9b4f11..54aa5d2 100644
> >> --- a/drivers/pci/host/Kconfig
> >> +++ b/drivers/pci/host/Kconfig
> >> @@ -228,4 +228,16 @@ config PCI_BRCMSTB
> >>       default ARCH_BRCMSTB || BMIPS_GENERIC
> >>       help
> >>         Adds support for Broadcom Settop Box PCIe host controller.
> >> +       To compile this driver as a module, choose m here.
> >> +
> >> +config PCI_BRCMSTB_MSI
> >> +     bool "Broadcom Brcmstb PCIe MSI support"
> >> +     depends on ARCH_BRCMSTB || BMIPS_GENERIC
> >
> > This could probably be depends on PCI_BRCMSTB, which would imply these
> > two conditions. PCI_BRCMSTB_MSI on its own is probably not very useful
> > without the parent RC driver.
> >
> >> +     depends on OF
> >> +     depends on PCI_MSI
> >> +     default PCI_BRCMSTB
> >> +     help
> >> +       Say Y here if you want to enable MSI support for Broadcom's iProc
> >> +       PCIe controller
> >> +
> >>  endmenu
> >> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> >> index c283321..1026d6f 100644
> >> --- a/drivers/pci/host/Makefile
> >> +++ b/drivers/pci/host/Makefile
> >> @@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> >>  obj-$(CONFIG_VMD) += vmd.o
> >>  obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
> >>  brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
> >> +obj-$(CONFIG_PCI_BRCMSTB_MSI) += pci-brcmstb-msi.o
> >
> > Should we combine this file with the brcmstb-pci.o? There is probably no
> > functional difference, except that pci-brcmstb-msi.ko needs to be loaded
> > first, right?
> > --
> > Florian
> 
> If you look at the pci/host/Kconfig you will see that other drivers
> also have a separate MSI config (eg iproc, altera, xgene) so there is
> precedent.  The reason that pci-brcmstb-msi.c is its own file is
> because it depends on an irq function that is not exported.  That is
> why CONFIG_PCI_BRCMSTB_MSI is bool, and CONFIG_PCI_BRCMSTB is
> tristate.  -- Jim

There is precedent, but that doesn't mean I like it :)
I would strongly prefer one file per driver when possible.

Take iproc for example.  iproc-msi.c is enabled by a Kconfig bool.  It
contains a bunch of code with the only external entry points being
iproc_msi_init() and iproc_msi_exit().  These are only called via
iproc_pcie_bcma_probe() or iproc_pcie_pltfm_probe(), both of which are
tristate.  So iproc-msi.c is only compiled if CONFIG_IPROC_BCMA or
CONFIG_IPROC_PLATFORM are enabled, but all that text is loaded even if
neither module is loaded, which seems suboptimal.

I don't care if you have several config options to enable the BCMA
probe and the platform probe (although these could probably be
replaced in the code by a simple "#ifdef CONFIG_BCMA" and "#ifdef
CONFIG_OF"), and making CONFIG_PCIE_IPROC tristate so it can be a
module makes sense.  But I think it would be better to put all the
code in one file instead of five, and probably remove
CONFIG_PCIE_IPROC_MSI.  Maybe this requires exporting some IRQ
function that currently isn't exported.  But that seems like a simpler
solution than what we currently have.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
