Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6583 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeCFNs3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 08:48:29 -0500
Subject: Re: [PATCH V9 3/3] PCI: tegra: Add power management support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <cyndis@kapsi.fi>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <vidyas@nvidia.com>, <kthota@nvidia.com>
References: <1519812034-11120-1-git-send-email-mmaddireddy@nvidia.com>
 <1519812034-11120-4-git-send-email-mmaddireddy@nvidia.com>
 <20180302163643.GA18316@e107981-ln.cambridge.arm.com>
 <19831410-9248-61ff-6e75-249c77dcee9a@nvidia.com>
 <20180305094116.GA28109@e107981-ln.cambridge.arm.com>
 <f807a2ad-6d30-70e5-ec42-fd2cf996f7a0@nvidia.com>
 <20180306115907.GA14599@e107981-ln.cambridge.arm.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <0d154904-d413-f22f-5fbc-2d7a793912c5@nvidia.com>
Date: Tue, 6 Mar 2018 19:18:04 +0530
MIME-Version: 1.0
In-Reply-To: <20180306115907.GA14599@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 06-Mar-18 5:29 PM, Lorenzo Pieralisi wrote:
> On Tue, Mar 06, 2018 at 03:26:33PM +0530, Manikanta Maddireddy wrote:
>>
>>
>> On 05-Mar-18 3:11 PM, Lorenzo Pieralisi wrote:
>>> On Sat, Mar 03, 2018 at 01:47:38PM +0530, Manikanta Maddireddy wrote:
>>>
>>> [...]
>>>
>>>>>> +static int tegra_pcie_pm_resume(struct device *dev)
>>>>>> +{
>>>>>> +	struct tegra_pcie *pcie = dev_get_drvdata(dev);
>>>>>> +	int err;
>>>>>> +
>>>>>> +	err = tegra_pcie_power_on(pcie);
>>>>>> +	if (err) {
>>>>>> +		dev_err(dev, "tegra pcie power on fail: %d\n", err);
>>>>>> +		return err;
>>>>>> +	}
>>>>>> +	err = tegra_pcie_enable_controller(pcie);
>>>>>> +	if (err) {
>>>>>> +		dev_err(dev, "tegra pcie controller enable fail: %d\n", err);
>>>>>> +		goto poweroff;
>>>>>> +	}
>>>>>> +	tegra_pcie_setup_translations(pcie);
>>>>>> +
>>>>>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>>>>>> +		tegra_pcie_enable_msi(pcie);
>>>>>> +
>>>>>> +	tegra_pcie_enable_ports(pcie);
>>>>>
>>>>> Is it correct to report a successfull resume if some of the ports fail
>>>>> to come up (whether within runtime PM or system suspend) ? I think that,
>>>>> if any of the ports fails to come up, returning a failure is more
>>>>> appropriate here given that the host bridge is a single device as far as
>>>>> the kernel is concerned.
>>>>>
>>>>> Thanks,
>>>>> Lorenzo
>>>>>
>>>>
>>>> Hi Lorenzo,
>>>>
>>>> We(Thierry, Vidya Sagar and myself) had a discussion on this topic
>>>> and we chose not to fail probe/resume because host controller is
>>>> initialized properly, so failing the probe/resume is not the right
>>>> thing to do.
>>>
>>> What happens then to endpoints downstream a rootport that failed to
>>> resume but we nonetheless reported that it successfully resume instead ?
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>
>> Hi Lorenzo,
>>
>> If an endpoint comes up in probe & enumeration is completed and if
>> the same endpoint doesn't come up during resume I am observing
>> PCIe errors because PCIe enumeration hierarchy is unchanged &
>> PCI subsystem is trying to restore PCI device. This observation
>> is same if host driver returns error.
>>
>> To handle this case driver needs to remove the respective
>> PCIe port enumeration hierarchy if link doesn't come up
>> in resume. It will tricky to identify PCI bus structure
>> from host port ID in resume, may be some book keeping required
>> here.
>>
>> However if the PCIe link comes up in probe, it should come up
>> during resume as well else it will be a bug. Do you see the
>> need for changing the PCIe enumeration hierarchy in resume
>> based on link up status?
> 
> I think that for the time being it is fine to merge the current
> set - I asked just for clarification; I agree there is no easy answer
> to the issue I raised. It should be safe to merge the series in its
> current form - I will keep this issue on my radar to see if there
> is something we can do to improve it.
> 
> Thanks,
> Lorenzo
> 
Thank you Lorenzo

>>
>> Thanks,
>> Manikanta
>>
>>>> PCIe link may fail to come up if there is no endpoint in the slot
>>>> or interoperable failure where endpoint specific quirk or work
>>>> around required. In such cases host controller driver shouldn't
>>>> fail.
>>>>
>>>> Also user can connect endpoint in only one slot and expect it to be
>>>> working. Even though host bridge is a single device, driver should
>>>> allow standalone port to work.
>>>>
>>>> Thanks,
>>>> Manikanta
>>>>
>>>>>>  
>>>>>>  	return 0;
>>>>>> +
>>>>>> +poweroff:
>>>>>> +	tegra_pcie_power_off(pcie);
>>>>>> +
>>>>>> +	return err;
>>>>>>  }
>>>>>>  
>>>>>> +static const struct dev_pm_ops tegra_pcie_pm_ops = {
>>>>>> +	SET_RUNTIME_PM_OPS(tegra_pcie_pm_suspend, tegra_pcie_pm_resume, NULL)
>>>>>> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_pcie_pm_suspend,
>>>>>> +				      tegra_pcie_pm_resume)
>>>>>> +};
>>>>>> +
>>>>>>  static struct platform_driver tegra_pcie_driver = {
>>>>>>  	.driver = {
>>>>>>  		.name = "tegra-pcie",
>>>>>>  		.of_match_table = tegra_pcie_of_match,
>>>>>>  		.suppress_bind_attrs = true,
>>>>>> +		.pm = &tegra_pcie_pm_ops,
>>>>>>  	},
>>>>>>  	.probe = tegra_pcie_probe,
>>>>>>  	.remove = tegra_pcie_remove,
>>>>>> -- 
>>>>>> 2.1.4
>>>>>>
