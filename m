Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v16 0/9] LPC: legacy ISA I/O support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
 <1520335317.10722.416.camel@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <frowand.list@gmail.com>, <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
Date: Tue, 6 Mar 2018 11:36:27 +0000
MIME-Version: 1.0
In-Reply-To: <1520335317.10722.416.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2018 11:21, Andy Shevchenko wrote:
> On Tue, 2018-03-06 at 18:47 +0800, John Garry wrote:
>> This patchset supports the IPMI-bt device attached to the Low-Pin-
>> Count
>> interface implemented on Hisilicon Hip06/Hip07 SoC.
>>                         -----------
>>                         | LPC host|
>>                         |         |
>>                         -----------
>>                              |
>>                 _____________V_______________LPC
>>                   |                       |
>>                   V                       V
>>                                      ------------
>>                                      |  BT(ipmi)|
>>                                      ------------
>>
>> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a
>> specific
>> LPC driver is needed to make LPC host generate the standard LPC I/O
>> cycles with
>> the target peripherals'I/O port addresses. But on curent arm64 world,
>> there is
>> no real I/O accesses. All the I/O operations through in/out accessors
>> are based
>> on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed
>> through driver
>> specific accessors rather than MMIO.
>> To solve this issue and keep the relevant existing peripherals'
>> drivers untouched,
>> this patchset:
>>    - introduces a generic I/O space management framework, logical PIO,
>> to support
>>       I/O operations on host controllers operating either on MMIO
>> buses or on buses
>>      requiring specific driver I/O accessors;
>>    - redefines the in/out accessors to provide a unified interface for
>> both MMIO
>>      and driver specific I/O operations. Using logical PIO, th call of
>> in/out() from
>>      the host children drivers, such as ipmi-si, will be redirected to
>> the
>>      corresponding device-specific I/O hooks to perform the I/O
>> accesses.
>>
>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
>> peripherals can
>> be supported without any changes on the existing ipmi-si driver.
>>
>> The whole patchset has been tested on Hip07 D05 board both using DTB
>> and ACPI.
>>
>
>> V15 thread here: https://lkml.org/lkml/2018/2/26/584
>
> Thanks for an update.
> Though I answered to previous thread.
>
> Summary: I'm fine with the series as long as maintainers are fine
> (Rafael et al.). On personal side I think that the handler approach is
> better. Details are in v15 thread.

Hi Andy,

Thanks for your input and continued support. As I mentioned in reply in 
v15, the handler support would (or has) faced issues. And Rafael seems 
fine with deferring the probe to the LLDD in Patch #7/9

Anyway, let's wait for any more input.

Much appreciated,
John

>


