Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622D346E41
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780653; cv=none; b=O+fIiFex89FuwCPsmK6ZRO9p+tcoMGZyYlu/SoR1qeYHTfG+7LmaIvYyw+n5EH4NMMaZ3OspioGAik9T7NFV9++BpvfLjfPikko8n5LIhpeJPu1hThvNzuYatZii39VOJO9tn+xzmDG5l8yI4+0dsIuruAo+SqJDmTihAAsv9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780653; c=relaxed/simple;
	bh=xkGNE2ohHTD4CfhfPzdzFZFTRcEJitPxHq9ykzoPMGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlVWmQAYzaNqra0nSRbH8NqBWi7w2LqRRTraziuR/9QbqmxjLizauqT1dh3X9x22Z9fogoX/XiOQCN3E8fulk22zRjB/C0Wwci7KzmUD6VJXbH/O7oFcfGoeunV5DtWAfpV4of85Rls6mf3o/mDonb6wuLfdw6/xHbJQpsg/ngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4flZCmV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4flZCmV"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6e1d3e4dc4so11411a12.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780651; x=1771385451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkGUjPlY8y9Yk5Nqgh7hT+M8qtzIfjwHeltAbD4eTuM=;
        b=K4flZCmVS2TdZmQ/YkDipj30lezCecZxJ9j+y0hJ+8v5E62zSruUP+/+m2yXse9x3P
         pti5tdrByZf2SF5PXT9m7MOEuPIZxIDYMtxTZHNPq+CQHOeanKrwLnw6R8GWWL67/1jN
         sC0I1NuCwUEBm+B26QF3cOpcSrCdtg5quvIX9XdEaodmY9sw3AymUL5a1Az7qPlxNu+v
         /KHJnH39qKIoe+DqFHoHwiDE7fo5iOItIZ5xRFr1a3Mngfb/P05OQ1VmyRGQuwqfxR23
         gWgLeIpXJ5DlBHCn78nxsshrTwm66FE4FVU7XYmHabIP9WTjNmnGiQC/FCV0GzonJ9/J
         pJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780651; x=1771385451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkGUjPlY8y9Yk5Nqgh7hT+M8qtzIfjwHeltAbD4eTuM=;
        b=OYJ1+zygg2mHscWPvCoPPqBE8gJTkXRNmJ6ofYUTDFp2hY6S3a+IKN9j0hD81k6uap
         bXc6n/KgLR8/B73hTOq5nO5tdJefRAHhBVJLzTfpV5bm5DKQu456tRnEJ+CT3AiU1eJn
         dSnMwm/Dnv1AkzZHdfVazN0bT4vk5FWQHT8+eWtdWAQ5MisoyCGQrWfF3pBZEiA32VeD
         Y6IyH5EPOoKETjmHJtkEyUsKCLFEsqaIh/rnYmZ6ZfYY1c7rKdT43isWvHU+VBUbP0CO
         5eRoKcItXkBKiyubzpSsZO3vaf1sQyyhLWI6Sjf7oZRkrFUJ6feVfKMVDvKCgMh1OlqZ
         3KFw==
X-Forwarded-Encrypted: i=1; AJvYcCVht5hf6hoem+a2r6/7Mjr3pfGLiyqDGTW29xGx6hJBC4zgwGY8DU+fkYYSB/F1j58lF57Pq6/KpIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn2OtKhMCPsdlA/rBVnV7yjpuzin0WFO2L1qZRtBJcrUAtzwUn
	vEMJLlHKnMrFA5OuGDMRBzmYx6cwJgFBiIH+f7MwGGICWVjMN7x1xuGl
