Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: Sinan Kaya <okaya@codeaurora.org>, Alex_Gagniuc@Dellteam.com,
        bhelgaas@google.com
Cc: Austin.Bolen@dell.com, Shyam.Iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <28004506-24f0-6d10-2d1e-074e0483d2f9@codeaurora.org>
 <4e0611c872054e768daa96b302651db3@ausx13mps321.AMER.DELL.COM>
 <f260078b-6918-7fd9-39d6-e9f300e4c048@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <3b8a895b-3080-7ddb-cbfd-5aa972e9bf65@gmail.com>
Date: Thu, 31 May 2018 10:46:07 -0500
MIME-Version: 1.0
In-Reply-To: <f260078b-6918-7fd9-39d6-e9f300e4c048@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/31/2018 10:38 AM, Sinan Kaya wrote:
> On 5/31/2018 11:29 AM, Alex_Gagniuc@Dellteam.com wrote:
>> On 5/31/2018 10:28 AM, Sinan Kaya wrote:
>>> On 5/31/2018 11:05 AM, Alexandru Gagniuc wrote:
>>>> +static void pcie_max_link_cap(struct pci_dev *dev, enum pci_bus_speed *speed,
>>>> +				enum pcie_link_width *width)
>>>> +{
>>>> +	uint32_t lnkcap;
>>>> +
>>>> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>>>> +
>>>> +	*speed = pcie_link_speed[lnkcap & PCI_EXP_LNKCAP_SLS];
>>>> +	*width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> PCI_EXP_LNKCAP_MLW_SHIFT;
>>>> +}
>>>> +
>>>> +static void pcie_cur_link_sta(struct pci_dev *dev, enum pci_bus_speed *speed,
>>>> +				enum pcie_link_width *width)
>>>> +{
>>>> +	uint16_t lnksta;
>>>> +
>>>> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>>>> +	*speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
>>>> +	*width = (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
>>>> +}
>>>> +
>>>> +static const char *pcie_bus_speed_name(enum pci_bus_speed speed)
>>>> +{
>>>> +	switch (speed) {
>>>> +	case PCIE_SPEED_2_5GT:
>>>> +		return "2.5 GT/s";
>>>> +	case PCIE_SPEED_5_0GT:
>>>> +		return "5.0 GT/s";
>>>> +	case PCIE_SPEED_8_0GT:
>>>> +		return "8.0 GT/s";
>>>> +	default:
>>>> +		return "unknown";
>>>> +	}
>>>> +}
>>>
>>> I thought Bjorn added some functions to retrieve this now.
>>
>> Hmm. I couldn't find them.
> 
> https://lkml.org/lkml/2018/3/30/553

Oh, pcie_get_speed_cap()/pcie_get_width_cap() seems to handle the
capability. Not seeing one for status and speed name.

> are you working on linux-next?

v4.17-rc7

>>
>> Alex
>>
>>
> 
> 
