Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <62634aa6-ad3c-93c2-e6fa-9e163d4004ca@huawei.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
 <1516725385-24535-8-git-send-email-john.garry@huawei.com> <0a30452f-34eb-d0b5-2001-ab6b866c53e2@huawei.com>
 <CAHp75VfXoAHNH2BnfNLbFfdCqUk3rxU_QWfxTx7ZyLgV0qxotQ@mail.gmail.com> <62634aa6-ad3c-93c2-e6fa-9e163d4004ca@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2018 21:44:35 +0200
Message-ID: <CAHp75VdTKCq5Vxox2OPvr+BvVSduhaxs_sa7B9wskzjv8ZJLqw@mail.gmail.com>
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
        Hanjun Guo <hanjun.guo@linaro.org>,
        Dann Frazier <dann.frazier@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, linux-pci@vger.kernel.org,
        Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 5, 2018 at 4:25 PM, John Garry <john.garry@huawei.com> wrote:
> On 05/02/2018 13:16, Andy Shevchenko wrote:
>> On Thu, Feb 1, 2018 at 1:32 PM, John Garry <john.garry@huawei.com> wrote:

>> resource_size_t is dynamic width type, you will see a compiler
>> warning. For this we have
>> %pap specifier.
>>
>> Moreover, in some cases it's useful to print struct resource via %pR or
>> %pr.

> I have already fixed this up in my rework.

Good!

>>>> +/* All the host devices which apply indirect-IO can be listed here. */
>>>> +static const struct acpi_device_id acpi_indirect_host_id[] = {
>>>> +       {""},
>>>> +};
>>
>>
>> The idea of terminator is to be such (remove comma there). And it's
>> basically redundant to have an empty string there. Moreover, it's a
>> waste of resources in ro section.
>
>
> OK, the comma should be removed. So what is the preferred acpi device id
> array sentinel? I see {}, {"", 0}, and {""} used.

The rule of thumb --- whatever has more entries in the kernel.
In case of similarity I would prefer simple {} because it suits for
termination slightly better (for my opinion, some cases might
potentially have {"", non_null_vakue}).

-- 
With Best Regards,
Andy Shevchenko
