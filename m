Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753234AbcJGQW7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:22:59 -0400
Subject: [PATCH 08/10] PCI: altera: Rename altera_pcie_valid_config() to
 altera_pcie_valid_device()
To: Ley Foon Tan <lftan@altera.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, rfi@lists.rocketboards.org
Date: Fri, 07 Oct 2016 11:22:50 -0500
Message-ID: <20161007162250.22796.57750.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162153.22796.13721.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename altera_pcie_valid_config() to altera_pcie_valid_device().

No functional change intended; for readability only.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-altera.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index bcc056b..90ab581 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -135,7 +135,7 @@ static void tlp_write_tx(struct altera_pcie *altera,
 	altera_cra_writel(altera, RP_TX_CNTRL, tlp_rp_regdata->ctrl);
 }
 
-static bool altera_pcie_valid_config(struct altera_pcie *altera,
+static bool altera_pcie_valid_device(struct altera_pcie *altera,
 				     struct pci_bus *bus, int dev)
 {
 	/* If there is no link, then there is no device */
@@ -336,7 +336,7 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(altera, bus, PCI_SLOT(devfn))) {
+	if (!altera_pcie_valid_device(altera, bus, PCI_SLOT(devfn))) {
 		*value = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -353,7 +353,7 @@ static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(altera, bus, PCI_SLOT(devfn)))
+	if (!altera_pcie_valid_device(altera, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	return altera_raw_cfg_write(altera, bus->number, devfn, where, size,

