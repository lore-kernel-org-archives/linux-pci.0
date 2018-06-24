Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:53807 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751034AbeFXQtz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 Jun 2018 12:49:55 -0400
Subject: `quirk_usb_handoff_ohci` takes over 73 ms (twice) on AMD system (was:
 `pci_apply_final_quirks()` taking half a second)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1712311607450.15484-100000@netrider.rowland.org>
From: Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Message-ID: <5e89a3ad-2210-800f-89b9-17152b5ad7c8@molgen.mpg.de>
Date: Sun, 24 Jun 2018 18:49:51 +0200
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1712311607450.15484-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Alan,


Sorry for the long delay.

Am 31.12.2017 um 22:16 schrieb Alan Stern:
> On Sun, 31 Dec 2017, Paul Menzel wrote:
> 
>> Am 29.12.2017 um 17:14 schrieb Alan Stern:
>>> On Thu, 28 Dec 2017, Bjorn Helgaas wrote:
>>>
>>>> On Tue, Dec 26, 2017 at 04:55:20PM +0100, Paul Menzel wrote:

[…]

>>>>> So it’s `pci fixup quirk_usb_early_handoff` taking around 85 ms, and
>>>>> that twice.
>>>>
>>>> Wow.  That's pretty painful, but of course I don't know how to fix it.
>>>> From looking at quirk_usb_early_handoff(), it may depend on BIOS
>>>> details.  Maybe the USB folks will have some ideas.
>>>
>>> Can we see the output from lspci?  It would help to know what the 12.0
>>> and 13.0 devices are.
>>
>> Sorry, that was trimmed from the original message. Here is the output
>> from the ASRock A780FullD.
>>
>>> ```
>>> $ more /proc/version
>>> Linux version 4.9.0-0.bpo.2-amd64 (debian-kernel@lists.debian.org)
>>> (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP Debian 4.9.13-1~bpo8+1 (2017-02-27)
>>> $ lspci -nn
> 
>>> 00:12.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
>>> 00:12.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
>>> 00:12.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
>>> 00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
>>> 00:13.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
>>> 00:13.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
> 
>> So far, this can be reproduce on all AMD systems I have (ASRock
>> A780FullHD, ASRock E350M1, Asus F2A85-M Pro).
> 
> So they are OHCI controllers.  You could add some debugging statements
> to quirk_usb_handoff_ohci() to try and locate the part that's taking so
> long.

>  737 static void quirk_usb_handoff_ohci(struct pci_dev *pdev)
>  738 {
>  739         void __iomem *base;
>  740         u32 control;
>  741         u32 fminterval = 0;
>  742         bool no_fminterval = false;
>  743         int cnt;
>  744 
>  745         if (!mmio_resource_enabled(pdev, 0))
>  746                 return;
>  747 
>  748         base = pci_ioremap_bar(pdev, 0);
>  749         if (base == NULL)
>  750                 return;
>  751 
>  752         /*
>  753          * ULi M5237 OHCI controller locks the whole system when accessing
>  754          * the OHCI_FMINTERVAL offset.
>  755          */
>  756         if (pdev->vendor == PCI_VENDOR_ID_AL && pdev->device == 0x5237)
>  757                 no_fminterval = true;
>  758 
>  759         control = readl(base + OHCI_CONTROL);
>  760 
>  761         printk(KERN_INFO "1\n");
>  762 /* On PA-RISC, PDC can leave IR set incorrectly; ignore it there. */
>  763 #ifdef __hppa__
>  764 #define OHCI_CTRL_MASK          (OHCI_CTRL_RWC | OHCI_CTRL_IR)
>  765 #else
>  766 #define OHCI_CTRL_MASK          OHCI_CTRL_RWC
>  767 
>  768         if (control & OHCI_CTRL_IR) {
>  769                 int wait_time = 500; /* arbitrary; 5 seconds */
>  770                 writel(OHCI_INTR_OC, base + OHCI_INTRENABLE);
>  771                 writel(OHCI_OCR, base + OHCI_CMDSTATUS);
>  772                 while (wait_time > 0 &&
>  773                                 readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
>  774                         wait_time -= 10;
>  775                         msleep(10);
>  776                 }
>  777                 if (wait_time <= 0)
>  778                         dev_warn(&pdev->dev,
>  779                                  "OHCI: BIOS handoff failed (BIOS bug?) %08x\n",
>  780                                  readl(base + OHCI_CONTROL));
>  781         }
>  782 #endif
>  783 
>  784         printk(KERN_INFO "2\n");
>  785         /* disable interrupts */
>  786         writel((u32) ~0, base + OHCI_INTRDISABLE);
>  787 
>  788         printk(KERN_INFO "3\n");
>  789         /* Reset the USB bus, if the controller isn't already in RESET */
>  790         if (control & OHCI_HCFS) {
>  791                 /* Go into RESET, preserving RWC (and possibly IR) */
>  792                 writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
>  793                 readl(base + OHCI_CONTROL);
>  794 
>  795                 /* drive bus reset for at least 50 ms (7.1.7.5) */
>  796                 msleep(50);
>  797         }
>  798         printk(KERN_INFO "4\n");
>  799 
>  800         /* software reset of the controller, preserving HcFmInterval */
>  801         if (!no_fminterval)
>  802                 fminterval = readl(base + OHCI_FMINTERVAL);
>  803 
>  804         writel(OHCI_HCR, base + OHCI_CMDSTATUS);
>  805         printk(KERN_INFO "5\n");
>  806 
>  807         /* reset requires max 10 us delay */
>  808         for (cnt = 30; cnt > 0; --cnt) {        /* ... allow extra time */
>  809                 printk(KERN_INFO "6 cnt = %d\n", cnt);
>  810                 if ((readl(base + OHCI_CMDSTATUS) & OHCI_HCR) == 0)
>  811                         break;
>  812                 udelay(1);
>  813         }
>  814 
>  815         printk(KERN_INFO "7\n");
>  816         if (!no_fminterval)
>  817                 writel(fminterval, base + OHCI_FMINTERVAL);
>  818 
>  819         /* Now the controller is safely in SUSPEND and nothing can wake it up */
>  820         iounmap(base);
>  821 }

Here is the result.

> [    0.062796] pci 0000:00:12.0: calling  quirk_usb_early_handoff+0x0/0x700 @ 1
> [    0.062860] 1
> [    0.086662] 2

Around 24 ms are spent in the loop checking `readl(base + OHCI_CONTROL) 
& OHCI_CTRL_IR)` in line 772.

> [    0.086663] 3
> [    0.138645] 4

That’s the 50 ms from resetting the USB bus, if the controller isn't 
already in RESET in line 796.

> [    0.138647] 5
> [    0.138649] 6 cnt = 30
> [    0.138650] 7
> [    0.138771] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x700 took 74188 usecs
> [    0.138778] pci 0000:00:12.2: calling  quirk_usb_early_handoff+0x0/0x700 @ 1
> [    0.138917] pci 0000:00:12.2: quirk_usb_early_handoff+0x0/0x700 took 133 usecs
> [    0.138919] pci 0000:00:12.2: calling  pci_fixup_amd_ehci_pme+0x0/0x30 @ 1
> [    0.138920] pci 0000:00:12.2: PME# does not work under D3, disabling it
> [    0.138922] pci 0000:00:12.2: pci_fixup_amd_ehci_pme+0x0/0x30 took 0 usecs
> [    0.138926] pci 0000:00:13.0: calling  quirk_usb_early_handoff+0x0/0x700 @ 1
> [    0.138987] 1
> [    0.161639] 2
> [    0.161640] 3
> [    0.213622] 4
> [    0.213625] 5
> [    0.213626] 6 cnt = 30
> [    0.213627] 7
> [    0.213748] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x700 took 73062 usecs

So, is there a way to not reset the controller? In my case the firmware 
and GRUB already used the controller and set it up.

Additionally, can this be done in parallel for both PCI devices?

Can you think of other ways to decrease the time?


Kind regards,

Paul
