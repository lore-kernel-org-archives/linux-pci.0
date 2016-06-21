Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH 2/2] PCI: rcar: Drop gen2 dummy I/O port region
To: Simon Horman <horms@verge.net.au>, Russell King <linux@armlinux.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 21 Jun 2016 12:01:50 -0500
Message-ID: <20160621170150.7997.4821.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160621165646.7997.44001.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160621165646.7997.44001.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Valentine Barshak <valentine.barshak@cogentembedded.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Previously we added a dummy I/O port region even though the R-Car
controller doesn't support PCI port I/O.  This resulted in bogus root bus
resources like this:

  pci_bus 0000:00: root bus resource [io  0xee080000-0xee0810ff]
  pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]

Drop the unused dummy I/O port region and set struct hw_pci.io_optional so
the ARM PCI code doesn't add a default one for us.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-rcar-gen2.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 9980a4b..ddf7765 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -97,7 +97,6 @@
 struct rcar_pci_priv {
 	struct device *dev;
 	void __iomem *reg;
-	struct resource io_res;
 	struct resource mem_res;
 	struct resource *cfg_res;
 	unsigned busnr;
@@ -273,7 +272,6 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
 		rcar_pci_setup_errirq(priv);
 
 	/* Add PCI resources */
-	pci_add_resource(&sys->resources, &priv->io_res);
 	pci_add_resource(&sys->resources, &priv->mem_res);
 
 	/* Setup bus number based on platform device id / of bus-range */
@@ -371,14 +369,6 @@ static int rcar_pci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->mem_res = *mem_res;
-	/*
-	 * The controller does not support/use port I/O,
-	 * so setup a dummy port I/O region here.
-	 */
-	priv->io_res.start = priv->mem_res.start;
-	priv->io_res.end = priv->mem_res.end;
-	priv->io_res.flags = IORESOURCE_IO;
-
 	priv->cfg_res = cfg_res;
 
 	priv->irq = platform_get_irq(pdev, 0);
@@ -421,6 +411,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	hw_private[0] = priv;
 	memset(&hw, 0, sizeof(hw));
 	hw.nr_controllers = ARRAY_SIZE(hw_private);
+	hw.io_optional = 1;
 	hw.private_data = hw_private;
 	hw.map_irq = rcar_pci_map_irq;
 	hw.ops = &rcar_pci_ops;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
