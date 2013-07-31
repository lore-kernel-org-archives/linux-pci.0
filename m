Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785Ab3GaDbe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Jul 2013 23:31:34 -0400
Subject: [RFC PATCH 0/7] pci: bus and slot reset interfaces
To: linux-pci@vger.kernel.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, indou.takao@jp.fujitsu.com
Date: Tue, 30 Jul 2013 21:31:29 -0600
Message-ID: <20130731031316.31931.56751.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds PCI bus and slot reset interfaces to the already
existing function reset interface.  I need this for two reasons, the
first is that not all devices support function level reset.  Even
some of those that we detect as supporting a PM reset on D3hot->D0
transition actually don't do any reset.  Others have no reset
capability at all.  We currently implement a secondary bus reset
escalation from the function reset path, but only when there is a
single devfn on the bus.  Drivers like vfio can have ownership of
all of the devices on a bus and should therefore have a path to
initiate a secondary bus reset with multiple devices.  This is
particularly required for use of GPUs by userspace, where none of
the predominant GPUs implement a useful function level reset.

The second reason is that even the current function reset escalating
to a secondary bus reset can cause problems with hotplug controllers.
If a root port supports PCIe HP with suprise removal, a bus reset
can trigger a presence detection change, which results in an attempt
to remove the struct device.  By having a slot reset interface, we
can involve the hotplug controllers to allow for a controlled bus
reset and avoid this spurious removal attempt.

Takao-san also needs a PCI bus reset interface to quiesce devices
during kexec.  I believe this interface also provides that.

Why is this an RFC?  I posted this a while back and self-nacked it
because there were issues when hotplug was built as a module.  Now
that we're removing module support for PCI hotplug and pciehp in
particular, I think that problem is resolved, but it needs further
testing.  Coments welcome.  Thanks,

Alex

---

Alex Williamson (7):
      pci: Create pci_reset_bridge_secondary_bus()
      pci: Add hotplug_slot_ops.reset_slot()
      pci: Implement reset_slot for pciehp
      pci: Add slot reset option to pci_dev_reset
      pci: Split out pci_dev lock/unlock and save/restore
      pci: Add slot and bus reset interfaces
      pci: Wake-up devices before save for reset


 drivers/pci/hotplug/pciehp.h      |    1 
 drivers/pci/hotplug/pciehp_core.c |   12 +
 drivers/pci/hotplug/pciehp_hpc.c  |   31 ++++
 drivers/pci/pci.c                 |  320 ++++++++++++++++++++++++++++++++++---
 include/linux/pci.h               |    3 
 include/linux/pci_hotplug.h       |    4 
 6 files changed, 345 insertions(+), 26 deletions(-)
