Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32860 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbcDDOBp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2016 10:01:45 -0400
Received: by mail-oi0-f43.google.com with SMTP id w85so36495998oiw.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Apr 2016 07:01:43 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 4 Apr 2016 16:01:42 +0200
Message-ID: <CACmAtJvLMDbJG7FrnfcRoaLM843GNx5+9rehwn4-tD_QWTEn=Q@mail.gmail.com>
Subject: Dell XPS13 9350 thunderbolt 3
From: Martin Andersson <martin.andersson@purplescout.se>
To: linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I have a Dell XPS 13 9350 laptop with a Dell Thunderbolt 3 dock (TB15)
that I'm trying to get to talk to each other. I hope this is the right
forum.

Lukas Wunner was kind enough to give me some pointers and after
upgrading the thunderbolt firmware and disabling all the security
settings for thunderbolt in the bios I'm able to see a usb hub
(ASMedia Technology) from the dock with lspci. But that's it. Nothing
happens when I attach any usb devices to the dock and I see no sign of
the ethernet or audio devices in the dock.

cut from lspci -vv:

09:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host
Controller (prog-if 30 [XHCI])
        Subsystem: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at c4100000 (64-bit, non-prefetchable) [size=32K]
        Capabilities: <access denied>
        Kernel driver in use: xhci_hcd


Also I only see the usb hub when I boot with the dock attached. I have
tried with pcie_hp=nomsi and echo "1" > /sys/bus/pci/rescan with no
luck. But hotplug is, of course, not my main concern at this point ;)

Should I open a bug at the kernel bugzilla and attach dmesg logs?

Thanks in advance! I'm happy for any pointers in the right direction.

Regards,
Martin Andersson
