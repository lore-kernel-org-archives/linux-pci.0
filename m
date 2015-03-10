Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v3 9/9] pci, ecam: Improve naming for ecam.c content and areas where it is used.
Date: Tue, 10 Mar 2015 13:25:13 +0100
Message-Id: <1425990313-27672-1-git-send-email-tomasz.nowicki@linaro.org>
In-Reply-To: <1425987320-15020-10-git-send-email-tomasz.nowicki@linaro.org>
References: <1425987320-15020-10-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit is consequence of making x86 MMCONFIG code available for all
architectures. Current code has old name fashion so for the sake of
making it more understandable and express where it comes from,
we are changing functions/variables/macros etc. name *mmconfig* -> *ecam*

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/pci/acpi.c            |   2 +-
 arch/x86/pci/mmconfig-shared.c |  70 +++++++++---------
 arch/x86/pci/mmconfig_32.c     |  16 ++--
 arch/x86/pci/numachip.c        |   2 +-
 drivers/acpi/mcfg.c            |  22 +++---
 drivers/pci/ecam.c             | 162 ++++++++++++++++++++---------------------
 drivers/xen/pci.c              |   6 +-
 include/linux/ecam.h           |  42 +++++------
 8 files changed, 161 insertions(+), 161 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5dfccef..fa3ef35 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -199,7 +199,7 @@ static int setup_mcfg_map(struct pci_root_info *info, u16 seg, u8 start,
 static void teardown_mcfg_map(struct pci_root_info *info)
 {
 	if (info->mcfg_added) {
-		pci_mmconfig_delete(info->segment, info->start_bus,
+		pci_ecam_delete(info->segment, info->start_bus,
 				    info->end_bus);
 		info->mcfg_added = false;
 	}
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 6dfe614..8f78671 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -30,8 +30,8 @@ static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 
 const struct pci_raw_ops pci_mmcfg = {
-	.read =		pci_mmcfg_read,
-	.write =	pci_mmcfg_write,
+	.read =		pci_ecam_read,
+	.write =	pci_ecam_write,
 };
 
 static u32
@@ -70,7 +70,7 @@ pci_mmconfig_amd_write(int len, void __iomem *addr, u32 value)
 	}
 }
 
-static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_amd_fam10h = {
+static struct pci_ecam_mmio_ops pci_mmcfg_mmio_amd_fam10h = {
 	.read = pci_mmconfig_amd_read,
 	.write = pci_mmconfig_amd_write,
 };
@@ -84,7 +84,7 @@ static const char *__init pci_mmcfg_e7520(void)
 	if (win == 0x0000 || win == 0xf000)
 		return NULL;
 
-	if (pci_mmconfig_add(0, 0, 255, win << 16) == NULL)
+	if (pci_ecam_add(0, 0, 255, win << 16) == NULL)
 		return NULL;
 
 	return "Intel Corporation E7520 Memory Controller Hub";
@@ -128,7 +128,7 @@ static const char *__init pci_mmcfg_intel_945(void)
 	if ((pciexbar & mask) >= 0xf0000000U)
 		return NULL;
 
-	if (pci_mmconfig_add(0, 0, (len >> 20) - 1, pciexbar & mask) == NULL)
+	if (pci_ecam_add(0, 0, (len >> 20) - 1, pciexbar & mask) == NULL)
 		return NULL;
 
 	return "Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub";
@@ -175,13 +175,13 @@ static const char *__init pci_mmcfg_amd_fam10h(void)
 
 	end_bus = (1 << busnbits) - 1;
 	for (i = 0; i < (1 << segnbits); i++)
-		if (pci_mmconfig_add(i, 0, end_bus,
+		if (pci_ecam_add(i, 0, end_bus,
 				     base + (1<<28) * i) == NULL) {
-			free_all_mmcfg();
+			pci_ecam_free_all();
 			return NULL;
 		}
 
-	pci_mmconfig_register_mmio(&pci_mmcfg_mmio_amd_fam10h);
+	pci_ecam_register_mmio(&pci_mmcfg_mmio_amd_fam10h);
 
 	return "AMD Family 10h NB";
 }
@@ -210,7 +210,7 @@ static const char *__init pci_mmcfg_nvidia_mcp55(void)
 	/*
 	 * do check if amd fam10h already took over
 	 */
-	if (!acpi_disabled || !list_empty(&pci_mmcfg_list) || mcp55_checked)
+	if (!acpi_disabled || !list_empty(&pci_ecam_list) || mcp55_checked)
 		return NULL;
 
 	mcp55_checked = true;
@@ -239,7 +239,7 @@ static const char *__init pci_mmcfg_nvidia_mcp55(void)
 		base <<= extcfg_base_lshift;
 		start = (extcfg & extcfg_start_mask) >> extcfg_start_shift;
 		end = start + extcfg_sizebus[size_index] - 1;
-		if (pci_mmconfig_add(0, start, end, base) == NULL)
+		if (pci_ecam_add(0, start, end, base) == NULL)
 			continue;
 		mcp55_mmconf_found++;
 	}
@@ -273,15 +273,15 @@ static const struct pci_mmcfg_hostbridge_probe pci_mmcfg_probes[] __initconst =
 
 static void __init pci_mmcfg_check_end_bus_number(void)
 {
-	struct pci_mmcfg_region *cfg, *cfgx;
+	struct pci_ecam_region *cfg, *cfgx;
 
 	/* Fixup overlaps */
-	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry(cfg, &pci_ecam_list, list) {
 		if (cfg->end_bus < cfg->start_bus)
 			cfg->end_bus = 255;
 
 		/* Don't access the list head ! */
-		if (cfg->list.next == &pci_mmcfg_list)
+		if (cfg->list.next == &pci_ecam_list)
 			break;
 
 		cfgx = list_entry(cfg->list.next, typeof(*cfg), list);
@@ -301,7 +301,7 @@ static int __init pci_mmcfg_check_hostbridge(void)
 	if (!raw_pci_ops)
 		return 0;
 
-	free_all_mmcfg();
+	pci_ecam_free_all();
 
 	for (i = 0; i < ARRAY_SIZE(pci_mmcfg_probes); i++) {
 		bus =  pci_mmcfg_probes[i].bus;
@@ -322,7 +322,7 @@ static int __init pci_mmcfg_check_hostbridge(void)
 	/* some end_bus_number is crazy, fix it */
 	pci_mmcfg_check_end_bus_number();
 
-	return !list_empty(&pci_mmcfg_list);
+	return !list_empty(&pci_ecam_list);
 }
 
 static acpi_status check_mcfg_resource(struct acpi_resource *res, void *data)
@@ -395,7 +395,7 @@ static int is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 typedef int (*check_reserved_t)(u64 start, u64 end, unsigned type);
 
 static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
-				    struct pci_mmcfg_region *cfg,
+				    struct pci_ecam_region *cfg,
 				    struct device *dev, int with_e820)
 {
 	u64 addr = cfg->res.start;
@@ -425,8 +425,8 @@ static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
 		cfg->end_bus = cfg->start_bus + ((size>>20) - 1);
 		num_buses = cfg->end_bus - cfg->start_bus + 1;
 		cfg->res.end = cfg->res.start +
-		    PCI_MMCFG_BUS_OFFSET(num_buses) - 1;
-		snprintf(cfg->name, PCI_MMCFG_RESOURCE_NAME_LEN,
+		    PCI_ECAM_BUS_OFFSET(num_buses) - 1;
+		snprintf(cfg->name, PCI_ECAM_RESOURCE_NAME_LEN,
 			 "PCI MMCONFIG %04x [bus %02x-%02x]",
 			 cfg->segment, cfg->start_bus, cfg->end_bus);
 
@@ -447,7 +447,7 @@ static int __ref is_mmconf_reserved(check_reserved_t is_reserved,
 }
 
 static int __ref pci_mmcfg_check_reserved(struct device *dev,
-		  struct pci_mmcfg_region *cfg, int early)
+		  struct pci_ecam_region *cfg, int early)
 {
 	if (!early && !acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
@@ -484,12 +484,12 @@ static int __ref pci_mmcfg_check_reserved(struct device *dev,
 
 static void __init pci_mmcfg_reject_broken(int early)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
-	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry(cfg, &pci_ecam_list, list) {
 		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
 			pr_info(PREFIX "not using MMCONFIG\n");
-			free_all_mmcfg();
+			pci_ecam_free_all();
 			return;
 		}
 	}
@@ -502,13 +502,13 @@ extern int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
 static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
 				     void *data), void *data)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 	int rc;
 
-	if (list_empty(&pci_mmcfg_list))
+	if (list_empty(&pci_ecam_list))
 		return 0;
 
-	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry(cfg, &pci_ecam_list, list) {
 		rc = func(cfg->res.start, resource_size(&cfg->res), data);
 		if (rc)
 			return rc;
@@ -524,24 +524,24 @@ static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
 static void __init __pci_mmcfg_init(int early)
 {
 	pci_mmcfg_reject_broken(early);
-	if (list_empty(&pci_mmcfg_list))
+	if (list_empty(&pci_ecam_list))
 		return;
 
 	if (pcibios_last_bus < 0) {
-		const struct pci_mmcfg_region *cfg;
+		const struct pci_ecam_region *cfg;
 
-		list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+		list_for_each_entry(cfg, &pci_ecam_list, list) {
 			if (cfg->segment)
 				break;
 			pcibios_last_bus = cfg->end_bus;
 		}
 	}
 
-	if (pci_mmcfg_arch_init()) {
+	if (pci_ecam_arch_init()) {
 		raw_pci_ext_ops = &pci_mmcfg;
 		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 	} else {
-		free_all_mmcfg();
+		pci_ecam_free_all();
 		pci_mmcfg_arch_init_failed = true;
 	}
 }
@@ -579,7 +579,7 @@ void __init pci_mmcfg_late_init(void)
 
 static int __init pci_mmcfg_late_insert_resources(void)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
 	pci_mmcfg_running_state = true;
 
@@ -592,7 +592,7 @@ static int __init pci_mmcfg_late_insert_resources(void)
 	 * marked so it won't cause request errors when __request_region is
 	 * called.
 	 */
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+	list_for_each_entry(cfg, &pci_ecam_list, list)
 		if (!cfg->res.parent)
 			insert_resource(&iomem_resource, &cfg->res);
 
@@ -612,7 +612,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 {
 	int rc;
 	struct resource *tmp = NULL;
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
 	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
 		return -ENODEV;
@@ -621,7 +621,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 		return -EINVAL;
 
 	rc = -EBUSY;
-	cfg = pci_mmconfig_alloc(seg, start, end, addr);
+	cfg = pci_ecam_alloc(seg, start, end, addr);
 	if (cfg == NULL) {
 		dev_warn(dev, "fail to add MMCONFIG (out of memory)\n");
 		return -ENOMEM;
@@ -642,7 +642,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 		goto error;
 	}
 
-	rc = pci_mmconfig_inject(cfg);
+	rc = pci_ecam_inject(cfg);
 	if (rc)
 		goto error;
 
diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
index 7a050cb..27e707d 100644
--- a/arch/x86/pci/mmconfig_32.c
+++ b/arch/x86/pci/mmconfig_32.c
@@ -28,7 +28,7 @@ static int mmcfg_last_accessed_cpu;
  */
 static u32 get_base_addr(unsigned int seg, int bus, unsigned devfn)
 {
-	struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
+	struct pci_ecam_region *cfg = pci_ecam_lookup(seg, bus);
 
 	if (cfg)
 		return cfg->address;
@@ -40,7 +40,7 @@ static u32 get_base_addr(unsigned int seg, int bus, unsigned devfn)
  */
 static void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
 {
-	u32 dev_base = base | PCI_MMCFG_BUS_OFFSET(bus) | (devfn << 12);
+	u32 dev_base = base | PCI_ECAM_BUS_OFFSET(bus) | (devfn << 12);
 	int cpu = smp_processor_id();
 	if (dev_base != mmcfg_last_accessed_device ||
 	    cpu != mmcfg_last_accessed_cpu) {
@@ -50,7 +50,7 @@ static void pci_exp_set_dev_base(unsigned int base, int bus, int devfn)
 	}
 }
 
-int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+int pci_ecam_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
@@ -79,7 +79,7 @@ err:		*value = -1;
 	return 0;
 }
 
-int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_ecam_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
@@ -106,22 +106,22 @@ int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-int __init pci_mmcfg_arch_init(void)
+int __init pci_ecam_arch_init(void)
 {
 	printk(KERN_INFO "PCI: Using MMCONFIG for extended config space\n");
 	return 1;
 }
 
-void __init pci_mmcfg_arch_free(void)
+void __init pci_ecam_arch_free(void)
 {
 }
 
-int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
+int pci_ecam_arch_map(struct pci_ecam_region *cfg)
 {
 	return 0;
 }
 
-void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+void pci_ecam_arch_unmap(struct pci_ecam_region *cfg)
 {
 	unsigned long flags;
 
diff --git a/arch/x86/pci/numachip.c b/arch/x86/pci/numachip.c
index 01868b6..f60d403 100644
--- a/arch/x86/pci/numachip.c
+++ b/arch/x86/pci/numachip.c
@@ -21,7 +21,7 @@ static u8 limit __read_mostly;
 
 static inline char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
-	struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
+	struct pci_ecam_region *cfg = pci_ecam_lookup(seg, bus);
 
 	if (cfg && cfg->virt)
 		return cfg->virt + (PCI_MMCFG_BUS_OFFSET(bus) | (devfn << 12));
diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index e285f62..40926a3 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -24,13 +24,13 @@
 int __weak raw_pci_read(unsigned int domain, unsigned int bus,
 			unsigned int devfn, int reg, int len, u32 *val)
 {
-	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
+	return pci_ecam_read(domain, bus, devfn, reg, len, val);
 }
 
 int __weak raw_pci_write(unsigned int domain, unsigned int bus,
 			 unsigned int devfn, int reg, int len, u32 val)
 {
-	return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
+	return pci_ecam_write(domain, bus, devfn, reg, len, val);
 }
 
 static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
@@ -69,7 +69,7 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 	mcfg = (struct acpi_table_mcfg *)header;
 
 	/* how many config structures do we have */
-	free_all_mmcfg();
+	pci_ecam_free_all();
 	entries = 0;
 	i = header->length - sizeof(struct acpi_table_mcfg);
 	while (i >= sizeof(struct acpi_mcfg_allocation)) {
@@ -85,14 +85,14 @@ int __init acpi_parse_mcfg(struct acpi_table_header *header)
 	for (i = 0; i < entries; i++) {
 		cfg = &cfg_table[i];
 		if (acpi_mcfg_check_entry(mcfg, cfg)) {
-			free_all_mmcfg();
+			pci_ecam_free_all();
 			return -ENODEV;
 		}
 
-		if (pci_mmconfig_add(cfg->pci_segment, cfg->start_bus_number,
+		if (pci_ecam_add(cfg->pci_segment, cfg->start_bus_number,
 				   cfg->end_bus_number, cfg->address) == NULL) {
 			pr_warn(PREFIX "no memory for MCFG entries\n");
-			free_all_mmcfg();
+			pci_ecam_free_all();
 			return -ENOMEM;
 		}
 	}
@@ -107,15 +107,15 @@ void __init __weak pci_mmcfg_early_init(void)
 
 void __init __weak pci_mmcfg_late_init(void)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
 	acpi_table_parse(ACPI_SIG_MCFG, acpi_parse_mcfg);
 
-	if (list_empty(&pci_mmcfg_list))
+	if (list_empty(&pci_ecam_list))
 		return;
-	if (!pci_mmcfg_arch_init())
-		free_all_mmcfg();
+	if (!pci_ecam_arch_init())
+		pci_ecam_free_all();
 
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
+	list_for_each_entry(cfg, &pci_ecam_list, list)
 		insert_resource(&iomem_resource, &cfg->res);
 }
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index f886796..6396944 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -15,24 +15,24 @@
 #include <linux/rculist.h>
 #include <linux/ecam.h>
 
-#define PREFIX "PCI: "
+#define PREFIX "PCI ECAM: "
 
-static DEFINE_MUTEX(pci_mmcfg_lock);
+static DEFINE_MUTEX(pci_ecam_lock);
 
-LIST_HEAD(pci_mmcfg_list);
+LIST_HEAD(pci_ecam_list);
 
 #ifdef CONFIG_PCI_ECAM_GENERIC
 static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus,
 				  unsigned int devfn)
 {
-	struct pci_mmcfg_region *cfg = pci_mmconfig_lookup(seg, bus);
+	struct pci_ecam_region *cfg = pci_ecam_lookup(seg, bus);
 
 	if (cfg && cfg->virt)
-		return cfg->virt + (PCI_MMCFG_BUS_OFFSET(bus) | (devfn << 12));
+		return cfg->virt + (PCI_ECAM_BUS_OFFSET(bus) | (devfn << 12));
 	return NULL;
 }
 
-int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+int pci_ecam_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
 	char __iomem *addr;
@@ -56,7 +56,7 @@ err:		*value = -1;
 	return 0;
 }
 
-int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_ecam_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
 	char __iomem *addr;
@@ -78,64 +78,64 @@ int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 	return 0;
 }
 
-static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
+static void __iomem *pci_ecam_ioremap(struct pci_ecam_region *cfg)
 {
 	void __iomem *addr;
 	u64 start, size;
 	int num_buses;
 
-	start = cfg->address + PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
+	start = cfg->address + PCI_ECAM_BUS_OFFSET(cfg->start_bus);
 	num_buses = cfg->end_bus - cfg->start_bus + 1;
-	size = PCI_MMCFG_BUS_OFFSET(num_buses);
+	size = PCI_ECAM_BUS_OFFSET(num_buses);
 	addr = ioremap_nocache(start, size);
 	if (addr)
-		addr -= PCI_MMCFG_BUS_OFFSET(cfg->start_bus);
+		addr -= PCI_ECAM_BUS_OFFSET(cfg->start_bus);
 	return addr;
 }
 
-int __init pci_mmcfg_arch_init(void)
+int __init pci_ecam_arch_init(void)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		if (pci_mmcfg_arch_map(cfg)) {
-			pci_mmcfg_arch_free();
+	list_for_each_entry(cfg, &pci_ecam_list, list)
+		if (pci_ecam_arch_map(cfg)) {
+			pci_ecam_arch_free();
 			return 0;
 		}
 
 	return 1;
 }
 
-void __init pci_mmcfg_arch_free(void)
+void __init pci_ecam_arch_free(void)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		pci_mmcfg_arch_unmap(cfg);
+	list_for_each_entry(cfg, &pci_ecam_list, list)
+		pci_ecam_arch_unmap(cfg);
 }
 
-int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
+int pci_ecam_arch_map(struct pci_ecam_region *cfg)
 {
-	cfg->virt = mcfg_ioremap(cfg);
+	cfg->virt = pci_ecam_ioremap(cfg);
 	if (!cfg->virt) {
-		pr_err(PREFIX "can't map MMCONFIG at %pR\n", &cfg->res);
+		pr_err(PREFIX "can't map ECAM at %pR\n", &cfg->res);
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
-void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+void pci_ecam_arch_unmap(struct pci_ecam_region *cfg)
 {
 	if (cfg && cfg->virt) {
-		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
+		iounmap(cfg->virt + PCI_ECAM_BUS_OFFSET(cfg->start_bus));
 		cfg->virt = NULL;
 	}
 }
 #endif
 
 static u32
-pci_mmconfig_generic_read(int len, void __iomem *addr)
+pci_ecam_generic_read(int len, void __iomem *addr)
 {
 	u32 data = 0;
 
@@ -155,7 +155,7 @@ pci_mmconfig_generic_read(int len, void __iomem *addr)
 }
 
 static void
-pci_mmconfig_generic_write(int len, void __iomem *addr, u32 value)
+pci_ecam_generic_write(int len, void __iomem *addr, u32 value)
 {
 	switch (len) {
 	case 1:
@@ -170,42 +170,42 @@ pci_mmconfig_generic_write(int len, void __iomem *addr, u32 value)
 	}
 }
 
-static struct pci_mmcfg_mmio_ops pci_mmcfg_mmio_default = {
-	.read = pci_mmconfig_generic_read,
-	.write = pci_mmconfig_generic_write,
+static struct pci_ecam_mmio_ops pci_ecam_mmio_default = {
+	.read = pci_ecam_generic_read,
+	.write = pci_ecam_generic_write,
 };
 
-static struct pci_mmcfg_mmio_ops *pci_mmcfg_mmio = &pci_mmcfg_mmio_default;
+static struct pci_ecam_mmio_ops *pci_ecam_mmio = &pci_ecam_mmio_default;
 
 void
-pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops)
+pci_ecam_register_mmio(struct pci_ecam_mmio_ops *ops)
 {
-	pci_mmcfg_mmio = ops;
+	pci_ecam_mmio = ops;
 }
 
 u32
 pci_mmio_read(int len, void __iomem *addr)
 {
-	if (!pci_mmcfg_mmio) {
+	if (!pci_ecam_mmio) {
 		pr_err("PCI config space has no accessors !");
 		return 0;
 	}
 
-	return pci_mmcfg_mmio->read(len, addr);
+	return pci_ecam_mmio->read(len, addr);
 }
 
 void
 pci_mmio_write(int len, void __iomem *addr, u32 value)
 {
-	if (!pci_mmcfg_mmio) {
+	if (!pci_ecam_mmio) {
 		pr_err("PCI config space has no accessors !");
 		return;
 	}
 
-	pci_mmcfg_mmio->write(len, addr, value);
+	pci_ecam_mmio->write(len, addr, value);
 }
 
-static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
+static void __init pci_ecam_remove(struct pci_ecam_region *cfg)
 {
 	if (cfg->res.parent)
 		release_resource(&cfg->res);
@@ -213,21 +213,21 @@ static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
 	kfree(cfg);
 }
 
-void __init free_all_mmcfg(void)
+void __init pci_ecam_free_all(void)
 {
-	struct pci_mmcfg_region *cfg, *tmp;
+	struct pci_ecam_region *cfg, *tmp;
 
-	pci_mmcfg_arch_free();
-	list_for_each_entry_safe(cfg, tmp, &pci_mmcfg_list, list)
-		pci_mmconfig_remove(cfg);
+	pci_ecam_arch_free();
+	list_for_each_entry_safe(cfg, tmp, &pci_ecam_list, list)
+		pci_ecam_remove(cfg);
 }
 
-void list_add_sorted(struct pci_mmcfg_region *new)
+void pci_ecam_list_add_sorted(struct pci_ecam_region *new)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
 	/* keep list sorted by segment and starting bus number */
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry_rcu(cfg, &pci_ecam_list, list) {
 		if (cfg->segment > new->segment ||
 		    (cfg->segment == new->segment &&
 		     cfg->start_bus >= new->start_bus)) {
@@ -235,13 +235,13 @@ void list_add_sorted(struct pci_mmcfg_region *new)
 			return;
 		}
 	}
-	list_add_tail_rcu(&new->list, &pci_mmcfg_list);
+	list_add_tail_rcu(&new->list, &pci_ecam_list);
 }
 
-struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
+struct pci_ecam_region *pci_ecam_alloc(int segment, int start,
 					    int end, u64 addr)
 {
-	struct pci_mmcfg_region *new;
+	struct pci_ecam_region *new;
 	struct resource *res;
 
 	if (addr == 0)
@@ -257,29 +257,29 @@ struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
 	new->end_bus = end;
 
 	res = &new->res;
-	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
-	res->end = addr + PCI_MMCFG_BUS_OFFSET(end + 1) - 1;
+	res->start = addr + PCI_ECAM_BUS_OFFSET(start);
+	res->end = addr + PCI_ECAM_BUS_OFFSET(end + 1) - 1;
 	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	snprintf(new->name, PCI_MMCFG_RESOURCE_NAME_LEN,
-		 "PCI MMCONFIG %04x [bus %02x-%02x]", segment, start, end);
+	snprintf(new->name, PCI_ECAM_RESOURCE_NAME_LEN,
+		 "PCI ECAM %04x [bus %02x-%02x]", segment, start, end);
 	res->name = new->name;
 
 	return new;
 }
 
-struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
+struct pci_ecam_region *pci_ecam_add(int segment, int start,
 					  int end, u64 addr)
 {
-	struct pci_mmcfg_region *new;
+	struct pci_ecam_region *new;
 
-	new = pci_mmconfig_alloc(segment, start, end, addr);
+	new = pci_ecam_alloc(segment, start, end, addr);
 	if (new) {
-		mutex_lock(&pci_mmcfg_lock);
-		list_add_sorted(new);
-		mutex_unlock(&pci_mmcfg_lock);
+		mutex_lock(&pci_ecam_lock);
+		pci_ecam_list_add_sorted(new);
+		mutex_unlock(&pci_ecam_lock);
 
 		pr_info(PREFIX
-		       "MMCONFIG for domain %04x [bus %02x-%02x] at %pR "
+		       "ECAM for domain %04x [bus %02x-%02x] at %pR "
 		       "(base %#lx)\n",
 		       segment, start, end, &new->res, (unsigned long)addr);
 	}
@@ -287,11 +287,11 @@ struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
 	return new;
 }
 
-struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
+struct pci_ecam_region *pci_ecam_lookup(int segment, int bus)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
+	list_for_each_entry_rcu(cfg, &pci_ecam_list, list)
 		if (cfg->segment == segment &&
 		    cfg->start_bus <= bus && bus <= cfg->end_bus)
 			return cfg;
@@ -299,39 +299,39 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
 	return NULL;
 }
 
-/* Delete MMCFG information for host bridges */
-int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
+/* Delete ECAM information for host bridges */
+int pci_ecam_delete(u16 seg, u8 start, u8 end)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 
-	mutex_lock(&pci_mmcfg_lock);
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
+	mutex_lock(&pci_ecam_lock);
+	list_for_each_entry_rcu(cfg, &pci_ecam_list, list)
 		if (cfg->segment == seg && cfg->start_bus == start &&
 		    cfg->end_bus == end) {
 			list_del_rcu(&cfg->list);
 			synchronize_rcu();
-			pci_mmcfg_arch_unmap(cfg);
+			pci_ecam_arch_unmap(cfg);
 			if (cfg->res.parent)
 				release_resource(&cfg->res);
-			mutex_unlock(&pci_mmcfg_lock);
+			mutex_unlock(&pci_ecam_lock);
 			kfree(cfg);
 			return 0;
 		}
-	mutex_unlock(&pci_mmcfg_lock);
+	mutex_unlock(&pci_ecam_lock);
 
 	return -ENOENT;
 }
 
-int pci_mmconfig_inject(struct pci_mmcfg_region *cfg)
+int pci_ecam_inject(struct pci_ecam_region *cfg)
 {
-	struct pci_mmcfg_region *cfg_conflict;
+	struct pci_ecam_region *cfg_conflict;
 	int err = 0;
 
-	mutex_lock(&pci_mmcfg_lock);
-	cfg_conflict = pci_mmconfig_lookup(cfg->segment, cfg->start_bus);
+	mutex_lock(&pci_ecam_lock);
+	cfg_conflict = pci_ecam_lookup(cfg->segment, cfg->start_bus);
 	if (cfg_conflict) {
 		if (cfg_conflict->end_bus < cfg->end_bus)
-			pr_info(FW_INFO "MMCONFIG for "
+			pr_info(FW_INFO "ECAM for "
 				"domain %04x [bus %02x-%02x] "
 				"only partially covers this bridge\n",
 				cfg_conflict->segment, cfg_conflict->start_bus,
@@ -340,17 +340,17 @@ int pci_mmconfig_inject(struct pci_mmcfg_region *cfg)
 		goto out;
 	}
 
-	if (pci_mmcfg_arch_map(cfg)) {
-		pr_warn("fail to map MMCONFIG %pR.\n", &cfg->res);
+	if (pci_ecam_arch_map(cfg)) {
+		pr_warn("fail to map ECAM %pR.\n", &cfg->res);
 		err = -ENOMEM;
 		goto out;
 	} else {
-		list_add_sorted(cfg);
-		pr_info("MMCONFIG at %pR (base %#lx)\n",
+		pci_ecam_list_add_sorted(cfg);
+		pr_info("ECAM at %pR (base %#lx)\n",
 			&cfg->res, (unsigned long)cfg->address);
 
 	}
 out:
-	mutex_unlock(&pci_mmcfg_lock);
+	mutex_unlock(&pci_ecam_lock);
 	return err;
 }
diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 95ee430..eff4035 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -204,7 +204,7 @@ arch_initcall(register_xen_pci_notifier);
 #ifdef CONFIG_PCI_MMCONFIG
 static int __init xen_mcfg_late(void)
 {
-	struct pci_mmcfg_region *cfg;
+	struct pci_ecam_region *cfg;
 	int rc;
 
 	if (!xen_initial_domain())
@@ -213,11 +213,11 @@ static int __init xen_mcfg_late(void)
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return 0;
 
-	if (list_empty(&pci_mmcfg_list))
+	if (list_empty(&pci_ecam_list))
 		return 0;
 
 	/* Check whether they are in the right area. */
-	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry(cfg, &pci_ecam_list, list) {
 		struct physdev_pci_mmcfg_reserved r;
 
 		r.address = cfg->address;
diff --git a/include/linux/ecam.h b/include/linux/ecam.h
index fba5d6b..363691b 100644
--- a/include/linux/ecam.h
+++ b/include/linux/ecam.h
@@ -5,10 +5,10 @@
 #include <linux/types.h>
 #include <linux/acpi.h>
 
-/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
-#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
+/* "PCI ECAM %04x [bus %02x-%02x]" */
+#define PCI_ECAM_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
 
-struct pci_mmcfg_region {
+struct pci_ecam_region {
 	struct list_head list;
 	struct resource res;
 	u64 address;
@@ -16,40 +16,40 @@ struct pci_mmcfg_region {
 	u16 segment;
 	u8 start_bus;
 	u8 end_bus;
-	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
+	char name[PCI_ECAM_RESOURCE_NAME_LEN];
 };
 
-struct pci_mmcfg_mmio_ops {
+struct pci_ecam_mmio_ops {
 	u32 (*read)(int len, void __iomem *addr);
 	void (*write)(int len, void __iomem *addr, u32 value);
 };
 
-struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
-struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
+struct pci_ecam_region *pci_ecam_lookup(int segment, int bus);
+struct pci_ecam_region *pci_ecam_alloc(int segment, int start,
 						   int end, u64 addr);
-int pci_mmconfig_inject(struct pci_mmcfg_region *cfg);
-struct pci_mmcfg_region *pci_mmconfig_add(int segment, int start,
+int pci_ecam_inject(struct pci_ecam_region *cfg);
+struct pci_ecam_region *pci_ecam_add(int segment, int start,
 						 int end, u64 addr);
-void list_add_sorted(struct pci_mmcfg_region *new);
-void free_all_mmcfg(void);
-int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
+void pci_ecam_list_add_sorted(struct pci_ecam_region *new);
+void pci_ecam_free_all(void);
+int pci_ecam_delete(u16 seg, u8 start, u8 end);
 
 /* Arch specific calls */
-int pci_mmcfg_arch_init(void);
-void pci_mmcfg_arch_free(void);
-int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
-void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
+int pci_ecam_arch_init(void);
+void pci_ecam_arch_free(void);
+int pci_ecam_arch_map(struct pci_ecam_region *cfg);
+void pci_ecam_arch_unmap(struct pci_ecam_region *cfg);
 extern u32 pci_mmio_read(int len, void __iomem *addr);
 extern void pci_mmio_write(int len, void __iomem *addr, u32 value);
-extern void pci_mmconfig_register_mmio(struct pci_mmcfg_mmio_ops *ops);
+extern void pci_ecam_register_mmio(struct pci_ecam_mmio_ops *ops);
 
-extern struct list_head pci_mmcfg_list;
+extern struct list_head pci_ecam_list;
 
-#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
+#define PCI_ECAM_BUS_OFFSET(bus)      ((bus) << 20)
 
-int pci_mmcfg_read(unsigned int seg, unsigned int bus,
+int pci_ecam_read(unsigned int seg, unsigned int bus,
 		   unsigned int devfn, int reg, int len, u32 *value);
-int pci_mmcfg_write(unsigned int seg, unsigned int bus,
+int pci_ecam_write(unsigned int seg, unsigned int bus,
 		    unsigned int devfn, int reg, int len, u32 value);
 
 #endif  /* __KERNEL__ */
-- 
1.9.1

