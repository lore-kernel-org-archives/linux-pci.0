Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jon Mason <jon.mason@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Jon Mason <jonmason@broadcom.com>
Subject: [PATCH] PCI: iproc: Add PCI_DOMAIN dependency to PCI Kconfig
Date: Wed,  1 Mar 2017 10:53:13 -0500
Message-Id: <1488383593-31666-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jon Mason <jonmason@broadcom.com>

2+ PCI devices fail to be discovered due to each bus having the same
PCI domain.  This is because the domain defined in the device tree file
is not being added due to PCI_DOMAIN not being enabled.  So, every PCI
bus has a domain of zero.  When PCI_DOMAIN is selected by the Kconfig,
it picks-up the domain defined in the device tree file and everything
works as expected.

Since both PCIE_IPROC_PLATFORM and PCIE_IPROC_BCMA need PCI_DOMAIN,
moving it to PCIE_IPROC (so it can be automatically selected for both).

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 898d2c4..82496b6 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -165,6 +165,7 @@ config PCI_VERSATILE
 
 config PCIE_IPROC
 	tristate
+	select PCI_DOMAINS
 	help
 	  This enables the iProc PCIe core controller support for Broadcom's
 	  iProc family of SoCs. An appropriate bus interface driver needs
@@ -185,7 +186,6 @@ config PCIE_IPROC_BCMA
 	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
 	select PCIE_IPROC
 	select BCMA
-	select PCI_DOMAINS
 	default ARCH_BCM_5301X
 	help
 	  Say Y here if you want to use the Broadcom iProc PCIe controller
-- 
2.7.4
