Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36132 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbEEWJO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2015 18:09:14 -0400
Received: by iecnq11 with SMTP id nq11so795699iec.3
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2015 15:09:13 -0700 (PDT)
Date: Tue, 5 May 2015 17:09:04 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, m-karicheri2@ti.com,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@stlinux.com, linux-pci@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH v3 2/5] PCI: st: Add Device Tree bindings for sti pcie
Message-ID: <20150505220904.GD24643@google.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-3-git-send-email-gabriel.fernandez@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428657168-12495-3-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 10, 2015 at 11:12:45AM +0200, Gabriel FERNANDEZ wrote:
> sti pcie is built around a Synopsis Designware PCIe IP.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

Arnd, Rob, can you ack this?

> ---
>  Documentation/devicetree/bindings/pci/st-pcie.txt | 53 +++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/st-pcie.txt b/Documentation/devicetree/bindings/pci/st-pcie.txt
> new file mode 100644
> index 0000000..25fcab3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st-pcie.txt
> @@ -0,0 +1,53 @@
> +STMicroelectronics STi PCIe controller
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.txt.
> +
> +Required properties:
> + - compatible: "st,stih407-pcie"
> + - reg: base address and length of the pcie controller, mem-window address
> +   and length available to the controller.
> + - interrupts: A list of interrupt outputs of the controller. Must contain an
> +   entry for each entry in the interrupt-names property.
> + - interrupt-names: Should be "msi". STi interrupt that is asserted when an
> +   MSI is received.
> + - st,syscfg : should be a phandle of the syscfg node. Also contains syscfg
> +   offset for IP configuration.
> + - resets, reset-names: the power-down and soft-reset lines of PCIe IP.
> +   Associated names must be "powerdown" and "softreset".
> + - phys, phy-names: the phandle for the PHY device.
> +   Associated name must be "pcie"
> +
> +Optional properties:
> + - reset-gpio: a GPIO spec to define which pin is connected to the bus reset.
> +
> +Example:
> +
> +pcie0: pcie@9b00000 {
> +	compatible = "st,pcie", "snps,dw-pcie";
> +	device_type = "pci";
> +	reg = <0x09b00000 0x4000>,	/* dbi cntrl registers */
> +	      <0x2fff0000 0x00010000>,	/* configuration space */
> +	      <0x40000000 0x80000000>;	/* lmi mem window */
> +	reg-names = "dbi", "config", "mem-window";
> +	st,syscfg = <&syscfg_core 0xd8 0xe0>;
> +	#address-cells = <3>;
> +	#size-cells = <2>;
> +	ranges = <0x82000000 0 0x20000000 0x20000000 0 0x0FFF0000>; /* non-prefetchable memory */
> +	num-lanes = <1>;
> +	interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "msi";
> +	#interrupt-cells = <1>;
> +	interrupt-map-mask = <0 0 0 7>;
> +	interrupt-map = <0 0 0 1 &intc GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>, /* INT A */
> +			<0 0 0 2 &intc GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>, /* INT B */
> +			<0 0 0 3 &intc GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>, /* INT C */
> +			<0 0 0 4 &intc GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>; /* INT D */
> +
> +	resets = <&powerdown STIH407_PCIE0_POWERDOWN>,
> +		 <&softreset STIH407_PCIE0_SOFTRESET>;
> +	reset-names = "powerdown",
> +		      "softreset";
> +	phys = <&phy_port0 PHY_TYPE_PCIE>;
> +	phy-names = "pcie";
> +};
> -- 
> 1.9.1
> 
