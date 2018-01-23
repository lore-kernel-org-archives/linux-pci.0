Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37946 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeAWJqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 04:46:54 -0500
Received: by mail-wm0-f45.google.com with SMTP id 141so560918wme.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 01:46:53 -0800 (PST)
Subject: Re: [PATCH] PCI: qcom: add missing supplies required for msm8996
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        stanimir.varbanov@linaro.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20171208092053.4417-1-srinivas.kandagatla@linaro.org>
 <65e01829-198e-f549-174d-c8368c5ee193@mm-sol.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <92e2808b-4b2d-8591-9ed7-6600d7a3357b@linaro.org>
Date: Tue, 23 Jan 2018 09:46:51 +0000
MIME-Version: 1.0
In-Reply-To: <65e01829-198e-f549-174d-c8368c5ee193@mm-sol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 23/01/18 09:23, Stanimir Varbanov wrote:
> Hey Srini,
> 
> As there are no comments I'd propose to change the endpoint supplies to
> more generic names.
> 
Sure, I will respin this with your suggestions, except the 3v3 and 1v5 
suffix due to the reasons below:
>> +- vdda-1p8-supply:
>> +	Usage: required for msm8996
>> +	Value type: <phandle>
>> +	Definition: A phandle to the 1.8v analog power supply
>> +
> 
> This should be dropped, because it is part of the phy.
Yep.

> 
>>   - vdda_phy-supply:
>>   	Usage: required for ipq/apq8064
>>   	Value type: <phandle>
>> @@ -189,6 +194,15 @@
>>   	Value type: <phandle>
>>   	Definition: A phandle to the analog power supply for IC which generates
>>   		    reference clock
>> +- vddpe-supply:
>> +	Usage: optional
>> +	Value type: <phandle>
>> +	Definition: A phandle to the PCIe endpoint power supply
> 
> vddpe_3v3-supply
Why do we need suffix here? AFAIU, It does not add any value, instead it 
would confuse the users.

These are power supplies for endpoint which could be of any voltage. In 
this case both endpoint supplies are 3v3, these could be 1.8 or 5v or 
12v in some other cases.

> 
>> +
>> +- vddpe1-supply:
>> +	Usage: optional
>> +	Value type: <phandle>
>> +	Definition: A phandle to the PCIe endpoint power supply 1
> 
> vddpe_1v5-supply
> 
>>   
>>   - phys:
>>   	Usage: required for apq8084
>> @@ -205,6 +219,8 @@
>>   	Value type: <prop-encoded-array>
>>   	Definition: List of phandle and GPIO specifier pairs. Should contain
>>   			- "perst-gpios"	PCIe endpoint reset signal line
>> +			- "pe_en-gpios"	PCIe endpoint enable signal line
>> +			- "pe_en1-gpios" PCIe endpoint enable1 signal line
> 
> We don't need those gpios, the regulator driver will manipulate these
> gpios when we call regulator_enable/disable.
yes, I will get rid of them.

> 
> 
