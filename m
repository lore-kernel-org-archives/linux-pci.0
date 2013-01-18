Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50577 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab3ARUDf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2013 15:03:35 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so4093826obb.21
        for <linux-pci@vger.kernel.org>; Fri, 18 Jan 2013 12:03:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
Date: Fri, 18 Jan 2013 12:57:28 -0700
Message-ID: <CAL-B5D3uLvysKEDzcO0SWNSpM_Hx7pR5Nv=Bj0y6Eec41rVahg@mail.gmail.com>
Subject: Re: PCIe ASPM crash on device removal
From: Myron Stowe <myron.stowe@gmail.com>
To: Joe Lawrence <Joe.Lawrence@stratus.com>
Cc: linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Re-posting after fixing gmail to not use rich text (html) formatting ...

On Fri, Jan 18, 2013 at 11:22 AM, Joe Lawrence <Joe.Lawrence@stratus.com> wrote:
> Stratus has encountered crashes in 3.8.0-rc2 ASPM tracking code when
> hotplugging PCI buses.  The call trace of a crash usually looks like:
>
> pci_stop_and_remove_bus_device
>   pci_stop_bus_device
>     pcie_aspm_exit_link_state
>       pcie_update_aspm_capable
>         pcie_aspm_check_latency
>
> where ASPM is trying to access a freed data structure.  When instrumenting
> the ASPM init/exit code, it seems that pcie_aspm_exit_link_state is
> skipping over one of our PCIe Downstream Ports that
> pcie_aspm_init_link_state had prior allocated link_state.  Subsequent
> trips through ASPM exit code traverse through the hierarchy and crash
> trying to access freed memory (slub_debug was set to FZPU and
> pcie_aspm_check_latency is trying to access a link* that is set to
> 0x6b6b6b6b6b6b6b6b.)
>
> A brief summary of the init/exit link_state routines is as follows.
>
>   pcie_aspm_init_link_state will alloc_pcie_link_state if:
>
>   1 - Device is PCIe
>   2 - Hasn't already allocated a link_state
>   3 - Device is PCI_EXP_TYPE_ROOT_PORT or PCI_EXP_TYPE_DOWNSTREAM
>   4 - Device is not VIA chipset (root port under bridge)
>   5 - Device's subordinate device list is not empty
>
>
>   pcie_aspm_exit_link_state will free_link_state of *parent* device if:
>
>   1 - Device is PCIe
>   2 - Device has a parent device
>   3 - Parent device has a link_state
>   4 - Parent device is PCI_EXP_TYPE_ROOT_PORT or PCI_EXP_TYPE_DOWNSTREAM
>   5 - Device is the last entry in parent's subordinate device list
>
>
> The Stratus PCI topology includes a branch that looks like:
>
> ... -00.0-[03-3c]----00.0-[04-2d]--+- ...
>                                    |
>                                    \-01.0-[2c-2d]--+-00.0
>                                                    +-00.1
>                                                    \-1f.0
>
This is an interesting topology.  The switch contains an Express
capable downstream port - 04:01.0 - leading to PCI (non-Express)
devices (2c:00.0, 2c:00.1, and 2c:1f.0).  Would Express links even be
used in this topology?  I'm guessing not, which brings up the
question: why would ASPM be inserting link state structures into its
link_list for such a topology?  Seems like the proper thing to do is
change the code in the beginning of pcie_aspm_init_link_state, or
pcie_aspm_sanity_check() with some re-factoring, to short-circuit out
and do nothing (even when ASPM is enabled in the kernel).

Could you supply an "lspci -xxx -vvs 04:01.0?  It would be interesting
to see what the "express capabilities" LnkCap indicates with respect
to its ASPM bits (11:10 Active State Power Management (ASPM) Support
bits).

Myron

