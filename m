Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:34353 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeA2OIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jan 2018 09:08:17 -0500
Date: Mon, 29 Jan 2018 15:08:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Matthew Minter <matt@masarand.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Access to inaccessible PCI devices by 30fdfb929e82
Message-ID: <20180129140815.GA22041@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There appears to be an issue with commit 30fdfb929e82

    Author: Matthew Minter <matt@masarand.com>
    Date:   Wed Jun 28 15:14:04 2017 -0500
    PCI: Add a call to pci_assign_irq() in pci_device_probe()

wherein config space of a PCI device is accessed upon probe even though
the device may be inaccessible:

pci_pm_runtime_idle() and pci_pm_runtime_suspend() keep unbound devices
in D0, however they return 0 which results in the PM core considering
the device to have "suspended" status.  By default we prevent the device
from runtime suspending by calling pm_runtime_forbid() in pci_pm_init(),
however the user may subsequently allow runtime PM via sysfs.

If the user allows runtime PM on an unbound device and that device is
located below a root port, that root port will runtime suspend to D3hot
because its child is considered to be runtime suspended.

Even though the device is technically in D0, the bus below the root port
is now no longer in B0 and so the device is *effectively* in D3hot and
thus inaccessible.

We call pm_runtime_get_sync() in local_pci_probe() and this causes the
root port to resume to D0, making the device accessible again.

However the call to pci_assign_irq() introduced by the above-mentioned
commit happens *before* the call to pm_runtime_get_sync().  Thus, when
pci_assign_irq() accesses config space, it reads 0xff as IRQ number.

There are multiple possible solutions, including:

- Moving the invocation of pci_assign_irq() after pm_runtime_get_sync().

- Moving the invocation of pm_runtime_get_sync() before pci_assign_irq().

- Amending pci_pm_runtime_idle() and pci_pm_runtime_suspend() like this:
  if (!pci_dev->driver) {
	pm_runtime_forbid(dev);
	return -EBUSY;
  }

I don't know which solution is appropriate so I'm deferring to Rafael.

I'm not affected by this issue (my machine's struct pci_host_bridge
lacks the ->map_irq callback), it's just something that caught my eye
while perusing the code.

Thanks,

Lukas
