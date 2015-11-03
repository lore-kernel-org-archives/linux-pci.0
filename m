Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60294 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbKCOJG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2015 09:09:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ley Foon Tan <lftan@altera.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] PCI: altera: add OF_PCI dependency
Date: Tue, 03 Nov 2015 15:08:33 +0100
Message-ID: <38421064.oVjju5M930@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The newly added altera PCI driver fails to build when CONFIG_OF
is disabled:

drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
drivers/pci/host/pcie-altera.c:420:8: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]

This adds a dependency on OF_PCI for clarity, this is the symbol
that guards the implementation of of_pci_get_host_bridge_resources.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6bb4dd154ae8 ("PCI: altera: Add Altera PCIe host controller driver")
---
Found on ARM randconfig builds yesterday

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 9e24075d83f7..f131ba947dc6 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -150,6 +150,7 @@ config PCIE_IPROC_BCMA
 config PCIE_ALTERA
 	bool "Altera PCIe controller"
 	depends on ARM || NIOS2
+	depends on OF_PCI
 	select PCI_DOMAINS
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera

