Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:44789 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbaE1CbQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 May 2014 22:31:16 -0400
Received: by mail-ig0-f170.google.com with SMTP id uy17so1799684igb.3
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2014 19:31:15 -0700 (PDT)
Date: Tue, 27 May 2014 20:31:12 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Linux PCI mailing list <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Clean up PCI-related Kconfig files with "if" and fix
 "help"
Message-ID: <20140528023112.GK11907@google.com>
References: <alpine.LFD.2.11.1405180401450.13036@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.11.1405180401450.13036@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 18, 2014 at 04:05:06AM -0400, Robert P. J. Day wrote:
> 
> Simplify some of the PCI-related Kconfig files by replacing numerous
> explicit dependencies with "if" wrappers"
> 
>   * PCI
>   * PCIEPORTBUS
>   * PCIEASPM
> 
> and fix some "help" typoes and formatting. None of this should cause
> any functional change.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>   Not compile-tested, but "make menuconfig" tested.
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 893503f..cc48eb4 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -1,24 +1,26 @@
>  #
>  # PCI configuration
>  #
> +
> +if PCI
> +

This looks like good stuff.  Would you mind splitting the help text
cleanups into a separate patch so we have a "no-brainer" typo patch
and a smaller one with the more interesting bits?

I think you have some more changes in mind; I hope they're still
coming.  You mentioned some of these earlier and I added a couple
more:

  - Fold aer/Kconfig.debug into aer/Kconfig
  - Move 'source "drivers/pci/hotplug/Kconfig"' from arch Kconfigs to
    pci/Kconfig
  - Maybe move CONFIG_HOTPLUG_PCI_PCIE to the HOTPLUG_PCI menu?
  - Move 'source "drivers/pci/pcie/Kconfig"" from arch Kconfig to
    pci/Kconfig.  This might require some thought -- my guess is that doing
    this naively will result in adding PCIe code bulk to some arches that
    don't care about PCI at all.  Maybe a new PCIe config symbol selected
    by the arch would be required.
  - arch/x86/kconfig has two "config PCI_MMCONFIG" stanzas; I assume one
    would be sufficient
  - On x86, at least, IOV, PRI, PASID, IO-APIC hotplug, PCI host controller
    drivers, and Support for PCI Hotplug don't appear nested under "PCI
    support", which seems wrong


