Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134196;
	b=czJz4VMscqNhc8LYpzLYSGYwEcI5X7Egtk05eg+X5iA2QbSHn8tptIORT0ZgL8lyuBrZ
	 6AMa+ZlJt3GcprOiyWrCFcIKPcST71AU7cIda6qOpO5ux90kv6/3cxaCawqdotZNRf7wh
	 DNWl+piY5BqLT1H/GtqxplyzJ+S1CN+/IvvaNVuXEht/h9jALhoaFXaIs1C14l9YQGBuM
	 d3kH+geDFgAv8TEDbWe6JwZt3+Z82QRLAKue1EhQUhfVhJjAcsIrdfYn/1iFXiC475mSw
	 WIYGkkOG+O9hXmNHbTnPakYpZBizCNMRG0tbhU0brsru4kmWLdFOjr32GSuL9O3H52g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bhkF1tou9oRGyu4WdSTLg48eRchEDGSlV44uyD0mKCg=;
	b=phmxPO24G8nP/qtrvK7kWLL3W1Zm9BTt/58YaUd9jL4C3WIgkztsrmywEE2X9phPoaVS
	 z21LcART23uOHiR22qasNcA9f+1FLGXWUX4Q+6Uoefw8wTxFXJZhmWmCVspvaPJambXfV
	 7v42nNPD/FmClBXqhfn872x2uEePgBWRbVEwQZc7RFfgBYOM5pQF9ERDruQ/tXyr0aC/4
	 jpW/UGXvT8dAFirHLBHiyviPZ20G82Omxcn89pokqbwAJ6F0gDY2q2KdZSTGv1mi0QGlP
	 XGunXipp2YcgEsUEmPyHI5GjwY8CllNnMasSlSNfL6iauUHck8Rydh12KfX1Ec/44cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U98y02JU;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55541606A336
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 00:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55541606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U98y02JU
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-383435e46f9so210321eec.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 16:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795134195; x=1795738995; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bhkF1tou9oRGyu4WdSTLg48eRchEDGSlV44uyD0mKCg=;
        b=U98y02JUPzWfEyaWiXEg+9KMnDnQIhUYkU05VKm87gzy4ra1hl8nPuCAVlnEPkmPWN
         X22nPXiuxPQHPtfeQSRRbAlJuA3UJkpRjQxINFaRod6JtANgREtszj6iXV6zBo3QK4yY
         evWhdLPFTz5WIpa2QGBYgnaUau0D6vHY3VNWZZ9xH2439+qz9S1RbLL1fcfks1yCYJ7E
         Z/SbvkWPXQ9I/mRtyDPh81TAqKx7FgusO0pzFrDud+WtBOx580PT4SqSapvXoXtGtxAK
         EwccjxX5+8jUUU09jxnovL/+mhUrPEzlDvHCEoZAejbeC29KqfaMNNeuwUFORuoEWvrm
         FJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134195; x=1795738995;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhkF1tou9oRGyu4WdSTLg48eRchEDGSlV44uyD0mKCg=;
        b=j183aVB6dy5390gLR89AsvHmKjrPL35n1CNAV0D7FISvSagpoL9+F9PhtDz0pbMzQb
         7FQyI3ZQmay7H6KT2hnctCJmy01q3XGH9jLw/Wq/FfEGW+zvOfVBMgXkORLELi6qj8Yw
         SD6Z/plIeXjYO8wSRx2uf53AmlxZ8gOeB4z7onMfyndW+tL5uNcI2lu0cmvhslYIpSVE
         sy70XiXiQVcKtRL9r/ui7Y9mb9U/ZgOxegXeExQrA66mVrf0tm7pydxvYdvkIhn9gsrN
         RDcaYD0XkD0EjYDVivOiEkZMmBT3zqPw4Frko20/hWFBW4y918F9tmv7j518y/CyavZT
         efcQ==
X-Forwarded-Encrypted: i=1; AL+hErGH99XkdWVHu4Bq7Gp93/5DseZK99U7vQC9WuXhUMd+d/eR3SNYbW5NInMwAxn2i5KXiD6B8y2W5dU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8F3tTvhXnv4nQBeRrWLdkze1c6RSP/6ry/QTUc+QgDXrceCLgL
	YPxw5HI0xHgZDtZxnwIeiW2tXXg+WFKLSX4NCKRozxho3g4lr7NePim7zs5gli0Y0aBPODO+jWS
	8ezf+9CdKdeDsdQ==
X-Received: from dybqf22.prod.google.com ([2002:a05:7301:6496:b0:382:8cee:3808])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:d509:b0:385:ac93:91f4 with SMTP id 5a478bee46e88-385ac939fc3mr560916eec.26.1795134194715;
 Thu, 19 Nov 2026 16:23:14 -0800 (PST)
Date: Fri, 20 Nov 2026 00:23:10 +0000
In-Reply-To: <20261120002311.394649-1-digonzal@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120002311.394649-1-digonzal@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120002311.394649-2-digonzal@google.com>
Subject: [PATCH v3 1/2] iommu: Track whether pci_dev_reset_iommu_done() needs
 to restore state
From: Danny Gonzalez <digonzal@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, decot@google.com, praan@google.com, 
	sheenamo@google.com, linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_dev_reset_iommu_done() relies on the assumption that
pci_ats_supported() and dev_has_iommu() always return the same values
they returned in pci_dev_reset_iommu_prepare(). While that may be true
today, relying on both calls evaluating identically is fragile: if they
ever return different values, gdev->reset_depth, group->recovery_cnt,
group->domain, and gdev->blocked will get out of sync.

Have pci_dev_reset_iommu_prepare() track whether
pci_dev_reset_iommu_done() needs to restore IOMMU state via a @restore
output flag, and pass @restore to pci_dev_reset_iommu_done() instead of
re-evaluating pci_ats_supported() and dev_has_iommu().

Signed-off-by: Danny Gonzalez <digonzal@google.com>
---

v3:
 - New patch based on review feedback to avoid relying on
   pci_ats_supported() and dev_has_iommu() returning identical values
   across pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done()

 drivers/iommu/iommu.c  | 14 ++++++++++----
 drivers/pci/pci-acpi.c |  5 +++--
 drivers/pci/pci.c      | 25 +++++++++++++++----------
 drivers/pci/quirks.c   |  5 +++--
 include/linux/iommu.h  |  9 +++++----
 5 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fc..8a563eb38bba 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -4010,6 +4010,7 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
 /**
  * pci_dev_reset_iommu_prepare() - Block IOMMU to prepare for a PCI device reset
  * @pdev: PCI device that is going to enter a reset routine
+ * @restore: set to true if pci_dev_reset_iommu_done() needs to restore state
  *
  * The PCIe r6.0, sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and block
  * ATS before initiating a reset. This means that a PCIe device during the reset
@@ -4031,7 +4032,7 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
  * case, callers must ensure there will be no racy iommu_release_device() call,
  * which otherwise would UAF the dev->iommu_group pointer.
  */
-int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
+int pci_dev_reset_iommu_prepare(struct pci_dev *pdev, bool *restore)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
 	struct group_device *gdev;
@@ -4039,8 +4040,12 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 	void *entry;
 	int ret;
 
-	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
+	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev)) {
+		*restore = false;
 		return 0;
+	}
+
+	*restore = true;
 
 	guard(mutex)(&group->mutex);
 
@@ -4132,6 +4137,7 @@ static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
 /**
  * pci_dev_reset_iommu_done() - Restore IOMMU after a PCI device reset is done
  * @pdev: PCI device that has finished a reset routine
+ * @restore: whether pci_dev_reset_iommu_prepare() blocked the IOMMU
  *
  * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
  * activity, including new translation and cache invalidation, by re-attaching
@@ -4143,14 +4149,14 @@ static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
  * Note that, although unlikely, there is a risk that re-attaching domains might
  * fail due to some unexpected happening like OOM.
  */
