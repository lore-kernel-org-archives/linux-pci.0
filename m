Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40799 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeAWKdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 05:33:16 -0500
Received: by mail-wm0-f46.google.com with SMTP id v123so834612wmd.5
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 02:33:15 -0800 (PST)
Subject: Re: [PATCH] PCI: qcom: add missing supplies required for msm8996
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20171208092053.4417-1-srinivas.kandagatla@linaro.org>
 <65e01829-198e-f549-174d-c8368c5ee193@mm-sol.com>
 <92e2808b-4b2d-8591-9ed7-6600d7a3357b@linaro.org>
 <1a3cc92e-545e-a703-7130-6a9c58854e03@mm-sol.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5f43164a-4d84-12be-7f69-f7bbaaf1d64c@linaro.org>
Date: Tue, 23 Jan 2018 10:33:13 +0000
MIME-Version: 1.0
In-Reply-To: <1a3cc92e-545e-a703-7130-6a9c58854e03@mm-sol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 23/01/18 10:14, Stanimir Varbanov wrote:
> Hi,
> 
> On 01/23/2018 11:46 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 23/01/18 09:23, Stanimir Varbanov wrote:
>>> Hey Srini,
>>>
>>> As there are no comments I'd propose to change the endpoint supplies to
>>> more generic names.
>>>
>> Sure, I will respin this with your suggestions, except the 3v3 and 1v5
>> suffix due to the reasons below:
>>>> +- vdda-1p8-supply:
>>>> +    Usage: required for msm8996
>>>> +    Value type: <phandle>
>>>> +    Definition: A phandle to the 1.8v analog power supply
>>>> +
>>>
>>> This should be dropped, because it is part of the phy.
>> Yep.
>>
>>>
>>>>    - vdda_phy-supply:
>>>>        Usage: required for ipq/apq8064
>>>>        Value type: <phandle>
>>>> @@ -189,6 +194,15 @@
>>>>        Value type: <phandle>
>>>>        Definition: A phandle to the analog power supply for IC which
>>>> generates
>>>>                reference clock
>>>> +- vddpe-supply:
>>>> +    Usage: optional
>>>> +    Value type: <phandle>
>>>> +    Definition: A phandle to the PCIe endpoint power supply
>>>
>>> vddpe_3v3-supply
>> Why do we need suffix here? AFAIU, It does not add any value, instead it
>> would confuse the users.
> 
> vddpe and vddpe1 is already confusing as well.

I partly agree with you.

How would you represent if there are two power 3v3 supplies for the 
endpoint?

> 
> Lets imagine that powering up the endpointX needs some specific sequence
> between 3v3 and 1v5 and endpointY (which could be connected on the same
> PCIe lane) has different power sequence, how we would handle that in the
> qcom pcie host driver?

power sequencing is all together a different issue, that is not 
addressed in this patch. Am hoping that this will be fixed as part of 
making pwrseq interface more generic. Not sure where it endedup now!!

--srini


> 
>>
>> These are power supplies for endpoint which could be of any voltage. In
> 
> I don't think that could be any values see PCIe mini card
> electromechanical specification. There on the connector are provided 3v3
> and 1v5.
> 
>> this case both endpoint supplies are 3v3, these could be 1.8 or 5v or
>> 12v in some other cases.
> 
> If we see hw designs with 5v and 12v we could extend the binding and the
> driver with support for them. I want to be exact in the names and
> voltages in the driver and bindings.

> 
