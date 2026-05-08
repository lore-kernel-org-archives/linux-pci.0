Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F63806C2
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251932; cv=none; b=jyQstyav/FW9Er5M2HUWtJJeRBkNeDfc9zr55RD12SbrZWAccisG+Cz5yYywXE8rPdpNSqI44LP9jJ47bEWkGK7RPmaf8/pT530gv4+RRR0iqHyT0FXhNqFHZzzJNhOnkyHkwKhCd6enDuUMqK+73imKq1wCaAqzhVgtiI/R51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251932; c=relaxed/simple;
	bh=pJCA9U+rJLJPYURxfMxrF+XxPu4yUK9JnTij5+B2Zf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfbFiSMiZIDx9iR2vf1x/IWgYQccXTW4TQ2H3r20pP+hoKNS64fmkhRmcWnWc/lft+HwNUDQYrsHrpwSSHoBN4R6mbw0vb2QBQjWu43eK3D68Gh8Fh7R29TFWZNku3+9nVABivrLKa7TOMSM943YoX4FElk3wAXi47thIGkAdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHcFWsTb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHcFWsTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778251930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFhF5uwsufQ9HDpsG0OCXCapUZmNuibSXoWCZgY3ix0=;
	b=SHcFWsTbCYzPhO69wz9PIZwizbd82aL/ODr4kClk8t+czCPTMalRz8kpC7txraGzcFcBsb
	3eGkemwf8DJ1cXeYd+uKvFQioqFhOdepkCYMZsotM0BwRbFN71ZUTgGbQibijEkheo2k6U
	G5kHUX0wx0BrrWjL2KFd1o68HveTIog=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-pGy95q49Nh6a_7qeVa0Eyw-1; Fri,
 08 May 2026 10:52:05 -0400
X-MC-Unique: pGy95q49Nh6a_7qeVa0Eyw-1
X-Mimecast-MFC-AGG-ID: pGy95q49Nh6a_7qeVa0Eyw_1778251924
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28A55195608A;
	Fri,  8 May 2026 14:52:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D52C93002D30;
	Fri,  8 May 2026 14:52:01 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2] PCI: Force PM reset for Qualcomm devices with NoSoftRst+
Date: Fri,  8 May 2026 16:51:53 +0200
Message-ID: <20260508145153.717641-2-jtornosm@redhat.com>
In-Reply-To: <20260508145153.717641-1-jtornosm@redhat.com>
References: <20260508145153.717641-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Some Qualcomm PCIe devices lack FLR capability and have the NoSoftRst+
flag set in their PM capability. This causes all standard PCI reset
methods to return -ENOTTY, leaving the device without any reset capability.

Add PCI_DEV_FLAGS_FORCE_PM_RESET flag to bypass the NoSoftRst check and
allow PM reset to proceed with the standard D3hot->D0 transition. This
provides these devices with a working reset method.

Apply this quirk to Qualcomm devices that need PM reset:
- ath11k WiFi (17cb:1103) - No FLR, NoSoftRst+, needs reset for reuse
- ath12k WiFi (17cb:1107) - No FLR, NoSoftRst+, needs reset for reuse
- SDX62/SDX65 5G modems (17cb:0308) - No FLR, NoSoftRst+, never initialize
  without proper reset (both modem generations share the same PCI device ID)

The problem manifests in VFIO passthrough scenarios:

1. WiFi devices (ath11k, ath12k): Normal VM operation works fine,
   including clean shutdown/reboot. However, when the VM terminates
   uncleanly (crash, force-off), VFIO attempts to reset the device.
   Without a working reset method, the device cannot be reused for
   another VM, preventing device reassignment.

2. Modem devices (SDX62/SDX65): Never successfully initialize even on
   first VM assignment without proper reset capability.

Testing showed that without this quirk, no reset is performed during
VFIO device initialization. With this quirk, PM reset succeeds and
devices work reliably in VFIO passthrough scenarios.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2:
  - Split from original combined patch based on maintainer feedback (Alex
    Williamson) and commented results.
  - Change approach: instead of custom D3cold reset method, enable existing
    pci_pm_reset() by bypassing NoSoftRst check for affected devices
    (PCI_DEV_FLAGS_FORCE_PM_RESET flag is added for that)
v1: https://lore.kernel.org/all/20260507142916.392983-1-jtornosm@redhat.com/

 drivers/pci/pci.c    | 12 +++++++++---
 drivers/pci/quirks.c | 13 +++++++++++++
 include/linux/pci.h  |  2 ++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..e0b32eccfcf4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4451,6 +4451,10 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
  * cooldown period, which for the D0->D3hot and D3hot->D0 transitions is 10 ms
  * by default (i.e. unless the @dev's d3hot_delay field has a different value).
  * Moreover, only devices in D0 can be reset by this function.
+ *
+ * Some devices incorrectly advertise PCI_PM_CTRL_NO_SOFT_RESET but PM reset
+ * actually works. For such devices, PCI_DEV_FLAGS_FORCE_PM_RESET can be set
+ * via quirk to bypass the NO_SOFT_RESET check and enable PM reset.
  */
 static int pci_pm_reset(struct pci_dev *dev, bool probe)
 {
@@ -4460,9 +4464,11 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
 		return -ENOTTY;
 
-	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
-	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
-		return -ENOTTY;
+	if (!(dev->dev_flags & PCI_DEV_FLAGS_FORCE_PM_RESET)) {
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
+		if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
+			return -ENOTTY;
+	}
 
 	if (probe)
 		return 0;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..5e8b310c9d5f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5595,6 +5595,19 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 
+/*
+ * Some devices incorrectly advertise NoSoftRst+ (suggesting PM reset won't
+ * work), but PM reset via D3hot->D0 transition actually works fine. Force
+ * PM reset for these devices to provide working reset capability.
+ */
+static void quirk_force_pm_reset(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_FORCE_PM_RESET;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1103, quirk_force_pm_reset); /* ath11k */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1107, quirk_force_pm_reset); /* ath12k */
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0308, quirk_force_pm_reset); /* SDX62/SDX65 */
+
 /*
  * FLR may cause the following to devices to hang:
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..714dbdaa21af 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -261,6 +261,8 @@ enum pci_dev_flags {
 	 * integrated with the downstream devices and doesn't use real PCI.
 	 */
 	PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS = (__force pci_dev_flags_t) (1 << 14),
+	/* Force PM reset even when NoSoftRst+ is set */
+	PCI_DEV_FLAGS_FORCE_PM_RESET = (__force pci_dev_flags_t) (1 << 15),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.53.0

