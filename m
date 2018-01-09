Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:35855
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964998AbeAITbc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jan 2018 14:31:32 -0500
Subject: Re: [BISECTED] v4.15-rc: Boot regression on x86_64/AMD
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi>
 <CA+55aFxCSWCG7ZvHW3AkLPzMPMAuG1BhL8fNgC0-JPYU4LZVow@mail.gmail.com>
 <CAErSpo7dOfabXk9rpZr=B87wK4_Ao9_moK89Ze0cyi6Mqb0Z+Q@mail.gmail.com>
 <628e2b58-b16b-5792-b4ef-88bec15ab779@amd.com>
 <CA+55aFxbpNHpiZdtddq8DqfChFwho0OWw5SAZkkwEpwPS4-QYg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5d794f18-f54c-3ca6-3869-5f5e2825b1ad@amd.com>
Date: Tue, 9 Jan 2018 20:31:14 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFxbpNHpiZdtddq8DqfChFwho0OWw5SAZkkwEpwPS4-QYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 09.01.2018 um 20:18 schrieb Linus Torvalds:
> On Tue, Jan 9, 2018 at 2:37 AM, Christian König
> <christian.koenig@amd.com> wrote:
>> I tested a bit with Aaro and came up with the attached patch, it adds a 16GB
>> guard between the end of memory and the new window for the PCIe root hub.
>> But I agree with you that this is just a hack and not a real solution.
> Guys, that last statement makes no sense.
>
> The *real* hack was that original patch that caused problems.
>
> I mean, just look at it. It has a completely made up - and bad -
> default start, and then it tries to forcibly just create the maximum
> window it possibly can. Well, not quite, but almost.
>
> Now *THAT* is hacky, and fragile, and a bad idea. It's a fundamentally
> bad idea exactly because it assumes
>
>   (a) we have perfect knowledge
>
>   (b) that window that wasn't even enabled or configured in the first
> place should be the maximum window.
>
> both of those assumptions seem completely bogus, and seem to have no
> actual reason.
>
> This comment in that code really does say it all:
>
>          /* Just grab the free area behind system memory for this */
>
> very lackadaisical.
>
> I agree that the 16GB guard is _also_ random, but it's certainly not
> less random or hacky.
>
> But I really wonder why you want to be that close to memory at all.

Actually I don't want to be close to the end of memory at all. It's just 
what I found a certain other OS is doing and I thought: Hey, that has 
the best chance of working...

But yeah, thinking about it I agree with you that this was probably not 
a good idea.

> What was wrong with the patch thgat just put it the hell out of any
> normal memory range, and just changed the default start from one
> random (and clearly bad) value to _another_ random but at least
> out-of-the-way value?

Well Bjorn didn't liked it because I couldn't come up with a good 
explanation why 256GB is a good value in general (it is a good value for 
our particular use case).

> IOW, this change
>
> -       res->start = 0x100000000ull;
> +       res->start = 0xbd00000000ull;
>
> really has a relatively solid explanation for it: "pick a high address
> that is likely out of the way". That's *much* better than "pick an
> address that is right after memory".
>
> Now, could there be a better high address to pick? Probably. It would
> be really nice to have a *reason* for the address to be picked.
>
> But honestly, even "it doesn't break Aaro's machine" is a better
> reason than many, in the absence of other reasons.
>
> For example, was there a reason for that random 756GB address? Is the
> limit of the particular AMD 64-bit bar perhaps at the 1TB mark (and
> that "res->end" value is because "close to it, but not at the top")?

That is actually a hardware limit documented in the BIOS and Kernel 
developers guide for AMD CPUs 
(https://support.amd.com/TechDocs/49125_15h_Models_30h-3Fh_BKDG.pdf).

I should probably add a comment explaining this.

> So I think "just above RAM" is a _horrible_ default starting point.
> The random 16GB guard is _better_, but it honestly doesn't seem any
> better than the simpler original patch.
>
> A starting point like "halfway to from the hardware limit" would
> actually be a better reason. Or just "we picked an end-point, let's
> pick a starting point that gives us a _sufficient_ - but not excessive
> - window".

Well that is exactly what the 256GB patch was doing.

So as long as you are fine with that I'm perfectly fine to use that one.

Christian.

> Or any number of other possible starting points. Almost _anything_ is
> better than "end of RAM".
>
> That "above end of RAM" might be a worst-case fall-back value (and in
> fact, I think that _is_ pretty close to what the PCI code uses for the
> case of "we don't have any parent at all, so we'll just have to assume
> it's a transparent bridge"), but I don't think it's necessarily what
> you should _strive_ for.
>
> So the hackyness of whatever the fix is really should be balanced with
> the hackyness of the original patch that introduced this problem.
>
>               Linus
