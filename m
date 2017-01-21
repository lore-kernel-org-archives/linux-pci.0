Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <paul.gortmaker@windriver.com>, <robh@kernel.org>,
 <colin.king@canonical.com>, <linux-pci@vger.kernel.org>,
 <marc.zyngier@arm.com>
Subject: [PATCH 2/4] PCI: Xilinx NWL: Modifying irq chip for legacy interrupts
Date: Sat, 21 Jan 2017 16:41:10 +0530
Message-ID: <1484997072-19276-2-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: arnd@arndb.de, michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
 Bharat Kumar Gogada <bharatku@xilinx.com>, rgummal@xilinx.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

- Few wifi end points which only support legacy interrupts,
performs hardware reset functionalities after disabling interrupts
by invoking disable_irq and then re-enable using enable_irq, they
enable hardware interrupts first and then virtual irq line later.
- The legacy irq line goes low only after DEASSERT_INTx is
received.As the legacy irq line is high immediately after hardware
interrupts are enabled but virq of EP is still in disabled state
and EP handler is never executed resulting no DEASSERT_INTx.If dummy
irq chip is used, interrutps are not masked and system is
hanging with CPU stall.
- Adding irq chip functions instead of dummy irq chip for legacy
interrupts.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index c8b5a33..e1809f9 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -396,10 +396,44 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void nwl_mask_leg_irq(struct irq_data *data)
+{
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct nwl_pcie *pcie;
+	unsigned int mask = 0;
+
+	pcie = irq_desc_get_chip_data(desc);
+	mask = 1 << (data->hwirq - 1);
+	nwl_bridge_writel(pcie, ((u32)MSGF_LEG_SR_MASKALL & (~mask)),
+			  MSGF_LEG_MASK);
+
+}
+
+static void nwl_unmask_leg_irq(struct irq_data *data)
+{
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	struct nwl_pcie *pcie;
+	unsigned int mask = 0;
+
+	pcie = irq_desc_get_chip_data(desc);
+	mask = 1 << (data->hwirq - 1);
+	nwl_bridge_writel(pcie, ((u32)MSGF_LEG_SR_MASKALL | mask),
+			  MSGF_LEG_MASK);
+
+}
+
+static struct irq_chip nwl_leg_irq_chip = {
+	.name = "nwl_pcie:legacy",
+	.irq_enable = nwl_unmask_leg_irq,
+	.irq_disable = nwl_mask_leg_irq,
+	.irq_mask = nwl_mask_leg_irq,
+	.irq_unmask = nwl_unmask_leg_irq,
+};
+
 static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
 			  irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
