Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:40168 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200Ab3KZSDE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Nov 2013 13:03:04 -0500
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: mvebu - The bridge secondary status register should be 0
Date: Tue, 26 Nov 2013 11:02:52 -0700
Message-Id: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are no writable bits in the secondary status register, only
write 1 to clear bits. The driver never sets any of the write 1 to
clear bits so the status register should always be 0, just remove
the set from the write path.

Someday the write 1 to clear bits should be copied/cleared directly
from registers in the HW.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/pci/host/pci-mvebu.c | 1 -
 1 file changed, 1 deletion(-)

Thomas: This was the last patch in my set that you haven't reviewed. Thanks

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index c269e43..6f5a20f 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -500,7 +500,6 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 		 */
 		bridge->iobase = (value & 0xff) | PCI_IO_RANGE_TYPE_32;
 		bridge->iolimit = ((value >> 8) & 0xff) | PCI_IO_RANGE_TYPE_32;
-		bridge->secondary_status = value >> 16;
 		mvebu_pcie_handle_iobase_change(port);
 		break;
 
-- 
1.8.1.2

