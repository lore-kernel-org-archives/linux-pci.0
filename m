Return-Path: <SRS0=UpNH=DK=linaro.org=srinivas.kandagatla@kernel.org>
Return-Path: <SRS0=UpNH=DK=linaro.org=srinivas.kandagatla@kernel.org>
Subject: Re: [PATCH] PCI: qcom: add missing supplies required for msm8996
To: Stanimir Varbanov <svarbanov@mm-sol.com>, stanimir.varbanov@linaro.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
References: <20171208092053.4417-1-srinivas.kandagatla@linaro.org>
 <4fd5f3e7-73f6-ad63-c961-47f1f0fac149@mm-sol.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <978c8df1-9077-e36d-90d6-896e29a0fc1d@linaro.org>
Date: Thu, 14 Dec 2017 11:19:39 +0000
MIME-Version: 1.0
In-Reply-To: <4fd5f3e7-73f6-ad63-c961-47f1f0fac149@mm-sol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 14/12/17 10:06, Stanimir Varbanov wrote:
> Hi Srini,
> 
> On 12/08/2017 11:20 AM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds supplies that are required for msm8996. Two of them vdda
>> and vdda-1p8 are analog supplies that go in to controller, and the rest
> 
> According to the msm8996 device specification there are two pins related
> to the PCIe power: VDD_PCIE_CORE (power for PCIe core circuitry) and
> VDD_PCIE_1P8 (power for PCIe I/O circuitry). Thus I think it is clear
> that VDD_PCIE_CORE is vdda and VDD_PCIE_1P8 should be part of PCIe phy
> driver DT binding (and this is the case currently [1]). So I don't think
> we need vdda-1p8 regulator DT binding for that in pcie-qcom.
Sure I will remove it.
> 
>> of the two vddpe's are supplies to PCIe endpoints.
> 
> For this part I'm still not sure. On first sight it looks that these
> vdd's should be part of endpoint drivers, on the other hand we have
> mPCIe connector (on db820c) which has two power rails 3p3v and 1p5v
> which should be controlled/enabled as well.
> 
Yes, these would be populated in DT as part of vddpe supplies for that lane.

> So I'd like to hear more opinions on that, i.e. how this is solved by
> the other PCIe bridge drivers.
I would be keen on knowing more options to solve this neatly too!!

This is only problem with DT and PCIE device discovery to start with!!

We are in catch 22 situation, where in we can not enumerate device 
without it actually powering up.

All the other controllers like SDIO, MMC use something similar to enable 
these regulators. SDIO actually uses pwrseq to do this.
There was attempt to generalize pwrseq to other subsystems, not sure 
where it landed.

As of today, the only way to power up endpoint in sync with reset is via 
controller driver, all other ways we would end up doing reset out of 
sync with power which are error prone.

> 

>>   - phys:
>>   	Usage: required for apq8084
>> @@ -205,6 +219,8 @@
>>   	Value type: <prop-encoded-array>
>>   	Definition: List of phandle and GPIO specifier pairs. Should contain
>>   			- "perst-gpios"	PCIe endpoint reset signal line
>> +			- "pe_en-gpios"	PCIe endpoint enable signal line
>> +			- "pe_en1-gpios" PCIe endpoint enable1 signal line
> 
> those two shouldn't be here, instead they should be part of regulator DT
> node, so please drop them.

Yes, I can drop them for now!

> 
>>   			- "wake-gpios"	PCIe endpoint wake signal line
>>   
>>   * Example for ipq/apq8064
>> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
>> index 952a4fc4bf3c..01488f90da31 100644
>> --- a/drivers/pci/dwc/pcie-qcom.c
>> +++ b/drivers/pci/dwc/pcie-qcom.c
>> @@ -109,13 +109,15 @@ struct qcom_pcie_resources_1_0_0 {
>>   	struct reset_control *core;
>>   	struct regulator *vdda;
>>   };
>> -
>> +#define QCOM_PCIE_MAX_SUPPLY	4
>>   struct qcom_pcie_resources_2_3_2 {
>>   	struct clk *aux_clk;
>>   	struct clk *master_clk;
>>   	struct clk *slave_clk;
>>   	struct clk *cfg_clk;
>>   	struct clk *pipe_clk;
>> +	int num_supplies;
>> +	struct regulator_bulk_data supplies[QCOM_PCIE_MAX_SUPPLY];
>>   };
>>   
>>   struct qcom_pcie_resources_2_4_0 {
>> @@ -529,6 +531,17 @@ static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
>>   	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
>>   	struct dw_pcie *pci = pcie->pci;
>>   	struct device *dev = pci->dev;
>> +	int ret;
>> +
>> +	res->supplies[0].supply = "vdda";
>> +	res->supplies[1].supply = "vdda-1p8";
>> +	res->supplies[2].supply = "vddpe";
>> +	res->supplies[3].supply = "vddpe1";
>> +	res->num_supplies = QCOM_PCIE_MAX_SUPPLY;
>> +	ret = devm_regulator_bulk_get(dev, QCOM_PCIE_MAX_SUPPLY,
>> +				      res->supplies);
> 
> If we decide to go on this direction we need to replace this with
> devm_regulator_bulk_get_optional (yes I know there is no such regulator
> API yet) because they are optional in the DT binding.

I think the api name is misleading here, actually 
devm_regulator_bulk_get() will return dummy regulators if the regulators 
are not present, so code as it is Okay. On the other hand *_optonal api 
would fail.


thanks,
srini
> 
> <snip>
> 
