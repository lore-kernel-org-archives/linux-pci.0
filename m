Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52789 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756102Ab2DZPQS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 11:16:18 -0400
Date: Thu, 26 Apr 2012 11:16:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <greg@kroah.com>
cc: Calin Demian <c.demian20@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
In-Reply-To: <20120426144356.GB4365@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1204261113430.1530-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 26 Apr 2012, Greg KH wrote:

> On Thu, Apr 26, 2012 at 10:25:41AM -0400, Alan Stern wrote:
> > On Thu, 26 Apr 2012, Calin Demian wrote:
> > 
> > > I don't know how, but adding the following line in function
> > > quirk_usb_handoff_ohci makes the system work fine:
> > > 
> > > 	/* reset requires max 10 us delay */
> > > +	udelay(1);
> > > 	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
> > > 		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
> > > 
> > > I observed thad the condition in the for loop is allways true, so the
> > > delay inside the loop is never executed.
> 
> That implies that something is wrong with the complier here, and it
> optimized out the loop?  Are you sure that really happened?

Here's the complete context:

	/* reset requires max 10 us delay */
	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
			break;
		udelay(1);
	}

I think Calim means that the "(readl(base + OHCI_CMDSTATUS) & OHCI_HCR)  
== 0" test succeeds on the first pass through the loop, so we break out
early and the udelay(1) statement never gets executed.

Alan Stern

