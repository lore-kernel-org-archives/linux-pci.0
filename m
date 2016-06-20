Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57294 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751725AbcFTA6m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2016 20:58:42 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: wim@djo.tudelft.nl
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	perex@perex.cz, linux-pci@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
Date: Mon, 20 Jun 2016 03:02:57 +0200
Message-ID: <2999417.fp4mqtxYS2@vostro.rjw.lan>
In-Reply-To: <20160620003530.GA19571@djo.tudelft.nl>
References: <20160620003530.GA19571@djo.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

You should CC the linux-pci too (done now)

On Monday, June 20, 2016 02:35:30 AM Wim Osterholt wrote:
> L.S.
> up to vanilla kernel-4.6.2 sound was working fine.
> Switching to kernel-4.7.0-rc3 made sound disappear. No /dev/mixer etc.
> There appears to be a bug in the Intel sound driver and/or ACPI driver.
> Dmesg shows interesting lines like:
> [   11.498592] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
> [   11.498605] PCI: setting IRQ 7 as level-triggered
> [   11.543903] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
> [   12.757735] genirq: Flags mismatch irq 7. 00000080 (snd_intel8x0m) vs. 00000000 (parport0)
> [   12.757751] snd_intel8x0m 0000:00:1f.6: unable to grab IRQ 7
> [   12.757875] snd_intel8x0m: probe of 0000:00:1f.6 failed with error -16
> [   12.900171] genirq: Flags mismatch irq 7. 00000080 (snd_intel8x0) vs. 00000000 (parport0)
> [   12.900189] snd_intel8x0 0000:00:1f.5: unable to grab IRQ 7
> [   12.900389] snd_intel8x0: probe of 0000:00:1f.5 failed with error -16
> [   12.922554] genirq: Flags mismatch irq 7. 00000080 (ipw2200) vs. 00000000 (parport0)
> [   12.922559] ipw2200: Error allocating IRQ 7
> 
> If I boot kernel-4.7.0-rc3 with acpi=off  then sound is back!
> 
> If you need the full dmesg outputs then please get them here:
> http://webserver.djo.tudelft.nl/dmesg460+ACPI
> http://webserver.djo.tudelft.nl/dmesg473+ACPI
> http://webserver.djo.tudelft.nl/dmesg473noACPI
> (with excuses for the silly hostname which is out of our control)
> 
> Regards, Wim.
> 
> 
> ----- wim@djo.tudelft.nl -----

