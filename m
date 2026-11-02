Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633825;
	b=jmp5D78QTl5hgoQZWRjT5PRKdoAzsFJaWjqS40VkjNP8e4iq9kGywgfjFyvR93bAZwXq
	 5G196w8s5D8rcYxMUEfNM2CTNn1V7ppOU5CP14zYI7NFcb572oS09UGbVOTw++IHG2jiJ
	 U1ezLJfiYpOIw6CGHkYHCNHrONcY5Hp5s+cp2Qgej6kDEpK6VKH+e0hAGLL2+VnkmH7FX
	 K2moMzqQ9Dsq0GoBoQoTVUQZmv3SkFddtrFtCT7s9q9LzP++7oe6EscDBDVbFE6Dr+Xbj
	 vqV9ESav6SshaJecEVyVHUy47uPaRFX3bZJxYzF5hqRtHEJzDTBVKYFPyjWx8iSAn2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gBehZpEkki34QiJCaFptvQANMlmxsUHjEKEQ/Cb0BiU=;
	b=LnuFrsgBnuqvRwezvp34DA0HV7zHFGvsnc329B8PZUlCX2CWxLogkRCEYCVvYXVdOx3n
	 uCKcWZvcwoKUeO53A1zyKGhpayZgF0hTeWneuE9EWYxOUMNgcjuMET9c5nEJf9MDQ1rDl
	 dM8XTTRMr/1gJBBlyfqQebLo1WPVvNgorNzXxE0dzxKCu1DAC1NLIoC5ozaEUMIlkPYjZ
	 xLPNOJPhgSJDeBSjkJ/YGpQ/u2Hu0CG67Pm6vYr04paTsC/Ywb2WDzEr7jEbyaEaRD18U
	 gxsSerNLIV6mqQYxubBEufH+nG1tOgcA/TKOGEjoVaX6duBY4AqpI0P4DwCXrZvA6YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ARjwfXYF;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019A60E34F2
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0019A60E34F2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ARjwfXYF
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aed1b64104so738758a91.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633824; x=1794238624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBehZpEkki34QiJCaFptvQANMlmxsUHjEKEQ/Cb0BiU=;
        b=ARjwfXYFECdqV30f+T60hRziGahjSsXoWCZtunvRAJD6A2d7zZYliCjmS4a/+YwgW7
         iiXJYCyag9U7vVa4cu5pJiJgoX29UcVCRWlgi9oqX4xJ4vZNukXo0ae4WDDRrfNEQdYJ
         4+gFo/uSGBFE135fByaFMMrz6H8nH/jJYk72iwYj0TjFrxNqm+MYXq4sBjgesz5JqDlt
         ud2hHCFO26i0oyfuNP/wes/dplcyPIFHV+XP2taCbM+vfsRl0ug2mPRKyhmzSq04g7zx
         Yiriy+STLFo7a2fNPxooqWxosI4yntbmwIVAEG+DsoEyygOYoosP3s/zqJ0yumQi7IN/
         5EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633824; x=1794238624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBehZpEkki34QiJCaFptvQANMlmxsUHjEKEQ/Cb0BiU=;
        b=yIbS+nVr3mHUCgHvB0IrxRK89jxiUofnKQYf8UMsdromwk4y/T6En9WViSJQiAWSzU
         j9K4YXCdpjTvlyFlesRk0JgoknBh7OSckgNAtROIq5dOk9WXt8uEBhCkg2yIMLzm4eT3
         AFwdSkToaXPQb7k8pwHSVAsI5Xbc2TzJg4idy+ndFJSCBKJ2EDThab/0rJgAwEoaRhVl
         yIPRnCUYsVoRXmZi158Nhs0wQxJ2IHuGCMZXMDefIOiUEE+ZL4qrnOKvjllER9f+aM3u
         Rwy0m/SMJCZa+VA7jlWyvjEJToTDxjpD3ZUz6/OQc2VOt/bbthabWcNEJPg9ZxUmESWV
         pbfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBrhmZt+4XDeDgI2XRxss2x+qtuU2SzWuOp3TeVUx0Oovo8teh4S3MjCERCbL81HwqNMPasmBbIGU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+awWdv36g04tNe9Ot3u6ez7uSC7UnFsGLKNjxzspgjnUVIORVg
	LSBsoXbrzpsXDvmwkoC+c6jaQ3IoeIFK5lXxmqdxI3Zv/2H/6jRXQ2G7C7MkS1J086pwkYHnN8c
	fUB7S7x9LXA==
X-Received: from pjzr10.prod.google.com ([2002:a17:90b:50a:b0:3a8:22c8:d19b])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c5:b0:3ac:a139:1b14
 with SMTP id 98e67ed59e1d1-3ae8984acc9mr9407724a91.57.1793633824222; Mon, 02
 Nov 2026 07:37:04 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:33 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-5-vipinsh@google.com>
