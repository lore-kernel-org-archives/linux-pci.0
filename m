Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932403AbcLMAcu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Dec 2016 19:32:50 -0500
From: Vaibhav Shankar <vaibhav.shankar@intel.com>
To: bhelgaas@google.com, vaibhav.shankar@intel.com,
        mayurkumar.patel@intel.com, keith.busch@intel.com, lukas@wunner.de,
        yinghai@kernel.org, yhlu.kernel@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: pciehp: Optimize PCIe root resume time
Date: Mon, 12 Dec 2016 16:32:25 -0800
Message-Id: <1481589145-22109-1-git-send-email-vaibhav.shankar@intel.com>
In-Reply-To: <20161211011908.GA10954@linux-siqj.site>
References: <20161211011908.GA10954@linux-siqj.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Apollolake platforms, PCIe rootport takes a long time to resume
from S3. With 100ms delay before read pci conf, rootport takes
~200ms during resume.

commit 2f5d8e4ff947 ("PCI: pciehp: replace unconditional sleep with
config space access check") is the one that added the 100ms delay
before reading pci conf.

This patch includes a condition check for 100ms dealy before reading
PCIe conf. This delay in included only when PCIe
max_bus_speed > 5.0 GT/s. Root port takes ~16ms during resume.

With 100ms delay:
[  155.102713] calling  0000:00:14.0+ @ 70, parent: pci0000:00, cb: pci_pm_resume_noirq
[  155.119337] call 0000:00:14.0+ returned 0 after 16231 usecs
[  155.119467] calling  0000:01:00.0+ @ 5845, parent: 0000:00:14.0, cb: pci_pm_resume_noirq
[  155.321670] call 0000:00:14.0+ returned 0 after 185327 usecs
[  155.321743] calling  0000:01:00.0+ @ 5849, parent: 0000:00:14.0, cb: pci_pm_resume

With Condition check:
[   36.624709] calling 0000:00:14.0+ @ 4434, parent: pci0000:00, cb: pci_pm_resume_noirq
[   36.641367] call 0000:00:14.0+ returned 0 after 16263 usecs
[   36.652458] calling 0000:00:14.0+ @ 4443, parent: pci0000:00, cb: pci_pm_resume
[   36.652673] call 0000:00:14.0+ returned 0 after 208 usecs
[   36.652863] calling  0000:01:00.0+ @ 4442, parent: 0000:00:14.0, cb: pci_pm_resume

Signed-off-by: Vaibhav Shankar <vaibhav.shankar@intel.com>
---
changes in v2:
        - Modify patch description.
        - Add condition check for 100ms delay before read pci conf as
          suggested by Yinghai.

 drivers/pci/hotplug/pciehp_hpc.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b57fc6d..2b10e5f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -311,8 +311,15 @@ int pciehp_check_link_status(struct controller *ctrl)
 	else
 		msleep(1000);
 
-	/* wait 100ms before read pci conf, and try in 1s */
-	msleep(100);
+	/*
+	 * If the port supports Link speeds greater than 5.0 GT/s, we
+	 * must wait for 100 ms after Link training completes before
+	 * sending configuration request.
+	 */
+	if (ctrl->pcie->port->subordinate->max_bus_speed > PCIE_SPEED_5_0GT)
+		msleep(100);
+
+	/* try in 1s */
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-- 
1.7.9.5

