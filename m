Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35874 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935272AbcIPPeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2016 11:34:07 -0400
Received: by mail-wm0-f52.google.com with SMTP id b187so43330498wme.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2016 08:34:06 -0700 (PDT)
Subject: Re: [PATCH] pcie: qcom: add support to msm8996 PCIE controller
To: Rob Herring <robh@kernel.org>
References: <1473246412-24616-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160916141708.GA21504@rob-hp-laptop>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <73a5a49c-3adb-ffca-52b0-1de22aabe088@linaro.org>
Date: Fri, 16 Sep 2016 16:34:03 +0100
MIME-Version: 1.0
In-Reply-To: <20160916141708.GA21504@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the Review,

On 16/09/16 15:17, Rob Herring wrote:
> On Wed, Sep 07, 2016 at 12:06:52PM +0100, Srinivas Kandagatla wrote:
>

...

>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> index 4059a6f..1ddfcb4 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -92,6 +92,18 @@
...
>>  	Definition: A phandle and power domain specifier pair to the
>>  		    power domain which is responsible for collapsing
>> @@ -137,6 +156,11 @@
>>  	Definition: A phandle to the analog power supply for IC which generates
>>  		    reference clock
>>
>> +- vdda_1p8-supply:
>
> Don't use '_' in property names.

Will fix it and example to match these properties in next version.

>
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <phandle>
>> +	Definition: A phandle to the analog power supply for PCIE_1P8
>> +
>>  - phys:
>>  	Usage: required for apq8084
>>  	Value type: <phandle>
>> @@ -231,3 +255,65 @@
>>  		pinctrl-0 = <&pcie0_pins_default>;
>>  		pinctrl-names = "default";
>>  	};
>> +
>> +* Example for apq8096:
>> +	pcie1: qcom,pcie@00608000 {
>
> pcie@...
Yep, will fix it in next version.
>
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

