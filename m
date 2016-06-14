Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0100.outbound.protection.outlook.com ([65.55.169.100]:46928
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751016AbcFNGXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 02:23:18 -0400
From: Po Liu <po.liu@nxp.com>
To: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"Marc Zyngier" <marc.zyngier@arm.com>,
	Rob Herring <robh@kernel.org>, Roy Zang <roy.zang@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Minghuan Lian <minghuan.lian@nxp.com>,
	Murali Karicheri <m-karicheri2@ti.com>, Po Liu <po.liu@nxp.com>
Subject: [PATCH v2 2/2] pci/aer: interrupt fixup in the quirk
Date: Tue, 14 Jun 2016 14:12:27 +0800
Message-ID: <1465884747-1517-2-git-send-email-po.liu@nxp.com>
In-Reply-To: <1465884747-1517-1-git-send-email-po.liu@nxp.com>
References: <1464242406-20203-1-git-send-email-po.liu@nxp.com>
 <1465884747-1517-1-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms, root port doesn't support MSI/MSI-X/INTx in RC mode.
When chip support the aer interrupt with none MSI/MSI-X/INTx mode,
maybe there is interrupt line for aer pme etc. Search the interrupt
number in the fdt file. Then fixup the dev->irq with it.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for V2:
	- Move to the quirk file

 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ee72ebe..909d479 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <linux/mm.h>
+#include <linux/of_irq.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -4419,3 +4420,25 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
+
+/* If root port doesn't support MSI/MSI-X/INTx in RC mode,
+ * but use standalone irq. Read the device tree for the aer
+ * interrupt number.
+ */
+static void quirk_aer_interrupt(struct pci_dev *dev)
+{
+	int ret;
+	struct device_node *np = NULL;
+
+	if (dev->bus->dev.of_node)
+		np = dev->bus->dev.of_node;
+
+	if (IS_ENABLED(CONFIG_OF_IRQ) && np) {
+		ret = of_irq_get_byname(np, "aer");
+		if (ret > 0) {
+			dev->no_msi = 1;
+			dev->irq = ret;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_aer_interrupt);
-- 
2.1.0.27.g96db324

