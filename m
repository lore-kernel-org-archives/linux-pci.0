Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121C4ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558D2147D
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C558D2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeITWKv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:21062 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731798AbeITWKv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918216"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:34 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 12/12] PCI: Make link active reporting detection generic
Date:   Thu, 20 Sep 2018 10:27:17 -0600
Message-Id: <20180920162717.31066-13-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The spec has timing requirements when waiting for a link to become
active after a conventional reset. This patch implements those hard
delays when waiting for an active link so pciehp and dpc drivers don't
need to duplicate this.

Since downstream ports that are HPC and DPC capable exist that do not
implement data link layer active reporting, the pci driver will wait
a fixed recommend time if the device reports it does not have link
reporing capabilities.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp.h     |  6 ------
 drivers/pci/hotplug/pciehp_hpc.c | 22 ++--------------------
 drivers/pci/pci.c                | 33 +++++++++++++++++++++++++++------
 drivers/pci/pcie/dpc.c           |  4 +++-
 drivers/pci/probe.c              |  1 +
 include/linux/pci.h              |  1 +
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 3740f1a759c5..75fd52571107 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -62,11 +62,6 @@ do {									\
  * struct controller - PCIe hotplug controller
  * @pcie: pointer to the controller's PCIe port service device
  * @slot_cap: cached copy of the Slot Capabilities register
- * @link_active_reporting: cached copy of Data Link Layer Link Active Reporting
- *	Capable bit in Link Capabilities register; if this bit is zero, the
- *	Data Link Layer Link Active bit in the Link Status register will never
- *	be set and the driver is thus confined to wait 1 second before assuming
- *	the link to a hotplugged device is up and accessing it
  * @slot_ctrl: cached copy of the Slot Control register
  * @ctrl_lock: serializes writes to the Slot Control register
  * @cmd_started: jiffies when the Slot Control register was last written;
@@ -103,7 +98,6 @@ struct controller {
 	struct pcie_device *pcie;
 
 	u32 slot_cap;				/* capabilities and quirks */
-	unsigned int link_active_reporting:1;
 
 	u16 slot_ctrl;				/* control register access */
 	struct mutex ctrl_lock;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7b5f9db60d9a..f0f3f4a3dac4 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -214,13 +214,6 @@ bool pciehp_check_link_active(struct controller *ctrl)
 	return ret;
 }
 
-static void pcie_wait_link_active(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-
-	pcie_wait_for_link(pdev, true);
-}
-
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 {
 	u32 l;
@@ -253,18 +246,9 @@ int pciehp_check_link_status(struct controller *ctrl)
 	bool found;
 	u16 lnk_status;
 
-	/*
-	 * Data Link Layer Link Active Reporting must be capable for
-	 * hot-plug capable downstream port. But old controller might
-	 * not implement it. In this case, we wait for 1000 ms.
-	*/
-	if (ctrl->link_active_reporting)
-		pcie_wait_link_active(ctrl);
-	else
-		msleep(1000);
+	if (!pcie_wait_for_link(pdev, true))
+		return -1;
 
-	/* wait 100ms before read pci conf, and try in 1s */
-	msleep(100);
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
@@ -865,8 +849,6 @@ struct controller *pcie_init(struct pcie_device *dev)
 
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
-	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
-		ctrl->link_active_reporting = 1;
 
 	/* Clear all remaining event bits in Slot Status register. */
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce4dafbfe2d1..2b4117011313 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4501,21 +4501,42 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
 	bool ret;
 	u16 lnk_status;
 
+	/*
+	 * Some controllers might not implement link active reporting. In this
+	 * case, we wait for 1000 + 100 ms.
+	 */
+	if (!pdev->link_active_reporting) {
+		msleep(1100);
+		return true;
+	}
+
+	/*
+	 * PCIe 4.0r1 6.6.1, a component must enter LTSSM Detect within 20ms,
+	 * after which we should expect an link active if the reset was
+	 * successful. If so, software must wait a minimum 100ms before sending
+	 * configuration requests to devices downstream this port.
+	 *
+	 * If the link fails to activate, either the device was physically
+	 * removed or the link is permanently failed.
+	 */
+	if (active)
+		msleep(20);
 	for (;;) {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
 		ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
 		if (ret == active)
-			return true;
+			break;
 		if (timeout <= 0)
 			break;
 		msleep(10);
 		timeout -= 10;
 	}
-
-	pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
-		 active ? "set" : "cleared");
-
-	return false;
+	if (active && ret)
+		msleep(100);
+	else if (ret != active)
+		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
+			active ? "set" : "cleared");
+	return ret == active;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 23e063aefddf..e435d12e61a0 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -140,10 +140,12 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
+	if (!pcie_wait_for_link(pdev, true))
+		return PCI_ERS_RESULT_DISCONNECT;
+
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
 	struct device *dev = &dpc->dev->device;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7c422ccbf9b4..ea2a6289e513 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -713,6 +713,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
+		bridge->link_active_reporting = !!(linkcap & PCI_EXP_LNKCAP_DLLLARC);
 
 		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
 		pcie_update_link_speed(bus, linksta);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..896b42032ec5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -402,6 +402,7 @@ struct pci_dev {
 	unsigned int	has_secondary_link:1;
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
 	unsigned int	is_probed:1;		/* Device probing in progress */
+	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.14.4

