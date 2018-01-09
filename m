Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:43520 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeAIT5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jan 2018 14:57:12 -0500
MIME-Version: 1.0
In-Reply-To: <5d794f18-f54c-3ca6-3869-5f5e2825b1ad@amd.com>
References: <20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi>
 <CA+55aFxCSWCG7ZvHW3AkLPzMPMAuG1BhL8fNgC0-JPYU4LZVow@mail.gmail.com>
 <CAErSpo7dOfabXk9rpZr=B87wK4_Ao9_moK89Ze0cyi6Mqb0Z+Q@mail.gmail.com>
 <628e2b58-b16b-5792-b4ef-88bec15ab779@amd.com> <CA+55aFxbpNHpiZdtddq8DqfChFwho0OWw5SAZkkwEpwPS4-QYg@mail.gmail.com>
 <5d794f18-f54c-3ca6-3869-5f5e2825b1ad@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jan 2018 11:57:11 -0800
Message-ID: <CA+55aFyQchgcmZFJqYD3jpka82G76SYs3dZka5v9_3q5=tJR2w@mail.gmail.com>
Subject: Re: [BISECTED] v4.15-rc: Boot regression on x86_64/AMD
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 9, 2018 at 11:31 AM, Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>>
>> For example, was there a reason for that random 756GB address? Is the
>> limit of the particular AMD 64-bit bar perhaps at the 1TB mark (and
>> that "res->end" value is because "close to it, but not at the top")?
>
> That is actually a hardware limit documented in the BIOS and Kernel
> developers guide for AMD CPUs
> (https://support.amd.com/TechDocs/49125_15h_Models_30h-3Fh_BKDG.pdf).
>
> I should probably add a comment explaining this.

Ok, good. So at least some of those values have reasons.

And yes, documenting it would be great.

>> A starting point like "halfway to from the hardware limit" would
>> actually be a better reason. Or just "we picked an end-point, let's
>> pick a starting point that gives us a _sufficient_ - but not excessive
>> - window".
>
>
> Well that is exactly what the 256GB patch was doing.

Ahh, so 0xbd00000000ull is basically 256GB from the end point, and the
end point is basically specified by hardware.

So yes, I think that's a starting point that can at least be
explained: let's try to make it something "big enough" (and 256GB
seems to be big enough).

Of course, since this is all "pick a random number", maybe that breaks
something _else_.

We do traditionally have a very similar issue for the 32-bit PCI
starting address, where we used to have tons of issues with "we don't
know all resources, we want to try to come up with a range that is out
of the way".

There we try to find a big enough gap in th e820 memory map
(e820_search_gap()), and the end result is pci_mem_start (which is
then exposed as PCIBIOS_MIN_MEM to the PCI resource allocation).

If worst comes to worst, maybe we should look at having something
similar for the full 64-bit range.

             Linus
