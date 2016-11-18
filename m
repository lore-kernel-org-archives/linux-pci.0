Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbcKROgO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Nov 2016 09:36:14 -0500
MIME-Version: 1.0
In-Reply-To: <50449970-74f5-1d73-4c78-323741b8a705@linaro.org>
References: <1479219837-7868-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20161116150858.343voujjg4p2zdhn@rob-hp-laptop> <50449970-74f5-1d73-4c78-323741b8a705@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 18 Nov 2016 08:35:49 -0600
Message-ID: <CAL_JsqJ+_mrwJkwDdbHirXcWiGXEAorE_46_gayTMYyQ9vK0FA@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: qcom: add support to msm8996 PCIE controller
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 16, 2016 at 10:29 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 16/11/16 15:08, Rob Herring wrote:
>>
>> On Tue, Nov 15, 2016 at 02:23:57PM +0000, Srinivas Kandagatla wrote:
>>>
>>> This patch adds support to msm8996/apq8096 pcie, MSM8996 supports
>>
>>
>> s/pcie/PCIe/
>
> Will fix two instances this and spin a next version.
>
>>
>>> Gen 1/2, One lane, 3 pcie root-complex with support to MSI and
>>> legacy interrupts and it conforms to PCI Express Base 2.1 specification.
>>>
>>> This patch adds post_init callback to qcom_pcie_ops, as this is pcie
>>
>>
>> s/pcie/PCIe/
>>
>>> pipe clocks are only setup after the phy is powered on.
>>> It also adds ltssm_enable callback as it is very much different to other
>>> supported SOCs in the driver.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>>> ---
>>>
>>>  Changes since v4:
>>>         - removed duplicate define spotted by Stan.
>>>         - renamed halt register to remove msm8996 suggested by Stan.
>>>         - dropped simple-pm-bus and runtime pm patches as these can
>>>          potentially go into pm domain provider.
>>>
>>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  67 +++++++-
>>>  drivers/pci/host/pcie-qcom.c                       | 175
>>> ++++++++++++++++++++-
>>>  2 files changed, 236 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> index 4059a6f..141d8c3 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>>> @@ -7,6 +7,7 @@
>>>                         - "qcom,pcie-ipq8064" for ipq8064
>>>                         - "qcom,pcie-apq8064" for apq8064
>>>                         - "qcom,pcie-apq8084" for apq8084
>>> +                       - "qcom,pcie-msm8996" for msm8996 or apq8096
>>>
>>>  - reg:
>>>         Usage: required
>>> @@ -92,6 +93,17 @@
>>>                         - "aux"         Auxiliary (AUX) clock
>>>                         - "bus_master"  Master AXI clock
>>>                         - "bus_slave"   Slave AXI clock
>>> +
>>> +- clock-names:
>>> +       Usage: required for msm8996/apq8096
>>> +       Value type: <stringlist>
>>> +       Definition: Should contain the following entries
>>> +                       - "pipe"        Pipe Clock driving internal
>>> logic.
>>> +                       - "aux"         Auxiliary (AUX) clock.
>>> +                       - "cfg"         Configuration clk.
>>> +                       - "bus_master"  Master AXI clock.
>>> +                       - "bus_slave"   Slave AXI clock.
>>> +
>>>  - resets:
>>>         Usage: required
>>>         Value type: <prop-encoded-array>
>>> @@ -115,7 +127,7 @@
>>>                         - "core" Core reset
>>>
>>>  - power-domains:
>>> -       Usage: required for apq8084
>>> +       Usage: required for apq8084 and msm8996/apq8096
>>>         Value type: <prop-encoded-array>
>>>         Definition: A phandle and power domain specifier pair to the
>>>                     power domain which is responsible for collapsing
>>> @@ -231,3 +243,56 @@
>>>                 pinctrl-0 = <&pcie0_pins_default>;
>>>                 pinctrl-names = "default";
>>>         };
>>> +
>>> +* Example for apq8096:
>>
>>
>> Do you really need an example for every chip?
>
>
> Yes, for consistency reasons, as there are two examples already in this
> document. Also having an example does not harm anyway.

You have the dts itself, and we don't need 2 copies of the same thing.
If anything, drop one of the 2 examples already there.

Rob
