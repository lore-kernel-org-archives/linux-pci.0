Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDE3D349A
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053146; cv=none; b=GcPzHE/4a8knoPa5W1L9TiRYdOWi+GJKae0pgHqrQx0CUVeZNgc43AUaBuP8gCfgKrKPR9XspFP5frC+X5qwOoDZmbFX9gU5Njju2Icq6N+y/cXbBRryntoa1NqW3MhaMI75kMB8qikgCXgA5uT2LewEWmF30bj3x3pV7+ve3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053146; c=relaxed/simple;
	bh=7e7DAPIm+AHn3qv5bIN9iON9Yk8ymifmGfWJ9sb7sLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cc134HkpX4DsT8jeIH2n9ptzeoQYa+Fubr5eV3Z5gQE9k6BFi85LiZWxQS7liCq0ZuriK3oNs+pXCsXF7AfOgDUmOWy7Li8yu6Pt9Ua6dovRDohr+H9KiScqV/+MaVMZLgZ8xPCTOt+muwAk3FwdCiFO5zn0CXpkiSNBokZaVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U/GEFfv1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/GEFfv1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso9356780b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053144; x=1780657944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=U/GEFfv1bhw3kHVeNHypaITBq/mzAkht4g2B0oLAZzpjDZMC1xGAbDa+MFpqwNYOLb
         l56jWYn+Bak4+usi83MtTIOV/P1BLN54faVgJXHeWw/x4MGHcPhKqvAREtFiVr6ENhqZ
         LaioxCS+Uc5sh180Hk+xMF5lqKhrhYw2WBrqhX2TGDZ+Bspha6iH7EvJ0ctg5s6EZTPg
         Cj4r0LGM2GpDX+XBXeT5ZJNqu7pC3ZuwXMxXaFtkj0VYjqQ98AgxMsyXntJ/mWbMNLXC
         YcMc9Ga/ada1uJuO3TIu6oYndeR9Bj7PWraQAW/rq0QNhzALQ4K1aOYu0a9RfZ1CwL7b
         Xg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053144; x=1780657944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=Ce0aXZNijkqKF5uMXYinNTJofRUFbuzzjJ0Y/gJuboYcouUEJohzYl+2bQOjRR0ygr
         81cVL7xXkr+brl9++N9ZLRX0TJH71PA608Wf66KIOw/j+R7GPE6qw6yCxjMXpcVYW015
         jJYShmSVyI40nyE9DvXQ1GKFM85GYi0ZKKta2M/GaPUfDpG5beSlK8Fr1fvSz2F0ErI3
         zBnELoLQaV4ESgTZuq8TFPPofjbFKPZmdu+MAAZVFbjQmLjc+TjBUEgzRVpErpJPWWyL
         T/DjTLhPDmahNoVH8rd1wg5QCRULCPQVWc19ngXbbRrjw0X2xSf0b4I0Z2pgxvRAhR4i
         nOZA==
X-Forwarded-Encrypted: i=1; AFNElJ8QQr7vUO+Rr06qhEa/2siHQT2Xxx2pdfD/QrvtcKpG5CqKniVRvKG9UFXnvxGD+cwWQtNwEuO43I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoI1xl05b+/xJzAqGozcNv71ua8FRO5doxOTiUOAyTSLvnV2Qr
	u+JmyHgic2baI1OlK0U2esVhle50yxdhTw8EVs7SiQ++SFva1DhkUBP+Gek+U36GC5V7RPdoc6r
	23Q==
X-Received: from pfbll21.prod.google.com ([2002:a05:6a00:7295:b0:835:429c:76df])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:848:b0:82a:7471:eb90
 with SMTP id d2e1a72fcca58-84212ba36e5mr2711651b3a.30.1780053143552; Fri, 29
 May 2026 04:12:23 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:07 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-6-praan@google.com>
Subject: [PATCH v6 5/6] iommu/vt-d: Fail probe on ATS configuration failure
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

