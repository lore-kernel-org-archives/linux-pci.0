Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:45840 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdFBS4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2017 14:56:12 -0400
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v4 4/4] PCI: xilinx: Allow build on MIPS platforms
Date: Fri, 2 Jun 2017 11:54:19 -0700
Message-ID: <20170602185420.22281-5-paul.burton@imgtec.com>
In-Reply-To: <20170602185420.22281-1-paul.burton@imgtec.com>
References: <20170602185420.22281-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow the xilinx-pcie driver to be built on MIPS platforms which make
use of generic PCI drivers rather than legacy MIPS-specific interfaces.
This is used on the MIPS Boston development board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
Cc: linux-pci@vger.kernel.org

---

Changes in v4:
- Depend on PCI_DRIVERS_GENERIC, which the driver won't work on MIPS without.

Changes in v3:
- Split out from Boston patchset.

Changes in v2: None

 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7f47cd5e10a5..22d4405914ec 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -71,7 +71,7 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ || MICROBLAZE
+	depends on ARCH_ZYNQ || MICROBLAZE || (MIPS && PCI_DRIVERS_GENERIC)
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.13.0
