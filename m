Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Li Yang <leoyang.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Minghuan Lian
 <minghuan.Lian@freescale.com>, Mingkai Hu <mingkai.hu@freescale.com>, Roy
 Zang <tie-fei.zang@freescale.com>
Subject: [PATCH] PCI: layerscape: Fix kernel panic on accessing NULL pointer
Date: Mon, 17 Oct 2016 16:44:06 -0500
Message-ID: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Stuart Yoder <stuart.yoder@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Commit fefe6733e added reference to the pcie->drvdata before it is
initialized which causes a kernel panic.  Fix the problem by
initializing the pcie->drvdata earlier before it is used.

Reported-by: Stuart Yoder <stuart.yoder@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/pci/host/pci-layerscape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 2cb7315..958187f 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -245,6 +245,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pcie->drvdata = match->data;
 	pp = &pcie->pp;
 	pp->dev = dev;
 	pp->ops = pcie->drvdata->ops;
@@ -256,7 +257,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->pp.dbi_base);
 	}
 
-	pcie->drvdata = match->data;
 	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
 
 	if (!ls_pcie_is_bridge(pcie))
-- 
1.9.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
