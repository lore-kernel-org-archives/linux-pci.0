Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:34190 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752180AbdFPTfU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 15:35:20 -0400
To: Serge Semin <fancer.lancer@gmail.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <20170616163324.GA15472@mobilestation>
 <883bdb76-972c-7de9-0208-2d0933f192d4@deltatee.com>
 <20170616183824.GA5175@mobilestation.tp-local.ru>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        Sergey.Semin@t-platforms.ru
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <33b6c321-c0af-7340-8e8e-e929a00005c7@deltatee.com>
Date: Fri, 16 Jun 2017 13:34:59 -0600
MIME-Version: 1.0
In-Reply-To: <20170616183824.GA5175@mobilestation.tp-local.ru>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/06/17 12:38 PM, Serge Semin wrote:
> On Fri, Jun 16, 2017 at 11:08:52AM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> It's the way the NTB API was created for, to have set of functions to access
> NTB devices in the similar way. These aren't my beliefs, it's the way it was
> created. I agree it can be optional, but it shouldn't be made as the basics
> of the driver. It is called NTB "hardware" driver after all, not "emulating" or
> "abstracting" driver.

Just more philosophy. You haven't given any good reason to remove the
functionality. Vague references to the way things were created aren't
compelling arguments. Better to cite code and point out actual problems.

> ntb_transport could work without Scratchpads, if it's properly altered to
> use NTB messaging. This should be the way to make things compatible, but not
> making the hardware driver suitable for just one ntb_transport.

Ok, well when all the NTB clients no longer require using scratchpads
and we can all abide by the rule that clients must function without
them. Then, I'll remove the emulation. Until then, it stays.

> It's not like my whim or something, but the way it's usually done.
> https://kernelnewbies.org/PatchPhilosophy

> Cite from there:
> "Each patch should group changes into a logical sequence. Bug fixes must
> come first in the patchset, then new features. This is because we need to be
> able to backport bug fixes to older kernels, and they should not depend on
> new features."

You should probably read that again because it doesn't actually support
your point (in fact it's saying something quite unrelated). It is also
probably a good idea to read the rest of the seciton you cite:

"The idea here is that you should break changes up in such a way that it
will be easy to review."

"When creating a new feature patchset, you may need to break up your
changes into multiple commits. "

"Clean up patches that are over 200 lines long are discouraged, because
they are hard to review. Break those patches up into smaller patches. "

Also, to quote Greg Kroah-Hartman from my last series[1]:

"That's one big patch to review, would you want to do that?

Can you break it up into smaller parts?"

> You grouped the patches in according to your logical view or development
> progress (I don't know for sure), but it's not obvious for reviewers.
> From my perspective your new Microsemi Switchtec NTB driver is just one
> feature. I don't know who would think differently so to split the solid
> driver up for review. Switchtec management driver alteration might be the
> same - just one fix. It's much easier for you to have your commits squashed,
> than for me to look at your git tree, than get back to your patchset looking
> for a necessary peace of patch and commenting it there.

Well you're free to think that but, in my experience, your opinion
differs significantly from the rest of the kernel community which I
personally agree with.

Now, if you'd like to actually review the code I'd be happy to address
any concerns you find. I won't be responding to any more philosophical
arguments or bike-shedding over the format of the patch.

Logan

[1] https://lkml.org/lkml/2017/1/31/637
