Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: tegra: add MSI dependency
Date: Tue, 13 Mar 2018 12:52:05 +0100
Message-Id: <20180313115218.2246372-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Building the tegra PCIe host driver without MSI results in a link
failure:

drivers/pci/host/pci-tegra.o:(.data+0x70): undefined reference to `pci_msi_unmask_irq'
drivers/pci/host/pci-tegra.o:(.data+0x74): undefined reference to `pci_msi_mask_irq'

This adds the same dependency that everyone else uses.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1fcdc890acc7..65b4afb8d11d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -38,6 +38,7 @@ config PCI_FTPCI100
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA && MMU
+	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
-- 
2.9.0
