Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:35093 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbcBCLdV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 06:33:21 -0500
From: Paul Burton <paul.burton@imgtec.com>
To: <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC: Paul Burton <paul.burton@imgtec.com>,
	Ley Foon Tan <lftan@altera.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Phil Edworthy" <phil.edworthy@renesas.com>,
	Scott Branden <sbranden@broadcom.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	<linux-kernel@vger.kernel.org>, "Duc Dang" <dhdang@apm.com>,
	<linux-pci@vger.kernel.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>,
	"Hauke Mehrtens" <hauke@hauke-m.de>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 09/15] PCI: xilinx: Allow build on MIPS platforms
Date: Wed, 3 Feb 2016 11:30:39 +0000
Message-ID: <1454499045-5020-10-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
used on the MIPS Boston board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a6054..0aee193 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -81,7 +81,7 @@ config PCI_KEYSTONE
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || MIPS
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
-- 
2.7.0

