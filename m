Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:60372 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbJSWkG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2015 18:40:06 -0400
From: Kamal Mostafa <kamal@canonical.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Meelis Roos <mroos@linux.ee>,
	Kamal Mostafa <kamal@canonical.com>,
	kernel-team@lists.ubuntu.com
Subject: [3.19.y-ckt stable] Patch "PCI,parisc: Enable 64-bit bus addresses on PA-RISC" has been added to staging queue
Date: Mon, 19 Oct 2015 15:40:02 -0700
Message-Id: <1445294402-17778-1-git-send-email-kamal@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a note to let you know that I have just added a patch titled

    PCI,parisc: Enable 64-bit bus addresses on PA-RISC

to the linux-3.19.y-queue branch of the 3.19.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.19.y-queue

This patch is scheduled to be released in version 3.19.8-ckt8.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.19.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From 45e91a63ffcd2e8de52804365d618391d3880475 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Wed, 2 Sep 2015 18:17:29 +0200
Subject: PCI,parisc: Enable 64-bit bus addresses on PA-RISC

commit e02a653e15d8d32e9e768fd99a3271aafe5c5d77 upstream.

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
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/parisc/lba_pci.c | 7 +++++--
 drivers/pci/Kconfig      | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

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
--
1.9.1

