Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06E370D7C
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289312; cv=none; b=E0m1STHwrw7p034FsKsAAzHXxucWPKA4GQFMrRLPsRmMFNr8ducMHJtIEcJmHbX9H0eiIQeGyJihqsfYnGABCcnV4lWbZOIzDqcLivIgqPe7M3f8sGd5Nd+idTt86Bw8N63f0VeFNjYvolC2doRcodj4THoE/xjmajs+m1BqkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289312; c=relaxed/simple;
	bh=tRHN9XRDNqUwBn+zEjs4BrUxA3DvOhjBwakMx07O2aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuSLiydu1HOwndIa6z23iJyfxwyqvus1cEb42sXOmrvv0k8YT6PUmj1HXTGV3ApQjYFvqOzxJ5sAWzpafN8cO3v6L5YMSfubbB+3oaKbb2lOpFZ8eGoURG8n0OsI3VjTQq427gE4JrvZ/YnQ2KTQzqBOeeWwiftyks+Bqd9TnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmIPjJbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmIPjJbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964881F00AC4;
	Sun,  5 Jul 2026 22:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289311;
	bh=SmA/JSmESj3ZmLdBl7V9IokWHV+lklm35LGu985fgVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmIPjJbQa4869kQtF+rFVeyt2FaOOaa8smNR2QQR7VpU7hhSNh1mwW5sMCL7cEVAT
	 PaMrNkEsY+bM7L4nGH8RI2IW9H9kUBx/FyPGSfV8zGERvGGiZVlzjJna/KR7iP6LhV
	 0kZglx6DT74Ta5j3tamTZaK4dSH30nfDQqZ7N58954vURGbbb15rGFjhm6GTf6nSXg
	 z+gEqR20pBINQdqshaEyRYFmCIM8qRy0DtZBVIuOvRKAMAOqno+eWmruH+WeKd4fEc
	 a2sS1BBiX05j9orc1VjDLheWSgX26y9oExVaMKCTtcWjsucXKvT2cMPaAiZW4tKLXo
	 JiDNkHGY5hDKA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D2A18F40068;
	Sun,  5 Jul 2026 18:08:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 05 Jul 2026 18:08:29 -0400
X-ME-Sender: <xms:3dVKalODJ7u_ecAlrUp2CP0PPgTxdlNWSgYvUR2nXgOCEfNxdze3Pg>
    <xme:3dVKajznhPcV8Epe9EeYOQvBnjNP0hJsqud-jvZeWps5dw1mQq8zncLOrqosIXIaH
    HDHhkJrNXVbmWHLdOa0ikILp8QhXlUtA-7y0XrQAJNEhhlaGEVkXBE>
X-ME-Received: <xmr:3dVKavqV98ZucKvQA_EHtiQ9mQ79xcAkbTcLSwbpAeX2jH9H4Ll0LXXaYcMJ0tB91vkw_wx4L5Z3AJfVDVcUNGgmcRHht3oxofc>
X-ME-Proxy-Cause: dmFkZTEU3a0dSe6i6CnOusv7UQo5bUt4W374Va1VF/civ2vS1aE3CdRJhR/3RPbTyg9YoM
    8CAom15n8Hwdl1B+/h1BX21cW6wHDRg4U/cmaCbLlyhpdU2LCT1rVEv+DK0HS+o2M/AjWH
    iVWhfG60Pi2dVHPivMF97pXf3jaizvHlxfCRSpiIxhKNx/MolpL6UNttWlJWb4t4hB9Kae
    T3+coeSgiC7ftW/nhuCD0fxYogFKtnCGab8QGZDyZAEf35YW373TIPVGu01bfyvVSZEPke
    BOSEFEOFNVa9Ap4hLBIb48azcD8J8Qw9QsbuF8JLJ/whQvUozGx088ZgysnOjUfjuHjwDz
    TKQjNkPK0qI9WEWVhRT2bp2lu/ZkTQ9aOeMfxpOJhAsrDiSiqTB/9LhCazdODPNcHptWJi
    1UejESQXhYKm0DJdKaPGAajaGSKiORUuGjbJwo+7FziYZcl28wqT0/Y0VjDFpMTfIV6L/Y
    TWfrv4SC5n+I/4xR/N1KpDW083s2Etz/a9OYXYUUgojUakQcuCn6Aam/1AziqBi73rIvIm
    jakd3+pFSU/slrMpKJVVuXGQYHFPCWhM6PfM774k/dEEDud0RQikWsFDxTVMsy7YCIHmA4
    ZwGXy9d/3JLsUTJs6L41y9JZLz8b3xlo58BETgarzmS/HBWzPLhMr5FNg5Iw
