Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53339 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583AbcAHPyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 10:54:06 -0500
Subject: [PATCH 1/2] PCI: dra7xx: Mark driver as broken
To: Kishon Vijay Abraham I <kishon@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>, linux-pci@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
	Suman Anna <s-anna@ti.com>,
	linux-arm-kernel@lists.infradead.org
Date: Fri, 08 Jan 2016 09:54:02 -0600
Message-ID: <20160108155402.32755.99031.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160108153427.32755.63673.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160108153427.32755.63673.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Cochran <richardcochran@gmail.com>

Mark the dra7xx PCI host driver as broken.  This driver was first merged in
v3.17 and has never worked.  Although the driver compiles just fine, it is
missing an essential device reset.  If the driver is included, the kernel
locks up hard shortly after booting, before any console output appears.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba9..c0ad9aa 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -5,6 +5,7 @@ config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
 	select PCIE_DW
 	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on BROKEN
 	help
 	 Enables support for the PCIe controller in the DRA7xx SoC.  There
 	 are two instances of PCIe controller in DRA7xx.  This controller can

