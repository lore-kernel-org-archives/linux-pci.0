Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Trent Piepho <tpiepho@impinj.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Workaround for IMX7d PCI-e PLL lock failure
Date: Wed, 18 Jul 2018 12:44:22 -0700
Message-Id: <20180718194424.8844-1-tpiepho@impinj.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Trent Piepho <tpiepho@impinj.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This is the workaround for the IMX7d Erratum e10728, failure of
initialize PCIe PLL VCO oscillation resulting in PLL lock failure and
failure of the PCI-e link to come up.

The registers used in the workaround are based on the latest patch in
the NXP kernel, but many things around that have been changed.

This uses a new node of type fsl,imx-pcie-phy to get the PHY's
registers.  The node is found via a phandle added to the PCI-e
controller's node, rather than the incorrect way done in the NXP kernel.

There is no error if the phandle is not preset (since it's needed except
for the imx7d workaround and no existing dtses have it), but if preset
it is an error if something relating to it does not work.

** Should the node be fsl,imx7d-pcie-phy?  snps,dw-pcie-phy?  

There is little to no documenation from NXP and Synopsis about this, so I'm
unsure of the PHY's lineage.

The imx6 PCI-e driver does not use the generic phy layer to interact
with the PHY.  It appears PHY related hardware, like clocks, regulators,
and resets, are part of the fsl,imx6q-pcie node.  But again, the
topology of this hardware is not documented very well.

Another approach would be to add the PHY registers as another bank in
the PCI-e node.  This would match how the PHY reset, clock, etc.  are
done.  However, the PHY is attached to a different AXI master than the
PCI-e controller, so the register range really does not belong there.

Trent Piepho (2):
  ARM: dts: imx7d: Add node for PCIe PHY
  PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 11 ++++
 arch/arm/boot/dts/imx7d.dtsi                       |  9 ++++
 drivers/pci/dwc/pci-imx6.c                         | 59 ++++++++++++++++++++++
 3 files changed, 79 insertions(+)

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>

-- 
2.14.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