Subject: [PATCH v6 04/27] vfio/pci: Register a file handler with Live Update Orchestrator
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Register a live update file handler for vfio-pci device files. Add stub
implementations of all required callbacks so that registration does not
fail. Register it with both live update framework and PCI subsystem.

This file handler will be extended in subsequent commits to enable a
device bound to vfio-pci to run without interruption while the host is
going through a kexec Live Update.

Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE. Initial
support is added for no-iommu model vfio-pci devices.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 MAINTAINERS                            |  1 +
 drivers/vfio/pci/Kconfig               | 11 ++++
 drivers/vfio/pci/Makefile              |  1 +
 drivers/vfio/pci/vfio_pci.c            | 11 +++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 75 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h       | 14 +++++
 include/linux/kho/abi/vfio_pci.h       | 28 ++++++++++
 7 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d1b58271989..167aa9d66ce8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28662,6 +28662,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
+F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
 F:	include/linux/vfio_pci_core.h
 F:	include/uapi/linux/vfio.h
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..e8285ad93a69 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -42,6 +42,17 @@ config VFIO_PCI_IGD
 	  and LPC bridge config space.
 
 	  To enable Intel IGD assignment through vfio-pci, say Y.
+
+config VFIO_PCI_LIVEUPDATE
+	bool "VFIO PCI support for Live Update in no-iommu mode"
+	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU
+	help
+	  Support for preserving devices bound to vfio-pci in no-iommu mode
+	  across a Live Update. It enables a device to continue working (DMA)
+	  while host kernel is going through a kexec live update.
+
+	  If you don't know what to do here, say N.
+
 endif
 
 config VFIO_PCI_ZDEV_KVM
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..bf296ab1c967 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
+vfio-pci-$(CONFIG_VFIO_PCI_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
 
 obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 2ec600768007..9d48b250a5e8 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -278,10 +278,14 @@ static int __init vfio_pci_init(void)
 {
 	int ret;
 
+	ret = vfio_pci_liveupdate_init();
+	if (ret)
+		return ret;
+
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
 	if (ret)
-		return ret;
+		goto err_liveupdate_cleanup;
 
 	vfio_pci_fill_ids();
 
@@ -289,12 +293,17 @@ static int __init vfio_pci_init(void)
 		pr_warn("device denylist disabled.\n");
 
 	return 0;
+
+err_liveupdate_cleanup:
+	vfio_pci_liveupdate_cleanup();
+	return ret;
 }
 module_init(vfio_pci_init);
 
 static void __exit vfio_pci_cleanup(void)
 {
 	pci_unregister_driver(&vfio_pci_driver);
+	vfio_pci_liveupdate_cleanup();
 }
 module_exit(vfio_pci_cleanup);
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
new file mode 100644
index 000000000000..8fd5af4f4b83
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/errno.h>
+#include <linux/kho/abi/vfio_pci.h>
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+
+#include "vfio_pci_priv.h"
+
+static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
+					     struct file *file)
+{
+	return false;
+}
+
+static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
+{
+}
+
+static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
+{
+	return -EOPNOTSUPP;
+}
+
+static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
+{
+}
+
+static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
+	.can_preserve = vfio_pci_liveupdate_can_preserve,
+	.preserve = vfio_pci_liveupdate_preserve,
+	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.retrieve = vfio_pci_liveupdate_retrieve,
+	.finish = vfio_pci_liveupdate_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
+	.ops = &vfio_pci_liveupdate_file_ops,
+	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
+};
+
+int __init vfio_pci_liveupdate_init(void)
+{
+	int ret;
+
+	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+	if (ret)
+		return ret == -EOPNOTSUPP ? 0 : ret;
+
+	ret = pci_liveupdate_register_flb(&vfio_pci_liveupdate_fh);
+	if (ret)
+		liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+
+	return ret;
+}
+
+void vfio_pci_liveupdate_cleanup(void)
+{
+	pci_liveupdate_unregister_flb(&vfio_pci_liveupdate_fh);
+	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 1634135de3f8..872b01bcb5a3 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -148,4 +148,18 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 }
 #endif
 
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+int __init vfio_pci_liveupdate_init(void);
+void vfio_pci_liveupdate_cleanup(void);
+#else
+static inline int vfio_pci_liveupdate_init(void)
+{
+	return 0;
+}
+
+static inline void vfio_pci_liveupdate_cleanup(void)
+{
+}
+#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
+
 #endif
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
new file mode 100644
index 000000000000..67e8199eec59
--- /dev/null
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Vipin Sharma <vipinsh@google.com>
+ * David Matlack <dmatlack@google.com>
+ */
+
+#ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+#define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
+
+/**
+ * DOC: VFIO PCI Live Update ABI
+ *
+ * VFIO uses the ABI defined below for preserving device files across a kexec
+ * reboot using LUO.
+ *
+ * Device metadata is serialized into memory which is then handed to the next
+ * kernel via KHO.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the VFIO_PCI_LUO_FH_COMPATIBLE string.
+ */
+
+#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
+
+#endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
-- 
2.56.0.317.g454f8302e1-goog

