Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36284 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbdGLMNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2017 08:13:15 -0400
Received: by mail-io0-f182.google.com with SMTP id z62so11365507ioi.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Jul 2017 05:13:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1886933.1k4ytioEMD@amdc3058>
References: <CGME20170710211327epcas1p4443f6f9df236e76fd4afd91dccf45cd0@epcas1p4.samsung.com>
 <20170710211305.6475-1-ard.biesheuvel@linaro.org> <1886933.1k4ytioEMD@amdc3058>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 12 Jul 2017 13:13:14 +0100
Message-ID: <CAKv+Gu8pmsqZj25_en7Q-i4tHhTjfuLoO9mRatH-+KZxMgi6ag@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/fbdev: efifb: allow BAR to be moved instead of
 claiming it
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12 July 2017 at 11:00, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Monday, July 10, 2017 10:13:05 PM Ard Biesheuvel wrote:
>> On UEFI systems, the firmware may expose a Graphics Output Protocol (GOP)
>> instance to which the efifb driver attempts to attach in order to provide
>> a minimal, unaccelerated framebuffer. The GOP protocol itself is not very
>> sophisticated, and only describes the offset and size of the framebuffer
>> in memory, and the pixel format.
>>
>> If the GOP framebuffer is provided by a PCI device, it will have been
>> configured and enabled by the UEFI firmware, and the GOP protocol will
>> simply point into a live BAR region. However, the GOP protocol itself does
>> not describe this relation, and so we have to take care not to reconfigure
>> the BAR without taking efifb's dependency on it into account.
>>
>> Commit 55d728a40d36 ("efi/fb: Avoid reconfiguration of BAR that covers
>> the framebuffer") attempted to do so by claiming the BAR resource early
>> on, which prevents the PCI resource allocation routines from changing it.
>> However, it turns out that this only works if the PCI device is not
>> behind any bridges, since the bridge resources need to be claimed first.
>>
>> So instead, allow the BAR to be moved, but make the efifb driver deal
>> with that gracefully. So record the resource that covers the BAR early
>> on, and if it turns out to have moved by the time we probe the efifb
>> driver, update the framebuffer address accordingly.
>>
>> While this is less likely to occur on x86, given that the firmware's
>> PCI resource allocation is more likely to be preserved, this is a
>> worthwhile sanity check to have in place, and so let's remove the
>
> It still cuts the patch description early..
>

Ah yes, thanks for pointing that out. I will fix it up before queuing the patch.

>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> From fbdev's side:
>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>

Cheers.
