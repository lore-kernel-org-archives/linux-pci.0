Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35535 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941660AbcJ1REj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2016 13:04:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id s8so1739271pfj.2
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2016 10:04:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
To: Ray Jui <ray.jui@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
 <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com> <5420659.scnjID7ZLn@wuerfel>
 <ae624772-9306-50ee-3dc1-df8156eaa16d@broadcom.com>
 <acccb06d-14b9-33bd-466b-47dd3689e537@broadcom.com>
 <CACna6rxCdgyqFMU5-LD0rJn1s6voSiVvk1AGGnaykGZPMDbwPw@mail.gmail.com>
 <1b58db80-c9ff-d4d6-0df1-d80d1c03bc45@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b11c63b3-b95a-cb90-2fea-462c9c89f24f@gmail.com>
Date: Fri, 28 Oct 2016 10:04:33 -0700
MIME-Version: 1.0
In-Reply-To: <1b58db80-c9ff-d4d6-0df1-d80d1c03bc45@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/28/2016 09:58 AM, Ray Jui wrote:
> Hi Rafal,
> 
> On 10/28/2016 8:31 AM, Rafał Miłecki wrote:
>> On 20 April 2016 at 20:18, Ray Jui <ray.jui@broadcom.com> wrote:
>>> Hi Rafal/Florian/Arnd,
>>>
>>> After a couple days of email exchange with the ASIC team, I think I've
>>> figured out the behavior on all of the Broadcom SoCs that use this iProc
>>> PCIe controller.
>>>
>>> On NSP, Cygnus, and NS2:
>>> - There's an APB error enable register at offset 0xf40 from the iProc PCIe
>>> controller's base address. If one clears bit 0 (enabled by default after
>>> chip POR) of that register, one can stop this from being forwarded to "iProc
>>> host" as an APB error/external imprecise abort
>>> - I will submit a patch to the iProc PCIe driver to disable this error
>>> forwarding
>>>
>>> On NS:
>>> - Unfortunately, there's no such control register in NS. In other words, we
>>> cannot disable this error at the PCIe controller level
>>> - FSR code corresponds to external (bit[12] = '1'), read (bit[11] = '0'),
>>> imprecise abort (bits[10][3:0] = '1''0110'), i.e., external imprecise abort
>>> triggered by read access. Our ASIC team believes a read access to a
>>> non-exist APB register can also trigger an abort with the same FSR code.
>>> Note this is the tricky part, by registering an abort hook that skips this
>>> particular FSR, one has a chance of skipping other aborts triggered by
>>> accessing invalid APB registers. But given that this cannot be disabled for
>>> the PCIe controller NS, I'm not sure what approach we should take. Any
>>> thoughts?
>>
>> It's really late reply but I wanted to finally handle this problem.
>>
>> From Ray's e-mail it seems Northstar is the only platform requiring
>> this workaround. So we don't have to worry about arm64.
> 
> Yes, Northstar is the only platform that requires this workaround. Even
> the arm32 platforms like NSP and Cygnus can disable unsupported request
> being forwarded as APB error. I've recently sent out a patch series to
> fix this for all other platforms, and sorry I should have included you
> in the email but I did not. I'll include you when revision 2 is sent out.
> 
>>
>> We have two options then:
>> 1) Add workaround in arch/arm/mach-bcm/bcm_5301x.c
>> 2) Add workaround into built-in drivers/pci/host/pcie-iproc-fault.c
> 
> How do you plan to implement pcie-iproc-fault.c? If it's similar to what
> you have now, then I think it fits more to bcm_5301x.c

I was going to suggest adding it to the PCIe driver so as to make it
localized there, but that seems like a better idea, in case the PCIe
driver is not built into the kernel, or as a module, it seems like a
nice thing to be able to clear the abort.
-- 
Florian
