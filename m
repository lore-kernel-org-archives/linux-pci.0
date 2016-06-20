Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan> <20160620212507.GA24086@localhost>
Cc: wim@djo.tudelft.nl, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57686D67.8010201@codeaurora.org>
Date: Mon, 20 Jun 2016 18:25:43 -0400
MIME-Version: 1.0
In-Reply-To: <20160620212507.GA24086@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 6/20/2016 5:25 PM, Bjorn Helgaas wrote:
> [+cc Sinan]
> 
> On Mon, Jun 20, 2016 at 03:02:57AM +0200, Rafael J. Wysocki wrote:
>> You should CC the linux-pci too (done now)
>>
>> On Monday, June 20, 2016 02:35:30 AM Wim Osterholt wrote:
>>> L.S.
>>> up to vanilla kernel-4.6.2 sound was working fine.
>>> Switching to kernel-4.7.0-rc3 made sound disappear. No /dev/mixer etc.
>>> There appears to be a bug in the Intel sound driver and/or ACPI driver.
>>> Dmesg shows interesting lines like:
>>> [   11.498592] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 7
>>> [   11.498605] PCI: setting IRQ 7 as level-triggered
>>> [   11.543903] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
>>> [   12.757735] genirq: Flags mismatch irq 7. 00000080 (snd_intel8x0m) vs. 00000000 (parport0)
>>> [   12.757751] snd_intel8x0m 0000:00:1f.6: unable to grab IRQ 7
>>> [   12.757875] snd_intel8x0m: probe of 0000:00:1f.6 failed with error -16
>>> [   12.900171] genirq: Flags mismatch irq 7. 00000080 (snd_intel8x0) vs. 00000000 (parport0)
>>> [   12.900189] snd_intel8x0 0000:00:1f.5: unable to grab IRQ 7
>>> [   12.900389] snd_intel8x0: probe of 0000:00:1f.5 failed with error -16
>>> [   12.922554] genirq: Flags mismatch irq 7. 00000080 (ipw2200) vs. 00000000 (parport0)
>>> [   12.922559] ipw2200: Error allocating IRQ 7
>>>
>>> If I boot kernel-4.7.0-rc3 with acpi=off  then sound is back!
>>>
>>> If you need the full dmesg outputs then please get them here:
>>> http://webserver.djo.tudelft.nl/dmesg460+ACPI
>>> http://webserver.djo.tudelft.nl/dmesg473+ACPI
>>> http://webserver.djo.tudelft.nl/dmesg473noACPI
>>> (with excuses for the silly hostname which is out of our control)
> 
> I think snd_intel8x0 (00:1f.5) is connected to LNKB, and in v4.6 LNKB
> was set to IRQ 5, while in v4.7 LNKB is connected to IRQ7.  It looks
> like IRQ7 is already in use by parport, which doesn't want to share
> it.
> 
> This might be related to Sinan's changes to pci_link.c, which
> were merged for 4.7:
> 
>   9e5ed6d1fb87 ACPI,PCI,IRQ: remove SCI penalize function
>   1fcb6a813c4f ACPI,PCI,IRQ: remove redundant code in acpi_irq_penalty_init()
>   5c5087a55390 ACPI,PCI,IRQ: reduce static IRQ array size to 16
>   103544d86976 ACPI,PCI,IRQ: reduce resource requirements
> 
> I don't think we intended to change any behavior with those patches,
> but maybe we did.  Could you confirm/deny that those patches are
> related?  If they're not, bisection might be the quickest way to
> find the problem.
> 

I agree. The intention was not to change the existing behavior. 
I am trying to decode what this means.

[    0.305642] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
[    0.306365] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
[    0.307078] ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
[    0.307791] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)

It looks like the syntax is ((possible irqs) *active irq)

It looks like both 5 and 7 are possible for LNKB and 11 is the active IRQ. 

Since 5 and 7 are listed as possible, I don't understand what makes 7
not a good IRQ. 

Anyhow, I did some code inspection. I am seeing some problems around the
acpi_irq_get_penalty function. The acpi_irq_get_penalty function
is both a get and set function for PCI IRQs. However, it looks like
we are accounting the penalty twice when using ISA IRQs.

Can you try the following and see if it makes any difference?


--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -500,7 +500,7 @@ static int acpi_irq_get_penalty(int irq)
        int penalty = 0;

        if (irq < ACPI_MAX_ISA_IRQS)
-               penalty += acpi_isa_irq_penalty[irq];
+               return acpi_isa_irq_penalty[irq];

        /*
        * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
@@ -586,6 +586,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
                            acpi_device_bid(link->device));
                return -ENODEV;
        } else {
+               if (irq < ACPI_MAX_ISA_IRQS)
+                       acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+                                                       PIRQ_PENALTY_PCI_USING;
+



> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
