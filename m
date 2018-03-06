Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:43539 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeCFPaF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 10:30:05 -0500
MIME-Version: 1.0
In-Reply-To: <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
 <1520335317.10722.416.camel@linux.intel.com> <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Mar 2018 16:30:03 +0100
Message-ID: <CAJZ5v0gnf6rDYtKLBNfKjC=g3W=2XUed_R=AO+GeGYuubP_zWw@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] LPC: legacy ISA I/O support
To: John Garry <john.garry@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2018 at 12:36 PM, John Garry <john.garry@huawei.com> wrote:
> On 06/03/2018 11:21, Andy Shevchenko wrote:
>>
>> On Tue, 2018-03-06 at 18:47 +0800, John Garry wrote:
>>>
>>> This patchset supports the IPMI-bt device attached to the Low-Pin-
>>> Count
>>> interface implemented on Hisilicon Hip06/Hip07 SoC.
>>>                         -----------
>>>                         | LPC host|
>>>                         |         |
>>>                         -----------
>>>                              |
>>>                 _____________V_______________LPC
>>>                   |                       |
>>>                   V                       V
>>>                                      ------------
>>>                                      |  BT(ipmi)|
>>>                                      ------------
>>>
>>> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a
>>> specific
>>> LPC driver is needed to make LPC host generate the standard LPC I/O
>>> cycles with
>>> the target peripherals'I/O port addresses. But on curent arm64 world,
>>> there is
>>> no real I/O accesses. All the I/O operations through in/out accessors
>>> are based
>>> on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed
>>> through driver
>>> specific accessors rather than MMIO.
>>> To solve this issue and keep the relevant existing peripherals'
>>> drivers untouched,
>>> this patchset:
>>>    - introduces a generic I/O space management framework, logical PIO,
>>> to support
>>>       I/O operations on host controllers operating either on MMIO
>>> buses or on buses
>>>      requiring specific driver I/O accessors;
>>>    - redefines the in/out accessors to provide a unified interface for
>>> both MMIO
>>>      and driver specific I/O operations. Using logical PIO, th call of
>>> in/out() from
>>>      the host children drivers, such as ipmi-si, will be redirected to
>>> the
>>>      corresponding device-specific I/O hooks to perform the I/O
>>> accesses.
>>>
>>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
>>> peripherals can
>>> be supported without any changes on the existing ipmi-si driver.
>>>
>>> The whole patchset has been tested on Hip07 D05 board both using DTB
>>> and ACPI.
>>>
>>
>>> V15 thread here: https://lkml.org/lkml/2018/2/26/584
>>
>>
>> Thanks for an update.
>> Though I answered to previous thread.
>>
>> Summary: I'm fine with the series as long as maintainers are fine
>> (Rafael et al.). On personal side I think that the handler approach is
>> better. Details are in v15 thread.
>
>
> Hi Andy,
>
> Thanks for your input and continued support. As I mentioned in reply in v15,
> the handler support would (or has) faced issues. And Rafael seems fine with
> deferring the probe to the LLDD in Patch #7/9

Well, the only sort-of concern is that these devices may not be
"serial bus slaves" in general, so the naming is slightly confusing.

But overall this approach and the one based on a scan handler both
boil down to checking a (list of) device ID(s) and doing something
special in case of a match.
