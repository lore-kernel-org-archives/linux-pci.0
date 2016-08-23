Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755134AbcHWWWZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Aug 2016 18:22:25 -0400
Subject: [PATCH 1/2] PCI: designware: Rename dw_pcie_valid_config() to
 dw_pcie_valid_device()
To: Ley Foon Tan <lftan@altera.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, rfi@lists.rocketboards.org,
        linux-pci@vger.kernel.org
Date: Tue, 23 Aug 2016 17:10:01 -0500
Message-ID: <20160823221001.16374.62205.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160823220620.16374.70369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160823220620.16374.70369.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename dw_pcie_valid_config() to dw_pcie_valid_device() and use the result
directly as a boolean value instead of testing against 0.

No functional change intended; for readability only.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..d09f376 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -657,8 +657,8 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return ret;
 }
 
-static int dw_pcie_valid_config(struct pcie_port *pp,
-				struct pci_bus *bus, int dev)
+static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
+				int dev)
 {
 	/* If there is no link, then there is no device */
 	if (bus->number != pp->root_bus_nr) {
@@ -685,7 +685,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 {
 	struct pcie_port *pp = bus->sysdata;
 
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
+	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -701,7 +701,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 {
 	struct pcie_port *pp = bus->sysdata;
 
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
+	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (bus->number == pp->root_bus_nr)

