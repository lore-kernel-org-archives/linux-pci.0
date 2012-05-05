Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f45.google.com ([209.85.210.45]:34775 "EHLO
	mail-pz0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2EEDAw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 May 2012 23:00:52 -0400
Received: by dadv2 with SMTP id v2so4922736dad.4
        for <linux-pci@vger.kernel.org>; Fri, 04 May 2012 20:00:52 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH v5 0/6] PCI, x86: update MMCFG information when hot-plugging PCI host bridges
Date: Sat,  5 May 2012 11:00:24 +0800
Message-Id: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

This patchset enhance pci_root driver to update MMCFG information when
hot-plugging PCI root bridges. It applies to Yinghai's tree at
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug

-v2: split into smaller patches and skip updating MMCFG information when
     MMCFG is disabled
-v3: add mmconf_added to simply free path, also make pci_mmconfig_insert()
     to process extra exist case --- By Yinghai
-v4: tune arch_acpi_pci_root_add() to handle a corner case raised by Kenji
-v5: address review comments from Bjorn and Taku, also better handle corner
     cases in arch_acpi_pci_root_add()

Jiang Liu (6):
  PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
  PCI, x86: split out pci_mmconfig_alloc() for code reuse
  PCI, x86: use RCU list to protect mmconfig list
  PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
  PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root
    bridge hotplug
  PCI, ACPI, x86: update MMCFG information when hot-plugging PCI host
    bridges

 arch/x86/include/asm/pci_x86.h |    5 +
 arch/x86/pci/acpi.c            |   57 +++++++++++
 arch/x86/pci/mmconfig-shared.c |  203 +++++++++++++++++++++++++++++++---------
 arch/x86/pci/mmconfig_32.c     |   30 +++++-
 arch/x86/pci/mmconfig_64.c     |   37 +++++++-
 drivers/acpi/pci_root.c        |   22 +++++
 include/acpi/acnames.h         |    1 +
 include/acpi/acpi_bus.h        |    1 +
 include/linux/pci-acpi.h       |    4 +
 9 files changed, 308 insertions(+), 52 deletions(-)

-- 
1.7.9.5

