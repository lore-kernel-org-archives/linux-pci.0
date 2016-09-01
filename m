Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <bhelgaas@google.com>, <soren.brinkmann@xilinx.com>,
 <christophe.jaillet@wanadoo.fr>, <grygorii.strashko@ti.com>,
 <yinghai@kernel.org>, <lorenzo.pieralisi@arm.com>, <fengguang.wu@intel.com>,
 <michal.simek@xilinx.com>, <arnd@arndb.de>
Subject: [PATCH 4/6] PCI: Xilinx: Dispose MSI virtual irq
Date: Thu, 1 Sep 2016 15:44:44 +0530
Message-ID: <1472724886-28301-4-git-send-email-bharatku@xilinx.com>
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

Dispose virtual irq being created for MSI interrupts.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index ec2844a..a276fa6 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -261,6 +261,7 @@ static void xilinx_msi_teardown_irq(struct msi_controller *chip,
 				    unsigned int irq)
 {
 	xilinx_pcie_destroy_msi(irq);
+	irq_dispose_mapping(irq);
 }
 
 /**
-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
