Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeGML6c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Jul 2018 07:58:32 -0400
Date: Fri, 13 Jul 2018 06:44:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/32] genirq: Synchronize only with single thread on
 free_irq()
Message-ID: <20180713114411.GI28466@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <83cfe0c826f1d793e2ead9032ef2109b5efa403a.1529173804.git.lukas@wunner.de>
 <20180712222109.GE28466@bhelgaas-glaptop.roam.corp.google.com>
 <20180713072109.GA23955@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180713072109.GA23955@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 13, 2018 at 09:21:09AM +0200, Lukas Wunner wrote:
> On Thu, Jul 12, 2018 at 05:21:09PM -0500, Bjorn Helgaas wrote:
> > On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > > When pciehp is converted to threaded IRQ handling, removal of unplugged
> > > devices below a PCIe hotplug port happens synchronously in the IRQ
> > > thread.  Removal of devices typically entails a call to free_irq() by
> > > their drivers.
> > > 
> > > If those devices share their IRQ with the hotplug port, free_irq()
> > > deadlocks because it calls synchronize_irq() to wait for all hard IRQ
> > > handlers as well as all threads sharing the IRQ to finish.
> > > 
> > > Actually it's sufficient to wait only for the IRQ thread of the removed
> > > device, so call synchronize_hardirq() to wait for all hard IRQ handlers
> > > to finish, but no longer for any threads.  Compensate by rearranging the
> > > control flow in irq_wait_for_interrupt() such that the device's thread
> > > is allowed to run one last time after kthread_stop() has been called.
> > 
> > I assume this would need to be merged along with the rest of the
> > series, which should probably go through the PCI tree, but I'm
> > definitely not qualified to review this IRQ patch.  And it would need
> > an ack from Thomas in any case.
> 
> A v2 of this patch has already been merged through the tip tree on June 24,
> it's in linux-next as commit 519cc8652b3a, and ISTR that I marked this patch
> either as "Obsoleted" or "Not Applicable" in pci-patchwork.  There was no
> build-dependency of the succeeding patches in the series on this patch,
> hence merging through a different tree was possible.

Perfect, thanks!
