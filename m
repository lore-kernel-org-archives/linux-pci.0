Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54499 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031434AbeBNQOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Feb 2018 11:14:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id o189so3947327wme.4
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2018 08:14:37 -0800 (PST)
Subject: Re: [PATCH v2] PCI: qcom: add missing supplies required for msm8996
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        stanimir.varbanov@linaro.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20180214120616.23428-1-srinivas.kandagatla@linaro.org>
 <79820f4c-5166-852f-1bc5-8cef2ff81a00@mm-sol.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d2b0f220-2982-dc86-ae9e-edf88e0b8e7d@linaro.org>
Date: Wed, 14 Feb 2018 16:14:26 +0000
MIME-Version: 1.0
In-Reply-To: <79820f4c-5166-852f-1bc5-8cef2ff81a00@mm-sol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 14/02/18 16:00, Stanimir Varbanov wrote:
>>   .../devicetree/bindings/pci/qcom,pcie.txt          |  4 ++++
>>   drivers/pci/dwc/pcie-qcom.c                        | 24 ++++++++++++++++++++--
>>   2 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> index 3c9d321b3d3b..1fd703bd73e0 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -189,6 +189,10 @@
>>   	Value type: <phandle>
>>   	Definition: A phandle to the analog power supply for IC which generates
>>   		    reference clock
>> +- vddpe-3v3-supply:
> shouldn't it be vddpe_3v3-supply to be aligned with the other supplies?
> 
I noticed that, I had to do it intentionally
As dt properties should follow - instead of _


>> +	Usage: optional
>> +	Value type: <phandle>
>> +	Definition: A phandle to the PCIe endpoint power supply
>>   
>>   - phys:
>>   	Usage: required for apq8084
>> diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
>> index 3e89909f8cb9..519a2ae416eb 100644
>> --- a/drivers/pci/dwc/pcie-qcom.c
>> +++ b/drivers/pci/dwc/pcie-qcom.c
>> @@ -101,13 +101,14 @@ struct qcom_pcie_resources_1_0_0 {
>>   	struct reset_control *core;
>>   	struct regulator *vdda;
>>   };
>> -
> please keep above blank line.
Will fix it.
> 
>> +#define QCOM_PCIE_2_3_2_MAX_SUPPLY	2
>>   struct qcom_pcie_resources_2_3_2 {
>>   	struct clk *aux_clk;
>>   	struct clk *master_clk;
>>   	struct clk *slave_clk;
>>   	struct clk *cfg_clk;
