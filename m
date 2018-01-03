Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4077 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeACQY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jan 2018 11:24:27 -0500
Subject: Re: [PATCH V4 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for
 Tegra PCIe
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <cyndis@kapsi.fi>, <bhelgaas@google.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <rjw@rjwysocki.net>, <tglx@linutronix.de>, <vidyas@nvidia.com>,
        <kthota@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
 <1512723493-865-4-git-send-email-mmaddireddy@nvidia.com>
 <20171215173643.GA1050@red-moon> <20171220193011.GA31757@ulmo>
 <20171221104630.GB24280@red-moon>
 <20180103155149.GA8929@e107981-ln.cambridge.arm.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <25d10221-67c8-59c4-46d1-9bff239bd6bd@nvidia.com>
Date: Wed, 3 Jan 2018 21:54:03 +0530
MIME-Version: 1.0
In-Reply-To: <20180103155149.GA8929@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 03-Jan-18 9:21 PM, Lorenzo Pieralisi wrote:
> On Thu, Dec 21, 2017 at 10:46:30AM +0000, Lorenzo Pieralisi wrote:
>> On Wed, Dec 20, 2017 at 08:30:11PM +0100, Thierry Reding wrote:
>>> On Fri, Dec 15, 2017 at 05:36:43PM +0000, Lorenzo Pieralisi wrote:
>>>> On Fri, Dec 08, 2017 at 02:28:09PM +0530, Manikanta Maddireddy wrote:
>>>>> Primary, secondary and subordinate default bus numbers are 0 in Tegra and
>>>>> it is expecting SW to program these numbers in configration space.
>>>>>
>>>>> pci_scan_bridge_extend() function programs these numbers in configuration
>>>>> space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_BUS
>>>>> flag is set. Since secondary & subordinate default bus numbers are 0,
>>>>> PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.
>>>>>
>>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>>> ---
>>>>> V3:
>>>>> * new patch in V3
>>>>> V4:
>>>>> * no change in this patch
>>>>>
>>>>>  drivers/pci/host/pci-tegra.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>>>>> index a549c5899e26..0d91f1a3a6b4 100644
>>>>> --- a/drivers/pci/host/pci-tegra.c
>>>>> +++ b/drivers/pci/host/pci-tegra.c
>>>>> @@ -2604,7 +2604,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>>>>  
>>>>>  	tegra_pcie_enable_ports(pcie);
>>>>>  
>>>>> -	pci_add_flags(PCI_REASSIGN_ALL_BUS);
>>>>
>>>> This looks obviously OK to me but I need Thierry's ACK to queue it.
>>>
>>> Just as an additional note: I think the real reason why this is okay to
>>> do is because we reset the PCI host controller in the kernel driver, so
>>> any bus assignments done by the firmware are reset as well.
>>>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>
>> Thank you. This series needs rebasing, we should try to untangle
>> the dependencies between series so that I can actually apply some
>> of these patches that make sense on their own.
> 
> Manikanta, would you be able to decouple this series from:
> 
> https://patchwork.ozlabs.org/patch/832053/
> 
> so that we can make forward progress ? There are some patches in
> this series that I could apply - if rebased.
> 
> Lorenzo
> 

Sure, I will decouple and send this series again.
