Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] pci: mvebu: avoid changing the SCC bit in the link status
 register
MIME-Version: 1.0
Message-Id: <E1cTbUq-0008Gj-9u@rmk-PC.armlinux.org.uk>
Date: Tue, 17 Jan 2017 21:40:52 +0000
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-pci@vger.kernel.org, Uwe Kleine-König <uwe@kleine-koenig.org>, Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

It seems on later Armada 38x, the slot clock configuration bit is not
read-only, but can be written.  This means that our RW1C protection
ends up clearing this bit when the link control register is written.

Adjust the mask so that we only avoid writing '1' bits to the RW1C
bits of this register (bits 15 and 14 of the link status) rather than
masking out all the status register bits.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 58f75c098b42..3ed4cb7501bd 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -827,10 +827,11 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 		 * If the mask is 0xffff0000, then we only want to write
 		 * the link control register, rather than clearing the
 		 * RW1C bits in the link status register.  Mask out the
-		 * status register bits.
+		 * RW1C bits.
 		 */
 		if (mask == 0xffff0000)
-			value &= 0xffff;
+			value &= ~((PCI_EXP_LNKSTA_LABS |
+				    PCI_EXP_LNKSTA_LBMS) << 16);
 
 		mvebu_writel(port, value, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
 		break;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
