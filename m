Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 3 Nov 2015 16:28:14 +0000
From: Liviu.Dudau@arm.com
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
Message-ID: <20151103162814.GR963@e106497-lin.cambridge.arm.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <20151028114940.GL963@e106497-lin.cambridge.arm.com>
 <20151103143214.GD3574@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20151103143214.GD3574@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 03, 2015 at 02:32:14PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Oct 28, 2015 at 11:49:40AM +0000, Liviu.Dudau@arm.com wrote:
> > On Tue, Oct 27, 2015 at 05:38:42PM +0100, Tomasz Nowicki wrote:
> 
> [...]
> 
> > > +static int __init pcibios_assign_resources(void)
> > > +{
> > > +	if (acpi_disabled)
> > > +		return 0;
> > > +
> > > +	pci_assign_unassigned_resources();
> > > +	return 0;
> > 
> > You can change this function into:
> > {
> > 	if (!acpi_disabled)
> > 		pci_assign_unassigned_resources();
> > 
> > 	return 0;
> > }
> > 
> > as the equivalent but shorter form.
> 
> I do not think it is a matter of code style here, it is a matter
> of understanding when and if we want to reassign resources on ACPI
> systems, it is an open question on ARM64 that must be sorted out (ie we
> ignore FW/BARs set-up entirely).

I was reviewing the code here, not doing any technical guidance, I'm
leaving that to you as you are more involved around ACPI.

> 
> > > +}
> > >  /*
> > > - * raw_pci_read/write - Platform-specific PCI config space access.
> > > + * rootfs_initcall comes after subsys_initcall and fs_initcall_sync,
> > > + * so we know acpi scan and PCI_FIXUP_FINAL quirks have both run.
> > >   */
> > > -int raw_pci_read(unsigned int domain, unsigned int bus,
> > > -		  unsigned int devfn, int reg, int len, u32 *val)
> > 
> > What happened with raw_pci_{read,write} ? Why do you remove them?
> > 
> > 
> > > +rootfs_initcall(pcibios_assign_resources);
> > 
> > Would you be so kind and explain to me why you need this initcall?
> > Can you not set the PCI_REASSIGN_ALL_RSRC flag before calling
> > pci_scan_root_bus() ?
> 
> On what basis ? BTW, PCI core code does not assign unassigned resources
> anyway even if that flag is set, so some policy has to be defined here.

I was thinking that ACPI code can do that if they seem to depend on the resources
being assigned during root bus scan. I was not implying that PCI core code enforces
that.

Best regards,
Liviu

