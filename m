Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FB43DA46
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108535; cv=none; b=CJ905dI0ZfL56HcntYlB87jB3rkOhzakwZJ7lDaafbugu9ckxhCFLugMm0rGG38G1BGzy2SuZgMSDnvR2nPg3uFiSRElwhIpFCb/DSiMnCqIeMPuz9Dn4RwnmwiN+ZsFVtdd4g9rcnwvHmQX5kSAlNnCZtjQWuPi9pHMbAFfA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108535; c=relaxed/simple;
	bh=lgomjevE6L8ROHcIL0ZW348lJl5Cm6rGy50dkWZx6LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbdnljOJo1B5FFbB9w9fYS0/kWZBtR4gVow0xhCBRHZO065SVvtocKTFIj62eHfHjCpNjjoqDgMfekX8x1d89Z0+ElscQSt17VoTFtIPH9pzHlUji+zd0iPPJ8Gb780k0W9gmbfjPqZFupyyHH0qHts2OYgElYEAfa+WrcHLQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edoJINvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edoJINvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779108533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC9H6hmJXtSXL1EjWfLGQfbsnaDczL2sh7s4JzF3p5E=;
	b=edoJINvrYGq42TQzbQXoOUEFJ5neAXznv5tQ0vykWjvAdSUWQqSaW1iMQx+SHDO1GF5Dim
	J8j070Q8wnj/WOIcXWaimyvNWuRpVUj/qd4kgZvnXLwVZKOjZGFGDpgNpQmMSEFu+dwPHM
	7Zad0/N61tZbnpNIXphSPHvWZd6AIGw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-nUrOlvLROu-xBv6q9WHtdQ-1; Mon,
 18 May 2026 08:48:51 -0400
X-MC-Unique: nUrOlvLROu-xBv6q9WHtdQ-1
X-Mimecast-MFC-AGG-ID: nUrOlvLROu-xBv6q9WHtdQ_1779108530
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9054919560A5;
	Mon, 18 May 2026 12:48:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.67])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D50D41956053;
	Mon, 18 May 2026 12:48:48 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: bhelgaas@google.com,
	alex@shazbot.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v4 1/3] PCI: Add d3cold as general reset method
Date: Mon, 18 May 2026 14:48:33 +0200
Message-ID: <20260518124836.460805-2-jtornosm@redhat.com>
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

Add D3cold power cycle as a general PCI reset method for single-function
devices on platforms with ACPI _PR3 power resources. This provides true
power cycle reset capability when the platform can physically cut power
to the device.

The implementation strictly requires _PR3 to be present - the platform
must be able to control device power. This ensures d3cold only attempts
true power cycling, not falling back to D3hot transitions.

D3cold reset is placed at the end of the reset hierarchy since it requires
specific platform support and should be tried after standard methods.

Reset hierarchy with this change:
1. device_specific
2. acpi
3. flr
4. af_flr
5. pm (D3hot via config space, checks NoSoftRst)
6. bus (SBR)
7. cxl_bus
8. d3cold (NEW - true power cycle, requires _PR3)

This benefits:
- Platforms with _PR3 support
- Single-function devices needing true power cycle
- VFIO passthrough scenarios where FLR/PM unavailable

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v4: Strict _PR3 requirement - no D3hot fallback (Alex Williamson and Lukas
    Wunner feedback)
v3: https://lore.kernel.org/all/20260513122349.268753-1-jtornosm@redhat.com/ 

 drivers/pci/pci.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..839903b59698 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4491,6 +4491,45 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	return ret;
 }
 
+/**
+ * pci_d3cold_reset - Put device into D3cold and back to D0 for reset
+ * @dev: PCI device to reset
+ * @probe: if true, check if D3cold reset is supported; if false, perform reset
+ *
+ * Reset the device by transitioning through D3cold (actual power removal via
+ * platform power control) and back to D0. This requires ACPI _PR3 power
+ * resources to be present - the platform must be able to physically cut power
+ * to the device.
+ *
+ * Only available for single-function devices to avoid affecting other
+ * functions in multi-function devices.
+ *
+ * Returns 0 if device can be/was reset this way, -ENOTTY if not supported,
+ * or other negative error code on failure.
+ */
+static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
+{
+	int ret;
+
+	if (dev->multifunction)
+		return -ENOTTY;
+
+	if (!pci_pr3_present(dev))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (dev->current_state != PCI_D0)
+		return -EINVAL;
+
+	ret = pci_set_power_state(dev, PCI_D3cold);
+	if (ret)
+		return ret;
+
+	return pci_set_power_state(dev, PCI_D0);
+}
+
 /**
  * pcie_wait_for_link_status - Wait for link status change
  * @pdev: Device whose link to wait for.
@@ -5065,6 +5104,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
+	{ pci_d3cold_reset, .name = "d3cold" },
 };
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..1ca7b880ead7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.54.0

