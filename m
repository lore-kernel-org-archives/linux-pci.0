Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jisheng Zhang <jszhang@marvell.com>
To: <jingoohan1@gmail.com>, <pratyush.anand@gmail.com>, <bhelgaas@google.com>,
 <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 2/2] PCI: designware: let dw_pcie_link_up() beware of LTSSM
 training bit
Date: Wed, 10 Aug 2016 13:31:19 +0800
Message-ID: <1470807079-366-3-git-send-email-jszhang@marvell.com>
In-Reply-To: <1470807079-366-1-git-send-email-jszhang@marvell.com>
References: <1470807079-366-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The link may be UP but still in link training. In this case, we can't
think the link is up and operating correctly. So we need to teach
dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.

This patch also rewrite PCIE_PHY_DEBUG_R1_LINK_UP definition so that
it's consistent with other MACROS.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/host/pcie-designware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 24a16dd..6cc21bb 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -73,7 +73,8 @@
 /* PCIe Port Logic registers */
 #define PLR_OFFSET			0x700
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
+#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
+#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
 
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
@@ -417,7 +418,8 @@ int dw_pcie_link_up(struct pcie_port *pp)
 		return pp->ops->link_up(pp);
 
 	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
+	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
+		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
 }
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-- 
2.8.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
