Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35099 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754360AbcKBJCY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2016 05:02:24 -0400
Received: by mail-wm0-f44.google.com with SMTP id a197so125937228wmd.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Nov 2016 02:02:24 -0700 (PDT)
Subject: Re: [PATCH v2] pcie: qcom: add support to msm8996 PCIE controller
To: Stephen Boyd <sboyd@codeaurora.org>
References: <1478004267-17259-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20161101184903.GV16026@codeaurora.org>
Cc: svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dc606884-8390-fa76-45e6-f2048e6f5c6b@linaro.org>
Date: Wed, 2 Nov 2016 09:02:22 +0000
MIME-Version: 1.0
In-Reply-To: <20161101184903.GV16026@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Stephen for Review comments.

On 01/11/16 18:49, Stephen Boyd wrote:
> On 11/01, Srinivas Kandagatla wrote:
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> index 4059a6f..cec9bbc 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -92,6 +93,19 @@
>>  			- "aux"		Auxiliary (AUX) clock
>>  			- "bus_master"	Master AXI clock
>>  			- "bus_slave"	Slave AXI clock
>> +
>> +- clock-names:
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <stringlist>
>> +	Definition: Should contain the following entries
>> +			- "aux"		Auxiliary (AUX) clock
>> +			- "bus_master"	Master AXI clock
>> +			- "bus_slave"	Slave AXI clock
>> +			- "pipe"	Pipe Clock driving internal logic.
>> +			- "cfg"		Configuration clk.
>
> These two get the full stop but nothing else?
Yep.. Will fix it in next version.
>
>> +			- "snoc_axi"	SNOC AXI clk
>> +			- "cnoc_ahb"	CNOC AHB clk
>> +			- "smmu_axi"	SMMU AXI bus clk
>
> These last three don't really go to the controller, so they
> shouldn't be here. Perhaps we should make a wrapper node that
> represents the aggre0 NOC/SMMU block that sits in front of the
> PCIe controllers on this SoC? Then that node could be the parent
> of this PCIe controller and populate it once it turns on these
> few clocks.
>
> The lack of a proper bus abstraction in the kernel is coming
> through here.

Yes, that is the issue, I will give it a try with wrapper node, that 
should take care of gdsc power domain issue too.

>
>>  - resets:
>>  	Usage: required
>>  	Value type: <prop-encoded-array>
>> @@ -137,6 +151,11 @@
>>  	Definition: A phandle to the analog power supply for IC which generates
>>  		    reference clock
>>
>> +- vdda_1p8-supply:
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <phandle>
>> +	Definition: A phandle to the analog power supply for PCIE_1P8
>> +
>
> This is very odd. Shouldn't the 1.8V analog supply go to the phy
> and not the controller? Probably vdda_supply should be removed
> from here as well as it looks to be a phy only thing.
>
Possibly, I will let phy take care of this.

>>  - phys:
>>  	Usage: required for apq8084
>>  	Value type: <phandle>
>> @@ -231,3 +250,64 @@
>>  		pinctrl-0 = <&pcie0_pins_default>;
>>  		pinctrl-names = "default";
>>  	};
>> +
>> +* Example for apq8096:
>> +
>> +	pcie@00608000 {
>
> Drop leading zeroes please
>
Will fix it in next version.
>> +		compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
>> +		power-domains = <&gcc PCIE1_GDSC>;
>> +		bus-range = <0x00 0xff>;
>> +		num-lanes = <1>;
>> +
>> +		status  = "disabled";
>> +
>> +		reg = <0x00608000 0x2000>,
>> +		      <0x0d000000 0xf1d>,
>> +		      <0x0d000f20 0xa8>,
>> +		      <0x0d100000 0x100000>;
>> +
>> +		reg-names = "parf", "dbi", "elbi","config";
>
> Space between elbi and config?
>
Yep.
>> +
>> +		phys = <&pcie_phy 1>;
>> +		phy-names = "pciephy";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
>> +			<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
>> +
>> +		interrupts = <GIC_SPI 413 IRQ_TYPE_NONE>;
>> +		interrupt-names = "msi";
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0x7>;
>> +		interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +				<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +				<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +				<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +		pinctrl-names = "default", "sleep";
>> +		pinctrl-0 = <&pcie1_clkreq_default &pcie1_perst_default &pcie1_wake_default>;
>> +		pinctrl-1 = <&pcie1_clkreq_sleep &pcie1_perst_default &pcie1_wake_sleep>;
>> +
>> +		vdda-1p8-supply = <&pm8994_l12>;
>> +		vdda-supply = <&pm8994_l28>;
>> +		linux,pci-domain = <1>;
>> +
>> +		clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
>> +			<&gcc GCC_PCIE_1_AUX_CLK>,
>> +			<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
>> +			<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
>> +			<&gcc GCC_PCIE_1_SLV_AXI_CLK>,
>> +			<&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
>> +			<&gcc GCC_AGGRE0_CNOC_AHB_CLK>,
>> +			<&gcc GCC_SMMU_AGGRE0_AXI_CLK>;
>> +
>> +		clock-names =  "pipe",
>> +				"aux",
>> +				"cfg",
>> +				"bus_master",
>> +				"bus_slave",
>> +				"snoc_axi",
>> +				"cnoc_ahb",
>> +				"smmu_axi";
>> +	};
>> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
>> index 3593640..47e7817 100644
>> --- a/drivers/pci/host/pcie-qcom.c
>> +++ b/drivers/pci/host/pcie-qcom.c
>> @@ -429,6 +636,22 @@ static int qcom_pcie_link_up(struct pcie_port *pp)
>>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>>  }
>>
>> +
>
> Noise?
>
Yep, will fix it in next version.

>>  static void qcom_pcie_host_init(struct pcie_port *pp)
>>  {
>>  	struct qcom_pcie *pcie = to_qcom_pcie(pp);
>> @@ -439,11 +662,13 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
>>  	ret = pcie->ops->init(pcie);
>>  	if (ret)
>>  		goto err_deinit;
>> -
>
> Leave this line there?

Yep.
>
>>  	ret = phy_power_on(pcie->phy);
>>  	if (ret)
>>  		goto err_deinit;
>>
>> +	if (pcie->ops->post_init)
>> +		pcie->ops->post_init(pcie);
>> +
>>  	dw_pcie_setup_rc(pp);
>>
>>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>> @@ -487,12 +712,22 @@ static const struct qcom_pcie_ops ops_v0 = {
>>  	.get_resources = qcom_pcie_get_resources_v0,
>>  	.init = qcom_pcie_init_v0,
>>  	.deinit = qcom_pcie_deinit_v0,
>> +	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
>>  };
>>
>>  static const struct qcom_pcie_ops ops_v1 = {
>>  	.get_resources = qcom_pcie_get_resources_v1,
>>  	.init = qcom_pcie_init_v1,
>>  	.deinit = qcom_pcie_deinit_v1,
>> +	.ltssm_enable = qcom_pcie_v0_v1_ltssm_enable,
>> +};
>> +
>> +static const struct qcom_pcie_ops ops_msm8996 = {
>
> Why not just ops_v2? The hw version is v2 now on 8996.

Ok, Will rename it to v2.
>
>> +	.get_resources = qcom_pcie_get_resources_msm8996,
>> +	.init = qcom_pcie_init_msm8996,
>> +	.post_init = qcom_pcie_post_init_msm8996,
>> +	.deinit = qcom_pcie_deinit_msm8996,
>> +	.ltssm_enable = qcom_pcie_msm8996_ltssm_enable,
>>  };
>>
>

Thanks,
srini
