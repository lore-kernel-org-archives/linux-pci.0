Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/37] PCI: dwc: dra7xx: Group all host related setup in
 add_pcie_port
Date: Thu, 12 Jan 2017 15:55:50 +0530
Message-ID: <1484216786-17292-2-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, kishon@ti.com,
 linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

commit 150645b94348 ("PCI: dra7xx: Move struct pcie_port
setup to probe function") moved host related setup to the probe
function. However instead of cluttering the probe function with
host related setup, group all host related setup in add_pcie_port
function. This way when endpoint support is added, all the
endpoint related setup can be added in a separate function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index ec5617a..fb37e09 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -288,9 +288,13 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 				       struct platform_device *pdev)
 {
 	int ret;
-	struct pcie_port *pp = &dra7xx->pp;
-	struct device *dev = pp->dev;
+	struct pcie_port *pp;
 	struct resource *res;
+	struct device *dev = &pdev->dev;
+
+	pp = &dra7xx->pp;
+	pp->dev = dev;
+	pp->ops = &dra7xx_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
@@ -374,7 +378,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct resource *res;
 	struct dra7xx_pcie *dra7xx;
-	struct pcie_port *pp;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	char name[10];
@@ -384,10 +387,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!dra7xx)
 		return -ENOMEM;
 
-	pp = &dra7xx->pp;
-	pp->dev = dev;
-	pp->ops = &dra7xx_pcie_host_ops;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource\n");
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
