Return-Path: <SRS0=agom=SC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D463C43381
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2934D21874
	for <linux-pci@archiver.kernel.org>; Sun, 31 Mar 2019 06:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014591;
	bh=JeRW47ms1WgnmCeMu+iH8xVfQy3OyHahQkdlTnIwzcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uqcW0LZKJD0KXlqP9KCUc01jRIsBz4StDdIFtanMQZbdtjNynV5rnQDIVtQLSoctw
	 S4vab93zquTkb9KPJMKwCz2ug73214z071AH7WlkyWLv1sJimxWdJhgAoSEKDIOKnV
	 d36uzxcFTUR491NJ+/QWMjnT8KxjeVP/C6sHECfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfCaGmU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33391 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbfCaGmU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2019 02:42:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so3178116pgk.0;
        Sat, 30 Mar 2019 23:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=xn5eC5YyW3JWc+Joq7tr8rOI9g53Pfm0PzVW8jdmqlU=;
        b=r8NTGZVYu6sQE9r/axmLGQ8Mstc7EkxB5TJ9HRoSPLJfksvatQ+ULrIVNhP20vAkUb
         p8DBM9eanBsuYRORuXR93y5buTy1aymKIIW+ReyI6z/2Gik1AbuMUppgScitdNu5MfTy
         uJgvO+4f/a7ELM0sEWd+9svlpOdjbtNYTPB3v35Vl7oAixN+WkMh7qAAZx4D6+yumrns
         YIoe3PZA/IL6jE0rOCo2pR5Y4EMn+V9iohihB0KW4V/3QDlgx85iEOpNXgiVO3yKzxON
         /VGHhQD9b6qSI0gh8cgt2oerw7NVRVDm2nMSU/EA/V1cbxijNk1+KYC2wWIci/vZ30fj
         a+Kw==
X-Gm-Message-State: APjAAAV5lCVO8FgNhGzt/xB9a0YoaAT38jjOCu5Ja3+FyI6/xkeAiAIo
        7HhTUNztD9giCYI4+kWLpg==
X-Google-Smtp-Source: APXvYqwK3Oco5TiQWNYNzOzw7vSWLQNOHe8rdzUseJeCKjpPWUdyIr0vysOtILlBBOFCtsXSCvziaw==
X-Received: by 2002:a63:c45:: with SMTP id 5mr47594596pgm.385.1554014538635;
        Sat, 30 Mar 2019 23:42:18 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id b3sm8873166pfi.82.2019.03.30.23.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:17 -0700 (PDT)
Message-ID: <5ca06149.1c69fb81.720fd.79e1@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        tiwai@suse.de, spujar@nvidia.com, skomatineni@nvidia.com,
        liviu.dudau@arm.com, krzk@kernel.org, heiko@sntech.de,
        horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
