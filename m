Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937635AbeFSORM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2018 10:17:12 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] PCI: Add hooks for bus/bridge-specific fixups
Date: Tue, 19 Jun 2018 16:16:58 +0200
Message-Id: <20180619141700.7842-2-hch@lst.de>
In-Reply-To: <20180619141700.7842-1-hch@lst.de>
References: <20180619141700.7842-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Wesley W. Terpstra" <wesley@sifive.com>

There is currently no way for a PCIe bridge to impose constraints on
devices added to it.  For example, the Xilinx PCIe host bridge only
supports 32-bit physical addresses (due to a limitation on the AXI
port's address width).  Thus, even devices that claim to support 64-bit
DMA addresses must be restricted to 32-bit addresses when attached to
this host controller.

This patch adds at "add_dev" hook to pci_ops that allows the PCI
infastructure to interpose when adding a device, which in the case of
the Xilinx driver will be used to restrict the address ranges used for
DMA.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[hch: simplified the prototype]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..978e684cba2c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2331,6 +2331,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Set up MSI IRQ domain */
 	pci_set_msi_domain(dev);
 
+	if (bus->ops->add_dev)
+		bus->ops->add_dev(dev, bus);
+
 	/* Notifier could use PCI capabilities */
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..ea9609fc44fc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -662,6 +662,7 @@ static inline int pcibios_err_to_errno(int err)
 struct pci_ops {
 	int (*add_bus)(struct pci_bus *bus);
 	void (*remove_bus)(struct pci_bus *bus);
+	void (*add_dev)(struct pci_dev *dev, struct pci_bus *bus);
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
-- 
2.17.1
