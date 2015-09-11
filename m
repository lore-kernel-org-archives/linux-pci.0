Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:16921 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbbIKJbb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2015 05:31:31 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v3 0/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
Date: Fri, 11 Sep 2015 17:38:24 +0800
Message-ID: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patchset:
1) fixes a bug in spear13xx when calling dw_pcie_cfg_read and
   dw_pcie_cfg_write usign the patch from Pratyush in
   https://lkml.org/lkml/2015/9/7/5
2) reworks dw_pcie_cfg_read/dw_pcie_cfg_write in pcie-designware.c in
   order to make it easier for callers to pass input parameters;
3) adds sanity checks in dw_pcie_cfg_read/dw_pcie_cfg_write to make
   sure the PCI header offset does not conflict with the size of
   the read/written field.

Change from v2:
   Replaced patch 1/3 with Pratyush one in
   https://lkml.org/lkml/2015/9/7/5

gabriele paoloni (3):
  PCIe: SPEAr13xx: fix dw_pcie_cfg_read/write() usage
  PCI: designware: change dw_pcie_cfg_write() and  dw_pcie_cfg_read()
  PCI: designware: add sanity checks on the header offset in
    dw_pcie_cfg_read and dw_pcie_cfg_write

 drivers/pci/host/pci-exynos.c      |  5 ++--
 drivers/pci/host/pci-keystone-dw.c |  4 ++--
 drivers/pci/host/pcie-designware.c | 47 +++++++++++++++++++++++---------------
 drivers/pci/host/pcie-spear13xx.c  | 18 +++++++--------
 4 files changed, 41 insertions(+), 33 deletions(-)

-- 
1.9.1

