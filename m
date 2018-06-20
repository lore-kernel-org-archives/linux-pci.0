Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:50589 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFTLBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2018 07:01:42 -0400
Date: Wed, 20 Jun 2018 13:01:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Xiongfeng Wang <xiongfeng.wang@linaro.com>
Subject: Re: [PATCH 09/32] PCI: pciehp: Convert to threaded IRQ
Message-ID: <20180620110140.GA8724@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <b65b18957cec018dec5c1f1c3de0e2e47b46b265.1529173804.git.lukas@wunner.de>
 <20180619231646.GA22648@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180619231646.GA22648@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Xiongfeng Wang]

On Tue, Jun 19, 2018 at 05:16:46PM -0600, Keith Busch wrote:
> I am a little concered about what may happen if we need to remove the
> bridge while its irq thread is running. The task removing the bridge
> is holding the pci_rescan_remove_lock so when it tries to free the
> bridge IRQ, the IRQ subsystem may not be able to progress because the
> action->thread may be waiting to take the same lock.
> 
> It actually looks like the same deadlock already exists in the current
> implementation when it takes down its workqueue, but it's a lot harder to
> follow all the different work tasks before this clean-up. Maybe removing
> bridges isn't very common, but it's just something I noticed.

In patch [03/32], "PCI: pciehp: Fix deadlock on unplug", I've fixed
this deadlock in case the lock is contended by two pciehp instances.

But when browsing patchwork yesterday, I came across Xiongfeng Wang's
patch "pciehp: fix a race between pciehp and removing operations by sysfs".
It deals with the same deadlock, but the contenders for the lock are a
pciehp instance and a sysfs "remove" request:
https://patchwork.ozlabs.org/patch/877835/

We need a generic solution which works regardless of the contenders'
type, so I'm withdrawing patch [03/32] and I'll try to come up with
something better.

It seems this is about the hierarchy, we need to prevent that the lock
is acquired to remove a device which is a child of another device which
is already being removed, wherefore the lock is currently held.  An idea
would be to change the API such that a struct pci_dev pointer is passed
in to pci_lock_rescan_remove().  That's the device being removed and
for which the lock is handed out.  If the lock is requested for a child,
the request is denied.  The invocation would thus look like this:

 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev)
 {
-	pci_lock_rescan_remove();
+	if (!pci_trylock_rescan_remove(dev));
+		return;
 	pci_stop_and_remove_bus_device(dev);
 	pci_unlock_rescan_remove();
 }

Thoughts?

Lukas
