Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44786 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbcDUDwQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 23:52:16 -0400
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
Date: Thu, 21 Apr 2016 13:51:55 +1000
Message-Id: <1461210715-29304-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It appears that Gen2 is a misnomer for the R-Car PCIE driver
which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
from the help text and Kconfig symbol.

Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
This appears to be in keeping with other PCIE Kconfig symbols.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Hi Bjorn,

As discussed elsewhere I am planning to take this through the renesas tree.

v3
* Added Ack from Bjorn Helgaas
* Added defconfig updates

v2
* As suggested by Geert Uytterhoeven:
  - Use PCIE as prefix in Kconfig symbol
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 arch/arm/configs/shmobile_defconfig | 2 +-
 arch/arm64/configs/defconfig        | 2 +-
 drivers/pci/host/Kconfig            | 4 ++--
 drivers/pci/host/Makefile           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 434f86b110bb..a1cf13dfdea1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -119,7 +119,7 @@ CONFIG_PCI_MSI=y
 CONFIG_PCI_MVEBU=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCI_RCAR_GEN2=y
-CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_PCIE_RCAR=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index e06acb9b38ce..f2d635566a13 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -24,7 +24,7 @@ CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
 CONFIG_PCI_RCAR_GEN2=y
-CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_PCIE_RCAR=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a44ef995d8ae..23dd767b2971 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -56,7 +56,7 @@ CONFIG_ARCH_ZYNQMP=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_IOV=y
-CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_PCIE_RCAR=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_LAYERSCAPE=y
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7a0780d56d2d..8fb1cf54617d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -69,11 +69,11 @@ config PCI_RCAR_GEN2
 	  There are 3 internal PCI controllers available with a single
 	  built-in EHCI/OHCI host controller present on each one.
 
-config PCI_RCAR_GEN2_PCIE
+config PCIE_RCAR
 	bool "Renesas R-Car PCIe controller"
 	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
 	help
-	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
+	  Say Y here if you want PCIe controller support on R-Car SoCs.
 
 config PCI_HOST_COMMON
 	bool
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index d85b5faf9bbc..d3d8e1b36fb9 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
 obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
 obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
-obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
+obj-$(CONFIG_PCIE_RCAR) += pcie-rcar.o
 obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
 obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
-- 
2.7.0.rc3.207.g0ac5344

