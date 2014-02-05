Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45079 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbaBECaI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2014 21:30:08 -0500
Message-ID: <52F1A22C.3090202@gmail.com>
Date: Tue, 04 Feb 2014 18:30:04 -0800
From: Rajat Jain <rajatxjain@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>
CC: Guenter Roeck <groeck@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: [PATCH v4 4/8] pciehp: Don't disable the link permanently, during
 removal
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need future link up events for hot-add, thus don't disable
the link permanently during device removal. Also, remove the static
functions that are now left unused.

This reverts part of 2debd9289997 ("PCI: pciehp: Disable/enable link
during slot power off/on"). This was dicussed at
http://marc.info/?l=linux-pci&m=138963477507425&w=2
where it was revealed that it was done for a bug in a pcie repeater
chip on that particular platform.

Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
---
 drivers/pci/hotplug/pciehp_hpc.c |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 245a3cb..15ca3a1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -242,11 +242,6 @@ static void pcie_wait_link_active(struct controller *ctrl)
 	__pcie_wait_link_active(ctrl, true);
 }
 
-static void pcie_wait_link_not_active(struct controller *ctrl)
-{
-	__pcie_wait_link_active(ctrl, false);
-}
-
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 {
 	u32 l;
@@ -332,11 +327,6 @@ static int pciehp_link_enable(struct controller *ctrl)
 	return __pciehp_link_set(ctrl, true);
 }
 
-static int pciehp_link_disable(struct controller *ctrl)
-{
-	return __pciehp_link_set(ctrl, false);
-}
-
 void pciehp_get_attention_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
@@ -508,14 +498,6 @@ void pciehp_power_off_slot(struct slot * slot)
 {
 	struct controller *ctrl = slot->ctrl;
 
-	/* Disable the link at first */
-	pciehp_link_disable(ctrl);
-	/* wait the link is down */
-	if (ctrl->link_active_reporting)
-		pcie_wait_link_not_active(ctrl);
-	else
-		msleep(1000);
-
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-- 
1.7.9.5

