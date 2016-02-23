Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43767 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbcBWO3t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 09:29:49 -0500
Date: Tue, 23 Feb 2016 08:29:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harvey Partridge <harveyp@hotmail.fr>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCI/USB 2.0 4 port hub fails to install under Ubuntu 12.04
Message-ID: <20160223142942.GA14394@localhost>
References: <loom.20160223T003705-325@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20160223T003705-325@post.gmane.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Harvey,

Thanks a lot for your report, and sorry you're having problems.

On Tue, Feb 23, 2016 at 12:06:54AM +0000, Harvey Partridge wrote:
> Bonjour,
> 
> I have a very old Hewlett-Packard PC with Ubuntu 12.04. Recently my built-in
> usb ports have become very flaky so I have bought a new low profile PCI
> 4-port USB 2.0 hub (VIA Technologies, Inc.) which has failed to install.

This is a plug-in PCI card, right?

> Immediately apparent is the !!!error notice. I have spent several hours in
> research with no success - I am obviously not doing it right!
> 
> Odd, too, that lspci and lshw only enumerate 3 ports on this card, whereas
> there are 4.
> 
> Any help gratefully received. Failing direct help, I should appreciate some
> pointers on how to start self-helping ... Ta! For example, I imagine it
> would be useful to understand the error message!
> 
> I shall be glad to supply any further diagnostics - just tell me!
> I am not a stranger to programming, but my major interests have been DBs
> rather than hardware...
> 
> PCI/VEN_1106&DEV_303A&REV_61
> 
> lsusb does not find these ports
> dmesg has no references to this card, that I can discover/recognise.
> 
> lspci -vvv -s 01:01
> 
> 01:01.0 Non-VGA unclassified device: VIA Technologies, Inc. Device 303a (rev 61)
> Subsystem: Accelgraphics Inc. Device 0003
> !!! Invalid class 0000 for header type 02
> Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx- Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=medium >TAbort- SERR- Latency: 22
> Interrupt: pin A routed to IRQ 0
> Region 0: Memory at (32-bit, non-prefetchable) [disabled]
> Bus: primary=00, secondary=00, subordinate=02, sec-latency=0
> Memory window 0: 00020000-0002fce1 [disabled]
> Memory window 1: 00020000-00020000 [disabled]
> I/O window 0: 00001104-00000003 [disabled]
> I/O window 1: 00000080-00000003 [disabled]
> BridgeCtl: Parity- SERR+ ISA- VGA- MAbort- >Reset- 16bInt- PostWrite- 

This particular device looks like a bridge, not a USB controller.  Can
you collect the complete "lspci -vvvxxx" output (as root) and the
complete dmesg log?

The first step is to figure out whether the PCI core is enumerating
the device.  If nothing else works, you could collect the dmesg log
with the card removed, then again with the card installed, and diff
the two.  The PCI core prints at least one line for each PCI device it
finds.

Bjorn
