Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>, <linux-pci@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 2/3] Revert "PCI: rcar: Build pcie-rcar.c only on ARM"
Date: Mon,  2 Nov 2015 16:36:14 +0000
Message-Id: <1446482175-26507-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
References: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we can build on arm64, revert commit 7c537c67d2e4
("PCI: rcar: Build pcie-rcar.c only on ARM").

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 2af0571..ad27664 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -48,8 +48,7 @@ config PCI_RCAR_GEN2
 
 config PCI_RCAR_GEN2_PCIE
 	bool "Renesas R-Car PCIe controller"
-	depends on ARM
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
 	help
 	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
 
-- 
1.9.1

