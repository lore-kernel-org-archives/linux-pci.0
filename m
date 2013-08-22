Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:64957 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3HVDZS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 23:25:18 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v8 0/6] Update device MPS
Date: Thu, 22 Aug 2013 11:24:42 +0800
Message-ID: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v7->v8: Yijing update the patch 6/6, and tested this series in hotplug machine.
v6->v7: Bjorn's rework and additions of other minor cleanups
v5->v6: rework the patch 1/2, remove the unnecessary check, pointed out by Bjorn.
        remove the patch 1/2 cc stable tag, because it's not a serious bug.
v4->v5: Fix some spelling problems and move mpss = 128 << dev->pcie_mpss above to reuse
        it, also remove the else braces for code style. thanks for Jon's review and comments.
v3->v4: Call pcie_bus_update_set() only when pcie_bus_config == PCIE_BUS_TUNE_OFF
        suggested by Jon Mason, try to change parent mps when parent device is
        root port and only one slot connected to it when parent mps > child device
        mpss. Other add a patch to fix a issue in pcie_find_smpss() during use
        "pci=pcie_bus_safe".
v2->v3: Update CC stable tag suggested by Li Zefan.
v1->v2: Update patch log, remove Joe's reported-by, because his problem
        was mainly caused by BIOS incorrect setting. But this patch mainly
        to fix the bug caused by device hot add. Conservatively, this
        version only update the mps problem when hot add. When the device
        mps < parent mps found, this patch try to update device mps.
        It seems unlikely device mps > parent mps after hot add device.
        So we don't care that situation.

1. test with append "pci=pcie_bus_safe" during system bootup
-+-[0000:40]-+-00.0-[0000:41]--
 |           +-05.0-[0000:45]--
 |           +-07.0-[0000:46]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection

root port(40:07.0 mps=256, mpss=256), NIC devices(46:00.0/1, mps=256, mpss=512)

linux-ha2:/sys/bus/pci/slots/7 # echo 0 > power 
linux-ha2:/sys/bus/pci/slots/7 # echo 1 > power 
linux-ha2:/sys/bus/pci/slots/7 # dmesg
....................................
pcieport 0000:40:07.0: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128 
pci 0000:46:00.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512 
pci 0000:46:00.1: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512 
pcieport 0000:40:07.0: Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128 
pci 0000:46:00.0: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512 
pci 0000:46:00.1: Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512 
...................................


2. test without append "pci=pcie_bus_xxx", default PCIE_BUS_TUNE_OFF
root port(40:07.0 mps=256, mpss=256), NIC devices(46:00.0/1, mps=256, mpss=512)
linux-ha2:/sys/bus/pci/slots/7 # echo 0 > power
root port, mps =256, NIC devices, mps = 128
linux-ha2:/sys/bus/pci/slots/7 # echo 1 > power 
root port, mps =256, NIC devices, mps = 256

all test results ok.

Bjorn Helgaas (3):
  PCI: Drop "PCI-E" prefix from Max Payload Size message
  PCI: Simplify pcie_bus_configure_settings() interface
  PCI: Simplify MPS test for Downstream Port

Yijing Wang (3):
  PCI: Remove unnecessary check for pcie_get_mps() failure
  PCI: Don't restrict MPS for slots below Root Ports
  PCI: update device mps when doing pci hotplug

 arch/powerpc/kernel/pci-common.c |    8 +---
 arch/tile/kernel/pci_gx.c        |    9 +---
 arch/x86/pci/acpi.c              |    9 +---
 drivers/pci/hotplug/pcihp_slot.c |    5 +-
 drivers/pci/pci.c                |    3 -
 drivers/pci/probe.c              |   90 +++++++++++++++++++++++++++++---------
 include/linux/pci.h              |    2 +-
 7 files changed, 78 insertions(+), 48 deletions(-)


