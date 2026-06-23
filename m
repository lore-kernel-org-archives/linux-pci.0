Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150013A9637
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190573; cv=none; b=VV2tcb/CzwIYU6OExhTx49TCgMTEv4gwopLKpPmI9C898SGC6k0enXNCprsce8r59K0GknVtRW6EjWC4g1Ao7rDwi7RZuEK6vM33Lojk+ujdwOogW7siLdlmROete2FZ/XsR+hxMSC9nVzKeKctDzenzg13+gYqnvGnaKqs6iZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190573; c=relaxed/simple;
	bh=K+SC5IxHlIV3iWNxwgE8Slh4rCOEed/puy7Uym6goT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHPUEVy7G1ELBFql5/bnmvKUlaQ3cRcSF1HXEhgEuMqvGNUUTRteWM5iPMTigPKpIgzF90enNEdo3izdeP0W7GMlpRapBnxBJ6zotLuFghkAaP7NMXIWCJNDYyl3ZQYk2eXlfmY8nVNuRsM6nbr69OmfLPVHRgXXU4W6mUdriVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcR+LdIP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcR+LdIP"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so3185750a91.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190570; x=1782795370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKjP4de/nL2YoJ5YNfExRvO0a9n82fsJmG7RvKODxLQ=;
        b=WcR+LdIPDm/tDSq/XnpOx591nIMPr91IockKI7eJj0QmbakPStMmXCS2nPhjlKP4kB
         SNj/Vd5K56u/A6mLD7a/7hh5eXhWDCIOMeIz5ACab0VVeg2hut6BlQsjac9Xsgl7ItR8
         ZqhZL6kypjx2afNJiIIVpXVouQRi6hCZyiW9MErHnNaVoPLZALxD9HW/NSHwUxdKSR3A
         mA/jZjKw/2VOWQetMeXTlEhyaHLUTfKsgDw1J0DeUe47yqW+ILWOmLxU1l2rH17aScl2
         SXSyse+A95scqPGEZa/BP+wRQotNUrQRQMMXjNBIQQozeW+HAIAvTbtpubtf5aokYOiU
         bc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190570; x=1782795370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKjP4de/nL2YoJ5YNfExRvO0a9n82fsJmG7RvKODxLQ=;
        b=oCCnXU9BARM2dQSMwYcEIA0D2Ms9MuLSV8SeqALq0IVFwc5hNoy79bgbpkaLBdV8jA
         bVImK1ah60b4QDoEhRtSsE3hu1LDuR7jozgeBndojrnyCLKphRPAAuTL1jhQJEmS2CD3
         WPH4oz61A0++a3qGKROAI7pIZr3sdDfE10j6gJ2EjxP1Fi7VSDfTtbrV2C1N50YaQF6y
         VgnVYkSCRx+ulItupEtghSLVNX4OZ4kWWsoobCvBnCjB7l3UoiVI4vXuzca3gFbNoOTL
         P1Px0B8Ie6p9RuZ+Gs9XL/8PVPw7EIhJzqoJFLRKS+KuvbqCPhl13L6uchhCFRJpavjh
         L9wA==
X-Forwarded-Encrypted: i=1; AHgh+RrV/TirIVhyayRBlsgwJa6tbMv9+20kHCTkholo9gZB7t7JUV+Nphk+kSkMXc3FooesuySrCA8tQLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Rj+VoE6zFzwQXPvXHgb36NElczLKsb6KATjxZZb4gImqjZHV
	4XEuq7WUCndQTvQbik/nsrk14o56NfL+vs4roKulcrY9g175/Qmt/3fv
X-Gm-Gg: AfdE7cn1gdhcFsUcJzz4r7s/orFDo9KpCPB4YqGc3VtGYQOYillHr4KTPEzH1yElBn5
	GrB4lcUstDO/cTNh7yew+V29ENMVWOxknjXsI4HGlHLjbXkObxqv2aINA4iuSXjXw2iwZNMNAAp
	fy6mLsgHkzQNxkSLrfLlDl/oowEO9uSG57oCuPCrzzpEQuXdnO9DZhGVaVZmeDcd5TF+6ZBel4L
	AeiaXZ1oXXslpefJsgkNTRHDimegjJadIWY2mbkf2RdVToR/jv9xFbW6A7q4KTb5p1fCO/sq+S5
	Ub77SWzPxLvVtWDE2i6KVMOlNiJzPC4ZS7gtz2XI8kni2cFcrm0wgv14EUU0LvqENaTXAfB00+0
	Vx62p11EY8C6EC3YUyieqtWNqI4VIoabJSG+svV5IXPvvMNdeOVsKTBNAemzUJWbk+OwdfUlrqD
	dF2f/rIPSUfuJpxRqa3hWE+vIcU7sQeA==
