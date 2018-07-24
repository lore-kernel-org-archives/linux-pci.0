Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC] PCI: imx: Add multi-pd support
Date: Tue, 24 Jul 2018 21:17:38 +0300
Message-Id: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
 linux-pm@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>, linux-imx@nxp.com, kernel@pengutronix.de,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On some chips the PCIE and PCIE_PHY blocks are in separate power domains
which can be power-gated independently. The driver needs to handle this
by keeping both domain active.

This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
it's own domain. Defining the DISPMIX domain requires a way for pcie to
keep it active or it will break when displays are off.

The power-domains on imx6sx are meant to look like this:
	power-domains = <&pd_disp>, <&pd_pci>;
	power-domain-names = "pcie", "pcie_phy";

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---

Right now if a device has a single power domain it will be activated
before probe but if it has multiple domains they need to be explicitly
"attached" to and controlled. Supporting both is a bit awkward, this
patch makes the distinction based on (dev->pm_domain != NULL).

Maybe the PM core should make this distinction based on a flag in struct
device_driver instead of number of power-domains? So by default when a
device has multiple power domains they would would be activated
together and this patch would be unnecessary.

This is marked as "RFC" mostly because I believe it should be handled
inside PM core, without driver code. Does this make sense to anyone else?

This is independent of recent patches adding suspend/resume support to
imx pci, but supporting suspend with multi-pd requires adding device
links, not just activating pds at probe time.

The device_link is marked as "STATELESS" because otherwise a warning is
triggered in device_links_driver_bound. This seems to happen because the
pd devices are always marked as "DL_DEV_NO_DRIVER". Maybe they should be
instead always be marked as DL_DEV_DRIVER_BOUND?

The imx pci driver doesn't support unbind or removal anyway so this is
not handled for multi-pd either.

Previously: https://lkml.org/lkml/2018/7/10/230
---
 drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index fc9529619469..7403918010e9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -25,10 +25,12 @@
 #include <linux/resource.h>
 #include <linux/signal.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 
 #include "pcie-designware.h"
 
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
@@ -57,10 +59,15 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+
+	/* power domain for pcie itself (dispmix) */
+	struct device		*pd_pcie;
+	/* power domain for pcie phy */
+	struct device		*pd_pcie_phy;
 };
 
 /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
 #define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
 #define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
@@ -805,10 +812,47 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 static const struct dev_pm_ops imx6_pcie_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
 				      imx6_pcie_resume_noirq)
 };
 
+static int imx6_pcie_attach_pd(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct device_link *link;
+
+	/* Do nothing when in a single power domain */
+	if (dev->pm_domain)
+		return 0;
+
+	imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
+	if (IS_ERR(imx6_pcie->pd_pcie))
+		return PTR_ERR(imx6_pcie->pd_pcie);
+	link = device_link_add(dev, imx6_pcie->pd_pcie,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
+	if (IS_ERR(imx6_pcie->pd_pcie_phy))
+		return PTR_ERR(imx6_pcie->pd_pcie_phy);
+
+	device_link_add(dev, imx6_pcie->pd_pcie_phy,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+	if (IS_ERR(link)) {
+		dev_err(dev, "Failed to add device_link to pcie_phy pd: %ld\n", PTR_ERR(link));
+		return PTR_ERR(link);
+	}
+
+	return 0;
+}
+
 static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
@@ -945,10 +989,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie = NULL;
 	}
 
 	platform_set_drvdata(pdev, imx6_pcie);
 
+	ret = imx6_pcie_attach_pd(dev);
+	if (ret)
+		return ret;
+
 	ret = imx6_add_pcie_port(imx6_pcie, pdev);
 	if (ret < 0)
 		return ret;
 
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
