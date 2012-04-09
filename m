Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40501 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437Ab2DIQZZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 12:25:25 -0400
From: Jiang Liu <liuj97@gmail.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V2 0/6] PCI, x86: update MMCFG information when hot-plugging PCI host bridges
Date: Tue, 10 Apr 2012 00:22:42 +0800
Message-Id: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset enhance pci_root driver to update MMCFG information when
hot-plugging PCI root bridges. It applies to Yinghai's tree at
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug

The second patch is based on Taku Izumi work with some enhancements to
correctly handle PCI host bridges without _CBA method.

v2: split into smaller patches and skip updating MMCFG information when
    MMCFG is disabled

Jiang Liu (6):
  PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
  PCI, x86: split out pci_mmconfig_alloc() for code reuse
  PCI, x86: use RCU list to protect mmconfig list
  PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
  PCI, x86: introduce pci_mmconfig_insert()/delete() for PCI root
    bridge hotplug
  PCI, ACPI, x86: update MMCFG information when hot-plugging PCI host
    bridges

 arch/x86/include/asm/pci_x86.h |    4 +
 arch/x86/pci/acpi.c            |   66 ++++++++++++++
 arch/x86/pci/mmconfig-shared.c |  186 +++++++++++++++++++++++++++++++---------
 arch/x86/pci/mmconfig_32.c     |   28 ++++++-
 arch/x86/pci/mmconfig_64.c     |   35 +++++++-
 drivers/acpi/pci_root.c        |   20 +++++
 include/acpi/acnames.h         |    1 +
 include/linux/pci-acpi.h       |    2 +
 8 files changed, 295 insertions(+), 47 deletions(-)

-- 
1.7.5.4