X-Mutt-References: <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
> Add support for Tegra194 PCIe controllers. These controllers are based
> on Synopsys DesignWare core IP.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../bindings/pci/nvidia,tegra194-pcie.txt          | 209 +++++++++++++++++++++
>  .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |  34 ++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> new file mode 100644
> index 000000000000..31527283a0cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> @@ -0,0 +1,209 @@
> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.txt.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> +- device_type: Must be "pci"
> +- reg: A list of physical base address and length for each set of controller
> +  registers. Must contain an entry for each entry in the reg-names property.
> +- reg-names: Must include the following entries:
> +  "appl": Controller's application logic registers
> +  "window1": This is the aperture of controller available under 4GB boundary
> +             (i.e. within 32-bit space). This aperture is typically used for
> +             accessing config space of root port itself and also the connected
> +             endpoints (by appropriately programming internal Address
> +             Translation Unit's (iATU) out bound region) and also to map
> +             prefetchable/non-prefetchable BARs.

This is usually represented in 'ranges' for BARs.

> +  "config": As per the definition in designware-pcie.txt
> +  "atu_dma": iATU and DMA register. This is where the iATU (internal Address
> +             Translation Unit) registers of the PCIe core are made available
> +             fow SW access.
> +  "dbi": The aperture where root port's own configuration registers are
> +         available
> +  "window2": This is the larger (compared to window1) aperture available above
> +             4GB boundary (i.e. in 64-bit space). This is typically used for
> +             mapping prefetchable/non-prefetchable BARs of endpoints
> +- interrupts: A list of interrupt outputs of the controller. Must contain an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: Must include the following entries:
> +  "intr": The Tegra interrupt that is asserted for controller interrupts
> +  "msi": The Tegra interrupt that is asserted when an MSI is received
> +- bus-range: Range of bus numbers associated with this controller
> +- #address-cells: Address representation for root ports (must be 3)
> +  - cell 0 specifies the bus and device numbers of the root port:
> +    [23:16]: bus number
> +    [15:11]: device number
> +  - cell 1 denotes the upper 32 address bits and should be 0
> +  - cell 2 contains the lower 32 address bits and is used to translate to the
> +    CPU address space
> +- #size-cells: Size representation for root ports (must be 2)
> +- ranges: Describes the translation of addresses for root ports and standard
> +  PCI regions. The entries must be 7 cells each, where the first three cells
> +  correspond to the address as described for the #address-cells property
> +  above, the fourth and fifth cells are for the physical CPU address to
> +  translate to and the sixth and seventh cells are as described for the
> +  #size-cells property above.
> +  - Entries setup the mapping for the standard I/O, memory and
> +    prefetchable PCI regions. The first cell determines the type of region
> +    that is setup:
> +    - 0x81000000: I/O memory region
> +    - 0x82000000: non-prefetchable memory region
> +    - 0xc2000000: prefetchable memory region
> +  Please refer to the standard PCI bus binding document for a more detailed
> +  explanation.
> +- #interrupt-cells: Size representation for interrupts (must be 1)
> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
> +  Please refer to the standard PCI bus binding document for a more detailed
> +  explanation.
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - core_clk
> +- resets: Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - core_apb_rst
> +  - core_rst
> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
> +- phy-names: Must include an entry for each active lane.
> +  "pcie-p2u-N": where N ranges from 0 to one less than the total number of lanes
> +- Controller dependent register offsets
> +  - nvidia,event-cntr-ctrl: EVENT_COUNTER_CONTROL reg offset
> +      0x168 - FPGA
> +      0x1a8 - C1, C2 and C3
> +      0x1c4 - C4
> +      0x1d8 - C0 and C5
> +  - nvidia,event-cntr-data: EVENT_COUNTER_DATA reg offset
> +      0x16c - FPGA
> +      0x1ac - C1, C2 and C3
> +      0x1c8 - C4
> +      0x1dc - C0 and C5
> +- nvidia,controller-id : Controller specific ID
> +      0x0 - C0
> +      0x1 - C1
> +      0x2 - C2
> +      0x3 - C3
> +      0x4 - C4
> +      0x5 - C5
> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> +
> +Optional properties:
> +- nvidia,max-speed: limits controllers max speed to this value.
> +    1 - Gen-1 (2.5 GT/s)
> +    2 - Gen-2 (5 GT/s)
> +    3 - Gen-3 (8 GT/s)
> +    4 - Gen-4 (16 GT/s)
> +- nvidia,init-speed: limits controllers init speed to this value.
> +    1 - Gen-1 (2. 5 GT/s)
> +    2 - Gen-2 (5 GT/s)
> +    3 - Gen-3 (8 GT/s)
> +    4 - Gen-4 (16 GT/s)

Don't we have standard speed properties?

Why do we need 2 values?

> +- nvidia,disable-aspm-states : controls advertisement of ASPM states
> +    bit-0 to '1' : disables advertisement of ASPM-L0s
> +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disables
> +                 advertisement of ASPM-L1.1 and ASPM-L1.2
> +    bit-2 to '1' : disables advertisement of ASPM-L1.1
> +    bit-3 to '1' : disables advertisement of ASPM-L1.2

Seems like these too should be common.

> +- nvidia,disable-clock-request : gives a hint to driver that there is no
> +    CLKREQ signal routing on board
> +- nvidia,update-fc-fixup : needs it to improve perf when a platform is designed
> +    in such a way that it satisfies at least one of the following conditions
> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and

What is Cx?

> +       a) speed is Gen-2 and MPS is 256B
> +       b) speed is >= Gen-3 with any MPS
> +- nvidia,cdm-check : Enables CDM checking. For more information, refer Synopsis
> +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter S.4
> +- nvidia,enable-power-down : Enables power down of respective controller and
> +    corresponding PLLs if they are not shared by any other entity
> +- "nvidia,pex-wake" : Add PEX_WAKE gpio number to provide wake support.
> +- "nvidia,plat-gpios" : Add gpio number that needs to be configured before
> +   system goes for enumeration. There could be platforms where enabling 3.3V and
> +   12V power supplies are done through GPIOs, in which case, list of all such
> +   GPIOs can be specified through this property.

