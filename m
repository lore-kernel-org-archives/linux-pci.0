Return-Path: <SRS0=4j9z=6G=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=4j9z=6G=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 3 Jul 2017 11:26:19 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Andrew Lunn <andrew@lunn.ch>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Will Deacon <will.deacon@arm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [RFT PATCH v2 29/42] ARM: PCI: Remove pci_fixup_irqs() call for
 bios32 host controllers
Message-ID: <20170703102619.GE19119@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170608141342.2018-30-lorenzo.pieralisi@arm.com>
 <20170701140629.GC8977@red-moon>
 <20170702211950.GD18324@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170702211950.GD18324@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 02, 2017 at 04:19:50PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 01, 2017 at 03:06:30PM +0100, Lorenzo Pieralisi wrote:
> > Hi Bjorn,
> > 
> > On Thu, Jun 08, 2017 at 03:13:29PM +0100, Lorenzo Pieralisi wrote:
> > > Legacy PCI host controllers (ie host controllers that set-up the PCI bus
> > > through the ARM pci_common_init() API) are currently relying on
> > > pci_fixup_irqs() to assign legacy PCI irqs to devices. This is not ideal
> > > in that pci_fixup_irqs() assign IRQs for all PCI devices present in a
> > > given system some of which may well be enabled by the time
> > > pci_fixup_irqs() is called (ie a system with multiple host controllers).
> > > With the introduction of struct pci_host_bridge.(*map_irq) pointer it is
> > > possible to assign IRQs for all devices originating from a PCI host
> > > bridge at probe time; this is implemented through pci_assign_irq() that
> > > relies on the struct pci_host_bridge.map_irq pointer to map IRQ for a
> > > given device.
> > > 
> > > The benefits this brings are twofold:
> > > 
> > > - the IRQ for a device is assigned once at probe time
> > > - the IRQ assignment works also for hotplugged devices
> > > 
> > > Remove pci_fixup_irqs() call from bios32 code and rely on
> > > pci_assign_irq() to carry out the IRQ mapping at device probe
> > > time.
> > > 
> > > The map_irq() and swizzle_irq() struct pci_host_bridge callbacks are
> > > set-up in the struct pci_host_bridge created in the bios32
> > > pcibios_init_hw() function and mach-* code paths (for PCI mach
> > > implementations that require a specific struct hw_pci.(*scan) function
> > > callback).
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Jason Cooper <jason@lakedaemon.net>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > >  arch/arm/kernel/bios32.c    |  4 ++--
> > >  arch/arm/mach-dove/pcie.c   | 18 ++++++++++--------
> > >  arch/arm/mach-iop13xx/pci.c |  2 ++
> > >  arch/arm/mach-orion5x/pci.c | 28 +++++++++++++++-------------
> > >  4 files changed, 29 insertions(+), 23 deletions(-)
> > 
> > As I mentioned to you, this patch is incomplete and needs an upgrade
> > (ie I misread how Orion and the gazillions board file that go with
> > it to map irqs - apologies but it is very hard to untangle).
> > 
> > I am inlining below an incremental patch to be folded in commit:
> > 
> > feaec00e757a ("ARM/PCI: Remove pci_fixup_irqs() call for bios32 host
> > controllers")
> > 
> > in your pci/irq-fixups branch, or if you prefer I can send you the
> > resulting squashed-in patch to replace this one, as you prefer.
> 
> Thanks, I folded this into pci/irq-fixups.  The resulting patch is
> merely this:

Yes that's what I expected, we remove pci_fixup_irqs() and add the
hooks into the host bridge structure that should cover all host
bridges initialized via pci_common_init_dev().

Thanks !
Lorenzo

> commit 16508469c0f3198a63923aaec08efa1c63f5fbcc
> Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Date:   Wed Jun 28 15:14:04 2017 -0500
> 
>     ARM/PCI: Remove pci_fixup_irqs() call for bios32 host controllers
>     
>     Legacy PCI host controllers (ie host controllers that set-up the PCI bus
>     through the ARM pci_common_init() API) are currently relying on
>     pci_fixup_irqs() to assign legacy PCI irqs to devices.  This is not ideal
>     in that pci_fixup_irqs() assigns IRQs for all PCI devices present in a given
>     system some of which may well be enabled by the time pci_fixup_irqs() is
>     called (ie a system with multiple host controllers).  With the introduction
>     of struct pci_host_bridge.(*map_irq) pointer it is possible to assign IRQs
>     for all devices originating from a PCI host bridge at probe time; this is
>     implemented through pci_assign_irq() that relies on the struct
>     pci_host_bridge.map_irq pointer to map IRQ for a given device.
>     
>     The benefits this brings are twofold:
>     
>       - the IRQ for a device is assigned once at probe time
>       - the IRQ assignment works also for hotplugged devices
>     
>     Remove pci_fixup_irqs() call from bios32 code and rely on pci_assign_irq()
>     to carry out the IRQ mapping at device probe time.
>     
>     The map_irq() and swizzle_irq() struct pci_host_bridge callbacks are set-up
>     in the struct pci_host_bridge created in the bios32 pcibios_init_hw()
>     function and mach-* code paths (for PCI mach implementations that require a
>     specific struct hw_pci.(*scan) function callback).
>     
>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     [bhelgaas: folded in fixes from Lorenzo:
>     http://lkml.kernel.org/r/20170701140629.GC8977@red-moon]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: Jason Cooper <jason@lakedaemon.net>
>     Cc: Russell King <linux@armlinux.org.uk>
>     Cc: Andrew Lunn <andrew@lunn.ch>
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 4c7621ac389c..56dc1a3a33b4 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -484,6 +484,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  				break;
>  			}
>  
> +			bridge->map_irq = pcibios_map_irq;
> +			bridge->swizzle_irq = pcibios_swizzle;
> +
>  			if (hw->scan)
>  				ret = hw->scan(nr, bridge);
>  			else {
> @@ -530,8 +533,6 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>  	if (hw->postinit)
>  		hw->postinit();
>  
> -	pci_fixup_irqs(pcibios_swizzle, pcibios_map_irq);
> -
>  	list_for_each_entry(sys, &head, node) {
>  		struct pci_bus *bus = sys->bus;
>  
