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
Subject: [PATCH V4 08/23] arm64, acpi: Use MCFG and empty PCI config space accessors from mcfg.c file.
Date: Thu,  4 Feb 2016 18:28:46 +0100
Message-Id: <1454606941-9523-9-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can now enable MCFG driver and its GENERIC_ECAM_MAP feature.
Currently there is no RAW pci config accessor use case for ARM64,
so lets use empty one for now. At the same time we can cleanup
the old implementation of RAW accessors from arch/arm64/kernel/pci.c

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/arm64/Kconfig      |  7 +++++++
 arch/arm64/kernel/pci.c | 15 ---------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc6228..4f45ea4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -34,6 +34,7 @@ config ARM64
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
+	select GENERIC_ECAM_MAP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
@@ -96,6 +97,7 @@ config ARM64
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_ARM_SMCCC
+	select HAVE_PCI_ECAM
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -238,6 +240,11 @@ source "drivers/pci/Kconfig"
 source "drivers/pci/pcie/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
+config PCI_MMCONFIG
+	def_bool y
+	select PCI_ECAM
+	depends on ACPI
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index b3d098b..023b983 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -61,21 +61,6 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
 
-/*
- * raw_pci_read/write - Platform-specific PCI config space access.
- */
-int raw_pci_read(unsigned int domain, unsigned int bus,
-		  unsigned int devfn, int reg, int len, u32 *val)
-{
-	return -ENXIO;
-}
-
-int raw_pci_write(unsigned int domain, unsigned int bus,
-		unsigned int devfn, int reg, int len, u32 val)
-{
-	return -ENXIO;
-}
-
 #ifdef CONFIG_ACPI
 /* Root bridge scanning */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-- 
1.9.1

