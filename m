Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: dra7xx: add back CONFIG_PCI dependency for endpoint
Date: Thu, 18 Jan 2018 14:15:54 +0100
Message-Id: <20180118131612.871559-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It was a nice idea to split out the PCI host and endpoint mode configuration
into separate options. Unfortunately it doesn't build:

drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate' undeclared here (not in a function)

This is certainly a fixable problem, but since it's clear that this
configuration was never tested, let's maybe revert back to the
dependency for now, until it can be done in a way that works
better.

Fixes: b052835c6385 ("PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/dwc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 0fb96c7754de..540419527a92 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -36,7 +36,7 @@ config PCI_DRA7XX_HOST
 config PCI_DRA7XX_EP
 	bool "TI DRA7xx PCIe controller Endpoint Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on PCI_ENDPOINT
+	depends on PCI && PCI_ENDPOINT
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_EP
 	select PCI_DRA7XX
-- 
2.9.0
