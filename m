Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56471 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbbJMSYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 14:24:30 -0400
Message-ID: <561D4C2A.1060704@ti.com>
Date: Tue, 13 Oct 2015 14:23:38 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: WingMan Kwok <w-kwok2@ti.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<kishon@ti.com>, <rogerq@ti.com>, <bhelgaas@google.com>,
	<ssantosh@kernel.org>, <linux@arm.linux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] ARM: keystone: dts: add PCI serdes driver bindings
References: <1444759464-32299-1-git-send-email-w-kwok2@ti.com> <1444759464-32299-4-git-send-email-w-kwok2@ti.com>
In-Reply-To: <1444759464-32299-4-git-send-email-w-kwok2@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/13/2015 02:04 PM, WingMan Kwok wrote:
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>   arch/arm/boot/dts/k2e.dtsi      |   24 ++++++++++++++++++++++++
>   arch/arm/boot/dts/keystone.dtsi |   25 +++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
>
> diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
> index 675fb8e..1ba47d8 100644
> --- a/arch/arm/boot/dts/k2e.dtsi
> +++ b/arch/arm/boot/dts/k2e.dtsi
> @@ -86,6 +86,18 @@
>   			gpio,syscon-dev = <&devctrl 0x240>;
>   		};
>
> +		pcie1_phy: pciephy@2326000 {
> +			#phy-cells = <0>;
> +			compatible = "ti,keystone-serdes-pcie";
> +			reg = <0x02326000 0x4000>;
> +			reg-names = "reg_serdes";
> +			refclk-khz = <100000>;
> +			link-rate-kbps = <5000000>;
> +			phy-type = "pcie";
> +			max-lanes = <2>;
> +			status = "disabled";
> +		};
> +
>   		pcie1: pcie@21020000 {
>   			compatible = "ti,keystone-pcie","snps,dw-pcie";
>   			clocks = <&clkpcie1>;
> @@ -130,6 +142,18 @@
>   					<GIC_SPI 375 IRQ_TYPE_EDGE_RISING>,
>   					<GIC_SPI 376 IRQ_TYPE_EDGE_RISING>;
>   			};
> +
> +			/* PCIE phy */
> +			serdeses {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				serdes@0 {
> +					reg = <0>;
> +					phys = <&pcie1_phy>;
> +					status = "disabled";
> +				};
> +			};
> +
>   		};
>
>   		mdio: mdio@24200f00 {
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index 72816d6..5312319 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -275,6 +275,19 @@
>   			ti,syscon-dev = <&devctrl 0x2a0>;
>   		};
>
> +		pcie0_phy: pciephy@2320000 {
> +			#phy-cells = <0>;
> +			compatible = "ti,keystone-serdes-pcie";
> +			reg = <0x02320000 0x4000>;
> +			reg-names = "reg_serdes";
> +			refclk-khz = <100000>;
> +			link-rate-kbps = <5000000>;
> +			init-firmware	= "k2_pcie_serdes_init.fw";
> +			phy-type = "pcie";
> +			max-lanes = <2>;
> +			status = "disabled";
> +		};
> +
>   		pcie0: pcie@21800000 {
>   			compatible = "ti,keystone-pcie", "snps,dw-pcie";
>   			clocks = <&clkpcie>;
> @@ -319,6 +332,18 @@
>   					<GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
>   					<GIC_SPI 29 IRQ_TYPE_EDGE_RISING>;
>   			};
> +
> +			/* PCIE phy */
> +			serdeses {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				serdes@0 {
> +					reg = <0>;
> +					phys = <&pcie0_phy>;
> +					status = "disabled";
> +				};
> +			};
> +
>   		};
>   	};
>   };
>
Wingman,

This should be a separate patch and remove the sane from Driver patch. 
i.e. send 1/3 ane 2/3 in one series and 3/3 as a separate patch.

Thanks

Murali

-- 
Murali Karicheri
Linux Kernel, Keystone
