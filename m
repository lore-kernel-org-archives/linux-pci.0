Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50678 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbaBTVcf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 16:32:35 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so1887296wgg.17
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2014 13:32:34 -0800 (PST)
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: linux-pci@vger.kernel.org
Cc: thomas.petazzoni@free-electrons.com, jason@lakedaemon.net,
	Andrew Murray <amurray@embedded-bits.co.uk>
Subject: [PATCH] PCI: mvebu: Remove unnecessary use of 'conf_lock' spinlock
Date: Thu, 20 Feb 2014 21:32:15 +0000
Message-Id: <1392931935-21313-1-git-send-email-amurray@embedded-bits.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Serialization of configuration accesses is provided by 'pci_lock' in
drivers/pci/access.c thus making the driver's 'conf_lock' superfluous.

Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>
---
 drivers/pci/host/pci-mvebu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13478ec..1d61182 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -119,7 +119,6 @@ struct mvebu_pcie {
 struct mvebu_pcie_port {
 	char *name;
 	void __iomem *base;
-	spinlock_t conf_lock;
 	u32 port;
 	u32 lane;
 	int devfn;
@@ -590,7 +589,6 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
 	struct mvebu_pcie_port *port;
-	unsigned long flags;
 	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
@@ -616,10 +614,8 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Access the real PCIe interface */
-	spin_lock_irqsave(&port->conf_lock, flags);
 	ret = mvebu_pcie_hw_wr_conf(port, bus, devfn,
 				    where, size, val);
-	spin_unlock_irqrestore(&port->conf_lock, flags);
 
 	return ret;
 }
@@ -630,7 +626,6 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 {
 	struct mvebu_pcie *pcie = sys_to_pcie(bus->sysdata);
 	struct mvebu_pcie_port *port;
-	unsigned long flags;
 	int ret;
 
 	port = mvebu_pcie_find_port(pcie, bus, devfn);
@@ -662,10 +657,8 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	}
 
 	/* Access the real PCIe interface */
-	spin_lock_irqsave(&port->conf_lock, flags);
 	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
 				    where, size, val);
-	spin_unlock_irqrestore(&port->conf_lock, flags);
 
 	return ret;
 }
@@ -985,7 +978,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		mvebu_pcie_set_local_dev_nr(port, 1);
 
 		port->dn = child;
-		spin_lock_init(&port->conf_lock);
 		mvebu_sw_pci_bridge_init(port);
 		i++;
 	}
-- 
1.8.3.2

