Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <robh@kernel.org>, <bhelgaas@google.com>, <colin.king@canonical.com>,
 <soren.brinkmann@xilinx.com>, <marc.zyngier@arm.com>,
 <michal.simek@xilinx.com>, <arnd@arndb.de>
Subject: [PATCH 2/3] PCI: Xilinx NWL PCIe: Enabling all MSI interrupts using
 MSI mask.
Date: Tue, 30 Aug 2016 16:09:17 +0530
Message-ID: <1472553558-27215-2-git-send-email-bharatku@xilinx.com>
In-Reply-To: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
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

The current mask enables and allows only one MSI interrupt on each MSI line.
This change, enables all MSI interrupts, which will also support End Points
with multi MSI support.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 86c1834..d8d43e6 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -120,8 +120,8 @@
 					MSGF_LEG_SR_INTC | MSGF_LEG_SR_INTD)
 
 /* MSI interrupt status mask bits */
-#define MSGF_MSI_SR_LO_MASK		BIT(0)
-#define MSGF_MSI_SR_HI_MASK		BIT(0)
+#define MSGF_MSI_SR_LO_MASK		GENMASK(31, 0)
+#define MSGF_MSI_SR_HI_MASK		GENMASK(31, 0)
 
 #define MSII_PRESENT			BIT(0)
 #define MSII_ENABLE			BIT(0)
-- 
2.1.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
