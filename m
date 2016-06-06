Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 10/25] PCI: xilinx-nwl: Free bridge resource list on failure
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 06 Jun 2016 18:05:59 -0500
Message-ID: <20160606230559.20936.29055.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, Scott Branden <sbranden@broadcom.com>,
 Jon Mason <jonmason@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, linux-kernel@vger.kernel.org,
 rfi@lists.rocketboards.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>,
 Tanmay Inamdar <tinamdar@apm.com>, Ray Jui <rjui@broadcom.com>,
 linux-tegra@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
 Michal Simek <michal.simek@xilinx.com>,
 =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

of_pci_get_host_bridge_resources() allocates a list of resources for host
bridge windows.  If we fail after allocating that list, free it before we
return error.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 3479d30..506da7b 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -832,20 +832,22 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	err = nwl_pcie_init_irq_domain(pcie);
 	if (err) {
 		dev_err(pcie->dev, "Failed creating IRQ Domain\n");
-		return err;
+		goto error;
 	}
 
 	bus = pci_create_root_bus(&pdev->dev, pcie->root_busno,
 				  &nwl_pcie_ops, pcie, &res);
-	if (!bus)
-		return -ENOMEM;
+	if (!bus) {
+		err = -ENOMEM;
+		goto error;
+	}
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie, bus);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"failed to enable MSI support: %d\n", err);
-			return err;
+			goto error;
 		}
 	}
 	pci_scan_child_bus(bus);
@@ -855,6 +857,10 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	pci_bus_add_devices(bus);
 	platform_set_drvdata(pdev, pcie);
 	return 0;
+
+error:
+	pci_free_resource_list(&res);
+	return err;
 }
 
 static int nwl_pcie_remove(struct platform_device *pdev)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
