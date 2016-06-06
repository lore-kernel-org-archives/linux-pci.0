Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59205 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbcFFNH3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 09:07:29 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/4] PCI / DPC: Fix whitespace in struct dpc_dev
Date: Mon,  6 Jun 2016 16:06:08 +0300
Message-Id: <1465218368-36494-5-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1465218368-36494-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is unnecesary space before tab in the two lines. Remove these.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/pcie-dpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 8a061645f217..197d9ec18713 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -15,8 +15,8 @@
 
 struct dpc_dev {
 	struct pcie_device	*dev;
-	struct work_struct 	work;
-	int 			cap_pos;
+	struct work_struct	work;
+	int			cap_pos;
 };
 
 static void dpc_wait_link_inactive(struct pci_dev *pdev)
-- 
2.8.1

