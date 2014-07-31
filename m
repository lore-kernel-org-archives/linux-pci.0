Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20415 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbaGaNcE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jul 2014 09:32:04 -0400
Date: Thu, 31 Jul 2014 16:31:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kishon@ti.com
Cc: linux-pci@vger.kernel.org
Subject: re: PCI: dra7xx: Add TI DRA7xx PCIe driver
Message-ID: <20140731133125.GA7434@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Kishon Vijay Abraham I,

The patch 47ff3de911a7: "PCI: dra7xx: Add TI DRA7xx PCIe driver" from
Jul 22, 2014, leads to the following static checker warning:

	drivers/pci/host/pci-dra7xx.c:180 dra7xx_pcie_init_irq_domain()
	warn: passing zero to 'PTR_ERR'

drivers/pci/host/pci-dra7xx.c
   172  static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
   173  {
   174          struct device *dev = pp->dev;
   175          struct device_node *node = dev->of_node;
   176          struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
   177  
   178          if (!pcie_intc_node) {
                     ^^^^^^^^^^^^^^
   179                  dev_err(dev, "No PCIe Intc node found\n");
   180                  return PTR_ERR(pcie_intc_node);
                                       ^^^^^^^^^^^^^^
   181          }
   182  
   183          pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
   184                                                 &intx_domain_ops, pp);
   185          if (!pp->irq_domain) {
   186                  dev_err(dev, "Failed to get a INTx IRQ domain\n");
   187                  return PTR_ERR(pp->irq_domain);
                                       ^^^^^^^^^^^^^^
Again.

   188          }
   189  
   190          return 0;

regards,
dan carpenter
