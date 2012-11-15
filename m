Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:64553 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab2KODyw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2012 22:54:52 -0500
Received: by mail-fa0-f74.google.com with SMTP id w1so76606fad.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Nov 2012 19:54:50 -0800 (PST)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.17.131.112])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id B034D20004E
	for <linux-pci@vger.kernel.org>; Wed, 14 Nov 2012 19:54:49 -0800 (PST)
Date: Wed, 14 Nov 2012 20:54:48 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Subject: Changes for v3.8 merge window
Message-ID: <20121115035448.GB6613@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Below are the patches currently in my "next" branch, planned for release in
v3.8.  If I'm missing something important, let me know.

next-20121115 will be the last linux-next release until next-20121126,
which will probably be just after -rc7.  That means we won't have much
chance for integration testing of patches I merge between now and the merge
window, so I probably won't merge major pieces.

I've been busy with other work this cycle, so I haven't been able to review
and merge as much as I'd hoped.  I'll start putting things on branches
destined for v3.9.  After the v3.8 merge window closes, I will rebase these
branches and fold them into my "next" branch for v3.9.



Andrew Cooks (1):
      PCI: Add GPL license for drivers/pci/ioapic module

Bjorn Helgaas (11):
      ACPI: Pass segment/bus to _PRT add/del so they don't depend on pci_bus
      PCI/ACPI: Add _PRT interrupt routing info before enumerating devices
      x86/PCI: Ignore _SEG on HP xw9300
      Merge branch 'pci/misc' into next
      Merge branch 'pci/yinghai-for-pci-root-bus-hotplug' into next
      Merge branch 'pci/taku-prt-cleanup' into next
      Merge branch 'pci/mike-x86-tra' into next
      PCI: Use spec names for SR-IOV capability fields
      PCI: Remove useless "!dev" tests
      Merge branch 'pci/don-sriov' into next
      Merge branch 'pci/misc' into next

Dave Airlie (1):
      PCI: Don't touch card regs after runtime suspend D3

Donald Dutile (2):
      PCI: SRIOV control and status via sysfs
      PCI: Provide method to reduce the number of total VFs supported

Huang Ying (2):
      PCI/PM: Add comments for PME poll support for PCIe
      PCI/ACPI: Notify PCI devices when their power resource is turned on

Ian Abbott (2):
      PCI: Add workaround for PLX PCI 9050 BAR alignment erratum
      PCI: Add PLX PCI 9050 workaround for some Meilhaus DAQ cards

Jingoo Han (1):
      PCI: Fix bit definitions of PCI_EXP_LNKCAP2 register

Joe Perches (1):
      PCI: Convert dev_printk(KERN_<LEVEL> to dev_<level>(

Mike Yoknis (1):
      x86/PCI: Allow x86 platforms to use translation offsets

Taku Izumi (2):
      PCI: Don't pass pci_dev to pci_ext_cfg_avail()
      PCI/ACPI: Request _OSC control before scanning PCI root bus

Yinghai Lu (10):
      PCI: Separate out pci_assign_unassigned_bus_resources()
      PCI: Move pci_rescan_bus() back to probe.c
      PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
      PCI/ACPI: Assign unassigned resource for hot-added root bus
      PCI: Add pci_stop_and_remove_root_bus()
      PCI/ACPI: Make acpi_pci_root_remove() stop/remove pci root bus
      PCI/ACPI: Delete host bridge _PRT during hot remove path
      PCI/ACPI: Remove acpi_root_driver in reverse order
      PCI: Add pci_device_type to pdev's device struct
      PCI: Use is_visible() with boot_vga attribute for pci_dev

 arch/x86/pci/acpi.c           |  46 +++++++++--
 arch/x86/pci/common.c         |   2 +-
 drivers/acpi/pci_bind.c       |  12 +--
 drivers/acpi/pci_irq.c        |  17 ++---
 drivers/acpi/pci_root.c       | 165 +++++++++++++++++++++++-----------------
 drivers/pci/ioapic.c          |   2 +
 drivers/pci/iov.c             |  87 ++++++++++++++++-----
 drivers/pci/irq.c             |  10 +--
 drivers/pci/pci-driver.c      |   6 +-
 drivers/pci/pci-stub.c        |   2 +-
 drivers/pci/pci-sysfs.c       | 172 +++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.c             |  33 +++++---
 drivers/pci/pci.h             |   8 +-
 drivers/pci/pcie/aspm.c       |   7 +-
 drivers/pci/probe.c           |  23 ++++++
 drivers/pci/quirks.c          |  39 ++++++++++
 drivers/pci/remove.c          |  36 +++++++++
 drivers/pci/setup-bus.c       |  22 +-----
 include/acpi/acpi_drivers.h   |   4 +-
 include/linux/pci.h           |  16 +++-
 include/uapi/linux/pci_regs.h |   6 +-
 21 files changed, 538 insertions(+), 177 deletions(-)
