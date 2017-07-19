Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 052/102] PCI: imx6: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:56 +0200
Message-Id: <20170719152646.25903-53-p.zabel@pengutronix.de>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/pci/dwc/pci-imx6.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index bf5c3616e3448..5a2ece394ad39 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -778,14 +778,15 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		}
 		break;
 	case IMX7D:
-		imx6_pcie->pciephy_reset = devm_reset_control_get(dev,
-								  "pciephy");
+		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
+									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
 			dev_err(dev, "Failed to get PCIEPHY reset control\n");
 			return PTR_ERR(imx6_pcie->pciephy_reset);
 		}
 
-		imx6_pcie->apps_reset = devm_reset_control_get(dev, "apps");
+		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
+									 "apps");
 		if (IS_ERR(imx6_pcie->apps_reset)) {
 			dev_err(dev, "Failed to get PCIE APPS reset control\n");
 			return PTR_ERR(imx6_pcie->apps_reset);
-- 
2.11.0
