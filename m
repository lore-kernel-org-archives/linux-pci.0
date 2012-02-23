Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4F46B1FC.4050002@gmail.com>
Date: Thu, 23 Feb 2012 15:39:08 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 04/12] arm/PCI: remove arch pci_flags definition
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com> <20120223194322.20708.4942.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194322.20708.4942.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 02/23/2012 01:43 PM, Bjorn Helgaas wrote:
> The PCI core provides a pci_flags definition (currently __weak), so drop
> the arm definition in favor of that.
> 
> We EXPORT_SYMBOL(pci_flags) as arm did previously.  I'm dubious about
> this: no other architecture exports it, and I didn't see any modules in
> the tree that reference it.

I think you're right that it doesn't need to be exported.

Rob

> CC: Rob Herring <rob.herring@calxeda.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm/kernel/bios32.c |    2 ++
>  arch/arm/mm/iomap.c      |    3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index f58ba35..f3fd52b 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -525,6 +525,7 @@ void __init pci_common_init(struct hw_pci *hw)
>  
>  	INIT_LIST_HEAD(&hw->buses);
>  
> +	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
>  	if (hw->preinit)
>  		hw->preinit();
>  	pcibios_init_hw(hw);
> @@ -559,6 +560,7 @@ void __init pci_common_init(struct hw_pci *hw)
>  		pci_bus_add_devices(bus);
>  	}
>  }
> +EXPORT_SYMBOL(pci_flags);
>  
>  #ifndef CONFIG_PCI_HOST_ITE8152
>  void pcibios_set_master(struct pci_dev *dev)
> diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
> index e62956e..4614208 100644
> --- a/arch/arm/mm/iomap.c
> +++ b/arch/arm/mm/iomap.c
> @@ -32,9 +32,6 @@ EXPORT_SYMBOL(pcibios_min_io);
>  unsigned long pcibios_min_mem = 0x01000000;
>  EXPORT_SYMBOL(pcibios_min_mem);
>  
> -unsigned int pci_flags = PCI_REASSIGN_ALL_RSRC;
> -EXPORT_SYMBOL(pci_flags);
> -
>  void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
>  {
>  	if ((unsigned long)addr >= VMALLOC_START &&
> 
