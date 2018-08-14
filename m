Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 14 Aug 2018 16:53:40 -0600
From: Rob Herring <robh@kernel.org>
To: Hanjie Lin <hanjie.lin@amlogic.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe controller
Message-ID: <20180814225340.GA25470@rob-hp-laptop>
References: <1534227522-186798-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
In-Reply-To: <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, Yue Wang <yue.wang@amlogic.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 14, 2018 at 02:18:41AM -0400, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> controller.
> 
> Signed-off-by: Yue Wang <hanjie.lin@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> new file mode 100644
> index 0000000..48233e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -0,0 +1,57 @@
> +Amlogic Meson AXG DWC PCIE SoC controller
> +
> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> +It shares common functions with the PCIe DesignWare core driver and
> +inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties:
> +- compatible:
> +	should contain "amlogic,axg-pcie" to identify the core.
> +- reg:
> +	Should contain the configuration address space.
> +- reg-names: Must be
> +	- "elbi"	External local bus interface registers
> +	- "cfg"		Meson specific registers
> +	- "config"	PCIe configuration space
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Must include the following entries:
> +	- "pcie"
> +	- "pcie_bus"
> +	- "pcie_general"
> +	- "pcie_mipi_en"
> +
> +Example configuration:
> +
> +	pcie: pcie@dffff000 {

Unit-address is wrong.

> +			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +			reg = <0x0 0xf9800000 0x0 0x400000
> +					0x0 0xff646000 0x0 0x2000
> +					0x0 0xf9f00000 0x0 0x100000>;
> +			reg-names = "elbi", "cfg", "config";
> +			reset-gpio = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;

Not documented and should be reset-gpios.

> +			interrupts = <0 177 IRQ_TYPE_EDGE_RISING>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +			bus-range = <0x0 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			phys = <&pcie_phy>;
> +			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
> +			num-lanes = <1>;
> +			pcie-num = <1>;

Not documented. What's this?

> +
> +			clocks = <&clkc CLKID_USB
> +					&clkc CLKID_MIPI_ENABLE
> +					&clkc CLKID_PCIE_A
> +					&clkc CLKID_PCIE_CML_EN0>;
> +			clock-names = "pcie_general",
> +					"pcie_refpll",
> +					"pcie_mipi_en",
> +					"pcie",
> +					"port";
> +	};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
