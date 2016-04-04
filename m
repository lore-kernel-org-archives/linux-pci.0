Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36171 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbcDDWSL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2016 18:18:11 -0400
Received: by mail-lf0-f50.google.com with SMTP id g184so117746245lfb.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Apr 2016 15:18:10 -0700 (PDT)
Date: Mon, 4 Apr 2016 18:18:04 -0400
From: Jarod Wilson <jarod@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Martin Andersson <martin.andersson@purplescout.se>,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	prarit@redhat.com
Subject: Re: Dell XPS13 9350 thunderbolt 3
Message-ID: <20160404221804.GL24264@redhat.com>
References: <CACmAtJvLMDbJG7FrnfcRoaLM843GNx5+9rehwn4-tD_QWTEn=Q@mail.gmail.com>
 <20160404195317.GA19031@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160404195317.GA19031@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 04, 2016 at 02:53:17PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 04, 2016 at 04:01:42PM +0200, Martin Andersson wrote:
> > Hi all,
> > 
> > I have a Dell XPS 13 9350 laptop with a Dell Thunderbolt 3 dock (TB15)
> > that I'm trying to get to talk to each other. I hope this is the right
> > forum.
> > 
> > Lukas Wunner was kind enough to give me some pointers and after
> > upgrading the thunderbolt firmware and disabling all the security
> > settings for thunderbolt in the bios I'm able to see a usb hub
> > (ASMedia Technology) from the dock with lspci. But that's it. Nothing
> > happens when I attach any usb devices to the dock and I see no sign of
> > the ethernet or audio devices in the dock.
> > 
> > cut from lspci -vv:
> > 
> > 09:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host
> > Controller (prog-if 30 [XHCI])
> >         Subsystem: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller
> >         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Interrupt: pin A routed to IRQ 18
> >         Region 0: Memory at c4100000 (64-bit, non-prefetchable) [size=32K]
> >         Capabilities: <access denied>
> >         Kernel driver in use: xhci_hcd
> > 
> > 
> > Also I only see the usb hub when I boot with the dock attached. I have
> > tried with pcie_hp=nomsi and echo "1" > /sys/bus/pci/rescan with no
> > luck. But hotplug is, of course, not my main concern at this point ;)
> > 
> > Should I open a bug at the kernel bugzilla and attach dmesg logs?
> 
> Looks like https://bugzilla.kernel.org/show_bug.cgi?id=115121

This looks possibly relevant:

http://marc.info/?l=linux-acpi&m=145929159015853&w=2

I believe it was sussed out on a Dell Precision 5510, with the Dell tb3
dock. I actually have said dock and a 3510 here in hand, and have been
meaning to give Prarit's patch a spin myself.

-- 
Jarod Wilson
jarod@redhat.com

