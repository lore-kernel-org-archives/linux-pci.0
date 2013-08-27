Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:50622 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab3H0Qrg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 12:47:36 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5117823pdj.12
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 09:47:35 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yuval Mintz <yuvalmin@broadcom.com>,
	"jacob . e . keller @ intel . com" <jacob.e.keller@intel.com>,
	Yu Zhao <yu.zhao@intel.com>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>,
	"linux-pci @ vger . kernel . org" <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: correctly check availability of PCIe Link Cap/Status/Control registers
Date: Wed, 28 Aug 2013 00:44:43 +0800
Message-Id: <1377621883-6707-1-git-send-email-liuj97@gmail.com>
In-Reply-To: <CAErSpo6pCzw6Gjn+SCFhu7PnBpHkUz0oqO+tGmmOH8NxoMiH6g@mail.gmail.com>
References: <CAErSpo6pCzw6Gjn+SCFhu7PnBpHkUz0oqO+tGmmOH8NxoMiH6g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <jiang.liu@huawei.com>

PCIe Base Spec 1.0 Section 5.8 states that "The PCI Express Capabilities,
Device Capabilities, Device Status/Control, Link Capabilities and
Link Status/Control registers are required for all PCI Express devices."

And PCIe Base Spec 3.0 Section 7.8 states that "The Link Capabilities,
Link Status, and Link Control registers are required for all Root Ports,
Switch Ports, Bridges, and Endpoints that are not Root Complex Integrated
Endpoints."

Changeset 1b6b8ce2ac372e "PCI: only save/restore existent registers in the
PCIe capability" introduces pcie_cap_has_lnkctl(), which assumes:
1) PCIe root port, endpoint and legacy endpoint with 1.0 PCIe Capability
   implement Link Cap/Status/Control registers.
2) All PCIe devices with 2.0 PCIe Capability implemnet Link Cap/Status/
   Control registers.

The above assumptions don't conform to PCIe base specifications, so change
pcie_cap_has_lnkctl() to follow PCIe specifications.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
Hi Bjorn,
	Yuval has a PCIe 1.0 swither, so triggers the bug.  I'm not sure
why Yu Zhao has implemented pcie_cap_has_linctl() in that way, any special
consideration here?

Hi Yuval,
	Could you please help to test this patch? Due to hardware resource
constraints, I have just compiled the patch on my laptop without testing.

Thanks!

---
 drivers/pci/access.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 1cc2366..23ff366 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -484,10 +484,14 @@ static inline bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return pcie_cap_version(dev) > 1 ||
-	       type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_ENDPOINT ||
-	       type == PCI_EXP_TYPE_LEG_END;
+	return	pcie_cap_version(dev) == 1 ||
+		type == PCI_EXP_TYPE_ENDPOINT ||
+		type == PCI_EXP_TYPE_LEG_END ||
+		type == PCI_EXP_TYPE_ROOT_PORT ||
+		type == PCI_EXP_TYPE_UPSTREAM ||
+		type == PCI_EXP_TYPE_DOWNSTREAM ||
+		type == PCI_EXP_TYPE_PCI_BRIDGE ||
+		type == PCI_EXP_TYPE_PCIE_BRIDGE;
 }
 
 static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
-- 
1.8.1.2

