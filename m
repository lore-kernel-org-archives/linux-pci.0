Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59368 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965478AbeAOPgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jan 2018 10:36:10 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V1 7/7] net/mlx5e: Use generic PCI function for BW calculation
Date: Mon, 15 Jan 2018 17:35:41 +0200
Message-Id: <1516030541-6626-8-git-send-email-talgi@mellanox.com>
In-Reply-To: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
References: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Newly introduced pcie_get_link_limits() function calculates
maximum available BW through the PCI chain. We can use this
value for mlx5e_get_pci_bw() instead of calculating ourselves.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d2b057a..d1d7427 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3971,27 +3971,16 @@ static int mlx5e_get_pci_bw(struct mlx5_core_dev *mdev, u32 *pci_bw)
 	enum pcie_link_width width;
 	enum pci_bus_speed speed;
 	int err = 0;
+	int bw;
 
-	err = pcie_get_minimum_link(mdev->pdev, &speed, &width);
+	err = pcie_get_link_limits(mdev->pdev, &speed, &width, &bw);
 	if (err)
 		return err;
 
 	if (speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN)
 		return -EINVAL;
 
-	switch (speed) {
-	case PCIE_SPEED_2_5GT:
-		*pci_bw = 2500 * width;
-		break;
-	case PCIE_SPEED_5_0GT:
-		*pci_bw = 5000 * width;
-		break;
-	case PCIE_SPEED_8_0GT:
-		*pci_bw = 8000 * width;
-		break;
-	default:
-		return -EINVAL;
-	}
+	*pci_bw = bw;
 
 	return 0;
 }
-- 
1.8.3.1
