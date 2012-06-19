Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:44339 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab2FSNZo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 09:25:44 -0400
From: Jiang Liu <jiang.liu@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
CC: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v8 00/12] PCI, x86: update MMCFG information when hot-plugging PCI host bridges
Date: Tue, 19 Jun 2012 21:15:20 +0800
Message-ID: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset enhance pci_root driver to update MMCFG information when
hot-plugging PCI root bridges. It applies to 
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next-3.5

-v2: split into smaller patches and skip updating MMCFG information when
     MMCFG is disabled
-v3: add mmconf_added to simply free path, also make pci_mmconfig_insert()
     to process extra exist case --- By Yinghai
-v4: tune arch_acpi_pci_root_add() to handle a corner case raised by Kenji
-v5: address review comments from Bjorn and Taku, also better handle corner
     cases in arch_acpi_pci_root_add()
-v6: get rid of arch_acpi_pci_root_xxx() by using existing hooks
     add MCFG information for host bridges on demand
     more corner cases clear up
     correctly handle condition compilation
     fix section mismatch issues
     fix a issue reported by Taku about a BIOS bug
-v7: unify log messages
     remove redundant host bridge resource related log messages
     fix a issue reported by Taku which breaks pnp resource allocation
-v8: 1) add acpi_pci_cache_mcfg() in patch "provide MCFG address for PCI host
     bridges" for better readability and fix a condition compilation issue
     2) change patch "add MMCFG information on demand" to RFC and fix
     compilation issues reported by Fengguang
     3) Add new patch "refine __pci_mmcfg_init() for better code readability"
      and "mark acpi_sfi_table_parse() as __init", there should no
      functionality changes.

Jiang Liu (12):
  x86/PCI: split out pci_mmcfg_check_reserved() for code reuse
  x86/PCI: split out pci_mmconfig_alloc() for code reuse
  x86/PCI: use RCU list to protect mmconfig list
  x86/PCI: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
  x86/PCI: add pci_mmconfig_insert()/delete() for PCI root bridge
    hotplug
  PCI/ACPI: provide MCFG address for PCI host bridges
  x86/PCI: update MMCFG information when hot-plugging PCI host bridges
  x86/PCI: simplify pci_mmcfg_late_insert_resources()
  x86/PCI: get rid of redundant log messages
  x86/PCI: refine __pci_mmcfg_init() for better code readability
  ACPI: mark acpi_sfi_table_parse() as __init
  x86/PCI: add MMCFG information on demand

 arch/x86/include/asm/pci_x86.h |   12 ++
 arch/x86/pci/acpi.c            |   76 +++++++-
 arch/x86/pci/legacy.c          |    1 +
 arch/x86/pci/mmconfig-shared.c |  429 +++++++++++++++++++++++++++++-----------
 arch/x86/pci/mmconfig_32.c     |   30 +++-
 arch/x86/pci/mmconfig_64.c     |   37 +++-
 drivers/acpi/pci_root.c        |   12 ++
 drivers/pci/pci-acpi.c         |   60 ++++++
 include/acpi/acnames.h         |    1 +
 include/acpi/acpi_bus.h        |    3 +
 include/linux/pci-acpi.h       |    5 +
 include/linux/sfi_acpi.h       |    4 +-
 12 files changed, 536 insertions(+), 134 deletions(-)


