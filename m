Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39165 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab3IFNHu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 09:07:50 -0400
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Shaohua Li <shaohua.li@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: VIA chipset with Root Port under a bridge
MIME-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1378472860_146410"
Date: Fri, 06 Sep 2013 15:07:43 +0200
Message-Id: <20130906130743.E1D44380C1D@gemini.denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multipart MIME message.

--==_Exmh_1378472860_146410
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com>
References: <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com>
Comments: In-reply-to Bjorn Helgaas <bhelgaas@google.com>
   message dated "Thu, 22 Aug 2013 15:47:13 -0600."

Dear Bjorn,

In message <CAErSpo53GpzdinvmQNX=DfJSsTUOzKng6LT1jrDSM8aU1ZUJiA@mail.gmail.com> you wrote:
> Shaohua, your commit 8e822df700 references a VIA chipset with a Root
> Port under a bridge, and that commit adds a special case to disable
> ASPM for that situation.
> 
> I know this is pretty old (the commit is from 2009), but do you have
> any more details about that system?  A pointer to the original problem
> report, lspci output, dmesg output, etc.?
> 
> I'm concerned because other parts of PCI make assumptions about Root
> Port topology, e.g., in MPS configuration, and we might need to make
> similar changes elsewhere.

I apologize for the long delay - I was on vacation.  I digged out this
stuff from my local archive.

[Note: I don't have that board any more, so I cannot help running any
tests.]

------- Forwarded Message

To: Shaohua Li <shaohua.li@intel.com>
cc: Andrew Patterson <andrew.patterson@hp.com>,
    Jesse Barnes <jbarnes@virtuousgeek.org>,
    Greg Kroah-Hartman <gregkh@suse.de>,
    Thomas Gleixner <tglx@linutronix.de>
Subject: commit d2da924f causes kernel panic
From: Wolfgang Denk <wd@denx.de>
Date: Fri, 05 Jun 2009 10:49:21 +0200

Hi,

I have an Athlon 64 system which does not boot any more with recent
kernels. Bisecting shows this commit as culprit:

$ git bisect bad
d2da924fad2d44f5b0be87f9b7edc791e347de7c is first bad commit
commit d2da924fad2d44f5b0be87f9b7edc791e347de7c
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Fri Dec 19 09:27:42 2008 +0800

    PCI: keep ASPM link state consistent throughout PCIe hierarchy
    
    commit 46bbdfa44cfc0d352148a0dc33ba9f6db02ccdf0 upstream.
    
    In a PCIe hierarchy with a switch present, if the link state of an
    endpoint device is changed, we must check the whole hierarchy from the
    endpoint device to root port, and for each link in the hierarchy, the new
    link state should be configured. Previously, the implementation checked
    the state but forgot to configure the links between root port to switch.
    Fixes Novell bz #448987.
    
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Tested-by: Andrew Patterson <andrew.patterson@hp.com>
    Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 72d29d00ac8046a10dd9ba5ec8a130ae872c4c4f 0e0509009a04f388598159dfa592dae2103c69b0 M   drivers

The crash is always reproducable and looks like this:


