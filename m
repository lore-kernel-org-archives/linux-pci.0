Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52741 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757064Ab2DZOZm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 10:25:42 -0400
Date: Thu, 26 Apr 2012 10:25:41 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Calin Demian <c.demian20@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
In-Reply-To: <CAD52pS_uLqhwQfr6Pqm=apqq94wY0ULNHp+tT8ohkeGn7M58HQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1204261020040.1530-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 26 Apr 2012, Calin Demian wrote:

> I don't know how, but adding the following line in function
> quirk_usb_handoff_ohci makes the system work fine:
> 
> 	/* reset requires max 10 us delay */
> +	udelay(1);
> 	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
> 		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
> 
> I observed thad the condition in the for loop is allways true, so the
> delay inside the loop is never executed.
> With the unmodified source, the execution doesn't stop at this point
> but at the next readl (I tried inserting printk and readl instructions
> after the writel which restores the fminterval and the execution
> stopped before exiting quirk_usb_handoff_ohci).
> I don't know how it relates to the ACPI message... (see bug 43073 in
> bugzilla.kernel.org).

I don't know just what the problem is either, but there's nothing wrong 
with delaying startup by 1 us.  In fact, all we have to do is reorder 
the statements within the loop.  Is this patch okay for you?

Alan Stern



Index: usb-3.4/drivers/usb/host/pci-quirks.c
===================================================================
--- usb-3.4.orig/drivers/usb/host/pci-quirks.c
+++ usb-3.4/drivers/usb/host/pci-quirks.c
@@ -520,9 +520,10 @@ static void __devinit quirk_usb_handoff_
 
 	/* reset requires max 10 us delay */
 	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
+		/* Some controllers enable HCR too soon, so always delay 1 us */
+		udelay(1);
 		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
 			break;
-		udelay(1);
 	}
 	writel(fminterval, base + OHCI_FMINTERVAL);
 

