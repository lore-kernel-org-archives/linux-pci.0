Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40541 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750777AbdLZPzZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Dec 2017 10:55:25 -0500
Subject: Re: `pci_apply_final_quirks()` taking half a second
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org
References: <44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de>
 <20170408154128.GA16832@bhelgaas-glaptop.roam.corp.google.com>
From: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Message-ID: <c3a7c75b-c50e-1cde-7bb1-94df5dc51f08@molgen.mpg.de>
Date: Tue, 26 Dec 2017 16:55:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170408154128.GA16832@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,


Am 08.04.2017 um 17:41 schrieb Bjorn Helgaas:
> On Fri, Apr 07, 2017 at 11:07:15PM +0200, Paul Menzel wrote:

>> Measuring where time is spent during boot with `systemd-bootchart`
>> on an Asus A780FullHD, it turns out that half a second is spent in
>> `pci_apply_final_quirks()`.
> 
> I agree, that seems like a crazy amount of time.
> 
> Can you figure out how to turn on pr_debug() (via the dynamic debug
> mess or whatever) and boot with "initcall_debug"?  That should tell us
> how long each quirk took.

I am sorry for taking so long to reply. I finally added `dyndbg=file 
quirks.c +p` to the command line of Linux 4.13.13. This is on another 
AMD system (Asus F285M Pro).

```
[…]
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for 0000:00:00.0
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_no_pm_reset+0x0/0x20 returned after 0 usecs for 0000:00:01.0
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for 0000:00:18.0
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for 0000:00:18.1
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for 0000:00:18.2
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for 0000:00:18.3
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for 0000:00:18.4
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for 0000:00:18.5
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
pci_fixup_video+0x0/0x110 returned after 4 usecs for 0000:00:01.0
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_usb_early_handoff+0x0/0x6b0 returned after 197 usecs for 0000:00:10.0
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_usb_early_handoff+0x0/0x6b0 returned after 127 usecs for 0000:00:10.1
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_usb_early_handoff+0x0/0x6b0 returned after 88643 usecs for 
0000:00:12.0
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_usb_early_handoff+0x0/0x6b0 returned after 137 usecs for 0000:00:12.2
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for 0000:00:12.2
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_usb_early_handoff+0x0/0x6b0 returned after 85770 usecs for 
0000:00:13.0
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_usb_early_handoff+0x0/0x6b0 returned after 134 usecs for 0000:00:13.2
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for 0000:00:13.2
Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup 
quirk_usb_early_handoff+0x0/0x6b0 returned after 125 usecs for 
0000:03:00.0[…]
```

So it’s `pci fixup quirk_usb_early_handoff` taking around 85 ms, and 
that twice.

>> Here are the times copied from the SVG:
>>
>>    init_ladder 0.012s
>>    init_menu 0.012s
>>    pm_sysrq_init 0.012s
>>    acpi_init 0.027s
>>    pci_subsys_init 0.008s
>>    hpet_late_init 0.004s
>>    tracer_init_tracefs 0.002s
>>    event_trace_init 0.008s
>>    pnpacpi_init 0.002s
>>    chr_dev_init 0.003s
>>    init_acpi_pm_clocksource 0.004s
>>    pci_apply_final_quirks 0.452s
>>    populate_rootfs 0.400s
>>    pci_iommu_init 0.003s
>>    rsa_init 0.058s
>>    serial8250_init 0.020s
>>    i8042_init 0.003s
>>    load_system_certificate_list 0.002s
>>    ata_init 0.007s
>>    ehci_pci_init 0.030s
>>    ohci_pci_init 0.312s
>>    ahci_pci_driver_init 0.342s
>>    atiixp_pci_driver_init 0.337s
>>    hid_init 0.004s
>>    init_sr 0.031s

[…]
>> It’d be great, if the times could be reduced, so that the time from
>> GRUB to entering the LUKS passphrase gets smaller.


Kind regards,

Paul
