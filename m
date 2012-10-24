Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <50879BFC.1070202@cn.fujitsu.com>
Date: Wed, 24 Oct 2012 15:42:52 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
CC: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	mihailm@parallels.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Use kacpi_hotplug_wq to handle container hotplug
 event.
References: <1351058750-4275-1-git-send-email-tangchen@cn.fujitsu.com> <1351058750-4275-2-git-send-email-tangchen@cn.fujitsu.com> <508790AC.5080001@jp.fujitsu.com>
In-Reply-To: <508790AC.5080001@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ishimatsu-san:

By the way, if you want to reproduce this problem, just
modify my patch1 to call __container_notify_cb() directly
in container_notify_cb(). And apply my patch2.

Then, you add a container, and remove it.
The deadlock will be triggered.

And this patch is based on Lu Yinghai's tree:
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-split-pci-root-hp-2


On 10/24/2012 02:54 PM, Yasuaki Ishimatsu wrote:
> Hi Tang,
> 
> 2012/10/24 15:05, Tang Chen wrote:
>> As the comments in __acpi_os_execute() said:
>>
>> 	We can't run hotplug code in keventd_wq/kacpid_wq/kacpid_notify_wq
>> 	because the hotplug code may call driver .remove() functions,
>> 	which invoke flush_scheduled_work/acpi_os_wait_events_complete
>> 	to flush these workqueues.
>>
>> we should keep the hotplug code in kacpi_hotplug_wq.
>>
>> But we have the following call series in kernel now:
>> 	acpi_ev_queue_notify_request()
>> 	|-->  acpi_os_execute()
>> 	     |-->  __acpi_os_execute(type, function, context, 0)
>>
>> The last parameter 0 makes the container_notify_cb() executed in
>> kacpi_notify_wq or kacpid_wq. So, we need to put the real hotplug code
>> into kacpi_hotplug_wq.
> 
> I cannot understand the purpose of the patch.
> Is the patch a bug fix patch? If yes, what problem happens?
> 
> Thanks,
> Yasuaki Ishimatsu
> 
>>
>> Signed-off-by: Tang Chen<tangchen@cn.fujitsu.com>
>> ---
>>    drivers/acpi/container.c |   17 ++++++++++++++++-
>>    1 files changed, 16 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
>> index 69e2d6b..d300e03 100644
>> --- a/drivers/acpi/container.c
>> +++ b/drivers/acpi/container.c
>> @@ -35,6 +35,7 @@
>>    #include<acpi/acpi_bus.h>
>>    #include<acpi/acpi_drivers.h>
>>    #include<acpi/container.h>
>> +#include<acpi/acpiosxf.h>
>>
>>    #define PREFIX "ACPI: "
>>
>> @@ -165,14 +166,21 @@ static int container_device_add(struct acpi_device **device, acpi_handle handle)
>>    	return result;
>>    }
>>
>> -static void container_notify_cb(acpi_handle handle, u32 type, void *context)
>> +static void __container_notify_cb(struct work_struct *work)
>>    {
>>    	struct acpi_device *device = NULL;
>>    	int result;
>>    	int present;
>>    	acpi_status status;
>> +	struct acpi_hp_work *hp_work;
>> +	acpi_handle handle;
>> +	u32 type;
>>    	u32 ost_code = ACPI_OST_SC_NON_SPECIFIC_FAILURE; /* default */
>>
>> +	hp_work = container_of(work, struct acpi_hp_work, work);
>> +	handle = hp_work->handle;
>> +	type = hp_work->type;
>> +
>>    	switch (type) {
>>    	case ACPI_NOTIFY_BUS_CHECK:
>>    		/* Fall through */
>> @@ -224,6 +232,13 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
>>    	return;
>>    }
>>
>> +static void container_notify_cb(acpi_handle handle, u32 type,
>> +				void *context)
>> +{
>> +	alloc_acpi_hp_work(handle, type, context,
>> +			   __container_notify_cb);
>> +}
>> +
>>    static acpi_status
>>    container_walk_namespace_cb(acpi_handle handle,
>>    			    u32 lvl, void *context, void **rv)
>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

