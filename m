Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48207 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032408AbdAEGEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2017 01:04:50 -0500
Subject: Re: [PATCH V2 1/5] Documetation: samsung-phy: add the exynos-pcie-phy
 binding
To: Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, cpgs@samsung.com
From: "pankaj.dubey" <pankaj.dubey@samsung.com>
Message-id: <d6a81e81-3ac2-5d83-15f3-9de07fb2d421@samsung.com>
Date: Thu, 05 Jan 2017 11:36:32 +0530
MIME-version: 1.0
In-reply-to: <4110cfa2-bbe8-337e-5f2c-13d82cd23713@samsung.com>
Content-type: text/plain; charset=windows-1252
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p1d3d840e4ade396a60ce690b09d486990@epcas1p1.samsung.com>
 <20170104123435.30740-2-jh80.chung@samsung.com>
 <4110cfa2-bbe8-337e-5f2c-13d82cd23713@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 05 January 2017 09:46 AM, Alim Akhtar wrote:
> Hi Jaehoon,
> 
> On 01/04/2017 06:04 PM, Jaehoon Chung wrote:
>> Adds the exynos-pcie-phy binding for Exynos PCIe PHY.
>> This is for using generic PHY framework.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog on V2:
>> - Remove the child node.
>> - Add 2nd address to the parent reg prop.
>>
>>  Documentation/devicetree/bindings/phy/samsung-phy.txt | 17
>> +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt
>> b/Documentation/devicetree/bindings/phy/samsung-phy.txt
>> index 9872ba8..ab80bfe 100644
>> --- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
>> @@ -191,3 +191,20 @@ Example:
>>          usbdrdphy0 = &usb3_phy0;
>>          usbdrdphy1 = &usb3_phy1;
>>      };
>> +
>> +Samsung Exynos SoC series PCIe PHY controller
>> +--------------------------------------------------
>> +Required properties:
>> +- compatible : Should be set to "samsung,exynos5440-pcie-phy"
>> +- #phy-cells : Must be zero
>> +- reg : a register used by phy driver.
>> +    - First is for phy register, second is for block register.
>> +- reg-names : Must be set to "phy" and "block".
>> +
> In general PHY uses a "reference clock" to work, if that is true for
> 5440 also, will you consider adding an (may be) optional clock
> properties as well?
> 

Yes, right, second clock, referred as "bus_clk" in pcie node should
actually refer to "phy" clock. From Exynos5433 DT patch also you are
mapping it to CLK_PCLK_PCIE_PHY which is a phy clk. This is same in
Exynos7 as well. So better we have clocks property defined in pcie-phy
binding. What do you say?

>From Exynos5440 UM, PCIe-Phy needs 250 MHz, clock and second clock used
as "bus_clk" is providing 250 MHz, so this can be moved in phy driver.


Thanks,
Pankaj Dubey
