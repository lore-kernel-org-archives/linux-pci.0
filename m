Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V9 11/11] ARM64/PCI: Support for ACPI based PCI host controller
Date: Fri, 10 Jun 2016 21:55:19 +0200
Message-Id: <1465588519-11334-12-git-send-email-tn@semihalf.com>
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Implement pci_acpi_scan_root and other arch-specific call so that ARM64
can start using ACPI to setup and enumerate PCI buses.

Prior to buses enumeration the pci_acpi_scan_root() implementation looks
for configuration space start address (obtained through ACPI _CBA method or
MCFG interface). If succeed, it uses ECAM library to create new mapping.
Then it attaches generic ECAM ops (pci_generic_ecam_ops) which are used
for accessing configuration space later on.

On ARM64, we need to use generic domains (CONFIG_PCI_DOMAINS_GENERIC).
In order to achieve that for ACPI case implement
acpi_pci_bus_find_domain_nr() body so that it retrieves pci_config_window
structure from bus sysdata and eventually gets domain number from
acpi_pci_root structure.

ACPI requires to run acpi_pci_{add|remove}_bus while new PCI bus is created.
This allows to do some ACPI-specific additional configuration, like
PCI hotplug slot enumeration. In order to fulfill these requirements,
we implement arch-specific pcibios_{add|remove}_bus calls
and call acpi_pci_{add|remove}_bus from there.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig      |   2 +
 arch/arm64/kernel/pci.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a0a691..4806cde 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ACPI_MCFG if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
@@ -96,6 +97,7 @@ config ARM64
 	select OF_EARLY_FLATTREE
 	select OF_NUMA if NUMA && OF
 	select OF_RESERVED_MEM
+	select PCI_ECAM if ACPI
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 328f857..94cd43c 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -18,6 +18,8 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/slab.h>
 
 /*
@@ -100,15 +102,123 @@ EXPORT_SYMBOL(pcibus_to_node);
 
 #ifdef CONFIG_ACPI
 
+struct acpi_pci_generic_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_config_window	*cfg;	/* config space mapping */
+};
+
 int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
 {
+	struct pci_config_window *cfg = bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	return root->segment;
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	if (!acpi_disabled) {
+		struct pci_config_window *cfg = bridge->bus->sysdata;
+		struct acpi_device *adev = to_acpi_device(cfg->parent);
+		ACPI_COMPANION_SET(&bridge->dev, adev);
+	}
+
 	return 0;
 }
 
-/* Root bridge scanning */
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+static struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
+{
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	struct pci_config_window *cfg;
+	struct resource cfgres;
+	unsigned int bsz;
+
+	/* Use address from _CBA if present, otherwise lookup MCFG */
+	if (!root->mcfg_addr)
+		root->mcfg_addr = pci_mcfg_lookup(seg, bus_res);
+
+	if (!root->mcfg_addr) {
+		dev_err(&root->device->dev, "%04x:%pR ECAM region not found\n",
+			seg, bus_res);
+		return NULL;
+	}
+
+	bsz = 1 << pci_generic_ecam_ops.bus_shift;
+	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
+	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
+	cfgres.flags = IORESOURCE_MEM;
+	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
+			      &pci_generic_ecam_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(&root->device->dev, "%04x:%pR error %ld mapping ECAM\n",
+			seg, bus_res, PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+
+/* release_info: free resources allocated by init_info */
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+	pci_ecam_free(ri->cfg);
+	kfree(ri);
+}
+
+static struct acpi_pci_root_ops acpi_pci_root_ops = {
+	.release_info = pci_acpi_generic_release_info,
+};
+
+/* Interface called from ACPI code to setup PCI host controller */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	/* TODO: Should be revisited when implementing PCI on ACPI */
-	return NULL;
+	int node = acpi_get_node(root->device->handle);
+	struct acpi_pci_generic_root_info *ri;
+	struct pci_bus *bus, *child;
+
+	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
+	if (!ri)
+		return NULL;
+
+	ri->cfg = pci_acpi_setup_ecam_mapping(root);
+	if (!ri->cfg) {
+		kfree(ri);
+		return NULL;
+	}
+
+	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
+	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
+				   ri->cfg);
+	if (!bus)
+		return NULL;
+
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
 }
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
 #endif
-- 
1.9.1
