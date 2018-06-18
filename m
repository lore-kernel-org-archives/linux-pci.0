Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] PCI: controller: Move PCI_DOMAINS selection to arch Kconfig
Date: Mon, 18 Jun 2018 12:21:15 +0100
Message-Id: <20180618112115.23759-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
added configuration options to allow PCI host controller drivers to be
compile tested on all architectures.

Some host controller drivers (eg PCIE_ALTERA) config entries select
the PCI_DOMAINS config option to enable PCI domains management in
the kernel. Now that host controller drivers can be compiled on
all architectures, this triggers build regressions on arches that
do not implement the PCI_DOMAINS required API (ie pci_domain_nr()):

drivers/ata/pata_ali.c: In function 'ali_init_chipset':
drivers/ata/pata_ali.c:469:38: error:
        implicit declaration of function 'pci_domain_nr';
                                          did you mean 'pci_iomap_wc'?

The PCI_DOMAINS config option is meant to be selected by the arch
configuration since it is an arch rather a than host controller option.

Move the PCI_DOMAINS selection to the sub-arch Kconfig entries,
therefore fixing the build regression.

Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
Link: https://lkml.kernel.org/r/20180612170229.GA10141@roeck-us.net
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Ley Foon Tan <lftan@altera.com>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/mach-bcm/Kconfig      | 1 +
 arch/arm/mach-socfpga/Kconfig  | 1 +
 drivers/pci/controller/Kconfig | 3 ---
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54eeb8d00bc6..7f1633dd9e07 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -701,6 +701,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
+	select PCI_DOMAINS if PCI
 
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index c46a728df44e..25aac6ee2ab1 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -20,6 +20,7 @@ config ARCH_BCM_IPROC
 	select GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
+	select PCI_DOMAINS if PCI
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index d0f62eacf59d..4adb901dd5eb 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -10,6 +10,7 @@ menuconfig ARCH_SOCFPGA
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select MFD_SYSCON
+	select PCI_DOMAINS if PCI
 
 if ARCH_SOCFPGA
 config SOCFPGA_SUSPEND
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 18fa09b3ac8f..cc9fa02d32a0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -96,7 +96,6 @@ config PCI_HOST_GENERIC
 	depends on OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
-	select PCI_DOMAINS
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
@@ -138,7 +137,6 @@ config PCI_VERSATILE
 
 config PCIE_IPROC
 	tristate
-	select PCI_DOMAINS
 	help
 	  This enables the iProc PCIe core controller support for Broadcom's
 	  iProc family of SoCs. An appropriate bus interface driver needs
@@ -176,7 +174,6 @@ config PCIE_IPROC_MSI
 config PCIE_ALTERA
 	bool "Altera PCIe controller"
 	depends on ARM || NIOS2 || COMPILE_TEST
-	select PCI_DOMAINS
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera
 	  FPGA.
-- 
2.15.0