X-Received: by 2002:a17:902:ec88:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2c7c7724fedmr15775365ad.33.1782190570275;
        Mon, 22 Jun 2026 21:56:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:56:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 12/21] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Date: Tue, 23 Jun 2026 14:53:57 +1000
Message-ID: <20260623045406.2589547-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
allows for measurement and authentication of PCIe devices.  It is
based on the Security Protocol and Data Model specification (SPDM,
https://www.dmtf.org/dsp/DSP0274).

CMA-SPDM in turn forms the basis for Integrity and Data Encryption
(IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
transmitted over a CMA-SPDM session.

As a first step, add support for authentication via a CMA TSM driver.

This was previously discusd here:
http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch

By utilising a TSM driver we get a lot of the TSM driver probe policies
"for free". Currently there is no mechanism to provide evidence to
userspace, as the TSM system doesn't support that at the moment. That
can be added later when support by TSM.

Credits: Jonathan wrote the original proof-of-concept for a CMA implementation.
Lukas reworked that for upstream. Wilfred contributed fixes for issues
discovered during testing. Alistair reworked it as a TSM driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Co-developed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS             |   1 +
 drivers/pci/Kconfig     |  14 ++++
 drivers/pci/Makefile    |   2 +
 drivers/pci/cma.c       | 154 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/doe.c       |   3 -
 include/linux/pci-doe.h |   4 ++
 6 files changed, 175 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/cma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 603192ab6d12..cf654b4ccbf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24407,6 +24407,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma.c
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 33c88432b728..07483655b191 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -124,6 +124,20 @@ config PCI_ATS
 config PCI_IDE
 	bool
 
+config PCI_CMA
+	bool "Component Measurement and Authentication (CMA-SPDM)"
+	depends on RSPDM
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select PCI_DOE
+	select PCI_TSM
+	help
+	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
+	  A PCI DOE mailbox is used as transport for DMTF SPDM based
+	  authentication, measurement and secure channel establishment.
+
 config PCI_TSM
 	bool "PCI TSM: Device security protocol support"
 	select PCI_IDE
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..16abfd0e17e1 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -41,6 +41,8 @@ obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
 obj-$(CONFIG_CARDBUS)		+= setup-cardbus.o
 
+obj-$(CONFIG_PCI_CMA)		+= cma.o
+
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
new file mode 100644
index 000000000000..9f2cc0b2ec8a
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Component Measurement and Authentication (CMA-SPDM, PCIe r6.2 sec 6.31)
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ * Copyright (C) 2022-24 Intel Corporation
+ * Copyright (C) 2026 Western Digital
+ * 	Alistair Francis <alistair.francis@wdc.com>
+ */
+
+#define dev_fmt(fmt) "CMA: " fmt
+
+#include <linux/err.h>
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spdm.h>
+#include <linux/tsm.h>
+
+#include "pci.h"
+
+static int pci_doe_transport(void *priv, struct device *dev,
+			     const void *request, size_t request_sz,
+			     void *response, size_t response_sz)
+{
+	struct pci_doe_mb *doe = priv;
+
+	return pci_doe(doe, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_CMA,
+		       request, request_sz, response, response_sz);
+}
+
+struct pci_cma_tsm {
+	struct pci_tsm_host host;
+	struct spdm_state *spdm;
+};
+
+static struct pci_cma_tsm *cma_tsm_from_tsm(struct pci_tsm *tsm)
+{
+	struct pci_tsm_host *host = container_of(tsm, struct pci_tsm_host, base_tsm);
+
+	return container_of(host, struct pci_cma_tsm, host);
+}
+
+static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
+					 struct pci_dev *pdev)
+{
+	struct pci_cma_tsm *cma;
+	int rc;
+
+	cma = kzalloc(sizeof(*cma), GFP_KERNEL);
+	if (!cma)
+		return NULL;
+
+	rc = pci_tsm_host_constructor(pdev, &cma->host, tsm_dev);
+	if (rc) {
+		kfree(cma);
+		return NULL;
+	}
+
+	cma->spdm = spdm_create(&pdev->dev, pci_doe_transport, cma->host.doe_mb,
+				PCI_DOE_MAX_PAYLOAD, NULL);
+	if (!cma->spdm) {
+		pci_tsm_host_destructor(&cma->host);
+		kfree(cma);
+		return NULL;
+	}
+
+	return &cma->host.base_tsm;
+}
+
+static void pci_cma_tsm_remove(struct pci_tsm *tsm)
+{
+	struct pci_cma_tsm *cma = cma_tsm_from_tsm(tsm);
+
+	spdm_destroy(cma->spdm);
+	pci_tsm_host_destructor(&cma->host);
+	kfree(cma);
+}
+
+static int pci_cma_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_cma_tsm *cma = cma_tsm_from_tsm(pdev->tsm);
+	int rc;
+
+	/*
+	 * The DOE mailbox lives in the device's config space, so the
+	 * device must be runtime-resumed for the duration of the SPDM
+	 * exchange.
+	 */
+	rc = pm_runtime_get_sync(&pdev->dev);
+	if (rc < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		return rc;
+	}
+
+	rc = spdm_authenticate(cma->spdm);
+
+	pm_runtime_put_sync(&pdev->dev);
+	return rc;
+}
+
+static void pci_cma_tsm_disconnect(struct pci_dev *pdev)
+{
+	/* SPDM state is freed in pci_cma_tsm_remove() */
+}
+
+static struct pci_tdi *pci_cma_tsm_bind(struct pci_dev *pdev,
+					struct kvm *kvm, u32 tdi_id)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void pci_cma_tsm_unbind(struct pci_tdi *tdi)
+{
+}
+
+static ssize_t pci_cma_tsm_guest_req(struct pci_tdi *tdi,
+				     enum pci_tsm_req_scope scope,
+				     sockptr_t req_in, size_t in_len,
+				     sockptr_t req_out, size_t out_len,
+				     u64 *tsm_code)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct pci_tsm_ops pci_cma_tsm_ops = {
+	.link_ops = {
+		.probe		= pci_cma_tsm_probe,
+		.remove		= pci_cma_tsm_remove,
+		.connect	= pci_cma_tsm_connect,
+		.disconnect	= pci_cma_tsm_disconnect,
+		.bind		= pci_cma_tsm_bind,
+		.unbind		= pci_cma_tsm_unbind,
+		.guest_req	= pci_cma_tsm_guest_req,
+	},
+};
+
+static struct tsm_dev *pci_cma_tsm_dev;
+
+static int __init pci_cma_tsm_init(void)
+{
+	struct tsm_dev *tsm_dev;
+
+	tsm_dev = tsm_register(NULL, (struct pci_tsm_ops *)&pci_cma_tsm_ops);
+	if (IS_ERR(tsm_dev))
+		return PTR_ERR(tsm_dev);
+
+	pci_cma_tsm_dev = tsm_dev;
+	return 0;
+}
+late_initcall(pci_cma_tsm_init);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 7b41da4ec11a..f236942660a3 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -31,9 +31,6 @@
 #define PCI_DOE_FLAG_CANCEL	0
 #define PCI_DOE_FLAG_DEAD	1
 
-/* Max data object length is 2^18 dwords */
-#define PCI_DOE_MAX_LENGTH	(1 << 18)
-
 /**
  * struct pci_doe_mb - State for a single DOE mailbox
  *
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
index bd4346a7c4e7..7540396336de 100644
--- a/include/linux/pci-doe.h
+++ b/include/linux/pci-doe.h
@@ -19,6 +19,10 @@ struct pci_doe_mb;
 #define PCI_DOE_FEATURE_CMA 1
 #define PCI_DOE_FEATURE_SSESSION 2
 
+/* Max data object length is 2^18 dwords (including 2 dwords for header) */
+#define PCI_DOE_MAX_LENGTH	(1 << 18)
+#define PCI_DOE_MAX_PAYLOAD	((PCI_DOE_MAX_LENGTH - 2) * sizeof(u32))
+
 struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
 					u8 type);
 
-- 
2.54.0

