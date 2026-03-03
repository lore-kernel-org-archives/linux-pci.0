Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A5219A8D
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496070; cv=none; b=VRJ9S2GKV/gb6E0wk8x4KrRA/QoXl7yC+gPcrKaEJadBJG0h8yCpT6Z2ylduIfoIT8ap+Y3gIXIfeD2YDSKaaD8+Ot1MscrRuUELOk0DJxDeHzp5POS2xOKF8CuEmnfOMLXvgKXd1af9q2GD0FDpdrhn+Q5xamwDkOLBwvUi/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496070; c=relaxed/simple;
	bh=+yt/IRC9EAMMhfa2JroCdoqjaMHHXvgbADaOftB5zes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db0JCZxb1RGL55CBbRclHBI5AfadyFdihFe1YPGXJnmoSHcYn3Tp/+2Qlmr2Q2O1MIchOLA4MXNm5gFc2Zm6rbgzHueJJ8kl0DsUzFMxx8aQzodr4qEcRF39cCnn6pxTtmRxJXSs5qoHjR4ByYXj2dA3ULMrLQltfUGSNKkCad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShhvJuz1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShhvJuz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496069; x=1804032069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+yt/IRC9EAMMhfa2JroCdoqjaMHHXvgbADaOftB5zes=;
  b=ShhvJuz1uD5oFTJZdy/70d4CHIOKNsG817P+GCRo3xdyW2HePKdOzFe4
   uGemoF6dqDjFfMy1UkmQFpkhYoJSz5yKyFHlaRX324Wlu8fDd0vulQARg
   q4g8Xfh81pW5NJNdQ4VjZBHUTFar+7DovuvzesYN5rtcC7UwlKAuehuO8
   PUD0//nUQM0VuJ7FVtvehPGpnNfmaA+OsScEDysRRJF8B21627NhYXrKQ
   tw4oyBRCOWxP9rTTWscR4TWbllpUUooFZ9j+OhRU6kbVLepxmHRwPFxQT
   v7Bfu6towQb+ZIgHLbIHdq/BqIavMiBpJv1c2C7dUOz9p3Iy/fS80V/Eh
   g==;
X-CSE-ConnectionGUID: f9zuwV3dS+uS/yckzGY+rA==
X-CSE-MsgGUID: C4bx/42ZQCKh6skt3sTrsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73483031"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73483031"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:01:00 -0800
X-CSE-ConnectionGUID: rvnL+1iNS7SZrF0Ewb4ohw==
X-CSE-MsgGUID: I01UQz/SRHGn7kBd5qs1Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967129"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:01:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com
Subject: [PATCH v2 16/19] samples/devsec: Introduce a "Device Security TSM" sample driver
Date: Mon,  2 Mar 2026 16:02:04 -0800
Message-ID: <20260303000207.1836586-17-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 sides to a TEE Security Manager (TSM), the 'link' TSM, and the
'devsec' TSM. The 'link' TSM, outside the TEE, establishes physical link
confidentiality and integerity, and a secure session for transporting
commands the manage the security state of devices. The 'devsec' TSM, within
the TEE, issues requests for confidential devices to lock their
configuration and transition to secure operation.

Implement a sample implementation of a 'devsec' TSM. This leverages the PCI
core's ability to register multiple TSMs at a time to load a sample
devsec_tsm module alongside the existing devsec_link_tsm module. When both
are loaded the TSM personality is selected by choosing to 'connect' vs
'lock' the device.

Drivers like tdx_guest, sev_guest, or arm-cca-guest are examples of "Device
Security TSM" drivers.

A devsec_pci driver is included to test the device_cc_probe() helper for
drivers that need to coordinate some configuration before 'lock' and
'accept'.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 samples/devsec/Makefile |   6 ++
 samples/devsec/pci.c    |  39 +++++++++++++
 samples/devsec/tsm.c    | 124 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 samples/devsec/pci.c
 create mode 100644 samples/devsec/tsm.c

diff --git a/samples/devsec/Makefile b/samples/devsec/Makefile
index da122eb8d23d..0c52448a629f 100644
--- a/samples/devsec/Makefile
+++ b/samples/devsec/Makefile
@@ -8,3 +8,9 @@ devsec_bus-y := bus.o
 
 obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_link_tsm.o
 devsec_link_tsm-y := link_tsm.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_tsm.o
