Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33131 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752672AbeC3HO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 03:14:56 -0400
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Keller Jacob E <jacob.e.keller@intel.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V4 0/8] Report PCI device link status
Date: Fri, 30 Mar 2018 10:14:38 +0300
Message-Id: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches introduce the ability to report PCI link width
and speed for all PCI devices in kernel log.
This would reduce code duplication between drivers and unify
the approach for reporting PCI link status.
Implemented and tested for Mellanox devices.

v4: Reverted most of v2, meaning re-introduced bandwidth limitation calculation.
Limiting device is now returned from the available PCIe bandwidth calculation
function and is logged in kernel log (suggested by Bjorn Helgaas and Jacob E.
Keller).

Applied PCIe encoding overhead to PCIe bandwidth calculation (available/capable).
this way upper bandwidth limit of the device is more accurate.

v3: Add Reviewed-by: Tariq Toukan to all commits.

v2: Remove chain BW calculation. This might be a nice feature, but
without the ability to know the exact limiting part, it is more
confusing than useful.
Remove warnings for failed PCI query actions, leaving only the status
and gaps from max capabilities report.
Use pci_warn()/pci_info() instead of dev_warn()/dev_info().
(suggested by Bjorn Helgaas).

v1: Split to multiple patches, calculate BW limitation and remove
MACRO definition for LNKCAP shift (suggested by Bjorn Helgaas).
Multiple fixes - conventions, typos, function naming and functional
(suggested by Tariq Toukan).

Tal Gilboa (8):
  PCI: Add a query function for PCI device's speed cap
  PCI: Add a query function for PCI device's width cap
  PCI: Add device link bandwidth capabilities calculation
  PCI: Calculate available bandwidth for PCI devices
  PCI: Print PCI device link status in kernel log
  net/mlx4_core: Report PCI properties using dedicated function
  net/mlx5: Report device PCI link status and issues
  net/mlx5e: Use generic PCI function for bandwidth calculation

 drivers/net/ethernet/mellanox/mlx4/main.c         |  81 +----------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  17 +--
 drivers/net/ethernet/mellanox/mlx5/core/main.c    |   4 +
 drivers/pci/pci-sysfs.c                           |  28 ++--
 drivers/pci/pci.c                                 | 161 +++++++++++++++++++++-
 include/linux/pci.h                               |  24 ++++
 6 files changed, 194 insertions(+), 121 deletions(-)

-- 
1.8.3.1
