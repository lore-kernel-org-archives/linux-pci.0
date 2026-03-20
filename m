Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A33D16EE
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027495; cv=none; b=euDsf9lSFx864lazRNwuCY//hr3d2K+HeUhSFOD8aM2fXhdAuPB9jBkHhPbC2Cv6VpYAyMBZ40I2s6LHHk1eI/aZ7jNpA0DHP3fp3EreqIzqDJTgc15p7efukqKA83Bxt/MKpX5s/3OSe/iiVJ0qMyEb/3Gl98JzJRrDxDNV3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027495; c=relaxed/simple;
	bh=ztWS/lINi8FK1uPkT1X4jXO3zWQ/ITWan3ys5erTRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SsEpx0aTsAVIwe8F2H8JDOpkcNf+lr/oWTBqupcGR9fvryw5uslhEO9gT0bcDLCpWMd4eDtRPe/EYW7ZYr4QwkMhgym8FMM3nS/ZW1s539L2GYowej0DYzregd2t9fKDvDS81XeYcgd5cUJe2tR0DZDhFNOjU1jYCEkzloCCC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.doghat.io; spf=pass smtp.mailfrom=kernel.doghat.io; dkim=pass (2048-bit key) header.d=kernel.doghat.io header.i=@kernel.doghat.io header.b=IYg3KW2n; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.doghat.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.doghat.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.doghat.io header.i=@kernel.doghat.io header.b="IYg3KW2n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.doghat.io;
	s=key1; t=1774027490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u7eKUMY3p0d6zwWTo9Aew6PNXcf4M66muaacfTXp3x0=;
	b=IYg3KW2nkDDgD+4wSRi/S2u0xKhm4xBn7SVgX72CxfQLLH2aeLFjwhDX1nsP8mcYSWWIcg
	4CRGYmpM7VDoL6cIPQ+A2hbJkIjuSASiELwhVksBCEZxaENpP/QCaoSZtXzLj5ondV5TaQ
	FnUUrfcdvHL09Rl/m1SI5gjs7GzXYNNbjjmpJosMjxj8y5zuF51/LeInZo5/jxHALJr/w2
	12bpQ4XoU3BsTBoDSmCEB5wwfNxRrKecbROiZtGX+bSTbBThhhcsFy7oTQcZ2ouqtOztRq
	9h4gILpBFwfVtoI2ldT7tvcm+hWbvtAsSFJv1wVEPnYdN6CRqkrApaqENMQALQ==
From: John Hancock <john@kernel.doghat.io>
To: stable@vger.kernel.org
Cc: bhelgaas@google.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	joro@8bytes.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	John Hancock <john@kernel.doghat.io>
Subject: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for OF platforms"
Date: Fri, 20 Mar 2026 13:23:35 -0400
Message-ID: <20260320172335.29778-1-john@kernel.doghat.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
platforms") introduced a regression affecting AMD IOMMU group isolation
on x86 systems, making PCIe passthrough non-functional.

While the commit addresses a legitimate ordering issue on OF/Device Tree
platforms, the fix modifies pci_dma_configure(), which executes on all
platforms regardless of firmware interface. On AMD systems with IOMMU,
moving pci_enable_acs() from pci_acs_init() to pci_dma_configure() alters
the point at which ACS is evaluated relative to IOMMU group assignment.
The result is that devices which previously occupied individual, exclusive
IOMMU groups are merged into a single group containing both passthrough
and non-passthrough members, violating IOMMU isolation requirements.

The commit author notes that pci_enable_acs() is now called twice per
device and that this is "presumably not an issue." On AMD IOMMU hardware
this assumption does not hold -- the change in call ordering has
observable and breaking consequences for group topology.

It is worth noting that this is a stable/LTS series (6.12.y), where
changes to fundamental PCI initialization ordering carry significant
risk for production and specialized workloads that depend on stable
IOMMU behavior across kernel updates. A regression of this nature --
silently breaking PCIe passthrough without any configuration change on
the part of the user -- is particularly disruptive in a series that
users reasonably expect to be conservative.

This revert restores pci_enable_acs() to pci_acs_init() and marks it
static again, fully restoring correct IOMMU group topology on affected
hardware.

Regression introduced in: 6.12.75
Tested on: 6.12.77 with this revert applied

Hardware:
  CPU:   AMD Ryzen Threadripper 2990WX (family 23h, Zen+)
  IOMMU: AMD-Vi

Bisect:
  6.12.74: GOOD -- IOMMU groups correct, passthrough functional
  6.12.75: BAD  -- IOMMU groups collapsed, passthrough broken
  6.12.76: BAD  -- still broken
  6.12.77: BAD  -- still broken

Fixes: 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF platforms")
Signed-off-by: John Hancock <john@kernel.doghat.io>
---
 drivers/pci/pci-driver.c | 8 --------
 drivers/pci/pci.c        | 8 ++++----
 drivers/pci/pci.h        | 1 -
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9846ab70c..a00a2ce01 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1656,14 +1656,6 @@ static int pci_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(to_pci_dev(dev));
-
 	pci_put_host_bridge_device(bridge);
 
 	if (!ret && !driver->driver_managed_dma) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 040c0be2d..3eb878781 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1072,7 +1072,7 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
@@ -3718,6 +3718,14 @@ bool pci_acs_path_enabled(struct pci_dev *start,
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b9b97ec0f..b1f393a42 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -653,7 +653,6 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_cfg);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);
