Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbdAWUdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jan 2017 15:33:40 -0500
Date: Mon, 23 Jan 2017 14:33:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kilian.singer@quantumtechnology.info
Cc: linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170123203335.GA4707@bhelgaas-glaptop.roam.corp.google.com>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2017 at 08:56:28AM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
> > Hi Killian,
> > 
> > Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=190861)
> > and all the debugging you've done.  Below is a revert of the troublesome
> > commit.  Can you test it and verify that it also fixes the problem?
> > 
> > I assume Mika is looking at this and will have a better solution soon.
> > But if not, I'll queue this up for v4.10.
> 
> Can somebody please summarize the current state of this issue?  I
> assume somebody has already posted a better patch that should replace
> this naive revert, but I haven't been following the whole thread.

This is somewhat frustrating.  Is there a better patch than the revert
mentioned below?  There was a lot of hullabaloo when I first posted
it, but I haven't seen a good alternative yet.  I intended the revert
as a worst-case scenario fix, with the expectation that somebody would
fix the problem or at least avoid it without having to do the revert.
Maybe somebody posted that better fix and I just missed it?

>From my perspective (and I have not followed the whole 100 message
thread), the bare bones of the situation are that 006d44e49a25 ("PCI:
Add runtime PM support for PCIe ports") probably reduced power
consumption on some machines.  But it also made Kilian's system
unresponsive when locking the screen.

Given only those assumptions, a revert seems like a reasonable
approach.  I understand and agree that we want to save power, but
not at the expense of making systems unresponsive.

Maybe 006d44e49a25 actually fixed a functional problem in addition to
saving power?  I don't think the changelog mentions anything like
that, but if that's the case, we should certainly consider that.

We're at -rc5 already, so if we want something other than a revert,
now is the time to propose it.

> > commit e648b1ca2b94d207289fedc2538d33c57cdbc4de
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Dec 27 17:27:30 2016 -0600
> > 
> >     Revert "PCI: Add runtime PM support for PCIe ports"
> >     
> >     Revert 006d44e49a25 ("PCI: Add runtime PM support for PCIe ports").
> >     
> >     Killian reported that on a Lenovo W54l with i7-4810MQ, Intel HD Graphics
> >     4600, and NVIDIA Quadro® K1100M, locking the screen kills all keyboard and
> >     mouse interaction.  Reverting 006d44e49a25 fixes the problem.
> >     
> >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=190861
> >     Reported-by: kilian.singer@quantumtechnology.info
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     CC: stable@vger.kernel.org	# v4.8+
> >     CC: Mika Westerberg <mika.westerberg@linux.intel.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
