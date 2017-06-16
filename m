Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33692 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdFPSiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2017 14:38:20 -0400
Date: Fri, 16 Jun 2017 21:38:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        Sergey.Semin@t-platforms.ru
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Message-ID: <20170616183824.GA5175@mobilestation.tp-local.ru>
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <20170616163324.GA15472@mobilestation>
 <883bdb76-972c-7de9-0208-2d0933f192d4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <883bdb76-972c-7de9-0208-2d0933f192d4@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 11:08:52AM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> 
> On 16/06/17 10:33 AM, Serge Semin wrote:
> > New NTB API is going to be merged to mainline kernel within next features
> > merge window, so it's really recommended to use that API for new hardware.
> > Could you please rabase your driver on top of the tree?
> > https://github.com/jonmason/ntb.git
> 
> Yes, Allen's already pointed this out. I'll be sure to fix it up before
> a final submission.
> 
> > According to the NTB philosophy, it's not good to have any hardware
> > emulation within hardware driver. Hardware driver must reflect the only
> > hardware abilities, nothing else. Could you please get rid of Scratchpad
> > emulation and add messaging as new NTB API has got a proper callback
> > functions for it?
> 
> I disagree completely. Practicality trumps philosophy in every case. I
> need emulated scratchpads for ntb_transport to work and I'm not getting
> rid of it (thus breaking things that work well) just because of your
> philosophical beliefs.
> 

It's the way the NTB API was created for, to have set of functions to access
NTB devices in the similar way. These aren't my beliefs, it's the way it was
created. I agree it can be optional, but it shouldn't be made as the basics
of the driver. It is called NTB "hardware" driver after all, not "emulating" or
"abstracting" driver.
ntb_transport could work without Scratchpads, if it's properly altered to
use NTB messaging. This should be the way to make things compatible, but not
making the hardware driver suitable for just one ntb_transport.

> > Hmmm, I haven't seen the actual code (see my last comment), but
> > according to my impression of API, it's impossible to have memory window
> > accessed while NTB link is down, but Scratchpads still can be used.
> > In this case, if you got Scratchpads emulated over memory windows,
> > you must have got NTB link enabled before NTB device is registered, which
> > makes ntb_link_* methods kind of being useless unless Switchtec hardware
> > supports NTB link getting up/down for individual memory windows...
> 
> Nothing in-kernel actually uses the peer's scratchpads while the link is
> down and all clients seem specifically designed to wait until the link
> event to set them. So I think you're either wrong about that rule or we
> should change the rule going forward.
> 
> I'm not sure what you're referring to about the link stuff; as
> implemented, our link management works just fine.
> 
> > New NTB API is updated so to have access to any of peer ports. IDT driver
> > has got a special translation table to access peer functionality just by
> > providing an index to corresponding API callback. You can use it as
> > reference to have Switchtec driver accordingly altered. It would be vastly
> > useful to have one more multi-port hardware driver in the tree.
> 
> Yes, I expect we will get there eventually, it doesn't sound like much
> work. However, it's client support that's really going to make this
> interesting and worthwhile. That seems like the real challenge right now.
> 
> > If I'm not mistaken, these patches can be combined the way so to have
> > just two big functionally split patches:
> > 1) NTB: Microsemy Switchtec switch management driver alterations for NTB
> > 2) NTB: Add Microsemi Switchtec PCIe-switches support
> > It would really simplify the review. Could you please combine them?
> 
> Seems like every time I make a submission, someone either wants patches
> to be smaller and split up more or bigger and combined. I happen to
> agree with the people who prefer smaller patches and I think these
> provide good chunks for reviewers to look at. So, no, I'm not going to
> change this. Feel free to apply the patches to a git tree or view it on
> our github branch if you want to see the code combined.

It's not like my whim or something, but the way it's usually done.
https://kernelnewbies.org/PatchPhilosophy

Cite from there:
"Each patch should group changes into a logical sequence. Bug fixes must
come first in the patchset, then new features. This is because we need to be
able to backport bug fixes to older kernels, and they should not depend on
new features."

You grouped the patches in according to your logical view or development
progress (I don't know for sure), but it's not obvious for reviewers.
>From my perspective your new Microsemi Switchtec NTB driver is just one
feature. I don't know who would think differently so to split the solid
driver up for review. Switchtec management driver alteration might be the
same - just one fix. It's much easier for you to have your commits squashed,
than for me to look at your git tree, than get back to your patchset looking
for a necessary peace of patch and commenting it there.

Regards,
-Sergey

> 
> Thanks,
> 
> Logan
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/883bdb76-972c-7de9-0208-2d0933f192d4%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
