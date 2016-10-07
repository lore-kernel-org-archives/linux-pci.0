Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756694AbcJGQ3U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:29:20 -0400
Subject: [PATCH 1/9] PCI: xilinx: Name private struct pointer "xilinx"
 consistently
To: Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:28:47 -0500
Message-ID: <20161007162847.24137.38713.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use a device-specific name, "xilinx", for struct xilinx_pcie_port pointers
to hint that this is device-specific information.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |  204 ++++++++++++++++++++--------------------
 1 file changed, 102 insertions(+), 102 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index be56803..14e4187 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -118,34 +118,34 @@ struct xilinx_pcie_port {
 
 static DECLARE_BITMAP(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
 
-static inline u32 pcie_read(struct xilinx_pcie_port *port, u32 reg)
+static inline u32 pcie_read(struct xilinx_pcie_port *xilinx, u32 reg)
 {
-	return readl(port->reg_base + reg);
+	return readl(xilinx->reg_base + reg);
 }
 
-static inline void pcie_write(struct xilinx_pcie_port *port, u32 val, u32 reg)
+static inline void pcie_write(struct xilinx_pcie_port *xilinx, u32 val, u32 reg)
 {
-	writel(val, port->reg_base + reg);
+	writel(val, xilinx->reg_base + reg);
 }
 
-static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *port)
+static inline bool xilinx_pcie_link_is_up(struct xilinx_pcie_port *xilinx)
 {
-	return (pcie_read(port, XILINX_PCIE_REG_PSCR) &
+	return (pcie_read(xilinx, XILINX_PCIE_REG_PSCR) &
 		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
 }
 
 /**
  * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
- * @port: PCIe port information
+ * @xilinx: PCIe port information
  */
-static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
+static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *xilinx)
 {
-	unsigned long val = pcie_read(port, XILINX_PCIE_REG_RPEFR);
+	unsigned long val = pcie_read(xilinx, XILINX_PCIE_REG_RPEFR);
 
 	if (val & XILINX_PCIE_RPEFR_ERR_VALID) {
-		dev_dbg(port->dev, "Requester ID %lu\n",
+		dev_dbg(xilinx->dev, "Requester ID %lu\n",
 			val & XILINX_PCIE_RPEFR_REQ_ID);
-		pcie_write(port, XILINX_PCIE_RPEFR_ALL_MASK,
+		pcie_write(xilinx, XILINX_PCIE_RPEFR_ALL_MASK,
 			   XILINX_PCIE_REG_RPEFR);
 	}
 }
@@ -159,15 +159,15 @@ static void xilinx_pcie_clear_err_interrupts(struct xilinx_pcie_port *port)
  */
 static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
-	struct xilinx_pcie_port *port = bus->sysdata;
+	struct xilinx_pcie_port *xilinx = bus->sysdata;
 
 	/* Check if link is up when trying to access downstream ports */
-	if (bus->number != port->root_busno)
-		if (!xilinx_pcie_link_is_up(port))
+	if (bus->number != xilinx->root_busno)
+		if (!xilinx_pcie_link_is_up(xilinx))
 			return false;
 
 	/* Only one device down on each root port */
-	if (bus->number == port->root_busno && devfn > 0)
+	if (bus->number == xilinx->root_busno && devfn > 0)
 		return false;
 
 	return true;
@@ -185,7 +185,7 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 					 unsigned int devfn, int where)
 {
-	struct xilinx_pcie_port *port = bus->sysdata;
+	struct xilinx_pcie_port *xilinx = bus->sysdata;
 	int relbus;
 
 	if (!xilinx_pcie_valid_device(bus, devfn))
@@ -194,7 +194,7 @@ static void __iomem *xilinx_pcie_map_bus(struct pci_bus *bus,
 	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
 		 (devfn << ECAM_DEV_NUM_SHIFT);
 
-	return port->reg_base + relbus + where;
+	return xilinx->reg_base + relbus + where;
 }
 
 /* PCIe operations */
@@ -213,14 +213,14 @@ static struct pci_ops xilinx_pcie_ops = {
 static void xilinx_pcie_destroy_msi(unsigned int irq)
 {
 	struct msi_desc *msi;
-	struct xilinx_pcie_port *port;
+	struct xilinx_pcie_port *xilinx;
 	struct irq_data *d = irq_get_irq_data(irq);
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
 	if (!test_bit(hwirq, msi_irq_in_use)) {
 		msi = irq_get_msi_desc(irq);
-		port = msi_desc_to_pci_sysdata(msi);
-		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
+		xilinx = msi_desc_to_pci_sysdata(msi);
+		dev_err(xilinx->dev, "Trying to free unused MSI#%d\n", irq);
 	} else {
 		clear_bit(hwirq, msi_irq_in_use);
 	}
@@ -228,11 +228,11 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
 
 /**
  * xilinx_pcie_assign_msi - Allocate MSI number
- * @port: PCIe port structure
+ * @xilinx: PCIe port structure
  *
  * Return: A valid IRQ on success and error value on failure.
  */
-static int xilinx_pcie_assign_msi(struct xilinx_pcie_port *port)
+static int xilinx_pcie_assign_msi(struct xilinx_pcie_port *xilinx)
 {
 	int pos;
 
@@ -269,23 +269,23 @@ static int xilinx_pcie_msi_setup_irq(struct msi_controller *chip,
 				     struct pci_dev *pdev,
 				     struct msi_desc *desc)
 {
-	struct xilinx_pcie_port *port = pdev->bus->sysdata;
+	struct xilinx_pcie_port *xilinx = pdev->bus->sysdata;
 	unsigned int irq;
 	int hwirq;
 	struct msi_msg msg;
 	phys_addr_t msg_addr;
 
-	hwirq = xilinx_pcie_assign_msi(port);
+	hwirq = xilinx_pcie_assign_msi(xilinx);
 	if (hwirq < 0)
 		return hwirq;
 
-	irq = irq_create_mapping(port->msi_domain, hwirq);
+	irq = irq_create_mapping(xilinx->msi_domain, hwirq);
 	if (!irq)
 		return -EINVAL;
 
 	irq_set_msi_desc(irq, desc);
 
-	msg_addr = virt_to_phys((void *)port->msi_pages);
+	msg_addr = virt_to_phys((void *)xilinx->msi_pages);
 
 	msg.address_hi = 0;
 	msg.address_lo = msg_addr;
@@ -335,16 +335,16 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 /**
  * xilinx_pcie_enable_msi - Enable MSI support
- * @port: PCIe port information
+ * @xilinx: PCIe port information
  */
-static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
+static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *xilinx)
 {
 	phys_addr_t msg_addr;
 
-	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
-	msg_addr = virt_to_phys((void *)port->msi_pages);
-	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
-	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
+	xilinx->msi_pages = __get_free_pages(GFP_KERNEL, 0);
+	msg_addr = virt_to_phys((void *)xilinx->msi_pages);
+	pcie_write(xilinx, 0x0, XILINX_PCIE_REG_MSIBASE1);
+	pcie_write(xilinx, msg_addr, XILINX_PCIE_REG_MSIBASE2);
 }
 
 /* INTx Functions */
@@ -382,85 +382,85 @@ static const struct irq_domain_ops intx_domain_ops = {
  */
 static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 {
-	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
+	struct xilinx_pcie_port *xilinx = (struct xilinx_pcie_port *)data;
 	u32 val, mask, status, msi_data;
 
 	/* Read interrupt decode and mask registers */
-	val = pcie_read(port, XILINX_PCIE_REG_IDR);
-	mask = pcie_read(port, XILINX_PCIE_REG_IMR);
+	val = pcie_read(xilinx, XILINX_PCIE_REG_IDR);
+	mask = pcie_read(xilinx, XILINX_PCIE_REG_IMR);
 
 	status = val & mask;
 	if (!status)
 		return IRQ_NONE;
 
 	if (status & XILINX_PCIE_INTR_LINK_DOWN)
-		dev_warn(port->dev, "Link Down\n");
+		dev_warn(xilinx->dev, "Link Down\n");
 
 	if (status & XILINX_PCIE_INTR_ECRC_ERR)
-		dev_warn(port->dev, "ECRC failed\n");
+		dev_warn(xilinx->dev, "ECRC failed\n");
 
 	if (status & XILINX_PCIE_INTR_STR_ERR)
-		dev_warn(port->dev, "Streaming error\n");
+		dev_warn(xilinx->dev, "Streaming error\n");
 
 	if (status & XILINX_PCIE_INTR_HOT_RESET)
-		dev_info(port->dev, "Hot reset\n");
+		dev_info(xilinx->dev, "Hot reset\n");
 
 	if (status & XILINX_PCIE_INTR_CFG_TIMEOUT)
-		dev_warn(port->dev, "ECAM access timeout\n");
+		dev_warn(xilinx->dev, "ECAM access timeout\n");
 
 	if (status & XILINX_PCIE_INTR_CORRECTABLE) {
-		dev_warn(port->dev, "Correctable error message\n");
-		xilinx_pcie_clear_err_interrupts(port);
+		dev_warn(xilinx->dev, "Correctable error message\n");
+		xilinx_pcie_clear_err_interrupts(xilinx);
 	}
 
 	if (status & XILINX_PCIE_INTR_NONFATAL) {
-		dev_warn(port->dev, "Non fatal error message\n");
-		xilinx_pcie_clear_err_interrupts(port);
+		dev_warn(xilinx->dev, "Non fatal error message\n");
+		xilinx_pcie_clear_err_interrupts(xilinx);
 	}
 
 	if (status & XILINX_PCIE_INTR_FATAL) {
-		dev_warn(port->dev, "Fatal error message\n");
-		xilinx_pcie_clear_err_interrupts(port);
+		dev_warn(xilinx->dev, "Fatal error message\n");
+		xilinx_pcie_clear_err_interrupts(xilinx);
 	}
 
 	if (status & XILINX_PCIE_INTR_INTX) {
 		/* INTx interrupt received */
-		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+		val = pcie_read(xilinx, XILINX_PCIE_REG_RPIFR1);
 
 		/* Check whether interrupt valid */
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
+			dev_warn(xilinx->dev, "RP Intr FIFO1 read error\n");
 			goto error;
 		}
 
 		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
 			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			pcie_write(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
 				   XILINX_PCIE_REG_RPIFR1);
 
 			/* Handle INTx Interrupt */
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
-			generic_handle_irq(irq_find_mapping(port->leg_domain,
+			generic_handle_irq(irq_find_mapping(xilinx->leg_domain,
 							    val));
 		}
 	}
 
 	if (status & XILINX_PCIE_INTR_MSI) {
 		/* MSI Interrupt */
-		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
+		val = pcie_read(xilinx, XILINX_PCIE_REG_RPIFR1);
 
 		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
-			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
+			dev_warn(xilinx->dev, "RP Intr FIFO1 read error\n");
 			goto error;
 		}
 
 		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
-			msi_data = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
+			msi_data = pcie_read(xilinx, XILINX_PCIE_REG_RPIFR2) &
 				   XILINX_PCIE_RPIFR2_MSG_DATA;
 
 			/* Clear interrupt FIFO register 1 */
-			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
+			pcie_write(xilinx, XILINX_PCIE_RPIFR1_ALL_MASK,
 				   XILINX_PCIE_REG_RPIFR1);
 
 			if (IS_ENABLED(CONFIG_PCI_MSI)) {
@@ -471,48 +471,48 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 	}
 
 	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
-		dev_warn(port->dev, "Slave unsupported request\n");
+		dev_warn(xilinx->dev, "Slave unsupported request\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_UNEXP)
-		dev_warn(port->dev, "Slave unexpected completion\n");
+		dev_warn(xilinx->dev, "Slave unexpected completion\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_COMPL)
-		dev_warn(port->dev, "Slave completion timeout\n");
+		dev_warn(xilinx->dev, "Slave completion timeout\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_ERRP)
-		dev_warn(port->dev, "Slave Error Poison\n");
+		dev_warn(xilinx->dev, "Slave Error Poison\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_CMPABT)
-		dev_warn(port->dev, "Slave Completer Abort\n");
+		dev_warn(xilinx->dev, "Slave Completer Abort\n");
 
 	if (status & XILINX_PCIE_INTR_SLV_ILLBUR)
-		dev_warn(port->dev, "Slave Illegal Burst\n");
+		dev_warn(xilinx->dev, "Slave Illegal Burst\n");
 
 	if (status & XILINX_PCIE_INTR_MST_DECERR)
-		dev_warn(port->dev, "Master decode error\n");
+		dev_warn(xilinx->dev, "Master decode error\n");
 
 	if (status & XILINX_PCIE_INTR_MST_SLVERR)
-		dev_warn(port->dev, "Master slave error\n");
+		dev_warn(xilinx->dev, "Master slave error\n");
 
 	if (status & XILINX_PCIE_INTR_MST_ERRP)
-		dev_warn(port->dev, "Master error poison\n");
+		dev_warn(xilinx->dev, "Master error poison\n");
 
 error:
 	/* Clear the Interrupt Decode register */
-	pcie_write(port, status, XILINX_PCIE_REG_IDR);
+	pcie_write(xilinx, status, XILINX_PCIE_REG_IDR);
 
 	return IRQ_HANDLED;
 }
 
 /**
  * xilinx_pcie_init_irq_domain - Initialize IRQ domain
- * @port: PCIe port information
+ * @xilinx: PCIe port information
  *
  * Return: '0' on success and error value on failure
  */
-static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
+static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *xilinx)
 {
-	struct device *dev = port->dev;
+	struct device *dev = xilinx->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
 
@@ -523,26 +523,26 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
+	xilinx->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
 						 &intx_domain_ops,
-						 port);
-	if (!port->leg_domain) {
+						 xilinx);
+	if (!xilinx->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
 	}
 
 	/* Setup MSI */
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		port->msi_domain = irq_domain_add_linear(node,
+		xilinx->msi_domain = irq_domain_add_linear(node,
 							 XILINX_NUM_MSI_IRQS,
 							 &msi_domain_ops,
 							 &xilinx_pcie_msi_chip);
-		if (!port->msi_domain) {
+		if (!xilinx->msi_domain) {
 			dev_err(dev, "Failed to get a MSI IRQ domain\n");
 			return -ENODEV;
 		}
 
-		xilinx_pcie_enable_msi(port);
+		xilinx_pcie_enable_msi(xilinx);
 	}
 
 	return 0;
@@ -550,42 +550,42 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 
 /**
  * xilinx_pcie_init_port - Initialize hardware
- * @port: PCIe port information
+ * @xilinx: PCIe port information
  */
-static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)
+static void xilinx_pcie_init_port(struct xilinx_pcie_port *xilinx)
 {
-	if (xilinx_pcie_link_is_up(port))
-		dev_info(port->dev, "PCIe Link is UP\n");
+	if (xilinx_pcie_link_is_up(xilinx))
+		dev_info(xilinx->dev, "PCIe Link is UP\n");
 	else
-		dev_info(port->dev, "PCIe Link is DOWN\n");
+		dev_info(xilinx->dev, "PCIe Link is DOWN\n");
 
 	/* Disable all interrupts */
-	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
+	pcie_write(xilinx, ~XILINX_PCIE_IDR_ALL_MASK,
 		   XILINX_PCIE_REG_IMR);
 
 	/* Clear pending interrupts */
-	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_IDR) &
+	pcie_write(xilinx, pcie_read(xilinx, XILINX_PCIE_REG_IDR) &
 			 XILINX_PCIE_IMR_ALL_MASK,
 		   XILINX_PCIE_REG_IDR);
 
 	/* Enable all interrupts */
-	pcie_write(port, XILINX_PCIE_IMR_ALL_MASK, XILINX_PCIE_REG_IMR);
+	pcie_write(xilinx, XILINX_PCIE_IMR_ALL_MASK, XILINX_PCIE_REG_IMR);
 
 	/* Enable the Bridge enable bit */
-	pcie_write(port, pcie_read(port, XILINX_PCIE_REG_RPSC) |
+	pcie_write(xilinx, pcie_read(xilinx, XILINX_PCIE_REG_RPSC) |
 			 XILINX_PCIE_REG_RPSC_BEN,
 		   XILINX_PCIE_REG_RPSC);
 }
 
 /**
  * xilinx_pcie_parse_dt - Parse Device tree
- * @port: PCIe port information
+ * @xilinx: PCIe port information
  *
  * Return: '0' on success and error value on failure
  */
-static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
+static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *xilinx)
 {
-	struct device *dev = port->dev;
+	struct device *dev = xilinx->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
 	const char *type;
@@ -603,16 +603,16 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 		return err;
 	}
 
-	port->reg_base = devm_ioremap_resource(dev, &regs);
-	if (IS_ERR(port->reg_base))
-		return PTR_ERR(port->reg_base);
+	xilinx->reg_base = devm_ioremap_resource(dev, &regs);
+	if (IS_ERR(xilinx->reg_base))
+		return PTR_ERR(xilinx->reg_base);
 
-	port->irq = irq_of_parse_and_map(node, 0);
-	err = devm_request_irq(dev, port->irq, xilinx_pcie_intr_handler,
+	xilinx->irq = irq_of_parse_and_map(node, 0);
+	err = devm_request_irq(dev, xilinx->irq, xilinx_pcie_intr_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
-			       "xilinx-pcie", port);
+			       "xilinx-pcie", xilinx);
 	if (err) {
-		dev_err(dev, "unable to request irq %d\n", port->irq);
+		dev_err(dev, "unable to request irq %d\n", xilinx->irq);
 		return err;
 	}
 
@@ -627,7 +627,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
  */
 static int xilinx_pcie_probe(struct platform_device *pdev)
 {
-	struct xilinx_pcie_port *port;
+	struct xilinx_pcie_port *xilinx;
 	struct device *dev = &pdev->dev;
 	struct pci_bus *bus;
 	int err;
@@ -637,21 +637,21 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	if (!dev->of_node)
 		return -ENODEV;
 
-	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
+	xilinx = devm_kzalloc(dev, sizeof(*xilinx), GFP_KERNEL);
+	if (!xilinx)
 		return -ENOMEM;
 
-	port->dev = dev;
+	xilinx->dev = dev;
 
-	err = xilinx_pcie_parse_dt(port);
+	err = xilinx_pcie_parse_dt(xilinx);
 	if (err) {
 		dev_err(dev, "Parsing DT failed\n");
 		return err;
 	}
 
-	xilinx_pcie_init_port(port);
+	xilinx_pcie_init_port(xilinx);
 
-	err = xilinx_pcie_init_irq_domain(port);
+	err = xilinx_pcie_init_irq_domain(xilinx);
 	if (err) {
 		dev_err(dev, "Failed creating IRQ Domain\n");
 		return err;
@@ -669,14 +669,14 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		goto error;
 
 	bus = pci_create_root_bus(&pdev->dev, 0,
-				  &xilinx_pcie_ops, port, &res);
+				  &xilinx_pcie_ops, xilinx, &res);
 	if (!bus) {
 		err = -ENOMEM;
 		goto error;
 	}
 
 #ifdef CONFIG_PCI_MSI
-	xilinx_pcie_msi_chip.dev = port->dev;
+	xilinx_pcie_msi_chip.dev = xilinx->dev;
 	bus->msi = &xilinx_pcie_msi_chip;
 #endif
 	pci_scan_child_bus(bus);
@@ -685,7 +685,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 #endif
 	pci_bus_add_devices(bus);
-	platform_set_drvdata(pdev, port);
+	platform_set_drvdata(pdev, xilinx);
 
 	return 0;
 

