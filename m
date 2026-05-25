Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E53A1686
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748835; cv=none; b=D2/FwXzHKbBIaa6Wvpr7jGIrQbERQ+h+32/G4TT1nBsEo+WlgaP2iIkn+4jIqO6KtSr2RgxgEza3RSzElnVGs++Q+m8V0veUgKyUlygZPIeqIdZpgA9BO4OedL0zxmmJaVATmOao/hfU7HFQ9GPcw6Fed/KNicwvnxSyLcM/d7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748835; c=relaxed/simple;
	bh=aSD74kj3PYGdo1SdrMBvJv2yGoUP4gPA/6+KokFBSxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8aDu9D13R/zFNhKOVJvDDYIxEEBaTPeObpeJftJ6Vuq1q+IyGrDl7gUhB6geZUru7csoHzRgvE+bQ6Q25uZA6ywh2Q+oR3bp740pGDzGRFQkD7FcU1J8oGdLduYqRekbd5p+FG0Aa5neoaFxSSvhgrOeXob07jLwFzwjlQI6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GDsyuLdK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GDsyuLdK"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso36188475e9.2
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779748832; x=1780353632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG2Cv2VAw3UgVMREBUMr2dx1Jt62rgb3ophHpy677q0=;
        b=GDsyuLdK0uE972iVPqNUqZZGfIPnz9K0AKZp1JR49BvZemGPpBPqNIDuhOWRhJ5JWp
         LM05u46PLqVmvZnZh5Vkw9FobFo55tmzK2QNMG76+XeobTCuNhITzyrtvFejq0MMknKA
         3PuKPmSmYTFiUD0dcMqFQHD0ZdkYEw2jI0UaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779748832; x=1780353632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WG2Cv2VAw3UgVMREBUMr2dx1Jt62rgb3ophHpy677q0=;
        b=TujN7vQBKDa9kPkPxSVyVlEVSBYPmaXOXpBTy8P3e7rNY2wCL1ba4yWuhSDkfGXkni
         06mQRzAm2Crzn8A80wGWH8niety28LWrEBT0Xv6ZkMyKc6pv/+ygRUqEZy+fvqAI8P0E
         HP76zx+t+bw1u+jwfuAmReGK/TGQ9Wa2iBiWH8C5y99BH+ckGqIJrKkjPsafe94IPR0C
         Bx1IBUTMtjGAO3OsvnkTgY578NGvzo64xh5GnnZ3W8nJF+G+BS3KB93XT2vn/K8heF1B
         +l97zhjU092WhveXvXgaZlTtflqZoaES9vOAVzk+VAZ3aA3FNuu73tPAGUn3L72Nveyw
         WXiA==
X-Forwarded-Encrypted: i=1; AFNElJ/LA4V28F34G58nntvnIVKcTbYNiLG5AQ7Y6MvZxCae0mo9IMrf3Rswkb9/W5EkXilXTyee5tcMDLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLFEL2hv7j5wbHJuYl+hoPgTrtPJb30uzJ/IDS/7TkD8+VBk2
	e2mF6jcLlZy5K28wlMEsVpTIbnC3Hrn74S/a1tyYudTz+C6wJ2HOtu1kefEKiJ0bJw==
X-Gm-Gg: Acq92OFg8Tl49d2i0MvG+552cA8W4G0ycKDQx9UU2IM9drIoAC8aWdcODGhAwF/uLgp
	pfpTkUOtJnwDaQd26vfSzUuI3OT82gzy5poB61uoZfnzWt4d7pv7SWrmaWARSallyZ1m/OR2oBh
	7emAfnKZ92ZT4iy/pNz4ESXtoHDz50Y0GkGKz68gknV9apijO9h9eAok2g09zKMbo4RLJWXmTcM
	U8NRupg4V5h/fgXN7EEM98EXNVSggMg6hq/Ug0+Rn4/sgBGtdNuu6TCnT2ZrnrBo9eFrslVzauQ
	PpQVWnbLYg6ciiXnt16ZoBR4iIJfJbA+Opash1hnVPXcqjtXxwIOpgzmc5RNx0yd7FmfATkx7yB
	qDTkSQevIbklf7QTPXlLgKt0MLVrwPomacNpGmvWViwfYdz+CFuh8fnbZf8wbxlsUZJyA1QsqMz
	gD5lsSJa/bMHj8tQjOjJxSIvnUiNdkgDPeXixWgJ6bXZS6v2oOtbgU4rX7lOQko+hnKbIzfwOV4
	9lr78J6b+8kPf/tj0FoNrM=
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id 5b1f17b1804b1-4905872e758mr171695635e9.18.1779748831589;
        Mon, 25 May 2026 15:40:31 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm26467837f8f.25.2026.05.25.15.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:40:29 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Joshua Peraza <jperaza@google.com>,
	Jesse Barnes <jsbarnes@google.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Tomasz Nowicki <tnowicki@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v10 2/2] PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection
Date: Mon, 25 May 2026 22:40:20 +0000
Message-ID: <20260525224023.2753569-3-dmaluka@chromium.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260525224023.2753569-1-dmaluka@chromium.org>
References: <20260525224023.2753569-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajat Jain <rajatja@google.com>

Rename the field to make it more clear, that the device can execute DMA
attacks on the system, and thus the system needs protection from such
attacks from this device.

No functional change intended.

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Joshua Peraza <jperaza@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/amd/iommu.c   |  3 +--
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      |  2 +-
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 10 +++++-----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 10 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 57dc8fabc7d9..70005fe16e64 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3133,8 +3133,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_data)
 		return 0;
 
