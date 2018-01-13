Return-Path: <SRS0=vd3t=EI=users.sourceforge.net=elfring@kernel.org>
Return-Path: <SRS0=vd3t=EI=users.sourceforge.net=elfring@kernel.org>
Subject: Re: pci/setup-bus: Delete an error message for a failed memory
 allocation in add_to_list()
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <fd9d212e-e8da-1aa7-be7f-7bf6d8f1e15f@users.sourceforge.net>
 <20180113000839.GD205469@bhelgaas-glaptop.roam.corp.google.com>
 <03f4a55c-3bc3-0f15-bfc4-73049861edc4@users.sourceforge.net>
 <20180113201709.GF205469@bhelgaas-glaptop.roam.corp.google.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f0a643f8-27f0-596b-a99d-671c6e0b3d97@users.sourceforge.net>
Date: Sat, 13 Jan 2018 22:08:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180113201709.GF205469@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

> Your commit message says "omit an extra message", which suggests that
> there are currently two messages about the memory allocation failure,
> and that your patch removes one of them.

Yes. - There is a general transformation pattern applied.


> If that's the case, it would be nice to know where the other message is.

Have you got any special experiences with backtraces?



> If your patch removes the *only* message about the memory allocation
> failure, that might be worth doing,

Thanks for a bit of positive feedback.


> but the changelog should be clear about that

Do you distinguish the “log” from a commit description?


> and say "I don't think the error message is worthwhile
> because the function already returns failure" or something similar.

Do you find the wording “WARNING: Possible unnecessary 'out of memory' message”
(from the script “checkpatch.pl”) more reasonable?



>> * Are you looking for a reminder on the Linux allocation failure report?
> 
> I don't know what the "Linux allocation failure report" is.

This information seems to be “hidden” in source code.

https://elixir.free-electrons.com/linux/v4.15-rc7/source/include/linux/gfp.h#L191
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/gfp.h?id=c92a9a461dff6140c539c61e457aa97df29517d6#n213


Are you familiar with the usage of the option “__GFP_NOWARN”?



>>> Also, please squash all the drivers/pci patches into one.
>>
>> To which other change possibilities do you refer here?
> 
> You posted two patches that remove error messages about memory
> allocation failures:

Yes. - Also for this software area …


>   http://lkml.kernel.org/r/dc3922b4-50f6-e7fa-482f-18e6ff5d905f@users.sourceforge.net

Is it safer to handle adjustments for the directory “drivers/pci/hotplug” separately?


>   http://lkml.kernel.org/r/fd9d212e-e8da-1aa7-be7f-7bf6d8f1e15f@users.sourceforge.net
> 
> These are doing the same thing and could be combined into one patch.

The final committer could perform such an operation if an other patch granularity
would be preferred (or if you would insist on patch squashing).
I guess that you do not need to wait on me to apply an adjusted software combination
in this case.

Regards,
Markus
