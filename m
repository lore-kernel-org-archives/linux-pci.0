Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B788306486
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210318; cv=none; b=mENJ3kG2lRPgvkrWaUSW/6HZKBMDA8Emotjt0tISi5OgOBV4Tm2eubeh5SCfaMcT58ewdE3hk+mfgtCgV3fstRArg3HxvLa/iR+9JXUJwE+QshCtnIoqdW8auX56VeaL8g3vxtHtU6OCmn3Y1HMp3zYTUECwgzzjLtzj5sXh5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210318; c=relaxed/simple;
	bh=MkGBnlqcPkrjbetz6CR3OU3ygvsKKQd9u7prbxNnQb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDi6Bfl2wS95bZGpS+ODLskfu0bbW9ejLlyqUH7Ljc6d8YERLXVHIm/PL+1boagkriTeZDDJ1wKGhsCI4/RQBx/BkVuJX3AnHjy3sQo35KhvFHtrH7IWlqsG+RisHOo4blFdxV4NmrEPwTO/mVe5uws+CSSejf9Bt+kbwxNRwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtV3RSiq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtV3RSiq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2baca78cfaaso8653495ad.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210312; x=1778815112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZDNMlvL+OebdDkipENIfQ0eTX10FcJgg4MaM4qp9cc=;
        b=UtV3RSiqhG63kRqMzxQOPtj7OqmR2fYfNs/2aS0tY8Sm03/Rtf33JmDOqNpjXKwM04
         8G/sZFlwkYHJjMqK08rWNsn9SIfZXCWR12fU94y01n9M71OxS0nWXEBFYtSB3ZAIgGjp
         qapoy95EcpagTR1ojAPbQ4+NXrEADnrK/GSmR6T5PTX+TNU0pU8Kz7F5Ic4uNQLLdl8X
         bRHY3HCAdO1grCWBj21mHdmcK0kgjVy1qxL4LtDjHor8H+sUPukMS472VEgGFB1ND922
         N2fn2U8YyLder5GHTsdzdJBv/LafZMOXflM90LiLmcHB8CEuQzOEUybhZlaq/Qpk7z+J
         OQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210312; x=1778815112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZDNMlvL+OebdDkipENIfQ0eTX10FcJgg4MaM4qp9cc=;
        b=b0sWPWHGmmMlX9UL6AhkzLksDz68VfBI927PXAwKxPcR25u7fkciliIBRfuS6156B7
         sxllxE6ISaI9tuBfv/B3T6FuAPBEONyONSbOoAKiwFN+cPWDNqsF6emYNrSZEiF+iqWW
         gn1uIivMuydPf9wZJ2rAIYFA9pU7YiGDi5+5Ks0Cejn0xEYuRN/7M5ehPcgGwxBwPFPv
         pm0qqinLGHss0cMpDt1o8uWTFGMhdac3p1+2xW12cahQDoiRQtkFSa1Rr+roxlFj1IAl
         nM32U3y7OPPOyX+jwXmWNYM8pKuMPG6PNr0TpQKPkKLZADzEcuL2bXf34N4nacryXpQI
         cFKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+D67S6Incu+hZua9Zp/bd30KStJOeut52qgUlN7DEYnGxF1r8B+fp9/Oc6uGtGrTl9Dup7uavZtl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynhrm/8rynZxdc3A7zO3FVRTWNxW+CStE7G/+F66VIT6KjZWix
	IfqQYv80vkiXkNUL7LY7byQG2jTF2ReSXM3sAdt/Qg72hkgLXHdsYeUs
X-Gm-Gg: Acq92OGw0TydgcOaXktj3YD+v4OOBDvMmrZzTWEZckCOte1lT/rPE327191E0TW/Gf+
	2J1nNPK81wq2p4m/uI3b8C/rBxNeu788WqIum6e6nplvwDJSxKTkv9ZVM2lC9g/tTq2hbR/o6FA
	t36u9eoqQUmaquMFVUwJRO/6xPAa8QRZXe8xH0JXzo/WZ5FVevgm72ee2j2xJ2FtCCdK+UBff7/
	mHrcy2J/JhY07fpJ+21rOJoi+SL58uwX+BrKWQNfyeBP9QwvMv/ciqdBoHv6kGtckRClkouxsv6
	J/qX7zlpgAurcSmfsR7K3EewSI8IJFbCFOWneeKOfDyjJ/2MpM5CfJN5UZ9exKxjsDo2M+u8UAT
	5O94mNb+XUgTHat7js+DisxD2OERTwyvR6pbVE4f3H4LjvQUzRPTKEGNfY5VW6nuDnUxiPLz1tn
	OkX4HATbECZl1SJcwiuE+KCNFu9JTLlYdE2RVRnWat
