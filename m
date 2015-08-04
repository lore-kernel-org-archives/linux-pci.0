Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36814 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbHDVya (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 17:54:30 -0400
Received: by ioeg141 with SMTP id g141so31183172ioe.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 14:54:30 -0700 (PDT)
Subject: [PATCH v5 5/9] PCI/MSI: Remove unused pcibios_msi_controller() hook
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <james.morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>
Date: Tue, 04 Aug 2015 16:54:28 -0500
Message-ID: <20150804215428.9189.60846.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

The pcibios_msi_controller() hook was only implemented by ARM, and it sets
pci_bus->msi now, so it doesn't need this hook anymore.

Remove the unused pcibios_msi_controller() hook.

[bhelgaas: changelog, split into separate patch]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f66be868..0d20142 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -77,24 +77,9 @@ static void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 
 /* Arch hooks */
 
-struct msi_controller * __weak pcibios_msi_controller(struct pci_dev *dev)
-{
-	return NULL;
-}
-
-static struct msi_controller *pci_msi_controller(struct pci_dev *dev)
-{
-	struct msi_controller *msi_ctrl = dev->bus->msi;
-
-	if (msi_ctrl)
-		return msi_ctrl;
-
-	return pcibios_msi_controller(dev);
-}
-
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_controller *chip = pci_msi_controller(dev);
+	struct msi_controller *chip = dev->bus->msi;
 	int err;
 
 	if (!chip || !chip->setup_irq)

