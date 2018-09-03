Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Sep 2018 21:24:32 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: IRQ number question.
Message-ID: <20180903192432.GE11854@BitWizard.nl>
References: <20180903171639.GC16262@BitWizard.nl>
 <20180903190903.290fff01@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180903190903.290fff01@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 03, 2018 at 07:09:03PM +0100, Alan Cox wrote:
> On Mon, 3 Sep 2018 19:16:39 +0200

> > irq 18: nobody cared (try booting with the "irqpoll" option)
> > 
> > I've been writing device drivers in the past, but in the past
> > when the lspci listed "IRQ 14" then I'd have to request_irq (14, ...
> 
> The IRQ number in the PCI configuration space is just a label really for
> legacy OS stuff. Nothing actually routes interrupts according to it (*).
> If it's coming up as 14 that looks more like the BIOS mislabelled it.
> Legacy PCI interrupts care about lines and pins not irq numbers.
> 
> Are you looking at values after things like pci_enable_device were called
> or before ? Are you also looking at what is in pcidev->irq after the
> enable ?

The driver used to be for an ISA card. But as the ISA hardware is
becoming less and less available, things were in need of an upgrade.

So... So far I was just doing
  inmod  mydriver.ko pci=1 irq=14 io=0xae00 mem=0xfda00000

keeping most of the ISA driver. (for testing I was able to run the ISA
card with the upgraded driver that does the PCI card as well...

So io= is the address I got from lspci, mem= and irq= the
same. Apparently All of them are accurate except for the IRQ?

So the answer is: No I wasn't doing pci_enable_device. I guess I'll 
have to make a proper PCI driver then. Hmm. OK. I'll look into it. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
