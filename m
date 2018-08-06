Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38022 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbeHGBhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 21:37:55 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com
Cc: keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH v6 2/9] bnx2x: Do not call pcie_print_link_status()
Date: Mon,  6 Aug 2018 18:25:36 -0500
Message-Id: <20180806232600.25694-2-mr.nuke.me@gmail.com>
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is now done by the PCI core to warn of sub-optimal bandwidth.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 57348f2b49a3..3eadd6201dff 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14100,7 +14100,6 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 	       board_info[ent->driver_data].name,
 	       (CHIP_REV(bp) >> 12) + 'A', (CHIP_METAL(bp) >> 4),
 	       dev->base_addr, bp->pdev->irq, dev->dev_addr);
-	pcie_print_link_status(bp->pdev);
 
 	bnx2x_register_phc(bp);
 
-- 
2.17.1
