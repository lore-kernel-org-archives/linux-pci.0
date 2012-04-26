Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56543 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757708Ab2DZPxs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 11:53:48 -0400
MIME-Version: 1.0
In-Reply-To: <20120426152548.GA15674@kroah.com>
References: <20120426144356.GB4365@kroah.com>
	<Pine.LNX.4.44L0.1204261113430.1530-100000@iolanthe.rowland.org>
	<20120426152548.GA15674@kroah.com>
Date: Thu, 26 Apr 2012 18:53:46 +0300
Message-ID: <CAD52pS_EV39vhgMgoPpFgELyfATCZ4wT43tsgmVwNOuw07WvWw@mail.gmail.com>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
From: Calin Demian <c.demian20@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I admit it might be a hardware problem. As I said in another mail, I
couldn't duplicate the problem on other computers...
If that's true than I'm sorry for bothering you.

2012/4/26 Greg KH <greg@kroah.com>:
> On Thu, Apr 26, 2012 at 11:16:17AM -0400, Alan Stern wrote:
>> On Thu, 26 Apr 2012, Greg KH wrote:
>>
>> > On Thu, Apr 26, 2012 at 10:25:41AM -0400, Alan Stern wrote:
>> > > On Thu, 26 Apr 2012, Calin Demian wrote:
>> > >
>> > > > I don't know how, but adding the following line in function
>> > > > quirk_usb_handoff_ohci makes the system work fine:
>> > > >
>> > > >         /* reset requires max 10 us delay */
>> > > > +       udelay(1);
>> > > >         for (cnt = 30; cnt > 0; --cnt) {        /* ... allow extra time */
>> > > >                 if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
>> > > >
>> > > > I observed thad the condition in the for loop is allways true, so the
>> > > > delay inside the loop is never executed.
>> >
>> > That implies that something is wrong with the complier here, and it
>> > optimized out the loop?  Are you sure that really happened?
>>
>> Here's the complete context:
>>
>>       /* reset requires max 10 us delay */
>>       for (cnt = 30; cnt > 0; --cnt) {        /* ... allow extra time */
>>               if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
>>                       break;
>>               udelay(1);
>>       }
>>
>> I think Calim means that the "(readl(base + OHCI_CMDSTATUS) & OHCI_HCR)
>> == 0" test succeeds on the first pass through the loop, so we break out
>> early and the udelay(1) statement never gets executed.
>
> Ok, but if the readl() succeeds, then all should be fine?
>
> Ah, unless the hardware is really lying, but no, that would never
> happen, right?
>
> Nevermind,
>
> greg k-h
