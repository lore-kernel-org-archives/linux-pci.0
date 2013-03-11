Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50207 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751868Ab3CKPDi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 11:03:38 -0400
Date: Mon, 11 Mar 2013 11:03:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
In-Reply-To: <513D2CD3.5000309@fold.natur.cuni.cz>
Message-ID: <Pine.LNX.4.44L0.1303111101090.2246-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 11 Mar 2013, Martin Mokrejs wrote:

> > I thought the only card with a problem was the USB3.0 card.  But here
> > you suggest that there *is* a problem with the SATA and Firewire
> > cards.  Can you describe that problem in one sentence?
> 
> One sentence? No. ;-)
> 
> None of the cards works when 'nousb' and while are disabled USB
> devices in BIOS (which can be altered at all, don't know whether that really
> disables all USB in BIOS or not, hence I used the 'nousb' to be sure).

Martin:

I don't know about Bjorn, but I find it very difficult to work on more 
than one bug at a time.  Since your low-level PCI hotplug problems 
seem to be more fundamental than the USB problems, I'll wait until the 
PCI part is under control before trying to contribute.

Alan Stern

