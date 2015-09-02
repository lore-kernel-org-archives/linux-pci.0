Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:56934 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbbIBQRm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Sep 2015 12:17:42 -0400
Date: Wed, 2 Sep 2015 18:17:29 +0200
From: Helge Deller <deller@gmx.de>
To: linux-parisc@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Meelis Roos <mroos@linux.ee>
Subject: [PATCH] PCI,parisc: Enable 64-bit bus addresses on PA-RISC
Message-ID: <20150902161729.GA2444@ls3530.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 3a9ad0b ("PCI: Add pci_bus_addr_t") unconditionally introduced usage of
64-bit PCI bus addresses on all 64-bit platforms which broke PA-RISC.

It turned out that due to enabling the 64-bit addresses, the PCI logic decided
to use the GMMIO instead of the LMMIO region. This commit simply disables
registering the GMMIO and thus we fall back to use the LMMIO region as before.

Reverts commit 45ea2a5fed6dacb9bb0558d8b21eacc1c45d5bb4
("PCI: Don't use 64-bit bus addresses on PA-RISC")

To: linux-parisc@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Meelis Roos <mroos@linux.ee>
Cc: stable@vger.kernel.org  # v3.19+
Signed-off-by: Helge Deller <deller@gmx.de>


diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index dceb9dd..a32c1f6 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1556,8 +1556,11 @@ lba_driver_probe(struct parisc_device *dev)
 	if (lba_dev->hba.lmmio_space.flags)
 		pci_add_resource_offset(&resources, &lba_dev->hba.lmmio_space,
 					lba_dev->hba.lmmio_space_offset);
-	if (lba_dev->hba.gmmio_space.flags)
-		pci_add_resource(&resources, &lba_dev->hba.gmmio_space);
+	if (lba_dev->hba.gmmio_space.flags) {
+		/* pci_add_resource(&resources, &lba_dev->hba.gmmio_space); */
+		pr_warn("LBA: Not registering GMMIO space %pR\n",
+			&lba_dev->hba.gmmio_space);
+	}
 
 	pci_add_resource(&resources, &lba_dev->hba.bus_num);
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 944f500..73de4ef 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -2,7 +2,7 @@
 # PCI configuration
 #
 config PCI_BUS_ADDR_T_64BIT
-	def_bool y if (ARCH_DMA_ADDR_T_64BIT || (64BIT && !PARISC))
+	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
 	depends on PCI
 
 config PCI_MSI
