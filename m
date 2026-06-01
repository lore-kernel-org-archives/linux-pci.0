Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C743C0A1B
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324620; cv=none; b=mwcDD3qt6tUUiMqv928dm4pxiPex+JLtTAcQH940YnbRP7cHl9jaVWsj8ibc4MHcRicjCHOhq9GuzxAu/UnYIxGV1rzgIiCtSca8kYhXrDvtd9K0HvjsS0O6CUiwX4cEAc1LpX53QdoId735GH2a9pJLcSdX2npUY+/FWrqMi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324620; c=relaxed/simple;
	bh=7e7DAPIm+AHn3qv5bIN9iON9Yk8ymifmGfWJ9sb7sLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tBe1Wg+YdyPd1BYWwfAYgK80Z0z2tOhOkGfwLEEQ/Z8GBAA/aZuUsujHPsa2OMZfyVU5giTP36hbjqn48goUZNn0x6UJbaS8tdnMMT9A1WBc0ZR3rlHhHxMrCjJDa+N5S0kqiSMX/qaNL3NC7WVDZSPZPoXPjUTjKMVFpMrhKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R35KGZwm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R35KGZwm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c1e112dfso19265735ad.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324617; x=1780929417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=R35KGZwmQd+dIcH0COmTdOwAOCpZ9yOs9JWtfOI/jZOdIlCKIgsMMzd4VsLM8xbWpj
         fEgBzolfgeAjJCMpy413IyxmeQb40TG9KkcvjFnxEmGfXQOiezxHnTqm0C8UQK94XK+7
         DL2Id049fDSu63ZF/h8aoLVeU06mw/WBfCKoGSprcXJNNXGqP0eeSNhpbEzzPjf1zwXq
         q7+bsxrBwokENLNTIgsu3nLJ5YOg3Bz8d1rYHMYQndy+mWd42n56nXbWjRTDCoWtvZKn
         p3c9+XZMFSb6b3tq6G2hozeeLigeiNjEYi7vhF/BK/weYnWpncL675raG7KrepqR9vaX
         rAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324617; x=1780929417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=XJa3jPKT3DY8Ad6h6IIgy9VHHKQQJEKDEC+2Rprrdpsblr456E8LwgL0m3PFp70wLD
         9Uf/drnRMyGg9QTuoyxLll2jge5p7Whk/wuTDQfH0ooxiogW2xVh/ddtKq2ApoTE9ir3
         dP6ZE0qMWK9S7ur1phYq24xq0VAh0Cra65g8Ket9BJYl5LCQ+PaLApDW86VKOWso+Ry5
         SZcATGWNnwJ6iXAJ0/T543pYva0NJPA7twyzGIzzdu+jtnmgOK3tdjabeZCfrxPQ+0hp
         lxQEzd6sdbbx1ogHyjAl2jKgD+Almnr2v3CleaMFPPEFeyoJe5YXW/tN1VRr9GfomZ01
         gcGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lXoYUIFXsWW/NVl6HfrQ1AsczXsgHfGGg/niHEtDZ3pdmC4XMnDkx0Ghc67lkzfibwIwEG0irMNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZFcJn3vevBM//a3OLQDQuyqrKFHGHLKVXFreBi79MbP2f01z
	rP/rS7d0yk4SjEFX8l0+GBaA/qi7BiPiEeU6QEiS9qEIaqkM8tP5Yhfyh44hueEJbOFfw5FdQPF
	Jaw==
X-Received: from plpm15.prod.google.com ([2002:a17:903:3def:b0:2c0:b1b0:fad5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d58d:b0:2bd:5026:ca11
 with SMTP id d9443c01a7336-2bf367936ecmr115140945ad.2.1780324616758; Mon, 01
 Jun 2026 07:36:56 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:44 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-6-praan@google.com>
Subject: [PATCH v7 5/5] iommu/vt-d: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the Intel VT-d driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..22308e4911e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -873,8 +873,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
 	if (!pci_ats_page_aligned(pdev))
 		return;
 
-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
+	/*
+	 * pci_enable_ats() should not fail here because earlier checks
+	 * have already verified support and configuration.
+	 */
+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
+		return;
+
+	info->ats_enabled = 1;
 }
 
 static void iommu_disable_pci_ats(struct device_domain_info *info)
@@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 	if (pdev && pci_ats_supported(pdev)) {
-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret)
+			goto free;
+
 		ret = device_rbtree_insert(iommu, info);
 		if (ret)
 			goto free;
-- 
2.54.0.823.g6e5bcc1fc9-goog

