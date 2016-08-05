Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41666 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161490AbcHEPvI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2016 11:51:08 -0400
Date: Fri, 5 Aug 2016 17:50:55 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: pcie-designware msi_controller->dev handling
Message-ID: <20160805175055.3e8800b8@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jingoo, Pratyush,

I was going to some of the MSI handling code in the pcie-designware
driver, and stumbled across the following part of the code:

static struct msi_controller dw_pcie_msi_chip = {
	.setup_irq = dw_msi_setup_irq,
	.setup_irqs = dw_msi_setup_irqs,
	.teardown_irq = dw_msi_teardown_irq,
};

[...]

int dw_pcie_host_init(struct pcie_port *pp)
{
	[...]

	if (IS_ENABLED(CONFIG_PCI_MSI)) {
		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
					    &dw_pcie_ops, pp, &res,
					    &dw_pcie_msi_chip);
		dw_pcie_msi_chip.dev = pp->dev;
	[...]
}

I am a bit surprised by the dw_pcie_msi_chip.dev assignment here.
Indeed, there is only one global dw_pcie_msi_chip structure, but the
function dw_pcie_host_init() can be called several times, once for each
PCIe controller available on a platform.

This means that the dw_pcie_msi_chip.dev will point to the last
Designware PCIe controller that was registered.

If the MSI controller is indeed part of the PCIe controller IP, I think
the msi_controller structure needs to be dynamically allocated, so that
you have one instance for each PCIe controller.

Am I missing something?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
