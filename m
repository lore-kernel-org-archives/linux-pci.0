Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43066 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB1O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:27:14 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so5278798pdj.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:13 -0800 (PST)
Subject: [PATCH v2 04/12] PCI: Remove unused ID-Based Ordering support
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Fri, 10 Jan 2014 18:27:11 -0700
Message-ID: <20140111012711.14505.25027.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This reverts b48d4425b602 ("PCI: add ID-based ordering enable/disable
support"), removing these interfaces:

    pci_enable_ido()
    pci_disable_ido()

[bhelgaas: split to separate patch, also remove prototypes from pci.h]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/pci/pci.c   |   40 ----------------------------------------
 include/linux/pci.h |   13 -------------
 2 files changed, 53 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 84a24d16778f..6db2f1a441e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2110,46 +2110,6 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
-/**
- * pci_enable_ido - enable ID-based Ordering on a device
- * @dev: the PCI device
- * @type: which types of IDO to enable
- *
- * Enable ID-based ordering on @dev.  @type can contain the bits
- * %PCI_EXP_IDO_REQUEST and/or %PCI_EXP_IDO_COMPLETION to indicate
- * which types of transactions are allowed to be re-ordered.
- */
-void pci_enable_ido(struct pci_dev *dev, unsigned long type)
-{
-	u16 ctrl = 0;
-
-	if (type & PCI_EXP_IDO_REQUEST)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_REQ_EN;
-	if (type & PCI_EXP_IDO_COMPLETION)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_CMP_EN;
-	if (ctrl)
-		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2, ctrl);
-}
-EXPORT_SYMBOL(pci_enable_ido);
-
-/**
- * pci_disable_ido - disable ID-based ordering on a device
- * @dev: the PCI device
- * @type: which types of IDO to disable
- */
-void pci_disable_ido(struct pci_dev *dev, unsigned long type)
-{
-	u16 ctrl = 0;
-
-	if (type & PCI_EXP_IDO_REQUEST)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_REQ_EN;
-	if (type & PCI_EXP_IDO_COMPLETION)
-		ctrl |= PCI_EXP_DEVCTL2_IDO_CMP_EN;
-	if (ctrl)
-		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, ctrl);
-}
-EXPORT_SYMBOL(pci_disable_ido);
-
 static int pci_acs_enable;
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b8cbe52c7a48..f2284f1332db 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -997,11 +997,6 @@ static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 	return __pci_enable_wake(dev, state, false, enable);
 }
 
-#define PCI_EXP_IDO_REQUEST	(1<<0)
-#define PCI_EXP_IDO_COMPLETION	(1<<1)
-void pci_enable_ido(struct pci_dev *dev, unsigned long type);
-void pci_disable_ido(struct pci_dev *dev, unsigned long type);
-
 /* For use by arch with custom probe code */
 void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
@@ -1412,14 +1407,6 @@ static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 	return 0;
 }
 
-static inline void pci_enable_ido(struct pci_dev *dev, unsigned long type)
-{
-}
-
-static inline void pci_disable_ido(struct pci_dev *dev, unsigned long type)
-{
-}
-
 static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
 {
 	return -EIO;

