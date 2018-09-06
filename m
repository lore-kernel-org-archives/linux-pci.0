Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:51503 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeIFWp0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 18:45:26 -0400
Date: Thu, 6 Sep 2018 21:08:31 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 03/32] PCI: pciehp: Fix deadlock on unplug
Message-ID: <20180906180831.GC14465@lahna.fi.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de>
 <20180906160100.GQ2283@lahna.fi.intel.com>
 <20180906162634.ylyp3ydwujf5wuxx@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906162634.ylyp3ydwujf5wuxx@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 06, 2018 at 06:26:34PM +0200, Lukas Wunner wrote:
> I asked for it to be dropped because while it fixes the problem,
> it's not a good solution, it would just add technical debt to the
> code base and come back to haunt us later.
> 
> Xiongfeng Wang found a similar race a few months ago that wouldn't
> be fixed by my patch:
> https://patchwork.ozlabs.org/patch/877835/
> 
> The PCI core nicely separates unbinding of drivers from destruction
> of the pci_dev (pci_stop_bus_device() + pci_remove_bus_device()).
> Problem is we currently protect both steps with pci_lock_rescan_remove().
> We should only be protecting the second step.  The first step (unbinding)
> needs to run lockless.
> 
> As a start, I've moved the call to pcie_aspm_exit_link_state() out
> of pci_stop_dev().  This also fixes an ASPM bug.  Bjorn merged it
> the day before yesterday:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/aspm&id=1f3934b1d5e5
> 
> The call to device_release_driver() already uses locking internally
> and can be run lockless.  The calls to pci_proc_detach_device() and
> pci_remove_sysfs_dev_files() need to be amended with locking, I've
> got some preliminary patches for this on my development branch that
> I'll have to rework.  This is very hairy, historically grown code
> that requires great care to avoid breakage.  It'll take a little
> more time I'm afraid.

OK, thanks for the explanation. I see you have a good plan going forward
with this.

I can reproduce the issue easily so can assist in testing if needed.
