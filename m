Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:31884 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753456AbaATTBE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 14:01:04 -0500
Date: 20 Jan 2014 14:01:02 -0500
Message-ID: <20140120190102.13636.qmail@science.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: acooks@gmail.com, linux@horizon.com
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Cc: iommu@lists.linux-foundation.org, linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org
In-Reply-To: <CAJtEV7ZsM2YHHETRGNwXnGi7uq0mJen73i-Yp3EXoDrnni=o=g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> I massaged it a bit to fit my personal idea of "cleaner".
>> The biggest logic change is the elimination of the fn_mapped
>> variable from quirk_map_multi_requester_ids.

> Thanks, that was detritus left over from debugging.

The code still does the exact same thing; I just derive the value from
(fn_map & ((1<<fn)-1)) if it's required.

>> I also got rid of the "fn_map << fn" logic (which is never false).

> What if function 0 is not present? There were cases where the Marvell
> 9172 only used function 1 (when only one port is in use). I don't
> think it's safe to assume that function 0 is present when you're
> trying to compensate for broken devices.

Er... can you explain?  I did not change what the code *does* in the
slightest, only the was it figures out what to do.

I took this it out because it does nothing; it can be statically proved
that the expression is always non-zero.

Because "fn_map" is a non-zero 8-bit value and "fn" is an integer in
the range 0-7, the value "fn_map << fn" is a non-zero 15-bit value.
15 bits can't overflow (even on a PDP-11 with 16-bit ints), so this is
a non-zero value, and the loop will never terminate because of it.

It sure looked like a bug to me, but I couldn't figure out what it
was supposed to do.  Can you enlighten me?  "fn_map >> fn" (shifting
right rather than left) achieves early termination of the loop, but
isn't essential.

>> +       fn_map &= ~(1<<PCI_FUNC(pdev->devfn));  /* Skip the normal case */

> Do you really find this "cleaner", as in more readable?

I find it easier to think about fn_map as the bitmap of functions to
be operated on.  Rather than have two conditions in the following loop.

The confusing thing is "why are we skipping that function?"  (Because this
is a quirk and the "normal case" has already been handled.)  It would be
nicer if all the domain_context_mapping_one calls were grouped together.

I would like to see if there's a clean way to combine this with phantom
function support (which I haven't find the code for yet).

>> +       for (i = pci_dev_dma_source_map; i->devfn; i++) {

> The bug that Martin Oehrling pointed out in the ticket is still there.

Ah, thank you; I had missed that that.  Yes, it should be testing
i->vendor.  You really get devices using the wrong slot as well as
function?  Wow!

Using multiple functions is at least anticipated in the PCI spec,
even if they do it wrong.