...
No dock devices found.
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG for extended config space
PCI: Using configuration type 1 for base access
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: PME# disabled
pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
pci 0000:00:03.0: PME# disabled
pci 0000:00:0f.0: PME# supported from D3hot
pci 0000:00:0f.0: PME# disabled
pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.0: PME# disabled
pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.1: PME# disabled
pci 0000:00:10.2: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.2: PME# disabled
pci 0000:00:10.3: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.3: PME# disabled
pci 0000:00:10.4: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:10.4: PME# disabled
pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:12.0: PME# disabled
pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
pci 0000:04:00.0: PME# disabled
pci 0000:04:00.1: PME# supported from D0 D3hot D3cold
pci 0000:04:00.1: PME# disabled
pci 0000:04:01.0: PME# supported from D0 D3hot D3cold
pci 0000:04:01.0: PME# disabled
pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:06:00.0: PME# disabled
Pre-1.1 PCIe device detected, disable ASPM for 0000:04:00.1. It can be enabled forcedly with 'pcie_aspm=force'
BUG: unable to handle kernel NULL pointer dereference at 00000054
IP: [<c052a0a7>] pcie_aspm_init_link_state+0x140/0x5e5
*pde = 00000000
Oops: 0000 [#1] SMP
Modules linked in:

Pid: 1, comm: swapper Not tainted (2.6.27.12-00018-gd2da924 #12)
EIP: 0060:[<c052a0a7>] EFLAGS: 00010286 CPU: 0
EIP is at pcie_aspm_init_link_state+0x140/0x5e5
EAX: 00000000 EBX: f788b8f8 ECX: f788c800 EDX: f785d540
ESI: f785d55c EDI: f788b800 EBP: f782fd5c ESP: f782fce8
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
Process swapper (pid: 1, ti=f782f000 task=f7848000 task.ti=f782f000)
Stack: f788c8f8 f785d540 a000c8f8 ffffffea c0775372 f788c800 f782fd24 c07da2c0
       f782fd10 c041f5aa f782fd18 c06a5bb2 f788c800 f783f400 f788c824 f782fd34
       c0523d63 f788c826 f788c800 f782fd5c c0697bd9 f783f400 0000003e 00000200
Call Trace:
 [<c041f5aa>] ? need_resched+0x18/0x22
 [<c06a5bb2>] ? _cond_resched+0x8/0x32
 [<c0523d63>] ? pci_device_add+0x99/0x9d
 [<c0697bd9>] ? pci_scan_single_device+0x45e/0x46c
 [<c0523dea>] ? pci_scan_slot+0x5b/0x63
 [<c0699a46>] ? pci_scan_child_bus+0x1d/0x78
 [<c0697771>] ? pci_add_new_bus+0xf8/0x102
 [<c0699832>] ? pci_scan_bridge+0x11d/0x314
 [<c0699a7f>] ? pci_scan_child_bus+0x56/0x78
 [<c0699832>] ? pci_scan_bridge+0x11d/0x314
 [<c0699a7f>] ? pci_scan_child_bus+0x56/0x78
 [<c0699abb>] ? pci_scan_bus_parented+0x1a/0x24
 [<c069e3dd>] ? pci_acpi_scan_root+0x9e/0x1ae
 [<c069b06a>] ? acpi_pci_root_add+0x1da/0x29f
 [<c055c791>] ? acpi_device_probe+0x42/0x84
 [<c0593604>] ? driver_probe_device+0xa0/0x136
 [<c05936d4>] ? __driver_attach+0x3a/0x59
 [<c059302b>] ? bus_for_each_dev+0x3b/0x63
 [<c05934a9>] ? driver_attach+0x14/0x16
 [<c059369a>] ? __driver_attach+0x0/0x59
 [<c0592a9f>] ? bus_add_driver+0x9d/0x1ba
 [<c059385b>] ? driver_register+0x81/0xe1
 [<c055ca6b>] ? acpi_bus_register_driver+0x3a/0x3f
 [<c082c515>] ? acpi_pci_root_init+0x16/0x25
 [<c0401125>] ? _stext+0x3d/0x115
 [<c082c4ff>] ? acpi_pci_root_init+0x0/0x25
 [<c0463e80>] ? register_irq_proc+0x92/0xae
 [<c0463ed9>] ? init_irq_proc+0x3d/0x4a
 [<c080c2ed>] ? kernel_init+0x102/0x150
 [<c080c1eb>] ? kernel_init+0x0/0x150
 [<c040573f>] ? kernel_thread_helper+0x7/0x10
 =======================
Code: 8b 55 90 88 42 0c 89 d6 89 d0 83 c0 14 83 c6 1c 89 42 14 89 42 18 89 72 1c 89 72 20 8b 47 08 83 78 1c 00 74 2c 8b 40 08 8b 40 1c <8b> 58 54 85 db 75 0c 89 d0 e8 15 20 f6 ff e9 76 04 00 00 8b 4b
EIP: [<c052a0a7>] pcie_aspm_init_link_state+0x140/0x5e5 SS:ESP 0068:f782fce8
---[ end trace 4eaa2a86a8e2da22 ]---
Kernel panic - not syncing: Attempted to kill init!



(Short) lspci output of the system:

$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. K8T890CF Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:00.5 PIC: VIA Technologies, Inc. VT3351 I/O APIC Interrupt Controller
00:00.7 Host bridge: VIA Technologies, Inc. VT3351 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. [K8T890 North / VT8237 South] PCI Bridge
00:02.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:03.0 PCI bridge: VIA Technologies, Inc. K8T890 PCI to PCI Bridge Controller
00:0f.0 SATA controller: VIA Technologies, Inc. VT8251 AHCI/SATA 4-Port Controller
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 07)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 90)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8251 PCI to ISA Bridge
00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 7c)
00:13.0 PCI bridge: VIA Technologies, Inc. VT8251 Host Bridge
00:13.1 PCI bridge: VIA Technologies, Inc. VT8251 PCI to PCI Bridge
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
02:00.0 VGA compatible controller: ATI Technologies Inc RV610 video device [Radeon HD 2400 PRO]
02:00.1 Audio device: ATI Technologies Inc RV610 audio device [Radeon HD 2400 PRO]
04:00.0 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
04:00.1 PCI bridge: VIA Technologies, Inc. VT8251 PCIE Root Port
04:01.0 Audio device: VIA Technologies, Inc. VT1708/A [Azalia HDAC] (VIA High Definition Audio Controller)
06:00.0 Ethernet controller: SysKonnect SK-9E21D 10/100/1000Base-T Adapter, Copper RJ-45 (rev 17)
07:0c.0 Network controller: Tiger Jet Network Inc. Tiger3XX Modem/ISDN interface
07:0d.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)


More detailed information can be found in the attached tarball:

lspci-vv-xxx.out		- output of "lspci -vv -xxx" on the system
2.6.27.12-00017-gd10bdc8.log	- complete boot log of the last working version
2.6.27.12-00018-gd2da924.log	- complete boot log of the first failing version


Any idea whay might be going wrong on this system?


If you need any additional information please let me know, I'll be
happy to run any tests you might suggest.

Thanks in advance.


Best regards,

Wolfgang Denk

------- End of Forwarded Message


Hope this helps.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The world is coming to an end -- save your buffers!


--==_Exmh_1378472860_146410
Content-Type: application/gzip ; name="logs.tar.gz"
Content-Description: logs.tar.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="logs.tar.gz"

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
r/EFM+EzGgAYAQA=
--==_Exmh_1378472860_146410--

