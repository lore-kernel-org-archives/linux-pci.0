Return-Path: <SRS0=VSpI=FY=apm.com=fkan@kernel.org>
Return-Path: <SRS0=VSpI=FY=apm.com=fkan@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180302192110.GA202062@bhelgaas-glaptop.roam.corp.google.com>
References: <1519942514-3350-1-git-send-email-fkan@apm.com> <20180302192110.GA202062@bhelgaas-glaptop.roam.corp.google.com>
From: Feng Kan <fkan@apm.com>
Date: Fri, 2 Mar 2018 14:32:23 -0800
Message-ID: <CAL85gmBOXvdSbRTrbu4TO26msn7RBABRqdLR-198W19w2TzUUw@mail.gmail.com>
Subject: Re: [PATCH V2] PM / core: fix deferred probe breaking suspend resume order
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org,
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toanle@apm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 2, 2018 at 11:21 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Mar 01, 2018 at 02:15:14PM -0800, Feng Kan wrote:
>> When bridge and its endpoint is enumerated the devices are added to the
>> dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
>> This causes the bridge to be moved to the end of the dpm list when
>> deferred probe kicks in. The order of the dpm list for bridge and
>> endpoint is reversed.
>
> I'm not very familiar with PM, so can you connect some of the dots
> here for me?
>
> When you say "the bridge defers probe when IOMMU is not ready", are
> you talking about pcie_portdrv_probe() claiming a PCIe port?
This is at driver_probe_device. Since the CCA attribute is set to 1 in the ACPI
table, the driver attempts a dma_configure. This is where it fails.
>
> How does this connect with the IOMMU?  Where do we figure out that the
> IOMMU is not ready?
The dma_configure attempts to do an iort_iommu_xlate which cause the
probe to defer. The iort_iommu_xlate fails because the IOMMU driver has not
been probe yet.
        /*
         * If the ops look-up fails, this means that either
         * the SMMU drivers have not been probed yet or that
         * the SMMU drivers are not built in the kernel;
         * Depending on whether the SMMU drivers are built-in
         * in the kernel or not, defer the IOMMU configuration
         * or just abort it.
         */
        ops = iommu_ops_from_fwnode(iort_fwnode);
        if (!ops)
                return iort_iommu_driver_enabled(node->type) ?
                       -EPROBE_DEFER : -ENODEV;
>
>> Add reordering code to move the bridge and its children and consumers to
>> the end of the pm list so the order for suspend and resume is not altered.
>> The code also move device and its children and consumers to the tail of
>> device_kset list if it is registered.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Toan Le <toanle@apm.com>
>> ---
>>  V2:
>>       1. change patch title from "move device and its children..."
>>       2. move define based on Bjorn's comment
>>       3. rename function name and comment content
>>  drivers/base/base.h |  3 +++
>>  drivers/base/core.c | 22 ++++++++++++++++++++++
>>  drivers/base/dd.c   |  8 ++++----
>>  3 files changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>> index d800de6..a75c302 100644
>> --- a/drivers/base/base.h
>> +++ b/drivers/base/base.h
>> @@ -161,3 +161,6 @@ static inline void module_remove_driver(struct device_driver *drv) { }
>>  extern void device_links_no_driver(struct device *dev);
>>  extern bool device_links_busy(struct device *dev);
>>  extern void device_links_unbind_consumers(struct device *dev);
>> +
>> +/* device pm support */
>> +void device_pm_move_to_tail(struct device *dev);
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 110230d..0a0756b 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -148,6 +148,28 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>>  }
>>
>>  /**
>> + * device_pm_move_to_tail - move device and its children and consumers to end of
>> + *                          pm and device kset list
>> + * @dev: current device pointer
>> + *
>> + * This is a lock held version of the device_reorder_to_tail. Function checks
>> + * if the device is registered and moves it to the end of device_kset list. Also
>> + * if the device is pm initialized, move the device to the end of the pm list.
>> + * Then the function iterate through the children and device link consumers to
>> + * do the same for each found.
>> + */
>> +void device_pm_move_to_tail(struct device *dev)
>> +{
>> +     int idx;
>> +
>> +     idx = device_links_read_lock();
>> +     device_pm_lock();
>> +     device_reorder_to_tail(dev, NULL);
>> +     device_pm_unlock();
>> +     device_links_read_unlock(idx);
>> +}
>> +
>> +/**
>>   * device_link_add - Create a link between two devices.
>>   * @consumer: Consumer end of the link.
>>   * @supplier: Supplier end of the link.
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 2c964f5..7e9d1ef 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -121,11 +121,11 @@ static void deferred_probe_work_func(struct work_struct *work)
>>                * Force the device to the end of the dpm_list since
>>                * the PM code assumes that the order we add things to
>>                * the list is a good order for suspend but deferred
>> -              * probe makes that very unsafe.
>> +              * probe makes that very unsafe. Move any children and
>> +              * consumers belong to the device to the end of the list.
>> +              * This way the suspend resume order won't be corrupted.
>>                */
>> -             device_pm_lock();
>> -             device_pm_move_last(dev);
>> -             device_pm_unlock();
>> +             device_pm_move_to_tail(dev);
>>
>>               dev_dbg(dev, "Retrying from deferred list\n");
>>               if (initcall_debug && !initcalls_done)
>> --
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
