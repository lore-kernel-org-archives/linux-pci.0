Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeGPOse (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Jul 2018 10:48:34 -0400
Date: Mon, 16 Jul 2018 09:20:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180716142053.GA12391@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> Rework pciehp to use modern, threaded IRQ handling.  The slot is powered
> on and off synchronously in the IRQ thread, no indirection via a work
> queue anymore.
> 
> When the slot is enabled/disabled by the user via sysfs or an Attention
> Button press, a request is sent to the IRQ thread.  The IRQ thread is
> thus the sole entity enabling/disabling the slot.
> 
> The IRQ thread can cope with missed events, e.g. if a card is inserted
> and immediately pulled out before the IRQ thread had a chance to react.
> It also tolerates an initially unstable link as observed in the wild by
> Stefan Roese.
> 
> Finally, runtime PM support is added.  This was the original motivation
> of the series because runtime suspending hotplug ports is needed to power
> down Thunderbolt controllers on idle, which saves ~1.5W per controller.
> Runtime resuming ports takes tenths of milliseconds during which events
> may be missed, this in turn necessitated the event handling rework.
> 
> I've pushed the series to GitHub to ease reviewing/fetching:
> https://github.com/l1k/linux/commits/pciehp_runpm_v2

My current test branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/06-16-lukas-pciehp

has this series with these changes:

  - Drop the genirq patch (already merged via tip)

  - Add one blank line (pcie_cleanup_slot())

  - A few trivial changelog updates (mostly to use lkml.kernel.org
    links to reduce dependency on 3rd party archives)

Do you plan any other updates?  The open questions I see are:

  - You mentioned withdrawing "03/32 PCI: pciehp: Fix deadlock on
    unplug".  I tried simply dropping that, but that caused a conflict
    that I didn't try to resolve.

  - Mika had a few questions/comments that are still dangling.

  - Whether to include "02/32 PCI: pciehp: Fix UAF on unplug" in the
    v4.19 merge window or in v4.18.

Bjorn
