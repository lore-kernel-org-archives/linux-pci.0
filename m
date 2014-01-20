Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:39472 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbaATXpV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 18:45:21 -0500
MIME-Version: 1.0
In-Reply-To: <20140120190102.13636.qmail@science.horizon.com>
References: <CAJtEV7ZsM2YHHETRGNwXnGi7uq0mJen73i-Yp3EXoDrnni=o=g@mail.gmail.com>
	<20140120190102.13636.qmail@science.horizon.com>
Date: Tue, 21 Jan 2014 07:45:20 +0800
Message-ID: <CAJtEV7bkfB=REaJkf+jb33_2h=_5YoZogQNw4SKmmWwZcF8NZA@mail.gmail.com>
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
From: Andrew Cooks <acooks@gmail.com>
To: George Spelvin <linux@horizon.com>
Cc: "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	linux-ide@vger.kernel.org,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 21, 2014 at 3:01 AM, George Spelvin <linux@horizon.com> wrote:
>>> I massaged it a bit to fit my personal idea of "cleaner".
>>> The biggest logic change is the elimination of the fn_mapped
>>> variable from quirk_map_multi_requester_ids.
>
>> Thanks, that was detritus left over from debugging.
>
> The code still does the exact same thing; I just derive the value from
> (fn_map & ((1<<fn)-1)) if it's required.

I see that now - was over excited and tired last night.

>>> I also got rid of the "fn_map << fn" logic (which is never false).
>
>> What if function 0 is not present? There were cases where the Marvell
>> 9172 only used function 1 (when only one port is in use). I don't
>> think it's safe to assume that function 0 is present when you're
>> trying to compensate for broken devices.
>
> Er... can you explain?  I did not change what the code *does* in the
> slightest, only the was it figures out what to do.
>
> I took this it out because it does nothing; it can be statically proved
> that the expression is always non-zero.
>
> Because "fn_map" is a non-zero 8-bit value and "fn" is an integer in
> the range 0-7, the value "fn_map << fn" is a non-zero 15-bit value.
> 15 bits can't overflow (even on a PDP-11 with 16-bit ints), so this is
> a non-zero value, and the loop will never terminate because of it.
>
> It sure looked like a bug to me, but I couldn't figure out what it
> was supposed to do.  Can you enlighten me?  "fn_map >> fn" (shifting
> right rather than left) achieves early termination of the loop, but
> isn't essential.

OK, I understand the problem now. Early exit was the intended effect
and for some reason I thought the new version could exit too early,
but it seems fine.

>>> +       fn_map &= ~(1<<PCI_FUNC(pdev->devfn));  /* Skip the normal case */
>
>> Do you really find this "cleaner", as in more readable?
>
> I find it easier to think about fn_map as the bitmap of functions to
> be operated on.  Rather than have two conditions in the following loop.

I see that now.

> The confusing thing is "why are we skipping that function?"  (Because this
> is a quirk and the "normal case" has already been handled.)  It would be
> nicer if all the domain_context_mapping_one calls were grouped together.

Sure, but since this was the first non-trivial patch I submitted, I
tried to keep it non-intrusive and simple.

> I would like to see if there's a clean way to combine this with phantom
> function support (which I haven't find the code for yet).

I'm willing to believe that if phantom functions haven't shown up and
caused problems yet, it probably doesn't need fixing in a hurry.
SR-IOV seems like a better and more common way for devices to use
multiple lightweight functions.

>
>>> +       for (i = pci_dev_dma_source_map; i->devfn; i++) {
>
>> The bug that Martin Oehrling pointed out in the ticket is still there.
>
> Ah, thank you; I had missed that that.  Yes, it should be testing
> i->vendor.  You really get devices using the wrong slot as well as
> function?  Wow!
>
> Using multiple functions is at least anticipated in the PCI spec,
> even if they do it wrong.
