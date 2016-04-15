Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 12/13] pci, pci-thunder-ecam: Add ACPI support for ThunderX ECAM.
Date: Fri, 15 Apr 2016 19:06:47 +0200
Message-Id: <1460740008-19489-13-git-send-email-tn@semihalf.com>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Passes 1.x miss PCI enhanced allocation (EA) header for fixed-BARs,
thus these passes should use Cavium-specific config access functions
that synthesize the missing EA capabilities.

We already have DT driver which addresses errata requirements and
allows to use special PCI config accessors. Currently this driver uses
compatible = "cavium,pci-host-thunder-ecam" to mach against the errata.
For ACPI case we need explicit errata number and corresponding
DECLARE_ACPI_MCFG_FIXUP fixup code.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/Kconfig                  | 14 ++++++++++++++
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c      |  8 ++++++++
 drivers/pci/host/pci-thunder-ecam.c | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1bded87..b7614b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -445,6 +445,20 @@ config CAVIUM_ERRATUM_27456
 
 	  If unsure, say Y.
 
+config CAVIUM_ERRATUM_24575
+	bool "Cavium erratum 24575: Enhanced Allocation (EA) emualaion"
+	default y
+	help
+	  Enable workaround for erratum 24575.
+
+	  Early versions of the Cavium Thunder CN88XX processor are missing
+	  Enhanced Allocation (EA) capabilities for the fixed BAR addresses used
+	  by the on-SoC hardware blocks. The erratum adds config access
+	  functions that synthesize the missing EA capabilities for versions
+	  that are missing that information.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b9b6494..a78364e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -35,8 +35,9 @@
 #define ARM64_ALT_PAN_NOT_UAO			10
 #define ARM64_HAS_VIRT_HOST_EXTN		11
 #define ARM64_WORKAROUND_CAVIUM_27456		12
+#define ARM64_WORKAROUND_CAVIUM_24575		13
 
-#define ARM64_NCAPS				13
+#define ARM64_NCAPS				14
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 06afd04..89c13d7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -97,6 +97,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 			   (1 << MIDR_VARIANT_SHIFT) | 1),
 	},
 #endif
+#ifdef CONFIG_CAVIUM_ERRATUM_24575
+	{
+	/* Cavium ThunderX, pass 1.x */
+		.desc = "Cavium erratum 24575",
+		.capability = ARM64_WORKAROUND_CAVIUM_24575,
+		MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
+	},
+#endif
 	{
 	}
 };
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
index f67c6d7..01de697 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -11,10 +11,14 @@
 #include <linux/ioport.h>
 #include <linux/of_pci.h>
 #include <linux/of.h>
+#include <linux/pci-acpi.h>
 #include <linux/platform_device.h>
 
+#include <asm/virt.h>
+
 #include "../ecam.h"
 
+
 static void set_val(u32 v, int where, int size, u32 *val)
 {
 	int shift = (where & 3) * 8;
@@ -376,5 +380,36 @@ static struct platform_driver thunder_ecam_driver = {
 };
 module_platform_driver(thunder_ecam_driver);
 
+#ifdef CONFIG_ACPI
+
+static bool needs_cavium_erratum_24575(struct pci_cfg_fixup *fixup,
+				      struct acpi_pci_root *root)
+{
+	/*
+	 * We must match errata code and be hypervisor, quirk does not apply
+	 * for virtual machines.
+	 */
+	return cpus_have_cap(ARM64_WORKAROUND_CAVIUM_24575) &&
+	       is_hyp_mode_available();
+}
+
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			0, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			1, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			2, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			3, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			10, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			11, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			12, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, needs_cavium_erratum_24575, &pci_thunder_ecam_ops,
+			13, PCI_MCFG_BUS_ANY);
+#endif
+
 MODULE_DESCRIPTION("Thunder ECAM PCI host driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
