Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/5] PCI: iproc: Add PAXC interface support
To: Florian Fainelli <f.fainelli@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
 <1447806715-30043-3-git-send-email-rjui@broadcom.com>
 <564BC79D.9010705@gmail.com> <564BCA4C.6030809@broadcom.com>
 <564BCA33.9020801@gmail.com>
CC: Marc Zyngier <marc.zyngier@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <564BCAB0.9060800@broadcom.com>
Date: Tue, 17 Nov 2015 16:47:44 -0800
MIME-Version: 1.0
In-Reply-To: <564BCA33.9020801@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/17/2015 4:45 PM, Florian Fainelli wrote:
> On 17/11/15 16:46, Ray Jui wrote:
>>
>>
>> On 11/17/2015 4:34 PM, Florian Fainelli wrote:
>>> On 17/11/15 16:31, Ray Jui wrote:
>>>> Traditionally, all iProc PCIe root complexes use PAXB based wrapper,
>>>> with an integrated on-chip Serdes to support external endpoint devices.
>>>> On newer iProc platforms, a PAXC based wrapper is introduced, for
>>>> connection with internally emulated PCIe endpoint devices in the ASIC
>>>>
>>>> This patch adds support for PAXC based iProc PCIe root complex in the
>>>> iProc PCIe core driver. This change fators out common logic between
>>>> PAXB and PAXC, and use tables to store register offsets that are
>>>> different between PAXB and PAXC. This allows the driver to be scaled to
>>>> support subsequent PAXC revisions in the future
>>>>
>>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>>> ---
>>>>    drivers/pci/host/pcie-iproc-platform.c |   8 ++
>>>>    drivers/pci/host/pcie-iproc.c          | 202
>>>> +++++++++++++++++++++++++++------
>>>>    drivers/pci/host/pcie-iproc.h          |  19 ++++
>>>>    3 files changed, 195 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-iproc-platform.c
>>>> b/drivers/pci/host/pcie-iproc-platform.c
>>>> index c9550dc..716b56b 100644
>>>> --- a/drivers/pci/host/pcie-iproc-platform.c
>>>> +++ b/drivers/pci/host/pcie-iproc-platform.c
>>>> @@ -42,6 +42,13 @@ static int iproc_pcie_pltfm_probe(struct
>>>> platform_device *pdev)
>>>>        pcie->dev = &pdev->dev;
>>>>        platform_set_drvdata(pdev, pcie);
>>>>
>>>> +    if (of_device_is_compatible(np, "brcm,iproc-pcie"))
>>>> +        pcie->type = IPROC_PCIE_PAXB;
>>>> +    else if (of_device_is_compatible(np, "brcm,iproc-pcie-paxc"))
>>>> +        pcie->type = IPROC_PCIE_PAXC;
>>>> +    else
>>>> +        return -ENODEV;
>>>
>>> Sorry for not noticing earlier, but typically, to avoid repeating the
>>> same compatible string twice (once if of_device_id, and somewhere else),
>>> you would put the type in the .data member of the of_device_id lookup
>>> table and you could fetch this directly here. So something like this:
>>>
>>>    static const struct of_device_id iproc_pcie_of_match_table[] = {
>>>        { .compatible = "brcm,iproc-pcie", .data = (int
>>> *)IPROC_PCIE_PAXB },
>>> +    { .compatible = "brcm,iproc-pcie-paxc", .data = (int
>>> *)IPROC_PCIE_PAXC },
>>>        { /* sentinel */ }
>>>
>>
>> Just to confirm, if I do this, then the above code to check
>> of_device_is_compatible becomes the following?
>>
>> pcie->type = (enum iproc_pcie_type)of_id->data;
>
> That is correct yes.
>

Okay thanks. Will wait for more comments and include this in the next 
iteration!

Ray


