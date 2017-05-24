Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161115AbdEXWv6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 18:51:58 -0400
Subject: [PATCH 0/2] Replace driver's usage of hard-coded device IDs to
 #defines
From: Myron Stowe <myron.stowe@redhat.com>
To: linux-pci@vger.kernel.org, netdev@vger.kernel.org
Cc: bhelgaas@google.com, saeedm@mellanox.com, noaos@mellanox.com,
        tariqt@mellanox.com
Date: Wed, 24 May 2017 16:47:34 -0600
Message-ID: <20170524224734.24221.33787.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Noa Osherovich introduced a series of new Mellanox device ID definitions to
help differentiate specific controllers that needed INTx masking quirks [1].

Bjorn Helgaas followed on, using the device ID definitions Noa provided to
replace hard-coded values within the mxl4 ID table [2].
    
This patch continues along similar lines, adding a few additional Mellanox
device ID definitions and converting the net/mlx5e driver's mlx5 ID table to
use the defines so tools like 'grep' and 'cscope' can be used to help
identify relationships with other aspects (such as INTx masking).


[1]  7254383341b PCI: Add Mellanox device IDs
     d76d2fe05fd PCI: Convert Mellanox broken INTx quirks to be for listed
                 devices only

[2]  c19e4b9037f net/mlx4_core: Use device ID defines


Myron Stowe (2):
      PCI: Add Mellanox device IDs
      net/mlx5e: Use device ID defines


 drivers/net/ethernet/mellanox/mlx5/core/main.c |   12 ++++++------
 include/linux/pci_ids.h                        |    3 +++
 2 files changed, 9 insertions(+), 6 deletions(-)

--
