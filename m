Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:60629 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729Ab2EWDvt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 23:51:49 -0400
Received: from huawei.com (szxga05-in [172.24.2.49])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G00G78IPNBT@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:23 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4G006UIIPNMU@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Wed, 23 May 2012 11:51:23 +0800 (CST)
Date: Wed, 23 May 2012 11:50:17 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH v6 0/9] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
To: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
MIME-version: 1.0
Content-type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jiang Liu <liuj97@gmail.com>

From: Jiang Liu <jiang.liu@huawei.com>

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

The first 4 patches in series is the same with v5.

On a test platform with four SandyBridge processors, MMCFG resources from
/proc/iomem are as below.
With original implementation:
bf000000-cfffffff : reserved
  c0000000-cfffffff : PCI MMCONFIG 0000 [bus 00-ff]

With patch set applied:
bf000000-cfffffff : reserved
  c0000000-c3efffff : PCI MMCONFIG 0000 [bus 00-3e]
  c3f00000-c3ffffff : PCI MMCONFIG 0000 [bus 3f-3f]
  c4000000-c7efffff : PCI MMCONFIG 0000 [bus 40-7e]
  c7f00000-c7ffffff : PCI MMCONFIG 0000 [bus 7f-7f]
  c8000000-cbefffff : PCI MMCONFIG 0000 [bus 80-be]
  cbf00000-cbffffff : PCI MMCONFIG 0000 [bus bf-bf]
  cc000000-cfefffff : PCI MMCONFIG 0000 [bus c0-fe]
  cff00000-cfffffff : PCI MMCONFIG 0000 [bus ff-ff]

After removing a host bridge:
bf000000-cfffffff : reserved
  c0000000-c3efffff : PCI MMCONFIG 0000 [bus 00-3e]
  c3f00000-c3ffffff : PCI MMCONFIG 0000 [bus 3f-3f]
  c4000000-c7efffff : PCI MMCONFIG 0000 [bus 40-7e]
  c7f00000-c7ffffff : PCI MMCONFIG 0000 [bus 7f-7f]
  c8000000-cbefffff : PCI MMCONFIG 0000 [bus 80-be]
  cbf00000-cbffffff : PCI MMCONFIG 0000 [bus bf-bf]
  cc000000-cfefffff : PCI MMCONFIG 0000 [bus c0-fe]
  cff00000-cfffffff : PCI MMCONFIG 0000 [bus ff-ff]

After adding the host bridge back
bf000000-cfffffff : reserved
  c0000000-c3efffff : PCI MMCONFIG 0000 [bus 00-3e]
  c3f00000-c3ffffff : PCI MMCONFIG 0000 [bus 3f-3f]
  c4000000-c7efffff : PCI MMCONFIG 0000 [bus 40-7e]
  c7f00000-c7ffffff : PCI MMCONFIG 0000 [bus 7f-7f]
  c8000000-cbefffff : PCI MMCONFIG 0000 [bus 80-be]
  cbf00000-cbffffff : PCI MMCONFIG 0000 [bus bf-bf]
  cc000000-cfefffff : PCI MMCONFIG 0000 [bus c0-fe]
  cff00000-cfffffff : PCI MMCONFIG 0000 [bus ff-ff]

Jiang Liu (9):
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

 arch/x86/include/asm/pci_x86.h |   11 ++
 arch/x86/pci/acpi.c            |   71 ++++++++++
 arch/x86/pci/legacy.c          |    1 +
 arch/x86/pci/mmconfig-shared.c |  280 ++++++++++++++++++++++++++++++----------
 arch/x86/pci/mmconfig_32.c     |   30 ++++-
 arch/x86/pci/mmconfig_64.c     |   37 +++++-
 drivers/acpi/pci_root.c        |   12 ++
 drivers/pci/pci-acpi.c         |   34 +++++
 include/acpi/acnames.h         |    1 +
 include/acpi/acpi_bus.h        |    3 +
 include/linux/pci-acpi.h       |    5 +
 11 files changed, 412 insertions(+), 73 deletions(-)


