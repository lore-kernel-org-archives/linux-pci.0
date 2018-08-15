Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:50962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbeHOS50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2018 14:57:26 -0400
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
To: poza@codeaurora.org
Cc: bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <8b8db3c5-e884-d697-6193-b409276f9638@oracle.com>
 <fa97a363892f757203ec7209f374a220@codeaurora.org>
 <08462817-7a4f-2d8a-a329-e856c9e702c9@oracle.com>
 <9215fe3c62c2f15d7da221bb77bd5680@codeaurora.org>
 <a23efe6f-4341-edaa-a230-c2f1c93ff0ce@oracle.com>
 <3c5fe7896f5d558fef9d37f8b7156a3b@codeaurora.org>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <c36f36bb-d80d-de58-af19-2653ac21b9a4@oracle.com>
Date: Wed, 15 Aug 2018 12:04:33 -0400
MIME-Version: 1.0
In-Reply-To: <3c5fe7896f5d558fef9d37f8b7156a3b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 08/15/2018 11:59 AM, poza@codeaurora.org wrote:
> On 2018-08-15 21:13, Thomas Tai wrote:
>> [ ... ]>>>>>>> +        if (dev)
>>>>>>>>> +            pci_info(dev, "Device recovery from fatal error 
>>>>>>>>> successful\n");
>>>>>>>>> +        else
>>>>>>>>> +            pr_err("AER: Can not find pci_dev for 
>>>>>>>>> %04x:%02x:%02x.%x\n",
>>>>>>>>> +                   domain, bus,
>>>>>>>>> +                   PCI_SLOT(devfn), PCI_FUNC(devfn));
>>>>>>>>> +        pci_dev_put(dev);
>>>>>>
>>>>>> That is, replace above with:
>>>>>>
>>>>>>     pr_info("AER: Device %04x:%02x:%02x.%x recover from fatal error
>>>>>> successful\n", domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>>>>>>
>>>>> is this not sufficient to print ?  which is there already.
>>>>> pci_info(dev, "Device recovery from fatal error successful\n");
>>>>
>>>> Unfortunately, I can't use "dev" because as you said I can't
>>>> pci_get_domain_slot to search for it after rescanning.
>>>>
>>>> -T
>>>
>>> If I understood the patch correctly,
>>> 1) it is restructuring of pci_dev_put(dev);
>>> 2) now we are sending uevent only if it is bridge.
>>> 3) the other logic where you store and compare bdf is not required, 
>>> although we have to fix following.
>>> pci_info(dev, "Device recovery from fatal error successful\n");
>>>
>>>
>>> probably 1) and 2) could be a separate patch.
>>
>> Yes Oza. I will separate 1) and 2) and fix the pci_info(dev, "...") to
>> use domain:bus:devfn
> 
> Thanks Thomas,
> although I am not sure on 3)  by doing following.
> 
>   dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
>       if (dev)
>          pci_info(dev, "Device recovery from fatal error successful\n");
> 
> but also it may be the case that device is removed and there is no new 
> device which would match BDF
> so in any case recovery has happened as far as PCIe link is concerned.
> 
> surprisingly in my case followin also went fine
> pci_info(dev, "Device recovery from fatal error successful\n");
> I guess probably after re-enumeration, I got the sane dev back !! (since 
> it enumerated the same device)
> 
> how about something like this
> 
> dev = pci_get_domain_bus_and_slot(domain, bus, devfn);
>       if (dev)
>          pci_info(dev, "Device recovery from fatal error successful\n");
>        else
>           pr_ifo ("AER: Device recovery from fatal error successful")

That is cool! Thank you for your suggestion, I will do so in V2.

Thomas

> 
> Regards,
> Oza.
> 
>>
>>>
>>> by the way,
>>> In my testing even after removing device the call pci_uevent_ers(dev, 
>>> PCI_ERS_RESULT_DISCONNECT); did not create any problem.
>>
>> I think that is dangerous, if we restructure pci_dev_put(dev), ie
>> revert commit bd91b56cb3b27492963caeb5fccefe20a986ca8d. The dev
>> structure is freed and we shouldn't really use it to send
>> pci_uevent_ers(). Although pci_uevent_ers() may be smart enough to
>> figure out to avoid crash, we should only use it when the dev is not
>> removed.
>>
> 
> I Agree.
> 
>> Thanks,
>> Thomas
>>
>>>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>>>      } else {
>>>>>>>>> -        pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>>>>>>>>> -        pci_info(dev, "Device recovery from fatal error 
>>>>>>>>> failed\n");
>>>>>>>>> +        if (is_bridge_device)
>>>>>>>> previously there was no condition.. why is this required now ?
>>>>>>>> and it was doing on "dev" while you are doing it on "udev"
>>>>>>> is that the reason we dont watnt o use dev after it is removed ? 
>>>>>>> instead do pci_uevent_ers on bridge ?
>>>>>>
>>>>>>
>>>>>> Yes, that's exactly the reason. I should have written down the reason
>>>>>> in the commit log. Here is the details explanation for the benefit of
>>>>>> others. If the failing device is a bridge device, udev is equal to
>>>>>> dev. So we can use udev in the pci_uevent_ers. But for non bridge
>>>>>> device the device is already removed from the bus and thus can't send
>>>>>> pci_uevent_ers.
>>>>>>
>>>>>> Thank you,
>>>>>> Thomas
>>>>>>
>>>>>>>>> +            pci_uevent_ers(udev, PCI_ERS_RESULT_DISCONNECT);
>>>>>>>>> +        pr_err("AER: Device %04x:%02x:%02x.%x recovery from 
>>>>>>>>> fatal error failed\n",
>>>>>>>>> +               domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>> -    pci_dev_put(dev);
>>>>>>>>>      pci_unlock_rescan_remove();
>>>>>>>>>  }
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Oza.
