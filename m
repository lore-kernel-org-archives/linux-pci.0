Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:36251 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753430AbdLMPuL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 10:50:11 -0500
Subject: Re: [PATCH V3 02/12] PCI: tegra: Move REFCLK pad settings out of
 phy_power_on()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, mperttunen@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-3-git-send-email-mmaddireddy@nvidia.com>
 <20171212114527.GB30799@e107981-ln.cambridge.arm.com>
 <6a089c5a-7a79-fd9f-ff77-e08f16731241@nvidia.com>
 <20171213142304.GB1736@red-moon>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <65662863-5c61-451e-b17b-516dc84b523e@kapsi.fi>
Date: Wed, 13 Dec 2017 03:16:09 +0200
MIME-Version: 1.0
In-Reply-To: <20171213142304.GB1736@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13.12.2017 16:23, Lorenzo Pieralisi wrote:
> On Wed, Dec 13, 2017 at 05:32:32PM +0530, Manikanta Maddireddy wrote:
>>
>>
>> On 12-Dec-17 5:15 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Oct 30, 2017 at 07:27:13PM +0530, Manikanta Maddireddy wrote:
>>>> In Tegra186 PHY programming is done by BPMP-FW, so PHY calls are skipped
>>>
>>> It is time you defined what FW does and what the kernel does and stick
>>> to that SW initialization sequence for all Tegra PCI host bridges from
>>> now onwards. Those tegra_pcie_soc structures in the driver will end up
>>> with a gazillion hardcoded parameters if you do not take a stance from
>>> that perspective and I do not like that - at all.
>>>
>>> You may want to use DT bindings to describe the FW<->OS handover - or
>>> just enforce firmware guidelines for Tegra systems - something has to be
>>> done.
>>>
>>> This patch makes sense stand-alone but I wanted to get the message
>>> across.
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>
>> In Tegra186 BPMP-FW will take care of programming the UPHY, this is
>> updated in commit log of "9cea513d8cbc ("PCI: tegra: Add Tegra186 PCIe support")".
>> I didn't put it in DT bindings because there is no DT property for this purpose.
>> Do you want me to add a comment in PCIe tegra driver, perhaps near program_uphy variable?
> 
> I would like to see some consistency from now onwards on what's done
> in BPMP (or host) FW and what's done in the driver and that's something
> you should drive because, as I have already said, the current approch
> based on boolean flags per-SoC hardcoded in the kernel does not scale -
> I may tolerate it for now but that has to change.
>

The model has changed once, when BPMP was introduced. So pre-BPMP SoCs 
(Tegra20/30/114/124/210) program the UPHY in kernel and post-BPMP SoCs 
(Tegra186+) have the BPMP program it. So there should not be further 
changes to this.

Mikko

> Is it that hard to define a software programming model (to describe
> what's done in what piece of software/firmware) for tegra PCI host
> bridges >
>> In current host driver, REFCLK pads settings are done in
>> tegra_pcie_port_phy_power_off() which is not apt. REFCLK pad settings
>> tunes the PCIe sideband signal REFCLK, it has nothing to do with UPHY.
>> So I am moving it out of tegra_pcie_port_phy_power_off().
> 
> I gathered that, I was not complaining on this patch on his own.
> 
> Thanks,
> Lorenzo
> 
>> Thanks,
>> Manikanta
>>
>>
>>>> in driver. REFCLK pad settings are independent of PHY and should be
>>>> programmed by driver. So move REFCLK pad settings out of phy_power_on().
>>>> These pad settings improve REFCLK peak to peak amplitude.
>>>>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>> V3:
>>>> * Corrected commit log
>>>> V2:
>>>> * no change in this patch
>>>>
>>>>   drivers/pci/host/pci-tegra.c | 20 +++++++++++++-------
>>>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>>>> index b41c60c7414c..068510b40c1a 100644
>>>> --- a/drivers/pci/host/pci-tegra.c
>>>> +++ b/drivers/pci/host/pci-tegra.c
>>>> @@ -910,7 +910,6 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
>>>>   static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>>>>   {
>>>>   	struct device *dev = pcie->dev;
>>>> -	const struct tegra_pcie_soc *soc = pcie->soc;
>>>>   	struct tegra_pcie_port *port;
>>>>   	int err;
>>>>   
>>>> @@ -936,12 +935,6 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>>>>   		}
>>>>   	}
>>>>   
>>>> -	/* Configure the reference clock driver */
>>>> -	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
>>>> -
>>>> -	if (soc->num_ports > 2)
>>>> -		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>>>> -
>>>>   	return 0;
>>>>   }
>>>>   
>>>> @@ -2049,6 +2042,17 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>>>>   	return 0;
>>>>   }
>>>>   
>>>> +static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
>>>> +{
>>>> +	const struct tegra_pcie_soc *soc = pcie->soc;
>>>> +
>>>> +	/* Configure the reference clock driver */
>>>> +	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
>>>> +
>>>> +	if (soc->num_ports > 2)
>>>> +		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>>>> +}
>>>> +
>>>>   /*
>>>>    * FIXME: If there are no PCIe cards attached, then calling this function
>>>>    * can result in the increase of the bootup time as there are big timeout
>>>> @@ -2107,6 +2111,8 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>>>   	struct device *dev = pcie->dev;
>>>>   	struct tegra_pcie_port *port, *tmp;
>>>>   
>>>> +	tegra_pcie_apply_pad_settings(pcie);
>>>> +
>>>>   	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>>>>   		dev_info(dev, "probing port %u, using %u lanes\n",
>>>>   			 port->index, port->lanes);
>>>> -- 
>>>> 2.1.4
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
