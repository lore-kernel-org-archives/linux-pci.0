Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [PATCH V6 1/2] PCI/ACPI: Provide acpi_get_rc_resources() for
 ARM64 platform
To: Tomasz Nowicki <tn@semihalf.com>, <helgaas@kernel.org>, <arnd@arndb.de>,
        <rafael@kernel.org>, <Lorenzo.Pieralisi@arm.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
References: <1479816529-97410-1-git-send-email-liudongdong3@huawei.com>
 <1479816529-97410-2-git-send-email-liudongdong3@huawei.com>
 <56c1d551-a18d-8ee0-eb3c-b2b7d5341161@semihalf.com>
 <7c6b49b1-fa79-d0b0-180e-25a342350245@huawei.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <hanjun.guo@linaro.org>, <charles.chenxin@huawei.com>,
        <jcm@redhat.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <ecb0524d-9f75-6fa1-5533-565997d9399a@huawei.com>
Date: Wed, 23 Nov 2016 10:24:21 +0800
MIME-Version: 1.0
In-Reply-To: <7c6b49b1-fa79-d0b0-180e-25a342350245@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz

在 2016/11/23 9:44, Dongdong Liu 写道:
> Hi Tomasz
>
> 在 2016/11/22 20:32, Tomasz Nowicki 写道:
>> Hi Dongdong,
>>
>> On 22.11.2016 13:08, Dongdong Liu wrote:
>>> The acpi_get_rc_resources() is used to get the RC register address that can
>>> not be described in MCFG. It takes the _HID&segment to look for and returns
>>> the RC address resource. Use PNP0C02 devices to describe such RC address
>>> resource. Use _UID to match segment to tell which root bus the PNP0C02
>>> resource belong to.
>>>
>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>> ---
>>>  drivers/pci/pci-acpi.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  drivers/pci/pci.h      |  4 +++
>>>  2 files changed, 73 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>> index d966d47..76fd6f4 100644
>>> --- a/drivers/pci/pci-acpi.c
>>> +++ b/drivers/pci/pci-acpi.c
>>> @@ -29,6 +29,75 @@
>>>      0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
>>>  };
>>>
>>> +#ifdef CONFIG_ARM64
>>> +static struct resource *acpi_get_rc_addr(struct acpi_device *adev)
>>> +{
>>> +    struct resource_entry *entry;
>>> +    struct list_head list;
>>> +    unsigned long flags;
>>> +    int ret;
>>> +    struct resource *res;
>>> +
>>> +    INIT_LIST_HEAD(&list);
>>> +    flags = IORESOURCE_MEM;
>>> +    ret = acpi_dev_get_resources(adev, &list,
>>> +                     acpi_dev_filter_resource_type_cb,
>>> +                     (void *) flags);
>>> +    if (ret <= 0)
>>> +        return NULL;
>>> +
>>> +    entry = list_first_entry(&list, struct resource_entry, node);
>>> +    res = entry->res;
>>
>> You return "res" memory pointer and...
>>
>>> +    acpi_dev_free_resource_list(&list);
>>
>> free it here.
>
>  acpi_dev_free_resource_list
>     --->resource_list_free
>         --->resource_list_destroy_entry
>             --->resource_list_free_entry
>                 --->kfree(entry)
> only free entry not free entry->res, so this is ok.

Sorry I am wrong, ignore this.
>
> Thanks
> Dongdong
>>
>>> +    return res;
>>> +}
>>
>>
>> We either allocate memory for res here or get it from the caller.

Yes, you are right.I prefer to get if from the caller as PATCH V5 shows.

Thanks
Dongdong
>>
>> Tomasz
>>
>> .
>>
>
> _______________________________________________
> linuxarm mailing list
> linuxarm@huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
