Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH v16 0/9] LPC: legacy ISA I/O support
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
 <1520335317.10722.416.camel@linux.intel.com>
 <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
 <CAJZ5v0gnf6rDYtKLBNfKjC=g3W=2XUed_R=AO+GeGYuubP_zWw@mail.gmail.com>
 <3ef757ff-8430-017f-59d3-ff67f49f5a80@huawei.com>
 <CAJZ5v0jTJ-LwyPUO7mbS47KyZ35pZeBfqkjxqubZjEGC=OJ82Q@mail.gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Hanjun Guo" <hanjun.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alexander Graf <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <fb457950-b0d7-0d77-02c5-f9531ea71d90@huawei.com>
Date: Tue, 13 Mar 2018 10:42:22 +0000
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jTJ-LwyPUO7mbS47KyZ35pZeBfqkjxqubZjEGC=OJ82Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/03/2018 10:22, Rafael J. Wysocki wrote:
> On Tue, Mar 6, 2018 at 5:22 PM, John Garry <john.garry@huawei.com> wrote:
>>>>>>
>>>>>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
>>>>>> peripherals can
>>>>>> be supported without any changes on the existing ipmi-si driver.
>>>>>>
>>>>>> The whole patchset has been tested on Hip07 D05 board both using DTB
>>>>>> and ACPI.
>>>>>>
>>>>>
>>>>>> V15 thread here: https://lkml.org/lkml/2018/2/26/584
>>>>>
>>>>>
>>>>>
>>>>> Thanks for an update.
>>>>> Though I answered to previous thread.
>>>>>
>>>>> Summary: I'm fine with the series as long as maintainers are fine
>>>>> (Rafael et al.). On personal side I think that the handler approach is
>>>>> better. Details are in v15 thread.
>>>>
>>>>
>>>>
>>>> Hi Andy,
>>>>
>>>> Thanks for your input and continued support. As I mentioned in reply in
>>>> v15,
>>>> the handler support would (or has) faced issues. And Rafael seems fine
>>>> with
>>>> deferring the probe to the LLDD in Patch #7/9
>>>
>>>
>>
>> Hi Rafael,
>>
>>> Well, the only sort-of concern is that these devices may not be
>>> "serial bus slaves" in general, so the naming is slightly confusing.
>>>
>>
>> Right, the name.
>>
>> The key point is that we model the bus the same as other serial buses like
>> I2C or SPI, so require the same treatment from the ACPI scan.
>>
>> Would you prefer acpi_is_serial_bus_slave() and
>> acpi_device_flags.serial_bus_slave symbols be modified also?
>
> Yeah, preferably.
>
> You can rename them to acpi_device_enumeration_by_parent() and
> acpi_device_flags.enumeration_by_parent, respectively, as far as I'm
> concerned.
>
> At least the names would match the purpose then. :-)
>
> And please update the comment in acpi_default_enumeration() while at it.

Hi Rafael,

That should be ok. I can just add this mentioned modification to my 
series and send for review.

All the best,
John

>
> .
>
