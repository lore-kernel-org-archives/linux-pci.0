Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55745 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032738AbeBNQio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Feb 2018 11:38:44 -0500
Received: by mail-wm0-f66.google.com with SMTP id a84so12563614wmi.5
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2018 08:38:43 -0800 (PST)
Subject: Re: [PATCH v2] PCI: qcom: add missing supplies required for msm8996
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20180214120616.23428-1-srinivas.kandagatla@linaro.org>
 <79820f4c-5166-852f-1bc5-8cef2ff81a00@mm-sol.com>
 <d2b0f220-2982-dc86-ae9e-edf88e0b8e7d@linaro.org>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <fe5639be-e520-b7f2-233e-c091440c77dc@linaro.org>
Date: Wed, 14 Feb 2018 18:38:39 +0200
MIME-Version: 1.0
In-Reply-To: <d2b0f220-2982-dc86-ae9e-edf88e0b8e7d@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 02/14/2018 06:14 PM, Srinivas Kandagatla wrote:
> 
> 
> On 14/02/18 16:00, Stanimir Varbanov wrote:
>>>   .../devicetree/bindings/pci/qcom,pcie.txt          |  4 ++++
>>>   drivers/pci/dwc/pcie-qcom.c                        | 24
>>> ++++++++++++++++++++--
>>>   2 files changed, 26 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> index 3c9d321b3d3b..1fd703bd73e0 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> @@ -189,6 +189,10 @@
>>>       Value type: <phandle>
>>>       Definition: A phandle to the analog power supply for IC which
>>> generates
>>>               reference clock
>>> +- vddpe-3v3-supply:
>> shouldn't it be vddpe_3v3-supply to be aligned with the other supplies?
>>
> I noticed that, I had to do it intentionally
> As dt properties should follow - instead of _

I don't agree with that. If the supply name is more than one word it
should be separated by underscore ('git grep \-supply' in dts files).

-- 
regards,
Stan
