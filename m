Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHDMO0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2018 08:14:26 -0400
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] PCI: add a callback to struct pci_host_bridge for adding a new device
Date: Sat,  4 Aug 2018 12:14:00 +0200
Message-Id: <20180804101402.10022-2-hch@lst.de>
In-Reply-To: <20180804101402.10022-1-hch@lst.de>
References: <20180804101402.10022-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is currently no way for a PCIe bridge to impose constraints on
devices added to it.  For example, the Xilinx PCIe host bridge only
supports 32-bit physical addresses (due to a limitation on the AXI
port's address width).  Thus, even devices that claim to support 64-bit
DMA addresses must be restricted to 32-bit addresses when attached to
this host controller.

This patch adds a "add_device" method  to struct pci_host_bridge that
allows the host driver to act upon acting adding devices.

Based on an earlier patch from Wesley W. Terpstra <wesley@sifive.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/probe.c | 6 ++++++
 include/linux/pci.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..452190fb05e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2290,6 +2290,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(bus);
 	int ret;
 
 	pci_configure_device(dev);
@@ -2328,6 +2329,11 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	ret = pcibios_add_device(dev);
 	WARN_ON(ret < 0);
 
+	if (host->add_device) {
+		ret = host->add_device(dev);
+		WARN_ON(ret < 0);
+	}
+
 	/* Set up MSI IRQ domain */
 	pci_set_msi_domain(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index abd5d5e17aee..1524adbb30ab 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -485,6 +485,7 @@ struct pci_host_bridge {
 			resource_size_t start,
 			resource_size_t size,
 			resource_size_t align);
+	int (*add_device)(struct pci_dev *dev);
 	unsigned long	private[0] ____cacheline_aligned;
 };
 
-- 
2.18.0
