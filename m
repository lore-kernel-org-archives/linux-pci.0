Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38748 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935235Ab3E2VzM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 May 2013 17:55:12 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so26279151iec.22
        for <linux-pci@vger.kernel.org>; Wed, 29 May 2013 14:55:11 -0700 (PDT)
Subject: [PATCH] ia64/PCI: Remove unused fallback_dev
To: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org
Date: Wed, 29 May 2013 15:55:02 -0600
Message-ID: <20130529215502.4977.2759.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are no users of fallback_dev, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/kernel/pci-dma.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 1ddcfe5..992c109 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -33,15 +33,6 @@ int force_iommu __read_mostly;
 
 int iommu_pass_through;
 
-/* Dummy device used for NULL arguments (normally ISA). Better would
-   be probably a smaller DMA mask, but this is bug-to-bug compatible
-   to i386. */
-struct device fallback_dev = {
-	.init_name = "fallback device",
-	.coherent_dma_mask = DMA_BIT_MASK(32),
-	.dma_mask = &fallback_dev.coherent_dma_mask,
-};
-
 extern struct dma_map_ops intel_dma_ops;
 
 static int __init pci_iommu_init(void)

