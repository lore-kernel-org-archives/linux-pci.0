Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755360AbeASLKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 06:10:45 -0500
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v6 7/7] PCI: Unify wait for link active into generic pci
Date: Fri, 19 Jan 2018 16:40:04 +0530
Message-Id: <1516360204-1586-8-git-send-email-poza@codeaurora.org>
In-Reply-To: <1516360204-1586-1-git-send-email-poza@codeaurora.org>
References: <1516360204-1586-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Clients such as pciehp, dpc are using pcie_wait_link_active, which waits
till the link becomes active or inactive.

Made generic function and moved it to drivers/pci/pci.c

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7bab060..26afeff 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -245,25 +245,12 @@ bool pciehp_check_link_active(struct controller *ctrl)
 	return ret;
 }
 
-static void __pcie_wait_link_active(struct controller *ctrl, bool active)
+static bool pcie_wait_link_active(struct controller *ctrl)
 {
-	int timeout = 1000;
-
-	if (pciehp_check_link_active(ctrl) == active)
-		return;
-	while (timeout > 0) {
-		msleep(10);
-		timeout -= 10;
-		if (pciehp_check_link_active(ctrl) == active)
-			return;
-	}
-	ctrl_dbg(ctrl, "Data Link Layer Link Active not %s in 1000 msec\n",
-			active ? "set" : "cleared");
-}
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	bool active = true;
 
-static void pcie_wait_link_active(struct controller *ctrl)
-{
-	__pcie_wait_link_active(ctrl, true);
+	return pci_wait_for_link(pdev, active);
 }
 
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c686..0de83ea 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2805,7 +2805,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
 
 	/* Source Validation */
-	ctrl |= (cap & PCI_ACS_SV);
+//	ctrl |= (cap & PCI_ACS_SV);
 
 	/* P2P Request Redirect */
 	ctrl |= (cap & PCI_ACS_RR);
@@ -4079,6 +4079,43 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/**
+ * pci__wait_for_link - Wait for link till its active/inactive
+ * @dev: Bridge device
+ * @active: waiting for active or inactive ?
+ *
+ * Use this to wait till link becomes active or inactive.
+ */
+
+bool pci_wait_for_link(struct pci_dev *pdev, bool active)
+{
+	int timeout = 1000;
+	bool ret;
+	u16 lnk_status;
+
+check_link:
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	if (ret == active) {
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "%s: lnk_status = %x\n", __func__, lnk_status);
+		return true;
+	}
+
+	while (timeout > 0) {
+		msleep(10);
+		timeout -= 10;
+		goto check_link;
+	}
+	dev_printk(KERN_DEBUG, &pdev->dev,
+		   "Data Link Layer Link Active not %s in 1000 msec\n",
+		   active ? "set" : "cleared");
+
+	return false;
+}
+EXPORT_SYMBOL(pci_wait_for_link);
+
 void pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	u16 ctrl;
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 1b06a8e..67502a5 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -150,37 +150,9 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 	struct pci_dev *pdev = dpc->dev->port;
 	struct device *dev = &dpc->dev->device;
 	u16 lnk_status;
+	bool active = false;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	while (lnk_status & PCI_EXP_LNKSTA_DLLLA &&
-					!time_after(jiffies, timeout)) {
-		msleep(10);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	}
-	if (lnk_status & PCI_EXP_LNKSTA_DLLLA)
-		dev_warn(dev, "Link state not disabled for DPC event\n");
-}
-
-static bool dpc_wait_link_active(struct pci_dev *pdev)
-{
-	unsigned long timeout = jiffies + HZ;
-	u16 lnk_status;
-	bool ret = true;
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-
-	while (!(lnk_status & PCI_EXP_LNKSTA_DLLLA) &&
-					!time_after(jiffies, timeout)) {
-		msleep(10);
-		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	}
-
-	if (!(lnk_status & PCI_EXP_LNKSTA_DLLLA)) {
-		dev_warn(&pdev->dev, "Link state not enabled after DPC event\n");
-		ret = false;
-	}
-
-	return ret;
+	pci_wait_for_link(pdev, active);
 }
 
 /**
@@ -191,7 +163,9 @@ static bool dpc_wait_link_active(struct pci_dev *pdev)
  */
 static void dpc_error_resume(struct pci_dev *pdev)
 {
-	if (dpc_wait_link_active(pdev)) {
+	bool active = true;
+
+	if (pci_wait_for_link(pdev, active)) {
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pdev->bus);
 		pci_unlock_rescan_remove();
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c170c92..f9f6a3d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1201,6 +1201,7 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
 int pci_request_selected_regions(struct pci_dev *, int, const char *);
 int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
+bool pci_wait_for_link(struct pci_dev *pdev, bool active);
 
 /* drivers/pci/bus.c */
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
