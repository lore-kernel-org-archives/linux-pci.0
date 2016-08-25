Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:41602 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757043AbcHYFWW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Aug 2016 01:22:22 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        jonathan.yong@intel.com
Subject: [PATCH] PCI: Export pci_enable_ptm
Date: Thu, 25 Aug 2016 03:41:35 +0000
Message-Id: <1472096495-42916-2-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1472096495-42916-1-git-send-email-jonathan.yong@intel.com>
References: <1472096495-42916-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Export symbol so device drivers outside of the core pci subsystem
can use it.

Signed-off-by: Yong, Jonathan <jonathan.yong@intel.com>
---
 drivers/pci/pcie/ptm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 3b83024..bab8ac6 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -139,3 +139,4 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 		*granularity = dev->ptm_granularity;
 	return 0;
 }
+EXPORT_SYMBOL(pci_enable_ptm);
-- 
2.7.3

