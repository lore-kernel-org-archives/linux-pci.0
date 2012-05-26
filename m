Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:39878 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab2EZJ5f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 May 2012 05:57:35 -0400
Received: from huawei.com (szxga05-in [172.24.2.49])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M00LDDJNNJS@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:57:23 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4M000WWJNG8J@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Sat, 26 May 2012 17:57:23 +0800 (CST)
Date: Sat, 26 May 2012 17:53:53 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v7 00/10] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
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

Jiang Liu (10):
  PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
  PCI, x86: split out pci_mmconfig_alloc() for code reuse
  PCI, x86: use RCU list to protect mmconfig list
  PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
  PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root
    bridge hotplug
  PCI, ACPI: provide MCFG address for PCI host bridges
  PCI, x86: update MMCFG information when hot-plugging PCI host bridges
  PCI, x86: add MMCFG information on demand
  PCI, x86: simplify pci_mmcfg_late_insert_resources()
  PCI, x86: get rid of redundant log messages

 arch/x86/include/asm/pci_x86.h |   12 ++
 arch/x86/pci/acpi.c            |   76 ++++++++-
 arch/x86/pci/legacy.c          |    1 +
 arch/x86/pci/mmconfig-shared.c |  364 +++++++++++++++++++++++++++++-----------
 arch/x86/pci/mmconfig_32.c     |   30 +++-
 arch/x86/pci/mmconfig_64.c     |   37 ++++-
 drivers/acpi/pci_root.c        |   12 ++
 drivers/pci/pci-acpi.c         |   34 ++++
 include/acpi/acnames.h         |    1 +
 include/acpi/acpi_bus.h        |    3 +
 include/linux/pci-acpi.h       |    5 +
 11 files changed, 465 insertions(+), 110 deletions(-)


