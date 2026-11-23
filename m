Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478351;
	b=F+fuOZzLpNIqhR+3VafNvVXyuWZ8HbyQklwengErZDkgQZ3xXCmPntHX/2y7NkYMSyPq
	 QHb6t8zbN4Fsf05aWIqcV1FxAFUSsIa5kzdRIe2YlQ7EyqmBp5lUbiMElb5qA+Z66+sbA
	 SNirgHK98zlNWM4UGckPKb0bk/ACFjgv+SZBI8ifRhb/FBYPgf8sI5dIFM6ucY/nURz6H
	 t7nWwGCO13YJKHRnSmaIEN4U88QSlsYrjxtEqFtb/4nuXs65etU0UdgE5MRLXBupEzYuh
	 /Qp/9Xu6BC5PdBYGVt4QeYFGVo/8ORABWtZc1SkTIzFPzd/YwT1hSMHO8UIAo/PlKfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JPIzmh8MgAGzwbd/e1qtcX2ELMVKAJVPBlKusfiCnS0=;
	b=WZ1FGOiAJPmryaSv2iG7dKDzFnshxfxnqpiFbucy/fFQlYy35Xm3MPJB4o0Hl+8Yrila
	 Sj59kpAcnTAiOsnn7/q2SMRgIFYayFEtgCjZItu3EY+8ps1evljd9JeumsEmWFBl85Zsm
	 FI+rXuv80azJV+q3Gcqigm0oSMFA/02jhthUO6axecDIB7UZCSN9e6A0RfikoAgJLw9xB
	 2wJnrFFTWwjyTIADGon4V29fmETEtCUtz59diIDGqA/zuJ881LbF+1F6zIPf8SAka9I/V
	 /ZJe40KVSLTXHTECHB1d79rnjdOOxxu60XOCzNuriJPbS7XrOmpfoDTR2PFvKLZEV8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ihd5XTrx;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8B606A685
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 23:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB8B606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ihd5XTrx
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a9be758734so2368879f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 15:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795478349; x=1796083149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPIzmh8MgAGzwbd/e1qtcX2ELMVKAJVPBlKusfiCnS0=;
        b=ihd5XTrxJPETqHH0T2zdVVTVWTiHMWwJRRFTWCgV9Su1m9S7wCJpK/GbB2TOsPjPID
         R9mNRn++nv6XjdWznxpHpwYgggGtvNKh7Jq7EbbxIPqTvR7EpByJYBvlJyF+MpDq85KJ
         Aaih13pQo5ae5iL8N0ZVZA0Tgq3xYKBlx0DQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478349; x=1796083149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPIzmh8MgAGzwbd/e1qtcX2ELMVKAJVPBlKusfiCnS0=;
        b=XFiz9iqhUptWP3hHsEZMklQNDeHTBMFR7AmDVznMq7vUuyR9tfxuHxj1rBxp8YiSvz
         +KeLOC00GfVNyazAuWl36Mm7Ey3Q1gEi2O0Jqmfpr0bHK3tlO1RrWa/47vWFHSkWIZOF
         9QU73W6qIeQdbMM8ZzBKM7c8tsgYzlDEru9E3rIaeZ8DCkJy8NGHRwNXc0I7eb5oYfj2
         cyO1TTledMuQwP3f702yJdZEFOskR0R7GWO17mAzUNm9ejRAHOTfL80QVr47YlrqXF9z
         wCY3u8e+jvm+wPmeDa1POxp1XZApT1qfSwbRBetbtiHqcuHM1jgu+dS7406GXVua6fcc
         KmWA==
X-Forwarded-Encrypted: i=1; AL+hErG+hzbypvjg81uja/fotoQnEB24EsGYpfWhol2gHQt936or6i+IIHidxP5+SDZ1OQByiOyFBRFPCV4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iL1ycbOuT6PiPYqqCstT5R+kcx2e20cBqJG04p6YrHJ9gIDck
	B5zSsAzlFFxPiKciSQv6r/kqC7g0O9xA3gWhHWmopHTUCPC454wNMqX/z36k92jJkg==
