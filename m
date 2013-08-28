Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:51323 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3H1T1M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 15:27:12 -0400
Received: by mail-yh0-f54.google.com with SMTP id b20so801701yha.27
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 12:27:11 -0700 (PDT)
Subject: [PATCH 2/4] PCI: Remove PCIe Capability version checks
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yuval Mintz <yuvalmin@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>
Date: Wed, 28 Aug 2013 13:27:08 -0600
Message-ID: <20130828192708.5895.51049.stgit@bhelgaas-glaptop>
In-Reply-To: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
References: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we relied on the PCIe r3.0, sec 7.8, spec language that says
"For Functions that do not implement the [Link, Slot, Root] registers,
these spaces must be hardwired to 0b," which means that for v2 PCIe
capabilities, we don't need to check the device type at all.

But it's simpler if we don't need to check the capability version at all,
and I think the spec is explicit enough about which registers are required
for which types that we can remove the version checks.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index e26c3bd..9a46fa9 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -484,8 +484,7 @@ static inline bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ENDPOINT ||
+	return type == PCI_EXP_TYPE_ENDPOINT ||
 	       type == PCI_EXP_TYPE_LEG_END ||
 	       type == PCI_EXP_TYPE_ROOT_PORT ||
 	       type == PCI_EXP_TYPE_UPSTREAM ||
@@ -498,8 +497,7 @@ static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
+	return type == PCI_EXP_TYPE_ROOT_PORT ||
 	       (type == PCI_EXP_TYPE_DOWNSTREAM &&
 		pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT);
 }
@@ -508,8 +506,7 @@ static inline bool pcie_cap_has_rtctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
+	return type == PCI_EXP_TYPE_ROOT_PORT ||
 	       type == PCI_EXP_TYPE_RC_EC;
 }
 

