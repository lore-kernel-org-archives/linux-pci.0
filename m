Return-Path: <SRS0=tCss=5Y=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=tCss=5Y=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170615222729.GJ12735@bhelgaas-glaptop.roam.corp.google.com>
References: <1496135297-19680-1-git-send-email-srinath.mannam@broadcom.com> <20170615222729.GJ12735@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Mon, 19 Jun 2017 22:32:11 +0530
Message-ID: <CABe79T7Y2G8F2vwNXuy_T8j5R+PvyF9+UkVC6ezabYwPqucn6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] pci: Concurrency issue in NVMe Init through PCIe switch
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thank you for the feedback.

On Fri, Jun 16, 2017 at 3:57 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Srinath,
>
> On Tue, May 30, 2017 at 02:38:17PM +0530, Srinath Mannam wrote:
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
>
> Let's refine the changelog a little bit by removing details that
> aren't pertinent.  The fact that this happens with NVMe on ARMv8 is
> irrelevant.  It could happen on any SMP system.  The critical thing is
> that drivers for two devices, both below the same disabled bridge,
> called pci_enable_device() about the same time, and both tried to
> enable the bridge simultaneously.
>
I will modify the changelog as generic.

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
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> ---
>> Changes since v1:
>>  - Used mutex to syncronize pci_enable_bridge
>>
>>  drivers/pci/pci.c   | 4 ++++
>>  drivers/pci/probe.c | 1 +
>>  include/linux/pci.h | 1 +
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b01bd5b..5bff3e7 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1347,7 +1347,9 @@ static void pci_enable_bridge(struct pci_dev *dev)
>>  {
>>       struct pci_dev *bridge;
>>       int retval;
>> +     struct mutex *lock = &dev->bridge_lock;
>>
>> +     mutex_lock(lock);
>
> I don't think it's necessary to hold the lock until we call
> pci_set_master() or pci_enable_device(), is it?  E.g., we shouldn't
> need to hold the lock for "dev" while we call pci_enable_bridge() for
> its upstream bridge.
We see the issue because of pci_set_master() and pci_enable_device()
are not syncronous. So we must take the lock for both pci_set_master() and
pci_enable_device(). As per your suggestion given in previous patch to avoid
concurrency using mutex in the struct pci_host_bridge causes dead lock,
because pci_enable_device_flags is calling recursively through pci_host_bridge.
So I have taken separate lock for each pcie bridge. In the case of common bridge
enable only this bridge lock will be taken by more than one CPUs.

We can take lock after pci_enable_bridge function call also.

             [BR0] (Host bridge)
                 |
              [BR1]
                 |
              [BR2]
                |
       -----------------
      |                    |
  [BR3]               [BR4]
     |                     |
  [DEV1]           [DEV2]

In the above case, lock tried by both cpus only at BR2, BR1 and BR0 because
they are common for both the devices. If we take the lock before
pci_enable_bridge
one CPU say CPU0 get the lock and CPU1 is waiting until first CPU completes
all the pci_set_master() and pci_enable_device() completed for all the remaining
common bridges.
If we take lock after pci_enable_bridge both CPUs traverse until BR0.
one CPU say
CPU0 get the lock CPU1 wait for the lock until bridge initialization completes.
after bridge enable both CPUs return back to pci_enable_bridge function
to enable BR1, then CPU0 will take the lock CPU1 will wait and both CPUs
return to BR2 then CPU0 will take the lock and CPU1 will wait for the lock.
this case little CPU1 execution is more except everything is fine.

>
>>       bridge = pci_upstream_bridge(dev);
>>       if (bridge)
>>               pci_enable_bridge(bridge);
>> @@ -1355,6 +1357,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
>>       if (pci_is_enabled(dev)) {
>>               if (!dev->is_busmaster)
>>                       pci_set_master(dev);
>> +             mutex_unlock(lock);
>
> It's not a big deal either way, but I probably would write this with a
> single unlock at the end and a goto here.
I will add goto here.
>
>>               return;
>>       }
>>
>> @@ -1363,6 +1366,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
>>               dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
>>                       retval);
>>       pci_set_master(dev);
>> +     mutex_unlock(lock);
>>  }
>>
>>  static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 19c8950..1c25d1c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -880,6 +880,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>>       child->dev.parent = child->bridge;
>>       pci_set_bus_of_node(child);
>>       pci_set_bus_speed(child);
>> +     mutex_init(&bridge->bridge_lock);
>>
>>       /* Set up default resource pointers and names.. */
>>       for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 33c2b0b..7e88f41 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -266,6 +266,7 @@ struct pci_dev {
>>       void            *sysdata;       /* hook for sys-specific extension */
>>       struct proc_dir_entry *procent; /* device entry in /proc/bus/pci */
>>       struct pci_slot *slot;          /* Physical slot this device is in */
>> +     struct mutex bridge_lock;
>
> I don't really like adding a per-device lock just for this unusual
> case.  Can you use the existing device_lock() instead?
>
Yes using device_lock is good idea.
with this lock we don't have issues of nexted locking in this context.
I will update the code.

>>       unsigned int    devfn;          /* encoded device & function index */
>>       unsigned short  vendor;
>> --
>> 2.7.4
>>

Regards,
srinath
