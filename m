Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25587 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbbGOJWT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 05:22:19 -0400
Date: Wed, 15 Jul 2015 14:59:46 +0530
From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI / ACPI: Fix pci_acpi_optimize_delay() comment
Message-ID: <20150715092915.GA8262@intel-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function takes ACPI handle, not the device itself. Fix the
comment

Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
---
Add this as part of your trivial commenting fixes patch series

 drivers/pci/pci-acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 6f6f175f51f7..d2e2bf4ef0a4 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -594,7 +594,7 @@ static struct acpi_device *acpi_pci_find_companion(struct device *dev)
 /**
  * pci_acpi_optimize_delay - optimize PCI D3 and D3cold delay from ACPI
  * @pdev: the PCI device whose delay is to be updated
- * @adev: the companion ACPI device of this PCI device
+ * @handle: ACPI handle of this device
  *
  * Update the d3_delay and d3cold_delay of a PCI device from the ACPI _DSM
  * control method of either the device itself or the PCI host bridge.
-- 
1.7.9.5


-- 
