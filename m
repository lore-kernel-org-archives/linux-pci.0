Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34436 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755887AbeAHXXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jan 2018 18:23:22 -0500
Received: by mail-yb0-f195.google.com with SMTP id a82so5240916ybg.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2018 15:23:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFxCSWCG7ZvHW3AkLPzMPMAuG1BhL8fNgC0-JPYU4LZVow@mail.gmail.com>
References: <20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi> <CA+55aFxCSWCG7ZvHW3AkLPzMPMAuG1BhL8fNgC0-JPYU4LZVow@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Jan 2018 17:23:01 -0600
Message-ID: <CAErSpo7dOfabXk9rpZr=B87wK4_Ao9_moK89Ze0cyi6Mqb0Z+Q@mail.gmail.com>
Subject: Re: [BISECTED] v4.15-rc: Boot regression on x86_64/AMD
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Boris, Juergen, linux-pci]

On Fri, Jan 5, 2018 at 6:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 5, 2018 at 2:04 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrot=
e:
>>
>> After v4.14, I've been unable to boot my AMD compilation box with the
>> v4.15-rc mainline Linux. It just ends up in a silent reboot loop.
>>
>> I bisected this to:
>>
>> commit fa564ad9636651fd11ec2c79c48dee844066f73a
>> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Date:   Tue Oct 24 14:40:29 2017 -0500
>>
>>     x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, =
60-7f)
>
> Hmm. That was reported to break boot earlier already.
>
> The breakage was supposedly fixed by three patches from Christian:
>
>   a19e2696135e: "x86/PCI: Only enable a 64bit BAR on single-socket AMD
> Family 15h"
>
>   470195f82e4e:  "x86/PCI: Fix infinite loop in search for 64bit BAR plac=
ement"
>
> and a third one that was apparently never applied.
>
> I'm not sure why that third patch was never applied, I'm including it her=
e.
>
> Does the system work for you if you apply that patch (instead of
> reverting all of them)?
>
> I wonder why that patch wasn't applied, but if it doesn't fix things,
> I think we do need to revert it all.
>
> Christian? Bjorn?

I didn't apply the third patch ("x86/PCI: limit the size of the 64bit
BAR to 256GB") because (a) we thought it was optional ("just a
precaution against eventual problems"), (b) we didn't have a good
explanation of why 256GB was the correct number, and (c)  it seemed to
be a workaround for a Xen issue that we hoped to fix in a better way.

It does apparently make Aaro's system work, but I still hesitate to
apply it because it's magical -- avoiding the address space from
0x1_00000000 to 0xbd_00000000 makes things work, but we don't know
why.  I assume there's some unreported device in that area, but I
don't think we have any real assurance that the
0xbd_00000000-0xfd_00000000 area we now use is any safer.

I would feel better about this if we made it opt-in via a kernel
parameter and/or some kind of whitelist.  I still don't really *like*
it, since ACPI does provide a mechanism (_PRS/_SRS) for doing this
safely, and we could just say "if you want to use big BARs, the BIOS
should enable big windows or at least make them available via ACPI
resources."  The only problem is that BIOSes don't do that and we
don't yet have Linux support for _PRS/_SRS for host bridges.

I'll prepare a revert as a back-up plan in case we don't come up with
a better solution.

Bjorn
