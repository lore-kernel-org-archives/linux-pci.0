Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34751 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbDDDEV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 23:04:21 -0400
Received: by igcau2 with SMTP id au2so73461227igc.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2015 20:04:20 -0700 (PDT)
Date: Fri, 3 Apr 2015 22:04:11 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix v3] x86/PCI/ACPI: Fix regression caused by commit
 63f1789ec716
Message-ID: <20150404030411.GG10892@google.com>
References: <1427683243-14355-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427683243-14355-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jiang,

Sorry for my delayed response.  I've been on vacation for a week and am
still trying to catch up.

On Mon, Mar 30, 2015 at 10:40:43AM +0800, Jiang Liu wrote:
> Before commit 593669c2ac0f("Use common ACPI resource interfaces to
> simplify implementation"), arch/x86/pci/acpi.c applies following
> rules when parsing ACPI resources for PCI host bridge:
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
> Commit 593669c2ac0f("Use common ACPI resource interfaces to
> simplify implementation") accept all IO port and IOMEM resources
> defined by acpi_resource_io, acpi_resource_fixed_io,
> acpi_resource_memory24, acpi_resource_memory32,
> acpi_resource_fixed_memory32 and
> acpi_resource_address{16,32,64,extended64}, which causes IO port
> resources consumed by host bridge itself are listed in to host bridge
> resource list.
> 
> Then commit 63f1789ec716("Ignore resources consumed by host bridge
> itself") ignores resources consumed by host bridge itself by checking
> IORESOURCE_WINDOW flag, which accidently removed the workaround in 2)
> above for BIOS bug .

This is probably partly my fault.

I think the ACPI spec intention is that every _CRS resource descriptor
should be interpreted as "Consumer," i.e., as resources consumed by the
device itself, unless it's marked otherwise.  Only the following types can
be marked as "Producer":

  - Word/DWord/QWord/Extended address space descriptors, 
  - Extended interrupt descriptors,
  - GPIO interrupt and I/O connections,
  - I2C/SPI/UART serial bus resource descriptors

With 66528fdd45b0 ("x86/PCI: parse additional host bridge window resource
types"), I made Linux treat Memory24, Memory32, and Memory32Fixed
descriptors in PCI host bridge _CRS as Producers.  I did it because Windows
apparently does that (there are details in
https://bugzilla.kernel.org/show_bug.cgi?id=15817), but I wasn't aware of
any machines that required it.  That was probably a mistake because it
didn't fix anything and it covered up ASL usage errors like what PC Engines
did.

> It's really costed us much time to figure out this whole picture.
> So we refine interface acpi_dev_filter_resource_type as below,
> which should be easier for maintence:
> 1) Caller specifies IORESOURCE_WINDOW flag to explicitly query resource
>    for bridge(PRODUCER), otherwise it's querying resource for
>    device(CONSUMER).

Sounds good to me.

> 2) Ignore IO port resources defined by acpi_resource_io and
>    acpi_resource_fixed_io if IORESOURCE_WINDOW is specified.

Sounds good to me.

> 3) Accpet IOMEM resource defined by acpi_resource_memory24,
>    acpi_resource_memory32 and acpi_resource_fixed_memory32 for BIOS
>    bugs, with comment to state it's workaround for BIOS bug.

I don't like the fact that this is the behavior for all ACPI devices.
Prior to 593669c2ac0f, we had this behavior for PCI host bridges only.
I don't think this is what the spec envisioned, so I don't really like
doing it for all devices.

> 4) Accept IO port and IOMEM defined by acpi_resource_addressxx if
>    a) IORESOURCE_WINDOW is specified and ACPI_PRODUCER is true
>    b) IORESOURCE_WINDOW is not specified and ACPI_PRODUCER is false

Sounds good to me.

> Currently acpi_dev_filter_resource_type() is only used by ACPI pci
> host bridge and IOAPIC driver, so it shouldn't affect other drivers.

We should assume it will eventually be used for all ACPI devices,
shouldn't we?

> Another possible fix is to only ignore IO resource consumed by host
> bridge and keep IOMEM resource consumed by host bridge, please refer to:
> http://www.spinics.net/lists/linux-pci/msg39706.html
> 
> Sample ACPI table are archived at:
> https://bugzilla.kernel.org/show_bug.cgi?id=94221
> 
> V2->V3:
> Refine function acpi_dev_match_producer_consumer() as suggested by Rafael
> 
> Fixes: 63f1789ec716("Ignore resources consumed by host bridge itself")
> Reported-and-Tested-by: Bernhard Thaler <bernhard.thaler@wvnet.at>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/x86/pci/acpi.c     |    5 ++---
>  drivers/acpi/resource.c |   33 +++++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 7 deletions(-)
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
> index 5589a6e2a023..e761a868bdba 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -567,6 +567,12 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
>  
> +static bool acpi_dev_match_producer_consumer(unsigned long types, int producer)
> +{
> +	return ((types & IORESOURCE_WINDOW) && producer == ACPI_PRODUCER) ||
> +		((types & IORESOURCE_WINDOW) == 0 && producer == ACPI_CONSUMER);
> +}
> +
>  /**
>   * acpi_dev_filter_resource_type - Filter ACPI resource according to resource
>   *				   types
> @@ -585,27 +591,46 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
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

I think this means these resources will be accepted regardless of whether
the caller is looking for Consumer or Producer resources.  To preserve the
behavior I added with 66528fdd45b0, we might be forced to do that for PCI
host bridges (or maybe we could just add a quirk for the PC Engines BIOS).

But I don't think it matches the ACPI spec intent, so I'm not sure it's
right to do it for all devices.

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
> -- 
> 1.7.10.4
> 
