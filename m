Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3D417BD2
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574244; cv=none; b=EYYojrqISMJh10rgfeEIIH10Pj8C2yrcstNvmgPm4TC5Dy+nV2R3bz36cGiMboPggJOCHEYFNVIQ8UQFl9QHv9Uws+ENhkCemG/cBm0VNGlV1VEakBGOTXyndVABVstsLLGMTUgfTuC7UI8KgIU6g0M3wRgH6vQ9C4zxXA/QfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574244; c=relaxed/simple;
	bh=utWFHovcSEde6W/vWMYRzwYuhpxsLViMJhURbUW/E2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oq0oNB30bCWyYg3/yGNEB9iVkwbOcKR4Pij07ZSBiFt5BZpeQl19flV7Xdno7+oj4Lt4mEIBj4imsIK5c1lNZsBzh71R4dEQRvWvwsM1E5oc3lfOq0BloV7tYasNvU7qJhuiFooM+a3fjD8izHLv7ySijfiZW5L8PY7LZLH2kQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMtHGqKX; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMtHGqKX"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848860def2cso3621058b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574240; x=1788179040; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2J3oy2a4JSIFvlr7/nvXqs5ymVUNBWbqafx9KZERE8s=;
        b=LMtHGqKXaoKlVF3/hnplfX0cxONe27jaHja/41jED6iAene8xTCHChOyPkN+mBkXY9
         9lmlhGppSRAAI61ugC8Qea7M2o7uYU4AAqk81FmnBVvlHdIJvQwJ+2oOhqCJpyNyW6SD
         MJb2SCIYBrBnm73a1A+8kFwoKrc0lmZXEgoHQfntHoPlr+GKBSlWUA+ekeJkTplUoKKU
         gMH0sJgel7BRH0vmftQiTQIyKoj80sDiz0VPxnemjJQSMY8dq3hnPMLeH2NTZcfGCFMO
         nudhiN1G/RZnsQLOiRFlo4/2arebxyDdQG5K2sWaDc9p5GwF9I1obEe/caY29KdcAHPm
         8Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574240; x=1788179040;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2J3oy2a4JSIFvlr7/nvXqs5ymVUNBWbqafx9KZERE8s=;
        b=CuOLe8cckgHQpZZy7e9ywCjxFm5eY8kD9MkiMhG5KXLXZ7SalgrNA2KWAc01NCniQH
         /dyvK0umvWJT0BSGtJQbLD9eqE7opTvh/9wnpSL1uTtXtdA+NsShSH7PmVWYPkHaQ+Hw
         2jribUMNHsBkiwEqy878IF6YJhUJyu2slneZkLXe1r0VGwVuoFWWQBxLHvpuK88i8wa4
         VxIvV9//Pf9VN6QoBzdpLqch49VNrIc177TjoEoZij5AmC2z2iY2Ud7JEmDx0/pLoudt
         sRYf6t45+LTtNHYPqwEH9s0mebNzAVfbr6deHkzeqDkmqhbbgfZ9W4e0p7Fjk/I9HFRW
         BNdA==
X-Forwarded-Encrypted: i=1; AHgh+RoUWquHBS3xsYFmJV5kX+ioFlF/m7R0MMryySGeIyReHfvC0SQ+gDeqmS2UJU+PuwfnQjIPSaNKuJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ms350Rpc12r0lOb+IL7lCxJPYcjJZ3zUXinbwPNOo3JOPYnWte
	CGs+dq7Eyi5l7DoEVhj5Gls5LfuwshZkEBSc6qgv/hvPjLGl89EQnDfywrX+91s9AfSQxDyPi/w
	qQQ==
X-Received: from pfbea20.prod.google.com ([2002:a05:6a00:4c14:b0:848:5453:d5d1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2383:b0:835:6388:655d
 with SMTP id d2e1a72fcca58-8520ba30a62mr27879947b3a.14.1787574239879; Mon, 24
 Aug 2026 05:23:59 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:44 +0000
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824122347.1588592-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-3-praan@google.com>
Subject: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The iommu_ignore_device() function currently uses memset() to manually
clear the primary Device Table Entry (DTE), which risks torn writes as
the hardware reads DTEs as atomic 256-bit qwords. Furthermore, clearing
the primary devid in the lookup table before calling setup_aliases()
causes rlookup_amd_iommu() to fail for aliases. This prevents clearing
the DTEs for DMA aliases.

Fix this by replacing the manual memset with a dedicated helper that
invalidates the DTE by clearing the lower 128 bits (having the Valid bit)
first, followed by the upper 128 bits. The cleared state is then
explicitly cloned to all aliases before the lookup tables are nullified.

Rename the function to iommu_disable_device() more accurately
reflects its intent, as we still support IRQ remapping for these devices)

Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 53 ++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e1f9fbb63837..8e382317709d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -728,22 +728,6 @@ static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
 	return dev_data;
 }
 
-static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
-{
-	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	int devid, sbdf;
-
-	sbdf = get_device_sbdf_id(dev);
-	if (sbdf < 0)
-		return;
-
-	devid = PCI_SBDF_TO_DEVID(sbdf);
-	pci_seg->rlookup_table[devid] = NULL;
-	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
-
-	setup_aliases(iommu, dev);
-}
 
 
 /****************************************************************************
@@ -2233,6 +2217,41 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 		clear_dte_entry(iommu, dev_data);
 }
 
+/*
+ * Invalidate a DTE by clearing the Valid bit first.
+ * Note: Lockless; Not to be used on a fully probed
+ * device with live dev_data.
+ */
+static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
+{
+	struct dev_table_entry new = {};
+
+	write_dte_lower128(ptr, &new);
+	write_dte_upper128(ptr, &new);
+}
+
+static void iommu_disable_device(struct amd_iommu *iommu, struct device *dev)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	int devid, sbdf;
+
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
+		return;
+
+	devid = PCI_SBDF_TO_DEVID(sbdf);
+
+	/* Clear the primary DTE */
+	amd_iommu_disable_dte(&dev_table[devid]);
+
+	/* Clone the cleared DTE to all aliases before wiping the rlookup */
+	if (dev_iommu_priv_get(dev))
+		clone_aliases(iommu, dev);
+
+	pci_seg->rlookup_table[devid] = NULL;
+}
+
 /*
  * If domain is SVA capable then initialize GCR3 table. Also if domain is
  * in v2 page table mode then update GCR3[0].
@@ -2521,7 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_ignore_device(iommu, dev);
+		iommu_disable_device(iommu, dev);
 		goto out_err;
 	}
 
-- 
2.55.0.766.g2966f0265a-goog

