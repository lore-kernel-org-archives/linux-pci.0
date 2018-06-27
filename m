Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34667 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeF0NA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2018 09:00:26 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so950213qkj.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Jun 2018 06:00:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627124920.GA27447@wunner.de>
References: <1529921446-20452-1-git-send-email-hari.vyas@broadcom.com>
 <20180625103742.GA20292@wunner.de> <3fa3c29e023abf67fa74d6e94a27645f@mail.gmail.com>
 <20180625111525.GA30242@wunner.de> <CAM5rFu-Bo_prR5R2w2XfM6JkUWo8URiL6i=4tWjOpDuMkcNn-w@mail.gmail.com>
 <20180626115356.GA24588@wunner.de> <CAM5rFu-Sb5Vhvy19GKesV00=tf0+7Q8hByU11=4F9MVhoO7nWA@mail.gmail.com>
 <20180627124920.GA27447@wunner.de>
From: Hari Vyas <hari.vyas@broadcom.com>
Date: Wed, 27 Jun 2018 18:30:25 +0530
Message-ID: <CAM5rFu-B6C8nd01E10oP1C7+JqWZ41ujAKqm6rYZrm=dkAEFuQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Data corruption happening due to race condition
To: Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2018 at 6:19 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Hari,
>
> please cc the list when replying so that others can comment.
>
apologize. My mistake.
> On Wed, Jun 27, 2018 at 03:45:26PM +0530, Hari Vyas wrote:
>> On Tue, Jun 26, 2018 at 5:23 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> > While a spinlock may do the job, I think a better solution would be
>> > to move is_added to the priv_flags bitmap in struct pci_dev.  The
>> > is_added flag is internal to the PCI core and anything outside has
>> > no business dealing with it.
>> >
>> > (Assuming arch/powerpc/kernel/pci-common.c can also be considered
>> > part of the PCI core.)
>>
>> Simple grep is showing that
>> is_added is being used outside in 1) arch/powerpc/platforms/powernv/
>> pci-ioda.c 2) arch/powerpc/platforms/pseries/setup.c files.
>
> I'd #include "../../../../drivers/pci/pci.h" in the few arch-specific
> files, there's some precedent for that, see
>
> git grep '#include .*\.\./\.\./\.\./\.\.' -- :/arch
>
> (I'd mention that precedent in the commit message or below the three
> dashes, in the latter case it doesn't become part of the commit message
> but it helps reviewers understand what's going on.)
>
>>> > The flags in priv_flags are defined in drivers/pci/pci.h, so far
>> > there's only one for PCI_DEV_DISCONNECTED which was introduced by
>> > 89ee9f768.  That commit also introduced accessors, personally I
>> > don't think that's necessary for the few places in the PCI core
>> > that the new PCI_DEV_ADDED flag would be used and I'd just update
>> > those sites to set or test the bit directly.
>> >
>> Agree. Issue needs to be just fixed in good way. Let me know if priv_flags
>> approach needs to be taken for is_added flag.
>
> I'd definitely recommend using priv_flags and the atomic bitops
> test_bit() and set_bit() (see Documentation/atomic_bitops.txt),
> it's less code than using a spinlock and nominally reduces the
> size of struct pci_dev by 1 bit (modulo padding by the compiler).
> spinlock is for when you have several function calls which need
> to be executed atomically.
>
Okay. Will update code (move is_added:1  to priv_flags), test and revert back.
Should fix concern but better to verify.
>
> Thanks,
>
> Lukas
