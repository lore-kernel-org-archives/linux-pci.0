Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:30074 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbaIKMyy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Sep 2014 08:54:54 -0400
Date: Thu, 11 Sep 2014 15:54:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: sthokal@xilinx.com
Cc: linux-pci@vger.kernel.org
Subject: re: PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver
Message-ID: <20140911125440.GA17279@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Srikanth Thokala,

The patch 8961def56845: "PCI: xilinx: Add Xilinx AXI PCIe Host Bridge
IP driver" from Aug 20, 2014, leads to the following static checker
warnings:

drivers/pci/host/pcie-xilinx.c:647 xilinx_pcie_init_irq_domain() warn: passing zero to 'PTR_ERR'
drivers/pci/host/pcie-xilinx.c:655 xilinx_pcie_init_irq_domain() warn: passing zero to 'PTR_ERR'
drivers/pci/host/pcie-xilinx.c:666 xilinx_pcie_init_irq_domain() warn: passing zero to 'PTR_ERR'

drivers/pci/host/pcie-xilinx.c
   637  static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
   638  {
   639          struct device *dev = port->dev;
   640          struct device_node *node = dev->of_node;
   641          struct device_node *pcie_intc_node;
   642  
   643          /* Setup INTx */
   644          pcie_intc_node = of_get_next_child(node, NULL);
   645          if (!pcie_intc_node) {
   646                  dev_err(dev, "No PCIe Intc node found\n");
   647                  return PTR_ERR(pcie_intc_node);
                               ^^^^^^^^^^^^^^^^^^^^^^
Returning success when a negative error code was intended.

   648          }
   649  
   650          port->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
   651                                                   &intx_domain_ops,
   652                                                   port);
   653          if (!port->irq_domain) {
   654                  dev_err(dev, "Failed to get a INTx IRQ domain\n");
   655                  return PTR_ERR(port->irq_domain);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^
   656          }
   657  
   658          /* Setup MSI */
   659          if (IS_ENABLED(CONFIG_PCI_MSI)) {
   660                  port->irq_domain = irq_domain_add_linear(node,
   661                                                           XILINX_NUM_MSI_IRQS,
   662                                                           &msi_domain_ops,
   663                                                           &xilinx_pcie_msi_chip);
   664                  if (!port->irq_domain) {
   665                          dev_err(dev, "Failed to get a MSI IRQ domain\n");
   666                          return PTR_ERR(port->irq_domain);
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^
   667                  }
   668  
   669                  xilinx_pcie_enable_msi(port);
   670          }
   671  
   672          return 0;
   673  }

regards,
dan carpenter
