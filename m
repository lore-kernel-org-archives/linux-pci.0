Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matthew Minter <matt@masarand.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFT PATCH 9/9] PCI: Remove pci_fixup_irqs() function
Date: Mon, 31 Jul 2017 17:37:57 +0100
Message-Id: <20170731163757.22629-10-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
References: <20170731163757.22629-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

Now we have removed all callers of pci_fixup_irqs() and
migrated everything to pci_assign_irq() delete the
pci_fixup_irqs() function completely.

Signed-off-by: Matthew Minter <matt@masarand.com>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/setup-irq.c | 24 ------------------------
 include/linux/pci.h     |  2 --
 2 files changed, 26 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 81eda3d..69e3b56 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -67,27 +67,3 @@ void pci_assign_irq(struct pci_dev *dev)
 	   the real IRQ to use; the device does not use it. */
 	pcibios_update_irq(dev, irq);
 }
-
-void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
-		    int (*map_irq)(const struct pci_dev *, u8, u8))
-{
-	/*
-	 * Implement pci_fixup_irqs() through pci_assign_irq().
-	 * This code should be remove eventually, it is a wrapper
-	 * around pci_assign_irq() interface to keep current
-	 * pci_fixup_irqs() behaviour unchanged on architecture
-	 * code still relying on its interface.
-	 */
-	struct pci_dev *dev = NULL;
-	struct pci_host_bridge *hbrg = NULL;
-
-	for_each_pci_dev(dev) {
-		hbrg = pci_find_host_bridge(dev->bus);
-		hbrg->swizzle_irq = swizzle;
-		hbrg->map_irq = map_irq;
-		pci_assign_irq(dev);
-		hbrg->swizzle_irq = NULL;
-		hbrg->map_irq = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(pci_fixup_irqs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4869e66..69034ab 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1160,8 +1160,6 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
 void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
-void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-		    int (*)(const struct pci_dev *, u8, u8));
 void pci_assign_irq(struct pci_dev *dev);
 struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res);
 #define HAVE_PCI_REQ_REGIONS	2
-- 
2.10.0
