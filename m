Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Date: Tue, 24 Jul 2018 19:14:18 +0300
Message-Id: <cover.1532448745.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 kernel@pengutronix.de, Anson Huang <Anson.Huang@nxp.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-imx@nxp.com,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Changes since v2:
 * Print with dev_info if link fails on resume (Lucas)
 * Add a comment on imx7d pci irq mappings (Andrey)
 * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)

The ltssm_disable does not return an error because it can't be usefully
handled, reversing partial suspend is a nightmare and unlikely to work.

 * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)

Series is against linux-next tag next-20180724 where the reset patch was
already accepted. The imx7d.dtsi patch is also useful standalone.

Link to v2: https://lkml.org/lkml/2018/7/20/472

Leonard Crestez (2):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  PCI: imx: Initial imx7d pm support

 arch/arm/boot/dts/imx7d.dtsi          | 12 ++--
 drivers/pci/controller/dwc/pci-imx6.c | 97 +++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 9 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