X-Gm-Gg: AZuq6aK7H/Zxixrhrv041tSnuH1zdy2C9WO7NAeqdKlK3GM8oEeIhGFom+dMFd1sluJ
	0Zg2q/SG0jqB0c08vLLt6CCU6rVnvezYCSuH63tW0ZodCPkns4Jdlztrui3fINhUlo+f0lTmzNL
	wR8J/lDMlPVRgmdZNeiUpGkGwGKeMdP87bBycN62NGxeheube2GwxYNJQGBD60r2sx1K/PieGwf
	nZ3L4WPg/DDURJAxTv+Lwf9Pf/skMpgShsZEh1lJaOlhhr3V7EJjUFTGgucAtXScszLU7lxVyAG
	Cdmh452opDvqtZJBjAbSAELjplOTU4wegx9YMGE0AK4MFN/YLKXxROIHqY4YqxxhHAqURJ4SBUy
	QnXWrgXMzKYUjnBh02y962HEVT3f0Y0sAMabBpVEJbCi2EkzRPNc/OIjppb8tgHJQGN0JRiWAfT
	pfWxq35hBAk96mza+3OuS9judsDhErZ2u5AzT860RmHA==
X-Received: by 2002:a05:6a21:a08:b0:38d:e87c:48c8 with SMTP id adf61e73a8af0-393ad36a5ddmr16559978637.60.1770780650790;
        Tue, 10 Feb 2026 19:30:50 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:50 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com
