Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BF233722
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 23:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897625; cv=none; b=Mu2MLTFu4ngDCh5pTqTWbDGKHD25WDKnbMQWX8KGjhV5/7iZCwTQxdD/QlcIbm+nM2gwYQL3UJCoMrYQQ88p+FkQ77BMf9rV5ZqlrQS5yu9vUmlWxrWbfpzojwFwjkvqLQAGxmh6CNPYzXncnIGgm7KJPnT+PGb4I4ILbxwuZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897625; c=relaxed/simple;
	bh=rJ7ojJeNxoY0F3yEvcWXE6csFWNbbcG2IYb5WneGaCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cU6NlW/3ODukk/DtEfUHzQWKrV4P9sKK0AgC5XGnIaRRByzo/2hHYwI7sPMUAruF64S9pljyBrOgJH95A0h1UYFWcKZ5DIj0P8V/mLTnjo+XjoPm1Z819uh+PZxI7Aq1mhS+ilYLBqVay/kpDPZK1s7a6g2uN1Pwlr8bdf2YwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qb9mNtiP; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qb9mNtiP"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-88629a452e0so2754787b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2026 16:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790897623; x=1791502423; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLEmTJab179jZNvGnD2AcNd0Naspf1zrpumlDqZqMDo=;
        b=qb9mNtiPFSGaKlZA95P74co+fd1bTq2TlTRp9G5zPaX0vPxUWWawpd39ewN2+l2AqP
         aU3KdhyYJRRxkW/pBF75RWKSE7MX2XC5OpWhOeJylY4hl2ublnV4Pj5Mu9TXwWqhTfs6
         j2eOBYqopfh2LgKESlOEzEbVA1/oAkeKfCGfIiI1dsrEpVDpJQXK4B6y6nGrwhw+B0qN
         VdxFaiDDhkfpq9f3AGOTokbi+y7AXrf6MRgfHNIMcrbLhkDSoo/bWT6pnGp3+zULDm3U
         YmUoOqFYJf8Mml/qVcUkOx6I5RdXBOZ5Ekt5PvTAI5angcK7H0xCExFd7DiSQaJJSzhV
         tO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897623; x=1791502423;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLEmTJab179jZNvGnD2AcNd0Naspf1zrpumlDqZqMDo=;
        b=ulknnMM8KTH9z4q0uXCm1m+pYoFs50t57QsLXAROsQZvscJWkOhPRcBeTOkNRwxdxe
         5I4ibXu55hZhEOML62XAIlQKEv2mvQXqu1SglcUHBMIi3E84xKrC0ch+WvaQz95xy1Cj
         /eTfjpw9c9cBesBcbwsu9TkIDNt4/cEOhM3yOPwvcFVYYqWBJ57S1zzIxLxKqWQuoAgi
         BaDpxSVzE5RSrVqh0+u0wIsKqvoyWdEFUJJ46gXA4V3T1Q/DLKxYVe6iMM7FIz7fq9NP
         U+AAXcYule/iSNQaEKrEJKGppbFi9+i/oXrmDPlPrRaNf6FdhiWm+Og/60LQfvsiR8bk
         vyxg==
X-Forwarded-Encrypted: i=1; AKwUvBxQkVs9PR3zWnFw0ppUcHi29ee2s5bwLPhoo0HWWfk9ILEfAyk9DRu+rgvmROt7pqrV5qi+pJ+JFhA=@vger.kernel.org
X-Gm-Message-State: AFuF++lFOi+WiCHC3O+phm4/kj6PYlni/tAIljgpJYfruPCbNTgU0n0W
	bUNGV6nrE5/g8/3Ko+WwoLuuhQBATOYfPL8U8VXP96XnkL1o4/obam/gUkpM2sQF1PyiOcxaaDr
	YLw==
X-Received: from pfkh14.prod.google.com ([2002:a05:6a00:e:b0:888:a32a:d55])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f6:b0:880:7dad:3e5
 with SMTP id d2e1a72fcca58-88af6a3b868mr892255b3a.51.1790897623073; Thu, 01
 Oct 2026 16:33:43 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:33:38 +0000
In-Reply-To: <20261001233338.918408-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001233338.918408-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001233338.918408-2-praan@google.com>
Subject: [PATCH v4 1/1] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-iommu@vger.kernel.org, joerg.roedel@amd.com, vasant.hegde@amd.com, 
	baolu.lu@linux.intel.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	skhawaja@google.com, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_prepare_ats() internally calls pci_ats_supported() and
returns -EINVAL if the device does not support ATS. While this provides
a silent safety check, it conflates support detection with configuration.

Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
the function supports ATS.

Update the function documentation to mention that callers must verify
ATS support (via pci_ats_supported()) before calling pci_prepare_ats().

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..f1434f86ac40 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
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
@@ -64,7 +66,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
+	if (WARN_ON(!pci_ats_supported(dev)))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

