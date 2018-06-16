Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:60727 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPTZD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:25:03 -0400
Message-Id: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 00/32] Rework pciehp event handling & add runtime PM
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rework pciehp to use modern, threaded IRQ handling.  The slot is powered
on and off synchronously in the IRQ thread, no indirection via a work
queue anymore.

When the slot is enabled/disabled by the user via sysfs or an Attention
Button press, a request is sent to the IRQ thread.  The IRQ thread is
thus the sole entity enabling/disabling the slot.

The IRQ thread can cope with missed events, e.g. if a card is inserted
and immediately pulled out before the IRQ thread had a chance to react.
It also tolerates an initially unstable link as observed in the wild by
Stefan Roese.

Finally, runtime PM support is added.  This was the original motivation
of the series because runtime suspending hotplug ports is needed to power
down Thunderbolt controllers on idle, which saves ~1.5W per controller.
Runtime resuming ports takes tenths of milliseconds during which events
may be missed, this in turn necessitated the event handling rework.

I've pushed the series to GitHub to ease reviewing/fetching:
https://github.com/l1k/linux/commits/pciehp_runpm_v2

Please review and test.

Thanks,

Lukas


Lukas Wunner (32):
  PCI: hotplug: Don't leak pci_slot on registration failure
  PCI: pciehp: Fix UAF on unplug
  PCI: pciehp: Fix deadlock on unplug
  PCI: pciehp: Fix unprotected list iteration in IRQ handler
  PCI: pciehp: Drop unnecessary NULL pointer check
  PCI: pciehp: Declare pciehp_unconfigure_device() void
  PCI: pciehp: Document struct slot and struct controller
  genirq: Synchronize only with single thread on free_irq()
  PCI: pciehp: Convert to threaded IRQ
  PCI: pciehp: Convert to threaded polling
  PCI: pciehp: Stop blinking on slot enable failure
  PCI: pciehp: Handle events synchronously
  PCI: pciehp: Drop slot workqueue
  PCI: hotplug: Demidlayer registration with the core
  PCI: pciehp: Publish to user space last on probe
  PCI: pciehp: Track enable/disable status
  PCI: pciehp: Enable/disable exclusively from IRQ thread
  PCI: pciehp: Drop enable/disable lock
  PCI: pciehp: Declare pciehp_enable/disable_slot() static
  PCI: pciehp: Tolerate initially unstable link
  PCI: pciehp: Become resilient to missed events
  PCI: pciehp: Always enable occupied slot on probe
  PCI: pciehp: Avoid slot access during reset
  PCI: portdrv: Deduplicate PM callback iterator
  PCI: pciehp: Clear spurious events earlier on resume
  PCI: pciehp: Obey compulsory command delay after resume
  PCI: pciehp: Support interrupts sent from D3hot
  PCI: pciehp: Resume to D0 on enable/disable
  PCI: pciehp: Resume parent to D0 on config space access
  PCI: sysfs: Resume to D0 on function reset
  PCI: Whitelist native hotplug ports for runtime D3
  PCI: Whitelist Thunderbolt ports for runtime D3

 drivers/pci/hotplug/acpiphp_core.c      |  22 +-
 drivers/pci/hotplug/cpci_hotplug_core.c |  14 +-
 drivers/pci/hotplug/cpqphp_core.c       |  16 +-
 drivers/pci/hotplug/ibmphp_core.c       |  15 +-
 drivers/pci/hotplug/ibmphp_ebda.c       |  20 --
 drivers/pci/hotplug/pci_hotplug_core.c  | 134 +++++++--
 drivers/pci/hotplug/pciehp.h            | 117 ++++++--
 drivers/pci/hotplug/pciehp_core.c       | 104 ++++---
 drivers/pci/hotplug/pciehp_ctrl.c       | 352 ++++++++++--------------
 drivers/pci/hotplug/pciehp_hpc.c        | 261 ++++++++++--------
 drivers/pci/hotplug/pciehp_pci.c        |  42 ++-
 drivers/pci/hotplug/pcihp_skeleton.c    |  16 +-
 drivers/pci/hotplug/pnv_php.c           |   5 +-
 drivers/pci/hotplug/rpaphp_core.c       |   2 +-
 drivers/pci/hotplug/rpaphp_slot.c       |  13 +-
 drivers/pci/hotplug/s390_pci_hpc.c      |  13 +-
 drivers/pci/hotplug/sgi_hotplug.c       |   9 +-
 drivers/pci/hotplug/shpchp_core.c       |  20 +-
 drivers/pci/pci-sysfs.c                 |   2 +
 drivers/pci/pci.c                       |  21 +-
 drivers/pci/pcie/portdrv.h              |   2 +
 drivers/pci/pcie/portdrv_core.c         |  30 +-
 drivers/pci/pcie/portdrv_pci.c          |   2 +
 drivers/platform/x86/asus-wmi.c         |  12 +-
 drivers/platform/x86/eeepc-laptop.c     |  12 +-
 include/linux/pci_hotplug.h             |  15 +-
 kernel/irq/manage.c                     |  21 +-
 27 files changed, 687 insertions(+), 605 deletions(-)

-- 
2.17.1
