Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECC352C4F
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557991; cv=none; b=ED5cpoX2jpGvUtof1shWiAgmvaDPTQKg+CCVJo/chuQs4e0D+LgJxG4AW7R1D/Fgr8Vxtw9ammdrC5fFd1gLwxZxtflUufddjer75wMfY1pAh9ig4lLr8osBEFReyN2zgLLmk86boizG+bGU0oCx/rUl90aO4jcJC4LzgCxwnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557991; c=relaxed/simple;
	bh=mPdZ4YzmGuOuBnQtYsBkKwgPvRUheV5+DHOGIftBU1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoadZuNhCi0Y0vmY3e8eyrmIHQsPyvUESSpPcBeiyvBLghxsunSueRQNNkM1EBoh9aHw0EmjwF+h9DjaqknDPIHv9XEFYFD5QU0/CjsoNpcv3+65RHFpvrdC2duHiT52fhV9008ImUtrjlG0z+cIQVcg/eyLVFQ/3hC7na2t30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzribqFJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzribqFJ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so1304491a91.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557988; x=1791162788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BRM1Hzz4fFI0zEE+sddBQUiqJULEyEeML2sw0SaeOmI=;
        b=XzribqFJjMXKtJTz6vkGz9OdKCWEQAjNm12j3BI8LdXM3582zQWzL7hV8brRdcm+d0
         XjR26B3OAoEbGLPoICKgi+cgCQakGFzSUO2czypz5xQaY1bK7A7mu0xwo+eE+YGr+2cy
         wj9kyWO2tOrCEjPModmXtul6V4Ybk+ORs0jKLcbkDm75/3wa5H/HQXV8cmjaqcviQXfS
         Ix/yCex6HjK2BwMzHHJDv44kcTgMF7aPOY2U2eGyOR/DYysAOt5PSlvvuGx1m/pW4G9Z
         RaZg4rlwWFMPvpZmUJwLGBvoHXugIY/ljdADrkLgiv6lS57nadHSijtaNfnjWWfNBLlv
         X1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557988; x=1791162788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BRM1Hzz4fFI0zEE+sddBQUiqJULEyEeML2sw0SaeOmI=;
        b=oRFjqS/7MjxKV1ZgA62CNCCwlJXvNziAjY1iI+hsww7QXRaiXMvvACprGveLFolt68
         ypGbRlP8Tjf2D7ekGV/IguEInW8+3uSnu2xG+L/Lb36jR7qDWlf+DbB4dMeFc9A3nFe2
         gPj3U3gMfcDhYeY5WoGnaPxIcG6PmhzobESXAVi3PieLOYpxX36kEbpvunrIzbUSAeKw
         ajTnhMN5Gia8WtQQynAGwAO2oDVGjj+aCKHew8aCDthA7vu5Xj5fCk3O0UBUwhp/fX3F
         1TN38j0qth4orML8XfQGwwGY32KSemj7bwRq3QRHubZka7XDLXGHZQNoLO/cTbW44g+F
         K7cw==
X-Forwarded-Encrypted: i=1; AKwUvBxsRFYR6P0A6/k5G2qWCLulJO5nLP4KNRaPh4l2UfAqoo4kjbdHITow2CvX3or2DuZxamAWelmftyY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx+89beBPSrZG+DLPZtX8AWCIx630kJibWCW0gaojNBe1NWnP+
	AjVEmkpMzhS7gBUmqGWYw5qqmrK8du5BE8iCLQwm+sWUJC5bgLRdq7Al
X-Gm-Gg: AYBFou3Uu5YWPGsyBCkVjd5T6pbUZpKmUjcGi3KMgdLJ2EOuvb9qUYYrd/d8M5uuYcI
	P7cWRQqInU/rJuCwiVlYh3YFHaPTyA7f3jsidpd0h31brZxmDEKdlPDGFcHtzgUA2lGvsmvJaS7
	MkciH+8cqtqZa0UO457IA9sFuWy19KeVehQne4jBX8hEPTP/o/VJipZsnmg0WmshNk6iEeTW79h
	H9rM9r09jTmJo1f71DF+nBhyr3bFbqh1tDLuBH4NOv3TBcEj/V6RoLCFgNbY613oEI5tDD05dho
	W7AcBnvPhRty70yDqFlcqikpG9fDnkaTIjkeCQeW2A6rZbM/nFKPab/lEY3kKmePFnx6yoPsUzM
	mMZyq/UpcXBMjf2X3mz1YmE95ZhXLMJp7qlCgZDV28mrKRO5r+ENeS8wgboBOhRmCSrnDBJZ4k0
	Np+vv8WYvwiPHosJse7277jsjXLUXzmtxYiagquDOXvu4Or03jV2P6iaPhWO8hdbh43lJY0dcBe
	JWP18pFdzSAs4lzAU1HCGcShik=
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a09c9df050mr6699718a91.58.1790557987941;
        Sun, 27 Sep 2026 18:13:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:13:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 13/22] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Date: Mon, 28 Sep 2026 11:11:14 +1000
Message-ID: <20260928011123.450800-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
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
 drivers/pci/cma.c       | 150 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/doe.c       |   3 -
 include/linux/pci-doe.h |   4 ++
 6 files changed, 171 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/cma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 424e25710ed2..c52dab8c6044 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24757,6 +24757,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma.c
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c7408509ba2..0862ef69aa3f 100644
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
index 000000000000..6b52b129574e
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,150 @@
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
+	if (!pdev->doe_cma)
+		return NULL;
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
+
+	/*
+	 * The DOE mailbox lives in the device's config space, so the device
+	 * must be runtime-resumed for the duration of the SPDM exchange.
+	 */
+	PM_RUNTIME_ACQUIRE(&pdev->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	return spdm_authenticate(cma->spdm);
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
+	tsm_dev = tsm_register(NULL, &pci_cma_tsm_ops);
+	if (IS_ERR(tsm_dev))
+		return PTR_ERR(tsm_dev);
+
+	pci_cma_tsm_dev = tsm_dev;
+	return 0;
+}
+late_initcall(pci_cma_tsm_init);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 6a59969bd52f..1b3d6e74fbe8 100644
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
2.55.0

