Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53F235CB7F
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999848; cv=none; b=li4QO+MJGJh5/+lmhfW/HoiPPxJ9O1vALnEZDXgK3ff/IyqRmnFNCRe5jCokbAXf1MgvqUS8XQuDN+8JXHnxqRrih4IJhlZ1/mWP6ee9mh6MLC75/I4R2EuwGAs46SFimNXoehXRaujOFwOqC8yIv0BbWVrJVENBTMeZwuHvs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999848; c=relaxed/simple;
	bh=VfVdmXQxQXa/JgZYgCma2WxLIqTFBKl4v9hiZjMAj/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HYM3wok5U1bH5u+LACHgFMjqY2kyYVmtJHk+svQLhyjj4c6/c8VEI7d2xgaYw7x3PqpKBBaFmVDctOKW+v40LNMKoamlZJrSA070Fw4nDEqz+4jeAeXyjrY3IrH6tClK4xTu8kga6piS+3YHli9RlvS7hXVEfLoh4oxNWhevw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fs68YwEV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs68YwEV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c477290bso7470432a12.3
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999846; x=1780604646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQXNgdZN3cKQ+g08vXrIsLwNysE31EdhoJp0+kzR5Os=;
        b=fs68YwEVHAkWRlDyxr/2Udxv0x4gbiYQ1zQHW+x+/hMeVWwCS9DCA3oA4Dx3qxyTDL
         Xp2FO6f3h31vrZgteBxxEK+flNziqq/InKuV+w+YyXM0srA585jVbUSnA258Lctt00zN
         GpZIvvhSefoVR2TGBNnm+mPFma0AMkJ7L08nct3JbYn4sDI+Y1lgpEyde/fO6CWhjByZ
         4uujhSblA/FMTshp0rOB5MpRwe0Fb4PSIJcv6rkRCkTVoqOmrx9aJX+f+1DShDoj4ub0
         30444QJtmHXNathTXPizlZU/bIjb+Ah5b0e8JiT7UHf51B7lZ3d+KN9u1+pe8Ecqyb94
         2nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999846; x=1780604646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQXNgdZN3cKQ+g08vXrIsLwNysE31EdhoJp0+kzR5Os=;
        b=LsxhqblvJi/jz1EuE+w7IIo5EhOZ8yIGPkzAMPEAyl9yODKZLJYX077lUVwpWlnQ8C
         O6sRomGV7fs9n6lQLBvQ/P4E5CRn2euA0WVqyfLcGHApFBpvQH4wDW+PQLdXcKT90ZRx
         kd0EE+h0WXN07D4GrVKtFAFWo+qqV9EYxkwCODecaoIMq7ycSASOPHzW7oCUPvoxgtzl
         CH3/XKQ9OIyNAw/AQG3Nshu5GcIYsqRFV/nrzdE2U6wq/KvCN1GN0h1Jlwdrxz+Nlo4A
         lJ7RMtdORG+0wF8r8qTo9jo8AoUr5rowZJg89WtQ8gkC3wLc1j7ovqBqsJYBSvY6cQPG
         Pc3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/TX6hnq12w9+WH/WwWyhPCwNyit/0tWqB30fc5rJajn2jrBa58K1UMLcuhKoZ2Vubc0er/7FnfEOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8t5ti4vq0CyGAqtEQ93Zb67EkkQ8IxYl2HiW4DH9WZAeMO69q
	fchYQO5fdGBlf86JJPrp+fC9nxBbEtWY5J7R/IFHI4JysvvjdSKmFZJlzD0aQ9qU86XXqgkpZyi
	ivg==
X-Received: from pgce23.prod.google.com ([2002:a05:6a02:1d7:b0:c85:104d:a751])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a9c:b0:3b3:9815:3e8f
 with SMTP id adf61e73a8af0-3b40e578036mr320728637.24.1779999845986; Thu, 28
 May 2026 13:24:05 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:51 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-6-praan@google.com>
Subject: [PATCH v5 5/7] iommu/vt-d: Fix RB-tree corruption and Use-After-Free
 in probe
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The intel_iommu_probe_device() function contains two pre-existing
memory safety issues on its error path:

1. The info->node RB-tree member is zero-initialized via kzalloc. If
   a device does not support ATS, the device_rbtree_insert() call is
   skipped. If a subsequent probe step fails, the error path jumps to
   device_rbtree_remove(), which misinterprets the zeroed node as
   a tree root and corrupts the device RB-tree.

2. The info structure is freed on failure, but the pointer remains
   linked to the device via dev_iommu_priv_set(). This leads to a
   Use-After-Free regression if the pointer is accessed later.

Fix these by explicitly initializing the RB-node as empty and guarding
its removal. Additionally, ensure dev_iommu_priv_set(dev, NULL) is
called before freeing the info structure in the error path.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..ed6d3a0203f5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -157,7 +157,10 @@ static void device_rbtree_remove(struct device_domain_info *info)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
-	rb_erase(&info->node, &iommu->device_rbtree);
+	if (!RB_EMPTY_NODE(&info->node)) {
+		rb_erase(&info->node, &iommu->device_rbtree);
+		RB_CLEAR_NODE(&info->node);
+	}
 	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
 }
 
@@ -3254,6 +3257,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	info->dev = dev;
 	info->iommu = iommu;
+	RB_CLEAR_NODE(&info->node);
 	if (dev_is_pci(dev)) {
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
@@ -3316,6 +3320,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 clear_rbtree:
 	device_rbtree_remove(info);
 free:
+	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 
 	return ERR_PTR(ret);
-- 
2.54.0.823.g6e5bcc1fc9-goog

