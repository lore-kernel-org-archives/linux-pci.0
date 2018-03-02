Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gncVMpQCc=kvuSdyy-+zPrdYOiA=pA54d538zTDz6rEA@mail.gmail.com>
References: <1519942514-3350-1-git-send-email-fkan@apm.com>
 <CAJZ5v0gncVMpQCc=kvuSdyy-+zPrdYOiA=pA54d538zTDz6rEA@mail.gmail.com>
From: Feng Kan <fkan@apm.com>
Date: Fri, 2 Mar 2018 10:50:07 -0800
Message-ID: <CAL85gmCkNGqi9QjT60ybbMDOdJGsZrraGEK+8Js2AxKG6+8ZVQ@mail.gmail.com>
Subject: Re: [PATCH V2] PM / core: fix deferred probe breaking suspend resume
 order
To: "Rafael J. Wysocki" <rafael@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Toan Le <toanle@apm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 2, 2018 at 1:11 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> [+Greg]
>
> On Thu, Mar 1, 2018 at 11:15 PM, Feng Kan <fkan@apm.com> wrote:
>> When bridge and its endpoint is enumerated the devices are added to the
>> dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
>> This causes the bridge to be moved to the end of the dpm list when
>> deferred probe kicks in. The order of the dpm list for bridge and
>> endpoint is reversed.
>>
>> Add reordering code to move the bridge and its children and consumers to
>> the end of the pm list so the order for suspend and resume is not altered.
>> The code also move device and its children and consumers to the tail of
>> device_kset list if it is registered.
>
> I assume that this has been tested and works as expected.
Yes, we have tested it on our arm64 system with suspend on resume
cycles over night.
We wanted to test on x86, but it doesn't suffer the same problem since IOMMU
comes before the PCIe.

>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Toan Le <toanle@apm.com>
>> ---
>>  V2:
>>         1. change patch title from "move device and its children..."
>>         2. move define based on Bjorn's comment
>>         3. rename function name and comment content
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
>
> This has to be one line.  Maybe something like "Move set of devices to
> the end of device lists" and then describe how it works below.
>
>> + * @dev: current device pointer
>> + *
>> + * This is a lock held version of the device_reorder_to_tail.
>
> I'd say "This is a device_reorder_to_tail() wrapper taking the
> requisite locks." and put an empty comment line after that.
>
>> +  Function checks
>
> "It checks"
>
>> + * if the device is registered and moves it to the end of device_kset list. Also
>> + * if the device is pm initialized, move the device to the end of the pm list.
>> + * Then the function iterate through the children and device link consumers to
>> + * do the same for each found.
>
> But generally I'd say "It moves the device along with all of its
> children and all of its consumers to the ends of the device_kset and
> dpm_list lists, recursively".
>
>> + */
>> +void device_pm_move_to_tail(struct device *dev)
>> +{
>> +       int idx;
>> +
>> +       idx = device_links_read_lock();
>> +       device_pm_lock();
>> +       device_reorder_to_tail(dev, NULL);
>> +       device_pm_unlock();
>> +       device_links_read_unlock(idx);
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
>>                  * Force the device to the end of the dpm_list since
>>                  * the PM code assumes that the order we add things to
>>                  * the list is a good order for suspend but deferred
>> -                * probe makes that very unsafe.
>> +                * probe makes that very unsafe. Move any children and
>> +                * consumers belong to the device to the end of the list.
>> +                * This way the suspend resume order won't be corrupted.
>
> Why do you need to change this comment?
Will remove. Do you know other than this problem, what was the
original issue that is referred by the
comment "makes that very unsafe"?
>
>>                  */
>> -               device_pm_lock();
>> -               device_pm_move_last(dev);
>> -               device_pm_unlock();
>> +               device_pm_move_to_tail(dev);
>>
>>                 dev_dbg(dev, "Retrying from deferred list\n");
>>                 if (initcall_debug && !initcalls_done)
>> --
>> 1.8.3.1
>>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
