Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59e5293f-0ea5-12f4-27db-b13bbcf0918b@huawei.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com> <CAHp75Ve7C4AJYK6AC=o-jzw6b2p8c8GBRd70Zjv+vYWbfytufg@mail.gmail.com>
 <adfa2009-476b-8c25-c661-b0eeb48a6c43@huawei.com> <CAHp75VfOa5pN4MKT-aQmWBwPGWsOaQupyfrN-weWwfR3vMLtuA@mail.gmail.com>
 <59e5293f-0ea5-12f4-27db-b13bbcf0918b@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 16:42:34 +0200
Message-ID: <CAHp75VeTQg+A9o5Ox-k_9Qx8=JPEnqg1taVjcd8Zd2rfj_TMog@mail.gmail.com>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: John Garry <john.garry@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
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
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 15, 2018 at 7:07 PM, John Garry <john.garry@huawei.com> wrote:
> On 14/02/2018 16:16, Andy Shevchenko wrote:

>>>>> >>> +       list_for_each_entry(rentry, &resource_list, node)
>>>>> >>> +               resources[count++] = *rentry->res;
>>>>
>>>> >> It has similarities with acpi_create_platform_device().
>>>> >> I guess we can utilize existing code.
>>>
>>> > For sure, this particular segment is effectively same as part of
>>> > acpi_create_platform_device():
>>
>> Not the same, acpi_create_platform_device() does a bit more than
>> copying the resources. If it indeed makes no hurt...
>>
>>> >         list_for_each_entry(rentry, &resource_list, node)
>>> >             acpi_platform_fill_resource(adev, rentry->res,
>>> >                             &resources[count++]);
>>> > So is your idea to refactor this common segment into a helper function?
>>
>> ...I would go with helper.
>>
>
> Hi Andy,
>
> Since the plan now is that this code is no longer going to be added to
> drivers/acpi, but instead pushed to the LLDD, I am pondering whether we
> should still factor out of this common code. Opinion?

I would still go with a common helper. Though, as first step, we can
make it lazy, i.e. put a comment in your code, like a todo notice (w/o
TODO word :-) ) to consider a common helper.

-- 
With Best Regards,
Andy Shevchenko
