Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62211 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965135AbbKDMjz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 07:39:55 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, Ley Foon Tan <lftan@altera.com>
Subject: [PATCH] PCI: altera: use fwnode API for pci_msi_create_irq_domain
Date: Wed, 04 Nov 2015 13:39:42 +0100
Message-ID: <4309044.Hy8Vx01ZVW@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is a new conflict between Thomas Gleixner's IRQ tree that contains
a patch from Marc Zyngier to change the prototype for
pci_msi_create_irq_domain, and Bjorn Helgaas' PCI tree that contains
a new driver for the Altera PCI MSI host, with the old interface,
as gcc now warns in linux-next:

drivers/pci/host/pcie-altera-msi.c: In function 'altera_allocate_domains':
drivers/pci/host/pcie-altera-msi.c:191:46: warning: passing argument 1 of 'pci_msi_create_irq_domain' from incompatible pointer type [-Wincompatible-pointer-types]
  msi->msi_domain = pci_msi_create_irq_domain(msi->pdev->dev.of_node,
include/linux/msi.h:286:20: note: expected 'struct fwnode_handle *' but argument is of type 'struct device_node *'

This changes the new driver use the modified API.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: af1169b48b17 ("PCI: altera: Add Altera PCIe MSI driver")
Fixes: be5436c83ac8 ("irqdomain/msi: Use fwnode instead of of_node")
---
This conflict seems to be new in linux-next today. Any idea how to resolve it?

I think either Bjorn merges the msi-map-4.4 of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms and uses this
as the resolution, or whichever pull request comes second should let Linus
know about the conflict so he can do it when merging both.

diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
index 2c37e8620c37..99177f4ccde2 100644
--- a/drivers/pci/host/pcie-altera-msi.c
+++ b/drivers/pci/host/pcie-altera-msi.c
@@ -181,6 +181,8 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int altera_allocate_domains(struct altera_msi *msi)
 {
+	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->pdev->dev.of_node);
+
 	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
@@ -188,7 +190,7 @@ static int altera_allocate_domains(struct altera_msi *msi)
 		return -ENOMEM;
 	}
 
-	msi->msi_domain = pci_msi_create_irq_domain(msi->pdev->dev.of_node,
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
 				&altera_msi_domain_info, msi->inner_domain);
 	if (!msi->msi_domain) {
 		dev_err(&msi->pdev->dev, "failed to create MSI domain\n");

