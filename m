Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Thu, 2 Jun 2016 10:35:00 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com,
	jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V8 9/9] pci, acpi: ARM64 support for ACPI based generic
 PCI host controller
Message-ID: <20160602093500.GA13962@red-moon>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-10-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464621262-26770-10-git-send-email-tn@semihalf.com>
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
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

[...]

> +/* release_info: free resrouces allocated by init_info */

Nit: s/resrouces/resources

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
                ^
Leaking memory -> kfree(ri)

> +	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
> +	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
> +				   ri->cfg);
> +	if (!bus)
> +		return NULL;

Ditto.

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

Technically speaking, this should be introduced in a separate patch;
given that I know it is a temporary plaster and no other architecture will
have to implement it I reckon it is fine to leave it here, I will make
it disappear as fast as I can.

We can argue if it is best to move the ACPI bits into a separate file
(acpi-pci.c), I am fine with keeping DT/ACPI in one file if that's fine
with Catalin and Will.

You can send the fix-ups above in the final pull request which I hope
is nigh.

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +#else
>  static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus) { return -1; }
> +#endif
>  void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
>  #else
>  static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