>  config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
> -	depends on PCI
>  	help
> -	   This allows device drivers to enable MSI (Message Signaled
> -	   Interrupts).  Message Signaled Interrupts enable a device to
> -	   generate an interrupt using an inbound Memory Write on its
> -	   PCI bus instead of asserting a device IRQ pin.
> +	  This allows device drivers to enable MSI (Message Signaled
> +	  Interrupts).  Message Signaled Interrupts enable a device to
> +	  generate an interrupt using an inbound Memory Write on its
> +	  PCI bus instead of asserting a device IRQ pin.
> 
> -	   Use of PCI MSI interrupts can be disabled at kernel boot time
> -	   by using the 'pci=nomsi' option.  This disables MSI for the
> -	   entire system.
> +	  Use of PCI MSI interrupts can be disabled at kernel boot time
> +	  by using the 'pci=nomsi' option.  This disables MSI for the
> +	  entire system.
> 
> -	   If you don't know what to do here, say Y.
> +	  If you don't know what to do here, say Y.
> 
>  config PCI_DEBUG
>  	bool "PCI Debugging"
> -	depends on PCI && DEBUG_KERNEL
> +	depends on DEBUG_KERNEL
>  	help
>  	  Say Y here if you want the PCI core to produce a bunch of debug
>  	  messages to the system log.  Select this if you are having a
> @@ -28,7 +30,6 @@ config PCI_DEBUG
> 
>  config PCI_REALLOC_ENABLE_AUTO
>  	bool "Enable PCI resource re-allocation detection"
> -	depends on PCI
>  	help
>  	  Say Y here if you want the PCI core to detect if PCI resource
>  	  re-allocation needs to be enabled. You can always use pci=realloc=on
> @@ -41,7 +42,6 @@ config PCI_REALLOC_ENABLE_AUTO
> 
>  config PCI_STUB
>  	tristate "PCI Stub driver"
> -	depends on PCI
>  	help
>  	  Say Y or M here if you want be able to reserve a PCI device
>  	  when it is going to be assigned to a guest operating system.
> @@ -50,7 +50,7 @@ config PCI_STUB
> 
>  config XEN_PCIDEV_FRONTEND
>          tristate "Xen PCI Frontend"
> -        depends on PCI && X86 && XEN
> +        depends on X86 && XEN
>          select PCI_XEN
>  	select XEN_XENBUS_FRONTEND
>          default y
> @@ -61,18 +61,17 @@ config XEN_PCIDEV_FRONTEND
>  config HT_IRQ
>  	bool "Interrupts on hypertransport devices"
>  	default y
> -	depends on PCI && X86_LOCAL_APIC && X86_IO_APIC
> +	depends on X86_LOCAL_APIC && X86_IO_APIC
>  	help
> -	   This allows native hypertransport devices to use interrupts.
> +	  This allows native hypertransport devices to use interrupts.
> 
> -	   If unsure say Y.
> +	  If unsure say Y.
> 
>  config PCI_ATS
>  	bool
> 
>  config PCI_IOV
>  	bool "PCI IOV support"
> -	depends on PCI
>  	select PCI_ATS
>  	help
>  	  I/O Virtualization is a PCI feature supported by some devices
> @@ -83,7 +82,6 @@ config PCI_IOV
> 
>  config PCI_PRI
>  	bool "PCI PRI support"
> -	depends on PCI
>  	select PCI_ATS
>  	help
>  	  PRI is the PCI Page Request Interface. It allows PCI devices that are
> @@ -93,7 +91,6 @@ config PCI_PRI
> 
>  config PCI_PASID
>  	bool "PCI PASID support"
> -	depends on PCI
>  	select PCI_ATS
>  	help
>  	  Process Address Space Identifiers (PASIDs) can be used by PCI devices
> @@ -106,7 +103,6 @@ config PCI_PASID
> 
>  config PCI_IOAPIC
>  	bool "PCI IO-APIC hotplug support" if X86
> -	depends on PCI
>  	depends on ACPI
>  	depends on X86_IO_APIC
>  	default !X86
> @@ -116,3 +112,5 @@ config PCI_LABEL
>  	select NLS
> 
>  source "drivers/pci/host/Kconfig"
> +
> +endif # PCI
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index df8caec..334d50d 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -81,7 +81,7 @@ config HOTPLUG_PCI_CPCI_ZT5550
>  	tristate "Ziatech ZT5550 CompactPCI Hotplug driver"
>  	depends on HOTPLUG_PCI_CPCI && X86
>  	help
> -	  Say Y here if you have an Performance Technologies (formerly Intel,
> +	  Say Y here if you have a Performance Technologies (formerly Intel,
>            formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
> 
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 7958e59..4a404f3 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -10,12 +10,14 @@ config PCIEPORTBUS
>  	  Power Management Event support and Virtual Channel support to run
>  	  on PCI Express Ports (Root or Switch).
> 
> +if PCIEPORTBUS
> +
>  #
>  # Include service Kconfig here
>  #
>  config HOTPLUG_PCI_PCIE
>  	bool "PCI Express Hotplug driver"
> -	depends on HOTPLUG_PCI && PCIEPORTBUS
> +	depends on HOTPLUG_PCI
>  	help
>  	  Say Y here if you have a motherboard that supports PCI Express Native
>  	  Hotplug
> @@ -29,7 +31,6 @@ source "drivers/pci/pcie/aer/Kconfig"
>  #
>  config PCIEASPM
>  	bool "PCI Express ASPM control" if EXPERT
> -	depends on PCI && PCIEPORTBUS
>  	default y
>  	help
>  	  This enables OS control over PCI Express ASPM (Active State
> @@ -44,9 +45,11 @@ config PCIEASPM
>  	  /sys/module/pcie_aspm/parameters/policy
> 
>  	  When in doubt, say Y.
> +
> +if PCIEASPM
> +
>  config PCIEASPM_DEBUG
>  	bool "Debug PCI Express ASPM"
> -	depends on PCIEASPM
>  	default n
>  	help
>  	  This enables PCI Express ASPM debug support. It will add per-device
> @@ -55,28 +58,28 @@ config PCIEASPM_DEBUG
>  choice
>  	prompt "Default ASPM policy"
>  	default PCIEASPM_DEFAULT
> -	depends on PCIEASPM
> 
>  config PCIEASPM_DEFAULT
>          bool "BIOS default"
> -	depends on PCIEASPM
>  	help
>  	  Use the BIOS defaults for PCI Express ASPM.
> 
>  config PCIEASPM_POWERSAVE
>          bool "Powersave"
> -	depends on PCIEASPM
>  	help
>  	  Enable PCI Express ASPM L0s and L1 where possible, even if the
>  	  BIOS did not.
> 
>  config PCIEASPM_PERFORMANCE
>          bool "Performance"
> -	depends on PCIEASPM
>  	help
>  	  Disable PCI Express ASPM L0s and L1, even if the BIOS enabled them.
>  endchoice
> 
> +endif # PCIEASPM
> +
>  config PCIE_PME
>  	def_bool y
> -	depends on PCIEPORTBUS && PM_RUNTIME
> +	depends on PM_RUNTIME
> +
> +endif # PCIEPORTBUS
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
