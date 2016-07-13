Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:16884 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbcGMPgW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 11:36:22 -0400
Date: Wed, 13 Jul 2016 18:36:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Srikanth Thokala <srikanth.thokala@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver
Message-ID: <20160713153600.GA7827@mwanda>
References: <20140911125440.GA17279@mwanda>
 <b7d26984-7424-4af5-a69f-e7bf28bf71fc@BL2FFO11FD011.protection.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b7d26984-7424-4af5-a69f-e7bf28bf71fc@BL2FFO11FD011.protection.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We lost track of this.  It's still buggy two years later.

regards,
dan carpenter

On Fri, Sep 12, 2014 at 10:35:46AM +0000, Srikanth Thokala wrote:
> Hi Dan,
> 
> I will look into it and will send a fix, thanks.
> 
> Srikanth
> 
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Thursday, September 11, 2014 6:25 PM
> > To: Srikanth Thokala
> > Cc: linux-pci@vger.kernel.org
> > Subject: re: PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver
> >
> > Hello Srikanth Thokala,
> >
> > The patch 8961def56845: "PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver"
> > from Aug 20, 2014, leads to the following static checker
> > warnings:
> >
> > drivers/pci/host/pcie-xilinx.c:647 xilinx_pcie_init_irq_domain() warn: passing
> > zero to 'PTR_ERR'
> > drivers/pci/host/pcie-xilinx.c:655 xilinx_pcie_init_irq_domain() warn: passing
> > zero to 'PTR_ERR'
> > drivers/pci/host/pcie-xilinx.c:666 xilinx_pcie_init_irq_domain() warn: passing
> > zero to 'PTR_ERR'
> >
> > drivers/pci/host/pcie-xilinx.c
> >    637  static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
> >    638  {
> >    639          struct device *dev = port->dev;
> >    640          struct device_node *node = dev->of_node;
> >    641          struct device_node *pcie_intc_node;
> >    642
> >    643          /* Setup INTx */
> >    644          pcie_intc_node = of_get_next_child(node, NULL);
> >    645          if (!pcie_intc_node) {
> >    646                  dev_err(dev, "No PCIe Intc node found\n");
> >    647                  return PTR_ERR(pcie_intc_node);
> >                                ^^^^^^^^^^^^^^^^^^^^^^ Returning success when a
> > negative error code was intended.
> >
> >    648          }
> >    649
> >    650          port->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> >    651                                                   &intx_domain_ops,
> >    652                                                   port);
> >    653          if (!port->irq_domain) {
> >    654                  dev_err(dev, "Failed to get a INTx IRQ domain\n");
> >    655                  return PTR_ERR(port->irq_domain);
> >                                ^^^^^^^^^^^^^^^^^^^^^^^^^
> >    656          }
> >    657
> >    658          /* Setup MSI */
> >    659          if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >    660                  port->irq_domain = irq_domain_add_linear(node,
> >    661                                                           XILINX_NUM_MSI_IRQS,
> >    662                                                           &msi_domain_ops,
> >    663                                                           &xilinx_pcie_msi_chip);
> >    664                  if (!port->irq_domain) {
> >    665                          dev_err(dev, "Failed to get a MSI IRQ domain\n");
> >    666                          return PTR_ERR(port->irq_domain);
> >                                        ^^^^^^^^^^^^^^^^^^^^^^^^^
> >    667                  }
> >    668
> >    669                  xilinx_pcie_enable_msi(port);
> >    670          }
> >    671
> >    672          return 0;
> >    673  }
> >
> > regards,
> > dan carpenter
> 
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
