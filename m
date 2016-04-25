Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55193 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754248AbcDYJxf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Apr 2016 05:53:35 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 1/4] PCI: No need to set d3cold_allowed to PCIe ports
Date: Mon, 25 Apr 2016 12:53:21 +0300
Message-Id: <1461578004-129094-2-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Linux PCI core skips PCI bridges and PCIe ports when system is
suspended. The PCI core checks return value of pci_has_subordinate() in
pci_pm_suspend_noirq() to skip all devices where it is non-zero (which
means PCI bridges and PCIe ports).

Since PCIe ports are never suspended in the first place, there is no need
to set d3cold_allowed for them.

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
2.8.0.rc3

