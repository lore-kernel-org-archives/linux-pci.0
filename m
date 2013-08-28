Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:37081 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3H1T11 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 15:27:27 -0400
Received: by mail-yh0-f51.google.com with SMTP id c41so1755166yho.38
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 12:27:26 -0700 (PDT)
Subject: [PATCH 4/4] PCI: Remove pcie_cap_has_devctl()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yuval Mintz <yuvalmin@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>
Date: Wed, 28 Aug 2013 13:27:23 -0600
Message-ID: <20130828192723.5895.68711.stgit@bhelgaas-glaptop>
In-Reply-To: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
References: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie_cap_has_devctl() does nothing, so remove it.  Simplicity over
consistency in this case.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 061da8c..0857ca9 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -475,11 +475,6 @@ static inline int pcie_cap_version(const struct pci_dev *dev)
 	return pcie_caps_reg(dev) & PCI_EXP_FLAGS_VERS;
 }
 
-static inline bool pcie_cap_has_devctl(const struct pci_dev *dev)
-{
-	return true;
-}
-
 static inline bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
@@ -521,7 +516,7 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:
 	case PCI_EXP_DEVSTA:
-		return pcie_cap_has_devctl(dev);
+		return true;
 	case PCI_EXP_LNKCAP:
 	case PCI_EXP_LNKCTL:
 	case PCI_EXP_LNKSTA:

