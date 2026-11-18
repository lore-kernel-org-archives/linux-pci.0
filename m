Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030141;
	b=ehlUyZmAEgKj3GUG8ArdVQIW9SMSd1LDum3pFhEZgRHnXxroQV3xNv4XH4Jp8GX3emXb
	 BQ44VKxKxinylH7O+NhsPq38YVYLGNLHDtshGwlJiV/7FLvAeU1jKo0JAQeGjiDYaNs6M
	 oZEDVQKhosS0XRUkTgnSebSZxfsIppQzUH/0XhWPSiiiomjvPdfvFHn5gvYvZWYl9+kAN
	 5Sdi5l+u0wh6Tv5eNjGU25GaTq0jmKShrGYNzmmAid8Z3PM4KDW0/5Mt67pv3w4XpW2jq
	 6qz7atjE8bJERI1eCAJ6vya4wmpR2BKw2Frje1rL+QuTGU1rn9g0yWhzx5TZwiqBTng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030141;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding;
	bh=S1lNzkiO6o4LausFVoazoovvosWrAl7cb3L0/hfy7Nw=;
	b=gAcVFRz/mne9wtS1u5T4zuV6PqG2gWgM3aBuaxKVhTsjsVFvPvHbcLoPCP52vdjIBYdU
	 9WHA5WKgNNe/1vFWP+f9YT9MFWNx16H9LHSoQgMtatSYSLxhYonqpv0rsTkCq/ncrJIGZ
	 EQF300dh59uSwEfJFy7c05HL6JX+eOV6NaBFfXhFjhmJesZWmj3VIGz8NutlfddjHE3RG
	 3emjBswG9MPPWFIAqfvVDbLCMPjYQazjaoBk0QA2YLk2ElvuDlytOwos9RlecsxdrxUTC
	 +tsGyPmfmMU9dr2KsZj25/VJK/kfybyQHzVLPkdhEV7CtkG2/lcJBcpT4FianKJUUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikxGeUA8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2960760BD;
	Wed, 18 Nov 2026 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikxGeUA8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117601F000C6;
	Wed, 18 Nov 2026 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030140;
	bh=S1lNzkiO6o4LausFVoazoovvosWrAl7cb3L0/hfy7Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ikxGeUA8dvLFbEJXQIvvte+w88nOTJond/jB7u2/RVGkk2omK1tilcywzAn3Atf80
	 OmBakMOp8kMobsRoJHAZZghuesXgdMGgkG5ryBt3oVGV6gh1zCeSGrCkbVzueLM3Ev
	 qLztC9gMNtPdpuzJi3QJX2oE5lwmb3OYltbt/sq9xdFtMSBtLfnVsdzzp7InoxRLym
	 QKOXD2pnOhOVvKk5492wqMo77OAmjaDKSgx4WXOX7wRgGqpglhRK8EwQDgYNwn6Ojn
	 W4iVhKQWxeap1mSHalyNaDvZlIQxRSZzds8gd0AWEygzKYbEHPrpTO0f+QewCmKKYt
	 B9HyMJ/S1QmEg==
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Mans Rullgard <mans@mansr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Cornelia Huck <cornelia.huck@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Alexey Kardashevskiy <aik@amd.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-sound@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 27/31] iommu: Use device trust for DMA restrictions
Date: Wed, 18 Nov 2026 21:26:57 +0200
Message-ID: <20261118-device-trust-core-v3-27-d655875c4bfb@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

PCI-specific untrusted checks exclude devices classified as adversaries
through generic policy. Their DMA protections should depend on the selected
trust policy rather than the source of that classification.

Use policy for early domain selection and active trust for DMA bouncing.
This removes the remaining need for PCI's duplicate untrusted flag.
Changes to IOMMU domains after authorization remain separate work.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/amd/iommu.c   |  3 +--
 drivers/iommu/dma-iommu.c   | 14 +++++---------
 drivers/iommu/intel/iommu.c | 14 +++++---------
 drivers/iommu/iommu.c       |  9 +++++----
 drivers/pci/probe.c         |  1 -
 include/linux/pci.h         |  8 --------
 6 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec69..e358bbb1f2baa 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3401,8 +3401,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	if (!dev_is_pci(dev))
 		return 0;
 
-	/* Always use DMA domain for untrusted device */
-	if (to_pci_dev(dev)->untrusted)
+	if (pci_dev_default_is_restricted(to_pci_dev(dev)))
 		return IOMMU_DOMAIN_DMA;
 
 	/* Apply device specific quirks */
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932d..a48fb511bfe6f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -589,16 +589,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
-static bool dev_is_untrusted(struct device *dev)
-{
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
-}
-
 static bool dev_use_swiotlb(struct device *dev, size_t size,
 			    enum dma_data_direction dir)
 {
 	return IS_ENABLED(CONFIG_SWIOTLB) &&
-		(dev_is_untrusted(dev) ||
+		(device_is_adversarial(dev) ||
 		 dma_kmalloc_needs_bounce(dev, size, dir));
 }
 
@@ -611,7 +606,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	if (!IS_ENABLED(CONFIG_SWIOTLB))
 		return false;
 
-	if (dev_is_untrusted(dev))
+	if (device_is_adversarial(dev))
 		return true;
 
 	/*
@@ -1189,7 +1184,8 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
 	 * the contents of the original memory buffer.
 	 */
-	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
+	if (phys != (phys_addr_t)DMA_MAPPING_ERROR &&
+	    device_is_adversarial(dev)) {
 		size_t start, virt = (size_t)phys_to_virt(phys);
 
 		/* Pre-padding */
@@ -1790,7 +1786,7 @@ size_t iommu_dma_max_opt_mapping_size(void)
 
 size_t iommu_dma_max_mapping_size(struct device *dev)
 {
-	if (dev_is_untrusted(dev))
+	if (device_is_adversarial(dev))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e0..0202b491f222e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2624,8 +2624,8 @@ static void __init platform_optin_force_iommu(void)
 		return;
 
 	/*
-	 * If Intel-IOMMU is disabled by default, we will apply identity
-	 * map for all devices except those marked as being untrusted.
+	 * If Intel-IOMMU is disabled by default, an external device could
+	 * otherwise receive an identity map despite its adversarial policy.
 	 */
 	if (dmar_policy_off()) {
 		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
@@ -3629,16 +3629,12 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
 	return translation_pre_enabled(info->iommu) && !info->domain;
 }
 
-/*
- * Check that the device does not live on an external facing PCI port that is
- * marked as untrusted. Such devices should not be able to apply quirks and
- * thus not be able to bypass the IOMMU restrictions.
- */
+/* Bypass quirks must not prevent later adversarial operation. */
 static bool risky_device(struct pci_dev *pdev)
 {
-	if (pdev->untrusted) {
+	if (pci_dev_default_is_restricted(pdev)) {
 		pci_info(pdev,
-			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
+			 "Skipping IOMMU quirk due to trust policy [%04X:%04X]\n",
 			 pdev->vendor, pdev->device);
 		pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
 		return true;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..891b0cd2dad02 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1901,10 +1901,11 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		driver_type = iommu_get_def_domain_type(group, gdev->dev,
 							driver_type);
 
-		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
+		if (dev_is_pci(gdev->dev) &&
+		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
 			/*
-			 * No ARM32 using systems will set untrusted, it cannot
-			 * work.
+			 * No ARM32 using systems select a restricted trust
+			 * policy; it cannot work.
 			 */
 			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
 				return -1;
@@ -1928,7 +1929,7 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
 			dev_err_ratelimited(
 				untrusted,
-				"Device is not trusted, but driver is overriding group %u to %s, refusing to probe.\n",
+				"Device trust policy restricts DMA, but driver is overriding group %u to %s, refusing to probe.\n",
 				group->id, iommu_domain_type_str(driver_type));
 			return -1;
 		}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9aa69d19ceab4..40b449b8e736c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2080,7 +2080,6 @@ int pci_setup_device(struct pci_dev *dev)
 	set_pcie_cxl(dev);
 
 	pci_set_default_trust_policy(dev);
-	dev->untrusted = device_policy_is_adversarial(&dev->dev);
 	device_trust_init(&dev->dev);
 
 	/* "Unknown power state" */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d8edf8403a5ad..17612cb18385e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -490,14 +490,6 @@ struct pci_dev {
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
-	/*
-	 * Devices marked being untrusted are the ones that can potentially
-	 * execute DMA attacks and similar. They are typically connected
-	 * through external ports such as Thunderbolt but not limited to
-	 * that. When an IOMMU is enabled they should be getting full
-	 * mappings to make sure they cannot access arbitrary memory.
-	 */
-	unsigned int	untrusted:1;
 	/*
 	 * Info from the platform, e.g., ACPI or device tree, may mark a
 	 * device as "external-facing".  An external-facing device is

-- 
2.56.1

