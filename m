Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeH0W4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Aug 2018 18:56:40 -0400
Subject: Re: bug in pci_try_reset_bus
To: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org
References: <3d3d78fb-f1f2-ec4f-38f9-0b0d14564f53@intel.com>
 <323b3bbe-d255-8a5d-2a9c-d64e1f86cb64@codeaurora.org>
 <bd7dbd5a-eebc-9142-f9a2-3b5ff8de9b8b@intel.com>
 <d437400c-7eed-19d3-9cf2-b8a42217136b@codeaurora.org>
 <2f0fb394-f1c9-d782-ffec-dac04b1ac0a9@intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <84484c45-64ff-ca2d-39dd-ee579e28558e@codeaurora.org>
Date: Mon, 27 Aug 2018 15:08:36 -0400
MIME-Version: 1.0
In-Reply-To: <2f0fb394-f1c9-d782-ffec-dac04b1ac0a9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/27/2018 2:59 PM, Dennis Dalessandro wrote:
> On 8/27/2018 2:21 PM, Sinan Kaya wrote:
>> [+linux-pci]
> 
> I'm not seeing a CC?

sorry, I fat fingered it. fixing now.

> 
>> On 8/27/2018 2:12 PM, Dennis Dalessandro wrote:
>>> On 8/27/2018 1:27 PM, Sinan Kaya wrote:
>>>> On 8/27/2018 1:21 PM, Dennis Dalessandro wrote:
>>>>> + */
>>>>> +int pci_try_reset_bus(struct pci_dev *pdev)
>>>>> +{
>>>>> +       return pci_probe_reset_slot(pdev->slot) ?
>>>>> +           __pci_try_reset_slot(pdev->slot) : __pci_try_reset_bus(pdev->bus);
>>>>> +}
>>>>
>>>> Code needs to go to __pci_try_reset_bus() when pci_probe_reset_slot() fails.
>>>>
>>>> It looks like we are missing a ! in front of pci_probe_reset_slot().
>>>>
>>>> Can you try this instead?
>>>>
>>>>        return !pci_probe_reset_slot(pdev->slot) ?
>>>>             __pci_try_reset_slot(pdev->slot) : __pci_try_reset_bus(pdev->bus);
>>>
>>> Right so I did that and it lands where I want it to, but the hang I get seems 
>>> to happen after it bails out of pci_bus_reset() because probe is set to 1.
>>
>> Is it returning from here?
>>
>> static int __pci_reset_bus(struct pci_bus *bus)
>> {
>>      int rc;
>>
>>      rc = pci_bus_reset(bus, 1);
>>      if (rc)
>>          return rc;
>>
>> ...
>> }
>>
>> If yes, this means that your bus is not resettable or your bus pointer
>> is null?
>>
>> Can you find out which one it is?
>>
>> https://elixir.bootlin.com/linux/v4.19-rc1/source/drivers/pci/pci.c#L5138
>>
>> It might be also good to capture the return value of pci_bus_reset() to
>> see if it returns 0 or not.
> 
> It is returning 0 from there because pci_bus_reset is being called with probe = 1.
> 
> The call stack from the driver is:
> 
> pci_reset_bus(pdev)
>      __pci_reset_bus(pdev->bus) <-- after fixing first issue
>          pci_bus_reset(bus, 1)
>              Checks ptr and if resetable.
>              if (probe)
>                  return 0 <-- here is where it returns
> 

Probe is there to query if this particular device supports reset or not. Which
is the very first thing this code does to ensure we are allowed to touch it
and it is correct.

If probe is returning 0, this code won't return from here. It will continue
to trylock piece.

	rc = pci_bus_reset(bus, 1);
	if (rc)
		return rc;

My guess is you are failing below with -EAGAIN because lock fails:

if (pci_bus_trylock(bus)) {

} else {
	rc = -EAGAIN;
}

can you please confirm?


> I tried removing the whole if (probe) then return thing but still get a hang 
> when it calls pci_bus_lock().
> 
>>> What is the right way to do an SBR while our driver is being probed? The 
>>> reason we are doing all of this is because we need to do a bump up to gen3 
>>> speed when the driver loads and the last thing we need to do is issue an SBR.
>>
>> I don't think you can achieve what you want without doing an SBR. Another
>> possibility is retrain if your hardware supports.
> 
> We do want to do an SBR. I'm just wondering if we are going about it the right 
> way. Because things worked before this was hidden from the drivers and we called 
> right into the bus reset.

That's where the problem is. It is responsibility of the PCI core to check that
you are allowed to reset.

> 
> -Denny
> 
