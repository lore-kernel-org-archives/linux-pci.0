Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: PCI_RCAR_GEN2 and PCI_RCAR_GEN2_PCIE should depend on ARM
Date: Tue, 11 Aug 2015 14:43:14 +0200
Message-Id: <1439296994-28480-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On arm64/shmobile:

    drivers/pci/host/pci-rcar-gen2.c: In function 'rcar_pci_cfg_base': drivers/pci/host/pci-rcar-gen2.c:112:34: error: dereferencing pointer to incomplete type
      struct rcar_pci_priv *priv = sys->private_data;
				      ^

and

    drivers/pci/host/pcie-rcar.c:138:52: warning: 'struct pci_sys_data' declared inside parameter list
     static inline struct rcar_pcie *sys_to_pcie(struct pci_sys_data *sys)
							^

pci_sys_data exists on ARM only, hence these drivers should depend on
ARM unconditionally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/host/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 48b5b3058d9d09eb..e94392560842be0a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -39,7 +39,8 @@ config PCI_TEGRA
 
 config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
-	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
+	depends on ARM
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
 	  There are 3 internal PCI controllers available with a single
@@ -47,7 +48,8 @@ config PCI_RCAR_GEN2
 
 config PCI_RCAR_GEN2_PCIE
 	bool "Renesas R-Car PCIe controller"
-	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
+	depends on ARM
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
 
-- 
1.9.1

