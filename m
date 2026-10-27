Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078837;
	b=Ui5Mb6iNZ9/irpdzxsLrYAr5lhtB+6oaLmzNZqzwhuEXPAhuZJKAMog9UzJRa6D83tA2
	 QBR66dLSabDQlRgJKUSmpgWHtPUB7JaLQjolOgW8n6toTPkL+juGMTd1sGPcftkudiUr8
	 SkztyIjLFITIloVXBmaxvQkxSmyWauH6CbSdTSZ80Y0+iqmyJsW4ueQ4bk49jHGIYTro5
	 tuYamBBYhM+6OTTPheRdnlkuTdnRmZTGwnON/unqG0zFEmpnph2GEOUoY8wDVv4Wr6kXG
	 FTly5kStkAaGyxx4Wpy+7HsqLjrzNK6fukqpMfexJnDUVsNS/zjiiWX8LNq0UTQGzFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QTs7gKFmtIFwCAR5rB1B8td2s4rX/b0JRH7aNSQh2EE=;
	b=BURtAWg/rP9CeHAzFq+Zrl3D1m5mqBhclPkJ2GZzQ1gWF0V5FuoHjMmygZxcKpuYdNUz
	 6yJP7MPlN26sUJV3rWVCsG/C+dXub6/BImkmx+mBjUf7j3he1moGqcQkwuBm5GQvcSL3C
	 sp/duz64EMxEvfocVCq7JWZVZaq+1wBuw8af/vId1FtU9dxxvCBoJ8sd2X2wfldYxQCNU
	 oNRcDbr0VI1VVZNSNOmjJo1CjLCLuXyc1m9j1EKu4detDMDXfr/WlhcFhvS6OzXf2JrzS
	 Y5/44k4rwP+mFriMWNm6FN/K8yU23s3hvhWSz53mf8UxaF3ZtAaFU3XpeyTI87Em0Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IWceS3fA;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E10606A320
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8E10606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IWceS3fA
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9ae391a05so4125805ad.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078836; x=1793683636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QTs7gKFmtIFwCAR5rB1B8td2s4rX/b0JRH7aNSQh2EE=;
        b=IWceS3fAKEp+tC6hvjD/aIYnQ7OV9NwaYByOUwJwxSnNzuYo6UREQpDmIed1sm/RqJ
         Q2ueUB4qLs8VhaKwcQuSneQvEMNbY4ULuefI/ch7rGRjP7DdRi2f2lqzNffO6fNxJfTk
         YNftD3NpRUYbjPgMgfJ6sqSES2bWSTIpS3gcG5NplvMBb/FAlqpeSb7jGn5DrmEtk0FB
         /a6Ya2J85ocnIyoNN6p90Ytbmnbh8FIHHW2UHOEQxg5aWfAGJawQtVQ8JZs8Ri3aOJSC
         l+hLCp3pS7X4EE0/iQGsqzcza0i4zma674+XwLH8W1e85lPmGpxy+6EJ8GcI5gH64I/g
         WRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078836; x=1793683636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QTs7gKFmtIFwCAR5rB1B8td2s4rX/b0JRH7aNSQh2EE=;
        b=LDqOIacVqYdRiq/fZzg66bpSnevzM3BQ+Z2P9fx9URF2nzJhI2GRF6GE272kZpOnHe
         3dAT0Y3ljsUtNKyTnB8Nr1jydxdKjo+hGknDXBEDo4X98Oi6qopKUvZFL1O4AAzSAiR6
         eH/AqD9H7UUhteEg8P5qDbmke8loFf8xWvZtvae9bTHD4oOQINXBeRCFS0Ty2bKGDA3G
         NvuI/r7sh1qTiyJYFuFzLYn1Qfli4bara0o8/k9KmE/Vu7kFAPzmG2bUnArRUBC5MP9P
         Wl9uueb5dHghSo+ujdExXGwFIkCssQ/q9BK7fgv+KLwhn+cNKJlGvQRou1wibjH2Y3df
         H8fA==
X-Forwarded-Encrypted: i=1; AKwUvBwXvIjxpolDZtSI10kkRQ0PNY7aF6nqd4QnvGRiqNbW42uYvJtwM5N8Tcr92LCJYlHUSEsuMz/ptMY=@vger.kernel.org
X-Gm-Message-State: AFq9FYILrV76GrWfs7CMUWBAnQy9fE+4Lc3msGh55GaTwhHLhoTHr3Xc
	XF/grQ3tb9ox4tJdLuHM43cPpM5T9DbQAzjhxDZwuqdcKXwdtuNQE47N
X-Gm-Gg: AYBFou2KdKIvBIsXkJkp+E6J+7/p13HJ3pF8VHgsQv4+7bTUOtr4u6Ek4HzrgGFPlVy
	yPhQpKnxdMdMHmCdpcFph0ZxhR6Iu6tlES2DxW5rSyVUrlwulVtneOCAaphCuP5kVyqA6/Z6zww
	lpohqElTlfotk+PodE7tRxodOWrTUDxq2l0LdF0k4H2IcWfTkQnPaqo1m/Zji65Aap1xm7ST4kb
	1tKKa4irVCgyj0DId71jvPkycrUvExXVgYpnY1QF1XHmbBMapH22EU7taudhGVDrQTBkFba+37e
	dxScDjdwJilHJsb2XL5kGgn3t+T89grwe28igDldl+9q2J8PYBRjpmfKTzZafcyH5dw27WMuFB2
	prfiR7sdrTkaUrfSgZuLDcbBd1poSCEDVfe67uAVyQUpSuCH7emH9OE44TYwzz1IE/CqqbayD3h
	F2MCbMIbTzYQL25TGmL3VF/d3W+hTN+bWxGroAV5g7BBUD17cDHZjKS9gMacjQo3NXPkVErWUvH
	DrE8JD9RBpqO0ZUQZrbPMFyGHRapRYXtD4+tiaFhVDdfcYooru9BRl5zr/NHPv0gNlsA0ZzJg==
X-Received: by 2002:a17:902:fc4b:b0:2df:98a1:d0a7 with SMTP id d9443c01a7336-2eae40298aemr9769035ad.33.1793078836128;
        Mon, 26 Oct 2026 22:27:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 12/23] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Date: Tue, 27 Oct 2026 15:25:25 +1000
Message-ID: <20261027052536.1722081-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
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
index 783da0b234541..5140ed5cc108b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25299,6 +25299,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma.c
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c7408509ba24..0862ef69aa3fd 100644
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
index 41ebc3b9a5182..16abfd0e17e19 100644
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
index 0000000000000..6b52b129574ec
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
index 365634fb0df7a..5f79307e0f087 100644
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
index bd4346a7c4e75..7540396336def 100644
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
2.56.0

