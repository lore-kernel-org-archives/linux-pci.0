Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:33498 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab3HUC0I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2013 22:26:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v6 0/2] update device mps
Date: Wed, 21 Aug 2013 10:25:35 +0800
Message-ID: <1377051937-5712-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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



Yijing Wang (2):
  PCI: remove the unnecessary check in pcie_find_smpss()
  PCI: update device mps when doing pci hotplug

 drivers/pci/probe.c |   60 ++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 52 insertions(+), 8 deletions(-)


