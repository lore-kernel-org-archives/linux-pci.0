Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Kumar Gala <galak@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 2/3] pci: pci-mvebu: remove useless MSI enabling code
Date: Tue, 28 Feb 2017 15:31:15 +0100
Message-Id: <1488292276-11106-3-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>,
 Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Since commit fcc392d501bd2 ("irqchip/armada-370-xp: Use the generic MSI
infrastructure"), the irqchip driver used on Armada 370, XP, 375, 38x,
39x for the MPIC interrupt controller has been converted to use the
generic MSI infrastructure.

Since this commit, it is no longer registering an msi_controller
structure with the of_pci_msi_chip_add() function. Therefore, having the
PCI driver used on the same platform calling
of_pci_find_msi_chip_by_node() is pretty useless.

The MSI resolution is now done in the generic interrupt resolution code,
since the MSI controller is an irq domain attached to the interrupt
controller node, which is pointed to by the msi-parent DT property in
the PCIe controller node.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v2:
 - Rebased on v4.10.

Changes since v1:
 - Rebased on v4.9.
---
 drivers/pci/host/pci-mvebu.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 45a89d9..2100dbd 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -986,22 +986,6 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 	return -ENOENT;
 }
 
-static void mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
-{
-	struct device_node *msi_node;
-
-	msi_node = of_parse_phandle(pcie->pdev->dev.of_node,
-				    "msi-parent", 0);
-	if (!msi_node)
-		return;
-
-	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
-	of_node_put(msi_node);
-
-	if (pcie->msi)
-		pcie->msi->dev = &pcie->pdev->dev;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mvebu_pcie_suspend(struct device *dev)
 {
@@ -1279,7 +1263,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
 		pci_ioremap_io(i, pcie->io.start + i);
 
-	mvebu_pcie_msi_enable(pcie);
 	mvebu_pcie_enable(pcie);
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
