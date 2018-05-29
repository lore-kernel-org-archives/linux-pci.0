Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] reset: imx7: Fix always writing bits as 0
Date: Tue, 29 May 2018 22:39:16 +0300
Message-Id: <c441872d7dd355ae09e945447441389e93e3b888.1527621510.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1527621510.git.leonard.crestez@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Abel Vesa <abel.vesa@nxp.com>,
 Anson Huang <Anson.Huang@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Right now the only user of reset-imx7 is pci-imx6 and the
reset_control_assert and deassert calls on pciephy_reset don't toggle
the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
1 or 0 respectively.

The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
other registers like MIPIPHY and HSICPHY the bits are explicitly
documented as "1 means assert, 0 means deassert".

The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/reset/reset-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 4db177bc89bc..fdeac1946429 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -78,11 +78,11 @@ static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
 static int imx7_reset_set(struct reset_controller_dev *rcdev,
 			  unsigned long id, bool assert)
 {
 	struct imx7_src *imx7src = to_imx7_src(rcdev);
 	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = 0;
+	unsigned int value = assert ? signal->bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
 		/*
 		 * wait for more than 10us to release phy g_rst and
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
