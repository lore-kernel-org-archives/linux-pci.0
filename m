Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024E3E315D
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368761; cv=none; b=JsYL4Wu4ULBdOx/nQi1UylJUPag1HrjDfiUo8Ks5lZArpiIiTYZtmnVH8JV554u0r+Wl9qC/S47YydrVma7IvVNwFJX9hSt68KjeeTmwbazH4NIEbum9ltUCTtmFFYxMDlm2qFQV+RmqgNaxuy0N53tEZGdV9Ujo+bRs/dieu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368761; c=relaxed/simple;
	bh=b8pRn23RIMal8eW52bBYdCxQqfFzDolmVXBA4e2ewzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBAkA5VuDyycaJWJdo0xRvu2vttCa2Miox1I4tM29vohtx8Lp0e3zJfGvcNq5X0+E78WfaAfE6lUVzhI2kxLuQ4IsYKJDS2Vxoq8QMR9MkyK0+D1A9Yyl0iOnbcAWimDNWxo5Cg4trpErKy4aipe5rRioF3MJg+IVPrpbn9L+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFtBXdNH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFtBXdNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779368759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBFMujtl0p7k3wA9Yk/Cxx1BZvoq2/hNjnnDHqqWmXI=;
	b=ZFtBXdNH3nr2V1383iuM2mWG+QrER+Tfl14P9mvn+x7R8bcxvW9QQ3R7iF7TO3uWWOMmOs
	FEQg97ZAoaF7M15pHGG/CNk1+60ig+2Fv3rS9MOzL8rDPKXspaZBmVeONirXABEfycd0FC
	/1GBXRsDMIXUrzvnCOuyUJSmvN/Lo58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-F765ixPrMxe3m8sXUEyeAQ-1; Thu,
 21 May 2026 09:05:54 -0400
X-MC-Unique: F765ixPrMxe3m8sXUEyeAQ-1
X-Mimecast-MFC-AGG-ID: F765ixPrMxe3m8sXUEyeAQ_1779368752
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F284F1956052;
	Thu, 21 May 2026 13:05:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1AE31800465;
	Thu, 21 May 2026 13:05:49 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v5 2/3] PCI: Add device-specific reset for Qualcomm devices
Date: Thu, 21 May 2026 15:05:11 +0200
Message-ID: <20260521130512.515125-3-jtornosm@redhat.com>
In-Reply-To: <20260521130512.515125-1-jtornosm@redhat.com>
References: <20260521130512.515125-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some Qualcomm PCIe devices (ath11k WiFi, ath12k WiFi, SDX62/SDX65 modems)
lack working reset methods for VFIO passthrough scenarios. These devices
have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
broken bus reset.

The problem manifests in VFIO passthrough scenarios:

- ath11k WiFi (17cb:1103): Normal VM operation works fine, including
  clean shutdown/reboot. However, when the VM terminates uncleanly
  (crash, force-off), VFIO attempts to reset the device before it can
  be assigned to another VM. Without a working reset method, the device
  remains in an undefined state, preventing reuse.

- ath12k WiFi (17cb:1107): Same behavior as ath11k.

- SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
  on first VM assignment without proper reset capability.

Add device-specific reset entries for these Qualcomm devices using D3cold
power cycling with automatic D3hot fallback. The implementation uses
pci_set_power_state(D3cold) which automatically falls back to D3hot on
platforms without ACPI _PR3 power resources.

Extract a shared pci_dev_d3cold_d0_cycle() helper function to avoid code
duplication between pci_d3cold_reset() (strict _PR3 requirement) and the
new reset_d3cold_d3hot() device-specific reset (automaticfallback). The
helper handles IOMMU preparation, performs the power cycle via
pci_set_power_state(), and cleans up IOMMU state.

Device-specific reset is position #1 in the reset hierarchy, so these
Qualcomm devices will use power cycling as their primary reset method,
with the general d3cold method (position #8) available as a fallback on
_PR3-capable platforms if users override via sysfs.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v5: Follow the advice from Alex Williamson, replace v4's general "soft"
    reset method (patch 2/3) as too broad by a device-specific reset using
    pci_dev_reset_methods[]
v4: https://lore.kernel.org/all/20260518124836.460805-3-jtornosm@redhat.com/

 drivers/pci/pci.c    | 55 ++++++++++++++++++++++++++++----------------
 drivers/pci/pci.h    |  1 +
 drivers/pci/quirks.c | 19 +++++++++++++++
 3 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 096868f80cd4..3677aaf8d160 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4491,6 +4491,40 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	return ret;
 }
 
+/**
+ * pci_dev_d3cold_d0_cycle - Perform D3cold->D0 power cycle
+ * @dev: Device to power cycle
+ *
+ * Common helper to perform D3cold->D0 power cycle for reset methods.
+ * Attempts D3cold transition with automatic fallback to D3hot on platforms
+ * without ACPI _PR3 power resources. Handles IOMMU preparation and cleanup.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int pci_dev_d3cold_d0_cycle(struct pci_dev *dev)
+{
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
+	ret = pci_set_power_state(dev, PCI_D3cold);
+	if (ret)
+		goto done;
+
+	ret = pci_set_power_state(dev, PCI_D0);
+
+done:
+	pci_dev_reset_iommu_done(dev);
+	return ret;
+}
+
 /**
  * pci_d3cold_reset - Put device into D3cold and back to D0 for reset
  * @dev: PCI device to reset
@@ -4509,8 +4543,6 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
  */
 static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
 {
-	int ret;
-
 	if (dev->multifunction)
 		return -ENOTTY;
 
@@ -4520,24 +4552,7 @@ static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
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
-	ret = pci_set_power_state(dev, PCI_D3cold);
-	if (ret)
-		goto done;
-
-	ret = pci_set_power_state(dev, PCI_D0);
-
-done:
-	pci_dev_reset_iommu_done(dev);
-	return ret;
+	return pci_dev_d3cold_d0_cycle(dev);
 }
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..a9942787de9e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -234,6 +234,7 @@ void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
+int pci_dev_d3cold_d0_cycle(struct pci_dev *dev);
 
 struct pci_cap_saved_data {
 	u16		cap_nr;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e49136ac5dbf..70f3b0f26799 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4237,6 +4237,22 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	return 0;
 }
 
+/*
+ * Device-specific reset method via D3cold/D3hot power cycle.
+ *
+ * Some devices lack working FLR, advertise NoSoftRst+ (blocking PM reset),
+ * and have broken bus reset. This function provides device-specific reset via
+ * power cycling, attempting D3cold with automatic fallback to D3hot on platforms
+ * without ACPI _PR3 power resources.
+ */
+static int reset_d3cold_d3hot(struct pci_dev *dev, bool probe)
+{
+	if (probe)
+		return 0;
+
+	return pci_dev_d3cold_d0_cycle(dev);
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -4252,6 +4268,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_chelsio_generic_dev },
 	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
 		reset_hinic_vf_dev },
+	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_d3cold_d3hot },  /* ath11k */
+	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_d3cold_d3hot },  /* ath12k */
+	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_d3cold_d3hot },  /* SDX62/SDX65 */
 	{ 0 }
 };
 
-- 
2.54.0

