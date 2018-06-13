Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:58762 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S933704AbeFMHXC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 03:23:02 -0400
Date: Wed, 13 Jun 2018 07:12:04 +0000
From: Nicholas Mc Guire <der.herr@hofr.at>
To: linux-pci@vger.kernel.org
Subject: question regarding irq_domain_add_linear fixup in error case
Message-ID: <20180613071204.GA14373@osadl.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi !

 I have a question regarding the MSI setup error path - if the
 irq_domain_add_linear() there were to fail then the prevous call
 irq_domain_add_linear() would leave the irq allocated and
 registered in the reverse mapping (HW -> Host) so should that
 error path no call irq_domain_clear_mapping() ?

 code is from linux-next 4.17.0 (localversion-next 20180613)

/**
 * xilinx_pcie_init_irq_domain - Initialize IRQ domain
 * @port: PCIe port information
 *
 * Return: '0' on success and error value on failure
 */
static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
{
	struct device *dev = port->dev;
	struct device_node *node = dev->of_node;
	struct device_node *pcie_intc_node;

	/* Setup INTx */
	pcie_intc_node = of_get_next_child(node, NULL);
	if (!pcie_intc_node) {
		dev_err(dev, "No PCIe Intc node found\n");
		return -ENODEV;
	}

	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
						 &intx_domain_ops,
						 port);
	if (!port->leg_domain) {
		dev_err(dev, "Failed to get a INTx IRQ domain\n");
		return -ENODEV;
	}

	/* Setup MSI */
	if (IS_ENABLED(CONFIG_PCI_MSI)) {
		port->msi_domain = irq_domain_add_linear(node,
							 XILINX_NUM_MSI_IRQS,
							 &msi_domain_ops,
							 &xilinx_pcie_msi_chip);
		if (!port->msi_domain) {
			dev_err(dev, "Failed to get a MSI IRQ domain\n");
+ ??			irq_domain_clear_mapping(port->leg_domain ?? ?? )
			return -ENODEV;
		}

		xilinx_pcie_enable_msi(port);
	}

	return 0;
}

Am I missing something here - or is the cleanup in the MSI setup error case
incomlete ?

thx!
hofrat
