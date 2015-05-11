Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33427 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbEKHRs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 03:17:48 -0400
Received: by pacwv17 with SMTP id wv17so103171534pac.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 00:17:48 -0700 (PDT)
Message-ID: <55505796.5030904@ozlabs.ru>
Date: Mon, 11 May 2015 17:17:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com
Subject: Re: [PATCH v4 10/21] powerpc/powernv: Fundamental reset for PCI bus
 reset
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com> <1430460188-31343-11-git-send-email-gwshan@linux.vnet.ibm.com> <554E15C2.40506@ozlabs.ru> <20150511064720.GB8241@gwshan>
In-Reply-To: <20150511064720.GB8241@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/2015 04:47 PM, Gavin Shan wrote:
> On Sun, May 10, 2015 at 12:12:18AM +1000, Alexey Kardashevskiy wrote:
>> On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>> Function pnv_pci_reset_secondary_bus() is used to reset specified
>>> PCI bus, which is leaded by root complex or PCI bridge. That means
>>> the function shouldn't be called on PCI root bus and the patch
>>> removes the logic for that case.
>>>
>>> Also, some adapters beneath the indicated PCI bus may require
>>> fundamental reset in order to successfully reload their firmwares
>>> after the reset. The patch translates hot reset to fundamental reset
>>> for that case.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 35 +++++++++++++++++++++-------
>>>   1 file changed, 26 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> index 3c01095..58e4dcf 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -888,18 +888,35 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>>   	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
>>>   }
>>>
>>> -void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>
>>
>> Why changing dev to pdev? Keeping "dev" could make the patch simpler.
>>
>
> In the early stage when I wrote the EEH code, I had "dev" to refer PCI
> device, which isn't precisely enough. Actually, "dev" means "struct device"
> while "pdev" stands for "struct pci_dev". That's why I changed it.


The rest of the file and the kernel overall use "dev" for pci_dev just 
fine. I would not bother.


>>> +static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>>>   {
>>> -	struct pci_controller *hose;
>>> +	int *freset = data;
>>>
>>> -	if (pci_is_root_bus(dev->bus)) {
>>> -		hose = pci_bus_to_host(dev->bus);
>>> -		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
>>> -		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
>>> -	} else {
>>> -		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>>> -		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>>> +	/*
>>> +	 * Stop the iteration immediately if there is any
>>> +	 * one PCI device requesting fundamental reset
>>> +	 */
>>> +	*freset |= pdev->needs_freset;
>>> +	return *freset;
>>> +}
>>> +
>>> +void pnv_pci_reset_secondary_bus(struct pci_dev *pdev)
>>> +{
>>> +	int option = EEH_RESET_HOT;
>>> +	int freset = 0;
>>> +
>>> +	/* Check if there're any PCI devices asking for fundamental reset */
>>> +	if (pdev->subordinate) {
>>> +		pci_walk_bus(pdev->subordinate,
>>> +			     pnv_pci_dev_reset_type,
>>> +			     &freset);
>>> +		if (freset)
>>> +			option = EEH_RESET_FUNDAMENTAL;
>>>   	}
>>> +
>>> +	/* Issue the requested type of reset */
>>> +	pnv_eeh_bridge_reset(pdev, option);
>>> +	pnv_eeh_bridge_reset(pdev, EEH_RESET_DEACTIVATE);
>>>   }
>>>
>>>   /**
>>>
>
> Thanks,
> Gavin
>


-- 
Alexey
