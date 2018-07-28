Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbeG2Bce (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jul 2018 21:32:34 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v6 0/1] PCI: Mask and unmask hotplug interrupts during reset
Date: Sat, 28 Jul 2018 02:13:23 -0700
Message-Id: <20180728091324.154795-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a bridge supports hotplug and observes a PCIe fatal error, the following
events happen:

1. AER driver removes the devices from PCI tree on fatal error
2. AER driver brings down the link by issuing a secondary bus reset waits
for the link to come up.
3. Hotplug driver observes a link down interrupt
4. Hotplug driver tries to remove the devices waiting for the rescan lock
but devices are already removed by the AER driver and AER driver is waiting
for the link to come back up.
5. AER driver tries to re-enumerate devices after polling for the link
state to go up.
6. Hotplug driver obtains the lock and tries to remove the devices again.

Ignore link events caused by fatal error in hotplug driver. Note that
surprise link down fatal error is a hotplug event.

Sinan Kaya (1):
  PCI: pciehp: Ignore link events when there is a fatal error pending

 drivers/pci/hotplug/pciehp_hpc.c | 13 ++++++++----
 drivers/pci/pci.h                |  1 +
 drivers/pci/pcie/err.c           | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.17.1
