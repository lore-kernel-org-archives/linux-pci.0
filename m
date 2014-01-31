Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:25941 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932072AbaAaKGL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 05:06:11 -0500
Date: 31 Jan 2014 05:06:10 -0500
Message-ID: <20140131100610.9498.qmail@science.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: acooks@linux.com, linux@horizon.com
Subject: Re: Who understand the IOMMU code?
Cc: dwmw2@infradead.org, fenghua.yu@intel.com,
	iommu@lists.linux-foundation.org, jiang.liu@linux.intel.com,
	linux-pci@vger.kernel.org
In-Reply-To: <CAJtEV7YLC=iSbzWS8PWDo8JWY_fyaRckxtLC3aCqU7sx+O4UPQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> I'm trying to improve it, but even limiting myself to intel-iommu.c,
>> it's definitely hairy.

> What's hairy? The patch, the problem, or the iommu code?

The iommu code.  The problem is pretty straightforward, it's just the
existing code I'm trying to patch that's already large and complex and
figuring out how to fit in as neatly as possible is a challenge.

>> Right now, I'm trying to figure out where to remove the additional
>> mapping.

> Which additional mapping?

The additional requester_id -> IOMMU domain mapping that is set up for
the additional devfn(s).

> Are you implying that the patch adds redundant context entries or
> are you talking about folding the quirk_map_multi_requester_ids() and
> quirk_map_requester_id() functions into the main code path?

I'm working on a complete rewrite, using the existing PCI quirk system,
although with yours as a base, and I'm having a hard time convincing
myself that the quirk_unmap_* functions are in the right place.

> Let me see if I understand you correctly.
> 1) You don't like the simple patch that clearly shows the problem (and offers
>    a simple work-around), because it's too ugly.

Yes.  I want something that can get merged upstream, and I don't think the
existing one has much of a chance.  If nothing else, the linear search
through exception lists each time a mapping is set up will quickly
become a bottleneck.

> 2) You complain that "this stuff" (presumably the stuff you didn't
>    learn from the ugly patch) is hard to understand.

Well, the target of the complaint is my own knowledge.  I'm not claiming
the complexity is *unnecessary*, just that it is hard to follow.

> 3) You question whether anyone else understands "this stuff".
> 4) You want to know whether anyone is qualified to review your patch when
>     you 'finish it' ...
> 5) ... as long as someone just help you a little bit?
>
> It that really what you meant?

Pretty much.  Figuring out whose blessing I need and at least making
initial contact seems like an obvious prerequisite to getting a patch
merged,

The help I need is primarily not breaking the existing code, which
requires a clear understanding of what it's supposed to do.

Really, I just want to find *someone* with authority in this area who
responds to e-mail.  I can escalate to someone higher on the patch merge
hierarchy, but I want to make it very clear that I tried before going
that route.

I was hoping that chatting to you on appropriate public mailing lists
would attract some attention, but maybe I have to be more direct.

> I don't think you understood the relevance of Alex's patch set for a
> "PCIe requester ID interface", that I referred you to.

I think I didn't understand it as well the first itme I read it.
Certainly it's a nice cleanup, and would be a better place to put the
relevant quirks.  If, as you say, it gets un-stalled.

I've just now been re-reading the discussion, and it's a lot more
comprehensible now that I've read a number of PCIe and IOMMU specification
documents.

I still have to wrap my head around ACS, though.  That also affects the
code heavily.

> Ultimately, this isn't going anywhere until David Woodhouse, the Intel iommu
> maintainer, gets involved. I have not yet found the magical incantation to
> achieve that.

I may have to ask Joerg.
