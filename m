Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:50883 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbcDPUQz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2016 16:16:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: rcar: select PCI_MSI_IRQ_DOMAIN
Date: Sat, 16 Apr 2016 22:15:46 +0200
Message-Id: <1460837798-1239513-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The R-CAR PCIe driver requires the use of irq domains for its
MSI code:

drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_msi_irq':
drivers/pci/host/pcie-rcar.c:635:9: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
drivers/pci/host/pcie-rcar.c: In function 'rcar_msi_setup_irq':
drivers/pci/host/pcie-rcar.c:666:8: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_enable_msi':
drivers/pci/host/pcie-rcar.c:725:16: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
drivers/pci/host/pcie-rcar.c:725:14: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
  msi->domain = irq_domain_add_linear(pcie->dev->of_node, INT_PCI_MSI_NR,
              ^
drivers/pci/host/pcie-rcar.c:762:2: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]

This ensures that the feature is always enabled by adding a
Kconfig select statement. This is not consistent with what the
other drivers do at the moment, but I have another patch that
changes them to do it like this one, which is more logical.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 169c545bf70a..6d642aa390b0 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -72,6 +72,8 @@ config PCI_RCAR_GEN2
 config PCI_RCAR_GEN2_PCIE
 	bool "Renesas R-Car PCIe controller"
 	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
+	select PCI_MSI
+	select PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
 
-- 
2.7.0

