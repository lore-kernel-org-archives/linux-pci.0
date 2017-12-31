Return-Path: <SRS0=R/pL=D3=molgen.mpg.de=pmenzel@kernel.org>
Return-Path: <SRS0=R/pL=D3=molgen.mpg.de=pmenzel@kernel.org>
Subject: Re: `pci_apply_final_quirks()` taking half a second
To: Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.1712291111580.24019-100000@netrider.rowland.org>
From: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Message-ID: <b1533fd5-1fae-7256-9597-36d3d5de9d2a@molgen.mpg.de>
Date: Sun, 31 Dec 2017 08:18:07 +0100
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1712291111580.24019-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



Am 29.12.2017 um 17:14 schrieb Alan Stern:
> On Thu, 28 Dec 2017, Bjorn Helgaas wrote:
> 
>> On Tue, Dec 26, 2017 at 04:55:20PM +0100, Paul Menzel wrote:
>>> Am 08.04.2017 um 17:41 schrieb Bjorn Helgaas:
>>>> On Fri, Apr 07, 2017 at 11:07:15PM +0200, Paul Menzel wrote:
>>>
>>>>> Measuring where time is spent during boot with `systemd-bootchart`
>>>>> on an Asus A780FullHD, it turns out that half a second is spent in
>>>>> `pci_apply_final_quirks()`.
>>>>
>>>> I agree, that seems like a crazy amount of time.
>>>>
>>>> Can you figure out how to turn on pr_debug() (via the dynamic debug
>>>> mess or whatever) and boot with "initcall_debug"?  That should tell us
>>>> how long each quirk took.
>>>
>>> I am sorry for taking so long to reply. I finally added `dyndbg=file
>>> quirks.c +p` to the command line of Linux 4.13.13. This is on
>>> another AMD system (Asus F285M Pro).
> 
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 197 usecs for
>>> 0000:00:10.0
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 127 usecs for
>>> 0000:00:10.1
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 88643 usecs for
>>> 0000:00:12.0
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 137 usecs for
>>> 0000:00:12.2
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for
>>> 0000:00:12.2
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 85770 usecs for
>>> 0000:00:13.0
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 134 usecs for
>>> 0000:00:13.2
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for
>>> 0000:00:13.2
>>> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
>>> quirk_usb_early_handoff+0x0/0x6b0 returned after 125 usecs for
>>> 0000:03:00.0[…]
>>> ```
>>>
>>> So it’s `pci fixup quirk_usb_early_handoff` taking around 85 ms, and
>>> that twice.
>>
>> Wow.  That's pretty painful, but of course I don't know how to fix it.
>>  From looking at quirk_usb_early_handoff(), it may depend on BIOS
>> details.  Maybe the USB folks will have some ideas.
> 
> Can we see the output from lspci?  It would help to know what the 12.0
> and 13.0 devices are.

Sorry, that was trimmed from the original message. Here is the output 
from the ASRock A780FullD.

> ```
> $ more /proc/version
> Linux version 4.9.0-0.bpo.2-amd64 (debian-kernel@lists.debian.org)
> (gcc version 4.9.2 (Debian 4.9.2-10) ) #1 SMP Debian 4.9.13-1~bpo8+1 (2017-02-27)
> $ lspci -nn
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] RS780 Host Bridge [1022:9600]
> 00:01.0 PCI bridge [0604]: ASRock Incorporation Device [1849:9602]
> 00:09.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 4) [1022:9608]
> 00:0a.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] RS780/RS880 PCI to PCI bridge (PCIE port 5) [1022:9609]
> 00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391]
> 00:12.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
> 00:12.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
> 00:12.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
> 00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
> 00:13.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0 USB OHCI1 Controller [1002:4398]
> 00:13.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller [1002:4385] (rev 3a)
> 00:14.1 IDE interface [0101]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 IDE Controller [1002:439c]
> 00:14.2 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA) [1002:4383]
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller [1002:439d]
> 00:14.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge [1002:4384]
> 00:14.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller [1002:4399]
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]
> 01:05.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] RS780 [Radeon HD 3200] [1002:9610]
> 04:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
> [10ec:8168] (rev 02)
> ```

So far, this can be reproduce on all AMD systems I have (ASRock 
A780FullHD, ASRock E350M1, Asus F2A85-M Pro).


Kind regards,

Paul	
