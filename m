Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34076 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeF1LXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jun 2018 07:23:51 -0400
Received: by mail-qk0-f193.google.com with SMTP id b66-v6so2725483qkj.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Jun 2018 04:23:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6f842c91-31da-ec4b-d2ff-a90e0cd7ba3f@broadcom.com>
References: <20180626115356.GA24588@wunner.de> <1530092297-10165-1-git-send-email-hari.vyas@broadcom.com>
 <4a27d5b4-6578-8f91-fc6f-6409733f2e15@broadcom.com> <CAM5rFu_28fwC6tnC9HG27KtHb0BNiBtdPWeTUxFAjwCv-Zs+Aw@mail.gmail.com>
 <6f842c91-31da-ec4b-d2ff-a90e0cd7ba3f@broadcom.com>
From: Hari Vyas <hari.vyas@broadcom.com>
Date: Thu, 28 Jun 2018 16:53:49 +0530
Message-ID: <CAM5rFu-3p+vmvnuzVKO0v8t+ZyjDh=4xLJE94SMRkjqFOqFdkQ@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: Data corruption happening due to race condition
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2018 at 10:06 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>
>
> On 6/27/2018 9:32 AM, Hari Vyas wrote:
>>
>> On Wed, Jun 27, 2018 at 9:57 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>>>
>>> Are you re-sending v1 version of this patch or this is actually v2?
>>>
>> This is actually v2. Forgot to give version in first patch.
>
>
> You may choose to specify [PATCH v1]: or simply [PATCH]: on your first
> version of the patch, so what you did in the first version was okay.
>
> Now, prefixing the 2nd version of the patch with v1 is just wrong and causes
> confusions. Can you fix that?
>
> In addition, the Reviewed-by filed on me needs to be removed on v2 of this
> patch, since I've never reviewed since you changed it from v1.
>
>
One spin_lock_init() was missing so just added for new patch. As that patch
should be obsolete so will take care about versioning in upcoming patch.
I have tested with priv_flag changes and needed to modify following files.
Changes fixing current scenario concern but eventually looks like  all pci_dev
relevant bit fields needs to be protected using atomic operation
keeping future in mind
and some cleanup in other modules using pci_dev structure fields.

