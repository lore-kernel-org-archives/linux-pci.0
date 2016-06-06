Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51763 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932242AbcFFXHC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 19:07:02 -0400
Subject: [PATCH v1 18/25] PCI: mvebu: Request host bridge window resources
 with core function
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Rob Herring <robh@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-kernel@vger.kernel.org, rfi@lists.rocketboards.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms@verge.net.au>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
	linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-arm-kernel@lists.infradead.org
Date: Mon, 06 Jun 2016 18:06:58 -0500
Message-ID: <20160606230658.20936.52000.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use devm_request_pci_bus_resources() to request host bridge window
resources instead of doing it by hand in the driver.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6b451df..2287a4e 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -839,25 +839,22 @@ static struct pci_ops mvebu_pcie_ops = {
 static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(sys);
-	int i;
+	int err, i;
 
 	pcie->mem.name = "PCI MEM";
 	pcie->realio.name = "PCI I/O";
 
-	if (request_resource(&iomem_resource, &pcie->mem))
-		return 0;
-
-	if (resource_size(&pcie->realio) != 0) {
-		if (request_resource(&ioport_resource, &pcie->realio)) {
-			release_resource(&pcie->mem);
-			return 0;
-		}
+	if (resource_size(&pcie->realio) != 0)
 		pci_add_resource_offset(&sys->resources, &pcie->realio,
 					sys->io_offset);
-	}
+
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
 	pci_add_resource(&sys->resources, &pcie->busn);
 
+	err = devm_request_pci_bus_resources(&pcie->pdev->dev, &sys->resources);
+	if (err)
+		return 0;
+
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 

