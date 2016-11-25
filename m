Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nm30-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.126]:49004 "EHLO
        nm30-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932231AbcKYQxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 11:53:05 -0500
Date: Fri, 25 Nov 2016 14:53:00 -0200
From: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-usb@vger.kernel.org
Subject: Re: Multiple problems with the Linux kernel on an AMD desktop
Message-ID: <20161125164622.tstsfztyojedi77b@ime.usp.br>
References: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
 <5e4a6800-251f-23e7-11f5-9993280fe8d5@ladisch.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oq4pym2kazhnr727"
In-Reply-To: <5e4a6800-251f-23e7-11f5-9993280fe8d5@ladisch.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--oq4pym2kazhnr727
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi, Clemens and Borislav.

On Nov 25 2016, Clemens Ladisch wrote:
> Rogério Brito wrote:
> > * I have never been able to boot this computer of mine without the option
> >   irqpoll---otherwise, I get the nobody cared message.
> 
> The "nobody cared" message indicates that there were too many interrupts
> that no driver felt responsible for, so the kernel has disabled that
> interrupt vector.  The irqpoll option is a workaround to get the devices
> on that interrupt vector to work, but it's not perfect.

Ah, great to know. I don't know if this is related or not, but I read
somewhere (don't remember where) that the machine may have performance
slightly reduced when irqpoll is used.

> It's possible that most of your problems are caused by the irqpoll option.

Excellent to know.

> What IRQ is the problematic one (see the "nobody cared" message)?  What
> devices are connected to it (see /proc/interrupts)?

>From the dmesg log, the interrupt is 18.

Here is part from /proc/interrupts that contains interrupt 18 *without* irqpoll:

---------------------------
           CPU0       CPU1       CPU2       CPU3       
  0:         47          0          0          0   IO-APIC   2-edge      timer
  1:          0          0          0          2   IO-APIC   1-edge      i8042
  7:          0          0          0          0   IO-APIC   7-edge      parport0
  8:          0          0          0          1   IO-APIC   8-edge      rtc0
  9:          0          0          0          0   IO-APIC   9-fasteoi   acpi
 10:          0          0          0          0   IO-APIC  10-edge      radeon
 12:          0          0          0          4   IO-APIC  12-edge      i8042
 16:          0         96          4        990   IO-APIC  16-fasteoi   ohci_hcd:usb3, ohci_hcd:usb4, snd_hda_intel:card0
 17:          0       2457          1        140   IO-APIC  17-fasteoi   ehci_hcd:usb1
 18:          1         11         43      99947   IO-APIC  18-fasteoi   ohci_hcd:usb5, ohci_hcd:usb6, ohci_hcd:usb7
 19:          0          0          0          0   IO-APIC  19-fasteoi   ehci_hcd:usb2
 22:          0      22169        139       8731   IO-APIC  22-fasteoi   ahci[0000:00:11.0]
 25:          0          0         11        753   PCI-MSI 1048576-edge      eth0
(...)
---------------------------

Here is part from /proc/interrupts that contains interrupt 18 *with* irqpoll:

---------------------------
           CPU0       CPU1       CPU2       CPU3       
  0:         46          0          0          0   IO-APIC   2-edge      timer
  1:          0          0          0          2   IO-APIC   1-edge      i8042
  7:          0          0          0          0   IO-APIC   7-edge      parport0
  8:          0          0          0          1   IO-APIC   8-edge      rtc0
  9:          0          0          0          0   IO-APIC   9-fasteoi   acpi
 10:          0          0          0          0   IO-APIC  10-edge      radeon
 12:          0          0          0          4   IO-APIC  12-edge      i8042
 16:          0        103          6        983   IO-APIC  16-fasteoi   ohci_hcd:usb3, ohci_hcd:usb4, snd_hda_intel:card0
 17:          0        588          0        144   IO-APIC  17-fasteoi   ehci_hcd:usb1
 18:          0          0          0        705   IO-APIC  18-fasteoi   ohci_hcd:usb5, ohci_hcd:usb6, ohci_hcd:usb7
 19:          0          0          0          0   IO-APIC  19-fasteoi   ehci_hcd:usb2
 22:          0      18049          4       8540   IO-APIC  22-fasteoi   ahci[0000:00:11.0]
 25:          0          0          0        327   PCI-MSI 1048576-edge      eth0
(...)
---------------------------

I'm attaching both files to this message.

> Does the problem go away when you prevent the corresponding driver(s) from
> loading?

Since the OHCI_HCD driver is built-in (as opposed to a module), I don't know
how to disable it. I can try to recompile the kernel with it as a module and
rename it as some garbage, so that it doesn't get loaded...


Thanks a lot,

-- 
Rogério Brito : rbrito@{ime.usp.br,gmail.com} : GPG key 4096R/BCFCAAAA
http://rb.doesntexist.org/blog : Projects : https://github.com/rbrito/
DebianQA: http://qa.debian.org/developer.php?login=rbrito%40ime.usp.br

--oq4pym2kazhnr727
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="proc-interrupts-without-irqpoll.txt"

           CPU0       CPU1       CPU2       CPU3       
  0:         47          0          0          0   IO-APIC   2-edge      timer
  1:          0          0          0          2   IO-APIC   1-edge      i8042
  7:          0          0          0          0   IO-APIC   7-edge      parport0
  8:          0          0          0          1   IO-APIC   8-edge      rtc0
  9:          0          0          0          0   IO-APIC   9-fasteoi   acpi
 10:          0          0          0          0   IO-APIC  10-edge      radeon
 12:          0          0          0          4   IO-APIC  12-edge      i8042
 16:          0         96          4        990   IO-APIC  16-fasteoi   ohci_hcd:usb3, ohci_hcd:usb4, snd_hda_intel:card0
 17:          0       2457          1        140   IO-APIC  17-fasteoi   ehci_hcd:usb1
 18:          1         11         43      99947   IO-APIC  18-fasteoi   ohci_hcd:usb5, ohci_hcd:usb6, ohci_hcd:usb7
 19:          0          0          0          0   IO-APIC  19-fasteoi   ehci_hcd:usb2
 22:          0      22169        139       8731   IO-APIC  22-fasteoi   ahci[0000:00:11.0]
 25:          0          0         11        753   PCI-MSI 1048576-edge      eth0
NMI:          0          1          0          1   Non-maskable interrupts
LOC:      21775      27088      24588      25944   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          0          1          0          1   Performance monitoring interrupts
IWI:       7478       8807       8179       9891   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:      33580      59725      52413      52928   Rescheduling interrupts
CAL:       1391       1549       1382       1159   Function call interrupts
TLB:        339        433        357        391   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:          2          2          2          2   Machine check polls
ERR:          1
MIS:          0
PIN:          0          0          0          0   Posted-interrupt notification event
PIW:          0          0          0          0   Posted-interrupt wakeup event

--oq4pym2kazhnr727
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="proc-interrupts-with-irqpoll.txt"

           CPU0       CPU1       CPU2       CPU3       
  0:         46          0          0          0   IO-APIC   2-edge      timer
  1:          0          0          0          2   IO-APIC   1-edge      i8042
  7:          0          0          0          0   IO-APIC   7-edge      parport0
  8:          0          0          0          1   IO-APIC   8-edge      rtc0
  9:          0          0          0          0   IO-APIC   9-fasteoi   acpi
 10:          0          0          0          0   IO-APIC  10-edge      radeon
 12:          0          0          0          4   IO-APIC  12-edge      i8042
 16:          0        103          6        983   IO-APIC  16-fasteoi   ohci_hcd:usb3, ohci_hcd:usb4, snd_hda_intel:card0
 17:          0        588          0        144   IO-APIC  17-fasteoi   ehci_hcd:usb1
 18:          0          0          0        705   IO-APIC  18-fasteoi   ohci_hcd:usb5, ohci_hcd:usb6, ohci_hcd:usb7
 19:          0          0          0          0   IO-APIC  19-fasteoi   ehci_hcd:usb2
 22:          0      18049          4       8540   IO-APIC  22-fasteoi   ahci[0000:00:11.0]
 25:          0          0          0        327   PCI-MSI 1048576-edge      eth0
NMI:          0          0          0          0   Non-maskable interrupts
LOC:       9375      12257       9554      10339   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:          0          0          0          0   Performance monitoring interrupts
IWI:       2630       3597       2754       2847   IRQ work interrupts
RTR:          0          0          0          0   APIC ICR read retries
RES:      21855      39899      46373      29822   Rescheduling interrupts
CAL:       1355       1484       1388       1067   Function call interrupts
TLB:        293        580        313        364   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
DFR:          0          0          0          0   Deferred Error APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:          1          1          1          1   Machine check polls
ERR:          1
MIS:          0
PIN:          0          0          0          0   Posted-interrupt notification event
PIW:          0          0          0          0   Posted-interrupt wakeup event

--oq4pym2kazhnr727--
