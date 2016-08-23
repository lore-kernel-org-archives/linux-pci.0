Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755046AbcHWWWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Aug 2016 18:22:25 -0400
Subject: [PATCH 2/2] PCI: altera: Rename altera_pcie_valid_config() to
 altera_pcie_valid_device()
To: Ley Foon Tan <lftan@altera.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, rfi@lists.rocketboards.org,
        linux-pci@vger.kernel.org
Date: Tue, 23 Aug 2016 17:10:22 -0500
Message-ID: <20160823221022.16374.78101.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160823220620.16374.70369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160823220620.16374.70369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index 2b78376..3b4b662 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -158,7 +158,7 @@ static void tlp_write_tx(struct altera_pcie *pcie,
 	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
 }
 
-static bool altera_pcie_valid_config(struct altera_pcie *pcie,
+static bool altera_pcie_valid_device(struct altera_pcie *pcie,
 				     struct pci_bus *bus, int dev)
 {
 	/* If there is no link, then there is no device */
@@ -312,7 +312,7 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn))) {
+	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
 		*value = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -360,7 +360,7 @@ static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
 	if (altera_pcie_hide_rc_bar(bus, devfn, where))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
+	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	switch (size) {

