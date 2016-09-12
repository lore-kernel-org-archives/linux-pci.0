Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751203AbcILU4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 16:56:14 -0400
Date: Mon, 12 Sep 2016 15:56:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: 'Rajat Jain' <rajatja@google.com>,
        "'bhelgaas@google.com'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "'mika.westerberg@linux.intel.com'" <mika.westerberg@linux.intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Tarazona-Duarte, Luis Antonio"
        <luis.antonio.tarazona-duarte@intel.com>,
        'Rajat Jain' <rajatxjain@gmail.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] PCI: pciehp: Rework hotplug interrupt routine
Message-ID: <20160912205608.GB23532@localhost>
References: <92EBB4272BF81E4089A7126EC1E7B28466598F35@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28466598F35@IRSMSX101.ger.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 08:59:49AM +0000, Patel, Mayurkumar wrote:
> First scenario, on any slot events, pcie_isr() does as following,
> pcie_isr() -> do {...} while(detected) loop in which it
> reads PCI_EXP_SLTSTA, stores it in the intr_loc, then
> clears respective interrupts by writing to PCI_EXP_SLTSTA.
> Again, due to loop, it reads PCI_EXP_SLTSTA, which might
> have been changed already for the same type of interrupts
> because in the previous iteration they already got cleared.
> In this case, it will execute pciehp_queue_interrupt_event() only once
> based on the last event happened. This can be problematic
> for PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC types of
> interrupts as if they miss to process previous events then PCIe device
> enumeration can get effected.
> 
> Second scenario, pcie_isr() after clearing interrupts, it calls
> pciehp_get_adapter_status() before processing PCI_EXP_SLTSTA_PDS
> and pciehp_check_link_active() before processing PCI_EXP_SLTSTA_DLLSC
> and takes decisions based on that to do pciehp_queue_interrupt_event()
> which might also have already got changed due to the same
> fact that the respective interrupts got cleared earlier.
> 
> The patch removes re-inspection to avoid first scenario happening
> and just reads the events once and clears them as soon as possible.
> To successfully execute right Slot events for PDC and DLLSC types which
> triggered pcie_isr() it reads the PCI_EXP_SLTSTA_PDS and
> PCI_EXP_LNKSTA_DLLLA earlier before clearing the respective interrupts
> and executes pciehp_queue_interrupt_event() based on the stored
> status of these two Slot events.

I think this is great.  I split it into two patches, one to deal with
the loop and a second to stop re-reading PCI_EXP_SLTSTA.

I propose that we keep the loop, but restructure it a little.  If we
remove the loop completely, I worry that we may be able to miss an
interrupt.  I'm not confident that there is a hole, so maybe we
*could* remove the loop competely; I just couldn't convince myself
that it was safe both for INTx and MSI/MSI-X signaling.

I also added a few trivial patches for cleanup in the area.  I'll post
the whole set as a v2 for your comments.

Bjorn
