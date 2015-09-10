Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:33964 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbIJOwG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 10:52:06 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v2 0/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
Date: Thu, 10 Sep 2015 22:58:55 +0800
Message-ID: <1441897138-23251-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset:
1) fixes a bug in spear13xx when calling dw_pcie_cfg_read and
   dw_pcie_cfg_write;
2) reworks dw_pcie_cfg_read/dw_pcie_cfg_write in pcie-designware.c in
   order to make it easier for callers to pass input parameters;
3) adds sanity checks in dw_pcie_cfg_read/dw_pcie_cfg_write to make
   sure the PCI header offset does not conflict with the size of
   the read/written field.

gabriele paoloni (3):
  PCIE: spear13xx: fix addresses in dw_pcie_cfg_read and
    dw_pcie_cfg_write
  PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
  PCIE: designware: add sanity checks on the header offset in
    dw_pcie_cfg_read and dw_pcie_cfg_write

 drivers/pci/host/pci-exynos.c      |  5 ++--
 drivers/pci/host/pci-keystone-dw.c |  4 ++--
 drivers/pci/host/pcie-designware.c | 47 +++++++++++++++++++++++---------------
 3 files changed, 32 insertions(+), 24 deletions(-)

-- 
1.9.1

