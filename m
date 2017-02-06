Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v3 1/3] PCI: imx6: Fix a typo in error message
Date: Mon,  6 Feb 2017 07:17:14 -0800
Message-Id: <20170206151716.10381-2-andrew.smirnov@gmail.com>
In-Reply-To: <20170206151716.10381-1-andrew.smirnov@gmail.com>
References: <20170206151716.10381-1-andrew.smirnov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 yurovsky@gmail.com, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Cc: yurovsky@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Acked-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/host/pci-imx6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index c8cefb0..50a1291 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -678,8 +678,7 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
 		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
-			dev_err(dev,
-				"pcie_incbound_axi clock missing or invalid\n");
+			dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
 		}
 	}
-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