These should be split out to their specific function.

> +- "nvidia,aspm-cmrt" : Common Mode Restore time for proper operation of ASPM to
> +   be specified in microseconds
> +- "nvidia,aspm-pwr-on-t" : Power On time for proper operation of ASPM to be
> +   specified in microseconds
> +- "nvidia,aspm-l0s-entrance-latency" : ASPM L0s entrance latency to be specified
> +   in microseconds

properties with units need unit suffixes as defined in 
property-units.txt.

> +
> +Examples:
> +=========
> +
> +Tegra194:
> +--------
> +
> +SoC DTSI:
> +
> +	pcie@14180000 {
> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> +		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
> +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
> +		reg-names = "appl", "config", "atu_dma";
> +
> +		status = "disabled";
> +
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		num-lanes = <8>;
> +		linux,pci-domain = <0>;
> +
> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> +		clock-names = "core_clk";
> +
> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +		reset-names = "core_apb_rst", "core_rst";
> +
> +		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names = "intr", "msi";
> +
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic 0 72 0x04>;
> +
> +		nvidia,bpmp = <&bpmp>;
> +
> +		nvidia,max-speed = <4>;
> +		nvidia,disable-aspm-states = <0xf>;
> +		nvidia,controller-id = <&bpmp 0x0>;
> +		nvidia,aux-clk-freq = <0x13>;
> +		nvidia,preset-init = <0x5>;
> +		nvidia,aspm-cmrt = <0x3C>;
> +		nvidia,aspm-pwr-on-t = <0x14>;
> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
> +
> +		bus-range = <0x0 0xff>;
> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000      /* downstream I/O (1MB) */
> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non-prefetchable memory (30MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
> +
> +		nvidia,cfg-link-cap-l1sub = <0x1c4>;
> +		nvidia,cap-pl16g-status = <0x174>;
> +		nvidia,cap-pl16g-cap-off = <0x188>;
> +		nvidia,event-cntr-ctrl = <0x1d8>;
> +		nvidia,event-cntr-data = <0x1dc>;
> +		nvidia,dl-feature-cap = <0x30c>;
> +	};
> +
> +Board DTS:
> +
> +	pcie@14180000 {
> +		status = "okay";
> +
> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
> +
> +		phys = <&p2u_2>,
> +		       <&p2u_3>,
> +		       <&p2u_4>,
> +		       <&p2u_5>;
> +		phy-names = "pcie-p2u-0", "pcie-p2u-1", "pcie-p2u-2",
> +			    "pcie-p2u-3";
> +	};
> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> new file mode 100644
> index 000000000000..cc0de8e8e8db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> @@ -0,0 +1,34 @@
> +NVIDIA Tegra194 P2U binding
> +
> +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
> +Speed) each interfacing with 12 and 8 P2U instances respectively.
> +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
> +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
> +lane.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-phy-p2u".
> +- reg: Should be the physical address space and length of respective each P2U
> +       instance.
> +- reg-names: Must include the entry "base".
> +
> +Required properties for PHY port node:
> +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> +
> +Example:
> +
> +hsio-p2u {
> +	compatible = "simple-bus";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	ranges;
> +	p2u_0: p2u@03e10000 {
> +		compatible = "nvidia,tegra194-phy-p2u";
> +		reg = <0x0 0x03e10000 0x0 0x00010000>;
> +		reg-names = "base";
> +
> +		#phy-cells = <0>;
> +	};
> +}
> -- 
> 2.7.4
> 