X-ME-Proxy: <xmx:3dVKarO0T2n86cq--x1ZA7mFaGhFk-zKWzMs96A6Q5BS8WkcnKxyDw>
    <xmx:3dVKardY14jQxESy0N-sBFtRsYH47jnAq57BNO_MyOyZ1UWAGhc8MA>
    <xmx:3dVKapUBGGNbr4OGcbd1nGTJ1Pwr97Hj2tixCwBjFvs7Fl0iqHcHCA>
    <xmx:3dVKakCYmTfhF87DOOvjaTTl6h5_ko8qNYfMDXM8OcEf5ed9zbqm2A>
    <xmx:3dVKas7RmdhjVd9NatCmbE95QYXTEmswz0OpnNwNHHRCsSBd3IGS1wRu>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:29 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Lukas Wunner <lukas@wunner.de>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH 06/15] PCI/TSM: Add device evidence support
Date: Sun,  5 Jul 2026 15:08:10 -0700
Message-ID: <20260705220819.2472765-7-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register the PCI Trusted Execution Environment Security Manager (TSM)
framework with the device-evidence netlink ABI. The security operations
that PCI core coordinates with a device security manager (DSM) through a
platform TEE security manager (TSM), builds upon the SPDM protocol.

A TSM owns an SPDM session and publishes the corresponding evidence through
TSM firwmware ABIs. A low level TSM driver is responsible for creating a
'struct device_evidence' context and carrying out refresh_evidence()
requests for regenerating measurement transcripts with a nonce.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/pci/Kconfig               |   1 +
 drivers/pci/Makefile              |   2 +-
 drivers/pci/tsm/Makefile          |   8 +++
 include/linux/pci-tsm.h           |  14 ++++
 drivers/pci/{tsm.c => tsm/core.c} |   9 +--
 drivers/pci/tsm/evidence.c        | 110 ++++++++++++++++++++++++++++++
 MAINTAINERS                       |   2 +-
 7 files changed, 137 insertions(+), 9 deletions(-)
 create mode 100644 drivers/pci/tsm/Makefile
 rename drivers/pci/{tsm.c => tsm/core.c} (99%)
 create mode 100644 drivers/pci/tsm/evidence.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c7408509ba2..ed17b5d2d5ae 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -126,6 +126,7 @@ config PCI_IDE
 
 config PCI_TSM
 	bool "PCI TSM: Device security protocol support"
+	select DEVICE_EVIDENCE if NET
 	select PCI_IDE
 	select PCI_DOE
 	select TSM
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..211f195ff2c9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
-obj-$(CONFIG_PCI_TSM)		+= tsm.o
+obj-$(CONFIG_PCI_TSM)		+= tsm/
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/tsm/Makefile b/drivers/pci/tsm/Makefile
new file mode 100644
index 000000000000..fd7ac2e862f1
--- /dev/null
+++ b/drivers/pci/tsm/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the PCI/TSM infrastructure
+
+obj-$(CONFIG_PCI_TSM) += tsm.o
+
+tsm-y := core.o
+tsm-$(CONFIG_DEVICE_EVIDENCE) += evidence.o
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9..8bc16029d31e 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,7 +3,10 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/rwsem.h>
 #include <linux/sockptr.h>
+#include <linux/tsm.h>
+#include <linux/device/evidence.h>
 
 struct pci_tsm;
 struct tsm_dev;
@@ -18,6 +21,7 @@ enum pci_tsm_req_scope;
  * @devsec_ops: Lock, unlock, and interrogate the security state of the
  *		function via the platform TSM (typically virtual function
  *		operations).
+ * @refresh_evidence: Common operation to regenerate attestation objects
  *
  * This operations are mutually exclusive either a tsm_dev instance
  * manages physical link properties or it manages function security
@@ -75,6 +79,9 @@ struct pci_tsm_ops {
 					struct pci_dev *pdev);
 		void (*unlock)(struct pci_tsm *tsm);
 	);
+
+	int (*refresh_evidence)(struct pci_tsm *tsm, const void *nonce,
+				size_t nonce_len);
 };
 
 /**
@@ -96,6 +103,8 @@ struct pci_tdi {
  * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
  *	     Function Security operations
  * @tdi: TDI context established by the @bind link operation
+ * @evidence: cached evidence from SPDM session establishment (connect), or
+ *	      TDISP bind (lock)
  *
  * This structure is wrapped by low level TSM driver data and returned by
  * probe()/lock(), it is freed by the corresponding remove()/unlock().
@@ -112,6 +121,7 @@ struct pci_tsm {
 	struct pci_dev *dsm_dev;
 	struct tsm_dev *tsm_dev;
 	struct pci_tdi *tdi;
+	struct device_evidence *evidence;
 };
 
 /**
@@ -216,6 +226,10 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
 			  size_t out_len, u64 *tsm_code);
+static inline const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
+{
+	return tsm->tsm_dev->pci_ops;
+}
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm/core.c
similarity index 99%
rename from drivers/pci/tsm.c
rename to drivers/pci/tsm/core.c
index 5fdcd7f2e820..220842df42bc 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm/core.c
@@ -15,13 +15,13 @@
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
 #include <linux/xarray.h>
-#include "pci.h"
+#include "../pci.h"
 
 /*
  * Provide a read/write lock against the init / exit of pdev tsm
  * capabilities and arrival/departure of a TSM instance
  */
