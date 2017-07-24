Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37003 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdGXAju (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2017 20:39:50 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] PCI: xilinx: Remove platform/architecture restrictions
Date: Sun, 23 Jul 2017 17:39:37 -0700
Message-Id: <1500856777-23383-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The MIPS Boston board configuration tries to enable CONFIG_PCIE_XILINX.
That doesn't work since PCIE_XILINX depends on ARCH_ZYNQ || MICROBLAZE.
Remove that restriction.

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/pci/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 89d61c2cbfaa..ed905a5401c3 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -71,7 +71,6 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ || MICROBLAZE
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.7.4