+devsec_tsm-y := tsm.o
+
+obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_pci.o
+devsec_pci-y := pci.o
diff --git a/samples/devsec/pci.c b/samples/devsec/pci.c
new file mode 100644
index 000000000000..50519be412ed
--- /dev/null
+++ b/samples/devsec/pci.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 - 2026 Intel Corporation */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+static int devsec_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	void __iomem *base;
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return dev_err_probe(&pdev->dev, rc, "enable failed\n");
+
+	base = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "iomap failed\n");
+
+	dev_dbg(&pdev->dev, "attach\n");
+	return 0;
+}
+
+static const struct pci_device_id devsec_pci_ids[] = {
+	{ PCI_DEVICE(0x8086, 0xffff), .override_only = 1, },
+	{ }
+};
+
+static struct pci_driver devsec_pci_driver = {
+	.name = "devsec_pci",
+	.probe = devsec_pci_probe,
+	.id_table = devsec_pci_ids,
+};
+
+module_pci_driver(devsec_pci_driver);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Secure PCI Driver");
diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
new file mode 100644
index 000000000000..46dbe668945a
--- /dev/null
+++ b/samples/devsec/tsm.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 - 2026 Intel Corporation */
+
+#define dev_fmt(fmt) "devsec: " fmt
+#include <linux/device/faux.h>
+#include <linux/pci-tsm.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/tsm.h>
+#include "devsec.h"
+
+struct devsec_dev_data {
+	struct pci_tsm_devsec pci;
+};
+
+static struct devsec_dev_data *to_devsec_data(struct pci_tsm *tsm)
+{
+	return container_of(tsm, struct devsec_dev_data, pci.base_tsm);
+}
+
+static struct pci_tsm *devsec_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
+{
+	int rc;
+
+	struct devsec_dev_data *devsec_data __free(kfree) =
+		kzalloc(sizeof(*devsec_data), GFP_KERNEL);
+	if (!devsec_data)
+		return ERR_PTR(-ENOMEM);
+
+	rc = pci_tsm_devsec_constructor(pdev, &devsec_data->pci, tsm_dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return &no_free_ptr(devsec_data)->pci.base_tsm;
+}
+
+static void devsec_tsm_unlock(struct pci_tsm *tsm)
+{
+	struct devsec_dev_data *devsec_data = to_devsec_data(tsm);
+	struct pci_tsm_devsec *devsec_tsm = to_pci_tsm_devsec(tsm);
+
+	pci_tsm_mmio_teardown(devsec_tsm->mmio);
+	kfree(devsec_tsm->mmio);
+	kfree(devsec_data);
+}
+
+static int devsec_tsm_accept(struct pci_dev *pdev)
+{
+	struct pci_tsm_devsec *devsec_tsm = to_pci_tsm_devsec(pdev->tsm);
+	int rc;
+
+	struct pci_tsm_mmio *mmio __free(kfree) =
+		kzalloc(struct_size(mmio, mmio, PCI_NUM_RESOURCES), GFP_KERNEL);
+	if (!mmio)
+		return -ENOMEM;
+
+	/*
+	 * Typically this range request would come from the TDISP Interface
+	 * Report. For this sample, just request all BARs be marked encrypted
+	 */
+	for (int i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, mmio->nr);
+
+		if (pci_resource_len(pdev, i) == 0 ||
+		    !(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
+			continue;
+		res->start = pci_resource_start(pdev, i);
+		res->end = pci_resource_end(pdev, i);
+		mmio->nr++;
+	}
+
+	rc = pci_tsm_mmio_setup(pdev, mmio);
+	if (rc)
+		return rc;
+	devsec_tsm->mmio = no_free_ptr(mmio);
+	return 0;
+}
+
+static struct pci_tsm_ops devsec_pci_ops = {
+	.lock = devsec_tsm_lock,
+	.unlock = devsec_tsm_unlock,
+	.accept = devsec_tsm_accept,
+};
+
+static void devsec_tsm_remove(void *tsm_dev)
+{
+	tsm_unregister(tsm_dev);
+}
+
+static int devsec_tsm_probe(struct faux_device *fdev)
+{
+	struct tsm_dev *tsm_dev;
+
+	tsm_dev = tsm_register(&fdev->dev, &devsec_pci_ops);
+	if (IS_ERR(tsm_dev))
+		return PTR_ERR(tsm_dev);
+
+	return devm_add_action_or_reset(&fdev->dev, devsec_tsm_remove,
+					tsm_dev);
+}
+
+static struct faux_device *devsec_tsm;
+
+static const struct faux_device_ops devsec_device_ops = {
+	.probe = devsec_tsm_probe,
+};
+
+static int __init devsec_tsm_init(void)
+{
+	devsec_tsm = faux_device_create("devsec_tsm", NULL, &devsec_device_ops);
+	if (!devsec_tsm)
+		return -ENOMEM;
+	return 0;
+}
+module_init(devsec_tsm_init);
+
+static void __exit devsec_tsm_exit(void)
+{
+	faux_device_destroy(devsec_tsm);
+}
+module_exit(devsec_tsm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Device Security Sample Infrastructure: Device Security TSM Driver");
-- 
2.52.0

