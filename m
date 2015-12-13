Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/10] drivers/pci: make host/pcie-xilinx.c explicitly non-modular
Date: Sat, 12 Dec 2015 20:41:55 -0500
Message-ID: <1449970917-12633-9-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_XILINX
drivers/pci/host/Kconfig:       bool "Xilinx AXI PCIe host bridge support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.  This
makes xilinx_pcie_free_irq_domain orphaned so we remove it too.

We don't have to worry about disallowing a driver unbind, since this
driver already does that.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-xilinx.c | 53 ++----------------------------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 3c7a0d580b1e..73b5e856f9c2 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -18,7 +18,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -516,35 +516,6 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 }
 
 /**
- * xilinx_pcie_free_irq_domain - Free IRQ domain
- * @port: PCIe port information
- */
-static void xilinx_pcie_free_irq_domain(struct xilinx_pcie_port *port)
-{
-	int i;
-	u32 irq, num_irqs;
-
-	/* Free IRQ Domain */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-
-		free_pages(port->msi_pages, 0);
-
-		num_irqs = XILINX_NUM_MSI_IRQS;
-	} else {
-		/* INTx */
-		num_irqs = 4;
-	}
-
-	for (i = 0; i < num_irqs; i++) {
-		irq = irq_find_mapping(port->irq_domain, i);
-		if (irq > 0)
-			irq_dispose_mapping(irq);
-	}
-
-	irq_domain_remove(port->irq_domain);
-}
-
-/**
  * xilinx_pcie_init_irq_domain - Initialize IRQ domain
  * @port: PCIe port information
  *
@@ -858,21 +829,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/**
- * xilinx_pcie_remove - Remove function
- * @pdev: Platform device pointer
- *
- * Return: '0' always
- */
-static int xilinx_pcie_remove(struct platform_device *pdev)
-{
-	struct xilinx_pcie_port *port = platform_get_drvdata(pdev);
-
-	xilinx_pcie_free_irq_domain(port);
-
-	return 0;
-}
-
 static struct of_device_id xilinx_pcie_of_match[] = {
 	{ .compatible = "xlnx,axi-pcie-host-1.00.a", },
 	{}
@@ -885,10 +841,5 @@ static struct platform_driver xilinx_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = xilinx_pcie_probe,
-	.remove = xilinx_pcie_remove,
 };
-module_platform_driver(xilinx_pcie_driver);
-
-MODULE_AUTHOR("Xilinx Inc");
-MODULE_DESCRIPTION("Xilinx AXI PCIe driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(xilinx_pcie_driver);
-- 
2.6.1

