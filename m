Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33929 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdE3S1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2017 14:27:34 -0400
Received: by mail-qk0-f178.google.com with SMTP id d14so35520518qkb.1
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2017 11:27:33 -0700 (PDT)
Subject: Re: [RFC PATCH v2] pci: Concurrency issue in NVMe Init through PCIe
 switch
To: Scott Branden <scott.branden@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1496135297-19680-1-git-send-email-srinath.mannam@broadcom.com>
 <07dbc07b-9cef-7677-5fc4-50b291e7e792@broadcom.com>
 <17a08644-4645-015f-a8ae-389833b171dd@broadcom.com>
 <2d230556-7d99-b411-1f16-2249e526bd02@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <bb260e2e-a5a6-fd34-1ff6-ab42f2a89bb0@broadcom.com>
Date: Tue, 30 May 2017 11:27:29 -0700
MIME-Version: 1.0
In-Reply-To: <2d230556-7d99-b411-1f16-2249e526bd02@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 5/30/17 11:10 AM, Scott Branden wrote:
> Hi Ray,
> 
> 
> On 17-05-30 10:04 AM, Ray Jui wrote:
>> Hi Srinath and Scott,
>>
>> On 5/30/17 8:44 AM, Scott Branden wrote:
>>> Hi Srinath,
>>>
>>>
>>> On 17-05-30 02:08 AM, Srinath Mannam wrote:
>>>> We found a concurrency issue in NVMe Init when we initialize
>>>> multiple NVMe connected over PCIe switch.
>>>>
>>>> Setup details:
>>>>    - SMP system with 8 ARMv8 cores running Linux kernel(4.11).
>>>>    - Two NVMe cards are connected to PCIe RC through bridge as shown
>>>>      in the below figure.
>>>>
>>>>                      [RC]
>>>>                       |
>>>>                    [BRIDGE]
>>>>                       |
>>>>                  -----------
>>>>                 |           |
>>>>               [NVMe]      [NVMe]
>>>>
>>>> Issue description:
>>>> After PCIe enumeration completed NVMe driver probe function called
>>>> for both the devices from two CPUS simultaneously.
>>>>   From nvme_probe, pci_enable_device_mem called for both the EPs. This
>>>> function called pci_enable_bridge enable recursively until RC.
>>>>
>>>> Inside pci_enable_bridge function, at two places concurrency issue is
>>>> observed.
>>>>
>>>> Place 1:
>>>>     CPU 0:
>>>>       1. Done Atomic increment dev->enable_cnt
>>>>          in pci_enable_device_flags
>>>>       2. Inside pci_enable_resources
>>>>       3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
>>>>       4. Ready to set PCI_COMMAND_MEMORY (0x2) in
>>>>          pci_write_config_word(dev, PCI_COMMAND, cmd)
>>>>     CPU 1:
>>>>       1. Check pci_is_enabled in function pci_enable_bridge
>>>>          and it is true
>>>>       2. Check (!dev->is_busmaster) also true
>>>>       3. Gone into pci_set_master
>>>>       4. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
>>>>       5. Ready to set PCI_COMMAND_MASTER (0x4) in
>>>>          pci_write_config_word(dev, PCI_COMMAND, cmd)
>>>>
>>>> By the time of last point for both the CPUs are read value 0 and
>>>> ready to write 2 and 4.
>>>> After last point final value in PCI_COMMAND register is 4 instead of 6.
>>>>
>>>> Place 2:
>>>>     CPU 0:
>>>>       1. Done Atomic increment dev->enable_cnt in
>>>>          pci_enable_device_flags
>>>>
>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>> ---
>>>> Changes since v1:
>>>>    - Used mutex to syncronize pci_enable_bridge
>>>>
>>>>    drivers/pci/pci.c   | 4 ++++
>>>>    drivers/pci/probe.c | 1 +
>>>>    include/linux/pci.h | 1 +
>>>>    3 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index b01bd5b..5bff3e7 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -1347,7 +1347,9 @@ static void pci_enable_bridge(struct pci_dev
>>>> *dev)
>>>>    {
>>>>        struct pci_dev *bridge;
>>>>        int retval;
>>>> +    struct mutex *lock = &dev->bridge_lock;
>>>>    +    mutex_lock(lock);
>>>>        bridge = pci_upstream_bridge(dev);
>>>>        if (bridge)
>>>>            pci_enable_bridge(bridge);
>>>> @@ -1355,6 +1357,7 @@ static void pci_enable_bridge(struct pci_dev
>>>> *dev)
>>>>        if (pci_is_enabled(dev)) {
>>>>            if (!dev->is_busmaster)
>>>>                pci_set_master(dev);
>>>> +        mutex_unlock(lock);
>>>>            return;
>>>>        }
>>>>    @@ -1363,6 +1366,7 @@ static void pci_enable_bridge(struct pci_dev
>>>> *dev)
>>>>            dev_err(&dev->dev, "Error enabling bridge (%d),
>>>> continuing\n",
>>>>                retval);
>>>>        pci_set_master(dev);
>>>> +    mutex_unlock(lock);
>>>>    }
>>> Looking at above function I think it should be restructured so that
>>> mute_unlock only needs to be called in one place.
>>> How about below to make things more clear?
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 563901c..82c232e 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -1347,22 +1347,29 @@ static void pci_enable_bridge(struct pci_dev
>>> *dev)
>>>   {
>>>          struct pci_dev *bridge;
>>>          int retval;
>>> +       struct mutex *lock = &dev->bridge_lock;
>> First of all, using a proper lock for this was proposed during the
>> internal review. The idea was dismissed with concern that a dead lock
>> can happen since the call to pci_enable_bridge is recursive.
>>
>> I'm glad that we are now still using the lock to properly fix the
>> problem by realizing that the lock is specific to the bridge itself and
>> the recursive call to upstream bridge does not cause a deadlock since a
>> different lock is used.
>>
>>> +
>>> +       /*
>>> +        * Add comment here explaining what needs concurrency protection
>>> +        */
>>> +       mutex_lock(lock);
>>>
>>>          bridge = pci_upstream_bridge(dev);
>>>          if (bridge)
>>>                  pci_enable_bridge(bridge);
>>>
>>> -       if (pci_is_enabled(dev)) {
>>> -               if (!dev->is_busmaster)
>>> -                       pci_set_master(dev);
>>> -               return;
>>> +       if (!pci_is_enabled(dev)) {
>>> +               retval = pci_enable_device(dev);
>>> +               if (retval)
>>> +                       dev_err(&dev->dev,
>>> +                               "Error enabling bridge (%d),
>>> continuing\n",
>>> +                               retval);
>>>          }
>>>
>>> -       retval = pci_enable_device(dev);
>>> -       if (retval)
>>> -               dev_err(&dev->dev, "Error enabling bridge (%d),
>>> continuing\n",
>>> -                       retval);
>>> -       pci_set_master(dev);
>>> +       if (!dev->is_busmaster)
>>> +               pci_set_master(dev);
>>> +
>>> +       mutex_unlock(lock);
>>>   }
>>>
>> I really don't see how the above logic is cleaner than the change from
>> Srinath and personally I found this is way harder to read. And we are
>> doing all of this just to keep the mutex_unlock in one place.
> If you apply the patch and look at the resulting code I hope it is
> easier to read than just looking at the patch diff.
> I believe that single entry, single exit is helpful when using a mutex
> to protect critical sections rather than multiple exit points.
> 
> My suggestion is just a suggestion.
>> If that is desired, a label at the end of the function like this will do:
>>
>> out:
>>      mutex_unlock(lock);
>>
>> And error case in the middle of the function can bail out and jump to
>> the label. Note I do not invent this. This is commonly done in a lot of
>> drivers in the kernel for cleaner error handling code.
> This is not an error case for deinitializing using goto's.  I wouldn't
> encourage the use of goto's here.

The same style is commonly used in other cases not dealing with errors.

I just want to express that I find the new code more complicated to read
and in the case of checking against 'pci_is_enabled', we now have 3
levels of indent.

I'm totally fine with leaving the call to Bjorn, :)

Thanks,

Ray
