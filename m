Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35725 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758555AbcIPORL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2016 10:17:11 -0400
Date: Fri, 16 Sep 2016 09:17:08 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pcie: qcom: add support to msm8996 PCIE controller
Message-ID: <20160916141708.GA21504@rob-hp-laptop>
References: <1473246412-24616-1-git-send-email-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473246412-24616-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 07, 2016 at 12:06:52PM +0100, Srinivas Kandagatla wrote:
> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
> 
> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
> pipe clocks and smmu configuration are only setup after the phy is
> powered on. It also adds ltssm_enable callback as it is very much
> different to other supported SOCs in the driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> I tested this patch along with phy driver patch on DB820c based on
> APQ8096 on port A and port B using sata and ethernet controllers.
> 
> Thanks
> srini
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  88 +++++++-
>  drivers/pci/host/pcie-qcom.c                       | 237 ++++++++++++++++++++-
>  2 files changed, 318 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 4059a6f..1ddfcb4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -92,6 +92,18 @@
>  			- "aux"		Auxiliary (AUX) clock
>  			- "bus_master"	Master AXI clock
>  			- "bus_slave"	Slave AXI clock
> +
> +- clock-names:
> +	Usage: required for msm8996/apq8096
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "aux"		Auxiliary (AUX) clock
> +			- "bus_master"	Master AXI clock
> +			- "bus_slave"	Slave AXI clock
> +			- "pipe"	Pipe Clock driving internal logic.
> +			- "cfg"		Configuration clk.
> +			- "snoc_axi"	SNOC AXI clk
> +			- "cnoc_ahb"	CNOC AHB clk
>  - resets:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -114,8 +126,15 @@
>  	Definition: Should contain the following entries
>  			- "core" Core reset
>  
> +- iommus:
> +	Usage: required for msm8996/apq8096
> +	Value type: <prop-encoded-array>
> +	Definition: Should point to the respective IOMMU block with master port
> +		    as argument, see Documentation/devicetree/bindings/iommu/
> +		    mediatek,iommu.txt for details.
> +
>  - power-domains:
> -	Usage: required for apq8084
> +	Usage: required for apq8084 and msm8996/apq8096
>  	Value type: <prop-encoded-array>
>  	Definition: A phandle and power domain specifier pair to the
>  		    power domain which is responsible for collapsing
> @@ -137,6 +156,11 @@
>  	Definition: A phandle to the analog power supply for IC which generates
>  		    reference clock
>  
> +- vdda_1p8-supply:

Don't use '_' in property names.

> +	Usage: required for msm8996/apq8096
> +	Value type: <phandle>
> +	Definition: A phandle to the analog power supply for PCIE_1P8
> +
>  - phys:
>  	Usage: required for apq8084
>  	Value type: <phandle>
> @@ -231,3 +255,65 @@
>  		pinctrl-0 = <&pcie0_pins_default>;
>  		pinctrl-names = "default";
>  	};
> +
> +* Example for apq8096:
> +	pcie1: qcom,pcie@00608000 {

pcie@...

> +		compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
> +		power-domains = <&gcc PCIE1_GDSC>;
> +		bus-range = <0x00 0xff>;
> +		num-lanes = <1>;
> +
> +		status  = "disabled";
> +
> +		reg = <0x00608000 0x2000>,
> +		      <0x0d000000 0xf1d>,
> +		      <0x0d000f20 0xa8>,
> +		      <0x0d100000 0x100000>;
> +
> +		reg-names = "parf", "dbi", "elbi","config";
> +
> +		phys = <&pcie_phy 1>;
> +		phy-names = "pciephy";
> +
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
> +			<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
> +
> +		interrupts = <GIC_SPI 413 IRQ_TYPE_NONE>;
> +		interrupt-names = "msi";
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0x7>;
> +		interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +				<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +				<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +				<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
> +		pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
> +
> +
> +		vreg-1.8-supply = <&pm8994_l12>;
> +		vreg-0.9-supply = <&pm8994_l28>;

Doesn't match binding?

> +		iommus = <&anoc0_smmu>;
> +
> +		linux,pci-domain = <1>;
> +
> +		clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +			<&gcc GCC_PCIE_1_AUX_CLK>,
> +			<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +			<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +			<&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +			<&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
> +			<&gcc GCC_AGGRE0_CNOC_AHB_CLK>;
> +
> +		clock-names =  "pipe",
> +				"aux",
> +				"cfg",
> +				"bus_master",
> +				"bus_slave",
> +				"snoc_axi",
> +				"cnoc_ahb";
> +
> +	};
