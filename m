Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <paul.gortmaker@windriver.com>, <robh@kernel.org>,
 <colin.king@canonical.com>, <linux-pci@vger.kernel.org>,
 <marc.zyngier@arm.com>
Subject: [PATCH 1/4] PCI: Xilinx NWL: Fix,
 do not check for legacy status in while loop
Date: Sat, 21 Jan 2017 16:41:09 +0530
Message-ID: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
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

- The legacy status register value for particular INTx becomes low
only after DEASSERT_INTx is received.
- Few End Points take time for sending DEASSERT_INTx, checking
legacy status register in while loop causes invoking of EP
handler continuosly until DEASSERT_INTx is received.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 43eaa4a..c8b5a33 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -342,9 +342,10 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 	pcie = irq_desc_get_handler_data(desc);
+	status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
+				  MSGF_LEG_SR_MASKALL;
 
-	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
-				MSGF_LEG_SR_MASKALL) != 0) {
+	if (status != 0) {
 		for_each_set_bit(bit, &status, INTX_NUM) {
 			virq = irq_find_mapping(pcie->legacy_irq_domain,
 						bit + 1);
-- 
1.7.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
