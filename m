Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 0/3] PCI: imx: Initial imx7d pm support
Date: Fri, 20 Jul 2018 15:47:41 +0300
Message-Id: <cover.1532090446.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-pm@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Changes since v1:
 * Indentation fixes
 * Use imx6_pcie_establish_link instead of imx6_pcie_wait_for_link
 * Move imx6_pcie_ltssm_disable to suspend
 * Make imx6_pcie_clk_disable a separate function
 * Revert PCI irq mapping (also useful separately)

Link to v1: https://lkml.org/lkml/2018/5/29/1042

Leonard Crestez (3):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  reset: imx7: Fix always writing bits as 0
  PCI: imx: Initial imx7d pm support

 arch/arm/boot/dts/imx7d.dtsi          |  8 +--
 drivers/pci/controller/dwc/pci-imx6.c | 95 +++++++++++++++++++++++++--
 drivers/reset/reset-imx7.c            |  2 +-
 3 files changed, 95 insertions(+), 10 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
