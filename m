Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59298 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965478AbeAOPgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jan 2018 10:36:08 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V1 0/7] Report PCI device link status
Date: Mon, 15 Jan 2018 17:35:34 +0200
Message-Id: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches introduce the ability to report PCI link width
and speed for all PCI devices in kernel log. It also warns if
the BW capability is bellow maximum. This would reduce code
duplication between drivers and unify the approach for reporting
PCI link status.
Implemented and tested for Mellanox devices.

v1: Split to multiple patches, calculate BW limitation and remove
MACRO definition for LNKCAP shift (suggested by Bjorn Helgaas).
Multiple fixes - conventions, typos, function naming and functional
(suggested by Tariq Toukan).

Tal Gilboa (7):
  PCI: Add a query function for PCI device's speed cap
  PCI: Add a query function for PCI device's width cap
  PCI: Calculate BW limitation for PCI devices
  PCI: Print PCI device link status in kernel log
  net/mlx4_core: Report PCI properties using dedicated function
  net/mlx5: Report device PCI link status and issues
  net/mlx5e: Use generic PCI function for BW calculation

 drivers/net/ethernet/mellanox/mlx4/main.c         |  81 +----------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  17 +--
 drivers/net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 drivers/pci/pci-sysfs.c                           |  28 ++--
 drivers/pci/pci.c                                 | 163 +++++++++++++++++++++-
 include/linux/pci.h                               |  17 +++
 6 files changed, 191 insertions(+), 117 deletions(-)

-- 
1.8.3.1
