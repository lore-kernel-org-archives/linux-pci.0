Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <soren.brinkmann@xilinx.com>,
 <christophe.jaillet@wanadoo.fr>, <grygorii.strashko@ti.com>,
 <yinghai@kernel.org>, <lorenzo.pieralisi@arm.com>, <fengguang.wu@intel.com>,
 <michal.simek@xilinx.com>, <arnd@arndb.de>
Subject: [PATCH 3/6] PCI: Xilinx: Clear correct msi set bit
Date: Thu, 1 Sep 2016 15:44:43 +0530
Message-ID: <1472724886-28301-3-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>, linux-pci@vger.kernel.org,
 rgummal@xilinx.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Kernel provides virtual irq number at teardown.
Get hwirq number from virtual irq and clear correct
MSI set bit.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index de1c758..ec2844a 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -221,13 +221,15 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
 {
 	struct msi_desc *msi;
 	struct xilinx_pcie_port *port;
+	struct irq_data *d = irq_get_irq_data(irq);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-	if (!test_bit(irq, msi_irq_in_use)) {
+	if (!test_bit(hwirq, msi_irq_in_use)) {
 		msi = irq_get_msi_desc(irq);
 		port = msi_desc_to_pci_sysdata(msi);
 		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
 	} else {
-		clear_bit(irq, msi_irq_in_use);
+		clear_bit(hwirq, msi_irq_in_use);
 	}
 }
 
-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