X-Gm-Gg: AZFdTZeFGet4c+5zlaKxLOMQM+ogu1A8XgHC9v/zX1zd328Mg0w3wlowI760R6qZ5TB
	LXCJCN/501K8iyZePaw9Rc9SIVbQuJKKBBNbEVdN7MoDScNHS1zbSRwOIcNdyCEPnQ9lFClsfO6
	k+ElaQ6nkQ3ykg3wiSIBUJZljDpN0SS2gGAdBcfAZyVtWVM1NqZpr28wk+jFp4CP8bKodnyl35H
	ZR6PD8RHm2qVAMS4vbGz5QyKq2kDrwdL7n4Shpvav0aKQb9G3r5S2gs1B7Hx7i7UJ9A/kqT/HZY
	MO1QHWWWghoxzb3rzxxzYuXxUrYDCBOybWec7Vbc7aK0ZcFNvAiwXzwfwDHnI05caWNCAWeX2aQ
	JpbUuinpcvgXc6Rwk7xq6PmdNUrlUalUH1H+c6cnTtcbdWt4ZiVfYuxT6BpebpdI7KnSOOlp8XC
	JMX03fB5HCauZcp8ye2FfogWsAhhLOn3dJ5fAutKAw8CkchdfK9cBFR6J1eCpiPWQX3e0Nwt+Tp
	/EJCnV9/gOzx3jJ2+cPy9uR4r11pecFDsTP405DyGikTJ8f9DoEqjK/RqaTzXHyd75GQaTB8SdJ
	+9JnL7+uOUEiDjg/ir8xC+HZYY4Gf8VcPST13odwWQATuYGM1y3Q652tKf9UXRqERjyQvWd7Qcg
	99TzvQmmRlT5IYkWE9A==
X-Received: by 2002:a05:6000:2883:b0:4a4:39bb:970d with SMTP id ffacd0b85a97d-4abab02c469mr24709044f8f.2.1795478349545;
        Mon, 23 Nov 2026 15:59:09 -0800 (PST)
Received: from dmaluka.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm25727068f8f.59.2026.11.23.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:59:08 -0800 (PST)
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
Subject: [PATCH v11 2/2] PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection
Date: Mon, 23 Nov 2026 23:58:29 +0000
Message-ID: <20261123235845.564027-3-dmaluka@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123235845.564027-1-dmaluka@chromium.org>
References: <20261123235845.564027-1-dmaluka@chromium.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      |  2 +-
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 10 +++++-----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 10 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 41ee4ad1dcf8..aa592a1e5298 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3223,7 +3223,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		return 0;
 
 	/* Always use DMA domain for untrusted device */
-	if (to_pci_dev(dev)->untrusted)
+	if (to_pci_dev(dev)->requires_dma_protection)
 		return IOMMU_DOMAIN_DMA;
 
 	/* Apply device specific quirks */
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932..30f9d108897e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -589,16 +589,16 @@ static int iova_reserve_iommu_regions(struct device *dev,
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
 
@@ -611,7 +611,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	if (!IS_ENABLED(CONFIG_SWIOTLB))
 		return false;
 
-	if (dev_is_untrusted(dev))
+	if (dev_requires_dma_protection(dev))
 		return true;
 
 	/*
@@ -1184,12 +1184,12 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 				      &attrs);
 
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
@@ -1790,7 +1790,7 @@ size_t iommu_dma_max_opt_mapping_size(void)
 
 size_t iommu_dma_max_mapping_size(struct device *dev)
 {
-	if (dev_is_untrusted(dev))
+	if (dev_requires_dma_protection(dev))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..dd75b41f47ab 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2625,7 +2625,7 @@ static void __init platform_optin_force_iommu(void)
 
 	/*
 	 * If Intel-IOMMU is disabled by default, we will apply identity
-	 * map for all devices except those marked as being untrusted.
+	 * map for all devices except those marked as requiring DMA protection.
 	 */
 	if (dmar_policy_off()) {
 		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
@@ -3630,13 +3630,13 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
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
index b486b8bbd1fc..e0bae0c94741 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1901,10 +1901,9 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
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
index 9cb23780093d..34e9147e52c7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,7 +40,7 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap || dev->untrusted)
+	if (!dev->ats_cap || dev->requires_dma_protection)
 		return false;
 
 	if (dev->is_virtfn)
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 5971ffc2a375..f6b199a121bd 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1454,7 +1454,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
-	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
+	pci_dev->requires_dma_protection |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..a2246049cae7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1017,7 +1017,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..d69ac5a746fe 100644
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
 
@@ -2082,7 +2082,7 @@ int pci_setup_device(struct pci_dev *dev)
 
 	set_pcie_cxl(dev);
 
-	set_pcie_untrusted(dev);
+	pci_set_requires_dma_protection(dev);
 
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4a02fc80755d..e081b6ca1fc0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5526,7 +5526,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
  * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
  *
  * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
- * if dev->external_facing || dev->untrusted
+ * if dev->external_facing || dev->requires_dma_protection
  */
 static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
 {
@@ -5567,7 +5567,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
 	ctrl |= (cap & PCI_ACS_CR);
 	ctrl |= (cap & PCI_ACS_UF);
 
-	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
+	if (pci_ats_disabled() || dev->external_facing || dev->requires_dma_protection)
 		ctrl |= (cap & PCI_ACS_TB);
 
 	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..b3fb044c5a4b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -491,13 +491,14 @@ struct pci_dev {
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
2.56.1.831.g720f3f5937-goog

