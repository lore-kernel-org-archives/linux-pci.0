Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:39478 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbeICWaZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Sep 2018 18:30:25 -0400
Date: Mon, 3 Sep 2018 19:09:03 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: IRQ number question.
Message-ID: <20180903190903.290fff01@alans-desktop>
In-Reply-To: <20180903171639.GC16262@BitWizard.nl>
References: <20180903171639.GC16262@BitWizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 3 Sep 2018 19:16:39 +0200
Rogier Wolff <R.E.Wolff@BitWizard.nl> wrote:

> Hi, 
> 
> I'm writing a kernel driver. It is not going to be widely used, so I'm
> not motivated to make things nice enough for inclusion in the standard
> kernel.
> 
> But lspci shows my device: 
> 
> 03:01.0 Serial bus controller [0c80]: Phoenix Contact GmbH & Co. Device 0002 (rev b7)
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 14
>         I/O ports at e070 [size=16]
>         Memory at f7d00000 (32-bit, non-prefetchable) [size=256K]
> 
> Now when I start my module and prod the device a bit, it will generate
> an interrupt. (in this case the monitor program needs to start sending
> messages to the card.)
> 
> Then the kernel reports: 
> 
> irq 18: nobody cared (try booting with the "irqpoll" option)
> 
> I've been writing device drivers in the past, but in the past
> when the lspci listed "IRQ 14" then I'd have to request_irq (14, ...

The IRQ number in the PCI configuration space is just a label really for
legacy OS stuff. Nothing actually routes interrupts according to it (*).
If it's coming up as 14 that looks more like the BIOS mislabelled it.
Legacy PCI interrupts care about lines and pins not irq numbers.

Are you looking at values after things like pci_enable_device were called
or before ? Are you also looking at what is in pcidev->irq after the
enable ?
 
> Has this changed? Or is this hardware "odd"/"bad"/"broken" in that it
> initializes the PCI devices wrong? (*)
> 
> My driver now works with the interrupts coming in nicely on IRQ18...
> 
> I have this card where I'm writing my own driver, and another PCI card
> that uses an "included-in-the-kernel" driver, and it too behaves as if
> it doesn't get any interrupts.
> 
> 	Roger. 
> 
> (*) Obviously according to everybody "windows works", so could it be
> that modern windows simply activates an irq and polls to see what
> driver handles it? Or something like that? Ah! That would be somewhat
> similar to what "irqpoll" does on Linux!

Does the hardware also support modern INTX interrupts or just the old
legacy ones. Could be Windows is using INTX if so

Alan
(*) PCI doesn't. Certain slightly stoned PCI 'emulations' in some
hardware do.
