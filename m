Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:32938 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab2DYW7R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2012 18:59:17 -0400
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1204251121000.1471-100000@iolanthe.rowland.org>
References: <CAD52pS8YbbgBGt_C8kTWfZWn0-CEiHUVBP+gC=wPid9kgAMQCw@mail.gmail.com>
	<Pine.LNX.4.44L0.1204251121000.1471-100000@iolanthe.rowland.org>
Date: Thu, 26 Apr 2012 01:59:15 +0300
Message-ID: <CAD52pS_uLqhwQfr6Pqm=apqq94wY0ULNHp+tT8ohkeGn7M58HQ@mail.gmail.com>
Subject: Re: PROBLEM: OHCI HCD - computer freezes during boot
From: Calin Demian <c.demian20@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I don't know how, but adding the following line in function
quirk_usb_handoff_ohci makes the system work fine:

	/* reset requires max 10 us delay */
+	udelay(1);
	for (cnt = 30; cnt > 0; --cnt) {	/* ... allow extra time */
		if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)

I observed thad the condition in the for loop is allways true, so the
delay inside the loop is never executed.
With the unmodified source, the execution doesn't stop at this point
but at the next readl (I tried inserting printk and readl instructions
after the writel which restores the fminterval and the execution
stopped before exiting quirk_usb_handoff_ohci).
I don't know how it relates to the ACPI message... (see bug 43073 in
bugzilla.kernel.org).

Calin Demian

2012/4/25 Alan Stern <stern@rowland.harvard.edu>:
> On Wed, 25 Apr 2012, Calin Demian wrote:
>
>> I have reported the issue in bugzilla, before (bug 43073). Because the
>> problem does not appear every time, I am able to boot with new kernels
>> (sometimes).
>> I also found that the problem is triggered by a specific sequence of
>> io read/write operations (including the software reset) related to the
>> host controller (during init) and by changing the operations or
>> inserting delays between them it can be solved.
>
> What delays do you need, and where should they be inserted?
>
> Alan Stern
>