-	/* Always use DMA domain for untrusted device */
-	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
+	if (dev_is_pci(dev) && to_pci_dev(dev)->requires_dma_protection)
 		return IOMMU_DOMAIN_DMA;
 
 	/*
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54d96e847f16..63a0b24b24e2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -588,16 +588,16 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_requires_dma_protection(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return dev_is_pci(dev) && to_pci_dev(dev)->requires_dma_protection;
 }
 
 static bool dev_use_swiotlb(struct device *dev, size_t size,
 			    enum dma_data_direction dir)
 {
 	return IS_ENABLED(CONFIG_SWIOTLB) &&
-		(dev_is_untrusted(dev) ||
+		(dev_requires_dma_protection(dev) ||
 		 dma_kmalloc_needs_bounce(dev, size, dir));
 }
 
@@ -610,7 +610,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	if (!IS_ENABLED(CONFIG_SWIOTLB))
 		return false;
 
-	if (dev_is_untrusted(dev))
+	if (dev_requires_dma_protection(dev))
 		return true;
 
 	/*
@@ -1183,12 +1183,12 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 			attrs);
 
 	/*
-	 * Untrusted devices should not see padding areas with random leftover
-	 * kernel data, so zero the pre- and post-padding.
+	 * Zero the pre- and post-padding to prevent exposing kernel data to devices
+	 * requiring DMA protection.
 	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
 	 * the contents of the original memory buffer.
 	 */
-	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
+	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_requires_dma_protection(dev)) {
 		size_t start, virt = (size_t)phys_to_virt(phys);
 
 		/* Pre-padding */
@@ -1761,7 +1761,7 @@ size_t iommu_dma_opt_mapping_size(void)
 
 size_t iommu_dma_max_mapping_size(struct device *dev)
 {
-	if (dev_is_untrusted(dev))
+	if (dev_requires_dma_protection(dev))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..0c10d48fae6e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2487,7 +2487,7 @@ static int __init platform_optin_force_iommu(void)
 
 	/*
 	 * If Intel-IOMMU is disabled by default, we will apply identity
-	 * map for all devices except those marked as being untrusted.
+	 * map for all devices except those marked as requiring DMA protection.
 	 */
 	if (dmar_disabled)
 		iommu_set_default_passthrough(false);
@@ -3491,13 +3491,13 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
 }
 
 /*
- * Check that the device does not live on an external facing PCI port that is
- * marked as untrusted. Such devices should not be able to apply quirks and
- * thus not be able to bypass the IOMMU restrictions.
+ * Check that the device does not require DMA protection. Such devices should
+ * not be able to apply quirks and thus not be able to bypass the IOMMU
+ * restrictions.
  */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pdev->requires_dma_protection) {
 		pci_info(pdev,
 			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
 			 pdev->vendor, pdev->device);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d1a9e713d3a0..4614342dc15b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1902,10 +1902,9 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		driver_type = iommu_get_def_domain_type(group, gdev->dev,
 							driver_type);
 
-		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
+		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->requires_dma_protection) {
 			/*
-			 * No ARM32 using systems will set untrusted, it cannot
-			 * work.
+			 * ARM32 systems don't support DMA protection.
 			 */
 			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
 				return -1;
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..8f5ad7122078 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -43,7 +43,7 @@ bool pci_ats_supported(struct pci_dev *dev)
 	if (!dev->ats_cap)
 		return false;
 
-	return (dev->untrusted == 0);
+	return (dev->requires_dma_protection == 0);
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9af1bab27841..08a07e02bdf7 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1457,7 +1457,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
-	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
+	pci_dev->requires_dma_protection |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..4273c4ab6d9d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1003,7 +1003,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..060210aaca2e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1738,7 +1738,7 @@ static void set_pcie_cxl(struct pci_dev *dev)
 
 }
 
-static void set_pcie_untrusted(struct pci_dev *dev)
+static void pci_set_requires_dma_protection(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
 
@@ -1748,14 +1748,14 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * If the upstream bridge is untrusted we treat this device as
 	 * untrusted as well.
 	 */
-	if (parent->untrusted) {
-		dev->untrusted = true;
+	if (parent->requires_dma_protection) {
+		dev->requires_dma_protection = true;
 		return;
 	}
 
 	if (arch_pci_dev_is_removable(dev)) {
 		pci_dbg(dev, "marking as untrusted\n");
-		dev->untrusted = true;
+		dev->requires_dma_protection = true;
 	}
 }
 
@@ -2077,7 +2077,7 @@ int pci_setup_device(struct pci_dev *dev)
 
 	set_pcie_cxl(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_requires_dma_protection(dev);
 
 	if (pci_is_pcie(dev))
 		dev->supported_speeds = pcie_get_supported_speeds(dev);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..ca7c964b593f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5380,7 +5380,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
  *
  * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
- * if dev->external_facing || dev->untrusted
+ * if dev->external_facing || dev->requires_dma_protection
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
@@ -5421,7 +5421,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..672577378650 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -485,13 +485,14 @@ struct pci_dev {
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
 	/*
-	 * Devices marked being untrusted are the ones that can potentially
-	 * execute DMA attacks and similar. They are typically connected
+	 * Devices marked with requires_dma_protection are the ones that can
+	 * potentially execute DMA attacks and similar. They are typically connected
 	 * through external ports such as Thunderbolt but not limited to
 	 * that. When an IOMMU is enabled they should be getting full
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
-	unsigned int	untrusted:1;
+	unsigned int	requires_dma_protection:1;
+
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is
-- 
2.54.0.794.g4f17f83d09-goog

