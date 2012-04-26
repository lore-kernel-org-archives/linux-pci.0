Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41395 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753184Ab2DZOn7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 10:43:59 -0400
Date: Thu, 26 Apr 2012 07:43:56 -0700
From: Greg KH <greg@kroah.com>
To: Calin Demian <c.demian20@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
Message-ID: <20120426144356.GB4365@kroah.com>
References: <CAD52pS_uLqhwQfr6Pqm=apqq94wY0ULNHp+tT8ohkeGn7M58HQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1204261020040.1530-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1204261020040.1530-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 26, 2012 at 10:25:41AM -0400, Alan Stern wrote:
> On Thu, 26 Apr 2012, Calin Demian wrote:
> 
> > I don't know how, but adding the following line in function
> > quirk_usb_handoff_ohci makes the system work fine:
> > 
> > 	/* reset requires max 10 us delay */
> > +	udelay(1);
> > 	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
> > 		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
> > 
> > I observed thad the condition in the for loop is allways true, so the
> > delay inside the loop is never executed.

That implies that something is wrong with the complier here, and it
optimized out the loop?  Are you sure that really happened?

greg k-h
