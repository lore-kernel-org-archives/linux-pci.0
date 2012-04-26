Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36501 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753473Ab2DZPZu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 11:25:50 -0400
Date: Thu, 26 Apr 2012 08:25:48 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Calin Demian <c.demian20@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
Message-ID: <20120426152548.GA15674@kroah.com>
References: <20120426144356.GB4365@kroah.com>
 <Pine.LNX.4.44L0.1204261113430.1530-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1204261113430.1530-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 26, 2012 at 11:16:17AM -0400, Alan Stern wrote:
> On Thu, 26 Apr 2012, Greg KH wrote:
> 
> > On Thu, Apr 26, 2012 at 10:25:41AM -0400, Alan Stern wrote:
> > > On Thu, 26 Apr 2012, Calin Demian wrote:
> > > 
> > > > I don't know how, but adding the following line in function
> > > > quirk_usb_handoff_ohci makes the system work fine:
> > > > 
> > > > 	/* reset requires max 10 us delay */
> > > > +	udelay(1);
> > > > 	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
> > > > 		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
> > > > 
> > > > I observed thad the condition in the for loop is allways true, so the
> > > > delay inside the loop is never executed.
> > 
> > That implies that something is wrong with the complier here, and it
> > optimized out the loop?  Are you sure that really happened?
> 
> Here's the complete context:
> 
> 	/* reset requires max 10 us delay */
> 	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
> 		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
> 			break;
> 		udelay(1);
> 	}
> 
> I think Calim means that the "(readl(base + OHCI_CMDSTATUS) & OHCI_HCR)  
> == 0" test succeeds on the first pass through the loop, so we break out
> early and the udelay(1) statement never gets executed.

Ok, but if the readl() succeeds, then all should be fine?

Ah, unless the hardware is really lying, but no, that would never
happen, right?

Nevermind,

greg k-h