X-Received: by 2002:a17:903:22c4:b0:2ba:e66b:ce34 with SMTP id d9443c01a7336-2bae66bd563mr27232095ad.21.1778210312457;
        Thu, 07 May 2026 20:18:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:18:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 09/18] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Date: Fri,  8 May 2026 13:17:01 +1000
Message-ID: <20260508031710.514574-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
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
 drivers/pci/cma.c       | 141 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/doe.c       |   3 -
 include/linux/pci-doe.h |   4 ++
 6 files changed, 162 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/cma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e8ad57fec5d..c99fc6ae2d03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24173,6 +24173,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma.c
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 33c88432b728..dcf4170381f2 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -124,6 +124,20 @@ config PCI_ATS
 config PCI_IDE
 	bool
 
+config PCI_CMA
+	bool "Component Measurement and Authentication (CMA-SPDM)"
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select PCI_DOE
+	select PCI_TSM
+	select RSPDM
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
index 000000000000..998fde6366fb
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,141 @@
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
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pci-tsm.h>
+#include <linux/slab.h>
+#include <linux/spdm.h>
+#include <linux/tsm.h>
+
+#include "pci.h"
+
+static ssize_t pci_doe_transport(void *priv, struct device *dev,
+				 const void *request, size_t request_sz,
+				 void *response, size_t response_sz)
+{
+	struct pci_doe_mb *doe = priv;
+	ssize_t rc;
+
+	rc = pci_doe(doe, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_CMA,
+		     request, request_sz, response, response_sz);
+
+	return rc;
+}
+
+/**
+ * struct pci_cma_tsm - CMA SPDM TSM driver context
+ * @pf0: base pci_tsm_pf0 context (must be first)
+ * @spdm: SPDM session for this device
+ */
+struct pci_cma_tsm {
+	struct pci_tsm_pf0 pf0;
+	struct spdm_state *spdm;
+};
+
+static struct pci_cma_tsm *cma_tsm_from_tsm(struct pci_tsm *tsm)
+{
+	struct pci_tsm_pf0 *pf0 = container_of(tsm, struct pci_tsm_pf0, base_tsm);
+
+	return container_of(pf0, struct pci_cma_tsm, pf0);
+}
+
+/**
+ * struct pci_cma_devsec - CMA SPDM devsec TSM context
+ * @spdm: SPDM session for this device
+ */
+struct pci_cma_devsec {
+	struct spdm_state *spdm;
+};
+
+static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
+				      struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe;
+	struct pci_cma_tsm *cma;
+
+	doe = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+				   PCI_DOE_FEATURE_CMA);
+	if (!doe)
+		return NULL;
+
+	cma = kzalloc(sizeof(*cma), GFP_KERNEL);
+	if (!cma)
+		return NULL;
+
+	mutex_init(&cma->pf0.lock);
+	cma->pf0.doe_mb = doe;
+	cma->pf0.base_tsm.pdev = pdev;
+	cma->pf0.base_tsm.dsm_dev = pdev;
+	cma->pf0.base_tsm.tsm_dev = tsm_dev;
+
+	cma->spdm = spdm_create(&pdev->dev, pci_doe_transport, doe,
+				PCI_DOE_MAX_PAYLOAD, NULL);
+	if (!cma->spdm) {
+		mutex_destroy(&cma->pf0.lock);
+		kfree(cma);
+		return NULL;
+	}
+
+	return &cma->pf0.base_tsm;
+}
+
+static void pci_cma_tsm_remove(struct pci_tsm *tsm)
+{
+	struct pci_cma_tsm *cma = cma_tsm_from_tsm(tsm);
+
+	spdm_destroy(cma->spdm);
+	mutex_destroy(&cma->pf0.lock);
+	kfree(cma);
+}
+
+static int pci_cma_tsm_connect(struct pci_dev *pdev)
+{
+	struct pci_cma_tsm *cma = cma_tsm_from_tsm(pdev->tsm);
+	int rc;
+
+	rc = spdm_authenticate(cma->spdm);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static void pci_cma_tsm_disconnect(struct pci_dev *pdev)
+{
+	/* SPDM state is freed in pci_cma_tsm_remove() */
+}
+
+static const struct pci_tsm_ops pci_cma_tsm_ops = {
+	.link_ops = {
+		.probe		= pci_cma_tsm_probe,
+		.remove		= pci_cma_tsm_remove,
+		.connect	= pci_cma_tsm_connect,
+		.disconnect	= pci_cma_tsm_disconnect,
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
2.52.0

