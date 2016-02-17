Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 17 Feb 2016 11:00:57 +0000
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
Subject: Re: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
Message-ID: <20160217110057.GA9794@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455630825-27253-2-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 02:53:31PM +0100, Tomasz Nowicki wrote:
> From: Jayachandran C <jchandra@broadcom.com>
> 
> Move pci_mmcfg_list handling to a drivers/acpi/pci_mcfg.c. This is
> to share the API and code with ARM64 later. The corresponding
> declarations are moved from asm/pci_x86.h to linux/pci-acpi.h
> 
> As a part of this we introduce three functions that can be
> implemented by the arch code: pci_mmconfig_map_resource() to map a
> mcfg entry, pci_mmconfig_unmap_resource to do the corresponding
> unmap and pci_mmconfig_enabled to see if the arch setup of
> mcfg entries was successful. We also provide weak implementations
> of these, which will be used from ARM64. On x86, we retain the
> old logic by providing platform specific implementation.
> 
> This patch is purely rearranging code, it should not have any
> impact on the logic of MCFG parsing or list handling.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> [Xen parts:]
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> ---
>  arch/x86/include/asm/pci_x86.h |  24 +---
>  arch/x86/pci/mmconfig-shared.c | 269 +++++------------------------------
>  arch/x86/pci/mmconfig_32.c     |   1 +
>  arch/x86/pci/mmconfig_64.c     |   1 +
>  arch/x86/pci/numachip.c        |   1 +
>  drivers/acpi/Makefile          |   1 +
>  drivers/acpi/pci_mcfg.c        | 312 +++++++++++++++++++++++++++++++++++++++++
>  drivers/xen/pci.c              |   5 +-
>  include/linux/pci-acpi.h       |  33 +++++
>  9 files changed, 386 insertions(+), 261 deletions(-)
>  create mode 100644 drivers/acpi/pci_mcfg.c

This patch makes perfect sense to me and manages to move MCFG handling
to common code in a seamless manner, it is basically a code move with
weak functions to cater for X86 specific legacy bits which are otherwise
pretty complex to untangle, so (apart from a few nits below):

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[...]

> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> new file mode 100644
> index 0000000..ea84365
> --- /dev/null
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -0,0 +1,312 @@
> +/*
> + * pci_mcfg.c
> + *
> + * Common code to maintain the MCFG areas and mappings
> + *
> + * This has been extracted from arch/x86/pci/mmconfig-shared.c
> + * and moved here so that other architectures can use this code.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/init.h>
> +#include <linux/dmi.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/sfi_acpi.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/rculist.h>

Nit: while at it order them alphabetically.

> +
> +#define PREFIX	"ACPI: "
> +
> +static DEFINE_MUTEX(pci_mmcfg_lock);
> +LIST_HEAD(pci_mmcfg_list);
> +
> +static void list_add_sorted(struct pci_mmcfg_region *new)
> +{
> +	struct pci_mmcfg_region *cfg;
> +
> +	/* keep list sorted by segment and starting bus number */
> +	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
> +		if (cfg->segment > new->segment ||
> +		    (cfg->segment == new->segment &&
> +		     cfg->start_bus >= new->start_bus)) {
> +			list_add_tail_rcu(&new->list, &cfg->list);
> +			return;
> +		}
> +	}
> +	list_add_tail_rcu(&new->list, &pci_mmcfg_list);
> +}
> +
> +static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
> +						   int end, u64 addr)
> +{
> +	struct pci_mmcfg_region *new;
> +	struct resource *res;
> +
> +	if (addr == 0)
> +		return NULL;
> +
> +	new = kzalloc(sizeof(*new), GFP_KERNEL);
> +	if (!new)
> +		return NULL;
> +
> +	new->address = addr;
> +	new->segment = segment;
> +	new->start_bus = start;
> +	new->end_bus = end;
> +
> +	res = &new->res;
> +	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
> +	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
> +	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +	snprintf(new->name, PCI_MMCFG_RESOURCE_NAME_LEN,
> +		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
> +	res->name = new->name;
> +
> +	return new;
> +}
> +
> +struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
> +							int end, u64 addr)
> +{
> +	struct pci_mmcfg_region *new;
> +
> +	new = pci_mmconfig_alloc(segment, start, end, addr);
> +	if (new) {
> +		mutex_lock(&pci_mmcfg_lock);
> +		list_add_sorted(new);
> +		mutex_unlock(&pci_mmcfg_lock);
> +
> +		pr_info(PREFIX
> +		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
> +		       "(base %#lx)\n",
> +		       segment, start, end, &new->res, (unsigned long)addr);
> +	}
> +
> +	return new;
> +}
> +
> +struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
> +{
> +	struct pci_mmcfg_region *cfg;
> +
> +	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
> +		if (cfg->segment == segment &&
> +		    cfg->start_bus <= bus && bus <= cfg->end_bus)
> +			return cfg;
> +
> +	return NULL;
> +}
> +
> +/*
> + * Map a pci_mmcfg_region, can be overrriden by arch

s/overrriden/overridden/

[...]

> +static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
> +					struct acpi_mcfg_allocation *cfg)
> +{
> +	int year;
> +
> +	if (!config_enabled(CONFIG_X86))
> +		return 0;

This check in generic code may ruffle someone's feathers, I even think we
can run this function safely on ARM64 but to prevent surprises we'd better
keep the X86 check, alternatives like adding a weak function just for a
quirk do not make much sense to me.

Lorenzo

> +
> +	if (cfg->address < 0xFFFFFFFF)
> +		return 0;
> +
> +	if (!strncmp(mcfg->header.oem_id, "SGI", 3))
> +		return 0;
> +
> +	if (mcfg->header.revision >= 1) {
> +		if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) &&
> +		    year >= 2010)
> +			return 0;
> +	}
> +
> +	pr_err(PREFIX "MCFG region for %04x [bus %02x-%02x] at %#llx "
> +	       "is above 4GB, ignored\n", cfg->pci_segment,
> +	       cfg->start_bus_number, cfg->end_bus_number, cfg->address);
> +	return -EINVAL;
> +}
> +
> +static int __init pci_parse_mcfg(struct acpi_table_header *header)
> +{
> +	struct acpi_table_mcfg *mcfg;
> +	struct acpi_mcfg_allocation *cfg_table, *cfg;
> +	unsigned long i;
> +	int entries;
> +
> +	if (!header)
> +		return -EINVAL;
> +
> +	mcfg = (struct acpi_table_mcfg *)header;
> +
> +	/* how many config structures do we have */
> +	entries = 0;
> +	i = header->length - sizeof(struct acpi_table_mcfg);
> +	while (i >= sizeof(struct acpi_mcfg_allocation)) {
> +		entries++;
> +		i -= sizeof(struct acpi_mcfg_allocation);
> +	}
> +	if (entries == 0) {
> +		pr_err(PREFIX "MMCONFIG has no entries\n");
> +		return -ENODEV;
> +	}
> +
> +	cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
> +	for (i = 0; i < entries; i++) {
> +		cfg = &cfg_table[i];
> +		if (acpi_mcfg_check_entry(mcfg, cfg))
> +			return -ENODEV;
> +
> +		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
> +				   cfg->end_bus_number, cfg->address) == NULL) {
> +			pr_warn(PREFIX "no memory for MCFG entries\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int __init pci_mmconfig_parse_table(void)
> +{
> +	return acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
> +}
> +
> +void __weak __init pci_mmcfg_late_init(void)
> +{
> +	int err, n = 0;
> +	struct pci_mmcfg_region *cfg;
> +
> +	err = pci_mmconfig_parse_table();
> +	if (err) {
> +		pr_err(PREFIX " Failed to parse MCFG (%d)\n", err);
> +		return;
> +	}
> +
> +	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> +		pci_mmconfig_map_resource(NULL, cfg);
> +		n++;
> +	}
> +
> +	pr_info(PREFIX " MCFG table loaded %d entries\n", n);
> +}
> diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
> index 7494dbe..97aa9d3 100644
> --- a/drivers/xen/pci.c
> +++ b/drivers/xen/pci.c
> @@ -27,9 +27,6 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/xen/hypercall.h>
>  #include "../pci/pci.h"
> -#ifdef CONFIG_PCI_MMCONFIG
> -#include <asm/pci_x86.h>
> -#endif
>  
>  static bool __read_mostly pci_seg_supported = true;
>  
> @@ -221,7 +218,7 @@ static int __init xen_mcfg_late(void)
>  	if (!xen_initial_domain())
>  		return 0;
>  
> -	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
> +	if (!pci_mmconfig_enabled())
>  		return 0;
>  
>  	if (list_empty(&pci_mmcfg_list))
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 89ab057..e9450ef 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -106,6 +106,39 @@ extern const u8 pci_acpi_dsm_uuid[];
>  #define RESET_DELAY_DSM		0x08
>  #define FUNCTION_DELAY_DSM	0x09
>  
> +/* common API to maintain list of MCFG regions */
> +/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
> +#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
> +
> +struct pci_mmcfg_region {
> +	struct list_head list;
> +	struct resource res;
> +	u64 address;
> +	char __iomem *virt;
> +	u16 segment;
> +	u8 start_bus;
> +	u8 end_bus;
> +	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
> +};
> +
> +extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
> +			       phys_addr_t addr);
> +extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
> +
> +extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
> +extern struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
> +							int end, u64 addr);
> +extern int pci_mmconfig_map_resource(struct device *dev,
> +	struct pci_mmcfg_region *mcfg);
> +extern void pci_mmconfig_unmap_resource(struct pci_mmcfg_region *mcfg);
> +extern int pci_mmconfig_enabled(void);
> +extern int __init pci_mmconfig_parse_table(void);
> +
> +extern struct list_head pci_mmcfg_list;
> +
> +#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
> +#define PCI_MMCFG_OFFSET(bus, devfn)   ((bus) << 20 | (devfn) << 12)
> +
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> -- 
> 1.9.1
> 
