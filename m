Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        james puthukattukaran <james.puthukattukaran@oracle.com>,
        Yinghai Lu <yinghai.lu@oracle.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2] PCI,pciehp: Not write linkctrl register if val is not changed
Date: Thu, 23 Feb 2017 13:37:47 -0800
Message-Id: <20170223213747.12154-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most system have port link enabled by default, and should not
have confusing printout.

Also move printout before actully write, so could make debug print in order.

-v2: inline __pciehp_link_set into pciehp_link_enable

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -333,28 +333,23 @@ int pciehp_check_link_status(struct cont
 	return 0;
 }
 
-static int __pciehp_link_set(struct controller *ctrl, bool enable)
+static int pciehp_link_enable(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_ctrl;
+	u16 lnk_ctrl, old_lnk_ctrl;
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
+	old_lnk_ctrl = lnk_ctrl;
 
-	if (enable)
-		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
-	else
-		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
+	lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
+	if (old_lnk_ctrl == lnk_ctrl)
+		return 0;
 
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
 	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
+	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
 	return 0;
 }
 
-static int pciehp_link_enable(struct controller *ctrl)
-{
-	return __pciehp_link_set(ctrl, true);
-}
-
 int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 				    u8 *status)
 {
