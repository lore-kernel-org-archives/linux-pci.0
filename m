Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbdGMCiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 22:38:12 -0400
Date: Wed, 12 Jul 2017 21:38:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] microblaze/PCI: Remove pcibios_setup_bus_{self/devices}
 dead code
Message-ID: <20170713023808.GB4486@bhelgaas-glaptop.roam.corp.google.com>
References: <20170620130844.11109-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170620130844.11109-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 20, 2017 at 02:08:44PM +0100, Lorenzo Pieralisi wrote:
> commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
> Bridge IP driver") removed pcibios calls to:
> 
> pcibios_setup_bus_self()
> pcibios_setup_bus_devices()
> 
> Given that pcibios_fixup_bus() was the only caller of those functions
> they have now become dead code (along with the functions they were
> calling in turn) so they can be removed.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michal Simek <michal.simek@xilinx.com>

Applied with Michal's ack to pci/misc for v4.14, thanks!

I also removed the "Fixup resources of a PCI<->PCI bridge" comment
since it's no longer applicable.

> ---
> Bjorn, Michal,
> 
> spotted this while reading microblaze code that parses legacy IRQs,
> I am not familiar with microblaze code but as things stand those
> pcibios calls are just unused IIUC.
> 
> Lorenzo
> 
>  arch/microblaze/include/asm/pci.h |   3 -
>  arch/microblaze/pci/pci-common.c  | 131 --------------------------------------
>  2 files changed, 134 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
> index efd4983..114b934 100644
> --- a/arch/microblaze/include/asm/pci.h
> +++ b/arch/microblaze/include/asm/pci.h
> @@ -81,9 +81,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
>  
>  #define HAVE_ARCH_PCI_RESOURCE_TO_USER
>  
> -extern void pcibios_setup_bus_devices(struct pci_bus *bus);
> -extern void pcibios_setup_bus_self(struct pci_bus *bus);
> -
>  /* This part of code was originally in xilinx-pci.h */
>  #ifdef CONFIG_PCI_XILINX
>  extern void __init xilinx_pci_init(void);
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index 404fb38..970b3a7 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -678,138 +678,7 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
>  
> -/* This function tries to figure out if a bridge resource has been initialized
> - * by the firmware or not. It doesn't have to be absolutely bullet proof, but
> - * things go more smoothly when it gets it right. It should covers cases such
> - * as Apple "closed" bridge resources and bare-metal pSeries unassigned bridges
> - */
> -static int pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
> -						 struct resource *res)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(bus);
> -	struct pci_dev *dev = bus->self;
> -	resource_size_t offset;
> -	u16 command;
> -	int i;
> -
> -	/* Job is a bit different between memory and IO */
> -	if (res->flags & IORESOURCE_MEM) {
> -		/* If the BAR is non-0 (res != pci_mem_offset) then it's
> -		 * probably been initialized by somebody
> -		 */
> -		if (res->start != hose->pci_mem_offset)
> -			return 0;
> -
> -		/* The BAR is 0, let's check if memory decoding is enabled on
> -		 * the bridge. If not, we consider it unassigned
> -		 */
> -		pci_read_config_word(dev, PCI_COMMAND, &command);
> -		if ((command & PCI_COMMAND_MEMORY) == 0)
> -			return 1;
> -
> -		/* Memory decoding is enabled and the BAR is 0. If any of
> -		 * the bridge resources covers that starting address (0 then
> -		 * it's good enough for us for memory
> -		 */
> -		for (i = 0; i < 3; i++) {
> -			if ((hose->mem_resources[i].flags & IORESOURCE_MEM) &&
> -			   hose->mem_resources[i].start == hose->pci_mem_offset)
> -				return 0;
> -		}
> -
> -		/* Well, it starts at 0 and we know it will collide so we may as
> -		 * well consider it as unassigned. That covers the Apple case.
> -		 */
> -		return 1;
> -	} else {
> -		/* If the BAR is non-0, then we consider it assigned */
> -		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
> -		if (((res->start - offset) & 0xfffffffful) != 0)
> -			return 0;
> -
> -		/* Here, we are a bit different than memory as typically IO
> -		 * space starting at low addresses -is- valid. What we do
> -		 * instead if that we consider as unassigned anything that
> -		 * doesn't have IO enabled in the PCI command register,
> -		 * and that's it.
> -		 */
> -		pci_read_config_word(dev, PCI_COMMAND, &command);
> -		if (command & PCI_COMMAND_IO)
> -			return 0;
> -
> -		/* It's starting at 0 and IO is disabled in the bridge, consider
> -		 * it unassigned
> -		 */
> -		return 1;
> -	}
> -}
> -
>  /* Fixup resources of a PCI<->PCI bridge */
> -static void pcibios_fixup_bridge(struct pci_bus *bus)
> -{
> -	struct resource *res;
> -	int i;
> -
> -	struct pci_dev *dev = bus->self;
> -
> -	pci_bus_for_each_resource(bus, res, i) {
> -		if (!res)
> -			continue;
> -		if (!res->flags)
> -			continue;
> -		if (i >= 3 && bus->self->transparent)
> -			continue;
> -
> -		pr_debug("PCI:%s Bus rsrc %d %016llx-%016llx [%x] fixup...\n",
> -			 pci_name(dev), i,
> -			 (unsigned long long)res->start,
> -			 (unsigned long long)res->end,
> -			 (unsigned int)res->flags);
> -
> -		/* Try to detect uninitialized P2P bridge resources,
> -		 * and clear them out so they get re-assigned later
> -		 */
> -		if (pcibios_uninitialized_bridge_resource(bus, res)) {
> -			res->flags = 0;
> -			pr_debug("PCI:%s            (unassigned)\n",
> -								pci_name(dev));
> -		} else {
> -			pr_debug("PCI:%s            %016llx-%016llx\n",
> -				 pci_name(dev),
> -				 (unsigned long long)res->start,
> -				 (unsigned long long)res->end);
> -		}
> -	}
> -}
> -
> -void pcibios_setup_bus_self(struct pci_bus *bus)
> -{
> -	/* Fix up the bus resources for P2P bridges */
> -	if (bus->self != NULL)
> -		pcibios_fixup_bridge(bus);
> -}
> -
> -void pcibios_setup_bus_devices(struct pci_bus *bus)
> -{
> -	struct pci_dev *dev;
> -
> -	pr_debug("PCI: Fixup bus devices %d (%s)\n",
> -		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
> -
> -	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		/* Setup OF node pointer in archdata */
> -		dev->dev.of_node = pci_device_to_OF_node(dev);
> -
> -		/* Fixup NUMA node as it may not be setup yet by the generic
> -		 * code and is needed by the DMA init
> -		 */
> -		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
> -
> -		/* Read default IRQs and fixup if necessary */
> -		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> -	}
> -}
> -
>  void pcibios_fixup_bus(struct pci_bus *bus)
>  {
>  	/* nothing to do */
> -- 
> 2.10.0
> 
