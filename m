Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbcJLNRz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:17:55 -0400
Subject: [PATCH v2 01/10] PCI: designware: Rename dw_pcie_valid_config() to
 dw_pcie_valid_device()
To: Joao Pinto <jpinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:17:50 -0500
Message-ID: <20161012131750.26443.65705.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012131616.26443.89407.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename dw_pcie_valid_config() to dw_pcie_valid_device() and use the result
directly as a boolean value instead of testing against 0.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 74da71e..b58f078 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -760,8 +760,8 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return ret;
 }
 
-static int dw_pcie_valid_config(struct pcie_port *pp,
-				struct pci_bus *bus, int dev)
+static int dw_pcie_valid_device(struct pcie_port *pp, struct pci_bus *bus,
+				int dev)
 {
 	/* If there is no link, then there is no device */
 	if (bus->number != pp->root_bus_nr) {
@@ -781,7 +781,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 {
 	struct pcie_port *pp = bus->sysdata;
 
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
+	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -797,7 +797,7 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 {
 	struct pcie_port *pp = bus->sysdata;
 
-	if (dw_pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
+	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (bus->number == pp->root_bus_nr)

