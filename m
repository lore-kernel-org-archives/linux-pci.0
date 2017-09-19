Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <marc.zyngier@arm.com>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>,
 <shawnguo@kernel.org>, <Mingkai.Hu@nxp.com>, <Minghuan.Lian@nxp.com>,
 <roy.zang@nxp.com>
Subject: [PATCH 0/5] arm64: add ls1012a and ls1046a pcie support
Date: Tue, 19 Sep 2017 17:26:53 +0800
Message-ID: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set adds ls1012a MSI and PCIe support, including driver
and device tree nodes. The ls1046a's MSI support patch and PCIe
driver patch has been applied, so only adds the PCIe device tree
nodes.

Hou Zhiqiang (5):
  irqchip/ls-scfg-msi: add LS1012a MSI support
  arm64: dts: ls1012a: Add MSI controller DT node
  PCI: layerscape: Add support for ls1012a
  arm64: dts: ls1012a: Add PCIe controller DT node
  arm64: dts: ls1046a: add PCIe controller DT nodes

 .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
 .../devicetree/bindings/pci/layerscape-pci.txt     |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 31 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 75 ++++++++++++++++++++++
 drivers/irqchip/irq-ls-scfg-msi.c                  |  1 +
 drivers/pci/dwc/pci-layerscape.c                   |  1 +
 6 files changed, 110 insertions(+)

-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
