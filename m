Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758460Ab3BNSfr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Feb 2013 13:35:47 -0500
Subject: [PATCH] pci: Fix pcie access for PCI_EXP_FLAGS
To: bhelgaas@google.com, linux-pci@vger.kernel.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, jiang.liu@huawei.com
Date: Thu, 14 Feb 2013 11:35:42 -0700
Message-ID: <20130214183438.16138.15416.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_EXP_FLAGS_TYPE is a mask, not an offset.  Fix it.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/access.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 3af0478..32046c5 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -515,7 +515,7 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
 		return false;
 
 	switch (pos) {
-	case PCI_EXP_FLAGS_TYPE:
+	case PCI_EXP_FLAGS:
 		return true;
 	case PCI_EXP_DEVCAP:
 	case PCI_EXP_DEVCTL:

