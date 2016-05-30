Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51346 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423076AbcE3VdL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 May 2016 17:33:11 -0400
Date: Mon, 30 May 2016 16:33:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
Message-ID: <20160530213305.GA21322@localhost>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 06:33:24PM +0800, Chen Yu wrote:
> Currently there are many people reported that they can not
> do a poweroff nor a suspend to memory on their Mac Pro 11.
> After some investigations it was found that, once the PCI bridge
> 0000:00:1c.0 reassigns its mm windows([mem 0x7fa00000-0x7fbfffff]
> and [mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
> io resource 0x1804 becomes unaccessible immediately, where the
> ACPI Sleep register is located, as a result neither poweroff(S5)
> nor suspend to memory(S3) works.
> 
> I don't know why setting the base/limit of PCI bridge mem resource
> would affect another io resource region, so this quirk just simply
> bypass the assignment of these mm resources on 0000:00:1c.0, by
> resetting the resource flag to 0 before updating the base/limit registers.
> This patch also introduces a new pci fixup phase before the actual bridge
> resource assignment.

Split the new fixup phase into a separate patch.

I'm doubtful about this because we don't understand the root cause.

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
> Tested-by: Cedric Le Goater <clg@kaod.org>
> Tested-by: pkozlov <pkozlov.vrn@gmail.com>
> Tested-by: Zach Norman <zach@nor.mn>
> Tested-by: Pablo Catalina <pablo.catalina@gmail.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/pci/quirks.c              | 25 +++++++++++++++++++++++++
>  drivers/pci/setup-bus.c           |  2 ++
>  include/asm-generic/vmlinux.lds.h |  3 +++
>  include/linux/pci.h               |  4 ++++
>  scripts/mod/modpost.c             |  1 +
>  5 files changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ee72ebe..e347047 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3370,6 +3370,8 @@ extern struct pci_fixup __start_pci_fixups_header[];
>  extern struct pci_fixup __end_pci_fixups_header[];
>  extern struct pci_fixup __start_pci_fixups_final[];
>  extern struct pci_fixup __end_pci_fixups_final[];
> +extern struct pci_fixup __start_pci_fixups_assign[];
> +extern struct pci_fixup __end_pci_fixups_assign[];
>  extern struct pci_fixup __start_pci_fixups_enable[];
>  extern struct pci_fixup __end_pci_fixups_enable[];
>  extern struct pci_fixup __start_pci_fixups_resume[];
> @@ -3405,6 +3407,11 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
>  		end = __end_pci_fixups_final;
>  		break;
>  
> +	case pci_fixup_assign:
> +		start = __start_pci_fixups_assign;
> +		end = __end_pci_fixups_assign;
> +		break;
> +
>  	case pci_fixup_enable:
>  		start = __start_pci_fixups_enable;
>  		end = __end_pci_fixups_enable;
> @@ -4419,3 +4426,21 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
> +
> +/*
> + * On Mac Pro 11, the allocation of pci bridge memory resource
> + * broke ACPI Sleep Type register region.
> + */
> +static void quirk_mac_disable_mmio_bar(struct pci_dev *dev)
> +{
> +	struct resource *b_res;
> +
> +	dev_info(&dev->dev, "[Quirk] Disable mmio on Mac Pro 11\n");
> +	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
> +		return;

Why test for PCI_CLASS_BRIDGE_PCI?  If you do need to test, why is the
test after the dev_info()?

> +	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
> +	b_res[1].flags = 0;
> +	b_res[2].flags = 0;

You're changing the resource flags but not the hardware itself.  I
assume the window is still enabled and still claims address space, so
we don't want to throw away the information about it, because then we
don't know whether downstream devices can work, and we can't safely
assign resources to peers.

> +}
> +DECLARE_PCI_FIXUP_ASSIGN(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_mac_disable_mmio_bar);

Is this device *only* used on the Mac Pro 11?  http://pci-ids.ucs.cz
says "8 Series/C220 Series Chipset Family PCI Express Root Port #1",
which sounds pretty generic.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 55641a3..730d6fd 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1256,6 +1256,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  			additional_io_size  = pci_hotplug_io_size;
>  			additional_mem_size = pci_hotplug_mem_size;
>  		}
> +
> +		pci_fixup_device(pci_fixup_assign, bus->self);
>  		/* Fall through */
>  	default:
>  		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 6a67ab9..3ba05f0 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -283,6 +283,9 @@
>  		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
>  		*(.pci_fixup_final)					\
>  		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
> +		VMLINUX_SYMBOL(__start_pci_fixups_assign) = .;		\
> +		*(.pci_fixup_assign)					\
> +		VMLINUX_SYMBOL(__end_pci_fixups_assign) = .;		\
>  		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
>  		*(.pci_fixup_enable)					\
>  		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b67e4df..14a35bb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1584,6 +1584,7 @@ enum pci_fixup_pass {
>  	pci_fixup_early,	/* Before probing BARs */
>  	pci_fixup_header,	/* After reading configuration header */
>  	pci_fixup_final,	/* Final phase of device fixups */
> +	pci_fixup_assign,	/* Before resource assignment */
>  	pci_fixup_enable,	/* pci_enable_device() time */
>  	pci_fixup_resume,	/* pci_device_resume() */
>  	pci_fixup_suspend,	/* pci_device_suspend() */
> @@ -1644,6 +1645,9 @@ enum pci_fixup_pass {
>  #define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)			\
>  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,			\
>  		hook, vendor, device, PCI_ANY_ID, 0, hook)
> +#define DECLARE_PCI_FIXUP_ASSIGN(vendor, device, hook)			\
> +	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_assign,			\
> +		hook, vendor, device, PCI_ANY_ID, 0, hook)
>  #define DECLARE_PCI_FIXUP_ENABLE(vendor, device, hook)			\
>  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
>  		hook, vendor, device, PCI_ANY_ID, 0, hook)
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 48958d3..248acdb 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -877,6 +877,7 @@ static void check_section(const char *modname, struct elf_info *elf,
>  
>  #define ALL_PCI_INIT_SECTIONS	\
>  	".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
> +	".pci_fixup_assign", \
>  	".pci_fixup_enable", ".pci_fixup_resume", \
>  	".pci_fixup_resume_early", ".pci_fixup_suspend"
>  
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
