Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zimbra1.kalray.eu ([92.103.151.219]:47004 "EHLO
        zimbra1.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeCULLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 07:11:05 -0400
Date: Wed, 21 Mar 2018 12:00:49 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Message-ID: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu>
Subject: [RFC PATCH] nvme: avoid race-conditions when enabling devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

NVMe driver uses threads for the work at device reset, including enabling
the PCIe device. When multiple NVMe devices are initialized, their reset
works may be scheduled in parallel. Then pci_enable_device_mem can be
called in parallel on multiple cores.

This causes a loop of enabling of all upstream bridges in
pci_enable_bridge(). pci_enable_bridge() causes multiple operations
including __pci_set_master and architecture-specific functions that
call ones like and pci_enable_resources(). Both __pci_set_master()
and pci_enable_resources() read PCI_COMMAND field in the PCIe space
and change it. This is done as read/modify/write.

Imagine that the PCIe tree looks like:
A - B - switch -  C - D
               \- E - F

D and F are two NVMe disks and all devices from B are not enabled and bus
mastering is not set. If their reset work are scheduled in parallel the two
modifications of PCI_COMMAND may happen in parallel without locking and the
system may end up with the part of PCIe tree not enabled.

The problem may also happen if other device is initialized in parallel to
a nvme disk.

This fix moves pci_enable_device_mem to the probe part of the driver that
is run sequentially to avoid the issue.

Signed-off-by: Marta Rybczynska <marta.rybczynska@kalray.eu>
Signed-off-by: Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b6f43b7..af53854 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2515,6 +2515,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	/*
+	 * Enable the device now to make sure that all accesses to bridges above
+	 * are done without races
+	 */
+	result = pci_enable_device_mem(pdev);
+	if (result)
+		goto release_pools;
+
 	nvme_reset_ctrl(&dev->ctrl);
 
 	return 0;
-- 
1.8.3.1
