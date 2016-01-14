Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1452785776.28109.22.camel@redhat.com>
Subject: Re: [PATCH V3 20/21] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
From: Mark Salter <msalter@redhat.com>
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
Date: Thu, 14 Jan 2016 10:36:16 -0500
In-Reply-To: <1452691267-32240-21-git-send-email-tn@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <1452691267-32240-21-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-01-13 at 14:21 +0100, Tomasz Nowicki wrote:
> Some platforms may not be fully compliant with generic set of PCI config
> accessors. For these cases we implement the way to overwrite accessors
> set prior to PCI buses enumeration. Algorithm traverses available quirk
> list, matches against <platform ID (DMI), domain, bus number> tuple and
> returns corresponding accessors. All quirks can be defined using:
> DECLARE_ACPI_MCFG_FIXUP() and keep self contained. Example,
> 
> static const struct dmi_system_id foo_dmi[] = {
>         {
>                 .ident = "<Platform ident string>",
>                 .callback = <handler>,
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "<system vendor>"),
>                         DMI_MATCH(DMI_PRODUCT_NAME, "<product name>"),
>                         DMI_MATCH(DMI_PRODUCT_VERSION, "product version"),
>                 },
>         },
>         { }
> };
> 
> static struct pci_ops foo_ecam_pci_ops = {
>         .map_bus = pci_mcfg_dev_base,
>         .read = foo_ecam_config_read,
>         .write = foo_ecam_config_write,
> };
> DECLARE_ACPI_MCFG_FIXUP(foo_dmi, NULL, &foo_ecam_pci_ops, <domain_nr>, <bus_nr>);
> 
> More custom (non-DMI) matching can be done via an alternative call.
> Note that there is possibility to assign quirk related private data to
> root->sysdata which will be available along read/wriate accessor, example:
> 
> static int boo_match(struct pci_mcfg_fixup *fixup, struct acpi_pci_root *root)
> {
>         return [condition] ? 1 : 0;
> }
> 
> int boo_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>                           int where, int size, u32 *val)
> {
>         struct acpi_pci_root *root = bus->sysdata;
>         struct boo_priv_data *boo_data = root->sysdata;
> 
>         [..]
> }
> 
> static struct pci_ops boo_ecam_pci_ops = {
> 	.map_bus = pci_mcfg_dev_base,
> 	.read = boo_ecam_config_read,
> 	.write = boo_ecam_config_write,
> };
> DECLARE_ACPI_MCFG_FIXUP(NULL, boo_match, &boo_ecam_pci_ops, <domain_nr>, <bus_nr>);
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/mcfg.c               | 33 +++++++++++++++++++++++++++++++--
>  include/acpi/acpi_bus.h           |  1 +
>  include/asm-generic/vmlinux.lds.h |  7 +++++++
>  include/linux/ecam.h              | 18 ++++++++++++++++++
>  4 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
> index dfc2d14..ec5fe7b 100644
> --- a/drivers/acpi/mcfg.c
> +++ b/drivers/acpi/mcfg.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/ecam.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> @@ -34,6 +35,29 @@ int __weak raw_pci_write(unsigned int domain, unsigned int bus,
>  	return PCIBIOS_DEVICE_NOT_FOUND;
>  }
>  
> +extern struct pci_mcfg_fixup __start_acpi_mcfg_fixups[];
> +extern struct pci_mcfg_fixup __end_acpi_mcfg_fixups[];
> +
> +static struct pci_ops *pci_mcfg_check_quirks(struct acpi_pci_root *root)
> +{
> +	struct pci_mcfg_fixup *f;
> +	int bus_num = root->secondary.start;
> +	int domain = root->segment;
> +
> +	/*
> +	 * First match against PCI topology <domain:bus> then use DMI or
> +	 * custom match handler.
> +	 */
> +	for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
> +		if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
> +		    (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
> +		    (f->system ? dmi_check_system(f->system) : 0 ||
> +		     f->match ? f->match(f, root) : 0))
> +			return f->ops;

I think this would be better as:

		    (f->system ? dmi_check_system(f->system) : 1 &&
		     f->match ? f->match(f, root) : 1))
			return f->ops;

Otherwise, one has to call dmi_check_system() from f->match() if
access to root is needed.
  
> +	}
> +	return NULL;
> +}
> +
>  void __iomem *
>  pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
>  {
> @@ -56,10 +80,15 @@ static struct pci_ops default_pci_mcfg_ops = {
>  
>  struct pci_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
>  {
> +	struct pci_ops *pci_mcfg_ops_quirk;
> +
>  	/*
> -	 * TODO: Match against platform specific quirks and return
> -	 * corresponding PCI config space accessor set.
> +	 * Match against platform specific quirks and return corresponding
> +	 * PCI config space accessor set.
>  	 */
> +	pci_mcfg_ops_quirk = pci_mcfg_check_quirks(root);
> +	if (pci_mcfg_ops_quirk)
> +		return pci_mcfg_ops_quirk;
>  
>  	return &default_pci_mcfg_ops;
>  }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ad0a5ff..ea4d2b5 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -554,6 +554,7 @@ struct acpi_pci_root {
>  	struct pci_bus *bus;
>  	u16 segment;
>  	struct resource secondary;	/* downstream bus range */
> +	void *sysdata;
>  
>  	u32 osc_support_set;	/* _OSC state of support bits */
>  	u32 osc_control_set;	/* _OSC state of control bits */
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index c4bd0e2..c93fc97 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -298,6 +298,13 @@
>  		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
>  	}								\
>  									\
> +	/* ACPI MCFG quirks */						\
> +	.acpi_fixup        : AT(ADDR(.acpi_fixup) - LOAD_OFFSET) {	\
> +		VMLINUX_SYMBOL(__start_acpi_mcfg_fixups) = .;		\
> +		*(.acpi_fixup_mcfg)					\
> +		VMLINUX_SYMBOL(__end_acpi_mcfg_fixups) = .;		\
> +	}								\
> +									\
>  	/* Built-in firmware blobs */					\
>  	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
>  		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
> diff --git a/include/linux/ecam.h b/include/linux/ecam.h
> index e0f322e..21215be 100644
> --- a/include/linux/ecam.h
> +++ b/include/linux/ecam.h
> @@ -20,6 +20,24 @@ struct pci_mmcfg_region {
>  	bool hot_added;
>  };
>  
> +struct pci_mcfg_fixup {
> +	const struct dmi_system_id *system;
> +	int (*match)(struct pci_mcfg_fixup *, struct acpi_pci_root *);
> +	struct pci_ops *ops;
> +	int domain;
> +	int bus_num;
> +};
> +
> +#define PCI_MCFG_DOMAIN_ANY	-1
> +#define PCI_MCFG_BUS_ANY	-1
> +
> +/* Designate a routine to fix up buggy MCFG */
> +#define DECLARE_ACPI_MCFG_FIXUP(system, match, ops, dom, bus)		\
> +	static const struct pci_mcfg_fixup __mcfg_fixup_##system##dom##bus\
> +	 __used	__attribute__((__section__(".acpi_fixup_mcfg"),		\
> +				aligned((sizeof(void *))))) =		\
> +	{ system, match, ops, dom, bus };
> +
>  struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
>  struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
>  						   int end, u64 addr);