-void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool restore)
 {
 	struct iommu_group *group = pdev->dev.iommu_group;
 	struct group_device *gdev;
 	unsigned long pasid;
 	void *entry;
 
-	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
+	if (!restore)
 		return;
 
 	guard(mutex)(&group->mutex);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1150f2fbabf4..83a581796001 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -955,6 +955,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+	bool restore;
 	int ret;
 
 	if (!handle || !acpi_has_method(handle, "_RST"))
@@ -963,7 +964,7 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	ret = pci_dev_reset_iommu_prepare(dev);
+	ret = pci_dev_reset_iommu_prepare(dev, &restore);
 	if (ret) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
 		return ret;
@@ -974,7 +975,7 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 		ret = -ENOTTY;
 	}
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, restore);
 	return ret;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..087594cc8095 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4440,6 +4440,7 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
  */
 int pcie_flr(struct pci_dev *dev)
 {
+	bool restore;
 	int ret;
 
 	if (!pci_dev_config_accessible(dev, "FLR"))
@@ -4449,7 +4450,7 @@ int pcie_flr(struct pci_dev *dev)
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
 	/* Have to call it after waiting for pending DMA transaction */
-	ret = pci_dev_reset_iommu_prepare(dev);
+	ret = pci_dev_reset_iommu_prepare(dev, &restore);
 	if (ret) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
 		return ret;
@@ -4469,7 +4470,7 @@ int pcie_flr(struct pci_dev *dev)
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, restore);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
@@ -4498,6 +4499,7 @@ EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
 static int pci_af_flr(struct pci_dev *dev, bool probe)
 {
+	bool restore;
 	int ret;
 	int pos;
 	u8 cap;
@@ -4526,7 +4528,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
 
 	/* Have to call it after waiting for pending DMA transaction */
-	ret = pci_dev_reset_iommu_prepare(dev);
+	ret = pci_dev_reset_iommu_prepare(dev, &restore);
 	if (ret) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
 		return ret;
@@ -4547,7 +4549,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, restore);
 	return ret;
 }
 
@@ -4568,6 +4570,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
  */
 static int pci_pm_reset(struct pci_dev *dev, bool probe)
 {
+	bool restore;
 	u16 csr;
 	int ret;
 
@@ -4584,7 +4587,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	if (dev->current_state != PCI_D0)
 		return -EINVAL;
 
-	ret = pci_dev_reset_iommu_prepare(dev);
+	ret = pci_dev_reset_iommu_prepare(dev, &restore);
 	if (ret) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
 		return ret;
@@ -4601,7 +4604,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_dev_d3_sleep(dev);
 
 	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, restore);
 	return ret;
 }
 
@@ -5033,6 +5036,7 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	bool restore;
 	int rc;
 
 	/*
@@ -5042,7 +5046,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge))
 		return -ENOTTY;
 
-	rc = pci_dev_reset_iommu_prepare(dev);
+	rc = pci_dev_reset_iommu_prepare(dev, &restore);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
 		return rc;
@@ -5054,7 +5058,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, restore);
 	return rc;
 }
 
@@ -5062,6 +5066,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
+	bool restore;
 	int rc;
 
 	bridge = pci_upstream_bridge(dev);
@@ -5079,7 +5084,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
-	rc = pci_dev_reset_iommu_prepare(dev);
+	rc = pci_dev_reset_iommu_prepare(dev, &restore);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
 		return rc;
@@ -5099,7 +5104,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, restore);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..f6b26467c9e0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4404,16 +4404,17 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 				    const struct pci_dev_reset_methods *i)
 {
+	bool restore;
 	int ret;
 
-	ret = pci_dev_reset_iommu_prepare(dev);
+	ret = pci_dev_reset_iommu_prepare(dev, &restore);
 	if (ret) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
 		return ret;
 	}
 
 	ret = i->reset(dev, probe);
-	pci_dev_reset_iommu_done(dev);
+	pci_dev_reset_iommu_done(dev, restore);
 	return ret;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a36..7d6e27d0d918 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1223,8 +1223,8 @@ ioasid_t iommu_alloc_global_pasid(struct device *dev);
 void iommu_free_global_pasid(ioasid_t pasid);
 
 /* PCI device reset functions */
-int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
-void pci_dev_reset_iommu_done(struct pci_dev *pdev);
+int pci_dev_reset_iommu_prepare(struct pci_dev *pdev, bool *restore);
+void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool restore);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1549,12 +1549,13 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
 
 static inline void iommu_free_global_pasid(ioasid_t pasid) {}
 
-static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
+static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev, bool *restore)
 {
+	*restore = false;
 	return 0;
 }
 
-static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
+static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev, bool restore)
 {
 }
 #endif /* CONFIG_IOMMU_API */
-- 
2.56.1.708.g77570a6a1d-goog

