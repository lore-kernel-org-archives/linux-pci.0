Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42276 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753462AbeACPY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jan 2018 10:24:56 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: [PATCH next 3/3] net/mlx5: Report device PCI link status and issues
Date: Wed,  3 Jan 2018 17:24:22 +0200
Message-Id: <1514993062-7328-4-git-send-email-talgi@mellanox.com>
In-Reply-To: <1514993062-7328-1-git-send-email-talgi@mellanox.com>
References: <1514993062-7328-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a check for mlx5 PCI device's link status.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5f32344..7a43735 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -977,6 +977,8 @@ static int mlx5_load_one(struct mlx5_core_dev *dev, struct mlx5_priv *priv,
 	dev_info(&pdev->dev, "firmware version: %d.%d.%d\n", fw_rev_maj(dev),
 		 fw_rev_min(dev), fw_rev_sub(dev));
 
+	pcie_print_link_status(dev->pdev);
+
 	/* on load removing any previous indication of internal error, device is
 	 * up
 	 */
-- 
1.8.3.1
