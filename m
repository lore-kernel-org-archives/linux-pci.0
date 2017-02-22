Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35829 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753463AbdBVA0n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2017 19:26:43 -0500
Date: Tue, 21 Feb 2017 18:26:40 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Gavin Guo <gavinguo@andestech.com>,
        Macpaul Lin <macpaul@andestech.com>,
        Janos Laube <janos.dev@gmail.com>,
        Paulius Zaleckas <paulius.zaleckas@gmail.com>,
        openwrt-devel@openwrt.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feng-Hsin Chiang <john453@faraday-tech.com>
Subject: Re: [PATCH 1/4] PCI: add DT bindings for Faraday Technology PCI Host
 Bridge
Message-ID: <20170222002640.y2uhumje5csioure@rob-hp-laptop>
References: <20170211125220.10273-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170211125220.10273-1-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 11, 2017 at 01:52:17PM +0100, Linus Walleij wrote:
> This adds device tree bindings for the Faraday technology PCI
> Host Bridge. This IP is found in the Storlink/Storm/Cortina
> Gemini SoC platform.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Gavin Guo <gavinguo@andestech.com>
> Cc: Macpaul Lin <macpaul@andestech.com>
> Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rename from Cortina prefixes to Faraday. This is clearly
>   a Faraday IP block.
> - Support both the version with cascaded interrupts and the
>   "dual" version with 1-to-1 mapped interrupts.
> - Change bus-range to <0x00 0xff>
> - Fix spelling mistake
> - Write a bit about swizzling interrupts on the interrupt
>   controller side
> - Reasonable swizzling in the interrupt mapping example
> 
> This can be merged to the PCI tree whenever it is considered
> fine for inclusion.
> ---
>  .../devicetree/bindings/pci/faraday-pci.txt        | 113 +++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/faraday-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/faraday-pci.txt b/Documentation/devicetree/bindings/pci/faraday-pci.txt
> new file mode 100644
> index 000000000000..5fbb0fc6b758
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/faraday-pci.txt
> @@ -0,0 +1,113 @@
> +Faraday Technology PCI Host Bridge
> +
> +This PCI bridge is found inside that Cortina Systems Gemini SoC platform and
> +is a generic IP block from Faraday Technology. It exists in two variants:
> +plain and dual PCI. The plain version embeds a cascading interrupt controller
> +into the host bridge. The dual version routes the interrupts to the host
> +chips interrupt controller.
> +
> +The host controller appear on the PCI bus with vendor ID 0x159b (Faraday
> +Technology) and product ID 0x4321.
> +
> +Mandatory properties:
> +
> +- compatible: should be one of
> +  "faraday,pci"
> +  "faraday,dual-pci"

Probably should still have a Cortina specific compatible.

> +- reg: memory base and size for the host bridge
> +- #address-cells: set to <3>
> +- #size-cells: set to <2>
> +- #interrupt-cells: set to <1>
> +- bus-range: set to <0x00 0xff>
> +- device_type, set to "pci"
> +- ranges: see pci.txt
> +- interrupt-map-mask: see pci.txt
> +- interrupt-map: see pci.txt
> +
> +Mandatory subnodes:
> +- For "faraday,pci" a node representing the interrupt-controller inside the
> +  host bridge is mandatory. It has the following mandatory properties:
> +  - interrupt: see interrupt-controller/interrupts.txt
> +  - interrupt-parent: see interrupt-controller/interrupts.txt
> +  - interrupt-controller: see interrupt-controller/interrupts.txt
> +  - #address-cells: set to <0>
> +  - #interrupt-cells: set to <1>
> +
> +I/O space considerations:
> +
> +The plain variant has 128MiB of non-prefetchable memory space, whereas the
> +"dual" variant has 64MiB. Take this into account when describing the ranges.
> +
> +Interrupt map considerations:
> +
> +The "dual" variant will get INT A, B, C, D from the system interrupt controller
> +and should point to respective interrupt in that controller in its
> +interrupt-map.
> +
> +The code which is the only documentation of how the Faraday PCI (the non-dual
> +variant) interrupts assigns the default interrupt mapping/swizzling has
> +typically been like this, doing the swizzling on the interrupt controller side
> +rather than in the interconnect:
> +
> +interrupt-map-mask = <0xf800 0 0 7>;
> +interrupt-map =
> +	<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> +	<0x4800 0 0 2 &pci_intc 1>,
> +	<0x4800 0 0 3 &pci_intc 2>,
> +	<0x4800 0 0 4 &pci_intc 3>,
> +	<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
> +	<0x5000 0 0 2 &pci_intc 2>,
> +	<0x5000 0 0 3 &pci_intc 3>,
> +	<0x5000 0 0 4 &pci_intc 0>,
> +	<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
> +	<0x5800 0 0 2 &pci_intc 3>,
> +	<0x5800 0 0 3 &pci_intc 0>,
> +	<0x5800 0 0 4 &pci_intc 1>,
> +	<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
> +	<0x6000 0 0 2 &pci_intc 0>,
> +	<0x6000 0 0 3 &pci_intc 1>,
> +	<0x6000 0 0 4 &pci_intc 2>;
> +
> +Example:
> +
> +pci@50000000 {
> +	compatible = "faraday,pci";
> +	reg = <0x50000000 0x100>;
> +	interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
> +			<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
> +			<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
> +			<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +	#interrupt-cells = <1>;

This doesn't belong here (I think).

> +
> +	bus-range = <0x00 0xff>;
> +	ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
> +		 <0x01000000 0 0          0x50000000 0 0x00100000>,
> +		 /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
> +		 <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
> +	interrupt-map-mask = <0xf800 0 0 7>;
> +	interrupt-map =
> +		<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
> +		<0x4800 0 0 2 &pci_intc 1>,
> +		<0x4800 0 0 3 &pci_intc 2>,
> +		<0x4800 0 0 4 &pci_intc 3>,
> +		<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
> +		<0x5000 0 0 2 &pci_intc 2>,
> +		<0x5000 0 0 3 &pci_intc 3>,
> +		<0x5000 0 0 4 &pci_intc 0>,
> +		<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
> +		<0x5800 0 0 2 &pci_intc 3>,
> +		<0x5800 0 0 3 &pci_intc 0>,
> +		<0x5800 0 0 4 &pci_intc 1>,
> +		<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
> +		<0x6000 0 0 2 &pci_intc 0>,
> +		<0x6000 0 0 3 &pci_intc 0>,
> +		<0x6000 0 0 4 &pci_intc 0>;
> +	pci_intc: interrupt-controller {
> +		interrupt-parent = <&intcon>;
> +		interrupt-controller;
> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +	};
> +};
> -- 
> 2.9.3
> 
