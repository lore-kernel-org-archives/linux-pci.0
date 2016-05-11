Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB
 PCIe bindings
Date: Wed, 11 May 2016 14:45:51 +0000
Message-ID: <8520D5D51A55D047800579B094147198258955CE@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-2-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1462475700-1654-2-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jim2101024@gmail.com" <jim2101024@gmail.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> 
>  .../devicetree/bindings/pci/brcm,brcmstb-pcie.txt  | 98
> ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
> b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
> new file mode 100644
> index 000000000000..3682b0f0bc26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
> @@ -0,0 +1,98 @@
> +Broadcom STB PCIe Host Controller Device Tree Bindings
> +
> +This document describes the binding of the PCIe Root Complex hardware
> +found in Broadcom Set Top Box System-on-Chips such as BCM7425 (MIPS),
> +BCM7435 (MIPS) and
> +BCM7445 (ARMv7).
> +
> +Required properties:
> +- compatible: must be one of: "brcm,bcm7425-pcie"
> +			      "brcm,bcm7435-pcie"
> +			      "brcm,bcm7445-pcie"
> +
> +- reg: specifies the physical base address of the controller registers
> +and
> +  its length
> +
> +- interrupt-parent: must be a reference (phandle) to the parent
> +interrupt
> +  controller in the system (7038-l1-intc on MIPS, GIC on ARM/ARM64)
> +
> +- interrrupts: first interrupt must be the Level 1 interrupt number
> +corresponding
> +  to the main PCIe RC interrupt, second interrupt must be the MSI
> +interrupt
> +  See the interrupt-parent documentation for the number of cells and their
> meaning:
> +  MIPS:
> +Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-
> l1-
> +intc.txt
> +  ARM/ARM64:
> +Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
> +
> +- interrupt-names: must be "pcie", and if present "msi"
> +
> +- interrupt-map: see pci.txt
> +
> +- interrupt-map-mask: see pci.txt
> +
> +- #address-cells: must be set to <3>, see pci.txt
> +
> +- #size-cells: must be set to <2>, see pci.txt
> +
> +- ranges: ranges for the PCI outbound windows, no I/O or prefetchable
> +windows
> +  must be specified here, only non-prefetchable. 32-bits windows or
> +64-bits
> +  windows are allowed based on the host processor's capabilities (ARM
> +w/ LPAE,
> +  ARM64).
> +
> +- #interrupt-cells: set to <1>, see pci.txt
> +
> +- brcm,log2-scb-sizes: log2 size of the SCB window that is mapped to
> +PCIe space
> +  there must be exactly one value per memory controller present in the
> +system
> +  (ranges from 1 to 3)

Can you please give more insight on what does this property do ?

Bharat
> +
> +Optional properties:
> +
> +- msi-controller: indicates that this is a MSI controller node (when
> +supported)
> +
> +- clocks: phandle to the functional clock that feeds into the PCIe RC
> +block
> +
> +- clock-names: the name(s) of the clocks specified in 'clocks'.  Note
> +  that if the 'clocks' property is given, 'clock-names' is mandatory,
> +  and the name of the clock is expected to be "pcie".
> +
> +- brcm,ssc: boolean that indicates usage of spread-spectrum clocking
> +
> +- brcm,gen: integer that indicates desired forced generation of link: 1
> +=> 2.5
> +  Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps. Will override the auto-negotation
> +if
> +  specified.
> +
> +- <*>-supply: see
> +Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +- <*>-supply-names: see
> +Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +Example Node:
> +
> +This example assumes that the top-level #address-cells = <2> and
> +#size-cells = <2>, e.g: ARM LPAE configuration.
> +
> +	pcie0: pcie-controller@f0460000 {
> +		reg = <0x0 0xf0460000 0x0 0x9310>;
> +		interrupts = <0x0 0x33 0x4>, <0x0 0x34, 0x4>;
> +		interrupt-names = "pcie", "msi";
> +		compatible = "brcm,bcm7445-pcie";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		/* Two non-prefetchable 32-bits memory space, each of
> 128MB
> + 		 * with the following mapping:
> +		 * PCIe address		=> CPU physical address space
> +		 * 0x00_0000_0000	=> 0x00_C000_0000
> +		 * 0x00_0800_0000	=> 0x00_C800_0000
> +		 */
> +		ranges = <0x02000000 0x00000000 0x00000000 0x00000000
> 0xc0000000 0x00000000 0x08000000>,
> +			 <0x02000000 0x00000000 0x08000000 0x00000000
> 0xc8000000 0x00000000 0x08000000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0 0 0 1 &intc 47 3
> +				 0 0 0 2 &intc 48 3
> +				 0 0 0 3 &intc 49 3
> +				 0 0 0 4 &intc 50 3>;
> +		clocks = <&pcie0>;
> +		clock-names = "pcie";
> +		brcm,ssc;
> +		brcm,log2-scb-sizes = <0x1e 0x1e 0x1e>;
> +		vreg-wifi-pwr-supply-names = "vreg-wifi-pwr";
> +		vreg-wifi-pwr-supply = <&vreg-wifi-pwr>;
> +	};
> --
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
