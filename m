Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:34423 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab3KEWdc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 17:33:32 -0500
Message-ID: <52797238.8070304@gmail.com>
Date: Tue, 05 Nov 2013 14:33:28 -0800
From: Rajat Jain <rajatjain.linux@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: Guenter Roeck <groeck@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In case of a spurious "cmd completed", pcie_write_cmd() does not
clear it, but yet expects more "cmd completed" events to be generated.
This does not happen because the previous (spurious) event has not
been acknowledged. Fix that.

Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
---
This is how I saw it in action: my controller does not implement any
hot-plug elements (LED, power ctrl, EMI etc) but still supports Command
completed bit.
 - During initialization,
      pcie_disable_notification()
      -> pcie_write_cmd()
         -> writes to Slot control register
            -> which causes PCI_EXP_SLTSTA_CC to get set, which is not
               cleared, because IRQ is not generated (we just disabled
               notifications).
 - After some time,
      pcie_enable_notification()
      -> pcie_write_cmd()
          -> finds PCI_EXP_SLTSTA_CC is set, assumes it is spurious.
          -> Does not clear it, yet expects more command completed
             events to be generated (never happens).

 drivers/pci/hotplug/pciehp_hpc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5b8d749..ba8e06f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -185,6 +185,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	}
 
 	if (slot_status & PCI_EXP_SLTSTA_CC) {
+		pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
 		if (!ctrl->no_cmd_complete) {
 			/*
 			 * After 1 sec and CMD_COMPLETED still not set, just
-- 
1.7.9.5

