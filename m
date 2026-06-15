Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28B356764
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567446; cv=none; b=oZg0cG4nv37L2EpUpjn5UmOhaEJYiBgULn1RcSdamBqxofIiSF38/8Yj4y2FvDEUBw4VU0ERz/HOqa9knZJMS+WcmmyMYbdLYGGoQD54JlKnECwFmHP+F8luwJwC0slCgYVo4Xg46RFpcdXGAe6kGTdoDji35ut8s/JJakdAYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567446; c=relaxed/simple;
	bh=OJiFxKUeERlCwujCCZlS3ElgKdijyMyNKAedq9NKq0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXK+Hp4h5kWeVkKYhxx2WVWSx6UBVhM1U/PU+NpqO6eQYYyE8Yf/Y4ggSItr38G9f9NDPh2J6YCf/ysi4MzrO2i2oOFuLuwZvzcSNsfDahG5R0RneIVFNrMNYbJrGO0wuoJHOjLX//aXUX901fkdWWC9RAluWFsL2F6Nkz8uJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjgvQns6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjgvQns6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36ba24fcd46so2857619a91.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567444; x=1782172244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PA8pg/E5d0cjaYhQA4UoQX60B9QG7sbpSeEUfY/VxIY=;
        b=sjgvQns6u5yZkZE5tUKdBECC9Jb+SGWVMsBv9tIMkZ7oMmDhRypD1j9sBpd0xAl3TC
         QUepyz8Vg62gcxVKpeG/fiNYx2/K4U4Ir/GMeKZi6VEgRad6pl9tbxgVasdMzqGy6fK6
         AxzAe7/EcYB1FU4/iRzMYU3y6qlaKkTKta1N5MBQfpXEbFCZ8F2tkEhipk1OTm9XU25x
         bTiaBp6thYO2bDYzxfjzz+iBlDBc500tg/t6CsI+4a8RCd1T5f3uJpt4xd3n1DhLG2e4
         eiZ8jwpXCIqalHaJjijcmQd/oMjw6jrPqNdKqnXVA12Qv5qwF9HZwLm9o9FhuRwxJ2f5
         rK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567444; x=1782172244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PA8pg/E5d0cjaYhQA4UoQX60B9QG7sbpSeEUfY/VxIY=;
        b=WMCrqDo5iCHzF16cjTYbTYFPmHOTdYrPce5DgMa9/FcD71psttTcAQIilaFSQ+FR+d
         1xQNRW6ZYuLk8NUPmV/LHvfWr65eEKaSUG3ZBhR+0oVbeg1uwir65kUhBLUMUePVuUNB
         FkrmBG7BofZk/QDQoB2bBa8+iJoGvxkfbQhblWC54Ef5khom5f37XJ7YthM4KuMoL4tr
         ICJr87jBCO63kqaa7Vmt6my4skSOs2XSu93hUQP7u8mHXojLU4kBSMdWZ8CIwiZQ32Kj
         gwJ+SWc+ul0calRpc2hR8aS5Ap6qr7qu8V4SqkBgbLn7cDHICiDXYYwGpDympWixVze4
         LCVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9X/ZNJx0f20gUqaOMkL75NFr3nEsikyEWiJOGyvyuSr5RIKz3eCrY7RmdBCEHMr2VIGEqmv9WM2J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfY4Pz+XS7EeaaNuh7XqnDTO2nlGKRZie4r6MgiPwu/DjqYms4
	vDt2kZGke/PBiKWQl/ItyeD4xM14uyvqF7cphG4z2AgVOclDaaGBbeohrQUXS8lh9dWas2zOoNw
	CaA==
X-Received: from pjzd5.prod.google.com ([2002:a17:90a:e285:b0:36b:8553:3c3a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fcd:b0:36b:bb66:fbd0
 with SMTP id 98e67ed59e1d1-37c52803059mr1143918a91.4.1781567443395; Mon, 15
 Jun 2026 16:50:43 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:50:34 +0000
In-Reply-To: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615235037.259909-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615235037.259909-2-praan@google.com>
Subject: [PATCH v9 1/4] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..679a3c3c1d54 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap)
+	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
-	return (dev->untrusted == 0);
+	if (dev->is_virtfn)
+		return pci_ats_supported(pci_physfn(dev));
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

