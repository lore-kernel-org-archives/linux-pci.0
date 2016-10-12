Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755356AbcJLMrf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 08:47:35 -0400
Subject: [PATCH v2 4/6] PCI: altera: Rename altera_pcie_valid_config() to
 altera_pcie_valid_device()
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Wed, 12 Oct 2016 07:47:31 -0500
Message-ID: <20161012124731.23240.70876.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123804.23240.96181.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename altera_pcie_valid_config() to altera_pcie_valid_device().
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 931c51e..a99765a 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -131,7 +131,7 @@ static void tlp_write_tx(struct altera_pcie *pcie,
 	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
 }
 
-static bool altera_pcie_valid_config(struct altera_pcie *pcie,
+static bool altera_pcie_valid_device(struct altera_pcie *pcie,
 				     struct pci_bus *bus, int dev)
 {
 	/* If there is no link, then there is no device */
@@ -342,7 +342,7 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
+	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
 		*value = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -359,7 +359,7 @@ static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
+	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	return _altera_pcie_cfg_write(pcie, bus->number, devfn, where, size,

