Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB03B2D00
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321346; cv=none; b=OuDOXeeLBzvWBLbUamxjeA8CmrRt4FKl4Pt4F7qn5vtOw1keEydKqiTml7ShXARYNCLCFHeEGJnvW/prwsUSP7HXv+dRjnSnX8MirRjM0gdrOGiuXyt3zKoN+oBQbumtgI2SsD699csH1gNYLCe+WsVUyhz+J0FYXVuRiQEqCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321346; c=relaxed/simple;
	bh=w9aL2jXBkSQc60s7PCYdOXjxGsJtviB4VjNKmXS4Hw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b3OBneg7XGRuACRApg6uIIv0PvIp2sfD4UUeZcLqaHxf1dI9ZZ2nKsLiTGnu92mcFUL/PteEVAZyVhvQyKvO1qGwTbCDSqedu4pAbEFnMOCA3WEEPyass8J8BeO1hlEUCr4LpCO6x+rm8ZKH1aqW2JxGHvNwopmxnjd8QVlAUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5IpyRcY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5IpyRcY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf55c3f44aso18247065ad.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321345; x=1780926145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWexhegNnVMZtjViVug1/DougZixUK6pa8KgAqOhU80=;
        b=J5IpyRcYjT+9kfjvogEenlMSN5c8t00cMLIAfpYd2aYJrhhLO6/smbUfk9nHSOsGC/
         /4mq4kxlTLH8YTg1MJHM4NglfYYEZSlOECnKAT9CuBBFze9uzgXTpZRdxQEem1NMWUXE
         BDTPPHaqIAUlQR9/w89tW8Fl0WozTuZmh9ozLPQgaFNUqLsMWFHFh1EJ/hPCQVMTlb9+
         SnZpbuE/bt0ojSpitBPESCTFSPEJkHVAZYAv20+DXW3JeF+oeCJw8owJEOKvWWiBWt3z
         6hL8g488Rh1D4Z/K+kb1l19KPjyHbIy4kETiNCZ8c2/M0XK2d2ji6+Bpt/caIApGGeO/
         yysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321345; x=1780926145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWexhegNnVMZtjViVug1/DougZixUK6pa8KgAqOhU80=;
        b=d0/uGpUOlKDBg8/ei0EE1DGFsSuNwKP0M85Z+9pFkhde4ifhfkNzcfvTuCFFzV8/XJ
         1jKYa5pfJ+FcgkKStum8+Maolz3oDHnfuV1kC4TXNK5CHoR33SuylTR1RiiYwd8ZZIqc
         GCZ2kU3zOUv7kPyoSGYY5JtO2EXvEpYBuOpZnv4TQDvcwQzWReevFTcxl/LKmOpDczR/
         GBsKIuoqP4Yh0OUAlyCd79oz0c081Drk6qqDURj7+ZlkD4nYr5mAHLR9QLWIQbh9qT2j
         b1R6BHO8LdB3IFNC0OiRqoCzWIf5wUXK50Wq4QYau8D3bop5K8JRSb3/i+IQj0a7b28T
         B6DQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pfaWi/XGxsK08tM3ovZDP1KE7E3avHIIyFzPx4H4eaknu9dh/YDwjrpxd+jRGB8+5xAXw984EdQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwgLT6dDVTmbVazZWjti7THGMrlFEGPzn99Tr4jbVyAGbmFQbm
	YyxAIsQnwZe9uu9+nn6CUw9SzPWqrAUjBExdAs5NFYk4NVmG3PIWhHpSfhMYW6gTZrDxp8FhmYn
	s8A==
X-Received: from plbke7.prod.google.com ([2002:a17:903:3407:b0:2bf:1274:55fb])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecc:b0:2c1:6ed:513b
 with SMTP id d9443c01a7336-2c106ed52bfmr2564075ad.16.1780321344530; Mon, 01
 Jun 2026 06:42:24 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:04 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-7-praan@google.com>
Subject: [PATCH 6/6] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_prepare_ats() internally calls pci_ats_supported() and
returns -EINVAL if the device does not support ATS. While this provides
a silent safety check, it conflates support detection with configuration.

Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
the function supports ATS.

Update the function documentation to mention that callers must verify
ATS support (via pci_ats_supported()) before calling pci_prepare_ats().

Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..e10a0ceb2645 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -53,7 +53,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
  * @ps: the IOMMU page shift
  *
  * This must be done by the IOMMU driver on the PF before any VFs are created to
- * ensure that the VF can have ATS enabled.
+ * ensure that the VF can have ATS enabled. Callers must verify that ATS is
+ * supported by the device (e.g. via pci_ats_supported()) before calling this
+ * function.
  *
  * Returns 0 on success, or negative on failure.
  */
@@ -61,7 +63,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
+	if (WARN_ON(!pci_ats_supported(dev)))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.54.0.823.g6e5bcc1fc9-goog