I will  probably need to  raise three separate patches i.e. one for
powerpc/ files,
driver/pci/*.c and include/linux.h;driver/pci/pci.h. Probably need
to include powerpc maintainer too.

modified:   arch/powerpc/kernel/pci-common.c
modified:   arch/powerpc/platforms/powernv/pci-ioda.c
modified:   arch/powerpc/platforms/pseries/setup.c
modified:   drivers/pci/bus.c
modified:   drivers/pci/hotplug/acpiphp_glue.c
modified:   drivers/pci/pci-driver.c
modified:   drivers/pci/pci.c
modified:   drivers/pci/pci.h
modified:   drivers/pci/probe.c
modified:   drivers/pci/remove.c
modified:   include/linux/pci.h

>> There was spin lock initialization issue with v1 which was not caught
>> in our environment.
>> In any case, I am trying out suggested priv_flag approach and testing it.
>> Hopefully that should be final version.
>>>
>>> Thanks,
>>>
>>> Ray
>>>
>>>
>>> On 6/27/2018 2:38 AM, Hari Vyas wrote:
>>>>
>>>>
>>>> When a pci device is detected, a variable is_added is set to
>>>> 1 in pci device structure and proc, sys entries are created.
>>>>
>>>> When a pci device is removed, first is_added is checked for one
>>>> and then device is detached with clearing of proc and sys
>>>> entries and at end, is_added is set to 0.
>>>>
>>>> is_added and is_busmaster are bit fields in pci_dev structure
>>>> sharing same memory location.
>>>>
>>>> A strange issue was observed with multiple times removal and
>>>> rescan of a pcie nvme device using sysfs commands where is_added
>>>> flag was observed as zero instead of one while removing device
>>>> and proc,sys entries are not cleared.  This causes issue in
>>>> later device addition with warning message "proc_dir_entry"
>>>> already registered.
>>>>
>>>> Debugging revealed a race condition between pcie core driver
>>>> enabling is_added bit(pci_bus_add_device()) and nvme driver
>>>> reset work-queue enabling is_busmaster bit (by pci_set_master()).
>>>> As both fields are not handled in atomic manner and that clears
>>>> is_added bit.
>>>>
>>>> Fix protects is_added and is_busmaster bits updation by a spin
>>>> locking mechanism.
>>>>
>>>> Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>> ---
>>>>    drivers/pci/bus.c        | 3 +++
>>>>    drivers/pci/pci-driver.c | 2 ++
>>>>    drivers/pci/pci.c        | 7 +++++++
>>>>    drivers/pci/probe.c      | 1 +
>>>>    drivers/pci/remove.c     | 5 +++++
>>>>    include/linux/pci.h      | 1 +
>>>>    6 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>>>> index 35b7fc8..61d389d 100644
>>>> --- a/drivers/pci/bus.c
>>>> +++ b/drivers/pci/bus.c
>>>> @@ -310,6 +310,7 @@ void __weak pcibios_bus_add_device(struct pci_dev
>>>> *pdev) { }
>>>>    void pci_bus_add_device(struct pci_dev *dev)
>>>>    {
>>>>          int retval;
>>>> +       unsigned long flags;
>>>>          /*
>>>>           * Can not put in pci_device_add yet because resources
>>>> @@ -330,7 +331,9 @@ void pci_bus_add_device(struct pci_dev *dev)
>>>>                  return;
>>>>          }
>>>>    +     spin_lock_irqsave(&dev->lock, flags);
>>>>          dev->is_added = 1;
>>>> +       spin_unlock_irqrestore(&dev->lock, flags);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_bus_add_device);
>>>>    diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index c125d53..547bcd7 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -123,6 +123,8 @@ static ssize_t new_id_store(struct device_driver
>>>> *driver, const char *buf,
>>>>                  pdev->subsystem_device = subdevice;
>>>>                  pdev->class = class;
>>>>    +             spin_lock_init(&pdev->lock);
>>>> +
>>>>                  if (pci_match_id(pdrv->id_table, pdev))
>>>>                          retval = -EEXIST;
>>>>    diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 97acba7..bcb1f96 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -1649,6 +1649,7 @@ void pci_disable_enabled_device(struct pci_dev
>>>> *dev)
>>>>    void pci_disable_device(struct pci_dev *dev)
>>>>    {
>>>>          struct pci_devres *dr;
>>>> +       unsigned long flags;
>>>>          dr = find_pci_dr(dev);
>>>>          if (dr)
>>>> @@ -1662,7 +1663,9 @@ void pci_disable_device(struct pci_dev *dev)
>>>>          do_pci_disable_device(dev);
>>>>    +     spin_lock_irqsave(&dev->lock, flags);
>>>>          dev->is_busmaster = 0;
>>>> +       spin_unlock_irqrestore(&dev->lock, flags);
>>>>    }
>>>>    EXPORT_SYMBOL(pci_disable_device);
>>>>    @@ -3664,6 +3667,7 @@ void __iomem
>>>> *devm_pci_remap_cfg_resource(struct
>>>> device *dev,
>>>>    static void __pci_set_master(struct pci_dev *dev, bool enable)
>>>>    {
>>>>          u16 old_cmd, cmd;
>>>> +       unsigned long flags;
>>>>          pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
>>>>          if (enable)
>>>> @@ -3675,7 +3679,10 @@ static void __pci_set_master(struct pci_dev *dev,
>>>> bool enable)
>>>>                          enable ? "enabling" : "disabling");
>>>>                  pci_write_config_word(dev, PCI_COMMAND, cmd);
>>>>          }
>>>> +
>>>> +       spin_lock_irqsave(&dev->lock, flags);
>>>>          dev->is_busmaster = enable;
>>>> +       spin_unlock_irqrestore(&dev->lock, flags);
>>>>    }
>>>>      /**
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index ac876e3..9203b88 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -2102,6 +2102,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>>>>          INIT_LIST_HEAD(&dev->bus_list);
>>>>          dev->dev.type = &pci_dev_type;
>>>>          dev->bus = pci_bus_get(bus);
>>>> +       spin_lock_init(&dev->lock);
>>>>          return dev;
>>>>    }
>>>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>>>> index 6f072ea..ff57bd6 100644
>>>> --- a/drivers/pci/remove.c
>>>> +++ b/drivers/pci/remove.c
>>>> @@ -17,13 +17,18 @@ static void pci_free_resources(struct pci_dev *dev)
>>>>      static void pci_stop_dev(struct pci_dev *dev)
>>>>    {
>>>> +       unsigned long flags;
>>>> +
>>>>          pci_pme_active(dev, false);
>>>>          if (dev->is_added) {
>>>>                  device_release_driver(&dev->dev);
>>>>                  pci_proc_detach_device(dev);
>>>>                  pci_remove_sysfs_dev_files(dev);
>>>> +
>>>> +               spin_lock_irqsave(&dev->lock, flags);
>>>>                  dev->is_added = 0;
>>>> +               spin_unlock_irqrestore(&dev->lock, flags);
>>>>          }
>>>>          if (dev->bus->self)
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 340029b..6940825 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -365,6 +365,7 @@ struct pci_dev {
>>>>          bool            match_driver;           /* Skip attaching
>>>> driver
>>>> */
>>>>    +     spinlock_t      lock;                   /* Protect is_added and
>>>> is_busmaster */
>>>>          unsigned int    transparent:1;          /* Subtractive decode
>>>> bridge */
>>>>          unsigned int    multifunction:1;        /* Multi-function
>>>> device
>>>> */
>>>>
>
