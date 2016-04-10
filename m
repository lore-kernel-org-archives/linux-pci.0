Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54145 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbcDJWRr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 10 Apr 2016 18:17:47 -0400
Date: Sun, 10 Apr 2016 17:17:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jordan_Hargrave@Dell.com
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, jharg93@gmail.com
Subject: Re: [PATCH v3] Create pci slot files for SMBIOS Type 9 entries
Message-ID: <20160410221743.GC5852@localhost>
References: <1455827823254.98505@Dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455827823254.98505@Dell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jordan,

On Thu, Feb 18, 2016 at 08:40:32PM +0000, Jordan_Hargrave@Dell.com wrote:
> The following diff builds on the "[PATCHv3] Save SMBIOS Type 9 System Slots"
> 
> This will create a /sys/bus/pci/slots/XXX file for each Type 9 entry.  This will be \
> used for systemd enumeration of NICs.
> 
> Only build if CONFIG_DMI is set
> 
> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
> ---
>  arch/x86/pci/common.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index eccd4d9..bfa3c85 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -173,6 +173,27 @@ void pcibios_fixup_bus(struct pci_bus *b)
>  
>  void pcibios_add_bus(struct pci_bus *bus)
>  {
> +#ifdef CONFIG_DMI
> +	const struct dmi_device *dmi;
> +	struct dmi_dev_onboard *dslot;
> +	char sname[128];
> +
> +	dmi = NULL;
> +	while ((dmi = dmi_find_device(DMI_DEV_TYPE_DEV_SLOT,
> +				      NULL, dmi)) != NULL) {
> +		dslot = dmi->device_data;
> +		if (dslot->segment == pci_domain_nr(bus) &&
> +		    dslot->bus == bus->number) {
> +			dev_info(&bus->dev, "Found SMBIOS Slot %s\n",
> +				 dslot->dev.name);
> +			snprintf(sname, sizeof(sname), "%s-%d",
> +				 dslot->dev.name,
> +				 dslot->instance);
> +			pci_create_slot(bus, dslot->devfn,
> +					sname, NULL);
> +		}
> +	}
> +#endif

arm64, ia64, and x86 all support CONFIG_DMI, so this would have to be
a bit more generic.

Is there a spec that describes this SMBIOS entry?  It seems to have
segment/bus/devfn, so maybe this should be done on a per-device basis,
not a per-bus basis?

Does this do the same thing ctrl_slot_setup() does with
get_SMBIOS_entry()?  (This is in the cpqphp hotplug driver; I have no
idea if anybody still uses that.)

There's quite a collection of pci_create_slot() callers, and I'd like
to know how this new addition would coexist with the others.  In
particular, what about the one in pciehp?  I think we only expose a
slot name in sysfs if pciehp claims a downstream port, but I'm not
sure that's the right thing.  The slot number might be useful even if
the slot doesn't support hotplug or if hotplug is disabled for some
reason.

>  	acpi_pci_add_bus(bus);
>  }
>  
> -- 
> 2.5.0
> 
> 
> 
> 
> 
> 
>  
> --jordan hargrave
>  Dell Enterprise Linux Engineering  --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
