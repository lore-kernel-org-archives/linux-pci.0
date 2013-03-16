Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:54602 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3CPQsk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Mar 2013 12:48:40 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so4491039oag.11
        for <linux-pci@vger.kernel.org>; Sat, 16 Mar 2013 09:48:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <514429D7.5040203@thegrindstone.me.uk>
References: <514429D7.5040203@thegrindstone.me.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 16 Mar 2013 10:48:19 -0600
Message-ID: <CAErSpo6vbJ8wy8i7ZJbDni097e0gbpDXLhLRermYhkyt24fi1g@mail.gmail.com>
Subject: Re: Configuration settings to return 0xFFFFFFFF on error?
To: Richard Taylor <rjt-linux-pci@thegrindstone.me.uk>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 16, 2013 at 2:14 AM, Richard Taylor
<rjt-linux-pci@thegrindstone.me.uk> wrote:
> Hi
>
> I am struggling with a badly behaved PCIe device that is either not
> sending Read Completion packets or it is sending Unsupported Requests.
>
> My problem is that the affect of these is to leave the Non-Posted
> transaction that is waiting for the Read Completion in a hung state,
> consuming 100% CPU.
>
> I have read a number of times that when an error occurs it should be
> possible to have the transaction return with 0xFFFFFFFF rather than hang.

I'm not a hardware person, but I think this would be done by the Root Complex.

I found a QorIQ P2020 Integrated Processor Reference Manual, rev 0
07/2009, and Table 16-125 seems to mention these cases in the first
(no response) and third (UR response) rows.  These show logging the
error and sending an interrupt to the PIC.  But the CPU probably won't
recognize an interrupt until its read completes, so I doubt if the
interrupt by itself helps.

The table does mention sending all 1s (0xFFFFFFFF), but it looks like
only for config transactions.

So I agree; I would expect there would be a way to send 0xFFFFFFFF
back to the CPU so it can continue, but I don't know how to make that
happen.

Doesn't the CPU have any kind of response timeout itself?  I would
think the CPU itself would eventually time out the read and take a
machine check or something.  I know that's not the response you're
looking for, but at least it would keep the CPU from getting
completely hung because of a broken peripheral.

> I suspect this may be something to do with error severity or error
> masking settings in the PCIe configuration registers.
>
> The CPU is a QoriQ P2020.
>
> Can anyone point me in the right direction for something to try?
>
> I have the AER driver installed and it shows error interrupts being
> generated - but the memory read call still does not terminate.
