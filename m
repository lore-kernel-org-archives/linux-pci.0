Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56617 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758020Ab2DZP7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 11:59:05 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1204261020040.1530-100000@iolanthe.rowland.org>
References: <CAD52pS_uLqhwQfr6Pqm=apqq94wY0ULNHp+tT8ohkeGn7M58HQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1204261020040.1530-100000@iolanthe.rowland.org>
Date: Thu, 26 Apr 2012 18:59:03 +0300
Message-ID: <CAD52pS--R8Ob14doabyqU7JBd96VQ-TqL5cdy4GW0k+gmFgpzg@mail.gmail.com>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
From: Calin Demian <c.demian20@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yes, it's ok. Thank you.
Nevertheless, I think I will try to find out exactly what's happening.

2012/4/26 Alan Stern <stern@rowland.harvard.edu>:
> On Thu, 26 Apr 2012, Calin Demian wrote:
>
>> I don't know how, but adding the following line in function
>> quirk_usb_handoff_ohci makes the system work fine:
>>
>>       /* reset requires max 10 us delay */
>> +     udelay(1);
>>       for (cnt = 30; cnt > 0; --cnt) {        /* ... allow extra time */
>>               if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
>>
>> I observed thad the condition in the for loop is allways true, so the
>> delay inside the loop is never executed.
>> With the unmodified source, the execution doesn't stop at this point
>> but at the next readl (I tried inserting printk and readl instructions
>> after the writel which restores the fminterval and the execution
>> stopped before exiting quirk_usb_handoff_ohci).
>> I don't know how it relates to the ACPI message... (see bug 43073 in
>> bugzilla.kernel.org).
>
> I don't know just what the problem is either, but there's nothing wrong
> with delaying startup by 1 us.  In fact, all we have to do is reorder
> the statements within the loop.  Is this patch okay for you?
>
> Alan Stern
>
>
>
> Index: usb-3.4/drivers/usb/host/pci-quirks.c
> ===================================================================
> --- usb-3.4.orig/drivers/usb/host/pci-quirks.c
> +++ usb-3.4/drivers/usb/host/pci-quirks.c
> @@ -520,9 +520,10 @@ static void __devinit quirk_usb_handoff_
>
>        /* reset requires max 10 us delay */
>        for (cnt = 30; cnt > 0; --cnt) {        /* ... allow extra time */
> +               /* Some controllers enable HCR too soon, so always delay 1 us */
> +               udelay(1);
>                if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
>                        break;
> -               udelay(1);
>        }
>        writel(fminterval, base + OHCI_FMINTERVAL);
>
>
