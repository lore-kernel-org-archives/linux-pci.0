Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:33715 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdFPRJN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 13:09:13 -0400
To: Serge Semin <fancer.lancer@gmail.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <20170616163324.GA15472@mobilestation>
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
Message-ID: <883bdb76-972c-7de9-0208-2d0933f192d4@deltatee.com>
Date: Fri, 16 Jun 2017 11:08:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170616163324.GA15472@mobilestation>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/06/17 10:33 AM, Serge Semin wrote:
> New NTB API is going to be merged to mainline kernel within next features
> merge window, so it's really recommended to use that API for new hardware.
> Could you please rabase your driver on top of the tree?
> https://github.com/jonmason/ntb.git

Yes, Allen's already pointed this out. I'll be sure to fix it up before
a final submission.

> According to the NTB philosophy, it's not good to have any hardware
> emulation within hardware driver. Hardware driver must reflect the only
> hardware abilities, nothing else. Could you please get rid of Scratchpad
> emulation and add messaging as new NTB API has got a proper callback
> functions for it?

I disagree completely. Practicality trumps philosophy in every case. I
need emulated scratchpads for ntb_transport to work and I'm not getting
rid of it (thus breaking things that work well) just because of your
philosophical beliefs.

> Hmmm, I haven't seen the actual code (see my last comment), but
> according to my impression of API, it's impossible to have memory window
> accessed while NTB link is down, but Scratchpads still can be used.
> In this case, if you got Scratchpads emulated over memory windows,
> you must have got NTB link enabled before NTB device is registered, which
> makes ntb_link_* methods kind of being useless unless Switchtec hardware
> supports NTB link getting up/down for individual memory windows...

Nothing in-kernel actually uses the peer's scratchpads while the link is
down and all clients seem specifically designed to wait until the link
event to set them. So I think you're either wrong about that rule or we
should change the rule going forward.

I'm not sure what you're referring to about the link stuff; as
implemented, our link management works just fine.

> New NTB API is updated so to have access to any of peer ports. IDT driver
> has got a special translation table to access peer functionality just by
> providing an index to corresponding API callback. You can use it as
> reference to have Switchtec driver accordingly altered. It would be vastly
> useful to have one more multi-port hardware driver in the tree.

Yes, I expect we will get there eventually, it doesn't sound like much
work. However, it's client support that's really going to make this
interesting and worthwhile. That seems like the real challenge right now.

> If I'm not mistaken, these patches can be combined the way so to have
> just two big functionally split patches:
> 1) NTB: Microsemt Switchtec switch management driver alterations for NTB
> 2) NTB: Add Microsemi Switchtec PCIe-switches support
> It would really simplify the review. Could you please combine them?

Seems like every time I make a submission, someone either wants patches
to be smaller and split up more or bigger and combined. I happen to
agree with the people who prefer smaller patches and I think these
provide good chunks for reviewers to look at. So, no, I'm not going to
change this. Feel free to apply the patches to a git tree or view it on
our github branch if you want to see the code combined.

Thanks,

Logan
