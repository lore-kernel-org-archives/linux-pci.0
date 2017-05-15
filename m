Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:60291 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752885AbdEOQpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 May 2017 12:45:04 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 15 May 2017 10:44:53 -0600
Message-Id: <1494866693-2850-3-git-send-email-logang@deltatee.com>
In-Reply-To: <1494866693-2850-1-git-send-email-logang@deltatee.com>
References: <1494866693-2850-1-git-send-email-logang@deltatee.com>
Subject: [PATCH 2/2] switchtec: fix minor bug with partition id register
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a switch endpoind is configured without NTB the mmio_ntb registers
will read all zeros. However, in corner case configurations where the
partition ID is not zero and NTB is not enabled then the code will have
the wrong partition ID and this causes the driver to use the wrong
set of drivers. To fix this we simply take the partition ID from the
system info region.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reported-by: Dingbao Chen <dingbao.chen@microsemi.com>
---
 drivers/pci/switch/switchtec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index abaa227a..f6a6340 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1441,12 +1441,15 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	stdev->mmio_sys_info = stdev->mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
 	stdev->mmio_flash_info = stdev->mmio + SWITCHTEC_GAS_FLASH_INFO_OFFSET;
 	stdev->mmio_ntb = stdev->mmio + SWITCHTEC_GAS_NTB_OFFSET;
-	stdev->partition = ioread8(&stdev->mmio_ntb->partition_id);
+	stdev->partition = ioread8(&stdev->mmio_sys_info->partition_id);
 	stdev->partition_count = ioread8(&stdev->mmio_ntb->partition_count);
 	stdev->mmio_part_cfg_all = stdev->mmio + SWITCHTEC_GAS_PART_CFG_OFFSET;
 	stdev->mmio_part_cfg = &stdev->mmio_part_cfg_all[stdev->partition];
 	stdev->mmio_pff_csr = stdev->mmio + SWITCHTEC_GAS_PFF_CSR_OFFSET;
 
+	if (stdev->partition_count < 1)
+		stdev->partition_count = 1;
+
 	init_pff(stdev);
 
 	pci_set_drvdata(pdev, stdev);
-- 
2.1.4
