Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 7 Jun 2016 21:14:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V8 9/9] pci, acpi: ARM64 support for ACPI based generic
 PCI host controller
Message-ID: <20160608021421.GF4759@localhost>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-10-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1464621262-26770-10-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org,
 Lorenzo.Pieralisi@arm.com, linaro-acpi@lists.linaro.org,
 ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, liudongdong3@huawei.com,
 catalin.marinas@arm.com, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, dhdang@apm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org,
 Suravee.Suthikulpanit@amd.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 05:14:22PM +0200, Tomasz Nowicki wrote:
> This patch implements pci_acpi_scan_root call so that ARM64 can start
> using ACPI to setup and enumerate PCI buses.
> 
> The implementation of pci_acpi_scan_root() looks up config space regions
> through MCFG interface. Then ECAM library is doing a new mapping
> and attach generic ECAM ops which are used for accessing config space.
> 
> On ARM64, ACPI and DT can be enabled together, and in that case
> we need to use generic domains. In order to do that we implement
> ARM64 specific way of retrieving domain number from pci_config_window
> structure.
> 
> Since we enable PCI for ACPI we need to implement raw_pci_{read|write}
> at the same time. ARM64 provides RAW accessors as long as there is
> correlated valid pci_bus structure, but not before.

I think this is important and needs to be spelled out a little more
explicitly using the terms from the ACPI spec so it will make sense to
people like BIOS writers who might be bitten by this.

"raw_pci_read()" is a Linux term that won't mean anything to them.
But they might expect that AML can access PCI config space before the
Linux driver claims the host bridge, and I think you're saying that
will not work.

> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/arm64/Kconfig      |   2 +
>  arch/arm64/kernel/pci.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci.h     |   5 ++
>  3 files changed, 122 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 76747d9..87c48ad 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>  	select ACPI_CCA_REQUIRED if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select ACPI_MCFG if ACPI
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
> @@ -96,6 +97,7 @@ config ARM64
>  	select OF_EARLY_FLATTREE
>  	select OF_NUMA if NUMA && OF
>  	select OF_RESERVED_MEM
> +	select PCI_ECAM if ACPI
>  	select PERF_USE_VMALLOC
>  	select POWER_RESET
>  	select POWER_SUPPLY
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 3663be1..39f2a40 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -17,7 +17,9 @@
>  #include <linux/mm.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
> +#include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/slab.h>
>  
>  /*
> @@ -71,13 +73,21 @@ int pcibios_alloc_irq(struct pci_dev *dev)
>  int raw_pci_read(unsigned int domain, unsigned int bus,
>  		  unsigned int devfn, int reg, int len, u32 *val)
>  {
> -	return -ENXIO;
> +	struct pci_bus *b = pci_find_bus(domain, bus);
> +
> +	if (!b)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return b->ops->read(b, devfn, reg, len, val);
>  }
>  
>  int raw_pci_write(unsigned int domain, unsigned int bus,
>  		unsigned int devfn, int reg, int len, u32 val)
>  {
> -	return -ENXIO;
> +	struct pci_bus *b = pci_find_bus(domain, bus);
> +
> +	if (!b)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return b->ops->write(b, devfn, reg, len, val);
>  }

I think these functions could be under #ifdef ACPI, couldn't they?
I see x86 and ia64 don't do that, and they do call them from non-ACPI
places.  So maybe there'd be no point in doing it differently here.

You could split this out into a separate patch, though, which would be
a nice way to highlight the issue of AML access before pci_root.c
claims the bridge.

>  #ifdef CONFIG_NUMA
> @@ -91,11 +101,111 @@ EXPORT_SYMBOL(pcibus_to_node);
>  #endif
>  
>  #ifdef CONFIG_ACPI
> -/* Root bridge scanning */
> +
> +struct acpi_pci_generic_root_info {
> +	struct acpi_pci_root_info	common;
> +	struct pci_config_window	*cfg;	/* config space mapping */
> +};
> +
> +int acpi_pci_bus_domain_nr(struct pci_bus *bus)
> +{
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +
> +	return root->segment;
> +}
> +
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	if (!acpi_disabled) {
> +		struct pci_config_window *cfg = bridge->bus->sysdata;
> +		struct acpi_device *adev = to_acpi_device(cfg->parent);
> +		ACPI_COMPANION_SET(&bridge->dev, adev);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Lookup the bus range for the domain in MCFG, and set up config space
> + * mapping.
> + */
> +static int pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root,
> +				       struct acpi_pci_generic_root_info *ri)

Maybe return the "struct pci_config_window *" and do the assignment in
the caller?  Then I don't think you'd have to pass in "ri".

> +{
> +	struct resource *bus_res = &root->secondary;
> +	u16 seg = root->segment;
> +	struct pci_config_window *cfg;
> +	struct resource cfgres;
> +	unsigned int bsz;
> +	int err;
> +
> +	err = pci_mcfg_lookup(root);
> +	if (err) {
> +		pr_err("%04x:%pR MCFG region not found\n", seg, bus_res);

dev_err()

> +		return err;
> +	}
> +
> +	bsz = 1 << pci_generic_ecam_ops.bus_shift;
> +	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
> +	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
> +	cfgres.flags = IORESOURCE_MEM;
> +	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
> +			      &pci_generic_ecam_ops);
> +	if (IS_ERR(cfg)) {
> +		pr_err("%04x:%pR error %ld mapping CAM\n", seg, bus_res,
> +		       PTR_ERR(cfg));

dev_err()

> +		return PTR_ERR(cfg);
> +	}
> +
> +	ri->cfg = cfg;
> +	return 0;
> +}
> +
> +/* release_info: free resrouces allocated by init_info */
> +static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> +{
> +	struct acpi_pci_generic_root_info *ri;
> +
> +	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
> +	pci_ecam_free(ri->cfg);
> +	kfree(ri);
> +}
> +
> +static struct acpi_pci_root_ops acpi_pci_root_ops = {
> +	.release_info = pci_acpi_generic_release_info,
> +};
> +
> +/* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  {
> -	/* TODO: Should be revisited when implementing PCI on ACPI */
> -	return NULL;
> +	int node = acpi_get_node(root->device->handle);
> +	struct acpi_pci_generic_root_info *ri;
> +	struct pci_bus *bus, *child;
> +	int err;
> +
> +	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
> +	if (!ri)
> +		return NULL;
> +
> +	err = pci_acpi_setup_ecam_mapping(root, ri);
> +	if (err)
> +		return NULL;
> +
> +	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
> +	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
> +				   ri->cfg);
> +	if (!bus)
> +		return NULL;
> +
> +	pci_bus_size_bridges(bus);
> +	pci_bus_assign_resources(bus);
> +
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);
> +
> +	return bus;
>  }
>  
>  void pcibios_add_bus(struct pci_bus *bus)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9661c85..f66d188 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1390,7 +1390,12 @@ static inline int pci_domain_nr(struct pci_bus *bus)
>  {
>  	return bus->domain_nr;
>  }
> +/* Arch specific ACPI hook to set-up domain number */
> +#ifdef CONFIG_ACPI
> +int acpi_pci_bus_domain_nr(struct pci_bus *bus);
> +#else
>  static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus) { return -1; }
> +#endif
>  void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
>  #else
>  static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
