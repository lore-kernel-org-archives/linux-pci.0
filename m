Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35192 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbcF3NOk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 09:14:40 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: tegra: Use pci_remap_iospace()
Date: Thu, 30 Jun 2016 15:14:29 +0200
Message-Id: <20160630131430.32096-2-thierry.reding@gmail.com>
In-Reply-To: <20160630131430.32096-1-thierry.reding@gmail.com>
References: <20160630131430.32096-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Use the pci_remap_iospace() function provided by the PCI core, rather
than the 32-bit ARM-specific pci_ioremap_io().

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 9595518f541d..f04b062e8c67 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -645,7 +645,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 				sys->mem_offset);
 	pci_add_resource(&sys->resources, &pcie->busn);
 
-	pci_ioremap_io(pcie->pio.start, pcie->io.start);
+	pci_remap_iospace(&pcie->pio, pcie->io.start);
 
 	return 1;
 }
-- 
2.8.3

