Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:50607 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbbD1HGO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 03:06:14 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <dja@axtens.net>,
	Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH Part1 v11 0/5] Some cleanup for pcie host drivers
Date: Tue, 28 Apr 2015 15:01:34 +0800
Message-ID: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches are split out from patchset(patch 5 is new)
"Refine PCI scan interfaces and make generic pci host bridge".
They are independent of the series, pci_bus_add_devices()
has been ripped out from pci_scan_root_bus(), so we could
use pci_scan_root_bus() instead of pci_create_root_bus() + 
pci_scan_child_bus() for simplicity. Also this is the preparation
for the series.

Yijing Wang (5):
  PCI: mvebu: Use pci_common_init_dev() to simplify code
  PCI: tegra: Remove redundant tegra_pcie_scan_bus()
  PCI: designware: Use pci_scan_root_bus() for simplicity
  PCI: xgene: Use pci_scan_root_bus() instead of pci_create_root_bus()
  PCI: iproc: Use pci_scan_root_bus() instead of pci_create_root_bus()

 drivers/pci/host/pci-mvebu.c       |   18 +-----------------
 drivers/pci/host/pci-tegra.c       |   16 ----------------
 drivers/pci/host/pci-xgene.c       |    3 +--
 drivers/pci/host/pcie-designware.c |    4 +---
 drivers/pci/host/pcie-iproc.c      |    5 ++---
 5 files changed, 5 insertions(+), 41 deletions(-)

