Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Po Liu <po.liu@nxp.com>
To: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v6 1/3] arm/dts-ls1021: add pcie aer/pme interrupt-name
 property in the dts
Date: Fri, 30 Sep 2016 17:11:35 +0800
Message-ID: <1475226697-7709-1-git-send-email-po.liu@nxp.com>
In-Reply-To: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
References: <1473741659-17618-3-git-send-email-po.liu@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Roy Zang <roy.zang@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, Po Liu <po.liu@nxp.com>,
 Stuart Yoder <stuart.yoder@nxp.com>, Yang-Leo Li <leoyang.li@nxp.com>,
 Minghuan Lian <minghuan.lian@nxp.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>,
 Mingkai Hu <mingkai.hu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

NXP arm aer/pme interrupts was not MSI/MSI-X/INTx but using interrupt
line independently. This patch add a "aer" "pme" interrupt-names for
aer/pme interrupts.

With the interrupt-names "aer","pme" code could probe aer/pme interrupt
line for pcie root port, replace the aer/pme interrupt service irqs.

This patch is intend to fixup the Layerscape platforms which aer/pme
interrupt was not MSI/MSI-X/INTx, but using interrupt line independently.

Since the interrupt-names "intr" never been used. Remove it.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for v6:
	- add remove "intr" reason;
	- add "pme" interrupt;

 arch/arm/boot/dts/ls1021a.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 368e219..9b3cb3b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -634,7 +634,9 @@
 			reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "pme", "aer";
 			fsl,pcie-scfg = <&scfg 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -657,7 +659,9 @@
 			reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+			interrupt-names = "pme", "aer";
 			fsl,pcie-scfg = <&scfg 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
2.1.0.27.g96db324


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
