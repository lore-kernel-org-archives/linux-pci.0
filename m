Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Nov 2015 14:15:12 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, robert.richter@caviumnetworks.com,
	Narinder.Dhillon@caviumnetworks.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V1 11/11] arm64, pci, acpi: Support for ACPI based PCI
 hostbridge init
Message-ID: <20151103141512.GC3574@red-moon>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <1445963922-22711-12-git-send-email-tn@semihalf.com>
 <5631180D.2000902@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5631180D.2000902@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 28, 2015 at 02:46:37PM -0400, Sinan Kaya wrote:

[...]

> >-int raw_pci_write(unsigned int domain, unsigned int bus,
> >-		unsigned int devfn, int reg, int len, u32 val)
> >+struct pci_ops pci_root_ops = {
> >+	.map_bus = pci_mcfg_dev_base,
> >+	.read = pci_generic_config_read,
> >+	.write = pci_generic_config_write,
> 
> 
> Can you change these with pci_generic_config_read32 and
> pci_generic_config_write32? We have some targets that can only do 32
> bits PCI config space access.

No.

http://www.spinics.net/lists/linux-pci/msg44869.html

Can you be a bit more specific please ?

Sigh. Looks like we have to start adding platform specific quirks even
before we merged the generic ACPI PCIe host controller implementation.

Lorenzo

> >+};
> >+
> >+#ifdef CONFIG_PCI_MMCONFIG
> >+static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
> >  {
> >-	return -ENXIO;
> >+	struct pci_mmcfg_region *cfg;
> >+	struct acpi_pci_root *root;
> >+	int seg, start, end, err;
> >+
> >+	root = ci->root;
> >+	seg = root->segment;
> >+	start = root->secondary.start;
> >+	end = root->secondary.end;
> >+
> >+	cfg = pci_mmconfig_lookup(seg, start);
> >+	if (cfg)
> >+		return 0;
> >+
> >+	cfg = pci_mmconfig_alloc(seg, start, end, root->mcfg_addr);
> >+	if (!cfg)
> >+		return -ENOMEM;
> >+
> >+	err = pci_mmconfig_inject(cfg);
> >+	return err;
> >  }
> >
> >-#ifdef CONFIG_ACPI
> >+static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci)
> >+{
> >+	struct acpi_pci_root *root = ci->root;
> >+	struct pci_mmcfg_region *cfg;
> >+
> >+	cfg = pci_mmconfig_lookup(root->segment, root->secondary.start);
> >+	if (cfg)
> >+		return;
> >+
> >+	if (cfg->hot_added)
> >+		pci_mmconfig_delete(root->segment, root->secondary.start,
> >+				    root->secondary.end);
> >+}
> >+#else
> >+static int pci_add_mmconfig_region(struct acpi_pci_root_info *ci)
> >+{
> >+	return 0;
> >+}
> >+
> >+static void pci_remove_mmconfig_region(struct acpi_pci_root_info *ci) { }
> >+#endif
> >+
> >+static int pci_acpi_root_init_info(struct acpi_pci_root_info *ci)
> >+{
> >+	return pci_add_mmconfig_region(ci);
> >+}
> >+
> >+static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
> >+{
> >+	pci_remove_mmconfig_region(ci);
> >+	kfree(ci);
> >+}
> >+
> >+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
> >+{
> >+	struct resource_entry *entry, *tmp;
> >+	int ret;
> >+
> >+	ret = acpi_pci_probe_root_resources(ci);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> >+		struct resource *res = entry->res;
> >+
> >+		/*
> >+		 * Special handling for ARM IO range
> >+		 * TODO: need to move pci_register_io_range() function out
> >+		 * of drivers/of/address.c for both used by DT and ACPI
> >+		 */
> >+		if (res->flags & IORESOURCE_IO) {
> >+			unsigned long port;
> >+			int err;
> >+			resource_size_t length = res->end - res->start;
> >+
> >+			err = pci_register_io_range(res->start, length);
> >+			if (err) {
> >+				resource_list_destroy_entry(entry);
> >+				continue;
> >+			}
> >+
> >+			port = pci_address_to_pio(res->start);
> >+			if (port == (unsigned long)-1) {
> >+				resource_list_destroy_entry(entry);
> >+				continue;
> >+			}
> >+
> >+			res->start = port;
> >+			res->end = res->start + length - 1;
> >+
> >+			if (pci_remap_iospace(res, res->start) < 0)
> >+				resource_list_destroy_entry(entry);
> >+		}
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >+static struct acpi_pci_root_ops acpi_pci_root_ops = {
> >+	.pci_ops = &pci_root_ops,
> >+	.init_info = pci_acpi_root_init_info,
> >+	.release_info = pci_acpi_root_release_info,
> >+	.prepare_resources = pci_acpi_root_prepare_resources,
> >+};
> >+
> >  /* Root bridge scanning */
> >  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >  {
> >-	/* TODO: Should be revisited when implementing PCI on ACPI */
> >-	return NULL;
> >+	int node = acpi_get_node(root->device->handle);
> >+	int domain = root->segment;
> >+	int busnum = root->secondary.start;
> >+	struct acpi_pci_root_info *info;
> >+	struct pci_bus *bus;
> >+
> >+	if (domain && !pci_domains_supported) {
> >+		pr_warn("PCI %04x:%02x: multiple domains not supported.\n",
> >+			domain, busnum);
> >+		return NULL;
> >+	}
> >+
> >+	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
> >+	if (!info) {
> >+		dev_err(&root->device->dev,
> >+			"pci_bus %04x:%02x: ignored (out of memory)\n",
> >+			domain, busnum);
> >+		return NULL;
> >+	}
> >+
> >+	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
> >+
> >+	/* After the PCI-E bus has been walked and all devices discovered,
> >+	 * configure any settings of the fabric that might be necessary.
> >+	 */
> >+	if (bus) {
> >+		struct pci_bus *child;
> >+
> >+		list_for_each_entry(child, &bus->children, node)
> >+			pcie_bus_configure_settings(child);
> >+	}
> >+
> >+	return bus;
> >  }
> >  #endif
> >
> 
> -- 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