Subject: [RFC v3 09/27] PCI/CMA: Authenticate devices on enumeration
Date: Wed, 11 Feb 2026 13:29:16 +1000
Message-ID: <20260211032935.2705841-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
allows for measurement and authentication of PCIe devices.  It is
based on the Security Protocol and Data Model specification (SPDM,
https://www.dmtf.org/dsp/DSP0274).

CMA-SPDM in turn forms the basis for Integrity and Data Encryption
(IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
transmitted over a CMA-SPDM session.

As a first step, authenticate CMA-capable devices on enumeration.
A subsequent commit will expose the result in sysfs.

When allocating SPDM session state with spdm_create(), the maximum SPDM
message length needs to be passed.  Make the PCI_DOE_MAX_LENGTH macro
public and calculate the maximum payload length from it.

Credits:  Jonathan wrote a proof-of-concept of this CMA implementation.
Lukas reworked it for upstream.  Wilfred contributed fixes for issues
discovered during testing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Co-developed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 MAINTAINERS             |   1 +
 drivers/pci/Kconfig     |  16 +++++++
 drivers/pci/Makefile    |   2 +
 drivers/pci/cma.c       | 101 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/doe.c       |   3 --
 drivers/pci/pci.h       |   8 ++++
 drivers/pci/probe.c     |   1 +
 drivers/pci/remove.c    |   1 +
 include/linux/pci-doe.h |   4 ++
 include/linux/pci.h     |   4 ++
 10 files changed, 138 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/cma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a5c4ec16081c..58898260fde8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23702,6 +23702,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	drivers/pci/cma.c
 F:	include/linux/spdm.h
 F:	lib/rspdm/
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e3f848ffb52a..7ea403799d78 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -125,6 +125,22 @@ config PCI_ATS
 config PCI_IDE
 	bool
 
+config PCI_CMA
+	bool "Component Measurement and Authentication (CMA-SPDM)"
+	select CRYPTO_ECDSA
+	select CRYPTO_RSA
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select PCI_DOE
+	select RSPDM
+	help
+	  Authenticate devices on enumeration per PCIe r6.2 sec 6.31.
+	  A PCI DOE mailbox is used as transport for DMTF SPDM based
+	  authentication, measurement and secure channel establishment.
+
+config PCI_DOE
+	bool
+
 config PCI_TSM
 	bool "PCI TSM: Device security protocol support"
 	select PCI_IDE
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index e10cfe5a280b..f026f5dbb938 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -40,6 +40,8 @@ obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
 
+obj-$(CONFIG_PCI_CMA)		+= cma.o
+
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
new file mode 100644
index 000000000000..7463cd1179f0
--- /dev/null
+++ b/drivers/pci/cma.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Component Measurement and Authentication (CMA-SPDM, PCIe r6.2 sec 6.31)
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#define dev_fmt(fmt) "CMA: " fmt
+
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/pm_runtime.h>
+#include <linux/spdm.h>
+
+#include "pci.h"
+
+/* Keyring that userspace can poke certs into */
+static struct key *pci_cma_keyring;
+
+#define PCI_DOE_FEATURE_CMA 1
+
+static ssize_t pci_doe_transport(void *priv, struct device *dev,
+				 const void *request, size_t request_sz,
+				 void *response, size_t response_sz)
+{
+	struct pci_doe_mb *doe = priv;
+	ssize_t rc;
+
+	/*
+	 * CMA-SPDM operation in non-D0 states is optional (PCIe r6.2
+	 * sec 6.31.3).  The spec does not define a way to determine
+	 * if it's supported, so resume to D0 unconditionally.
+	 */
+	rc = pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	rc = pci_doe(doe, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_CMA,
+		     request, request_sz, response, response_sz);
+
+	pm_runtime_put(dev);
+
+	return rc;
+}
+
+void pci_cma_init(struct pci_dev *pdev)
+{
+	struct pci_doe_mb *doe;
+
+	if (IS_ERR(pci_cma_keyring))
+		return;
+
+	if (!pci_is_pcie(pdev))
+		return;
+
+	doe = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+				   PCI_DOE_FEATURE_CMA);
+	if (!doe)
+		return;
+
+	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
+				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring,
+				       NULL);
+	if (!pdev->spdm_state)
+		return;
+
+	/*
+	 * Keep spdm_state allocated even if initial authentication fails
+	 * to allow for provisioning of certificates and reauthentication.
+	 */
+	spdm_authenticate(pdev->spdm_state);
+}
+
+void pci_cma_destroy(struct pci_dev *pdev)
+{
+	if (!pdev->spdm_state)
+		return;
+
+	spdm_destroy(pdev->spdm_state);
+}
+
+__init static int pci_cma_keyring_init(void)
+{
+	pci_cma_keyring = keyring_alloc(".cma", KUIDT_INIT(0), KGIDT_INIT(0),
+					current_cred(),
+					(KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					KEY_USR_VIEW | KEY_USR_READ |
+					KEY_USR_WRITE | KEY_USR_SEARCH,
+					KEY_ALLOC_NOT_IN_QUOTA |
+					KEY_ALLOC_SET_KEEP, NULL, NULL);
+	if (IS_ERR(pci_cma_keyring)) {
+		pr_err("PCI: Could not allocate .cma keyring\n");
+		return PTR_ERR(pci_cma_keyring);
+	}
+
+	return 0;
+}
+arch_initcall(pci_cma_keyring_init);
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 62be9c8dbc52..344e01496a8e 100644
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
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e67014aa001..1ab1a39e8df3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -599,6 +599,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_PCI_CMA
+void pci_cma_init(struct pci_dev *pdev);
+void pci_cma_destroy(struct pci_dev *pdev);
+#else
+static inline void pci_cma_init(struct pci_dev *pdev) { }
+static inline void pci_cma_destroy(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCI_NPEM
 void pci_npem_create(struct pci_dev *dev);
 void pci_npem_remove(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..665532a07cfc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2706,6 +2706,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_cma_init(dev);		/* Component Measurement & Auth */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 417a9ea59117..b98d96919089 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -69,6 +69,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+	pci_cma_destroy(dev);
 	pci_doe_destroy(dev);
 	pci_ide_destroy(dev);
 	pcie_aspm_exit_link_state(dev);
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
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9357e9b00e1c..7384846ade19 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -39,6 +39,7 @@
 #include <linux/io.h>
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
+#include <linux/spdm.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -542,6 +543,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_PCI_CMA
+	struct spdm_state *spdm_state;	/* Security Protocol and Data Model */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.52.0

