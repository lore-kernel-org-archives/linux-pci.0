Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeG2SaH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Jul 2018 14:30:07 -0400
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D73208A2
        for <linux-pci@vger.kernel.org>; Sun, 29 Jul 2018 16:59:04 +0000 (UTC)
Received: by mail-oi0-f46.google.com with SMTP id i12-v6so17250149oik.2
        for <linux-pci@vger.kernel.org>; Sun, 29 Jul 2018 09:59:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180729120901.GA8489@wunner.de>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de> <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de> <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <20180728183130.GA21482@wunner.de> <29894244-e682-9394-c408-bd989fb4716a@kernel.org>
 <20180729120901.GA8489@wunner.de>
From: Sinan Kaya <Okaya@kernel.org>
Date: Sun, 29 Jul 2018 09:59:02 -0700
Message-ID: <CAK9iUCNZvHLsW=-MKAcJs_MWR08HHGsm1aUqbiO1ea_LFCfAdA@mail.gmail.com>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
To: Lukas Wunner <lukas@wunner.de>
Cc: Alex_Gagniuc@dellteam.com, mr.nuke.me@gmail.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        Austin.Bolen@dell.com, Stuart.Hayes@dell.com, Narendra.K@dell.com,
        Christopher.Arzola@dell.com, David.Chalfant@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/29/18, Lukas Wunner <lukas@wunner.de> wrote:
> On Sat, Jul 28, 2018 at 05:26:57PM -0700, Sinan Kaya wrote:
>> On 7/28/2018 11:31 AM, Lukas Wunner wrote:
>> >The knowledge whether a surprise removal or a safe removal is at hand
>> >does exist further up in the call stack:  A surprise removal is
>> >initiated by pciehp_handle_presence_or_link_change(), a safe removal by
>> >pciehp_handle_disable_request().
>>
>> Can you also check if platform supports surprise link down error
>> reporting (Link Capabilities Register) and reports a surprise link
>> down event in AER Uncorrectable Error Status Register for the
>> hotplug code to make it more reliable?
>
> We read the Link Capabilities register in pcie_init() to determine if
> Data Link Layer Link Active Reporting is supported.  (That's a feature
> added in the PCIe r1.1 Base Spec.  Old devices that strictly adhere to
> PCIe r1.0 don't support it.)
>
> We could likewise cache the Surprise Down Error Reporting Capable bit
> in struct controller.  But I don't quite understand yet how and when
> you want it to be used by pciehp?  If the link goes down, pciehp doesn't
> care whether that's caused by a fatal error or removal by the user.
> It seems correct to me to also remove devices on a fatal error, after all
> they're no longer accessible until the error is cleared (IIUC).
> Do you agree or disagree?

Yes, we have to remove the devices for both. However, I don't think
pciehp is the right place for fatal error link events. I am trying to
separate these two execution paths.

If we fail, someone will have to take the challenge and unify link
code for both.
Right now, two threads are trying to do the same thing in parallel.

Why surprise link down check...

Data link layer can change due to signal integrity issues.
Spec defines surprise link down bit to separate device removal
>From other link quality issues.

That's why, i was suggesting to check it if a pcie device supports
It.

>
> Thanks,
>
> Lukas
>
