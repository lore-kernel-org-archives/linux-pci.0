Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47102 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab3LFUWz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Dec 2013 15:22:55 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] PCI, pciehp: Turn on link a while to workaround presense detection
Date: Fri,  6 Dec 2013 12:22:37 -0800
Message-Id: <1386361357-7767-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During hotplug test on platform, found slot status register does not
report present status correctly. That present bit does not get cleared
even after that card is removed.

That problem is caused by commit:
| commit 2debd9289997fc5d1c0043b41201a8b40d5e11d0
|
|    PCI: pciehp: Disable/enable link during slot power off/on

It looks like chipset bug, that PresDet bit is "OR" operation between
sideband input from FPGA, and chipset inband detection from pcie link.
It does not like if we disable pcie link at first and power off
other side device, and it has input from inband detection
always 1.

Workaround: Try turn on link a while after power off.

After this patch, PresDet report correct status when removing or adding
card later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: <stable@vger.kernel.org> 3.4+

---
 drivers/pci/hotplug/pciehp_hpc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -637,6 +637,15 @@ int pciehp_power_off_slot(struct slot *
 	}
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+
+	/*
+	 * Enable link for a while so chipset could settle down
+	 * inband presence detection logic
+	 */
+	pciehp_link_enable(ctrl);
+	msleep(20);
+	pciehp_link_disable(ctrl);
+
 	return 0;
 }
 
