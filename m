Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:35070 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdEPRVN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2017 13:21:13 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] PCI: endpoint: PCI_ENDPOINT should depend on HAS_DMA
Date: Tue, 16 May 2017 19:21:08 +0200
Message-Id: <1494955268-1262-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If NO_DMA=y:

    drivers/built-in.o: In function `__pci_epc_create':
    (.text+0xef4e): undefined reference to `bad_dma_ops'
    drivers/built-in.o: In function `pci_epc_add_epf':
    (.text+0xf676): undefined reference to `bad_dma_ops'
    drivers/built-in.o: In function `pci_epf_alloc_space':
    (.text+0xfa32): undefined reference to `bad_dma_ops'
    drivers/built-in.o: In function `pci_epf_free_space':
    (.text+0xfac4): undefined reference to `bad_dma_ops'

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Should PCI_ENDPOINT depend on CONFIG_PCI instead?
---
 drivers/pci/endpoint/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
index c23f146fb5a668b3..c09623ca8c3b14b9 100644
--- a/drivers/pci/endpoint/Kconfig
+++ b/drivers/pci/endpoint/Kconfig
@@ -6,6 +6,7 @@ menu "PCI Endpoint"
 
 config PCI_ENDPOINT
 	bool "PCI Endpoint Support"
+	depends on HAS_DMA
 	help
 	   Enable this configuration option to support configurable PCI
 	   endpoint. This should be enabled if the platform has a PCI
-- 
2.7.4
