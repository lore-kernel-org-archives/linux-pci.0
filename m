Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57976 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbbG1Nyp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 09:54:45 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v4 0/3] dra7xx: Add PM support to PCIe
Date: Tue, 28 Jul 2015 19:24:33 +0530
Message-ID: <1438091676-21243-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds PM support to pci-dra7xx so that PCI clocks can be disabled
during suspend and enabled back during resume without affecting
PCI functionality.

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

 drivers/pci/host/pci-dra7xx.c |   94 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

-- 
1.7.9.5

