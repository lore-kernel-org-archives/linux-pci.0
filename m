Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54536 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbbHTRAA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Aug 2015 13:00:00 -0400
Date: Thu, 20 Aug 2015 12:00:00 -0500
From: "Shelton, Ben" <benjamin.h.shelton@intel.com>
To: linux-pci@vger.kernel.org
Subject: Convention for PCI device to handle bridge window change
Message-ID: <20150820165959.GB14073@bhshelto-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I'm working on an issue with an x64-based emulation system that has
multiple PCI-accessible FPGAs, each of which sits behind a PCI bridge.

We program the first FPGA and then warm-reboot the CPU.  When it comes
back up, there is an additional PCIe device that has been programmed
into the FPGA, and the kernel goes through the remapping process to
figure out how to fit everything.  The remapping succeeds by moving
several of the FPGA bridges out of the way.  The bridges get set up
properly, but the FPGA resources themselves get released but not
reassigned, and the BAR of the FPGA behind each bridge that got
relocated is still set to the old address.  If I add a hack in the boot
process to call pci_assign_resource() for those particular devices if
they have not been assigned, then everything works as expected.

Where is the usual place to handle updating the BAR for a device after
the bridge window of the bridge it's behind has changed?

Is it in the driver?  Looking at other drivers, there are a few that
call pci_assign_resource() explicitly if their resource has not been
assigned, e.g. drivers/char/agp/intel-agp.c.  There are also a few
drivers that used to do this but no longer do, e.g. ath10k (see commit
a6a2f74e for where it got removed).  

Or are resources behind a bridge that was relocated supposed to be
reassigned as part of the remapping process, and that just isn't
happening for some reason in our case?

Thanks,
Ben
