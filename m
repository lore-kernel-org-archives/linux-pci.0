Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C53D45EF
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672617; cv=none; b=C6Fktgh94S6SyXEpfzx9i6oVWoXu74ppzX8tP2S1PBDER2DUCkELS35f08hIpCrhrQtJYH0zRIabFhWurfd/1KUZvKo81/TbHc2b652ioBagF0r5WqESpvUztnUtV/g32cXf8TxgPwlZE+HXDIFcB4bngWS6gAempN2KiBjpvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672617; c=relaxed/simple;
	bh=qmV1Q/0KI4p+2B8V3vN0lUGtxGexx4uGynYE7GUfOq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uwln/VbP3QRF/tFcOUolWHKruOgXLGnSYVOglGaCM1sCtLoPM1yKF+rBAgUiVdvX2JKHuYNJOCosXDvPFr94aUpKJuBziShZAX7gC6kWkEh2wcZaXIq2oiAcaNFegfykJMzoMmcdMjqf+i0aQodSoqOY8jgSWXtU5L2AIwqR/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQJ0+I3+; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQJ0+I3+"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso678233a12.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672615; x=1787277415; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wsMfzFkg0enOrt2eV/SCy7RWuY9LmtCK54cwxYbF5/g=;
        b=pQJ0+I3+oU4YSlfaorwchoyUs5ZkOnzp5p6OmGi0MlEn4rY4ZNcjHrJMaQHHtU/xMp
         Yzc6ApqvoblCF7qDqXBUdnqNviPUZ+mOsHkbagYjV6yiJZjddBtr0sX4a5w+P+aOcS5q
         cBX5FG3sPkFFKcp40aBYuPzdkjsMWMV9/ix6VX6MdWB1l/wPVf3POVee+kUgzLoQetsv
         8kWT5H/cAGZDUx3/bx8p1abCkd/+Cs1XWotN5gn0sC0zCWPVkEtOaYip8zYJtSFmedCY
         TsgG2rZFDz6QohRISRWfGFo1JuwYHU4Dlw6znG2IZ9IM83OUGC+EQILFjSVviyeOm+Hi
         Hs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672615; x=1787277415;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wsMfzFkg0enOrt2eV/SCy7RWuY9LmtCK54cwxYbF5/g=;
        b=hhPDk2rCqF+U3iqGaEUVq873lmWkUQoo6n9IHO5f1lCgIy2vuatN7N5ExApgB+7ftE
         LNI1atbuMMV0msHlE36sSbaHl8bunH9NyC4fvYcGMluFguSGT0Oz3SU6ISK2MGe3yDoB
         SQAijFeqYRf3ac29flbiC30ohJNO2dWCupPJaYrgKvQBsTSVD0OaIHS9R///lnbIJ+LH
         cN61jVbzYQlFExMozW6euOD0nk11764CfHIoivEVzcOevQxHXvT4LZ+xgiEuSYJbSIWF
         dNV8G+vEkk2Rht3523gF0gifpHxNAzMgcRFlqCAsagZ06Xd78rJ8MDrFh1PcLAWy68gX
         N8MA==
X-Forwarded-Encrypted: i=1; AHgh+Rq70bHGGEhw4p1GSTlNVsXaQ8Y/0effVgmDeXu7o/hCG0Q1boSbN6U4OBRN3p4slhebaliKxif4Fbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxREz8Fqo47oBerevduczsDcV7KoIzChJIsC9O66nFNEPXKGD
	S8mJs5+tDdnUt5GTO16VC967BKCCeEdLtfimet/KOnWxC65j9T6IdhyLxPaFbdAicLG+1JbVDMT
	7WA==
X-Received: from dybgo36.prod.google.com ([2002:a05:7301:25a4:b0:315:9b2e:850a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e613:b0:3cc:55ed:dbfa
 with SMTP id adf61e73a8af0-3cc71cd3ee1mr2499125637.27.1786672615150; Thu, 13
 Aug 2026 18:56:55 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:44 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-3-praan@google.com>
Subject: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
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

Rename the function to iommu_disable_device_dma() more accurately
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
index 9b8ad131ba79..911a95527d74 100644
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
+ * Note: Not to be used on a fully probed device with
+ * live dev_data.
+ */
+static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
+{
+	struct dev_table_entry new = {};
+
+	write_dte_lower128(ptr, &new);
+	write_dte_upper128(ptr, &new);
+}
+
+static void iommu_disable_device_dma(struct amd_iommu *iommu, struct device *dev)
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
+		iommu_disable_device_dma(iommu, dev);
 		goto out_err;
 	}
 
-- 
2.55.0.691.gc56d675ccc-goog

