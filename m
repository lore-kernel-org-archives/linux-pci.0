Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37253 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758703AbbGHMzJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2015 08:55:09 -0400
Date: Wed, 8 Jul 2015 14:55:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org
Subject: Re: [PATCH v2 1/3] x86/pci/intel_mid_pci: work around for IRQ0
 assignment
In-Reply-To: <1436354059-130135-2-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1507081453310.5134@nanos>
References: <1436354059-130135-1-git-send-email-andriy.shevchenko@linux.intel.com> <1436354059-130135-2-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 8 Jul 2015, Andy Shevchenko wrote:
> A few devices on Intel Edison board (Intel Tangier) has IRQ0 as an IRQ line in
> the PCI configuration. The actual one which is using that is a first eMMC host
> controller.

You fail to explain that the other devices have a bogus PCI configuration.

> In case we compile sdhci-pci as a module and leave serial driver built-in,
> first serial device not in use and has IRQ0 assigned as well, the latter takes
> the interrupt allocation.

We are really not interested in the details of whats compiled in or
not and which other device is acquiring the interrupt. What matters
is: It's an init ordering problem.
 
> The result of such behaviour is impossibility to
> allocate the interrupt by sdhci-pci driver.
> 
> This patch introduces a quirk inside intel_mid_pci_irq_enable() to avoid
> described behaviour.

That's pretty useless. You tell the reader that you add a quirk, which
is hardly interesting because the subject line already talks about a
workaround. You fail to tell WHAT the quirk is doing.

Aside of that, starting a sentence in a changelog with "This patch" is
silly. We already know that THIS is a patch.

Let me rephrase the whole thing:

"On Intel Tangier the MMC host controller is wired up to irq 0. But
 several other devices have irq 0 associated as well due to a bogus
 PCI configuration.

 The first initialized driver will acquire irq 0 and make it
 unavailable for other devices. If the sdhci driver is not the first
 one it will fail to acquire the interrupt and therefor be non
 functional.

 Add a quirk to the pci irq enable function which denies irq 0 to
 anything else than the MMC host controller driver on Tangier
 platforms."

Can you see the difference?
 
> +#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
> +

Please add defines at the top of the file, not just randomly in the
middle of the code.

>  static int intel_mid_pci_irq_enable(struct pci_dev *dev)
>  {
>  	struct irq_alloc_info info;
>  	int polarity;
>  	int ret;
>  
> -	if (dev->irq_managed && dev->irq > 0)
> +	if (dev->irq_managed && dev->irq >= 0)
>  		return 0;

What's the point here? Can dev->irq_managed be set and dev->irq be < 0?

> +	/* Special treatment for IRQ0 */
> +	if (dev->irq == 0) {
> +		switch (intel_mid_identify_cpu()) {
> +		case INTEL_MID_CPU_CHIP_TANGIER:
> +			/*
> +			 * TNG has IRQ0 assigned to eMMC controller. This makes
> +			 * it happy to get an interrupt.

It's nice that you want to make the eMMC controller happy, but I doubt
that the silicon actually cares.

Please add a proper comment explaining the issue at hand.

> +			 */
> +			if (dev->device != PCI_DEVICE_ID_INTEL_MRFL_MMC)
> +				return -EBUSY;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
>  	/* Set IRQ polarity */
>  	if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
>  		polarity = 0; /* active high */

So now we have:

       if (dev->irq == 0) {
       	     switch(intel_mid_identify_cpu()) {
	     case INTEL_MID_CPU_CHIP_TANGIER:
  	     ....
       }

and right after that:

       if (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_TANGIER)
       	  ....

That's just silly. Whats wrong with:

       switch (intel_mid_identify_cpu()) {
       case INTEL_MID_CPU_CHIP_TANGIER:
       	    polarity = 0;
	    if (dev->irq == 0) {
	       ....
	    }
	    break;
       default:
            polarity = 1;
       }

Hmm?

	tglx
