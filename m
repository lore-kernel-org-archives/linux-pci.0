Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0a30452f-34eb-d0b5-2001-ab6b866c53e2@huawei.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
 <1516725385-24535-8-git-send-email-john.garry@huawei.com> <0a30452f-34eb-d0b5-2001-ab6b866c53e2@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Feb 2018 15:16:03 +0200
Message-ID: <CAHp75VfXoAHNH2BnfNLbFfdCqUk3rxU_QWfxTx7ZyLgV0qxotQ@mail.gmail.com>
Subject: Re: [PATCH v12 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: John Garry <john.garry@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Hanjun Guo <hanjun.guo@linaro.org>, dann.frazier@canonical.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, linux-pci@vger.kernel.org,
        Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 1, 2018 at 1:32 PM, John Garry <john.garry@huawei.com> wrote:


I'm not going through all patch, by one thing I would like you to pay
attention on, i.e.
printing resource_size_t and struct resource

>> +               dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
>> +                       resource->start);

resource_size_t is dynamic width type, you will see a compiler
warning. For this we have
%pap specifier.

Moreover, in some cases it's useful to print struct resource via %pR or %pr.

Consider reading kernel documentation about these (printk-formats.rst).

>> +struct acpi_indirectio_host_data {
>> +       resource_size_t io_size;
>> +       resource_size_t io_start;
>> +};

Why not utilize struct resource?

If it's coming from platform / firmware it should *never* have types
like size_t, unsigned long, resource_size_t, etc.

>> +/* All the host devices which apply indirect-IO can be listed here. */
>> +static const struct acpi_device_id acpi_indirect_host_id[] = {
>> +       {""},
>> +};

The idea of terminator is to be such (remove comma there). And it's
basically redundant to have an empty string there. Moreover, it's a
waste of resources in ro section.

-- 
With Best Regards,
Andy Shevchenko
