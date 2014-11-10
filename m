Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge1.emulex.com ([138.239.224.99]:50288 "EHLO
	CMEXEDGE1.ext.emulex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaKJLv6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 06:51:58 -0500
From: Sathya Perla <sathya.perla@emulex.com>
To: <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <ariel.elior@qlogic.com>, <linux.nics@intel.com>,
	<shahed.shaikh@qlogic.com>, <ddutile@redhat.com>
Subject: [PATCH 2/4] bnx2x: remove pci_assigned_vfs() check while disabling VFs
Date: Mon, 10 Nov 2014 17:23:28 +0530
Message-ID: <1415620410-4937-3-git-send-email-sathya.perla@emulex.com>
In-Reply-To: <1415620410-4937-1-git-send-email-sathya.perla@emulex.com>
References: <1415620410-4937-1-git-send-email-sathya.perla@emulex.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vasundhara Volam <vasundhara.volam@emulex.com>

The pci_assigned_vfs() check (while disabling VFs) is being moved to the
pci-sysfs.c file and will be done before invoking sriov_configure().

Signed-off-by: Vasundhara Volam <vasundhara.volam@emulex.com>
Signed-off-by: Sathya Perla <sathya.perla@emulex.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index c88b20a..e90a10b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2481,7 +2481,7 @@ int bnx2x_sriov_configure(struct pci_dev *dev, int num_vfs_param)
 	bp->requested_nr_virtfn = num_vfs_param;
 	if (num_vfs_param == 0) {
 		bnx2x_set_pf_tx_switching(bp, false);
-		bnx2x_disable_sriov(bp);
+		pci_disable_sriov(bp->pdev);
 		return 0;
 	} else {
 		return bnx2x_enable_sriov(bp);
-- 
1.7.1

