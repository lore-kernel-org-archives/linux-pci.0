Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50267 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750923Ab3CKQOS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 12:14:18 -0400
Date: Mon, 11 Mar 2013 12:14:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
In-Reply-To: <513DFEA8.2080203@fold.natur.cuni.cz>
Message-ID: <Pine.LNX.4.44L0.1303111210020.2246-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 11 Mar 2013, Martin Mokrejs wrote:

> Alan, for me it is even more difficult because I really do not know what
> are the hardware details about nor what is an OS kernel. I really wanted
> you pickup anything you see broken in the collected data and we work on
> those bug separately. But I am not able to judge what if broken and what
> is not.
> 
> But I believe you could always say: Hey, if the eSATA or Firewire is
> USB-based (unlike PCIe based) it would have to use usb-storage and blah.
> I think you can try to come up with answer why USB-related changes disable
> PCI Express Root port or whether that was the 'nousb' outcome. I doubt
> PCI people will dive into that area. ;)

As far as I can tell, neither the eSATA nor the Firewire is connected 
with USB -- except for the fact that the eSATA card also contains a USB 
controller.  Maybe I have misunderstood.

Bjorn, can you explain the exact connection?

As for disabling USB in the BIOS configuration...  What that does isn't
clear.  It might turn off the USB hardware entirely, so that the kernel
can't detect it at all.  Or it might leave the hardware turned on but 
tell the BIOS not to use it.

Do you have lspci output from an older kernel where this stuff all 
worked correctly?

Alan Stern

