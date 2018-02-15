Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43832 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030245AbeBOMzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Feb 2018 07:55:39 -0500
MIME-Version: 1.0
In-Reply-To: <f7b3de31-46fb-f80e-511e-651fa815bddf@huawei.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com> <20180214161635.GA13849@e107981-ln.cambridge.arm.com>
 <65185a4d-c712-4486-d713-3fa9de14e35d@huawei.com> <e3fb78b3-5f5c-fe96-9f02-e96092963c17@huawei.com>
 <CAHp75VfFKcnUVQwPUxynzp88RXWdV8VEqtXxd0=_Q_GJKO6UpQ@mail.gmail.com> <f7b3de31-46fb-f80e-511e-651fa815bddf@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 15 Feb 2018 14:55:37 +0200
Message-ID: <CAHp75Vec1vXxuo9i5G-og1cQre1AYm=0_61u+DK1690FpY17bQ@mail.gmail.com>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: John Garry <john.garry@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 15, 2018 at 2:52 PM, John Garry <john.garry@huawei.com> wrote:
> On 15/02/2018 12:22, Andy Shevchenko wrote:
>> On Thu, Feb 15, 2018 at 1:19 PM, John Garry <john.garry@huawei.com> wrote:

>>> +static const struct acpi_device_id indirect_io_hosts[] = {
>>> +    {"HISI0191", 0},    /* HiSilicon LPC host */
>>> +    {},
>>
>>
>> Just a nit.
>>
>
> I noticed that I have this in the LLDD also. I think that this may be a
> force of habit.


>> It seems lately this happens more often than usual, I mean a comma in
>> the terminator line.
>>
>> If we remove it. we terminate not only at runtime, but at compile
>> time, which is slightly better.
>
>
> I grepped for "{}," in the drivers folder and it gives many results (I do
> accept that some are not sentinels):

Yes, in old code it might be, but why to cargo-culting bad (okay, less
worth) practices?

>>grep -R "{}," * | tail

Btw, `git grep ...` is much faster.

> watchdog/gef_wdt.c:    {},
> watchdog/asm9260_wdt.c:    {},
> watchdog/bcm2835_wdt.c:    {},
> watchdog/digicolor_wdt.c:    {},
> watchdog/bcm7038_wdt.c:    {},
> watchdog/ath79_wdt.c:    {},
> watchdog/riowd.c:    {},
> watchdog/sbsa_gwdt.c:    {},
> watchdog/sbsa_gwdt.c:    {},
> watchdog/bcm_kona_wdt.c:    {},



-- 
With Best Regards,
Andy Shevchenko
