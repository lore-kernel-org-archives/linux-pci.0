Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47304 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbbGaMZV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2015 08:25:21 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jingoohan1@gmail.com>, <nsekhar@ti.com>
CC: <kishon@ti.com>
Subject: [PATCH v5 0/3] dra7xx: Add PM support to PCIe
Date: Fri, 31 Jul 2015 17:55:09 +0530
Message-ID: <1438345512-28973-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds PM support to pci-dra7xx so that PCI clocks can be disabled
during suspend and enabled back during resume without affecting
PCI functionality.

Changes from v4:
*) Fixed a bug caused by sending incomplete patch.

Changes from v3:
*) Fix compilation errors when individual patches are applied

Changes from v2:
*) Used SET_SYSTEM_SLEEP_PM_OPS and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for
   populating PM ops.

Changes from v1:
*) Moved resetting and setting of MSE bit to pci-dra7xx.

The comment to reset and set ISE is not done now since I don't have a card
with IO space. Once I get to test that, I'll post a separate patch for
handling that.

Kishon Vijay Abraham I (3):
  PCI: host: pci-dra7xx: Disable pm_runtime on get_sync failure
  PCI: host: pci-dra7xx: add pm support to pci dra7xx
  PCI: host: pci-dra7xx: Idle the module by disabling MSE bit

 drivers/pci/host/pci-dra7xx.c |   95 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

-- 
1.7.9.5

