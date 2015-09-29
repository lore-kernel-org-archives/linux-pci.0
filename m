Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:12749 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325AbbI2Nuj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 09:50:39 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<wangzhou1@hisilicon.com>, <yuanzhichang@hisilicon.com>,
	<zhudacai@hisilicon.com>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liguozhu@hisilicon.com>
Subject: [PATCH v5 0/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
Date: Tue, 29 Sep 2015 21:57:19 +0800
Message-ID: <1443535042-242400-1-git-send-email-gabriele.paoloni@huawei.com>
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
3) changes dw_pcie_cfg_read implementation to make it symmetric with
   dw_pcie_cfg_write 
4) adds sanity checks in dw_pcie_cfg_read/dw_pcie_cfg_write to make
   sure the PCI header offset does not conflict with the size of
   the read/written field.

Changes from v4:
   - included https://lkml.org/lkml/2015/9/7/5 back as it was lost in v4

Changes from v3:
   - changed dw_pcie_cfg_read implementation to make it symmetric with
     dw_pcie_cfg_write
   - changed dw_pcie_cfg_read/dw_pcie_cfg_write implementations to take
     as input param directly the address of the field to read/write rather
     than the base address and the offset in the PCI header

Change from v2:
   Replaced patch 1/3 with Pratyush one in
   https://lkml.org/lkml/2015/9/7/5


gabriele paoloni (3):
  PCIe: SPEAr13xx: fix dw_pcie_cfg_read/write() usage
  PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
  PCI: designware: add sanity checks on the header offset in
    dw_pcie_cfg_read and dw_pcie_cfg_write

 drivers/pci/host/pci-exynos.c      |  5 ++--
 drivers/pci/host/pci-keystone-dw.c |  4 +--
 drivers/pci/host/pcie-designware.c | 52 ++++++++++++++++++++------------------
 drivers/pci/host/pcie-designware.h |  4 +--
 drivers/pci/host/pcie-spear13xx.c  | 24 +++++++++---------
 5 files changed, 46 insertions(+), 43 deletions(-)

-- 
1.9.1

