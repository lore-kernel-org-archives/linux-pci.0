Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, <lftan.linux@gmail.com>
Subject: [PATCH 3/3] PCI: altera: fix error when INTX is 4
Date: Thu, 3 Dec 2015 19:17:54 +0800
Message-ID: <1449141474-3378-4-git-send-email-lftan@altera.com>
In-Reply-To: <1449141474-3378-1-git-send-email-lftan@altera.com>
References: <1449141474-3378-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI interrupt lines start at 1, not at 0. So, creates additional one
interrupt when register for irq domain.

Error when PCIe devices have 4 INTX:
WARNING: CPU: 1 PID: 1 at kernel/irq/irqdomain.c:280
	irq_domain_associate+0x17c/0x1cc()
error: hwirq 0x4 is too large for dummy

Tested on Ethernet adapter card with multi-functions.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index e4176b3..1a2d4a6 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -467,7 +467,7 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	struct device_node *node = dev->of_node;
 
 	/* Setup INTx */
-	pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM,
+	pcie->irq_domain = irq_domain_add_linear(node, INTX_NUM + 1,
 					&intx_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-- 
1.8.2.1

