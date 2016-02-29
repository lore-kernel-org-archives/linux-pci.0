Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63660 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbcB2M4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 07:56:11 -0500
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/6] PCI: No need to set d3cold_allowed to PCIe ports
Date: Mon, 29 Feb 2016 14:56:01 +0200
Message-Id: <1456750566-116248-2-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe ports are already skipped by the PCI core so they are never moved to
D3 (or D3cold) anyway. No need to set the field.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index be35da2e105e..6c6bb03392ea 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -134,11 +134,6 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		return status;
 
 	pci_save_state(dev);
-	/*
-	 * D3cold may not work properly on some PCIe port, so disable
-	 * it by default.
-	 */
-	dev->d3cold_allowed = false;
 	return 0;
 }
 
-- 
2.7.0

