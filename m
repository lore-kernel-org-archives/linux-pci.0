Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56840 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbcGFMne (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 08:43:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: artpec: add PCI_MSI_IRQ_DOMAIN dependency
Date: Wed,  6 Jul 2016 14:46:04 +0200
Message-Id: <20160706124640.1521466-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The designware PCIe driver requires MSI support, so we get a warning
for the artpec6 glue driver if that is not enabled:

warning: (PCIE_ARTPEC6) selects PCIE_DW which has unmet direct dependencies (PCI && PCI_MSI_IRQ_DOMAIN)

This adds the same dependency that all other such drivers have.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c917e2fede05..a1ef0c06dbb4 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -258,6 +258,7 @@ config PCIE_ARMADA_8K
 config PCIE_ARTPEC6
 	bool "Axis ARTPEC-6 PCIe controller"
 	depends on MACH_ARTPEC6
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW
 	select PCIEPORTBUS
 	help
-- 
2.9.0

