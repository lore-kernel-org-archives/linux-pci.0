Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 17 Feb 2016 18:39:30 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V5 09/15] acpi, mcfg: Add default PCI config accessors
 implementation and initial support for related quirks.
Message-ID: <20160217183930.GC11132@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-10-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455630825-27253-10-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 02:53:39PM +0100, Tomasz Nowicki wrote:
> We use generic accessors from access.c by default. However, we already
> know platforms that need special handling while accessing to PCI config
> space. These platforms will need different accessors set matched against
> platform ID, domain, bus touple. Therefore we are going to add (in future)
> DECLARE_ACPI_MCFG_FIXUP which will register platform specific custom
> accessors. For now, we let pci_mcfg_get_ops to take acpi_pci_root structure
> as an arguments and left some space for quirk matching algorithm.

You should not describe the future (because you do not know if/when
that will be implemented), you should describe what the patch does
in its current form.

"This patch implements MCFG based PCI bus operations through MCFG
map function and generic PCI accessors".

> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Duc Dang <dhdang@apm.com>
> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_mcfg.c  | 30 ++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h | 12 ++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 3282f2a..0062257 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -41,6 +41,36 @@ int __weak raw_pci_write(unsigned int domain, unsigned int bus,
>  	return PCIBIOS_DEVICE_NOT_FOUND;
>  }
>  
> +void __iomem *
> +pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
> +{
> +	struct pci_mmcfg_region *cfg;
> +
> +	cfg = pci_mmconfig_lookup(pci_domain_nr(bus), bus->number);
> +	if (cfg && cfg->virt)
> +		return cfg->virt +
> +			(PCI_MMCFG_BUS_OFFSET(bus->number) | (devfn << 12)) +
> +			offset;
> +	return NULL;
> +}
> +
> +/* Default generic PCI config accessors */
> +static struct pci_ops default_pci_mcfg_ops = {
> +	.map_bus = pci_mcfg_dev_base,
> +	.read = pci_generic_config_read,
> +	.write = pci_generic_config_write,
> +};

Nit: s/default_pci_mcfg_ops/pci_mcfg_ops

> +
> +struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> +{
> +	/*
> +	 * TODO: Match against platform specific quirks and return
> +	 * corresponding PCI config space accessor set.
> +	 */

Remove this comment, see above.

> +
> +	return &default_pci_mcfg_ops;

See above.

> +}
> +
>  static void list_add_sorted(struct pci_mmcfg_region *new)
>  {
>  	struct pci_mmcfg_region *cfg;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index b4f87ba9..3dc6a8c 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -141,6 +141,18 @@ extern struct list_head pci_mmcfg_list;
>  #define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
>  #define PCI_MMCFG_OFFSET(bus, devfn)   ((bus) << 20 | (devfn) << 12)
>  
> +#ifdef	CONFIG_PCI_MMCONFIG
> +extern struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root);
> +extern void __iomem *pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn,
> +				       int offset);
> +#else
> +static inline struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> +{ return NULL; }
> +static inline void __iomem *pci_mcfg_dev_base(struct pci_bus *bus,
> +					      unsigned int devfn, int offset)
> +{ return NULL; }
> +#endif
> +
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }

I think it can even be squashed, anyway:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
