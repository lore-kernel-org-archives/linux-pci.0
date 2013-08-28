Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57447 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab3H1RZs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 13:25:48 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so6561822pdj.35
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 10:25:47 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yuval Mintz <yuvalmin@broadcom.com>,
	"jacob . e . keller @ intel . com" <jacob.e.keller@intel.com>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>,
	"linux-pci @ vger . kernel . org" <linux-pci@vger.kernel.org>
Subject: [PATCH v2] PCI: correctly check availability of PCIe Link Cap/Status/Control registers
Date: Thu, 29 Aug 2013 01:23:13 +0800
Message-Id: <1377710593-9758-1-git-send-email-liuj97@gmail.com>
In-Reply-To: <CAErSpo7YhokZip4gEo=_gva+26UZF5vfNa-yeLg=UPMspaf06g@mail.gmail.com>
References: <CAErSpo7YhokZip4gEo=_gva+26UZF5vfNa-yeLg=UPMspaf06g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

According to PCIe Base Specification 3.0, devices are guarenteed to
return zero for unimplemented V2 PCI Express Capability registers.
But there's no such guarantee for unimplemented V1 PCI Express
Capability registers, so we need to explicitly check availability of
V1 PCI Express Capability registers and return zero for unimplemented
registers.

Changeset 1b6b8ce2ac372e "PCI: only save/restore existent registers in
the PCIe capability" introduces pcie_cap_has_lnkctl(), which assumes that
PCIe root port, endpoint and legacy endpoint with 1.0 PCIe Capability
implement Link Cap/Status/Control registers.

On the other hand, section 7.8 of PCIe Base Spec V1.1 and V3.0 states that
"The Link Capabilities, Link Status, and Link Control registers are
required for all Root Ports, Switch Ports, Bridges, and Endpoints that
are not Root Complex Integrated Endpoints."
That means Link Capability/Status/Control registers are also available
for PCIe Upstream Port, Downstream Port, PCIe-to-PCI bridge and PCI-to-PCIe
bridge. So change pcie_cap_has_lnkctl() to follow PCIe specifications.

Also refine pcie_cap_has_sltctl() and pcie_cap_has_rtctl() for readability.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Reported-by: Yuval Mintz <yuvalmin@broadcom.com>
---
 drivers/pci/access.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 1cc2366..b9af3d1 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -470,6 +470,13 @@ void pci_cfg_access_unlock(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_cfg_access_unlock);
 
+/*
+ * According to PCIe base spec 3.0, devices are guarenteed to return zero for
+ * unimplemented V2 PCI Express Capability registers. But there's no such
+ * guarantee for unimplemented V1 PCI Express Capability registers, so
+ * explicitly check availability of V1 PCI Express Capability registers
+ * and return zero for unimplemented registers.
+ */
 static inline int pcie_cap_version(const struct pci_dev *dev)
 {
 	return pcie_caps_reg(dev) & PCI_EXP_FLAGS_VERS;
@@ -484,29 +491,39 @@ static inline bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_ENDPOINT ||
-	       type == PCI_EXP_TYPE_LEG_END;
+	if (pcie_cap_version(dev) == 1)
+		return	type == PCI_EXP_TYPE_ENDPOINT ||
+			type == PCI_EXP_TYPE_LEG_END ||
+			type == PCI_EXP_TYPE_ROOT_PORT ||
+			type == PCI_EXP_TYPE_UPSTREAM ||
+			type == PCI_EXP_TYPE_DOWNSTREAM ||
+			type == PCI_EXP_TYPE_PCI_BRIDGE ||
+			type == PCI_EXP_TYPE_PCIE_BRIDGE;
+
+	return true;
 }
 
 static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
-	       (type == PCI_EXP_TYPE_DOWNSTREAM &&
-		pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT);
+	if (pcie_cap_version(dev) == 1)
+		return type == PCI_EXP_TYPE_ROOT_PORT ||
+		       (type == PCI_EXP_TYPE_DOWNSTREAM &&
+			pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT);
+
+	return true;
 }
 
 static inline bool pcie_cap_has_rtctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_RC_EC;
+	if (pcie_cap_version(dev) == 1)
+		return type == PCI_EXP_TYPE_ROOT_PORT ||
+		       type == PCI_EXP_TYPE_RC_EC;
+
+	return true;
 }
 
 static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
-- 
1.8.1.2

