Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25133 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdBWVcs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2017 16:32:48 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        james puthukattukaran <james.puthukattukaran@oracle.com>,
        Yinghai Lu <yinghai.lu@oracle.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI,pciehp: Not write linkctrl register if val is changed
Date: Thu, 23 Feb 2017 13:32:28 -0800
Message-Id: <20170223213228.11467-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most system have port link enabled by default, and should not
have confusing printout.

Also move printout before actully write, so could make debug print in order.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -336,17 +336,21 @@ int pciehp_check_link_status(struct cont
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_ctrl;
+	u16 lnk_ctrl, old_lnk_ctrl;
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
+	old_lnk_ctrl = lnk_ctrl;
 
 	if (enable)
 		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
 	else
 		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
 
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
+	if (old_lnk_ctrl == lnk_ctrl)
+		return 0;
+
 	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
+	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
 	return 0;
 }
 
