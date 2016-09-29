Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
Date: Thu, 29 Sep 2016 11:10:49 +0200
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
References: <201609251512.05657.linux@rainbow-software.org> <201609282123.48506.linux@rainbow-software.org> <946fcb62-272b-61b3-9afa-7c27a1ce7419@codeaurora.org>
In-Reply-To: <946fcb62-272b-61b3-9afa-7c27a1ce7419@codeaurora.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201609291110.50176.linux@rainbow-software.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 29 September 2016, Sinan Kaya wrote:
> On 9/28/2016 3:23 PM, Ondrej Zary wrote:
> > On Wednesday 28 September 2016 20:22:40 Sinan Kaya wrote:
> >> On 9/28/2016 1:02 PM, Ondrej Zary wrote:
> >>>> Thanks, It sounds like you have more than one machine with similar
> >>>>
> >>>>> problems. Can you collect the log from the other machines with
> >>>>> 4.8-rc8?
> >>>>>
> >>>>> and also a boot log with 4.6 kernel where things are working?
> >>>
> >>> The attached logs are from another machine:
> >>>
> >>> dmesg-bad-debug.txt: 4.8-rc8 with your debug patch - bad
> >>>
> >>> dmesg-reverted.txt: 4.8-rc8 with patches (as per Rafael's suggestion)
> >>> reverted - good
> >>>
> >>> dmesg-3.6.txt: 4.6 (Debian kernel) - good
> >>
> >> I think I see a race condition for the SCI interrupt. I need another
> >> dump from 4.8-rc8 with the attached patch to confirm. Let's remove the
> >> previous one and apply this one.
> >
> > dmesg-reverted.txt: 4.8-rc8 w/patches reverted (good)
> > $ head /proc/interrupts
> >            CPU0
> >   0:       8531    XT-PIC  timer
> >   1:          9    XT-PIC  i8042
> >   2:          0    XT-PIC  cascade
> >   8:          1    XT-PIC  rtc0
> >  11:        713    XT-PIC  acpi, uhci_hcd:usb1, uhci_hcd:usb2, nvkm, eth0
> >  12:        161    XT-PIC  i8042
> >  14:       4042    XT-PIC  pata_via
> >  15:          0    XT-PIC  pata_via
> > NMI:          0   Non-maskable interrupts
> >
> > dmesg-bad-debug.txt: 4.8-rc8 (bad)
> > $ head /proc/interrupts
> >            CPU0
> >   0:       8027    XT-PIC  timer
> >   1:        286    XT-PIC  i8042
> >   2:          0    XT-PIC  cascade
> >   8:          1    XT-PIC  rtc0
> >  10:          0    XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2
> >  11:          0    XT-PIC  acpi, nvkm, eth0
> >  12:        161    XT-PIC  i8042
> >  14:       4069    XT-PIC  pata_via
> >  15:          0    XT-PIC  pata_via
> >
> > (I'm moving between different machines through the day - these logs are
> > from different machine than the last ones).
>
> Can you try these patches on your machines please?

It doesn't even boot :(

ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
BUG: unable to handle kernel paging request at e3382f64
IP: [<c11ecf61>] acpi_irq_get_penalty+0x69/0xa5
*pde = 00000000
Oops: 0000 [#1] SMP
Modules linked in: 
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc8+ #114
Hardware name: System Manufacturer System Name/A7VL133, BIOS ASUS A7VL133-VM ACPI BIOS Revision 1008 06/10/2002
task: c7094000 task.stack: c7098000
EIP: 0060:[<c11ecf61>] EFLAGS: 00210202 CPU:  0
EIP is at acpi_irq_get_penalty+0x69/0xa5
...
Call Trace:
acpi_isa_irq_available
acpi_pci_irq_enable
pcibios_enable_device
do_pci_enable_device
quirk_usb_early_handoff
pci_get_subsys
pci_fixup_device
pci_apply_final_quirks
pci_proc_init
do_one_initcall
parse_args
kernel_init_freeable
kernel_init_freeable
ret_from_kernel_thread
rest_init

-- 
Ondrej Zary
