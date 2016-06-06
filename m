Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 23/25] PCI: tegra: Request host bridge window resources
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
Date: Mon, 06 Jun 2016 18:07:36 -0500
Message-ID: <20160606230736.20936.41942.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use devm_request_pci_bus_resources() to request host bridge window
resources instead of doing it by hand in the driver.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 920a899..048a35e 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -626,17 +626,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	if (err < 0)
 		return err;
 
-	err = devm_request_resource(pcie->dev, &ioport_resource, &pcie->pio);
-	if (err < 0)
-		return err;
-
-	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->mem);
-	if (err < 0)
-		return err;
-
-	err = devm_request_resource(pcie->dev, &iomem_resource, &pcie->prefetch);
-	if (err)
-		return err;
+	pci_ioremap_io(pcie->pio.start, pcie->io.start);
 
 	pci_add_resource_offset(&sys->resources, &pcie->pio, sys->io_offset);
 	pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem_offset);
@@ -644,7 +634,9 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 				sys->mem_offset);
 	pci_add_resource(&sys->resources, &pcie->busn);
 
-	pci_ioremap_io(pcie->pio.start, pcie->io.start);
+	err = devm_request_pci_bus_resources(&pcie->dev, &sys->resources);
+	if (err < 0)
+		return err;
 
 	return 1;
 }
