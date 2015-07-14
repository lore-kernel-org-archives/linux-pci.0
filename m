Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33865 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbGNWaT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 18:30:19 -0400
Received: by obre1 with SMTP id e1so15318084obr.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 15:30:19 -0700 (PDT)
Date: Tue, 14 Jul 2015 17:30:13 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org,
	Matt Fleming <matt.fleming@intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 33/42] x86, boot: Add add_pci handler for SETUP_PCI
Message-ID: <20150714223013.GP24416@google.com>
References: <1436300428-21163-1-git-send-email-yinghai@kernel.org>
 <1436300428-21163-34-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436300428-21163-34-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 07, 2015 at 01:20:19PM -0700, Yinghai Lu wrote:
> Let it reserve setup_data, and keep it's own list.

s/it's/its/

> Also clear the hdr.setup_data, as all handler now handle or
> reserve setup_data locally already.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matt Fleming <matt.fleming@intel.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/include/asm/pci.h |  2 ++
>  arch/x86/kernel/setup.c    |  8 ++++++++
>  arch/x86/pci/common.c      | 42 ++++++++++++++++++++++++++++--------------
>  3 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 4625943..7d2468c 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -80,8 +80,10 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
>  
>  #ifdef CONFIG_PCI
>  extern void early_quirks(void);
> +void add_pci(u64 pa_data);
>  #else
>  static inline void early_quirks(void) { }
> +static inline void add_pci(u64 pa_data) { }
>  #endif
>  
>  extern void pci_iommu_alloc(void);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a3b65f1..de0f830 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -440,6 +440,8 @@ static void __init parse_setup_data(void)
>  		pa_next = data->next;
>  		early_memunmap(data, sizeof(*data));
>  
> +		printk(KERN_DEBUG "setup_data type: %d @ %#010llx\n",
> +				data_type, pa_data);
>  		switch (data_type) {
>  		case SETUP_E820_EXT:
>  			parse_e820_ext(pa_data, data_len);
> @@ -447,14 +449,20 @@ static void __init parse_setup_data(void)
>  		case SETUP_DTB:
>  			add_dtb(pa_data);
>  			break;
> +		case SETUP_PCI:
> +			add_pci(pa_data);
> +			break;
>  		case SETUP_EFI:
>  			parse_efi_setup(pa_data, data_len);
>  			break;
>  		default:
> +			pr_warn("Unknown setup_data type: %d @ %#010llx ignored!\n",
> +				data_type, pa_data);
>  			break;
>  		}
>  		pa_data = pa_next;
>  	}
> +	boot_params.hdr.setup_data = 0; /* all done */
>  }
>  
>  static void __init memblock_x86_reserve_range_setup_data(void)
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 8fd6f44..16ace12 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -9,6 +9,7 @@
>  #include <linux/pci-acpi.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> +#include <linux/memblock.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
>  
> @@ -641,31 +642,44 @@ unsigned int pcibios_assign_all_busses(void)
>  	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
>  }
>  
> +static u64 pci_setup_data;
> +void __init add_pci(u64 pa_data)
> +{
> +	struct setup_data *data;
> +
> +	data = early_memremap(pa_data, sizeof(*data));
> +	memblock_reserve(pa_data, sizeof(*data) + data->len);
> +	data->next = pci_setup_data;
> +	pci_setup_data = pa_data;
> +	early_memunmap(data, sizeof(*data));
> +}
> +
>  int pcibios_add_device(struct pci_dev *dev)
>  {
>  	struct setup_data *data;
>  	struct pci_setup_rom *rom;
>  	u64 pa_data;
>  
> -	pa_data = boot_params.hdr.setup_data;
> +	pa_data = pci_setup_data;
>  	while (pa_data) {
>  		data = ioremap(pa_data, sizeof(*rom));
>  		if (!data)
>  			return -ENOMEM;
>  
> -		if (data->type == SETUP_PCI) {
> -			rom = (struct pci_setup_rom *)data;
> -
> -			if ((pci_domain_nr(dev->bus) == rom->segment) &&
> -			    (dev->bus->number == rom->bus) &&
> -			    (PCI_SLOT(dev->devfn) == rom->device) &&
> -			    (PCI_FUNC(dev->devfn) == rom->function) &&
> -			    (dev->vendor == rom->vendor) &&
> -			    (dev->device == rom->devid)) {
> -				dev->rom = pa_data +
> -				      offsetof(struct pci_setup_rom, romdata);
> -				dev->romlen = rom->pcilen;
> -			}
> +		rom = (struct pci_setup_rom *)data;
> +
> +		if ((pci_domain_nr(dev->bus) == rom->segment) &&
> +		    (dev->bus->number == rom->bus) &&
> +		    (PCI_SLOT(dev->devfn) == rom->device) &&
> +		    (PCI_FUNC(dev->devfn) == rom->function) &&
> +		    (dev->vendor == rom->vendor) &&
> +		    (dev->device == rom->devid)) {
> +			dev->rom = pa_data +
> +			      offsetof(struct pci_setup_rom, romdata);
> +			dev->romlen = rom->pcilen;
> +			dev_printk(KERN_DEBUG, &dev->dev, "set rom to [%#010lx, %#010lx] via SETUP_PCI\n",
> +				   (unsigned long)dev->rom,
> +				   (unsigned long)(dev->rom + dev->romlen - 1));

"set ROM to [mem %#010lx-%#010lx] via SETUP_PCI" so it matches the way we
print other MMIO ranges.

>  		}
>  		pa_data = data->next;
>  		iounmap(data);
> -- 
> 1.8.4.5
> 
