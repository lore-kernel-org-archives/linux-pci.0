Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix v2] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
Date: Sat, 28 Mar 2015 02:35:05 +0100
Message-ID: <29753783.Vd1ACXQxMN@vostro.rjw.lan>
In-Reply-To: <1427267843-18710-1-git-send-email-jiang.liu@linux.intel.com>
References: <1427267843-18710-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 25, 2015 03:17:23 PM Jiang Liu wrote:
> Before commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource
> interfaces to simplify implementation"), arch/x86/pci/acpi.c applies
> following rules when parsing ACPI resources for PCI host bridge:
> 1) Ignore IO port resources defined by acpi_resource_io and
>    acpi_resource_fixed_io, which should be used to define resource
>    for PCI device instead of PCI bridge.
> 2) Accept IOMEM resource defined by acpi_resource_memory24,
>    acpi_resource_memory32 and acpi_resource_fixed_memory32.
>    These IOMEM resources are accepted to workaround some BIOS issue,
>    though they should be ignored. For example, PC Engines APU.1C
>    platform defines PCI host bridge IOMEM resources as:
>                 Memory32Fixed (ReadOnly,
>                     0x000A0000,         // Address Base
>                     0x00020000,         // Address Length
>                     )
>                 Memory32Fixed (ReadOnly,
>                     0x00000000,         // Address Base
>                     0x00000000,         // Address Length
>                     _Y00)
> 3) Accept all IO port and IOMEM resources defined by
>    acpi_resource_address{16,32,64,extended64}, no matter it's marked as
>    ACPI_CONSUMER or ACPI_PRODUCER.
> 
> Commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces
> to simplify implementation") accept all IO port and IOMEM resources
> defined by acpi_resource_io, acpi_resource_fixed_io,
> acpi_resource_memory24, acpi_resource_memory32,
> acpi_resource_fixed_memory32 and
> acpi_resource_address{16,32,64,extended64}, which causes IO port
> resources consumed by host bridge itself are listed in host bridge
> resource list.
> 
> Then commit 63f1789ec716 ("x86/PCI/ACPI: Ignore resources consumed by
> host bridge itself") ignores resources consumed by host bridge itself
> by checking IORESOURCE_WINDOW flag, which accidently removed the
> workaround for BIOS bug in 2) listed above.
> 
> It's really costed us much time to figure out this whole picture.
> So we will refine interface acpi_dev_filter_resource_type as below,
> which should be much easier for maintence:
> 1) Caller specifies IORESOURCE_WINDOW flag to explicitly query resource
>    for bridge(PRODUCER), otherwise it's querying resource for
>    device(CONSUMER).
> 2) Ignore IO port resources defined by acpi_resource_io and
>    acpi_resource_fixed_io if IORESOURCE_WINDOW is specified.
> 3) Accpet IOMEM resource defined by acpi_resource_memory24,
>    acpi_resource_memory32 and acpi_resource_fixed_memory32 to work
>    around BIOS bugs, with comment to state it's workaround for BIOS bug.
> 4) Accept IO port and IOMEM defined by acpi_resource_addressxx if
>    a) IORESOURCE_WINDOW is specified and ACPI_PRODUCER is true
>    b) IORESOURCE_WINDOW is not specified and ACPI_PRODUCER is false
> 
> Currently acpi_dev_filter_resource_type() is only used by ACPI pci
> host bridge and IOAPIC driver, so it shouldn't affect other drivers.
> 
> Sample ACPI table needing the workaround are archived at:
> https://bugzilla.kernel.org/show_bug.cgi?id=94221
> 
> Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
> Reported-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
> Hi Bjorn and Rafael,
> 	Great thanks to you two:) Now I think I have fully understand
> the whole picture and the final code should be much easier for
> understanding and maintenance.

It all makes sense to me, but one minor nit below. ->


