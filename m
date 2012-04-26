Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47899 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757569Ab2DZPtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 11:49:15 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1204261113430.1530-100000@iolanthe.rowland.org>
References: <20120426144356.GB4365@kroah.com>
	<Pine.LNX.4.44L0.1204261113430.1530-100000@iolanthe.rowland.org>
Date: Thu, 26 Apr 2012 18:49:13 +0300
Message-ID: <CAD52pS8JPd-KPAMQR2D=MmVDs=UnipauLhoWf=dTkELGhN49TQ@mail.gmail.com>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
From: Calin Demian <c.demian20@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2012/4/26 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 26 Apr 2012, Greg KH wrote:
>
>> On Thu, Apr 26, 2012 at 10:25:41AM -0400, Alan Stern wrote:
>> > On Thu, 26 Apr 2012, Calin Demian wrote:
>> >
>> > > I don't know how, but adding the following line in function
>> > > quirk_usb_handoff_ohci makes the system work fine:
>> > >
>> > >   /* reset requires max 10 us delay */
>> > > + udelay(1);
>> > >   for (cnt = 30; cnt > 0; --cnt) {        /* ... allow extra time */
>> > >           if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
>> > >
>> > > I observed thad the condition in the for loop is allways true, so the
>> > > delay inside the loop is never executed.
>>
>> That implies that something is wrong with the complier here, and it
>> optimized out the loop?  Are you sure that really happened?
>
> Here's the complete context:
>
>        /* reset requires max 10 us delay */
>        for (cnt = 30; cnt > 0; --cnt) {        /* ... allow extra time */
>                if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
>                        break;
>                udelay(1);
>        }
>
> I think Calim means that the "(readl(base + OHCI_CMDSTATUS) & OHCI_HCR)
> == 0" test succeeds on the first pass through the loop, so we break out
> early and the udelay(1) statement never gets executed.
>
> Alan Stern
>

Yes, that's what I was saying. Storing the readl result in a variable
and displaying it later shows that the (readl_result & OHCI_HCR) is 0
at first pass, but that doesn't imply reset is finished, I think. It
would be too fast. Maybe the readl doesn't work for some reason...
