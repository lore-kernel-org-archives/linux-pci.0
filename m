Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756235AbeFOSfN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jun 2018 14:35:13 -0400
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0BE208B8
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2018 18:35:12 +0000 (UTC)
Received: by mail-it0-f50.google.com with SMTP id u4-v6so4001687itg.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2018 11:35:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <980b68c0-6034-b495-753f-c75c04e0f5d1@broadcom.com>
References: <20180405193154.27897-1-robh@kernel.org> <20180612170229.GA10141@roeck-us.net>
 <20180613100935.GA7707@e107981-ln.cambridge.arm.com> <20180613181146.GA28856@roeck-us.net>
 <20180615125847.GA7735@e107981-ln.cambridge.arm.com> <980b68c0-6034-b495-753f-c75c04e0f5d1@broadcom.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Jun 2018 12:34:51 -0600
Message-ID: <CAL_JsqLUR_5Hnaws3Dt8ujetq8R-TxnG9wvOe4y6HT50KrNnbQ@mail.gmail.com>
Subject: Re: [v4] PCI: improve host drivers compile test coverage
To: Scott Branden <scott.branden@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Ley Foon Tan <lftan@altera.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 15, 2018 at 11:55 AM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Hi Lorenzo,
>
>
>
> On 18-06-15 05:58 AM, Lorenzo Pieralisi wrote:
>>
>> On Wed, Jun 13, 2018 at 11:11:46AM -0700, Guenter Roeck wrote:
>>>
>>> On Wed, Jun 13, 2018 at 11:09:35AM +0100, Lorenzo Pieralisi wrote:
>>>>
>>>> [+Jan, Ley Foon, RMK]
>>>>
>>>> On Tue, Jun 12, 2018 at 10:02:29AM -0700, Guenter Roeck wrote:
>>>>>
>>>>> On Thu, Apr 05, 2018 at 02:31:54PM -0500, Rob Herring wrote:
>>>>>>
>>>>>> Add COMPILE_TEST on driver config options with it. Some ARM drivers
>>>>>> still have arch dependencies, so we have to keep those dependent on
>>>>>> ARM.
>>>>>>
>>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>>> Cc: linux-pci@vger.kernel.org
>>>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>>>
>>>>> This patch has the undesirable side effect that it selects PCI_DOMAINS
>>>>> for
>>>>> sparc32:allmodconfig, which in turn results in
>>>>>
>>>>> drivers/ata/pata_ali.c: In function 'ali_init_chipset':
>>>>> drivers/ata/pata_ali.c:469:38: error:
>>>>>         implicit declaration of function 'pci_domain_nr'; did you mean
>>>>> 'pci_iomap_wc'?
>>>>>
>>>>> Unfortunately, 37bd62d224c82 ("PCI: Enable PCI_DOMAINS along with
>>>>> generic
>>>>> PCI host controller") has pretty much the same result. No idea how to
>>>>> fix
>>>>> the problem, so I won't even try.
>>>>
>>>> Sorry about that.
>>>>
>>>> One option would consist in removing all PCI_DOMAINS selection from
>>>> drivers/pci/controller/Kconfig and delegate it to arches even though
>>>> this would force PCI_DOMAINS selection on all ARM platforms (it is
>>>> already selected for ARCH_MULTIPLATFORM).
>>>>
>>>> Or we add back arch dependency to the relevant host bridges.
>>>>
>>>> Everything else I have in mind seems overkill to me given that this
>>>> patch was added to improve test coverage (we could add a default
>>>> pci_domain_nr() stub - weak or #define - that returns 0 in case arches
>>>> do not provide an implementation but do we really want to do that ?).
>>>>
>>>> Thoughts appreciated.
>>>>
>>>  From the definition of PCI_DOMAINS, I suspect the original idea was that
>>> drivers should depend on it, not select it. Especially auto-selecting
>>> it with PCI_HOST_GENERIC seems like a bad idea to me. However, that is
>>> just me. I'll leave it up to Bjorn to decide what if anything he wants
>>> to do about it.
>>
>> Here is a patch that should reinstate the previous behaviour but
>> it will make PCI_DOMAINS a visible option on ARM 32-bit systems; whether
>> that's acceptable that's the question I need to answer, it should
>> honour old configs and it does not force PCI_DOMAINS selection on
>> non-DT arch/arm PCI host controllers (that do not need PCI_DOMAINS
>> anyway so I suspect that enabling it on all ARM 32-bit platforms
>> should not break anything but I preferred to be cautious).
>
> I think this change will also require a patch enabling CONFIG_PCI_DOMAINS in
> multi_v7_defconfig and iproc_defconfig at the very least?

Perhaps the sub-arches that want this should select it. It is more a
platform option/decision more than a controller option.

Rob
