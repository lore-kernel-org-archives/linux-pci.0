Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5088967E.3060204@cn.fujitsu.com>
Date: Thu, 25 Oct 2012 09:31:42 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Toshi Kani <toshi.kani@hp.com>
CC: yinghai@kernel.org, bhelgaas@google.com, lenb@kernel.org,
	jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, mihailm@parallels.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Improve container_notify_cb() to support container
 hot-remove.
References: <1351058750-4275-1-git-send-email-tangchen@cn.fujitsu.com>  <1351058750-4275-3-git-send-email-tangchen@cn.fujitsu.com> <1351098875.19172.21.camel@misato.fc.hp.com>
In-Reply-To: <1351098875.19172.21.camel@misato.fc.hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Toshi,

On 10/25/2012 01:14 AM, Toshi Kani wrote:
> On Wed, 2012-10-24 at 14:05 +0800, Tang Chen wrote:
>> +static int container_device_remove(struct acpi_device *device)
>> +{
>> +	int ret;
>> +	struct acpi_eject_event *ej_event;
>> +
>> +	/* stop container device at first */
>> +	ret = acpi_bus_trim(device, 0);
>
> Hi Tang,
>
> Why do you need to call acpi_bus_trim(device,0) to stop the container
> device first?

This issue was introduced by Lu Yinghai, I think he could give a better
answer than me. :)
Please refer to the following url:

http://www.spinics.net/lists/linux-pci/msg17667.html

However, this is not applied into the pci tree yet.

>
>> +	printk(KERN_WARNING "acpi_bus_trim stop return %x\n", ret);
>
> Do you need this message in the normal case?  If so, I'd suggest to use
> pr_debug().
>
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* event originated from ACPI eject notification */
>> +	device->flags.eject_pending = 1;
>
> You do not need to set the eject_pending flag when the handler calls
> acpi_bus_hot_remove_device().  It was set before because the handler did
> not initiate the hot-remove operation.

I just set it to keep the logic the same as before.
And thanks for telling me this. :)

>
...
>> +		printk(KERN_WARNING "Container driver received %s event\n",
>> +			"ACPI_NOTIFY_EJECT_REQUEST");
>
> Same as other comment.  Suggest to use pr_debug().

OK. :)

>
>> +
>> +		if (!present || ACPI_FAILURE(status) || !device)
>> +			break;
>> +
>> +		result = container_device_remove(device);
>> +		if (result) {
>> +			printk(KERN_WARNING "Failed to remove container\n");
>
> Please use pr_warn().
>
> Thanks,
> -Toshi
>
>> +			break;
>>   		}
>> -		break;
>> +
>> +		return;
>>
>>   	default:
>>   		/* non-hotplug event; possibly handled by other handler */
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

