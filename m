Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35424 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdLIXn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Dec 2017 18:43:59 -0500
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/3] PCI: introduce a device-managed version of pci_set_mwi
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9eee5aba-a739-a609-fd65-76666f377ed1@gmail.com>
Message-ID: <3e560e2b-7f11-74e2-6db5-60c8479dc59b@gmail.com>
Date: Sun, 10 Dec 2017 00:43:48 +0100
MIME-Version: 1.0
In-Reply-To: <9eee5aba-a739-a609-fd65-76666f377ed1@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce a device-managed version of pci_set_mwi. First user is the
Realtek r8169 driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.c   | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c6864f..fc57c378d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1458,6 +1458,7 @@ struct pci_devres {
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
+	unsigned int mwi:1;
 	u32 region_mask;
 };
 
@@ -1476,6 +1477,9 @@ static void pcim_release(struct device *gendev, void *res)
 		if (this->region_mask & (1 << i))
 			pci_release_region(dev, i);
 
+	if (this->mwi)
+		pci_clear_mwi(dev);
+
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
@@ -3760,6 +3764,31 @@ int pci_set_mwi(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_set_mwi);
 
+/**
+ * pcim_set_mwi - Managed pci_set_mwi()
+ * @dev: the PCI device for which MWI is enabled
+ *
+ * Managed pci_set_mwi().
+ *
+ * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
+ */
+int pcim_set_mwi(struct pci_dev *dev)
+{
+	struct pci_devres *dr;
+	int ret;
+
+	ret = pci_set_mwi(dev);
+	if (ret)
+		return ret;
+
+	dr = find_pci_dr(dev);
+	if (dr)
+		dr->mwi = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(pcim_set_mwi);
+
 /**
  * pci_try_set_mwi - enables memory-write-invalidate PCI transaction
  * @dev: the PCI device for which MWI is enabled
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 978aad784..0a7ac863a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1064,6 +1064,7 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state);
 int pci_set_cacheline_size(struct pci_dev *dev);
 #define HAVE_PCI_SET_MWI
 int __must_check pci_set_mwi(struct pci_dev *dev);
+int __must_check pcim_set_mwi(struct pci_dev *dev);
 int pci_try_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_intx(struct pci_dev *dev, int enable);
-- 
2.15.1
