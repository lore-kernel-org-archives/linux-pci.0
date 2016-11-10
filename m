Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34995 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935654AbcKJU1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 15:27:12 -0500
Date: Thu, 10 Nov 2016 14:26:12 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: qcom: add support to msm8996 PCIE controller
Message-ID: <20161110202612.nvt5qiemydutoqoh@rob-hp-laptop>
References: <1478264387-17914-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1478264387-17914-3-git-send-email-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478264387-17914-3-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 04, 2016 at 12:59:46PM +0000, Srinivas Kandagatla wrote:
> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
> 
> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
> pipe clocks are only setup after the phy is powered on.
> It also adds ltssm_enable callback as it is very much different to other
> supported SOCs in the driver.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt          |  68 +++++++-
>  drivers/pci/host/pcie-qcom.c                       | 177 ++++++++++++++++++++-
>  2 files changed, 239 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 4059a6f..4a0538d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -7,6 +7,7 @@
>  			- "qcom,pcie-ipq8064" for ipq8064
>  			- "qcom,pcie-apq8064" for apq8064
>  			- "qcom,pcie-apq8084" for apq8084
> +			- "qcom,pcie-msm8996" for msm8996 or apq8096
>  
>  - reg:
>  	Usage: required
> @@ -92,6 +93,16 @@
>  			- "aux"		Auxiliary (AUX) clock
>  			- "bus_master"	Master AXI clock
>  			- "bus_slave"	Slave AXI clock
> +
> +- clock-names:
> +	Usage: required for msm8996/apq8096
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "aux"		Auxiliary (AUX) clock.
> +			- "bus_master"	Master AXI clock.
> +			- "bus_slave"	Slave AXI clock.
> +			- "pipe"	Pipe Clock driving internal logic.
> +			- "cfg"		Configuration clk.

The order here and the order in the example don't match. The order 
should be defined.

>  - resets:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -115,7 +126,7 @@
>  			- "core" Core reset
>  
>  - power-domains:
> -	Usage: required for apq8084
> +	Usage: required for apq8084 and msm8996/apq8096
>  	Value type: <prop-encoded-array>
>  	Definition: A phandle and power domain specifier pair to the
>  		    power domain which is responsible for collapsing
> @@ -231,3 +242,58 @@
>  		pinctrl-0 = <&pcie0_pins_default>;
>  		pinctrl-names = "default";
>  	};
> +
> +* Example for apq8096:
> +
> +	pcie@00608000{

Drop leading 0s.

> +		compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
> +		power-domains = <&gcc PCIE1_GDSC>;
> +		bus-range = <0x00 0xff>;
> +		num-lanes = <1>;
> +
> +		status  = "disabled";

No point to have status in the example.

> +
> +		reg = <0x00608000 0x2000>,
> +		      <0x0d000000 0xf1d>,
> +		      <0x0d000f20 0xa8>,
> +		      <0x0d100000 0x100000>;
> +
> +		reg-names = "parf", "dbi", "elbi", "config";
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
> +		vdda-1p8-supply = <&pm8994_l12>;
> +		vdda-supply = <&pm8994_l28>;
> +		linux,pci-domain = <1>;
> +
> +		clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +			<&gcc GCC_PCIE_1_AUX_CLK>,
> +			<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +			<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +			<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
> +
> +		clock-names =  "pipe",
> +				"aux",
> +				"cfg",
> +				"bus_master",
> +				"bus_slave";
> +	};
