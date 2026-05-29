Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F873D34B1
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053147; cv=none; b=ADwi0ekBo4h9vVCyzwLqG170gfQOHFtzjofaCsrzU5abSATlaNyqlzm4C3pgcXWUTWtE6rpCDklky67VQ1vmiEx3e9/sqKKFfgNhbTb1R9OrNYm68dft+e9qvCALRELNyT8WngzfUwqLIUok6QmKf87rjOv26jaKGNYo6s1rI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053147; c=relaxed/simple;
	bh=C32dPM3NWhfYHk+PhOeUKOa0PbpNAjRjIDRpztej9Bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LG8e7na4Kjd5JmQ/IruprNbuJzrBm7jiqxoVnqtWIZ4rUxKvjb8SWcsMTDwdh+1zBsbtrkpP3LsQCBqz2nT8dXGrEgbt5w7wSB7IBb4m1Klk+mYaCxI/qTwuYJBcVNw4FtBp/tdnJBKB3/gFm1h1IRXQaLqTGKk0iarY03R2pWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDeg6dAf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDeg6dAf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso6571475b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053142; x=1780657942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8knH7UioVOHGAK4eKxBC8130k96uQrzRV3kgHSLvOkg=;
        b=dDeg6dAfGZGag+1hj1qJD9F+MBKD8O/UyK0dGaRbk1O785mIqFxac0wcSvEFf0mQuO
         8WrKd/CxQen5cA3U928sD4GNgokqIuScqpKfAKlIuapfYQ0TxY6uhgSTIENEPLI4XKgY
         +A96I6CmzVMZu1U9u7dN/VHV9CXvmSjRaK6qKp9s2ukd6nSLrRd63/bpjq+oXutj3A/2
         x1i08uk51WAKNG91CjFF22LtAhGCXqUUwQoIKZf2CrfG2k5r/s66YtXNB4uf9R9wm0ND
         IHIPhg18T47gTha9zdVhoY/tIMkvtBY2IhDZIQAJqT+/Eisdi9XcxHSHujJeHGdXqifE
         rMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053142; x=1780657942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8knH7UioVOHGAK4eKxBC8130k96uQrzRV3kgHSLvOkg=;
        b=AMClFx6cktTw7bZT0vy0+0/N8j/4Vp6PPXot/of95sdPzOGlK85QyBy6akJ+EbLSIm
         QizyTVuXytiGxUW0Ysi7vZhrqB/c6G/hq3P1o3AcwYeGwJw1/mLqRqcjM0MknkK9s155
         zHgsj1oTfHL5A7rEfi/Z8EVi0owDUoNGW5NA4Se4p0O07O39JDy6SU1c2OI/uvA4A6/2
         Q3Sp0Kxsju6COo/BI8bHH59IsUN3TU+lcYI5le/PajI0ohW/PMYMUjQxBJe/MgdBFaUo
         DjssbVbs3upteA/OXjAalLYSJkH/ZL70QG+7pt1jgO9n5EaWtHrkttKKMD67k2WzX5s0
         gE4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Q/hSrkIYm5IQSCxpuU1NIfUecqeDx9ftuZWwDufYm3k/KkqUyfrIPpZWeVKNuXmwmYcDQNNM1e8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNg48nDwpqK53L7Spz3qQ9UgZr9ak/zy11W59bb1jSkiopUV6R
	CoiX5eINHhYxW/Xo2VOOMt0m7ZuYNgp89Hl7gGWU0p2r0EM3y/JbBFyWmHlkXvj7byZluMz5JoU
	JFw==
X-Received: from pfbll21.prod.google.com ([2002:a05:6a00:7295:b0:835:429c:76df])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2185:b0:834:df57:9d36
 with SMTP id d2e1a72fcca58-84212ba2fb4mr2617218b3a.25.1780053141470; Fri, 29
 May 2026 04:12:21 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:06 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-5-praan@google.com>
Subject: [PATCH v6 4/6] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
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
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The SMMUv3 driver currently has a two-phase commit in its ATS enablement
flow. During arm_smmu_attach_prepare(), it predicts whether ATS will be
enabled using arm_smmu_ats_supported() and accordingly increments
nr_ats_masters and merges ATS invalidations into the domain's invs array.

However, the actual hardware enablement via pci_enable_ats() happens
later in arm_smmu_attach_commit(). If this call to pci_enable_ats fails,
the SMMU driver's ATS state tracking remains polluted, i.e., the driver
tracks ATS as enabled on a master that is not actually using it. This
leads to an incorrect nr_ats_masters and triggers a warning in the PCI
core during detach:

 1 [  127.925080] ------------[ cut here ]------------
 2 [  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8
 3 ...
 4 [  128.068169] Call trace:
 5 [  128.070603]  pci_disable_ats+0x94/0xa8 (P)
 6 [  128.074688]  arm_smmu_attach_prepare+0x104/0x310
 7 [  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0

The issue was exposed under heavy load when running a VFIO-based DMA
map stress test (iova_stress).

Following the addition of the arm_smmu_master_prepare_ats() [1] helper during
device probe, failable ATS configuration (STU setup) is now handled early
during probe. This ensures that any master reaching the attach phase is
guaranteed to have a valid ATS configuration.

Update arm_smmu_enable_ats() to use the WARN() macro for any
subsequent enablement failures during the commit phase. Since probe
checks now preclude software configuration errors, any failure here is
considered a kernel bug.

[1] https://lore.kernel.org/all/cover.1779392420.git.nicolinc@nvidia.com/

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..aaebd72bc48d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2956,8 +2956,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
-		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
+
+	/*
+	 * Any failure at this point is a kernel bug. pci_ats_supported()
+	 * and pci_prepare_ats() have already verified the hardware capability
+	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
+	 */
+	WARN(pci_enable_ats(pdev, stu),
+	     "Failed to enable ATS (STU %zu)\n", stu);
 }
 
 static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
-- 
2.54.0.823.g6e5bcc1fc9-goog

