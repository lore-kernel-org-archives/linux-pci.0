Return-Path: <SRS0=toz3=5D=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=toz3=5D=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170526192703.GB8204@bhelgaas-glaptop.roam.corp.google.com>
References: <1494256190-28993-1-git-send-email-srinath.mannam@broadcom.com> <20170526192703.GB8204@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Mon, 29 May 2017 15:00:42 +0530
Message-ID: <CABe79T5YCE7OXAF5rKWTA6fQkBfDvmW-bHqPA2O5mQZMzfa+tQ@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: Concurrency issue in NVMe Init through PCIe switch
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Sat, May 27, 2017 at 12:57 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Srinath,
>
> Thanks for chasing this down!  It must have been a real hassle to find
> this.
>
> On Mon, May 08, 2017 at 08:39:50PM +0530, Srinath Mannam wrote:
>> We found a concurrency issue in NVMe Init when we initialize
>> multiple NVMe connected over PCIe switch.
>>
>> Setup details:
>>  - SMP system with 8 ARMv8 cores running Linux kernel(4.11).
>>  - Two NVMe cards are connected to PCIe RC through bridge as shown
>>    in the below figure.
>>
>>                    [RC]
>>                     |
>>                  [BRIDGE]
>>                     |
>>                -----------
>>               |           |
>>             [NVMe]      [NVMe]
>>
>> Issue description:
>> After PCIe enumeration completed NVMe driver probe function called
>> for both the devices from two CPUS simultaneously.
>> From nvme_probe, pci_enable_device_mem called for both the EPs. This
>> function called pci_enable_bridge enable recursively until RC.
>>
>> Inside pci_enable_bridge function, at two places concurrency issue is
>> observed.
>>
>> Place 1:
>>   CPU 0:
>>     1. Done Atomic increment dev->enable_cnt
>>        in pci_enable_device_flags
>>     2. Inside pci_enable_resources
>>     3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
>>     4. Ready to set PCI_COMMAND_MEMORY (0x2) in
>>        pci_write_config_word(dev, PCI_COMMAND, cmd)
>>   CPU 1:
>>     1. Check pci_is_enabled in function pci_enable_bridge
>>        and it is true
>>     2. Check (!dev->is_busmaster) also true
>>     3. Gone into pci_set_master
>>     4. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
>>     5. Ready to set PCI_COMMAND_MASTER (0x4) in
>>        pci_write_config_word(dev, PCI_COMMAND, cmd)
>>
>> By the time of last point for both the CPUs are read value 0 and
>> ready to write 2 and 4.
>> After last point final value in PCI_COMMAND register is 4 instead of 6.
>>
>> Place 2:
>>   CPU 0:
>>     1. Done Atomic increment dev->enable_cnt in
>>        pci_enable_device_flags
>>     2. Inside pci_enable_resources
>>     3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
>>     4. Ready to set PCI_COMMAND_MEMORY (0x2) in
>>        pci_write_config_word(dev, PCI_COMMAND, cmd);
>>   CPU 1:
>>     1. Done Atomic increment dev->enable_cnt in function
>>        pci_enable_device_flag fail return 0 from there
>>     2. Gone into pci_set_master
>>     3. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
>>     4. Ready to set PCI_COMMAND_MASTER (0x4) in
>>        pci_write_config_word(dev, PCI_COMMAND, cmd)
>>
>> By the time of last point for both the CPUs are read value 0 and
>> ready to write 2 and 4.
>> After last point final value in PCI_COMMAND register is 4 instead of 6.
>
> Most places that write PCI_COMMAND do this sort of read/modify/write
> thing.  But in most of those places we only touch one device, and it's
> the device we own, e.g., the PCI core enumerating it or a driver.
> I don't think we really have a concurrency problem with those.
>
> But in this case, where a driver called pci_enable_device() for device
> A, and we're touching an upstream bridge B, we *do* have an issue.
>
> Since it's a concurrency issue, the obvious solution is a mutex.  I'm
> sure this patch solves it, but it's not obvious to me how it works and
> I'd be afraid of breaking it in the future.
>
> Would it work to add a mutex in the struct pci_host_bridge, then hold
> it while we enable upstream bridges, e.g., something like the
> following?
>
>   bridge = pci_upstream_bridge(dev);
>   if (bridge) {
>     struct mutex = &pci_find_host_bridge(dev)->mutex;
>
>     mutex_lock(mutex);
>     pci_enable_bridge(bridge);
>     mutex_unlock(mutex);
>   }

Yes, your suggestion looks good to me. I will try on similar lines
and send RFC V2.

In the current patch we had tried to limit the changes to single function.
With your suggestions the changes may spread across three files and
more cleaner way.

Thank you,

Regards,
Srinath.

>
> Bjorn
>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 7904d02..6c5744e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1345,21 +1345,39 @@ static void pci_enable_bridge(struct pci_dev *dev)
>>  {
>>       struct pci_dev *bridge;
>>       int retval;
>> +     int err;
>> +     int i;
>> +     unsigned int bars = 0;
>> +     unsigned long flags = IORESOURCE_MEM | IORESOURCE_IO;
>>
>>       bridge = pci_upstream_bridge(dev);
>>       if (bridge)
>>               pci_enable_bridge(bridge);
>>
>> -     if (pci_is_enabled(dev)) {
>> -             if (!dev->is_busmaster)
>> -                     pci_set_master(dev);
>> +     if (dev->pm_cap) {
>> +             u16 pmcsr;
>> +
>> +             pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>> +             dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
>> +     }
>> +
>> +     if (atomic_inc_return(&dev->enable_cnt) > 1)
>> +             return;         /* already enabled */
>> +
>> +     /* only skip sriov related */
>> +     for (i = 0; i <= PCI_ROM_RESOURCE; i++)
>> +             if (dev->resource[i].flags & flags)
>> +                     bars |= (1 << i);
>> +     for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++)
>> +             if (dev->resource[i].flags & flags)
>> +                     bars |= (1 << i);
>> +
>> +     err = do_pci_enable_device(dev, bars);
>> +     if (err < 0) {
>> +             atomic_dec(&dev->enable_cnt);
>>               return;
>>       }
>>
>> -     retval = pci_enable_device(dev);
>> -     if (retval)
>> -             dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
>> -                     retval);
>>       pci_set_master(dev);
>>  }
>>
>> --
>> 2.7.4
>>
