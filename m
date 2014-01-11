Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48283 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB1H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:27:07 -0500
Received: by mail-pa0-f42.google.com with SMTP id lj1so5499974pab.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:06 -0800 (PST)
Subject: [PATCH v2 03/12] PCI: Remove unused Optimized Buffer Flush/Fill
 support
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Fri, 10 Jan 2014 18:27:03 -0700
Message-ID: <20140111012703.14505.20187.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This reverts 48a92a8179b3 ("PCI: add OBFF enable/disable support"),
removing these interfaces:

    pci_enable_obff()
    pci_disable_obff()

[bhelgaas: split to separate patch, also remove prototypes from pci.h]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/pci/pci.c   |   73 ---------------------------------------------------
 include/linux/pci.h |   16 -----------
 2 files changed, 89 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 020f672deabb..84a24d16778f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2150,79 +2150,6 @@ void pci_disable_ido(struct pci_dev *dev, unsigned long type)
 }
 EXPORT_SYMBOL(pci_disable_ido);
 
-/**
- * pci_enable_obff - enable optimized buffer flush/fill
- * @dev: PCI device
- * @type: type of signaling to use
- *
- * Try to enable @type OBFF signaling on @dev.  It will try using WAKE#
- * signaling if possible, falling back to message signaling only if
- * WAKE# isn't supported.  @type should indicate whether the PCIe link
- * be brought out of L0s or L1 to send the message.  It should be either
- * %PCI_EXP_OBFF_SIGNAL_ALWAYS or %PCI_OBFF_SIGNAL_L0.
- *
- * If your device can benefit from receiving all messages, even at the
- * power cost of bringing the link back up from a low power state, use
- * %PCI_EXP_OBFF_SIGNAL_ALWAYS.  Otherwise, use %PCI_OBFF_SIGNAL_L0 (the
- * preferred type).
- *
- * RETURNS:
- * Zero on success, appropriate error number on failure.
- */
-int pci_enable_obff(struct pci_dev *dev, enum pci_obff_signal_type type)
-{
-	u32 cap;
-	u16 ctrl;
-	int ret;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_DEVCAP2_OBFF_MASK))
-		return -ENOTSUPP; /* no OBFF support at all */
-
-	/* Make sure the topology supports OBFF as well */
-	if (dev->bus->self) {
-		ret = pci_enable_obff(dev->bus->self, type);
-		if (ret)
-			return ret;
-	}
-
-	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctrl);
-	if (cap & PCI_EXP_DEVCAP2_OBFF_WAKE)
-		ctrl |= PCI_EXP_DEVCTL2_OBFF_WAKE_EN;
-	else {
-		switch (type) {
-		case PCI_EXP_OBFF_SIGNAL_L0:
-			if (!(ctrl & PCI_EXP_DEVCTL2_OBFF_WAKE_EN))
-				ctrl |= PCI_EXP_DEVCTL2_OBFF_MSGA_EN;
-			break;
-		case PCI_EXP_OBFF_SIGNAL_ALWAYS:
-			ctrl &= ~PCI_EXP_DEVCTL2_OBFF_WAKE_EN;
-			ctrl |= PCI_EXP_DEVCTL2_OBFF_MSGB_EN;
-			break;
-		default:
-			WARN(1, "bad OBFF signal type\n");
-			return -ENOTSUPP;
-		}
-	}
-	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, ctrl);
-
-	return 0;
-}
-EXPORT_SYMBOL(pci_enable_obff);
-
-/**
- * pci_disable_obff - disable optimized buffer flush/fill
- * @dev: PCI device
- *
- * Disable OBFF on @dev.
- */
-void pci_disable_obff(struct pci_dev *dev)
-{
-	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
-				   PCI_EXP_DEVCTL2_OBFF_WAKE_EN);
-}
-EXPORT_SYMBOL(pci_disable_obff);
-
 static int pci_acs_enable;
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ee26454746ba..b8cbe52c7a48 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1002,13 +1002,6 @@ static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 void pci_enable_ido(struct pci_dev *dev, unsigned long type);
 void pci_disable_ido(struct pci_dev *dev, unsigned long type);
 
-enum pci_obff_signal_type {
-	PCI_EXP_OBFF_SIGNAL_L0 = 0,
-	PCI_EXP_OBFF_SIGNAL_ALWAYS = 1,
-};
-int pci_enable_obff(struct pci_dev *dev, enum pci_obff_signal_type);
-void pci_disable_obff(struct pci_dev *dev);
-
 /* For use by arch with custom probe code */
 void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
@@ -1427,15 +1420,6 @@ static inline void pci_disable_ido(struct pci_dev *dev, unsigned long type)
 {
 }
 
-static inline int pci_enable_obff(struct pci_dev *dev, unsigned long type)
-{
-	return 0;
-}
-
-static inline void pci_disable_obff(struct pci_dev *dev)
-{
-}
-
 static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
 {
 	return -EIO;

