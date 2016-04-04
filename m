Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44960 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754235AbcDDTxV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Apr 2016 15:53:21 -0400
Date: Mon, 4 Apr 2016 14:53:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Andersson <martin.andersson@purplescout.se>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: Dell XPS13 9350 thunderbolt 3
Message-ID: <20160404195317.GA19031@localhost>
References: <CACmAtJvLMDbJG7FrnfcRoaLM843GNx5+9rehwn4-tD_QWTEn=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACmAtJvLMDbJG7FrnfcRoaLM843GNx5+9rehwn4-tD_QWTEn=Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 04, 2016 at 04:01:42PM +0200, Martin Andersson wrote:
> Hi all,
> 
> I have a Dell XPS 13 9350 laptop with a Dell Thunderbolt 3 dock (TB15)
> that I'm trying to get to talk to each other. I hope this is the right
> forum.
> 
> Lukas Wunner was kind enough to give me some pointers and after
> upgrading the thunderbolt firmware and disabling all the security
> settings for thunderbolt in the bios I'm able to see a usb hub
> (ASMedia Technology) from the dock with lspci. But that's it. Nothing
> happens when I attach any usb devices to the dock and I see no sign of
> the ethernet or audio devices in the dock.
> 
> cut from lspci -vv:
> 
> 09:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host
> Controller (prog-if 30 [XHCI])
>         Subsystem: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 18
>         Region 0: Memory at c4100000 (64-bit, non-prefetchable) [size=32K]
>         Capabilities: <access denied>
>         Kernel driver in use: xhci_hcd
> 
> 
> Also I only see the usb hub when I boot with the dock attached. I have
> tried with pcie_hp=nomsi and echo "1" > /sys/bus/pci/rescan with no
> luck. But hotplug is, of course, not my main concern at this point ;)
> 
> Should I open a bug at the kernel bugzilla and attach dmesg logs?

Looks like https://bugzilla.kernel.org/show_bug.cgi?id=115121

Bjorn
