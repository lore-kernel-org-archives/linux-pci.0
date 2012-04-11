Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45686 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759550Ab2DKAOL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 20:14:11 -0400
Received: by pbcun15 with SMTP id un15so552527pbc.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 17:14:11 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH V4 0/6] PCI, x86: update MMCFG information when hot-plugging PCI host bridges
Date: Wed, 11 Apr 2012 08:10:57 +0800
Message-Id: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset enhance pci_root driver to update MMCFG information when
hot-plugging PCI root bridges. It applies to Yinghai's tree at
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug

The second patch is based on Taku Izumi work with some enhancements to
correctly handle PCI host bridges without _CBA method.

-v2: split into smaller patches and skip updating MMCFG information when
     MMCFG is disabled
-v3: add mmconf_added to simply free path, also make pci_mmconfig_insert()
     to process extra exist case --- By Yinghai
-v4: tune arch_acpi_pci_root_add() to handle a corner case raised by Kenji

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
 arch/x86/pci/acpi.c            |   58 +++++++++++++
 arch/x86/pci/mmconfig-shared.c |  185 +++++++++++++++++++++++++++++++---------
 arch/x86/pci/mmconfig_32.c     |   30 ++++++-
 arch/x86/pci/mmconfig_64.c     |   37 +++++++-
 drivers/acpi/pci_root.c        |   16 ++++
 include/acpi/acnames.h         |    1 +
 include/acpi/acpi_bus.h        |    1 +
 include/linux/pci-acpi.h       |    3 +
 9 files changed, 287 insertions(+), 49 deletions(-)

-- 
1.7.5.4

