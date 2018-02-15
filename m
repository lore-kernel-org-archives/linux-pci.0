Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com>
 <20180214161635.GA13849@e107981-ln.cambridge.arm.com>
 <65185a4d-c712-4486-d713-3fa9de14e35d@huawei.com>
 <e3fb78b3-5f5c-fe96-9f02-e96092963c17@huawei.com>
 <CAJZ5v0jGvo+cutmvi3WSe1JNvQ1UvZhJr1mQ76=8=1E5Gq+iRg@mail.gmail.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <4c81ecec-b3be-6b57-938a-b7d11ca7ee96@huawei.com>
Date: Thu, 15 Feb 2018 12:59:36 +0000
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jGvo+cutmvi3WSe1JNvQ1UvZhJr1mQ76=8=1E5Gq+iRg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15/02/2018 11:47, Rafael J. Wysocki wrote:
> On Thu, Feb 15, 2018 at 12:19 PM, John Garry <john.garry@huawei.com> wrote:
>>> Nothing apart from only being used by arm64 platforms today, which is
>>> circumstantial.
>>>
>>>>
>>>> I understand you need to find a place to add the:
>>>>
>>>> acpi_indirect_io_scan_init()
>>>>
>>>> to be called from core ACPI code because ACPI can't handle probe
>>>> dependencies in any other way but other than that this patch is
>>>> a Hisilicon ACPI driver - there is nothing generic in it (or at
>>>> least there are no standard bindings to make it so).
>>>>
>>>> Whether a callback from ACPI core code (acpi_scan_init()) to a driver
>>>> specific hook is sane or not that's the question and the only reason
>>>> why you want to add this in drivers/acpi/arm64 rather than, say,
>>>> drivers/bus (as you do for the DT driver).
>>>>
>>>> I do not know Rafael's opinion on the above, I would like to help
>>>> you make forward progress but please understand my concerns, mostly
>>>> on FW side.
>>>>
>>>
>>> I did mention an alternative in my "ping" in v12 patch 7/9 (Feb 1), but
>>> no response to this specific note so I kept on the same path.
>>>
>>> Here's what I then wrote:
>>> "I think another solution - which you may prefer - is to avoid adding
>>> this scan handler (and all this other scan code) and add a check like
>>> acpi_is_serial_bus_slave() [which checks the device parent versus a list
>>> of known indirectIO hosts] to not enumerate these children, and do it
>>> from the LLDD host probe instead (https://lkml.org/lkml/2017/6/16/250)"
>>>
>>
>> Hi Rafael, Lorenzo,
>>
>> I can avoid adding the scan handler in acpi_indirectio.c by skipping the
>> child enumeration, like with this change in scan.c:
>>

Hi Rafael,

>> +static const struct acpi_device_id indirect_io_hosts[] = {
>> +    {"HISI0191", 0},    /* HiSilicon LPC host */
>> +    {},
>> +};
>> +
>> +static bool acpi_is_indirect_io_slave(struct acpi_device *device)
>> +{
>
> Why don't you put the table definition here?
>

I can do.

>> +    struct acpi_device *parent = dev->parent;
>> +
>> +    if (!parent || acpi_match_device_ids(parent, indirect_io_hosts))
>> +        return false;
>> +
>> +    return true;
>
> return parent && !acpi_match_device_ids(parent, indirect_io_hosts);

Fine, a bit more concise

>
>> +}
>> +
>>  static bool acpi_is_serial_bus_slave(struct acpi_device *device)
>>  {
>>      struct list_head resource_list;
>>      bool is_serial_bus_slave = false;
>>
>> +    if (acpi_is_indirect_io_slave(device))
>> +        return true;
>> +
>>      /* Macs use device properties in lieu of _CRS resources */
>>
>>
>> This means I can move all this scan code into the LLDD.
>>
>> What do you think? Please let me know.
>
> If Lorenzo agrees, that will be fine by me modulo the above remarks.
>
> .

I see Lorenzo also finds this ok, so I'll go with that.

Thanks to all,
John

>
