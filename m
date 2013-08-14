Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:20578 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759471Ab3HNJCo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 05:02:44 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v4 0/2] update device mps 
Date: Wed, 14 Aug 2013 17:01:50 +0800
Message-ID: <1376470912-40264-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v3->v4: Call pcie_bus_update_set() only when pcie_bus_config == PCIE_BUS_TUNE_OFF
        suggested by Jon Mason, try to change parent mps if parent device is
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
  PCI: fix the only slot identification in pcie_find_smpss()
  PCI: update device mps when doing pci hotplug

 drivers/pci/probe.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 68 insertions(+), 2 deletions(-)


