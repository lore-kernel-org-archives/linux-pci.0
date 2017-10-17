Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Trent Piepho <tpiepho@impinj.com>
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: imx6: Check for link training status in link up check
Date: Mon, 16 Oct 2017 17:11:59 -0700
Message-Id: <20171017001159.109152-2-tpiepho@impinj.com>
In-Reply-To: <20171017001159.109152-1-tpiepho@impinj.com>
References: <20171017001159.109152-1-tpiepho@impinj.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Lucas Stach <l.stach@pengutronix.de>, Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This fixes a regression introduced in merge 562df5c8521e.

Prior to this the link up check done by imx6_pcie_wait_for_link()
consisted of a polling loop on imx6_pcie_link_up() (via the former
calling dw_pcie_link_up() which called the latter as callback), and
imx6_pcie_link_up() polled the link status register checking for link
up *and link not still training*.

This was a polling loop inside another polling loop.  And the outermost
loop was duplicated with minor variations in a number of other dwc based
host drivers.

This was addressed in two commits.  Commit 4d107d3b5a68 ("PCI: imx6: Move
link up check into imx6_pcie_wait_for_link()"), changed
imx6_pcie_wait_for_link() to poll the link status register directly,
checking for link up and not training, and made imx6_pcie_link_up() only
check the link up bit (once, not a polling loop).

While commit commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()"), replaced the loop in imx6_pcie_wait_for_link()
with a call to a new dwc core function, which polled imx6_pcie_link_up(),
which still checked both link up and not training in a loop.

When these two commits were merged, the version of
imx6_pcie_wait_for_link() from '886 was kept, which eliminated the link
training check placed there by '4d1.  But the version of
imx6_pcie_link_up() from '4d1 was kept, which eliminated the link training
check that had been there and was moved to imx6_pcie_wait_for_link().

There result is no link training check.

Then commit dac29e6c5460 ("PCI: designware: Add default link up check if
sub-driver doesn't override") added a link training check to the default
version of dw_pcie_link_up(), but since imx6 uses imx6_pcie_link_up() it
does not use the default version with this fix.

This commit eliminates imx6_pcie_link_up() so that the default
dw_pcie_link_up() is used.  The default has the correct code and is what
the imx6 driver used to do.

Fixes: 562df5c8521e1371f3cbd0b7b868034da376d714
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/dwc/pci-imx6.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index b73483534a5b..1f1069b70e45 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -83,8 +83,6 @@ struct imx6_pcie {
 #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -653,12 +651,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int imx6_pcie_link_up(struct dw_pcie *pci)
-{
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
-			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
-}
-
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
@@ -701,7 +693,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = imx6_pcie_link_up,
+	/* No special ops needed, but pcie-designware still expects this struct */
 };
 
 static int imx6_pcie_probe(struct platform_device *pdev)
-- 
2.13.6


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
