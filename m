Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: <honghui.zhang@mediatek.com>
To: <bhelgaas@google.com>, <robh+dt@kerenl.org>, <matthias.bgg@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
 <eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH 2/5] PCI: mediatek: switch to use
 platform_get_resource_byname()
Date: Fri, 21 Jul 2017 10:32:44 +0800
Message-ID: <a453ae0e2fb32972b53c9478030fc41ec1208e33.1500601172.git.honghui.zhang@mediatek.com>
In-Reply-To: <cover.1500601172.git.honghui.zhang@mediatek.com>
References: <cover.1500601172.git.honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, sean.wang@mediatek.com,
 xinping.qian@mediatek.com, honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 yong.wu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Ryder Lee <ryder.lee@mediatek.com>

This is a transitional patch. We currently use platfarm_get_resource() for
retrieving the IOMEM resources, but there might be some chips don't have
subsys/shared registers part, which depends on platform design, and these
will be introduced in further patches.

Switch this function to use the platform_get_resource_byname() so that the
binding can be agnostic of the resource order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index d6ac342..5e0a2ee2 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -295,7 +295,8 @@ static int mtk_pcie_parse_ports(struct mtk_pcie *pcie,
 		return err;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
+	snprintf(name, sizeof(name), "port%d", index);
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	port->base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(port->base)) {
 		dev_err(dev, "failed to map port%d base\n", index);
@@ -336,12 +337,14 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 	struct resource *regs;
 	int err;
 
-	/* get shared registers */
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(pcie->base)) {
-		dev_err(dev, "failed to map shared register\n");
-		return PTR_ERR(pcie->base);
+	/* get shared registers, which are optional */
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "subsys");
+	if (regs) {
+		pcie->base = devm_ioremap_resource(dev, regs);
+		if (IS_ERR(pcie->base)) {
+			dev_err(dev, "failed to map shared register\n");
+			return PTR_ERR(pcie->base);
+		}
 	}
 
 	pcie->free_ck = devm_clk_get(dev, "free_ck");
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
