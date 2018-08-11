Return-Path: <linux-arch-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 07/17] x86/pci: add Hygon PCI vendor and northbridge support
Date: Sat, 11 Aug 2018 21:27:42 +0800
Message-Id: <0b8f3a7c5ba8b4f496f8f790e3dafa8d612ffc81.1533989492.git.puwen@hygon.cn>
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As Hygon register its PCI Vendor ID as a new one "0x1d94", so add a new
definition PCI_VENDOR_ID_HYGON in include/linux/pci_ids.h.

Also Hygon PCI Device ID(0x1450/0x1463/0x1464) for Host bridge is added
to amd_nb.c. And it need to define new arrays for Hygon:
hygon_root_ids[], hygon_nb_misc_ids[], hygon_nb_link_ids[].

To enable Hygon north bridge support, add new variable root_ids, and
assign its value based on whether CPU vendor is AMD or Hygon. Modify
the CONFIG_AMD_NB to depends on either AMD or Hygon.

Add Hygon support in amd_postcore_init(), early_root_info_init().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/Kconfig         |  2 +-
 arch/x86/kernel/amd_nb.c | 51 ++++++++++++++++++++++++++++++++++++++++++------
 arch/x86/pci/amd_bus.c   |  6 ++++--
 include/linux/pci_ids.h  |  2 ++
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 887d3a7..c71e08bf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2822,7 +2822,7 @@ endif # X86_32
 
 config AMD_NB
 	def_bool y
-	depends on CPU_SUP_AMD && PCI
+	depends on (CPU_SUP_AMD || CPU_SUP_HYGON) && PCI
 
 source "drivers/pcmcia/Kconfig"
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b481b95..d9867b2 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -20,6 +20,10 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 
+#define PCI_DEVICE_ID_HYGON_18H_ROOT     0x1450
+#define PCI_DEVICE_ID_HYGON_18H_DF_F3    0x1463
+#define PCI_DEVICE_ID_HYGON_18H_DF_F4    0x1464
+
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -61,6 +65,21 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{}
 };
 
+static const struct pci_device_id hygon_root_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_ROOT) },
+	{}
+};
+
+const struct pci_device_id hygon_nb_misc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_DF_F3) },
+	{}
+};
+
+static const struct pci_device_id hygon_nb_link_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_DF_F4) },
+	{}
+};
+
 const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
 	{ 0x00, 0x18, 0x20 },
 	{ 0xff, 0x00, 0x20 },
@@ -197,12 +216,25 @@ int amd_cache_northbridges(void)
 	u16 i = 0;
 	struct amd_northbridge *nb;
 	struct pci_dev *root, *misc, *link;
+	const struct pci_device_id *root_ids = NULL;
+	const struct pci_device_id *misc_ids = NULL;
+	const struct pci_device_id *link_ids = NULL;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		root_ids = amd_root_ids;
+		misc_ids = amd_nb_misc_ids;
+		link_ids = amd_nb_link_ids;
+	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+		root_ids = hygon_root_ids;
+		misc_ids = hygon_nb_misc_ids;
+		link_ids = hygon_nb_link_ids;
+	}
 
 	if (amd_northbridges.num)
 		return 0;
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, amd_nb_misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
 		i++;
 
 	if (!i)
@@ -218,11 +250,11 @@ int amd_cache_northbridges(void)
 	link = misc = root = NULL;
 	for (i = 0; i != amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root = root =
-			next_northbridge(root, amd_root_ids);
+			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc = misc =
-			next_northbridge(misc, amd_nb_misc_ids);
+			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link = link =
-			next_northbridge(link, amd_nb_link_ids);
+			next_northbridge(link, link_ids);
 	}
 
 	if (amd_gart_present())
@@ -263,9 +295,15 @@ bool __init early_is_amd_nb(u32 device)
 {
 	const struct pci_device_id *id;
 	u32 vendor = device & 0xffff;
+	const struct pci_device_id *misc_ids = NULL;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		misc_ids = amd_nb_misc_ids;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		misc_ids = hygon_nb_misc_ids;
 
 	device >>= 16;
-	for (id = amd_nb_misc_ids; id->vendor; id++)
+	for (id = misc_ids; id->vendor; id++)
 		if (vendor == id->vendor && device == id->device)
 			return true;
 	return false;
@@ -277,7 +315,8 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
 	/* assume all cpus from fam10h have mmconfig */
diff --git a/arch/x86/pci/amd_bus.c b/arch/x86/pci/amd_bus.c
index 649bdde..bfa50e6 100644
--- a/arch/x86/pci/amd_bus.c
+++ b/arch/x86/pci/amd_bus.c
@@ -93,7 +93,8 @@ static int __init early_root_info_init(void)
 		vendor = id & 0xffff;
 		device = (id>>16) & 0xffff;
 
-		if (vendor != PCI_VENDOR_ID_AMD)
+		if (vendor != PCI_VENDOR_ID_AMD &&
+		    vendor != PCI_VENDOR_ID_HYGON)
 			continue;
 
 		if (hb_probes[i].device == device) {
@@ -390,7 +391,8 @@ static int __init pci_io_ecs_init(void)
 
 static int __init amd_postcore_init(void)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 
 	early_root_info_init();
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2950223..d0e98a9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -511,6 +511,8 @@
 #define PCI_DEVICE_ID_AMI_MEGARAID	0x9010
 #define PCI_DEVICE_ID_AMI_MEGARAID2	0x9060
 
+#define PCI_VENDOR_ID_HYGON		0x1d94
+
 #define PCI_VENDOR_ID_AMD		0x1022
 #define PCI_DEVICE_ID_AMD_K8_NB		0x1100
 #define PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP	0x1101
-- 
2.7.4
