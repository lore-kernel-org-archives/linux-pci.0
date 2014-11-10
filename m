Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cmexedge2.emulex.com ([138.239.224.100]:51069 "EHLO
	CMEXEDGE2.ext.emulex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbaKJLwu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 06:52:50 -0500
From: Sathya Perla <sathya.perla@emulex.com>
To: <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <ariel.elior@qlogic.com>, <linux.nics@intel.com>,
	<shahed.shaikh@qlogic.com>, <ddutile@redhat.com>
Subject: [PATCH 3/4] i40e: remove pci_assigned_vfs() check while disabling VFs
Date: Mon, 10 Nov 2014 17:23:29 +0530
Message-ID: <1415620410-4937-4-git-send-email-sathya.perla@emulex.com>
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
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index fff3c27..0028a9a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -951,12 +951,7 @@ int i40e_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	if (num_vfs)
 		return i40e_pci_sriov_enable(pdev, num_vfs);
 
-	if (!pci_vfs_assigned(pf->pdev)) {
-		i40e_free_vfs(pf);
-	} else {
-		dev_warn(&pdev->dev, "Unable to free VFs because some are assigned to VMs.\n");
-		return -EINVAL;
-	}
+	i40e_free_vfs(pf);
 	return 0;
 }
 
-- 
1.7.1

