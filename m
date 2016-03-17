Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:59612 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933112AbcCQKzM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2016 06:55:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <linux@arm.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] arm/arm64/irqchip/pci: select PCI_MSI instead of depending on it
Date: Thu, 17 Mar 2016 11:52:49 +0100
Message-Id: <1458212069-896315-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI_MSI symbol is used inconsistently throughout the tree,
with some drivers using 'select' and others using 'depends on',
or using conditional selects. This keeps causing problems,
and the latest one is a result of ARCH_ALPINE using a 'select'
statement to enable its platform specific MSI driver but not
enabling MSI support first:

warning: (ARCH_ALPINE) selects ALPINE_MSI which has unmet direct dependencies (PCI && PCI_MSI)
drivers/irqchip/irq-alpine-msi.c:104:15: error: variable 'alpine_msix_domain_info' has initializer but incomplete type
 static struct msi_domain_info alpine_msix_domain_info = {
               ^~~~~~~~~~~~~~~
drivers/irqchip/irq-alpine-msi.c:105:2: error: unknown field 'flags' specified in initializer
  .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
  ^
drivers/irqchip/irq-alpine-msi.c:105:11: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
  .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
           ^~~~~~~~~~~~~~~~~~~~~~~~

There is little reason to enable PCI support for a platform that
uses MSI but then leaving MSI disabled at compile time, so this
patch changes the various Kconfig statement relating to PCI_MSI
so they all use 'select'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig         |  3 ++-
 arch/arm64/Kconfig       |  4 ++--
 drivers/irqchip/Kconfig  | 11 ++++++++---
 drivers/pci/host/Kconfig | 10 ++++++----
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aa9f67a89620..1c4e38764f02 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -703,9 +703,10 @@ config ARCH_VIRT
 	depends on ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GIC_V2M if PCI_MSI
+	select ARM_GIC_V2M
 	select ARM_GIC_V3
 	select ARM_PSCI
+	select PCI
 	select HAVE_ARM_ARCH_TIMER
 
 #
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f436220384f..c9a3161e0aed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,9 +19,9 @@ config ARM64
 	select ARM_ARCH_TIMER
 	select ARM_GIC
 	select AUDIT_ARCH_COMPAT_GENERIC
-	select ARM_GIC_V2M if PCI_MSI
+	select ARM_GIC_V2M
 	select ARM_GIC_V3
-	select ARM_GIC_V3_ITS if PCI_MSI
+	select ARM_GIC_V3_ITS
 	select ARM_PSCI_FW
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7e8c441ff2de..73ab0ecb9b3b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -16,7 +16,8 @@ config ARM_GIC_MAX_NR
 config ARM_GIC_V2M
 	bool
 	depends on ARM_GIC
-	depends on PCI && PCI_MSI
+	depends on PCI
+	select PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 
 config GIC_NON_BANKED
@@ -30,6 +31,8 @@ config ARM_GIC_V3
 
 config ARM_GIC_V3_ITS
 	bool
+	depends on PCI
+	select PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 
 config HISILICON_IRQ_MBIGEN
@@ -63,11 +66,13 @@ config ARM_VIC_NR
 config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
-	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
+	select PCI_MSI if PCI
+	select PCI_MSI_IRQ_DOMAIN if PCI
 
 config ALPINE_MSI
 	bool
-	depends on PCI && PCI_MSI
+	depends on PCI
+	select PCI_MSI
 	select GENERIC_IRQ_CHIP
 	select PCI_MSI_IRQ_DOMAIN
 
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c5014bf95a20..844d7eb79c45 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -118,7 +118,6 @@ config PCI_XGENE
 	depends on ARCH_XGENE
 	depends on OF
 	select PCIEPORTBUS
-	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
@@ -126,7 +125,9 @@ config PCI_XGENE
 
 config PCI_XGENE_MSI
 	bool "X-Gene v1 PCIe MSI feature"
-	depends on PCI_XGENE && PCI_MSI
+	depends on PCI_XGENE
+	select PCI_MSI
+	select PCI_MSI_IRQ_DOMAIN
 	default y
 	help
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
@@ -175,7 +176,7 @@ config PCIE_IPROC_BCMA
 config PCIE_IPROC_MSI
 	bool "Broadcom iProc PCIe MSI support"
 	depends on PCIE_IPROC_PLATFORM || PCIE_IPROC_BCMA
-	depends on PCI_MSI
+	select PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 	default ARCH_BCM_IPROC
 	help
@@ -193,7 +194,8 @@ config PCIE_ALTERA
 
 config PCIE_ALTERA_MSI
 	bool "Altera PCIe MSI feature"
-	depends on PCIE_ALTERA && PCI_MSI
+	depends on PCIE_ALTERA
+	select PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
-- 
2.7.0

