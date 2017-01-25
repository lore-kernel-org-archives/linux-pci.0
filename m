Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <paul.gortmaker@windriver.com>,
        <robh@kernel.org>, <colin.king@canonical.com>,
        <linux-pci@vger.kernel.org>, <marc.zyngier@arm.com>
CC: <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rgummal@xilinx.com>,
        <arnd@arndb.de>, "Bharat Kumar Gogada" <bharatku@xilinx.com>
Subject: [PATCH v2 2/2] PCI: Xilinx NWL: Fix, proc interrupts for legacy virtual irq shown as edge
Date: Wed, 25 Jan 2017 14:22:33 +0530
Message-ID: <1485334353-26815-2-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1485334353-26815-1-git-send-email-bharatku@xilinx.com>
References: <1485334353-26815-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

- Legacy interrupts are level triggered, virtual irq line of End
Point shows as edge in /proc/interrupts.
- Setting irq flags of virtual irq line of EP to level triggered
at the time of mapping.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 6ac3e1d..1cddd1f 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -434,6 +434,7 @@ static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
 {
 	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
 
 	return 0;
 }
-- 
2.1.1
