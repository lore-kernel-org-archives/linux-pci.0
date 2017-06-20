Return-Path: <SRS0=euK4=5Z=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=euK4=5Z=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 20 Jun 2017 15:44:40 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Will Deacon <will.deacon@arm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Simon Horman <horms@verge.net.au>,
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs()
 usage
Message-ID: <20170620144440.GB11351@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170619231217.GE554@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619231217.GE554@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 19, 2017 at 06:12:17PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 08, 2017 at 03:13:00PM +0100, Lorenzo Pieralisi wrote:
> > v1 -> v2
> > 
> > - Split pci_fixup_irqs() removal in several patches
> > - Embedded pci_register_host_bridge() in pci_scan_root_bus_bridge()
> > - Refactored iproc, faraday and xilinx-nwl host bridges in preparation
> >   for irq fixup removal
> > - Converted all DT PCI host bridge drivers to pci_scan_root_bus_bridge()
> > - Dropped RFC tag
> > - Added devm_pci_alloc_host_bridge() interface
> > - Rebased against v4.12-rc3
> > 
> > v1: http://marc.info/?l=linux-pci&m=149320545522205&w=2
> > 
> > Current pci_fixup_irqs() usage on ARM/ARM64 host controller drivers is
> > flawed in that pci_fixup_irqs() allocates IRQs for all PCI devices present
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
> > By leveraging Matthew Minter's patch series (and its purpose):
> > 
> > http://lkml.kernel.org/r/1445576642-29624-2-git-send-email-matt@masarand.com
> > 
> > this series[1] adds IRQs mapping and swizzling primitives to
> > the struct pci_host_bridge which allows IRQs to be allocated for
> > for a device at probe time with host bridge specific functions,
> > fixing the aforementioned limitations.
> > 
> > Current series remove pci_fixup_irqs() usage on ARM/ARM64; removal
> > can be extended to other architectures provided the IRQs map/swizzle
> > functions are set-up properly in the respective host bridges
> > set-up/probe paths.
> > 
> > Tested on kvmtool with PCI host generic.
> > 
> > [1] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal-v2
> > 
> > Lorenzo Pieralisi (37):
> >   PCI: xilinx-nwl: Remove nwl_pcie_enable_msi() unused bus parameter
> >   drivers: pci: host: iproc: Convert link check to raw PCI config
> >     accessors
> >   drivers: pci: host: ftpci100: convert IRQ masking to raw PCI config
> >     accessors
> >   PCI: Initialize bridge release function at bridge allocation
> >   PCI: Add pci_free_host_bridge interface
> >   PCI: Add devm_pci_alloc_host_bridge() interface
> >   drivers: pci: host: ftpci100: Fix host bridge memory leakage
> >   drivers: pci: host: tegra: Fix host bridge memory leakage
> >   PCI: Introduce pci_scan_root_bus_bridge()
> >   PCI: Make pci_register_host_bridge() PCI core internal
> >   ARM: PCI: bios32: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: designware: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: aardvark: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: rcar: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: iproc: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: versatile: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: altera: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: xilinx: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: xgene: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: host-common: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: rockchip: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: xilinx-nwl: Convert PCI scan API to pci_scan_root_bus_bridge()
> >   PCI: Remove pci_scan_root_bus_msi()
> >   ARM: PCI: Remove pci_fixup_irqs() call for bios32 host controllers
> >   PCI: tegra: Drop pci_fixup_irqs()
> >   PCI: xilinx: Drop pci_fixup_irqs()
> >   PCI: rcar: Drop pci_fixup_irqs()
> >   PCI: iproc: Drop pci_fixup_irqs()
> >   PCI: designware-host: Drop pci_fixup_irqs()
> >   PCI: ftpci100: Drop pci_fixup_irqs()
> >   PCI: host-common: Drop pci_fixup_irqs()
> >   PCI: versatile: Drop pci_fixup_irqs()
> >   PCI: altera: Drop pci_fixup_irqs()
> >   PCI: xgene: Move to struct pci_host_bridge IRQ mapping functions
> >   PCI: rockchip: Move to struct pci_host_bridge IRQ mapping functions
> >   PCI: xilinx-nwl: Move to struct pci_host_bridge IRQ mapping functions
> >   ARM64: PCI: Drop DT IRQ allocation from pcibios_alloc_irq()
> > 
> > Matthew Minter (5):
> >   PCI: Build setup-irq.o on all arches
> >   PCI: Add IRQ mapping function pointers to pci_host_bridge struct
> >   PCI: Add pci_assign_irq() function and have pci_fixup_irqs() use it
> >   OF/PCI: Update of_irq_parse_and_map_pci() comment
> >   PCI: Add a call to pci_assign_irq() in pci_device_probe()
> > 
> >  Documentation/driver-model/devres.txt  |   1 +
> >  arch/arm/include/asm/mach/pci.h        |   3 +-
> >  arch/arm/kernel/bios32.c               |  43 +++++++----
> >  arch/arm/mach-dove/pcie.c              |  33 +++++---
> >  arch/arm/mach-iop13xx/pci.c            |  31 +++++---
> >  arch/arm/mach-iop13xx/pci.h            |   3 +-
> >  arch/arm/mach-mv78xx0/pcie.c           |   8 +-
> >  arch/arm/mach-orion5x/common.h         |   3 +-
> >  arch/arm/mach-orion5x/pci.c            |  39 ++++++----
> >  arch/arm64/kernel/pci.c                |  10 +--
> >  drivers/of/of_pci_irq.c                |   3 +-
> >  drivers/pci/Makefile                   |  17 +----
> >  drivers/pci/dwc/pcie-designware-host.c |  43 ++++++-----
> >  drivers/pci/host/pci-aardvark.c        |  21 +++--
> >  drivers/pci/host/pci-ftpci100.c        |  50 +++++++-----
> >  drivers/pci/host/pci-host-common.c     |  27 +++++--
> >  drivers/pci/host/pci-tegra.c           |   9 +--
> >  drivers/pci/host/pci-versatile.c       |  22 +++++-
> >  drivers/pci/host/pci-xgene.c           |  23 ++++--
> >  drivers/pci/host/pcie-altera.c         |  24 ++++--
> >  drivers/pci/host/pcie-iproc-bcma.c     |   7 +-
> >  drivers/pci/host/pcie-iproc-platform.c |   7 +-
> >  drivers/pci/host/pcie-iproc.c          | 135 +++++++++++++++++++++++----------
> >  drivers/pci/host/pcie-rcar.c           |  40 ++++++----
> >  drivers/pci/host/pcie-rockchip.c       |  24 ++++--
> >  drivers/pci/host/pcie-xilinx-nwl.c     |  34 ++++++---
> >  drivers/pci/host/pcie-xilinx.c         |  34 +++++----
> >  drivers/pci/pci-driver.c               |   2 +
> >  drivers/pci/probe.c                    | 105 ++++++++++++++++++-------
> >  drivers/pci/setup-irq.c                |  45 ++++++++---
> >  include/linux/pci.h                    |  12 +--
> >  31 files changed, 565 insertions(+), 293 deletions(-)
> 
> This is awesome!  I put these on pci/enumeration with the acks received so
> far.  I hope we can merge these for v4.13, so please take a look at your
> drivers and test if possible.

Thank you very much Bjorn. Yes it would help me a lot if CC'ed people
can help me test it (and also Matt's patch [PATCH 26] reworked
pci_fixup_irqs() on top of struct pci_host_bridge hooks so even if they
should not be affected all arches other than ARM/ARM64 should be tested
too - I have not extended the CC list since it is huge already).

Thanks !
Lorenzo
