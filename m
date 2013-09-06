Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34452 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab3IFPSS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 11:18:18 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so7306912ieb.28
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 08:18:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130906130743.E1D44380C1D@gemini.denx.de>
References: <20130906130743.E1D44380C1D@gemini.denx.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 6 Sep 2013 09:17:57 -0600
Message-ID: <CAErSpo6ANwZ1ZbwfhbHWewYNKQLt5k0siSbQObE=yj3Y1gUO=A@mail.gmail.com>
Subject: Re: VIA chipset with Root Port under a bridge
To: Wolfgang Denk <wd@denx.de>
Cc: Shaohua Li <shaohua.li@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks a lot, Wolfgang!  I opened
https://bugzilla.kernel.org/show_bug.cgi?id=60864 as a place to attach
your logs and info.

Bjorn

Text to help search engines find this bug:
  8e822df700694ca6850d1e0c122fd7004b2778d8
  PCI: disable ASPM on VIA root-port-under-bridge configurations
  VIA has a strange chipset, root port is under a bridge

On Fri, Sep 6, 2013 at 7:07 AM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Bjorn,
>
> In message <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com> you wrote:
>> Shaohua, your commit 8e822df700 references a VIA chipset with a Root
>> Port under a bridge, and that commit adds a special case to disable
>> ASPM for that situation.
>>
>> I know this is pretty old (the commit is from 2009), but do you have
>> any more details about that system?  A pointer to the original problem
>> report, lspci output, dmesg output, etc.?
>>
>> I'm concerned because other parts of PCI make assumptions about Root
>> Port topology, e.g., in MPS configuration, and we might need to make
>> similar changes elsewhere.
>
> I apologize for the long delay - I was on vacation.  I digged out this
> stuff from my local archive.
>
> [Note: I don't have that board any more, so I cannot help running any
> tests.]
>
> ------- Forwarded Message
>
> To: Shaohua Li <shaohua.li@intel.com>
> cc: Andrew Patterson <andrew.patterson@hp.com>,
>     Jesse Barnes <jbarnes@virtuousgeek.org>,
>     Greg Kroah-Hartman <gregkh@suse.de>,
>     Thomas Gleixner <tglx@linutronix.de>
> Subject: commit d2da924f causes kernel panic
> From: Wolfgang Denk <wd@denx.de>
> Date: Fri, 05 Jun 2009 10:49:21 +0200
>
> Hi,
>
> I have an Athlon 64 system which does not boot any more with recent
> kernels. Bisecting shows this commit as culprit:
>
> $ git bisect bad
> d2da924fad2d44f5b0be87f9b7edc791e347de7c is first bad commit
> commit d2da924fad2d44f5b0be87f9b7edc791e347de7c
> Author: Shaohua Li <shaohua.li@intel.com>
> Date:   Fri Dec 19 09:27:42 2008 +0800
>
>     PCI: keep ASPM link state consistent throughout PCIe hierarchy
>
>     commit 46bbdfa44cfc0d352148a0dc33ba9f6db02ccdf0 upstream.
>
>     In a PCIe hierarchy with a switch present, if the link state of an
>     endpoint device is changed, we must check the whole hierarchy from the
>     endpoint device to root port, and for each link in the hierarchy, the new
>     link state should be configured. Previously, the implementation checked
>     the state but forgot to configure the links between root port to switch.
>     Fixes Novell bz #448987.
>
>     Signed-off-by: Shaohua Li <shaohua.li@intel.com>
>     Tested-by: Andrew Patterson <andrew.patterson@hp.com>
>     Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> :040000 040000 72d29d00ac8046a10dd9ba5ec8a130ae872c4c4f 0e0509009a04f388598159dfa592dae2103c69b0 M   drivers
>
> The crash is always reproducable and looks like this:
>
>
> ...
> No dock devices found.
> ACPI: bus type pci registered
> PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
> PCI: MCFG area at e0000000 reserved in E820
> PCI: Using MMCONFIG for extended config space
> PCI: Using configuration type 1 for base access
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:02.0: PME# disabled
> pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:03.0: PME# disabled
> pci 0000:00:0f.0: PME# supported from D3hot
> pci 0000:00:0f.0: PME# disabled
> pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:10.0: PME# disabled
> pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:10.1: PME# disabled
> pci 0000:00:10.2: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:10.2: PME# disabled
> pci 0000:00:10.3: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:10.3: PME# disabled
> pci 0000:00:10.4: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:10.4: PME# disabled
> pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:12.0: PME# disabled
> pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:04:00.0: PME# disabled
> pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
> pci 0000:04:00.1: PME# disabled
> pci 0000:04:01.0: PME# supported from D0 D3hot D3cold
> pci 0000:04:01.0: PME# disabled
> pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:06:00.0: PME# disabled
> Pre-1.1 PCIe device detected, disable ASPM for 0000:04:00.1. It can be enabled forcedly with 'pcie_aspm=force'
> BUG: unable to handle kernel NULL pointer dereference at 00000054
> IP: [<c052a0a7>] pcie_aspm_init_link_state+0x140/0x5e5
> *pde = 00000000
> Oops: 0000 [#1] SMP
> Modules linked in:
>
> Pid: 1, comm: swapper Not tainted (2.6.27.12-00018-gd2da924 #12)
> EIP: 0060:[<c052a0a7>] EFLAGS: 00010286 CPU: 0
> EIP is at pcie_aspm_init_link_state+0x140/0x5e5
> EAX: 00000000 EBX: f788b8f8 ECX: f788c800 EDX: f785d540
> ESI: f785d55c EDI: f788b800 EBP: f782fd5c ESP: f782fce8
>  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> Process swapper (pid: 1, ti=f782f000 task=f7848000 task.ti=f782f000)
> Stack: f788c8f8 f785d540 a000c8f8 ffffffea c0775372 f788c800 f782fd24 c07da2c0
>        f782fd10 c041f5aa f782fd18 c06a5bb2 f788c800 f783f400 f788c824 f782fd34
>        c0523d63 f788c826 f788c800 f782fd5c c0697bd9 f783f400 0000003e 00000200
> Call Trace:
>  [<c041f5aa>] ? need_resched+0x18/0x22
>  [<c06a5bb2>] ? _cond_resched+0x8/0x32
>  [<c0523d63>] ? pci_device_add+0x99/0x9d
>  [<c0697bd9>] ? pci_scan_single_device+0x45e/0x46c
>  [<c0523dea>] ? pci_scan_slot+0x5b/0x63
>  [<c0699a46>] ? pci_scan_child_bus+0x1d/0x78
>  [<c0697771>] ? pci_add_new_bus+0xf8/0x102
>  [<c0699832>] ? pci_scan_bridge+0x11d/0x314
>  [<c0699a7f>] ? pci_scan_child_bus+0x56/0x78
>  [<c0699832>] ? pci_scan_bridge+0x11d/0x314
>  [<c0699a7f>] ? pci_scan_child_bus+0x56/0x78
>  [<c0699abb>] ? pci_scan_bus_parented+0x1a/0x24
>  [<c069e3dd>] ? pci_acpi_scan_root+0x9e/0x1ae
>  [<c069b06a>] ? acpi_pci_root_add+0x1da/0x29f
>  [<c055c791>] ? acpi_device_probe+0x42/0x84
>  [<c0593604>] ? driver_probe_device+0xa0/0x136
>  [<c05936d4>] ? __driver_attach+0x3a/0x59
>  [<c059302b>] ? bus_for_each_dev+0x3b/0x63
>  [<c05934a9>] ? driver_attach+0x14/0x16
>  [<c059369a>] ? __driver_attach+0x0/0x59
>  [<c0592a9f>] ? bus_add_driver+0x9d/0x1ba
>  [<c059385b>] ? driver_register+0x81/0xe1
>  [<c055ca6b>] ? acpi_bus_register_driver+0x3a/0x3f
>  [<c082c515>] ? acpi_pci_root_init+0x16/0x25
>  [<c0401125>] ? _stext+0x3d/0x115
>  [<c082c4ff>] ? acpi_pci_root_init+0x0/0x25
>  [<c0463e80>] ? register_irq_proc+0x92/0xae
>  [<c0463ed9>] ? init_irq_proc+0x3d/0x4a
>  [<c080c2ed>] ? kernel_init+0x102/0x150
>  [<c080c1eb>] ? kernel_init+0x0/0x150
>  [<c040573f>] ? kernel_thread_helper+0x7/0x10
>  =======================
> Code: 8b 55 90 88 42 0c 89 d6 89 d0 83 c0 14 83 c6 1c 89 42 14 89 42 18 89 72 1c 89 72 20 8b 47 08 83 78 1c 00 74 2c 8b 40 08 8b 40 1c <8b> 58 54 85 db 75 0c 89 d0 e8 15 20 f6 ff e9 76 04 00 00 8b 4b
> EIP: [<c052a0a7>] pcie_aspm_init_link_state+0x140/0x5e5 SS:ESP 0068:f782fce8
> ---[ end trace 4eaa2a86a8e2da22 ]---
> Kernel panic - not syncing: Attempted to kill init!
>
>
>
> (Short) lspci output of the system:
>
> $ lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. K8T890CF Host Bridge
> 00:00.1 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
> 00:00.2 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
> 00:00.3 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
> 00:00.4 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
> 00:00.5 PIC: VIA Technologies, Inc. VT3351 I/O APIC Interrupt Controller
> 00:00.7 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
> 00:01.0 PCI bridge: VIA Technologies, Inc. [K8T890 North / VT8237 South] PCI Bridge
> 00:02.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
> 00:03.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
> 00:0f.0 SATA controller: VIA Technologies, Inc. VT8251 AHCI/SATA 4-Port Controller
> 00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8251 PCI to ISA Bridge
> 00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 7c)
> 00:13.0 PCI bridge: VIA Technologies, Inc. VT8251 Host Bridge
> 00:13.1 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCI Bridge
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 02:00.0 VGA compatible controller: ATI Technologies Inc RV610 video device [Radeon HD 2400 PRO]
> 02:00.1 Audio device: ATI Technologies Inc RV610 audio device [Radeon HD 2400 PRO]
> 04:00.0 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
> 04:00.1 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
> 04:01.0 Audio device: VIA Technologies, Inc. VT1708/A [Azalia HDAC] (VIA High Definition Audio Controller)
> 06:00.0 Ethernet controller: SysKonnect SK-9E21D 10/100/1000Base-T Adapter, Copper RJ-45 (rev 17)
> 07:0c.0 Network controller: Tiger Jet Network Inc. Tiger3XX Modem/ISDN interface
> 07:0d.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
>
>
> More detailed information can be found in the attached tarball:
>
> lspci-vv-xxx.out                - output of "lspci -vv -xxx" on the system
> 2.6.27.12-00017-gd10bdc8.log    - complete boot log of the last working version
> 2.6.27.12-00018-gd2da924.log    - complete boot log of the first failing version
>
>
> Any idea whay might be going wrong on this system?
>
>
> If you need any additional information please let me know, I'll be
> happy to run any tests you might suggest.
>
> Thanks in advance.
>
>
> Best regards,
>
> Wolfgang Denk
>
> ------- End of Forwarded Message
>
>
> Hope this helps.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> The world is coming to an end -- save your buffers!
>
