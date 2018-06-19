Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18179 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbeFSXNi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jun 2018 19:13:38 -0400
Date: Tue, 19 Jun 2018 17:16:46 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 09/32] PCI: pciehp: Convert to threaded IRQ
Message-ID: <20180619231646.GA22648@localhost.localdomain>
References: <cover.1529173804.git.lukas@wunner.de>
 <b65b18957cec018dec5c1f1c3de0e2e47b46b265.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b65b18957cec018dec5c1f1c3de0e2e47b46b265.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2018 at 12:25:00PM -0700, Lukas Wunner wrote:
> pciehp's IRQ handler queues up a work item for each event signaled by
> the hardware.  A more modern alternative is to let a long running
> kthread service the events.  The IRQ handler's sole job is then to check
> whether the IRQ originated from the device in question, acknowledge its
> receipt to the hardware to quiesce the interrupt and wake up the kthread.
> 
> One benefit is reduced latency to handle the IRQ, which is a necessity
> for realtime environments.  Another benefit is that we can make pciehp
> simpler and more robust by handling events synchronously in process
> context, rather than asynchronously by queueing up work items.  pciehp's
> usage of work items is a historic artifact, it predates the introduction
> of threaded IRQ handlers by two years.  (The former was introduced in
> 2007 with commit 5d386e1ac402 ("pciehp: Event handling rework"), the
> latter in 2009 with commit 3aa551c9b4c4 ("genirq: add threaded interrupt
> handler support").)
> 
> Convert pciehp to threaded IRQ handling by retrieving the pending events
> in pciehp_isr(), saving them for later consumption by the thread handler
> pciehp_ist() and clearing them in the Slot Status register.
> 
> By clearing the Slot Status (and thereby acknowledging the events) in
> pciehp_isr(), we can avoid requesting the IRQ with IRQF_ONESHOT, which
> would have the unpleasant side effect of starving devices sharing the
> IRQ until pciehp_ist() has finished.
> 
> pciehp_isr() does not count how many times each event occurred, but
> merely records the fact *that* an event occurred.  If the same event
> occurs a second time before pciehp_ist() is woken, that second event
> will not be recorded separately, which is problematic according to
> commit fad214b0aa72 ("PCI: pciehp: Process all hotplug events before
> looking for new ones") because we may miss removal of a card in-between
> two back-to-back insertions.  We're about to make pciehp_ist() resilient
> to missed events.  The present commit regresses the driver's behavior
> temporarily in order to separate the changes into reviewable chunks.
> This doesn't affect regular slow-motion hotplug, only plug-unplug-plug
> operations that happen in a timespan shorter than wakeup of the IRQ
> thread.

I like the series over-all. Definitely an improvement.

I am a little concered about what may happen if we need to remove the
bridge while its irq thread is running. The task removing the bridge
is holding the pci_rescan_remove_lock so when it tries to free the
bridge IRQ, the IRQ subsystem may not be able to progress because the
action->thread may be waiting to take the same lock.

It actually looks like the same deadlock already exists in the current
implementation when it takes down its workqueue, but it's a lot harder to
follow all the different work tasks before this clean-up. Maybe removing
bridges isn't very common, but it's just something I noticed.
