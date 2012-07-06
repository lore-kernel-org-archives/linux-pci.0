Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:35346 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756254Ab2GFCBJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jul 2012 22:01:09 -0400
Date: Thu, 5 Jul 2012 22:01:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	AceLan Kao <acelan.kao@canonical.com>,
	<linux-pci@vger.kernel.org>,
	=?UTF-8?B?5rSqKEFsZXgp6IyC6ICV?= <alex.hung@canonical.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
In-Reply-To: <CAErSpo6AJEdCem2oAv6z0wGiGTZSLQAs5sJN+_rN1d9uqyT7BQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1207052153240.18923-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 5 Jul 2012, Bjorn Helgaas wrote:

> >> Windows sets the COMMAND register to 0 before suspending, so it doesn't
> >> trigger the BIOS bus.  Linux doesn't, so the BIOS tries to quiesce the
> >> EHCI controller.  This involves doing various MMIO accesses, which of
> >> course don't work if the controller is already in D3.
> 
> Should we clear the COMMAND register for more than just EHCI devices?
> It seems like known differences from Windows are just waiting to bite
> us.

You're undoubtedly right, but I don't know what Windows does!  I'm just 
relying on what AceLan reported.

For the patch, I wanted to change the system behavior as little as
possible -- hence the restriction to EHCI controllers.  For all I know
it might be perfectly okay to do this with all PCI devices, but it
seems more likely that it would cause trouble in some obscure cases.  

And at least with EHCI controllers, I know what the underlying driver
is doing.

> I like your patch and explanation for how this can cause a hang...
> that helps make sense of things.
> 
> >> For obvious reasons, I'm in favor of my two-line change over AceLan's
> >> new PCI quirk.  So far there have been positive responses from a few
> >> volunteers testing the patch.
> >
> > The two-liner is good enough, I think, and tested.  We can always add a quirk
> > based on it in the future.
> 
> Cool, do you want to send me a patch with Signed-off-by, etc?

I'll send it early next week.

Alan Stern

