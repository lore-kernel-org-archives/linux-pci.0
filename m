Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jayachandran C <jchandra@broadcom.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v3 2/5] arm64: pci: Add ACPI support
Date: Wed, 16 Dec 2015 15:24:12 +0100
Message-ID: <3216037.gpgqE0G0oj@wuerfel>
In-Reply-To: <1450269755-21420-3-git-send-email-jchandra@broadcom.com>
References: <1450269755-21420-1-git-send-email-jchandra@broadcom.com> <1450269755-21420-3-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 16 December 2015 18:12:32 Jayachandran C wrote:
> @@ -48,9 +49,22 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>         if (pci_has_flag(PCI_PROBE_ONLY))
>                 return 0;
>  
> +#ifdef CONFIG_ACPI
> +       if (acpi_find_root_bridge_handle(dev))
> +               acpi_pci_irq_enable(dev);
> +#endif
> +
>         return pci_enable_resources(dev, mask);
>  }
>  
> +void pcibios_disable_device(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_ACPI
> +       if (acpi_find_root_bridge_handle(dev))
> +               acpi_pci_irq_disable(dev);
> +#endif
> +}
> +

Can you just move this into the PCI core code? Adding more stuff here
just makes it harder to kill off the existing functions.

>  #ifdef CONFIG_ACPI
> -/* Root bridge scanning */
> -struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> +
> +void pcibios_add_bus(struct pci_bus *bus)
> +{
> +       acpi_pci_add_bus(bus);
> +}
> +
> +void pcibios_remove_bus(struct pci_bus *bus)
> +{
> +       acpi_pci_remove_bus(bus);
> +}
> +
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +       /* ACPI root bus is created with NULL parent */
> +       if (!acpi_disabled && bridge->dev.parent == NULL) {
> +               struct pci_bus *b = bridge->bus;
> +               struct acpi_pci_root_info *ci = b->sysdata;
> +
> +               ACPI_COMPANION_SET(&bridge->dev, ci->bridge);
> +               b->domain_nr = ci->root->segment;
> +       }
> +       return 0;
> +}
> +

Same here: these functions are identical for all architectures
that use ACPI, so just move the code into PCI core and be done with
it. This means we can even kill off all pcibios_add_bus and
pcibios_remove_bus completely, and pcibios_root_bridge_prepare
will only be needed for powerpc/pseries.

>  /*
> - * raw_pci_read/write - Platform-specific PCI config space access.
> + * ACPI uses these - leave it to the generic ACPI PCI driver
>   */
> -int raw_pci_read(unsigned int domain, unsigned int bus,
> +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
>                   unsigned int devfn, int reg, int len, u32 *val)
>  {
>         return -ENXIO;
>  }
>  
> -int raw_pci_write(unsigned int domain, unsigned int bus,
> +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
>                 unsigned int devfn, int reg, int len, u32 val)
>  {
>         return -ENXIO;
>  }
>  
> +/*
> + * Provide weak implementations of ACPI PCI hooks needed.
> + * Leave it to the ACPI PCI driver implementation to do it
> + */
> +struct pci_bus *__weak pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
> -       /* TODO: Should be revisited when implementing PCI on ACPI */
>         return NULL;
>  }
> +
> +void __init __weak pci_mmcfg_late_init(void)
> +{
> +}

Please don't add __weak functions in architecture code that you expect
a driver to override. Just call it directly if it's configured and
make sure that it doesn't get called if it's not there. If both the
caller and the callee are in generic code, you can leave the architecture
out of this.

> +static int __init pcibios_assign_resources(void)
> +{
> +       pci_assign_unassigned_resources();
> +       return 0;
> +}
> +
> +fs_initcall(pcibios_assign_resources);

This doesn't work for PCI host drivers in loadable modules.

	Arnd
