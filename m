Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50714 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbbJGTU4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 15:20:56 -0400
Date: Wed, 7 Oct 2015 14:20:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Shelton, Ben" <benjamin.h.shelton@intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Convention for PCI device to handle bridge window change
Message-ID: <20151007192052.GD27633@localhost>
References: <20150820165959.GB14073@bhshelto-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150820165959.GB14073@bhshelto-vm>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ben,

Sorry for the late response.  I didn't notice this until now.

On Thu, Aug 20, 2015 at 12:00:00PM -0500, Shelton, Ben wrote:
> Hi all,
> 
> I'm working on an issue with an x64-based emulation system that has
> multiple PCI-accessible FPGAs, each of which sits behind a PCI bridge.
> 
> We program the first FPGA and then warm-reboot the CPU.  When it comes
> back up, there is an additional PCIe device that has been programmed
> into the FPGA, and the kernel goes through the remapping process to
> figure out how to fit everything.  The remapping succeeds by moving
> several of the FPGA bridges out of the way.  The bridges get set up
> properly, but the FPGA resources themselves get released but not
> reassigned, and the BAR of the FPGA behind each bridge that got
> relocated is still set to the old address.  If I add a hack in the boot
> process to call pci_assign_resource() for those particular devices if
> they have not been assigned, then everything works as expected.

When you say "warm-reboot the CPU," I assume you mean that you're
rebooting Linux from scratch, and it has no knowledge about the
previous boot.  But apparently BIOS isn't involved?  At least on x86,
BIOS usually assigns space for most or all PCI devices, but in your
case it sounds like Linux is doing the assignment.

> Where is the usual place to handle updating the BAR for a device after
> the bridge window of the bridge it's behind has changed?

If the Linux PCI core is changing a bridge window, it should also
change the BARs of any devices below the bridge.  Maybe a complete
dmesg log would help me understand what's happening.

Bjorn
