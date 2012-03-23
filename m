Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34156 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab2CWPBV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 11:01:21 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 00/11] Enhancements and bugfixes to PCI hotplug subsystem
Date: Fri, 23 Mar 2012 22:58:16 +0800
Message-Id: <1332514707-9673-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a series of RFC patches, to make sure we are doing the
right thing in the right way.  The patchset hasn't been tested yet.
There are several minor bugfixes and two proposals.

The first proposal is to add notification chain for PCI hotplug events,
so other components interested in PCI root/bus/device hotplug events
could subscribe to the chain.

The second prososal is to introduce a recursive mutex lock to
serialize all hotplug operations triggered by sysfs interfaces,
PCI HPC hardware events, ACPI hotplug events and other sources.

There are still works left in driver/pci/hotplug directory to apply
the above two proposals.

The patchset applies to Yinghai's work on PCI root bus hotplug at
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-x86-irq
And it depends on my previous patchset, please refer to
http://www.spinics.net/lists/linux-pci/msg14472.html

Thanks!

Jiang Liu (11):
  PCI: Fix device reference count leakage in pci_dev_present()
  PCI: introduce pci_bus_get()/pci_bus_put() to hide implementation
    details
  PCI: clean up root bridge related logic in acpiphp driver
  ACPI,PCI: fix race windows caused by alloc_acpi_hotplug_work()
  PCI: Add notification interfaces for PCI root/bus/device hotplug
    events
  ACPI,PCI: update ACPI<->PCI binding information when pci hotplug
    event happens
  ACPI,PCI: update ACPI slots when PCI hotplug event happens
  PCI: Introduce recursive mutex to serialize PCI hotplug operations
  PCI: serialize hotplug operations triggered by PCI hotplug sysfs
    interfaces
  PCI,ACPI: serialize hotplug operations triggered by ACPI subsystem
  PCI: Serialize hotplug operations triggered by acpiphp driver

 drivers/acpi/pci_bind.c                |  115 +++++++++++++++++++++++++
 drivers/acpi/pci_root.c                |    8 ++
 drivers/acpi/pci_slot.c                |   81 ++++++++++++++++++-
 drivers/pci/bus.c                      |   20 ++++-
 drivers/pci/hotplug.c                  |   47 +++++++++++
 drivers/pci/hotplug/acpiphp.h          |    7 ++-
 drivers/pci/hotplug/acpiphp_glue.c     |  143 ++++++++++++--------------------
 drivers/pci/hotplug/pci_hotplug_core.c |    2 +
 drivers/pci/pci-sysfs.c                |   29 +++----
 drivers/pci/pci.h                      |    8 ++
 drivers/pci/probe.c                    |   10 ++-
 drivers/pci/remove.c                   |   20 ++++-
 drivers/pci/search.c                   |   10 +-
 include/linux/pci.h                    |   57 +++++++++++++
 14 files changed, 437 insertions(+), 120 deletions(-)

-- 
1.7.5.4