-static DECLARE_RWSEM(pci_tsm_rwsem);
+DECLARE_RWSEM(pci_tsm_rwsem);
 
 /*
  * Count of TSMs registered that support physical link operations vs device
@@ -30,11 +30,6 @@ static DECLARE_RWSEM(pci_tsm_rwsem);
 static int pci_tsm_link_count;
 static int pci_tsm_devsec_count;
 
-static const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
-{
-	return tsm->tsm_dev->pci_ops;
-}
-
 static inline bool is_dsm(struct pci_dev *pdev)
 {
 	return pdev->tsm && pdev->tsm->dsm_dev == pdev;
diff --git a/drivers/pci/tsm/evidence.c b/drivers/pci/tsm/evidence.c
new file mode 100644
index 000000000000..ffb08208f0c0
--- /dev/null
+++ b/drivers/pci/tsm/evidence.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 NVIDIA Corporation & Affiliates */
+
+#include <linux/device/evidence.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci-tsm.h>
+#include <linux/tsm.h>
+
+extern struct rw_semaphore pci_tsm_rwsem;
+
+static bool evidence_available(struct pci_dev *pdev)
+{
+	return pdev->tsm && pdev->tsm->evidence;
+}
+
+static struct device *pci_tsm_evidence_find_device(const char *name)
+{
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if (ACQUIRE_ERR(rwsem_read_intr, &lock))
+		return NULL;
+
+	struct device *dev __free(put_device) =
+		bus_find_device_by_name(&pci_bus_type, NULL, name);
+
+	/*
+	 * Bail evidence gathering early if we know at this point that
+	 * the device has no valid evidence provider, but still need to
+	 * revalidate the same in pci_tsm_evidence_read_begin().
+	 */
+	if (!dev || !evidence_available(to_pci_dev(dev)))
+		return NULL;
+
+	return no_free_ptr(dev);
+}
+
+static struct device_evidence *pci_tsm_evidence_read_begin(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device_evidence *evidence;
+	int rc;
+
+	rc = down_read_interruptible(&pci_tsm_rwsem);
+	if (rc)
+		return ERR_PTR(rc);
+
+	if (!evidence_available(pdev))
+		goto err;
+
+	/* Hold the evidence stable against conflicting refresh updates */
+	evidence = pdev->tsm->evidence;
+	rc = down_read_interruptible(&evidence->lock);
+	if (rc)
+		goto err;
+
+	return evidence;
+err:
+	up_read(&pci_tsm_rwsem);
+	return ERR_PTR(-ENXIO);
+}
+
+static void pci_tsm_evidence_read_end(struct device_evidence *evidence)
+{
+	up_read(&evidence->lock);
+	up_read(&pci_tsm_rwsem);
+}
+
+static int pci_tsm_refresh_evidence(struct device *dev, const void *nonce,
+				    size_t nonce_len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device_evidence *evidence;
+	const struct pci_tsm_ops *ops;
+	int rc;
+
+	/* Sync against disconnect */
+	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
+		return rc;
+
+	if (!pdev->tsm)
+		return -ENXIO;
+
+	ops = to_pci_tsm_ops(pdev->tsm);
+	if (!ops->refresh_evidence)
+		return -EOPNOTSUPP;
+
+	/* Sync against pci_tsm_evidence_read_begin */
+	evidence = pdev->tsm->evidence;
+	ACQUIRE(rwsem_write_kill, elock)(&evidence->lock);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &elock)))
+		return rc;
+
+	return ops->refresh_evidence(pdev->tsm, nonce, nonce_len);
+}
+
+static const struct device_evidence_ops pci_tsm_evidence_ops = {
+	.subsys_name = "pci",
+	.find_device = pci_tsm_evidence_find_device,
+	.evidence_read_begin = pci_tsm_evidence_read_begin,
+	.evidence_read_end = pci_tsm_evidence_read_end,
+	.refresh_evidence = pci_tsm_refresh_evidence,
+};
+
+static int __init pci_tsm_evidence_init(void)
+{
+	return device_evidence_register(&pci_tsm_evidence_ops);
+}
+subsys_initcall(pci_tsm_evidence_init);
diff --git a/MAINTAINERS b/MAINTAINERS
index cb4f74957f69..6cefaddc1120 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27472,7 +27472,7 @@ F:	Documentation/driver-api/coco/
 F:	Documentation/driver-api/pci/tsm.rst
 F:	Documentation/netlink/specs/device-evidence.yaml
 F:	drivers/base/*evidence*
-F:	drivers/pci/tsm.c
+F:	drivers/pci/tsm/
 F:	drivers/virt/coco/guest/
 F:	include/uapi/linux/device-evidence.h
 F:	include/linux/device/evidence.h
-- 
2.54.0

