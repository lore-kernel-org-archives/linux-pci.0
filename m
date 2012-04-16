Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37352 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab2DPQcG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:32:06 -0400
Received: by dake40 with SMTP id e40so7132053dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:32:06 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Dely Sy <dely.l.sy@intel.com>,
	Scott Murray <scott@spiteful.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 00/17] Introduce a global lock to serialize all PCI hotplug
Date: Tue, 17 Apr 2012 00:28:54 +0800
Message-Id: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are multiple ways to trigger PCI hotplug requests concurrently,
such as:
1. Sysfs interfaces exported by the PCI core subsystem
2. Sysfs interfaces exported by the PCI hotplug subsystem
3. PCI hotplug events triggered by PCI Hotplug Controllers
4. ACPI hotplug events for PCI host bridges
5. Driver binding/unbinding events

The PCI core subsystem doesn't support concurrent hotplug operations yet,
so all PCI hotplug requests should be globally serialized. This patchset
introduces a global recursive rwsem to serialize all PCI hotplug operations.

Following PCI hotplug drivers/interfaces have been enhanced with this
1. Sysfs interfaces exported by the PCI core subsystem
2. Sysfs interfaces exported by the PCI hotplug subsystem
3. pciehp
4. shpchp
5. cpcihp_generic and cpcihp_zt5550
6. fakephp

But there are still several TODOs:
1) all other PCI hotplug driver in drivers/pci/hotplug directory
2) SR-IOV
3) acpiphp (plan to do this based on Yinghai's PCI root bus hotplug gate)
4) pci_root (plan to do this based on Yinghai's PCI root bus hotplug gate)

Basic test has been done as below, will find more hardwares to do more tests.
Start three scripts on an Intel Atom system to currently execute:
1) remove/rescan PCI devices by sysfs interfaces exported by PCI core subsystem
2) remove/rescan PCI devices by sysfs interfaces exported by fakephp driver
3) load/unload fakephp driver
The test has run about four hours without failure.

Jiang Liu (17):
  PCI: introduce pci_bus_get()/pci_bus_put() to hide PCI implementation
    details
  PCI: introduce recursive rwsem to serialize PCI hotplug operations
  PCI: replace pci_remove_rescan_mutex with the PCI hotplug lock
  PCI: serialize hotplug operations triggered by PCI hotplug sysfs
    interfaces
  PCI: correctly flush workqueue when destroy pcie hotplug controller
  PCI: prepare for serializing hotplug operations triggered by pciehp
    driver
  PCI: serialize hotplug operaitons triggered by the pciehp driver
  PCI: fix two race windows when probing/removing SHPC controller
  PCI: correctly flush workqueues and timer when destroy SHPC
    controller
  PCI: serialize hotplug operaitons triggered by the shpchp driver
  PCI: release IO resource in error handling path in
    cpcihp_generic_init()
  PCI: clean up all resources in error handling path in
    zt5550_hc_init_one()
  PCI: trivial code clean up in cpci_hotplug_core.c
  PCI: fix race windows when shutting down cpcihp controller
  PCI: hold a reference count to the PCI bus used by cpcihp drivers
  PCI: serialize PCI hotplug operations triggered by cpcihp drivers
  PCI: serialize PCI hotplug operations triggered by fakephp drivers

 drivers/pci/bus.c                       |   15 +++++
 drivers/pci/hotplug.c                   |   55 +++++++++++++++++
 drivers/pci/hotplug/cpci_hotplug_core.c |   53 +++++++++-------
 drivers/pci/hotplug/cpcihp_generic.c    |   30 +++++++---
 drivers/pci/hotplug/cpcihp_zt5550.c     |   21 +++++--
 drivers/pci/hotplug/fakephp.c           |   38 ++++++++++--
 drivers/pci/hotplug/pci_hotplug_core.c  |   26 ++++++--
 drivers/pci/hotplug/pciehp.h            |    5 +-
 drivers/pci/hotplug/pciehp_core.c       |   25 ++++++--
 drivers/pci/hotplug/pciehp_ctrl.c       |   56 ++++++++++++++++-
 drivers/pci/hotplug/pciehp_hpc.c        |   18 +++++-
 drivers/pci/hotplug/shpchp.h            |    3 +
 drivers/pci/hotplug/shpchp_core.c       |   11 ++--
 drivers/pci/hotplug/shpchp_ctrl.c       |   32 ++++++++++
 drivers/pci/hotplug/shpchp_hpc.c        |   36 +++++++-----
 drivers/pci/pci-sysfs.c                 |  100 +++++++++++++++++-------------
 drivers/pci/remove.c                    |    1 +
 include/linux/pci.h                     |   16 +++++
 18 files changed, 415 insertions(+), 126 deletions(-)

-- 
1.7.5.4

