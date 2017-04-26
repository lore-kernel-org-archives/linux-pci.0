Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [RFC/RFT PATCH 14/18] PCI: Add pci_assign_irq() function and have
 pci_fixup_irqs() use it
Date: Wed, 26 Apr 2017 12:18:05 +0100
Message-Id: <20170426111809.19922-15-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Wenrui Li <wenrui.li@rock-chips.com>, Russell King <linux@armlinux.org.uk>,
 Murali Karicheri <m-karicheri2@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

Here we delete the static pdev_fixup_irq() function which is currently
what pci_fixup_irqs() uses to actually assign the irqs and replace it
with the pci_assign_irq() function which changes the interface and
makes use of the new function pointers stored in the host bridge
structure.

Eventually this will allow pci_fixup_irqs() to be removed entirely
and the new deferred assignment code path will call pci_assign_irq
directly. However to ensure current users continue to work a
new implementation of pci_fixup_irqs() is introduced which simply
wraps the functionality of pci_assign_irq().

Signed-off-by: Matthew Minter <matt@masarand.com>
[lorenzo.pieralisi@arm.com: reworked comments/log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/setup-irq.c | 45 +++++++++++++++++++++++++++++++++++----------
 include/linux/pci.h     |  1 +
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 95c225b..5eeee79 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
+#include "pci.h"
 
 void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 {
@@ -22,12 +23,17 @@ void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
 	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
 }
 
-static void pdev_fixup_irq(struct pci_dev *dev,
-			   u8 (*swizzle)(struct pci_dev *, u8 *),
-			   int (*map_irq)(const struct pci_dev *, u8, u8))
+void pci_assign_irq(struct pci_dev *dev)
 {
-	u8 pin, slot;
+	u8 pin;
+	u8 slot = -1;
 	int irq = 0;
+	struct pci_host_bridge *hbrg = pci_find_host_bridge(dev->bus);
+
+	if (!(hbrg->map_irq)) {
+		dev_dbg(&dev->dev, "runtime irq mapping not provided by arch\n");
+		return;
+	}
 
 	/* If this device is not on the primary bus, we need to figure out
 	   which interrupt pin it will come in on.   We know which slot it
@@ -40,17 +46,22 @@ static void pdev_fixup_irq(struct pci_dev *dev,
 	if (pin > 4)
 		pin = 1;
 
-	if (pin != 0) {
+	if (pin) {
 		/* Follow the chain of bridges, swizzling as we go.  */
-		slot = (*swizzle)(dev, &pin);
+		if (hbrg->swizzle_irq)
+			slot = (*(hbrg->swizzle_irq))(dev, &pin);
 
-		irq = (*map_irq)(dev, slot, pin);
+		/*
+		 * If a swizzling function is not used map_irq must
+		 * ignore slot
+		 */
+		irq = (*(hbrg->map_irq))(dev, slot, pin);
 		if (irq == -1)
 			irq = 0;
 	}
 	dev->irq = irq;
 
-	dev_dbg(&dev->dev, "fixup irq: got %d\n", dev->irq);
+	dev_dbg(&dev->dev, "assign irq: got %d\n", dev->irq);
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
@@ -60,9 +71,23 @@ static void pdev_fixup_irq(struct pci_dev *dev,
 void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
 		    int (*map_irq)(const struct pci_dev *, u8, u8))
 {
+	/*
+	 * Implement pci_fixup_irqs() through pci_assign_irq().
+	 * This code should be remove eventually, it is a wrapper
+	 * around pci_assign_irq() interface to keep current
+	 * pci_fixup_irqs() behaviour unchanged on architecture
+	 * code still relying on its interface.
+	 */
 	struct pci_dev *dev = NULL;
+	struct pci_host_bridge *hbrg = NULL;
 
-	for_each_pci_dev(dev)
-		pdev_fixup_irq(dev, swizzle, map_irq);
+	for_each_pci_dev(dev) {
+		hbrg = pci_find_host_bridge(dev->bus);
+		hbrg->swizzle_irq = swizzle;
+		hbrg->map_irq = map_irq;
+		pci_assign_irq(dev);
+		hbrg->swizzle_irq = NULL;
+		hbrg->map_irq = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(pci_fixup_irqs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 722a770..688c669 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1152,6 +1152,7 @@ void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(const struct pci_dev *, u8, u8));
+void pci_assign_irq(struct pci_dev *dev);
 struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res);
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
