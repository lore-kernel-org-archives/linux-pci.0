Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35529 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753320AbcKPQ3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2016 11:29:45 -0500
Received: by mail-wm0-f47.google.com with SMTP id a197so250239409wmd.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 08:29:44 -0800 (PST)
Subject: Re: [PATCH v5] PCI: qcom: add support to msm8996 PCIE controller
To: Rob Herring <robh@kernel.org>
References: <1479219837-7868-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20161116150858.343voujjg4p2zdhn@rob-hp-laptop>
Cc: svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <50449970-74f5-1d73-4c78-323741b8a705@linaro.org>
Date: Wed, 16 Nov 2016 16:29:41 +0000
MIME-Version: 1.0
In-Reply-To: <20161116150858.343voujjg4p2zdhn@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/11/16 15:08, Rob Herring wrote:
> On Tue, Nov 15, 2016 at 02:23:57PM +0000, Srinivas Kandagatla wrote:
>> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
>
> s/pcie/PCIe/
Will fix two instances this and spin a next version.
>
>> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
>> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
>>
>> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
>
> s/pcie/PCIe/
>
>> pipe clocks are only setup after the phy is powered on.
>> It also adds ltssm_enable callback as it is very much different to other
>> supported SOCs in the driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>> ---
>>
>>  Changes since v4:
>>  	- removed duplicate define spotted by Stan.
>> 	- renamed halt register to remove msm8996 suggested by Stan.
>> 	- dropped simple-pm-bus and runtime pm patches as these can
>> 	 potentially go into pm domain provider.
>>
>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  67 +++++++-
>>  drivers/pci/host/pcie-qcom.c                       | 175 ++++++++++++++++++++-
>>  2 files changed, 236 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> index 4059a6f..141d8c3 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -7,6 +7,7 @@
>>  			- "qcom,pcie-ipq8064" for ipq8064
>>  			- "qcom,pcie-apq8064" for apq8064
>>  			- "qcom,pcie-apq8084" for apq8084
>> +			- "qcom,pcie-msm8996" for msm8996 or apq8096
>>
>>  - reg:
>>  	Usage: required
>> @@ -92,6 +93,17 @@
>>  			- "aux"		Auxiliary (AUX) clock
>>  			- "bus_master"	Master AXI clock
>>  			- "bus_slave"	Slave AXI clock
>> +
>> +- clock-names:
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <stringlist>
>> +	Definition: Should contain the following entries
>> +			- "pipe"	Pipe Clock driving internal logic.
>> +			- "aux"		Auxiliary (AUX) clock.
>> +			- "cfg"		Configuration clk.
>> +			- "bus_master"	Master AXI clock.
>> +			- "bus_slave"	Slave AXI clock.
>> +
>>  - resets:
>>  	Usage: required
>>  	Value type: <prop-encoded-array>
>> @@ -115,7 +127,7 @@
>>  			- "core" Core reset
>>
>>  - power-domains:
>> -	Usage: required for apq8084
>> +	Usage: required for apq8084 and msm8996/apq8096
>>  	Value type: <prop-encoded-array>
>>  	Definition: A phandle and power domain specifier pair to the
>>  		    power domain which is responsible for collapsing
>> @@ -231,3 +243,56 @@
>>  		pinctrl-0 = <&pcie0_pins_default>;
>>  		pinctrl-names = "default";
>>  	};
>> +
>> +* Example for apq8096:
>
> Do you really need an example for every chip?

Yes, for consistency reasons, as there are two examples already in this 
document. Also having an example does not harm anyway.

thanks,
srini
>
>> +
>> +	pcie@608000{
>> +		compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
>> +		power-domains = <&gcc PCIE1_GDSC>;
>> +		bus-range = <0x00 0xff>;
>> +		num-lanes = <1>;
>> +
>> +		reg = <0x00608000 0x2000>,
>> +		      <0x0d000000 0xf1d>,
>> +		      <0x0d000f20 0xa8>,
>> +		      <0x0d100000 0x100000>;
>> +
>> +		reg-names = "parf", "dbi", "elbi", "config";
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
>> +			<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
>> +
>> +		clock-names =  "pipe",
>> +				"aux",
>> +				"cfg",
>> +				"bus_master",
>> +				"bus_slave";
>> +	};
