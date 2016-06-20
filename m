Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 20 Jun 2016 16:25:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: wim@djo.tudelft.nl, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, perex@perex.cz,
	linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
Message-ID: <20160620212507.GA24086@localhost>
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2999417.fp4mqtxYS2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Sinan]

On Mon, Jun 20, 2016 at 03:02:57AM +0200, Rafael J. Wysocki wrote:
> You should CC the linux-pci too (done now)
> 
> On Monday, June 20, 2016 02:35:30 AM Wim Osterholt wrote:
> > L.S.
> > up to vanilla kernel-4.6.2 sound was working fine.
> > Switching to kernel-4.7.0-rc3 made sound disappear. No /dev/mixer etc.
> > There appears to be a bug in the Intel sound driver and/or ACPI driver.
> > Dmesg shows interesting lines like:
> > [   11.498592] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
> > [   11.498605] PCI: setting IRQ 7 as level-triggered
> > [   11.543903] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
> > [   12.757735] genirq: Flags mismatch irq 7. 00000080 (snd_intel8x0m) vs. 00000000 (parport0)
> > [   12.757751] snd_intel8x0m 0000:00:1f.6: unable to grab IRQ 7
> > [   12.757875] snd_intel8x0m: probe of 0000:00:1f.6 failed with error -16
> > [   12.900171] genirq: Flags mismatch irq 7. 00000080 (snd_intel8x0) vs. 00000000 (parport0)
> > [   12.900189] snd_intel8x0 0000:00:1f.5: unable to grab IRQ 7
> > [   12.900389] snd_intel8x0: probe of 0000:00:1f.5 failed with error -16
> > [   12.922554] genirq: Flags mismatch irq 7. 00000080 (ipw2200) vs. 00000000 (parport0)
> > [   12.922559] ipw2200: Error allocating IRQ 7
> > 
> > If I boot kernel-4.7.0-rc3 with acpi=off  then sound is back!
> > 
> > If you need the full dmesg outputs then please get them here:
> > http://webserver.djo.tudelft.nl/dmesg460+ACPI
> > http://webserver.djo.tudelft.nl/dmesg473+ACPI
> > http://webserver.djo.tudelft.nl/dmesg473noACPI
> > (with excuses for the silly hostname which is out of our control)

I think snd_intel8x0 (00:1f.5) is connected to LNKB, and in v4.6 LNKB
was set to IRQ 5, while in v4.7 LNKB is connected to IRQ7.  It looks
like IRQ7 is already in use by parport, which doesn't want to share
it.

This might be related to Sinan's changes to pci_link.c, which
were merged for 4.7:

  9e5ed6d1fb87 ACPI,PCI,IRQ: remove SCI penalize function
  1fcb6a813c4f ACPI,PCI,IRQ: remove redundant code in acpi_irq_penalty_init()
  5c5087a55390 ACPI,PCI,IRQ: reduce static IRQ array size to 16
  103544d86976 ACPI,PCI,IRQ: reduce resource requirements

I don't think we intended to change any behavior with those patches,
but maybe we did.  Could you confirm/deny that those patches are
related?  If they're not, bisection might be the quickest way to
find the problem.

Bjorn
