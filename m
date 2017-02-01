Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 1 Feb 2017 10:02:24 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
Message-ID: <20170201160224.jg6tuls2xcuul3m4@rob-hp-laptop>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170128204839.18330-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-pci@vger.kernel.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Janos Laube <janos.dev@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 28, 2017 at 09:48:36PM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Cortina Systems Gemini PCI
> Host Bridge.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This can be merged to the PCI tree whenever it is considered
> fine for inclusion.
> ---
>  .../devicetree/bindings/pci/cortina,gemini-pci.txt | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cortina,gemini-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/cortina,gemini-pci.txt b/Documentation/devicetree/bindings/pci/cortina,gemini-pci.txt
> new file mode 100644
> index 000000000000..e3090d995e1e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cortina,gemini-pci.txt
> @@ -0,0 +1,64 @@
> +* Cortina Systems Gemini PCI Host Bridge
> +
> +Mandatory properties:
> +
> +- compatible: should be "cortina,gemini-pci"
> +- reg: memory base and size for the host bridge
> +- interrupts: the four PCI interrupts
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- #interrupt-cells: set to <1>
> +- bus-range: set to <0x00 0x00> (only root bus)
> +- device_type, set to "pci"
> +- ranges: see pci.txt

You need to specify what ranges should have for this bridge.

> +- interrupt-map-mask: see pci.txt
> +- interrupt-map: see pci.txt
> +
> +Mandatory subnodes:
> +- One node reprenting the interrupt-controller inside the host bridge
> +  with the following mandatory properties:
> +  - interrupt-controller: see interrupt-controller/interrupts.txt
> +  - #address-cells: set to <0>
> +  - #interrupt-cells: set to <1>
> +
> +Example:
> +
> +pci@50000000 {
> +	compatible = "cortina,gemini-pci";
> +	reg = <0x50000000 0x100>;

Config space is indirectly accessed?

> +	interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
> +			<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
> +			<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
> +			<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +	#interrupt-cells = <1>;
> +
> +	bus-range = <0x00 0x00>; /* Only root bus */
> +	ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
> +		 <0x01000000 0 0          0x50000000 0 0x00100000>,
> +		 /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
> +		 <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
> +	interrupt-map-mask = <0xff00 0 0 7>;
> +	interrupt-map = <0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> +			<0x4900 0 0 2 &pci_intc 1>,
> +			<0x4a00 0 0 3 &pci_intc 2>,
> +			<0x4b00 0 0 4 &pci_intc 3>,
> +			<0x5000 0 0 1 &pci_intc 0>, /* Slot 10 */
> +			<0x5100 0 0 2 &pci_intc 1>,
> +			<0x5200 0 0 3 &pci_intc 2>,
> +			<0x5300 0 0 4 &pci_intc 3>,
> +			<0x5800 0 0 1 &pci_intc 0>, /* Slot 11 */
> +			<0x5900 0 0 2 &pci_intc 1>,
> +			<0x5a00 0 0 3 &pci_intc 2>,
> +			<0x5b00 0 0 4 &pci_intc 3>,
> +			<0x6000 0 0 1 &pci_intc 0>, /* Slot 12 */
> +			<0x6100 0 0 2 &pci_intc 1>,
> +			<0x6200 0 0 3 &pci_intc 2>,
> +			<0x6300 0 0 4 &pci_intc 3>;
> +	pci_intc: interrupt-controller {
> +		interrupt-controller;
> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +	};
> +};
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
