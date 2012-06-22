Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65325 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760330Ab2FVG4o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 02:56:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3169265pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 23:56:44 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v10 00/13] x86/PCI: update MMCFG information when hot-plugging PCI host bridges
Date: Fri, 22 Jun 2012 14:55:09 +0800
Message-Id: <1340348122-29021-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset enhance pci_root driver to update MMCFG information when
hot-plugging PCI root bridges. It applies to 
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next

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
-v9: changes from v7 (redo v8)
     Redo v8 to remove MCFG caching logic according to Yinghai's suggestion.
     1) remove patch "add MMCFG information on demand" and MCFG caching logic
     2) Add new patch "refine __pci_mmcfg_init() for better code readability"
      and "mark acpi_sfi_table_parse() as __init", there should no
      functionality changes.
-v10: changes from v9
     1) merge pci_mmcfg_arch_map/unmap with pci_mmcfg_arch_init/free
     2) add better error handling in patch "update MMCFG information when
     hot-plugging PCI host bridges"
     3) split patch "add pci_mmconfig_insert()/delete() for PCI root bridge
     hotplug" into two patches for easy review
     4) add patch "x86/PCI: use pr_level() to replace printk(KERN_LEVEL)"

Jiang Liu (13):
  x86/PCI: split out pci_mmcfg_check_reserved() for code reuse
  x86/PCI: split out pci_mmconfig_alloc() for code reuse
  x86/PCI: use RCU list to protect mmconfig list
  x86/PCI: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
  x86/PCI: prepare pci_mmcfg_check_reserved() to be called at runtime
  x86/PCI: add pci_mmconfig_insert()/delete() for PCI root bridge
    hotplug
  PCI/ACPI: provide MCFG address for PCI host bridges
  x86/PCI: update MMCFG information when hot-plugging PCI host bridges
  x86/PCI: simplify pci_mmcfg_late_insert_resources()
  x86/PCI: get rid of redundant log messages
  x86/PCI: refine __pci_mmcfg_init() for better code readability
  ACPI: mark acpi_sfi_table_parse() as __init
  x86/PCI: use pr_level() to replace printk(KERN_LEVEL)

 arch/x86/include/asm/pci_x86.h |    7 +
 arch/x86/pci/acpi.c            |  100 +++++++++--
 arch/x86/pci/mmconfig-shared.c |  361 +++++++++++++++++++++++++++-------------
 arch/x86/pci/mmconfig_32.c     |   30 +++-
 arch/x86/pci/mmconfig_64.c     |   53 ++++--
 drivers/acpi/pci_root.c        |    2 +
 drivers/pci/pci-acpi.c         |   14 ++
 include/acpi/acnames.h         |    1 +
 include/acpi/acpi_bus.h        |    1 +
 include/linux/pci-acpi.h       |    1 +
 include/linux/sfi_acpi.h       |    4 +-
 11 files changed, 427 insertions(+), 147 deletions(-)

-- 
1.7.9.5

