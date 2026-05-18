Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6143E4A6
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108543; cv=none; b=E3RSF5x7+jBGJ+jy+aw3a9wIamjoPqRXOHkswH3QQ1Q6xAQcH4lgk1WlEG1WB2xOZWWf7R0tsm4b+t1l7UQ8nrnMRE6jmCUH/9OSiCkMQ+A7k/wy813pSf+P8lobI1NEjzqbwTrHzoGYJ/JPM0mOCUJ77c3jpMMMIcneOAJJYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108543; c=relaxed/simple;
	bh=rby+73+cUIFF45Yy4+4sJj/VKGN2sld7inrgKP1qXXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYasz4SqewNJCqepElBr2lOCZUs1yY/2Ng4/LisE0NK508YXLmgklptiUZeDfXrRe+SwsWGaBjFHbx1Ae052TyoukgyG1aaOzZCRwjO6KeSA+N9zi3hhIglAE8Y2Y7t7+27p16q8csOikX7LpIbWfQMfxk6HwMHj+y2uwMd65D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=andy7kP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="andy7kP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779108540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HT6CsAUGxnMxOVK3tfRIcyDObTP/vMh+7IVsuXA8VWw=;
	b=andy7kP3ZKHDK0630yWtZ1yX4tqAWZU/vPGs5BSXSKJfFz+NNWkgyjeoOP7REdYD/iNhWe
	XmyeHPm9bP02PCf9AWcMkf3Sj4CENq6kOyrs4aOaoxEtCEmxYBirVbWZY2MmvXalSSjSbX
	NhbBbi1s0YKqbaSn+uimYohUVL+8gQc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-jn_yXxFaNweutnvQ6znYoA-1; Mon,
 18 May 2026 08:48:55 -0400
X-MC-Unique: jn_yXxFaNweutnvQ6znYoA-1
X-Mimecast-MFC-AGG-ID: jn_yXxFaNweutnvQ6znYoA_1779108534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 773321956089;
	Mon, 18 May 2026 12:48:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B4581956053;
	Mon, 18 May 2026 12:48:52 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v4 2/3] PCI: Add soft reset method as last resort
Date: Mon, 18 May 2026 14:48:34 +0200
Message-ID: <20260518124836.460805-3-jtornosm@redhat.com>
In-Reply-To: <20260518124836.460805-1-jtornosm@redhat.com>
References: <20260518124836.460805-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a software-initiated "soft" reset method that attempts D3hot->D0
transition as an absolute last resort when all other reset methods
have failed.

Some devices incorrectly advertise NoSoftRst+ (blocking PM reset) but
the D3hot transition does provide sufficient reset for certain use cases,
particularly VFIO passthrough scenarios. This method provides a "better
than nothing" option when the device would otherwise have no reset
capability.

The method only becomes available when:
- pci_pm_reset() is unavailable (typically blocked by NoSoftRst+)
- pci_d3cold_reset() is unavailable (no platform _PR3 support)
- Device has PM capability (required for D3hot transition)

Extract the D3hot transition logic into a shared helper function
(pci_do_d3hot_transition) used by both pci_pm_reset and pci_soft_reset.

Reset hierarchy with this change:
1. device_specific
2. acpi
3. flr
4. af_flr
5. pm (proper method, checks NoSoftRst)
6. bus
7. cxl_bus
8. d3cold (requires _PR3)
9. soft (NEW - D3hot without NoSoftRst check, absolute last resort)

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4: Implements D3hot transition as last resort when pm/d3cold unavailable
v3: https://lore.kernel.org/all/20260513122349.268753-1-jtornosm@redhat.com/

 drivers/pci/pci.c   | 98 ++++++++++++++++++++++++++++++++++-----------
 include/linux/pci.h |  2 +-
 2 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 839903b59698..8dad386bd65d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4437,6 +4437,43 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	return ret;
 }
 
+/**
+ * pci_do_d3hot_transition - Perform D3hot->D0 power state transition
+ * @dev: Device to transition
+ *
+ * Common helper to perform D3hot->D0 transition for PM-based reset methods.
+ * Handles IOMMU preparation, state transition, and waiting for device ready.
+ */
+static int pci_do_d3hot_transition(struct pci_dev *dev)
+{
+	u16 csr;
+	int ret;
+
+	if (dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	ret = pci_dev_reset_iommu_prepare(dev);
+	if (ret) {
+		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
+		return ret;
+	}
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
+	csr &= ~PCI_PM_CTRL_STATE_MASK;
+	csr |= PCI_D3hot;
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	pci_dev_d3_sleep(dev);
+
+	csr &= ~PCI_PM_CTRL_STATE_MASK;
+	csr |= PCI_D0;
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
+	pci_dev_d3_sleep(dev);
+
+	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	pci_dev_reset_iommu_done(dev);
+	return ret;
+}
+
 /**
  * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
  * @dev: Device to reset.
@@ -4455,7 +4492,6 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 static int pci_pm_reset(struct pci_dev *dev, bool probe)
 {
 	u16 csr;
-	int ret;
 
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
 		return -ENOTTY;
@@ -4467,28 +4503,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	if (probe)
 		return 0;
 
-	if (dev->current_state != PCI_D0)
-		return -EINVAL;
-
-	ret = pci_dev_reset_iommu_prepare(dev);
-	if (ret) {
-		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
-		return ret;
-	}
-
-	csr &= ~PCI_PM_CTRL_STATE_MASK;
-	csr |= PCI_D3hot;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	pci_dev_d3_sleep(dev);
-
-	csr &= ~PCI_PM_CTRL_STATE_MASK;
-	csr |= PCI_D0;
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	pci_dev_d3_sleep(dev);
-
-	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
-	pci_dev_reset_iommu_done(dev);
-	return ret;
+	return pci_do_d3hot_transition(dev);
 }
 
 /**
@@ -4530,6 +4545,42 @@ static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
 	return pci_set_power_state(dev, PCI_D0);
 }
 
+/**
+ * pci_soft_reset - Software-initiated reset via D3hot as last resort
+ * @dev: PCI device to reset
+ * @probe: if true, check if soft reset is supported; if false, perform reset
+ *
+ * Attempt a software-initiated reset via D3hot->D0 transition as an absolute
+ * last resort when all other reset methods have failed. This method only
+ * becomes available if the device has PM capability, pci_pm_reset() is blocked
+ * (typically by NoSoftRst+), and pci_d3cold_reset() is not available.
+ *
+ * Some devices incorrectly advertise NoSoftRst+ but D3hot transition does
+ * provide sufficient reset for certain use cases (e.g., VFIO passthrough).
+ * This method provides a "better than nothing" option when the device would
+ * otherwise have no reset capability.
+ *
+ * Returns 0 if device can be/was reset this way, -ENOTTY if a better reset
+ * method is available (pm or d3cold) or device lacks PM capability, or other
+ * negative error code on failure.
+ */
+static int pci_soft_reset(struct pci_dev *dev, bool probe)
+{
+	if (pci_pm_reset(dev, true) == 0)
+		return -ENOTTY;
+
+	if (pci_d3cold_reset(dev, true) == 0)
+		return -ENOTTY;
+
+	if (!dev->pm_cap)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return pci_do_d3hot_transition(dev);
+}
+
 /**
  * pcie_wait_for_link_status - Wait for link status change
  * @pdev: Device whose link to wait for.
@@ -5105,6 +5156,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
 	{ pci_d3cold_reset, .name = "d3cold" },
+	{ pci_soft_reset, .name = "soft" },
 };
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1ca7b880ead7..bcd2987b868b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 9
+#define PCI_NUM_RESET_METHODS 10
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.54.0

