Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:58202 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750995AbeCLMG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2018 08:06:27 -0400
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V3 0/5] Report PCI device link status
Date: Mon, 12 Mar 2018 14:06:05 +0200
Message-Id: <1520856370-15404-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches introduce the ability to report PCI link width
and speed for all PCI devices in kernel log.
This would reduce code duplication between drivers and unify
the approach for reporting PCI link status.
Implemented and tested for Mellanox devices.

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

Tal Gilboa (5):
  PCI: Add a query function for PCI device's speed cap
  PCI: Add a query function for PCI device's width cap
  PCI: Print PCI device link status in kernel log
  net/mlx4_core: Report PCI properties using dedicated function
  net/mlx5: Report device PCI link status and issues

 drivers/net/ethernet/mellanox/mlx4/main.c      | 81 +----------------------
 drivers/net/ethernet/mellanox/mlx5/core/main.c |  2 +
 drivers/pci/pci-sysfs.c                        | 28 +++-----
 drivers/pci/pci.c                              | 90 ++++++++++++++++++++++++++
 include/linux/pci.h                            |  9 +++
 5 files changed, 110 insertions(+), 100 deletions(-)

-- 
1.8.3.1
