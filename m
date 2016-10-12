Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755721AbcJLNKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:10:44 -0400
Subject: [PATCH v2 1/5] PCI: xilinx: Add local struct device pointers
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:10:38 -0500
Message-ID: <20161012131038.25793.18769.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012130819.25793.17542.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a local "struct device *dev" for brevity and consistency with other
drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |   55 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index be56803..2ef47af 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -140,10 +140,11 @@ static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *port)
  */
 static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
 {
+	struct device *dev = port->dev;
 	unsigned long val = pcie_read(port, XILINX_PCIE_REG_RPEFR);
 
 	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
-		dev_dbg(port->dev, "Requester ID %lu\n",
+		dev_dbg(dev, "Requester ID %lu\n",
 			val & XILINX_PCIE_RPEFR_REQ_ID);
 		pcie_write(port, XILINX_PCIE_RPEFR_ALL_MASK,
 			   XILINX_PCIE_REG_RPEFR);
@@ -383,6 +384,7 @@ static const struct irq_domain_ops intx_domain_ops = {
 static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
 	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
+	struct device *dev = port->dev;
 	u32 val, mask, status, msi_data;
 
 	/* Read interrupt decode and mask registers */
@@ -394,32 +396,32 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		return IRQ_NONE;
 
 	if (status & XILINX_PCIE_INTR_LINK_DOWN)
-		dev_warn(port->dev, "Link Down\n");
+		dev_warn(dev, "Link Down\n");
 
 	if (status & XILINX_PCIE_INTR_ECRC_ERR)
-		dev_warn(port->dev, "ECRC failed\n");
+		dev_warn(dev, "ECRC failed\n");
 
 	if (status & XILINX_PCIE_INTR_STR_ERR)
-		dev_warn(port->dev, "Streaming error\n");
+		dev_warn(dev, "Streaming error\n");
 
 	if (status & XILINX_PCIE_INTR_HOT_RESET)
-		dev_info(port->dev, "Hot reset\n");
+		dev_info(dev, "Hot reset\n");
 
 	if (status & XILINX_PCIE_INTR_CFG_TIMEOUT)
-		dev_warn(port->dev, "ECAM access timeout\n");
+		dev_warn(dev, "ECAM access timeout\n");
 
 	if (status & XILINX_PCIE_INTR_CORRECTABLE) {
-		dev_warn(port->dev, "Correctable error message\n");
+		dev_warn(dev, "Correctable error message\n");
 		xilinx_pcie_clear_err_interrupts(port);
 	}
 
 	if (status & XILINX_PCIE_INTR_NONFATAL) {
-		dev_warn(port->dev, "Non fatal error message\n");
+		dev_warn(dev, "Non fatal error message\n");
 		xilinx_pcie_clear_err_interrupts(port);
 	}
 
 	if (status & XILINX_PCIE_INTR_FATAL) {
-		dev_warn(port->dev, "Fatal error message\n");
+		dev_warn(dev, "Fatal error message\n");
 		xilinx_pcie_clear_err_interrupts(port);
 	}
 
@@ -429,7 +431,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
+			dev_warn(dev, "RP Intr FIFO1 read error\n");
 			goto error;
 		}
 
@@ -451,7 +453,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
 
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
+			dev_warn(dev, "RP Intr FIFO1 read error\n");
 			goto error;
 		}
 
@@ -471,31 +473,31 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
-		dev_warn(port->dev, "Slave unsupported request\n");
+		dev_warn(dev, "Slave unsupported request\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_UNEXP)
-		dev_warn(port->dev, "Slave unexpected completion\n");
+		dev_warn(dev, "Slave unexpected completion\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_COMPL)
-		dev_warn(port->dev, "Slave completion timeout\n");
+		dev_warn(dev, "Slave completion timeout\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_ERRP)
-		dev_warn(port->dev, "Slave Error Poison\n");
+		dev_warn(dev, "Slave Error Poison\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_CMPABT)
-		dev_warn(port->dev, "Slave Completer Abort\n");
+		dev_warn(dev, "Slave Completer Abort\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_ILLBUR)
-		dev_warn(port->dev, "Slave Illegal Burst\n");
+		dev_warn(dev, "Slave Illegal Burst\n");
 
 	if (status & XILINX_PCIE_INTR_MST_DECERR)
-		dev_warn(port->dev, "Master decode error\n");
+		dev_warn(dev, "Master decode error\n");
 
 	if (status & XILINX_PCIE_INTR_MST_SLVERR)
-		dev_warn(port->dev, "Master slave error\n");
+		dev_warn(dev, "Master slave error\n");
 
 	if (status & XILINX_PCIE_INTR_MST_ERRP)
-		dev_warn(port->dev, "Master error poison\n");
+		dev_warn(dev, "Master error poison\n");
 
 error:
 	/* Clear the Interrupt Decode register */
@@ -554,10 +556,12 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
  */
 static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
 {
+	struct device *dev = port->dev;
+
 	if (xilinx_pcie_link_is_up(port))
-		dev_info(port->dev, "PCIe Link is UP\n");
+		dev_info(dev, "PCIe Link is UP\n");
 	else
-		dev_info(port->dev, "PCIe Link is DOWN\n");
+		dev_info(dev, "PCIe Link is DOWN\n");
 
 	/* Disable all interrupts */
 	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
@@ -627,8 +631,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
  */
 static int xilinx_pcie_probe(struct platform_device *pdev)
 {
-	struct xilinx_pcie_port *port;
 	struct device *dev = &pdev->dev;
+	struct xilinx_pcie_port *port;
 	struct pci_bus *bus;
 	int err;
 	resource_size_t iobase = 0;
@@ -668,15 +672,14 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto error;
 
-	bus = pci_create_root_bus(&pdev->dev, 0,
-				  &xilinx_pcie_ops, port, &res);
+	bus = pci_create_root_bus(dev, 0, &xilinx_pcie_ops, port, &res);
 	if (!bus) {
 		err = -ENOMEM;
 		goto error;
 	}
 
 #ifdef CONFIG_PCI_MSI
-	xilinx_pcie_msi_chip.dev = port->dev;
+	xilinx_pcie_msi_chip.dev = dev;
 	bus->msi = &xilinx_pcie_msi_chip;
 #endif
 	pci_scan_child_bus(bus);

