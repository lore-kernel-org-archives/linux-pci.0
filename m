Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:43546 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab3HUXjK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 19:39:10 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so2241498oag.12
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 16:39:09 -0700 (PDT)
Subject: [PATCH v7 0/5] Update device MPS
To: Yijing Wang <wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>
Date: Wed, 21 Aug 2013 17:39:07 -0600
Message-ID: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

---

Bjorn Helgaas (3):
      PCI: Drop "PCI-E" prefix from Max Payload Size message
      PCI: Simplify pcie_bus_configure_settings() interface
      PCI: Simplify MPS test for Downstream Port

Yijing Wang (2):
      PCI: Remove unnecessary check for pcie_get_mps() failure
      PCI: Don't restrict MPS for slots below Root Ports


 arch/powerpc/kernel/pci-common.c |    8 ++-----
 arch/tile/kernel/pci_gx.c        |    9 ++------
 arch/x86/pci/acpi.c              |    9 ++------
 drivers/pci/hotplug/pcihp_slot.c |    5 ++---
 drivers/pci/pci.c                |    3 ---
 drivers/pci/probe.c              |   42 ++++++++++++++++++++------------------
 include/linux/pci.h              |    2 +-
 7 files changed, 31 insertions(+), 47 deletions(-)
