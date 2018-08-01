Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbeHARAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 13:00:23 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] PCI: add a callback to struct pci_host_bridge for adding a new device
Date: Wed,  1 Aug 2018 17:14:01 +0200
Message-Id: <20180801151403.20660-2-hch@lst.de>
In-Reply-To: <20180801151403.20660-1-hch@lst.de>
References: <20180801151403.20660-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is currently no way for a PCIe bridge to impose constraints on
devices added to it.  For example, the Xilinx PCIe host bridge only
supports 32-bit physical addresses (due to a limitation on the AXI
port's address width).  Thus, even devices that claim to support 64-bit
DMA addresses must be restricted to 32-bit addresses when attached to
this host controller.

This patch adds a "add_dev" method  to struct pci_host_bridge that
allows the host driver to act upon acting adding devices.

Based on an earlier patch from Wesley W. Terpstra <wesley@sifive.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/probe.c | 4 ++++
 include/linux/pci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..8736d78ffc66 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2290,6 +2290,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(bus);
 	int ret;
 
 	pci_configure_device(dev);
@@ -2331,6 +2332,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Set up MSI IRQ domain */
 	pci_set_msi_domain(dev);
 
+	if (host->add_dev)
+		host->add_dev(dev);
+
 	/* Notifier could use PCI capabilities */
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index abd5d5e17aee..5eedae8e8f2b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -485,6 +485,7 @@ struct pci_host_bridge {
 			resource_size_t start,
 			resource_size_t size,
 			resource_size_t align);
+	void (*add_dev)(struct pci_dev *dev);
 	unsigned long	private[0] ____cacheline_aligned;
 };
 
-- 
2.18.0
