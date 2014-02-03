Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55343 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaBCHHd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2014 02:07:33 -0500
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7B9753EE181
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2014 16:07:32 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D1F745DEB5
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2014 16:07:32 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5588445DD77
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2014 16:07:32 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 44BDC1DB803B
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2014 16:07:32 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id ED5881DB8038
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2014 16:07:31 +0900 (JST)
Date: Mon, 3 Feb 2014 16:07:24 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com, yinghai@kernel.org
Subject: [PATCH] PCI: pciehp: Fix the problem that the present bit is not
 cleared though slot is empty
Message-Id: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


I found the problem that the present bit does not be cleared
though the slot is empty.

 Step to reproduce:

  # cd /sys/bus/pci/slots/66
  # cat adapter
  0
  --- (insert PCIe card on slot#66) ---
  # cat adapter
  1
  # echo 1 > power
  # echo 0 > power
  --- (eject PCIe card on slot#66) ---
  # cat adapter
  1
    ==> should be 0.

According to git-bisect this is caused by:
    2debd9289997fc5d1c0043b41201a8b40d5e11d0
       PCI: pciehp: Disable/enable link during slot power off/on
    is the first bad commit

By reverting the above patch, this bug can be solved.
And I also found this can be fixed by changing the timing of link-disable
during power off the slot.
So, this patch changes the timing of link-disable during power off.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 14acfcc..163f0b4 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -508,7 +508,12 @@ void pciehp_power_off_slot(struct slot * slot)
 {
 	struct controller *ctrl = slot->ctrl;
 
-	/* Disable the link at first */
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_OFF);
+
+	/* Disable the link */
 	pciehp_link_disable(ctrl);
 	/* wait the link is down */
 	if (ctrl->link_active_reporting)
@@ -516,10 +521,6 @@ void pciehp_power_off_slot(struct slot * slot)
 	else
 		msleep(1000);
 
-	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_OFF);
 }
 
 static irqreturn_t pcie_isr(int irq, void *dev_id)
-- 
1.8.3.1

