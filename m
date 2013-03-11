Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:46174 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751302Ab3CKP41 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2013 11:56:27 -0400
Message-ID: <513DFEA8.2080203@fold.natur.cuni.cz>
Date: Mon, 11 Mar 2013 16:56:24 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>,
	Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
References: <Pine.LNX.4.44L0.1303111101090.2246-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1303111101090.2246-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alan Stern wrote:
> On Mon, 11 Mar 2013, Martin Mokrejs wrote:
> 
>>> I thought the only card with a problem was the USB3.0 card.  But here
>>> you suggest that there *is* a problem with the SATA and Firewire
>>> cards.  Can you describe that problem in one sentence?
>>
>> One sentence? No. ;-)
>>
>> None of the cards works when 'nousb' and while are disabled USB
>> devices in BIOS (which can be altered at all, don't know whether that really
>> disables all USB in BIOS or not, hence I used the 'nousb' to be sure).
> 
> Martin:
> 
> I don't know about Bjorn, but I find it very difficult to work on more 
> than one bug at a time.  Since your low-level PCI hotplug problems 
> seem to be more fundamental than the USB problems, I'll wait until the 
> PCI part is under control before trying to contribute.

Alan, for me it is even more difficult because I really do not know what
are the hardware details about nor what is an OS kernel. I really wanted
you pickup anything you see broken in the collected data and we work on
those bug separately. But I am not able to judge what if broken and what
is not.

But I believe you could always say: Hey, if the eSATA or Firewire is
USB-based (unlike PCIe based) it would have to use usb-storage and blah.
I think you can try to come up with answer why USB-related changes disable
PCI Express Root port or whether that was the 'nousb' outcome. I doubt
PCI people will dive into that area. ;)

But thank you for your time on this.
Martin
