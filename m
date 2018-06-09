Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, tony.luck@intel.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-x86_64@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH 02/11] x86/pci: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:21:46 +0800
Message-Id: <1528550506-28173-1-git-send-email-puwen@hygon.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables the x86 PCI support to Hygon Family 18h CPU:
- AMD Northbridge
  - Add PCI_DEVICE_ID_HYGON_18H_ROOT, PCI_DEVICE_ID_HYGON_18H_DF_F3
    and PCI_DEVICE_ID_HYGON_18H_DF_F4 support in amd_nb.c
- PCI for X86
  - Add Hygon Vendor ID(0x1D94) support.
  - Add Hygon irq router support in pirq_routers arrays.
  - Add Hygon support in amd_postcore_init(), early_root_info_init().
- APIC for X86
  - Add Hygon support in modern_apic() and sync_Arb_IDs() as Hygon
    processors are modern processors.
  - Add Hygon support in detect_init_API().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/amd_nb.c    | 11 ++++++++++-
 arch/x86/kernel/apic/apic.c | 13 +++++++++++--
 arch/x86/pci/amd_bus.c      |  6 ++++--
 arch/x86/pci/irq.c          |  1 +
 include/linux/pci_ids.h     |  2 ++
 5 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b481b95..054b7fa 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -20,6 +20,11 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 
+/* Hygon Family 18h follow AMD Family 17h's Device ID definition */
+#define PCI_DEVICE_ID_HYGON_18H_ROOT     PCI_DEVICE_ID_AMD_17H_ROOT
+#define PCI_DEVICE_ID_HYGON_18H_DF_F3    PCI_DEVICE_ID_AMD_17H_DF_F3
+#define PCI_DEVICE_ID_HYGON_18H_DF_F4    PCI_DEVICE_ID_AMD_17H_DF_F4
+
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
 
@@ -28,6 +33,7 @@ static u32 *flush_words;
 static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_ROOT) },
 	{}
 };
 
@@ -45,6 +51,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_DF_F3) },
 	{}
 };
 EXPORT_SYMBOL_GPL(amd_nb_misc_ids);
@@ -58,6 +65,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_HYGON_18H_DF_F4) },
 	{}
 };
 
@@ -277,7 +285,8 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
 	/* assume all cpus from fam10h have mmconfig */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 2aabd4c..d8b7ac1 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -223,6 +223,11 @@ static int modern_apic(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 	    boot_cpu_data.x86 >= 0xf)
 		return 1;
+
+	/* Hygon systems use modern APIC */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return 1;
+
 	return lapic_get_version() >= 0x14;
 }
 
@@ -1207,9 +1212,11 @@ void __init sync_Arb_IDs(void)
 {
 	/*
 	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
-	 * needed on AMD.
+	 * needed on AMD or Hygon.
 	 */
-	if (modern_apic() || boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (modern_apic() ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 
 	/*
@@ -1908,6 +1915,8 @@ static int __init detect_init_APIC(void)
 		    (boot_cpu_data.x86 >= 15))
 			break;
 		goto no_apic;
+	case X86_VENDOR_HYGON:
+		break;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
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
diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 52e5510..63ff5e3 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -804,6 +804,7 @@ static __initdata struct irq_router_handler pirq_routers[] = {
 	{ PCI_VENDOR_ID_VLSI, vlsi_router_probe },
 	{ PCI_VENDOR_ID_SERVERWORKS, serverworks_router_probe },
 	{ PCI_VENDOR_ID_AMD, amd_router_probe },
+	{ PCI_VENDOR_ID_HYGON, amd_router_probe },
 	{ PCI_VENDOR_ID_PICOPOWER, pico_router_probe },
 	/* Someone with docs needs to add the ATI Radeon IGP */
 	{ 0, NULL }
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index cc608fc5..efb5dfd 100644
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

