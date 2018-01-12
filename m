Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964950AbeALSWB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 13:22:01 -0500
Date: Fri, 12 Jan 2018 18:23:02 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Koen Vandeputte <koen.vandeputte@ncentric.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        niklas.cassel@axis.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: dwc: fix enumeration end when reaching root
 subordinate
Message-ID: <20180112182302.GF26438@red-moon>
References: <1515508941-20055-1-git-send-email-koen.vandeputte@ncentric.com>
 <20180109152550.GA16285@red-moon>
 <4bf872a4-ce26-aca6-eacd-db25673fb8c6@ncentric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4bf872a4-ce26-aca6-eacd-db25673fb8c6@ncentric.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 12, 2018 at 04:56:33PM +0100, Koen Vandeputte wrote:
> Hi Lorenzo,
> 
> Apologies for the late reply, It's been really busy over here.
> 
> 
> On 2018-01-09 16:25, Lorenzo Pieralisi wrote:
> ><snip>
> >>Fix this by initializing the RC to a subordinate value of 0xff, meaning
> >>that all busses [0x00-0xff] are reachable through this RC.
> >This is not a correct description of the problem. AFAICS all busses
> >are reachable through this RC _regardless_ of whatever subordinate
> >bus number value you programme into it.
> Noted.
> 
> This was written meaning: "as seen be the probing functions below"
> I'll try harder in V2 to actually include the message that it's not
> a HW related problem or influencing HW in any way, but really
> "tricking" the probing functions below

Ok, add it to the log please.

> >You should extend the CC list to all dwc host submaintainers so
> >that you can actually get it tested.
> How to figure out who to include? (& please provide who to include)
> Reading online manuals on "how to send patches" only demo's
> "get_maintainer.pl" script

Well, you can do it manually, by checking all pci/dwc submaintainers
in MAINTAINERS.

There are other ways of course but it is simple enough.

> >><snip>
> >>---
> >>
> >>Will send separate patches to stable as this file got moved/renamed
> >Fixes: commit appeared at v4.15-rc1 (and v4.15 has not been released
> >yet) - there is no separate patch to be sent.
> This is something typical which is hard to learn/understand by just
> reading "how to send patches" docs available everywhere. (like I did
> before sending this one over ;-) )
> 
> 2 questions basically:
> - As the commit causing it was included in 4.15-*RC1*,  do I need to
> add a "Fixes; bla bla" at all?

Yes.

> - As the commit causing it was backported to 4.9, (how) should I
> send a separate patch in order to get it fixed there? [0]

So submitting a stable tag does make sense, sorry I missed that.

Or we can send to stable kernel specific backports.

> Probably annoying questions triggering a 'sigh' .. but I'm lacking
> experience here ..

No way, thank you for fixing it !

> Thanks for your time & patience so far,
> Highly appreciated,

Same here, thank you.

Lorenzo