> 
> Thanks,
> Lorenzo
> 
> > I haven't focused on ACPI before so I'm a bit hazy on the init order when
> > that is enabled. That being said, I don't like adding in the architecture
> > code initcall hooks just to fix up some dependency orders that could / should
> > be fixed some other way.
> > 
> > > +
> > > +static void __iomem *
> > > +pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
> > >  {
> > > -	return -ENXIO;
> > > +	struct pci_mmcfg_region *cfg;
> > > +
> > > +	cfg = pci_mmconfig_lookup(pci_domain_nr(bus), bus->number);
> > > +	if (cfg && cfg->virt)
> > > +		return cfg->virt +
> > > +			(PCI_MMCFG_BUS_OFFSET(bus->number) | (devfn << 12)) +
> > > +			offset;
> > > +	return NULL;
> > >  }
> > >  
> > > -int raw_pci_write(unsigned int domain, unsigned int bus,
> > > -		unsigned int devfn, int reg, int len, u32 val)
> > > +struct pci_ops pci_root_ops = {
> > > +	.map_bus = pci_mcfg_dev_base,
> > > +	.read = pci_generic_config_read,
> > > +	.write = pci_generic_config_write,
> > > +};
> > > +
> > > +#ifdef CONFIG_PCI_MMCONFIG
> > > +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
> > >  {
> > > -	return -ENXIO;
> > > +	struct pci_mmcfg_region *cfg;
> > > +	struct acpi_pci_root *root;
> > > +	int seg, start, end, err;
> > > +
> > > +	root = ci->root;
> > > +	seg = root->segment;
> > > +	start = root->secondary.start;
> > > +	end = root->secondary.end;
> > > +
> > > +	cfg = pci_mmconfig_lookup(seg, start);
> > > +	if (cfg)
> > > +		return 0;
> > > +
> > > +	cfg = pci_mmconfig_alloc(seg, start, end, root->mcfg_addr);
> > > +	if (!cfg)
> > > +		return -ENOMEM;
> > > +
> > > +	err = pci_mmconfig_inject(cfg);
> > > +	return err;
> > >  }
> > >  
> > > -#ifdef CONFIG_ACPI
> > > +static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci)
> > > +{
> > > +	struct acpi_pci_root *root = ci->root;
> > > +	struct pci_mmcfg_region *cfg;
> > > +
> > > +	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
> > > +	if (cfg)
> > > +		return;
> > > +
> > > +	if (cfg->hot_added)
> > > +		pci_mmconfig_delete(root->segment, root->secondary.start,
> > > +				    root->secondary.end);
> > > +}
> > > +#else
> > > +static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci) { }
> > > +#endif
> > > +
> > > +static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
> > > +{
> > > +	return pci_add_mmconfig_region(ci);
> > > +}
> > > +
> > > +static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
> > > +{
> > > +	pci_remove_mmconfig_region(ci);
> > > +	kfree(ci);
> > > +}
> > > +
> > > +static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> > > +{
> > > +	struct resource_entry *entry, *tmp;
> > > +	int ret;
> > > +
> > > +	ret = acpi_pci_probe_root_resources(ci);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> > > +		struct resource *res = entry->res;
> > > +
> > > +		/*
> > > +		 * Special handling for ARM IO range
> > 
> > There is nothing ARM specific here. It should apply to any memory mapped IO range.
> > 
> > > +		 * TODO: need to move pci_register_io_range() function out
> > > +		 * of drivers/of/address.c for both used by DT and ACPI
> > > +		 */
> > > +		if (res->flags & IORESOURCE_IO) {
> > > +			unsigned long port;
> > > +			int err;
> > > +			resource_size_t length = res->end - res->start;
> > > +
> > > +			err = pci_register_io_range(res->start, length);
> > > +			if (err) {
> > > +				resource_list_destroy_entry(entry);
> > > +				continue;
> > > +			}
> > > +
> > > +			port = pci_address_to_pio(res->start);
> > > +			if (port == (unsigned long)-1) {
> > > +				resource_list_destroy_entry(entry);
> > > +				continue;
> > > +			}
> > > +
> > > +			res->start = port;
> > > +			res->end = res->start + length - 1;
> > > +
> > > +			if (pci_remap_iospace(res, res->start) < 0)
> > > +				resource_list_destroy_entry(entry);
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct acpi_pci_root_ops acpi_pci_root_ops = {
> > > +	.pci_ops = &pci_root_ops,
> > > +	.init_info = pci_acpi_root_init_info,
> > > +	.release_info = pci_acpi_root_release_info,
> > > +	.prepare_resources = pci_acpi_root_prepare_resources,
> > > +};
> > > +
> > >  /* Root bridge scanning */
> > >  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> > >  {
> > > -	/* TODO: Should be revisited when implementing PCI on ACPI */
> > > -	return NULL;
> > > +	int node = acpi_get_node(root->device->handle);
> > > +	int domain = root->segment;
> > > +	int busnum = root->secondary.start;
> > > +	struct acpi_pci_root_info *info;
> > > +	struct pci_bus *bus;
> > > +
> > > +	if (domain && !pci_domains_supported) {
> > > +		pr_warn("PCI %04x:%02x: multiple domains not supported.\n",
> > > +			domain, busnum);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
> > > +	if (!info) {
> > > +		dev_err(&root->device->dev,
> > > +			"pci_bus %04x:%02x: ignored (out of memory)\n",
> > > +			domain, busnum);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
> > > +
> > > +	/* After the PCI-E bus has been walked and all devices discovered,
> > > +	 * configure any settings of the fabric that might be necessary.
> > > +	 */
> > > +	if (bus) {
> > > +		struct pci_bus *child;
> > > +
> > > +		list_for_each_entry(child, &bus->children, node)
> > > +			pcie_bus_configure_settings(child);
> > > +	}
> > > +
> > > +	return bus;
> > >  }
> > >  #endif
> > > -- 
> > > 1.9.1
> > > 
> > 
> > -- 
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ¯\_(ツ)_/¯
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
