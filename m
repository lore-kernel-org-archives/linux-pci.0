Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752924AbeBEOZv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Feb 2018 09:25:51 -0500
Subject: Re: [PATCH v12 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
 <1516725385-24535-8-git-send-email-john.garry@huawei.com>
 <0a30452f-34eb-d0b5-2001-ab6b866c53e2@huawei.com>
 <CAHp75VfXoAHNH2BnfNLbFfdCqUk3rxU_QWfxTx7ZyLgV0qxotQ@mail.gmail.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        <dann.frazier@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, <linux-pci@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <62634aa6-ad3c-93c2-e6fa-9e163d4004ca@huawei.com>
Date: Mon, 5 Feb 2018 14:25:20 +0000
MIME-Version: 1.0
In-Reply-To: <CAHp75VfXoAHNH2BnfNLbFfdCqUk3rxU_QWfxTx7ZyLgV0qxotQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/02/2018 13:16, Andy Shevchenko wrote:
> On Thu, Feb 1, 2018 at 1:32 PM, John Garry <john.garry@huawei.com> wrote:
>
>

Hi Andy,

> I'm not going through all patch, by one thing I would like you to pay
> attention on, i.e.
> printing resource_size_t and struct resource
>
>>> +               dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
>>> +                       resource->start);
>
> resource_size_t is dynamic width type, you will see a compiler
> warning. For this we have
> %pap specifier.
>
> Moreover, in some cases it's useful to print struct resource via %pR or %pr.

I have already fixed this up in my rework.

>
> Consider reading kernel documentation about these (printk-formats.rst).
>
>>> +struct acpi_indirectio_host_data {
>>> +       resource_size_t io_size;
>>> +       resource_size_t io_start;
>>> +};
>
> Why not utilize struct resource?
>
> If it's coming from platform / firmware it should *never* have types
> like size_t, unsigned long, resource_size_t, etc.

This is not coming from firmware, but it is a struct which we define in 
the kernel per host, describing that host bus address range for translation.

In fact, generally io_start is 0 and the io_size would be 
PIO_INDIRECT_SIZE, so I'll consider removing it for now.

>
>>> +/* All the host devices which apply indirect-IO can be listed here. */
>>> +static const struct acpi_device_id acpi_indirect_host_id[] = {
>>> +       {""},
>>> +};
>
> The idea of terminator is to be such (remove comma there). And it's
> basically redundant to have an empty string there. Moreover, it's a
> waste of resources in ro section.

OK, the comma should be removed. So what is the preferred acpi device id 
array sentinel? I see {}, {"", 0}, and {""} used.

>

thank you,
John
