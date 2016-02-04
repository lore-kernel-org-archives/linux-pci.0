Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 20/23] pci, acpi: Support for ACPI based generic PCI host controller init
Date: Thu,  4 Feb 2016 18:28:58 +0100
Message-Id: <1454606941-9523-21-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Because of two patch series:
1. Jiang Liu's common interface to support PCI host controller init
2. MMCONFIG refactoring (part of this patch set)
now we can think about generic ACPI based PCI host controller init
implementation out of arch/ directory.

These calls use information from MCFG table (PCI config space regions)
and _CRS method (IO/irq resources) to initialize PCI hostbridge.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/Kconfig    |   7 +++
 drivers/acpi/pci_root.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 183ffa3..1c7f57bd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -346,6 +346,13 @@ config ACPI_PCI_SLOT
 	  i.e., segment/bus/device/function tuples, with physical slots in
 	  the system.  If you are unsure, say N.
 
+config ACPI_PCI_HOST_GENERIC
+	bool
+	help
+	  Select this config option from the architecture Kconfig,
+	  if it is preferred to enable ACPI PCI host controller driver which
+	  has no arch-specific assumptions.
+
 config X86_PM_TIMER
 	bool "Power Management Timer Support" if EXPERT
 	depends on X86
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index cc2c73a..acf0d53 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -532,6 +532,117 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	}
 }
 
+#ifdef CONFIG_ACPI_PCI_HOST_GENERIC
+static void pci_mcfg_release_info(struct acpi_pci_root_info *ci)
+{
+	pci_mmcfg_teardown_map(ci);
+	kfree(ci);
+}
+
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
+{
+	struct list_head *list = &ci->resources;
+	struct acpi_device *device = ci->bridge;
+	struct resource_entry *entry, *tmp;
+	unsigned long flags;
+	int ret;
+
+	flags = IORESOURCE_IO | IORESOURCE_MEM;
+	ret = acpi_dev_get_resources(device, list,
+				     acpi_dev_filter_resource_type_cb,
+				     (void *)flags);
+	if (ret < 0) {
+		dev_warn(&device->dev,
+			 "failed to parse _CRS method, error code %d\n", ret);
+		return ret;
+	} else if (ret == 0)
+		dev_dbg(&device->dev,
+			"no IO and memory resources present in _CRS\n");
+
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		struct resource *res = entry->res;
+
+		if (entry->res->flags & IORESOURCE_DISABLED)
+			resource_list_destroy_entry(entry);
+		else
+			res->name = ci->name;
+
+		if (res->flags & IORESOURCE_IO) {
+			resource_size_t cpu_addr = res->start;
+			resource_size_t pci_addr = cpu_addr - entry->offset;
+			resource_size_t length = resource_size(res);
+			unsigned long port;
+
+			if (pci_register_io_range(cpu_addr, length)) {
+				resource_list_destroy_entry(entry);
+				continue;
+			}
+
+			port = pci_address_to_pio(cpu_addr);
+			if (port == (unsigned long)-1) {
+				resource_list_destroy_entry(entry);
+				continue;
+			}
+
+			res->start = port;
+			res->end = port + length - 1;
+			entry->offset = port - pci_addr;
+
+			if (pci_remap_iospace(res, cpu_addr) < 0)
+				resource_list_destroy_entry(entry);
+		}
+	}
+	return ret;
+}
+
+static struct acpi_pci_root_ops acpi_pci_root_ops = {
+	.init_info = pci_mmcfg_setup_map,
+	.release_info = pci_mcfg_release_info,
+	.prepare_resources = pci_acpi_root_prepare_resources,
+};
+
+/* Root bridge scanning */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	int node = acpi_get_node(root->device->handle);
+	int domain = root->segment;
+	int busnum = root->secondary.start;
+	struct acpi_pci_root_info *info;
+	struct pci_bus *bus, *child;
+
+	if (domain && !pci_domains_supported) {
+		pr_warn("PCI %04x:%02x: multiple domains not supported.\n",
+			domain, busnum);
+		return NULL;
+	}
+
+	info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
+	if (!info) {
+		dev_err(&root->device->dev,
+			"pci_bus %04x:%02x: ignored (out of memory)\n",
+			domain, busnum);
+		return NULL;
+	}
+
+	acpi_pci_root_ops.pci_ops = pci_mcfg_get_ops(root);
+	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, info, root);
+	if (!bus)
+		return NULL;
+
+	pci_bus_claim_resources(bus);
+	pci_assign_unassigned_bus_resources(bus);
+
+	/*
+	 * After the PCI-E bus has been walked and all devices discovered,
+	 * configure any settings of the fabric that might be necessary.
+	 */
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+#endif /* CONFIG_ACPI_PCI_HOST_GENERIC */
+
 static int acpi_pci_root_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used)
 {
-- 
1.9.1

