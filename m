Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel Verkamp <daniel.verkamp@intel.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Daniel Verkamp <daniel.verkamp@intel.com>
Subject: [PATCH] ntb: initialize max_mw for Atom before using it
Date: Wed, 13 May 2015 08:59:54 -0700
Message-Id: <1431532794-144732-1-git-send-email-daniel.verkamp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit ab760a0 (ntb: Adding split BAR support for Haswell platforms)
changed ntb_device's mw from a fixed-size array into a pointer that is
allocated based on limits.max_mw; however, on Atom platforms, max_mw
is not initialized until ntb_device_setup(), which happens after the
allocation.

Fill out max_mw in ntb_atom_detect() to match ntb_xeon_detect(); this
happens before the use of max_mw in the ndev->mw allocation.

Fixes a null pointer dereference on Atom platforms with ntb hardware.

Signed-off-by: Daniel Verkamp <daniel.verkamp@intel.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/ntb_hw.c b/drivers/ntb/ntb_hw.c
index cd29b10..2f065f0 100644
--- a/drivers/ntb/ntb_hw.c
+++ b/drivers/ntb/ntb_hw.c
@@ -1660,6 +1660,7 @@ static int ntb_atom_detect(struct ntb_device *ndev)
 	u32 ppd;
 
 	ndev->hw_type = BWD_HW;
+	ndev->limits.mw_max = BWD_MAX_MW;
 
 	rc = pci_read_config_dword(ndev->pdev, NTB_PPD_OFFSET, &ppd);
 	if (rc)
-- 
2.1.0

