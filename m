Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11043 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbcEQVkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 17:40:02 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
Date: Tue, 17 May 2016 15:39:59 -0600
Message-Id: <1463521199-16604-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Registers a standard boiler-plate SR-IOV configure callback for NVMe.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/nvme/host/pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbe8cc2..8379b9a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2033,6 +2033,18 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
+static int nvme_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	int ret = 0;
+
+	if (numvfs == 0)
+		pci_disable_sriov(pdev);
+	else
+		ret = pci_enable_sriov(pdev, numvfs);
+
+	return ret ? ret : numvfs;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2127,6 +2139,7 @@ static struct pci_driver nvme_driver = {
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
+	.sriov_configure = nvme_sriov_configure,
 	.err_handler	= &nvme_err_handler,
 };
 
-- 
2.7.2

