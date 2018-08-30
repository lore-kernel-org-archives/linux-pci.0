Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:16601 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH3LiT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2018 07:38:19 -0400
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To: Rob Herring <robh@kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <devicetree@vger.kernel.org>
References: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
 <8c48964151d24758298ba935da336c0829e2b287.camel@baylibre.com>
 <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com>
 <20180829004122.GA25928@bogus>
From: Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <84d5399c-67d4-f8a4-3613-00d91f21292f@amlogic.com>
Date: Thu, 30 Aug 2018 15:37:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180829004122.GA25928@bogus>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2018/8/29 8:41, Rob Herring wrote:
> On Mon, Aug 27, 2018 at 04:55:20PM +0800, Hanjie Lin wrote:
>>
>>
>> On 2018/8/24 16:22, Jerome Brunet wrote:
>>> On Fri, 2018-08-24 at 15:36 +0800, Hanjie Lin wrote:
>>>> From: Yue Wang <yue.wang@amlogic.com>
>>>>
>>>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
>>>> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
>>>> controller.
>>>>
>>>> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
>>>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>>>> ---
>>>>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 63 ++++++++++++++++++++++
>>>>  1 file changed, 63 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>>> new file mode 100644
>>>> index 0000000..8a831d1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>>> @@ -0,0 +1,63 @@
>>>> +Amlogic Meson AXG DWC PCIE SoC controller
>>>> +
>>>> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
>>>> +It shares common functions with the PCIe DesignWare core driver and
>>>> +inherits common properties defined in
>>>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
>>>> +
>>>> +Additional properties are described here:
>>>> +
>>>> +Required properties:
>>>> +- compatible:
>>>> +	should contain "amlogic,axg-pcie" to identify the core.
>>>> +- reg:
>>>> +	Should contain the configuration address space.
>>>> +- reg-names: Must be
>>>> +	- "elbi"	External local bus interface registers
>>>> +	- "cfg"		Meson specific registers
>>>> +	- "config"	PCIe configuration space
>>>> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>> +- clock-names: Must include the following entries:
>>>> +	- "pclk"       PCIe GEN 100M PLL clock
>>>> +	- "port"       PCIe_x(A or B) RC clock gate
>>>> +	- "general"    PCIe Phy clock
>>>> +	- "mipi"       PCIe_x(A or B) 100M ref clock gate
>>>> +- resets: phandle to the reset lines.
>>>> +- reset-names: must contain "phy" and "peripheral"
>>>> +       - "port" Port A or B reset
>>>> +       - "apb" APB reset
>>>
>>> The above description is not coherent (phy <=> port)
>>>
>>
>> Yes, this should be port and apb here.
>> We'll integrate phy driver into ctrl driver, and move phy reset to here also.
> 
> Why? That's the wrong thing to do if they are separate h/w blocks. You 
> can do whatever you like in the drivers, but the DT should reflect the 
> h/w.
> 
> Rob
> 
> .
> 

We have the dedicated phy driver which only process reset job,
and we consider that it's too overkill to do just these things .
So we will integrate phy reset job into the controller driver int the next version.  

thanks. 
