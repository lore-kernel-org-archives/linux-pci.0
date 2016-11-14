Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbcKNLOs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2016 06:14:48 -0500
MIME-Version: 1.0
In-Reply-To: <2eae2624-fd5e-df55-5261-a49b3fe56a18@linaro.org>
References: <1478264387-17914-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1478264387-17914-3-git-send-email-srinivas.kandagatla@linaro.org>
 <CAFp+6iF7rspwXvANoz_3XgC33-CwSYzPvdpwsGK8UAfp064Jxg@mail.gmail.com> <2eae2624-fd5e-df55-5261-a49b3fe56a18@linaro.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Mon, 14 Nov 2016 16:43:53 +0530
Message-ID: <CAFp+6iHkhqHUcLRHZNPoJXqvm2RjzkenRZq9JVGj1SS7cSYA8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: qcom: add support to msm8996 PCIE controller
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: svarbanov@mm-sol.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,


On Mon, Nov 14, 2016 at 4:02 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 09/11/16 10:37, Vivek Gautam wrote:
>>
>> Hi,
>>
>> On Fri, Nov 4, 2016 at 6:29 PM, Srinivas Kandagatla
>> <srinivas.kandagatla@linaro.org> wrote:
>>>
>>> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
>>> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
>>> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
>>>
>>> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
>>> pipe clocks are only setup after the phy is powered on.
>>> It also adds ltssm_enable callback as it is very much different to other
>>> supported SOCs in the driver.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>
>>
>> Few minor nits.
>>
>>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  68 +++++++-
>>>  drivers/pci/host/pcie-qcom.c                       | 177
>>> ++++++++++++++++++++-
>>>  2 files changed, 239 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> index 4059a6f..4a0538d 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> @@ -7,6 +7,7 @@
>>>                         - "qcom,pcie-ipq8064" for ipq8064
>>>                         - "qcom,pcie-apq8064" for apq8064
>>>                         - "qcom,pcie-apq8084" for apq8084
>>> +                       - "qcom,pcie-msm8996" for msm8996 or apq8096
>>
>>
>> Since this works for both apq8096 and msm8996, compatible -
>> "qcom,pcie-apq8096" for uniformity ?
>
>
> AFAIK, compatible is selected based on SOC on which this IP is integrated
> first, So msm8996 seems to be correct, in that way.
>
> Also if we look at clk controller compatible strings, you would see them as
> *msm8996* rather than *8096*.

ok, cool. I didn't notice that. This looks good then.


Thanks
Vivek

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
