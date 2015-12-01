Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49066 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbbLABnK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Nov 2015 20:43:10 -0500
Subject: [PATCH] PCI/MSI: Remove empty pci_msi_init_pci_dev()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Mon, 30 Nov 2015 19:43:06 -0600
Message-ID: <20151201014306.17812.84340.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

4a7cc8316705 ("genirq/MSI: Move msi_list from struct pci_dev to struct
device") removed the contents of pci_msi_init_pci_dev().  All
implementation of it are now empty, so remove it completely.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c   |    4 ----
 drivers/pci/pci.h   |    2 --
 drivers/pci/probe.c |    3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 53e4632..b64d267 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1024,10 +1024,6 @@ int pci_msi_enabled(void)
 }
 EXPORT_SYMBOL(pci_msi_enabled);
 
-void pci_msi_init_pci_dev(struct pci_dev *dev)
-{
-}
-
 /**
  * pci_enable_msi_range - configure device's MSI capability structure
  * @dev: device to configure
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd2f03f..44d9859 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -144,10 +144,8 @@ extern unsigned int pci_pm_d3_delay;
 
 #ifdef CONFIG_PCI_MSI
 void pci_no_msi(void);
-void pci_msi_init_pci_dev(struct pci_dev *dev);
 #else
 static inline void pci_no_msi(void) { }
-static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
 #endif
 
 static inline void pci_msi_set_enable(struct pci_dev *dev, int enable)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cd94737..88f0fed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1601,9 +1601,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Enhanced Allocation */
 	pci_ea_init(dev);
 
-	/* MSI/MSI-X list */
-	pci_msi_init_pci_dev(dev);
-
 	/* Setup MSI caps & disable MSI/MSI-X interrupts */
 	pci_msi_setup_pci_dev(dev);
 