> ---
>  arch/x86/pci/acpi.c     |    5 ++---
>  drivers/acpi/resource.c |   38 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index e4695985f9de..8c4b1201f340 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -337,7 +337,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>  	info->bridge = device;
>  	ret = acpi_dev_get_resources(device, list,
>  				     acpi_dev_filter_resource_type_cb,
> -				     (void *)(IORESOURCE_IO | IORESOURCE_MEM));
> +				     (void *)(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_WINDOW));
>  	if (ret < 0)
>  		dev_warn(&device->dev,
>  			 "failed to parse _CRS method, error code %d\n", ret);
> @@ -346,8 +346,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>  			"no IO and memory resources present in _CRS\n");
>  	else
>  		resource_list_for_each_entry_safe(entry, tmp, list) {
> -			if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
> -			    (entry->res->flags & IORESOURCE_DISABLED))
> +			if (entry->res->flags & IORESOURCE_DISABLED)
>  				resource_list_destroy_entry(entry);
>  			else
>  				entry->res->name = info->name;
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 5589a6e2a023..68b44eef67eb 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -567,6 +567,17 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
>  
> +static inline bool acpi_dev_match_producer_consumer(unsigned long types,
> +						    int producer)
> +{
> +	if ((types & IORESOURCE_WINDOW) && producer == ACPI_PRODUCER)
> +		return true;
> +	else if ((types & IORESOURCE_WINDOW) == 0 && producer == ACPI_CONSUMER)
> +		return true;
> +	else
> +		return false;
> +}

-> This can be implemented as

static bool acpi_dev_match_producer_consumer(unsigned long types, int producer)
{
	return ((types & IORESOURCE_WINDOW) && producer == ACPI_PRODUCER) ||
		((types & IORESOURCE_WINDOW) == 0 && producer == ACPI_CONSUMER);
}

(and I dropped the "inline", because it may be better to let the complier decide
whether or not to inline this).


> +
>  /**
>   * acpi_dev_filter_resource_type - Filter ACPI resource according to resource
>   *				   types
> @@ -585,27 +596,46 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
>  	case ACPI_RESOURCE_TYPE_MEMORY24:
>  	case ACPI_RESOURCE_TYPE_MEMORY32:
>  	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +		/*
> +		 * These types of resource descriptor should be used to
> +		 * describe resource consumption instead of resource provision.
> +		 * But some platforms, such as PC Engines APU.1C, reports
> +		 * resource provision by Memory32Fixed(). Please refer to:
> +		 * https://bugzilla.kernel.org/show_bug.cgi?id=94221
> +		 * So accept it no matter IORESOURCE_WINDOW is specified or not.
> +		 */
>  		type = IORESOURCE_MEM;
>  		break;
>  	case ACPI_RESOURCE_TYPE_IO:
>  	case ACPI_RESOURCE_TYPE_FIXED_IO:
> -		type = IORESOURCE_IO;
> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
> +			type = IORESOURCE_IO;
>  		break;
>  	case ACPI_RESOURCE_TYPE_IRQ:
> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
> +			type = IORESOURCE_IRQ;
> +		break;
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> -		type = IORESOURCE_IRQ;
> +		if (acpi_dev_match_producer_consumer(types,
> +				ares->data.extended_irq.producer_consumer))
> +			type = IORESOURCE_IRQ;
>  		break;
>  	case ACPI_RESOURCE_TYPE_DMA:
>  	case ACPI_RESOURCE_TYPE_FIXED_DMA:
> -		type = IORESOURCE_DMA;
> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
> +			type = IORESOURCE_DMA;
>  		break;
>  	case ACPI_RESOURCE_TYPE_GENERIC_REGISTER:
> -		type = IORESOURCE_REG;
> +		if (acpi_dev_match_producer_consumer(types, ACPI_CONSUMER))
> +			type = IORESOURCE_REG;
>  		break;
>  	case ACPI_RESOURCE_TYPE_ADDRESS16:
>  	case ACPI_RESOURCE_TYPE_ADDRESS32:
>  	case ACPI_RESOURCE_TYPE_ADDRESS64:
>  	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
> +		if (!acpi_dev_match_producer_consumer(types,
> +				ares->data.address.producer_consumer))
> +			break;
>  		if (ares->data.address.resource_type == ACPI_MEMORY_RANGE)
>  			type = IORESOURCE_MEM;
>  		else if (ares->data.address.resource_type == ACPI_IO_RANGE)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
