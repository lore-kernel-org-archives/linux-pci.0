Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38410 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbcCaAf3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 20:35:29 -0400
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
Date: Thu, 31 Mar 2016 09:35:23 +0900
Message-Id: <1459384523-16146-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It appears that Gen2 is a misnomer for the R-Car PCIE driver
which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
from the help text and Kconfig symbol.

Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
This appears to be in keeping with other PCIE Kconfig symbols.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Bjorn, if this patch is acceptable I would like to request that we
co-ordinate things so that I can queue-up corresponding updates for
arm and arm64 defconfigs in the same release. From my point of view
v4.7 would make sense.

v2
* As suggested by Geert Uytterhoeven:
  - Use PCIE as prefix in Kconfig symbol
---
 drivers/pci/host/Kconfig  | 4 ++--
 drivers/pci/host/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
2.1.4

