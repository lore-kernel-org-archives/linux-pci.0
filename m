Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:41602 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbeIDMEp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2018 08:04:45 -0400
Date: Tue, 4 Sep 2018 09:40:51 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: IRQ number question.
Message-ID: <20180904074051.GG11854@BitWizard.nl>
References: <20180903171639.GC16262@BitWizard.nl>
 <20180903190903.290fff01@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180903190903.290fff01@alans-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 03, 2018 at 07:09:03PM +0100, Alan Cox wrote:

> The IRQ number in the PCI configuration space is just a label really for
> legacy OS stuff. Nothing actually routes interrupts according to it (*).
> If it's coming up as 14 that looks more like the BIOS mislabelled it.
> Legacy PCI interrupts care about lines and pins not irq numbers.

Yeah, on ISA there are lines marked IRQ3, IRQ4 and you pull on such a
line and the CPU gets interrupted.

On PCI there are lines marked IRQA, IRQB... IRQD and you yan one line
and the CPU gets interrupted.

Usually IRQA on the first slot gets wired to IRQB on the second slot
and so on. This is because cards are expected to require only one IRQ,
but /can/ have upto four.

the IRQ register in the PCI configuration space is just an 8bit
register that is required to be able to remember those 8 bits nothing
else.

The BIOS is expected to know which SLOTx INTy line goes where in the
hardware. And then it should store the resulting interrupt number in
that 8-bit register.

Now when Linux knows enough about the hardware (interrupt controller)
to reroute interrupts on an interrupt controller, I would have liked
it to also note the result in the interrupt register in the affected
card. Apparently it doesn't. 

Anyway. Yesterday I was: "OK, I'll have to make it into a real
PCI-device-driver", and today I'm thinking: "Now I know how this comes
about, I can make it nicer if I have time left", on to other stuff for
the time being.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
