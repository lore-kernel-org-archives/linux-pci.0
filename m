Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbdDHPld (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Apr 2017 11:41:33 -0400
Date: Sat, 8 Apr 2017 10:41:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: `pci_apply_final_quirks()` taking half a second
Message-ID: <20170408154128.GA16832@bhelgaas-glaptop.roam.corp.google.com>
References: <44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 07, 2017 at 11:07:15PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Measuring where time is spent during boot with `systemd-bootchart`
> on an Asus A780FullHD, it turns out that half a second is spent in
> `pci_apply_final_quirks()`.

I agree, that seems like a crazy amount of time.

Can you figure out how to turn on pr_debug() (via the dynamic debug
mess or whatever) and boot with "initcall_debug"?  That should tell us
how long each quirk took.

> Here are the times copied from the SVG:
> 
>   init_ladder 0.012s
>   init_menu 0.012s
>   pm_sysrq_init 0.012s
>   acpi_init 0.027s
>   pci_subsys_init 0.008s
>   hpet_late_init 0.004s
>   tracer_init_tracefs 0.002s
>   event_trace_init 0.008s
>   pnpacpi_init 0.002s
>   chr_dev_init 0.003s
>   init_acpi_pm_clocksource 0.004s
>   pci_apply_final_quirks 0.452s
>   populate_rootfs 0.400s
>   pci_iommu_init 0.003s
>   rsa_init 0.058s
>   serial8250_init 0.020s
>   i8042_init 0.003s
>   load_system_certificate_list 0.002s
>   ata_init 0.007s
>   ehci_pci_init 0.030s
>   ohci_pci_init 0.312s
>   ahci_pci_driver_init 0.342s
>   atiixp_pci_driver_init 0.337s
>   hid_init 0.004s
>   init_sr 0.031s
> 
> I don’t know what information you need, so I just include the Linux
> Kernel version, and the output of `lspci -nn`.
> 
> ```
> $ more /proc/version
> Linux version 4.9.0-0.bpo.2-amd64 (debian-kernel@lists.debian.org)
> (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP Debian 4.9.13-1~bpo8+1
> (201
> 7-02-27)
> $ lspci -nn
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] RS780
> Host Bridge [1022:9600]
> 00:01.0 PCI bridge [0604]: ASRock Incorporation Device [1849:9602]
> 00:09.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
> RS780/RS880 PCI to PCI bridge (PCIE port 4) [1022:9608]
> 00:0a.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
> RS780/RS880 PCI to PCI bridge (PCIE port 5) [1022:9609]
> 00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391]
> 00:12.0 USB controller [0c03]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
> 00:12.1 USB controller [0c03]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
> 00:12.2 USB controller [0c03]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
> 00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
> 00:13.1 USB controller [0c03]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
> 00:13.2 USB controller [0c03]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
> SMBus Controller [1002:4385] (rev 3a)
> 00:14.1 IDE interface [0101]: Advanced Micro Devices, Inc. [AMD/ATI]
> SB7x0/SB8x0/SB9x0 IDE Controller [1002:439c]
> 00:14.2 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI]
> SBx00 Azalia (Intel HDA) [1002:4383]
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD/ATI]
> SB7x0/SB8x0/SB9x0 LPC host controller [1002:439d]
> 00:14.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI]
> SBx00 PCI to PCI Bridge [1002:4384]
> 00:14.5 USB controller [0c03]: Advanced Micro Devices, Inc.
> [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller [1002:4399]
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8
> [Athlon64/Opteron] HyperTransport Technology Configuration
> [1022:1100]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8
> [Athlon64/Opteron] Address Map [1022:1101]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8
> [Athlon64/Opteron] DRAM Controller [1022:1102]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8
> [Athlon64/Opteron] Miscellaneous Control [1022:1103]
> 01:05.0 VGA compatible controller [0300]: Advanced Micro Devices,
> Inc. [AMD/ATI] RS780 [Radeon HD 3200] [1002:9610]
> 04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
> [10ec:8168] (rev 02)
> ```
> 
> It’d be great, if the times could be reduced, so that the time from
> GRUB to entering the LUKS passphrase gets smaller.
> 
> 
> Kind regards,
> 
> Paul
