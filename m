Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48056 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469AbcGFQGR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Jul 2016 12:06:17 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] pcie/dpc: Remove tristate module option
Date: Wed,  6 Jul 2016 10:06:01 -0600
Message-Id: <1467821161-25458-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1467821161-25458-1-git-send-email-keith.busch@intel.com>
References: <1467821161-25458-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch changes the config type from tristate too bool. The driver
doesn't automatically load based on any rules, so it needs to be built-in
in order to bind to devices it needs to drive.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 22ca641..7fcea75 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -83,7 +83,7 @@ config PCIE_PME
 	depends on PCIEPORTBUS && PM
 
 config PCIE_DPC
-	tristate "PCIe Downstream Port Containment support"
+	bool "PCIe Downstream Port Containment support"
 	depends on PCIEPORTBUS
 	default n
 	help
@@ -92,6 +92,3 @@ config PCIE_DPC
 	  will be handled by the DPC driver.  If your system doesn't
 	  have this capability or you do not want to use this feature,
 	  it is safe to answer N.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pcie-dpc.
-- 
2.7.2

