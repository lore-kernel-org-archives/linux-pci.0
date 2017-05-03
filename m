Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751176AbdECKum (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 May 2017 06:50:42 -0400
Date: Wed, 3 May 2017 11:51:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Ray Jui <rjui@broadcom.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>,
        Russell King <linux@armlinux.org.uk>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Matthew Minter <matt@masarand.com>
Subject: Re: [RFC/RFT PATCH 18/18] ARM/ARM64: PCI: Drop pci_fixup_irqs()
 usage for DT based host controllers
Message-ID: <20170503105130.GD10800@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-19-lorenzo.pieralisi@arm.com>
 <CAK8P3a3dT-PR69LrAc8_9tNkdj+LTztQ0pcJKyAV6DwykyXi4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a3dT-PR69LrAc8_9tNkdj+LTztQ0pcJKyAV6DwykyXi4A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 28, 2017 at 03:05:44PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 26, 2017 at 1:18 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > DT based PCI host controllers are currently relying on
> > pci_fixup_irqs() to assign legacy PCI irqs to devices. This is
> > broken in that pci_fixup_irqs() assign IRQs for all PCI devices
> > present in a given system some of which may well be enabled by
> > the time pci_fixup_irqs() is called (ie a system with multiple
> > host controllers). With the introduction of
> > struct pci_host_bridge.map_irq pointer it is possible to assign IRQs
> > for all devices originating from a PCI host bridge at probe time;
> > this is implemented through pci_assign_irq() that relies on the
> > struct pci_host_bridge.map_irq pointer to map IRQ for a given device.
> >
> > The benefits this brings are twofold:
> >
> > - the IRQ for a device is assigned once at probe time
> > - the IRQ assignment works also for hotplugged devices
> >
> > Remove pci_fixup_irqs() call from all DT based PCI host controller
> > drivers. The map_irq() and swizzle_irq() struct pci_host_bridge callbacks
> > are either set-up in the respective PCI host controller driver or
> > delegated to ARM/ARM64 pcibios_root_bridge_prepare() implementations,
> > where, upon DT probe detection, the functions are set to DT defaults (ie
> > of_irq_parse_and_map_pci() and pci_common_swizzle() respectively.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Nice!
> 
> > +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> > +{
> > +       /*
> > +        * Set-up IRQ mapping/swizzingly functions.
> > +        * If the either function pointer is already set,
> > +        * do not override any of them since it is a host
> > +        * controller specific mapping/swizzling function.
> > +        */
> > +       if (!bridge->map_irq && !bridge->swizzle_irq) {
> > +               struct device *parent = bridge->dev.parent;
> > +               /*
> > +                * If we have a parent pointer with a valid
> > +                * OF node this means we are probing a PCI host
> > +                * controller configured through DT firmware.
> > +                */
> > +               if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node) {
> > +                       bridge->map_irq = of_irq_parse_and_map_pci;
> > +                       bridge->swizzle_irq = pci_common_swizzle;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> 
> I think it would be better to reduce the number of global functions defined
> by common code to be called from PCI core code, and instead use
> additional callback pointers from the pci_host_bridge operations.

Yes but this means duplicating the whole map_irq/swizzle_irq
initialization thing in all DT PCI host controllers, it is getting
quite cumbersome to be frank, we should try to consolidate DT PCI
host controllers code, it is becoming a bit unwieldy to manage and
there is too much code duplication.

> In particular, there are only very few existing users of
> pcibios_root_bridge_prepare() at the moment, so we should
> be able to get rid of those quite easily now.

I could do but please see my comment above.

> > diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> > index 0f39bd2..bc9e36a 100644
> > --- a/drivers/pci/host/pcie-iproc.c
> > +++ b/drivers/pci/host/pcie-iproc.c
> > @@ -1205,7 +1205,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> >         struct device *dev;
> >         int ret;
> >         void *sysdata;
> > -       struct pci_bus *bus, *child;
> > +       struct pci_bus *child;
> > +       struct pci_host_bridge *host;
> >
> >         dev = pcie->dev;
> >
> > @@ -1252,15 +1253,30 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> >         sysdata = pcie;
> >  #endif
> >
> > -       bus = pci_create_root_bus(dev, 0, &iproc_pcie_ops, sysdata, res);
> > -       if (!bus) {
> 
> Could this be a separate patch?

Yes, I can split it from the pci_fixup_irqs() removal.

Thanks,
Lorenzo
