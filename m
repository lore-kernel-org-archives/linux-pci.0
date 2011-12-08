Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from re04.intra2net.com ([82.165.46.26]:51429 "EHLO
	re04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab1LHI1K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2011 03:27:10 -0500
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] pci: Add quirk for still enabled interrupts on Intel Sandy Bridge GPUs
Date: Thu, 8 Dec 2011 09:27:06 +0100
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Charlie Suffin <charlie.suffin@stratus.com>, stable@kernel.org
References: <4EDFD5BB.1050906@intra2net.com> <20111207133000.69051c59@jbarnes-desktop>
In-Reply-To: <20111207133000.69051c59@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201112080927.07063.thomas.jarosch@intra2net.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jesse,

On Wednesday, 7. December 2011 22:30:00 Jesse Barnes wrote:
> > +	/* Check if any interrupt line is still enabled */
> > +	if (readl(regs + I915_DEIER_REG) != 0) {
> > +		dev_warn(&dev->dev, "BIOS left Intel GPU interrupts enabled; "
> > +			"disabling\n");
> >  {
> 
> Could really be dev_dbg, I think this will be fairly common. 

Thanks for your review.

I prefer dev_warn() or dev_info() for two reasons:

1. This is new code. If a system crashes in the unlikely event
because of this change, the user will have a better chance
to see the message before we tweak around the registers.

2. All other quirks either use dev_warn() (like the Intel e100 quirk
which is similar to this fix, see quirk_e100_interrupt()) or dev_info().

If there is something wrong and we activate a workaround,
let the user know about it, at least for now.

User impact is minimal and users with graphical boot up don't see
kernel messages anyway.

> I think we also need to ack any outstanding interrupts after disabling
> them in IER by writing IIR back on itself. Can you test that?

Can you go into more detail why we need this?

Looking at the logic diagram at page 23 of this document
http://intellinuxgraphics.org/documentation/SNB/IHD_OS_Vol3_Part2.pdf

tells me we don't necessarily need this, no interrupt should slip through.

Also the i915 driver first disables IER and then clears IIR
in drivers/gpu/drm/i915/i915_irq.c: ivybridge_irq_handler()
or ironlake_irq_handler(). So it always initializes the GPU to
a sane state before enabling the interrupts.

Thanks,
Thomas
