Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:37655 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIFVCv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2018 17:02:51 -0400
Date: Thu, 6 Sep 2018 18:26:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 03/32] PCI: pciehp: Fix deadlock on unplug
Message-ID: <20180906162634.ylyp3ydwujf5wuxx@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de>
 <20180906160100.GQ2283@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906160100.GQ2283@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 06, 2018 at 07:01:00PM +0300, Mika Westerberg wrote:
> On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > When pciehp was conceived it apparently wasn't considered that one
> > hotplug port may be the parent of another, but with Thunderbolt this is
> > par for the course.
> > 
> > If the sysfs interface is used to initiate a simultaneous card removal
> > of two hotplug ports where one is a parent of the other, or if the two
> > ports simultaneously signal interrupts, e.g. because a link or presence
> > change was detected on both, a deadlock may occur if:
> > 
> > - The parent acquires pci_lock_rescan_remove(), starts removal of the
> >   child and waits for it to be unbound.
> > - The child waits to acquire pci_lock_rescan_remove() in order to
> >   service the pending sysfs command or interrupt before it can unbind.
> > 
> > Fix by using pci_dev_is_disconnected() as an indicator whether a parent
> > is removing the child, and avoid acquiring the lock in the child if so.
> > Should the child happen to acquire the lock first, there's no deadlock.
> 
> This patch got dropped from your pciehp series but I wonder if you have
> any plans to re-send it or rework it?
> 
> I'm asking because this is pretty real issue if you have longer chains
> of devices and I've been using this patch to make the issue go away. So
> even if this is not solving all possible problems, I think it may be
> good idea to get included.

I asked for it to be dropped because while it fixes the problem,
it's not a good solution, it would just add technical debt to the
code base and come back to haunt us later.

Xiongfeng Wang found a similar race a few months ago that wouldn't
be fixed by my patch:
https://patchwork.ozlabs.org/patch/877835/

The PCI core nicely separates unbinding of drivers from destruction
of the pci_dev (pci_stop_bus_device() + pci_remove_bus_device()).
Problem is we currently protect both steps with pci_lock_rescan_remove().
We should only be protecting the second step.  The first step (unbinding)
needs to run lockless.

As a start, I've moved the call to pcie_aspm_exit_link_state() out
of pci_stop_dev().  This also fixes an ASPM bug.  Bjorn merged it
the day before yesterday:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/aspm&id=1f3934b1d5e5

The call to device_release_driver() already uses locking internally
and can be run lockless.  The calls to pci_proc_detach_device() and
pci_remove_sysfs_dev_files() need to be amended with locking, I've
got some preliminary patches for this on my development branch that
I'll have to rework.  This is very hairy, historically grown code
that requires great care to avoid breakage.  It'll take a little
more time I'm afraid.

Thanks,

Lukas