> % lspci -vs 03:00.0
> 03:00.0 PCI bridge: Device 1bcf:0004 (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Memory at 93000000 (64-bit, non-prefetchable) [size=4K]
>         Bus: primary=03, secondary=04, subordinate=2d, sec-latency=0
>         I/O behind bridge: 00001000-00005fff
>         Memory behind bridge: 84000000-92ffffff
>         Prefetchable memory behind bridge: 00000000c4000000-00000000c7ffffff
>         Capabilities: [b0] Express Upstream Port, MSI 00
>         Capabilities: [ec] Power Management version 2
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: pcieport
>
> % lspci -vs 04:01.0
> 04:01.0 PCI bridge: Device 1bcf:0009 (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=04, secondary=2c, subordinate=2d, sec-latency=0
>         I/O behind bridge: 00005000-00005fff
>         Memory behind bridge: 90000000-92ffffff
>         Capabilities: [b0] Express Downstream Port (Slot-), MSI 00
>         Capabilities: [ec] Power Management version 2
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: pcieport
>
> % lspci -vs 2c:00.0
> 2c:00.0 USB Controller: Intel Corporation Patsburg USB2 Enhanced Host
>                         Controller #1 (rev 06) (prog-if 20 [EHCI])
>         Subsystem: Device 1bcf:8002
>         Flags: bus master, medium devsel, latency 0, IRQ 10
>         Memory at 90000000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] Debug port: BAR=1 offset=00a0
>         Capabilities: [98] PCI Advanced Features
>         Kernel driver in use: ehci-pci
>
> % lspci -vs 2c:00.1
> 2c:00.1 USB Controller: Intel Corporation Patsburg USB2 Enhanced Host
>                         Controller #2 (rev 06) (prog-if 20 [EHCI])
>         Subsystem: Device 1bcf:8002
>         Flags: bus master, medium devsel, latency 0, IRQ 11
>         Memory at 90001000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] Debug port: BAR=1 offset=00a0
>         Capabilities: [98] PCI Advanced Features
>         Kernel driver in use: ehci-pci
>
> % lspci -vs 2c:1f.0
> 2c:1f.0 ISA bridge: Intel Corporation Patsburg LPC Controller (rev 06)
>         Subsystem: Device 1bcf:8002
>         Flags: bus master, medium devsel, latency 0
>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>
> When debugging is added to pcie_init_link_state, 04:01.0 does set
> blacklist to 1, as the pcie_aspm_sanity_check figures out that at least
> one of its children is not PCIe.  However, all of the criteria 1-5 above
> is met and a link_state is allocated for this device.
>
> On device removal, pcie_aspm_exit_link_state will never clean up 04:01.0 as
> 2c:00.0, 2c:00.1, and most importantly 2c:1f.0 are not PCIe (criteria 1).
>
>
> In reply to this mail, I will post two patches I have been testing this
> week:
>
> [PATCH 1/2] PCI: ASPM exit link state code could skip devices
>
> In looking at pcie_aspm_exit_link_state, might it be better to verify that
> the *parent* device is PCIe rather than the device itself?  This would
> prevent early exit when the last function is not PCIe and also verify that
> the parent is PCIe before calling pci_pcie_type on it.
>
> Furthermore, I didn't investigate this, but does the strategy of the
> last device function out cleaning up the parent link_state leave another
> whole -- what if there are no child devices in the first place?
>
> I'd be happy to test other approaches here.
>
> [PATCH 2/2] PCI: Don't touch ASPM if forcibly disabled
>
> Matthew Garrett had provided us this patch to use against a RHEL 6.3
> kernel.  It prevents ASPM from allocating any link_state when
> 'pcie_aspm=off' is specified on the kernel command line.  Stratus has been
> using this patch to avoid this crash in RHEL 6.3.
>
> When testing with Patch 1, this second patch was unnecessary (I removed
> any pcie_aspm directives from the boot line).  However given its utility
> in avoiding the crash in the first place, it would be nice to offer the
> user a means to turn off ASPM tracking to avoid other potential issues.
>
> Regards,
>
> -- Joe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
