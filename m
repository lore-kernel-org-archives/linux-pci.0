Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: export devm_request_pci_bus_resources to modules
Date: Mon, 20 Jun 2016 17:45:41 +0200
Message-Id: <20160620154604.2280100-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Host drivers can be loadable modules, so we might run into this
build error with the new interface:

ERROR: devm_request_pci_bus_resources [drivers/pci/host/pcie-iproc.ko] undefined!

This adds an EXPORT_SYMBOL_GPL() line.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 4c42a1013e3b..32efe8f5d5e9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -132,6 +132,7 @@ int devm_request_pci_bus_resources(struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(devm_request_pci_bus_resources);
 
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
 #ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
-- 
2.9.0
