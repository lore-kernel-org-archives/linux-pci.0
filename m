Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:36224 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab2G3VaE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2012 17:30:04 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] PCI, pciehp: turn on link again after power off the slot
Date: Mon, 30 Jul 2012 14:29:57 -0700
Message-Id: <1343683797-19017-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During debugging hotplug surpise support, found slot status reg does not report
present status anymore after removing the card. That present bit
does not get cleared even that card is removed. So no interrupt is generated
later after reinsert the card.

That problem is caused by commit:
| commit 2debd9289997fc5d1c0043b41201a8b40d5e11d0
|
|    PCI: pciehp: Disable/enable link during slot power off/on

Try turn on link after power off.
With the fix present bit will report correctly, also still avoid the aer
during the power off.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: stable@vger.kernel.org

---
 drivers/pci/hotplug/pciehp_hpc.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -631,6 +631,8 @@ int pciehp_power_off_slot(struct slot *
 	slot_cmd = POWER_OFF;
 	cmd_mask = PCI_EXP_SLTCTL_PCC;
 	retval = pcie_write_cmd(ctrl, slot_cmd, cmd_mask);
+	/* need to enable link again for present bit report */
+	pciehp_link_enable(ctrl);
 	if (retval) {
 		ctrl_err(ctrl, "Write command failed!\n");
 		return retval;
