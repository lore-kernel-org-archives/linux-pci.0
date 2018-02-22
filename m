Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932744AbeBVPTk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 10:19:40 -0500
Date: Thu, 22 Feb 2018 09:19:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?iso-8859-1?Q?St=E9phane?= Grosjean <s.grosjean@peak-system.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: free_irq(IRQ#0) on PCIe device with MSI enabled issue...
Message-ID: <20180222151938.GC52685@bhelgaas-glaptop.roam.corp.google.com>
References: <AM5PR03MB296338FECDD421CF2F438EB7D6CD0@AM5PR03MB2963.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AM5PR03MB296338FECDD421CF2F438EB7D6CD0@AM5PR03MB2963.eurprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Marc, Thomas]

Hi Stéphane,

Thanks for your email!

On Thu, Feb 22, 2018 at 08:23:52AM +0000, Stéphane Grosjean wrote:
> I've been writing some drivers for Linux-can in the past years and
> want to add support of MSI in one of them (see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/peak_canfd).
> 
> This device driver works with legacy shared INTx over a CAN PCIe
> device. I'd like to switch to a full MSI usage of this device, which
> proposes up to 4 vectors (this device is proposed with 1, 2 or 4 CAN
> FD ports).
> 
> I'm running x86_64 Kernel 4.13.0-32 from Ubuntu 17.10. Everything
> looks ok as I successfully get the 4 consecutive IRQ levels. My
> problem is this one: as soon as the driver free_irq() the FISRT IRQ
> level, then it does not receive any interrupt from the device
> anymore, for all other 3 IRQs... On the contrary, when the driver
> free_irq() one of the 3 other IRQ (instead of the 1st one), then
> there is no problem and all other interrupts (including the first
> IRQ vector) are working as they should.

Can you share the actual driver code you're running?  The peak_canfd.c
in v4.16-rc1 doesn't have the MSI code in it, so I can't see exactly
what you're doing.

The fact that it does work on ARM suggests there's some difference in
the arch code.  I don't know enough about this area to figure it out
from scratch, but maybe working through the actual code would help.

It would be ideal if you could reproduce the problem on v4.16-rc1, in
case it's something fixed since v4.13.

> I contact you because this "issue" seems to be arch dependent:
> running the same driver and the same board on another arch (ARM),
> then everything works like a charm: the driver can free_irq() any
> IRQ in any order without disturbing the other ones. But running on
> x86, free_irq() on the FIRST MSI seems to (also) free all the other
> ones...
> 
> Note that the driver set up MSI as described in the last version of
> Documentation/PCI/MSI-HOWTO.txt.
