Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42106 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753456AbeACPYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jan 2018 10:24:41 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH next 0/3] Report PCI device link status
Date: Wed,  3 Jan 2018 17:24:19 +0200
Message-Id: <1514993062-7328-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These patches introduce the ability to report PCI link width
and speed for all PCI devices in kernel log. It also warns if
the capabilities are bellow maximum. This would reduce code
duplication between drivers and unify the approach for reporting
PCI link status.
Implemented and tested for Mellanox devices.

Tal Gilboa (3):
  pci: Report PCI device link status
  net/mlx4_core: Report PCI properties using dedicated function
  net/mlx5: Report device PCI link status and issues

 drivers/net/ethernet/mellanox/mlx4/main.c      |  81 +------------------
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   2 +
 drivers/pci/pci.c                              | 107 +++++++++++++++++++++++++
 include/linux/pci.h                            |   3 +
 include/uapi/linux/pci_regs.h                  |   1 +
 5 files changed, 114 insertions(+), 80 deletions(-)

-- 
1.8.3.1
