Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1C3890EC
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310332; cv=none; b=WKBcakQ4M7+i4T72dhFCX49Ffu2WEvTntr+Vdm50Sveje7SX0HTa5Ik/flemy+ltp6NZbMsa9GX0UGu6hC7zcgM6qSrO6EiqREiZJOygzGJm50HrEYZNFS6NwU/1kTkDl+8Z1y8lWhAy+Fy3A9ICuyP/WUIaTQi/4vW7M35DyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310332; c=relaxed/simple;
	bh=l00LIHmX2FmWkYpSjP6Q+peOSbjX0cWvYczRtB6/PPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OggKv3uhnt2ZU18B4w8vKEbDW5GfE5eT9YoMOdzQpR3ei8jc2Fvs+QhnHaBGKdqwr54dM5JnqIt+m+csW2ZK+gwJZBDZOFjfGffee0Lf8RkkGnjXm7NYDF+11MVbBBTxpeg4/0Z9wPLo8XyjWUCFeUbtPk7fhNzL5O8vCqibrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIg1nEzq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIg1nEzq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35b901d542bso265192a91.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310328; x=1774915128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCGcH5x5HW+NRzEKEkZIp2gqKlZo/LGIoKmQ3sM/JLo=;
        b=hIg1nEzq82bKlCD8cGLW1/bMAov6oOdwDux59+GdjIx8RqTysB6T+jrl0B95VUknVV
         4lYrJ2YnYqK+txBL8gaIXpBZ+GN1C0LMFd54OJiE36GQn8znAQrOmAkaAM8Jj4lir0Gs
         NG7BfovrRadhImYowOKg6Sfi2D8SmIDBXG7EPP7dCJZnc004J4AUvN2HlwEqADgGOIwd
         3BuXaIAuVhRb8/8MWWQp9m827fs9UCVweyAyErS616OsWAJ5niWsSWnJM5cNhSHh8Kup
         DS6oSwNEhxNV+X/9swNSqWqJ+Dm+VjRDnjKUj7BZ/7o3VpR+hfDzpAgin6edngvqGz32
         lX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310328; x=1774915128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCGcH5x5HW+NRzEKEkZIp2gqKlZo/LGIoKmQ3sM/JLo=;
        b=ECLCIY1I5sBfDFRpM74H8pUJvMZ416gshrSI9ot/Tq2EPpsi8D+lncyQHEWod7Gwiw
         SXbPLEFhvPJQ0/eM8rwe1CN4BhGUuIPFtz02WHK+ZgbeggbP0M09TGgstjdDfj2D+6kV
         s2JFRG7/b7wB8DHle2Of/wjNIZw0WiaHsq/PJJI8CmfiEF6x8a9Fm8vVsITDCY522qMJ
         NA/icubk6yDeY73pE0PQQhPG+obMSw4MHF51Cs3FtDtoo3VE2vyORZjjcVGDkFvLSFk/
         FCX3jrPZnYgbKDtd8c6xdl51l4h1cppq2BiRslaOdypvYkN+n/eMV09JgJfkBT89qI+m
         3LwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQop6FM3Dtp3TbXuxusDXcLQ1GzTdYoWDpvJB2TzgxldMN7RF/ExKHM5j1l3q/lQPy/s3qo6di1Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKX9Knff0SULELR3eKQey2/MVylfnBFY8moYckZx8eo4vJQkE
	HXtF/F+ZmUQTT8utkyaDKuPwDm5hYPcFgRNoeZkshUSrrCsHhGfqnNZV/+GGyw9klEPtge7gUvW
	1NT6kfXGmiNdxGQ==
X-Received: from pjvp18.prod.google.com ([2002:a17:90a:df92:b0:35b:9822:9f79])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8a:b0:359:f43d:4a6e with SMTP id 98e67ed59e1d1-35bd2996301mr12903584a91.0.1774310327594;
 Mon, 23 Mar 2026 16:58:47 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:58 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-7-dmatlack@google.com>
Subject: [PATCH v3 06/24] vfio/pci: Register a file handler with Live Update Orchestrator
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Register a live update file handler for vfio-pci device files. Add stub
implementations of all required callbacks so that registration does not
fail (i.e. to avoid breaking git-bisect).

This file handler will be extended in subsequent commits to enable a
device bound to vfio-pci to run without interruption while the host is
going through a kexec Live Update.

Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE that is marked
experimental and default-disabled until more of the device preservation
support has landed in the kernel.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                            |  1 +
 drivers/vfio/pci/Kconfig               | 11 ++++
 drivers/vfio/pci/Makefile              |  1 +
 drivers/vfio/pci/vfio_pci.c            | 12 ++++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 69 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h       | 14 ++++++
 include/linux/kho/abi/vfio_pci.h       | 28 +++++++++++
 7 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76..a16a7ecc67a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27685,6 +27685,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
 F:	drivers/vfio/
+F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
 F:	include/linux/vfio_pci_core.h
 F:	include/uapi/linux/vfio.h
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 1e82b44bda1a..8f087f7b58c3 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -58,6 +58,17 @@ config VFIO_PCI_ZDEV_KVM
 config VFIO_PCI_DMABUF
 	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
 
+config VFIO_PCI_LIVEUPDATE
+	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
+	depends on VFIO_PCI && PCI_LIVEUPDATE
+	help
+	  Support for preserving devices bound to vfio-pci across a Live
+	  Update. This option should only be enabled by developers working on
+	  implementing this support. Once enough support has landed in the
+	  kernel, this option will no longer be marked EXPERIMENTAL.
+
+	  If you don't know what to do here, say N.
+
 source "drivers/vfio/pci/mlx5/Kconfig"
 
 source "drivers/vfio/pci/hisilicon/Kconfig"
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index e0a0757dd1d2..f462df61edb9 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
+vfio-pci-$(CONFIG_VFIO_PCI_LIVEUPDATE) += vfio_pci_liveupdate.o
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
 
 obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..41dcbe4ace67 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -170,6 +170,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = vfio_pci_core_register_device(vdev);
 	if (ret)
 		goto out_put_vdev;
+
 	return 0;
 
 out_put_vdev:
@@ -264,10 +265,14 @@ static int __init vfio_pci_init(void)
 
 	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
 
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
 
@@ -275,12 +280,17 @@ static int __init vfio_pci_init(void)
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
index 000000000000..5ea5af46b159
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -0,0 +1,69 @@
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
+#include <linux/kho/abi/vfio_pci.h>
+#include <linux/liveupdate.h>
+#include <linux/errno.h>
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
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
+	return 0;
+}
+
+void vfio_pci_liveupdate_cleanup(void)
+{
+       liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 27ac280f00b9..cbf46e09da30 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -133,4 +133,18 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
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
index 000000000000..e2412b455e61
--- /dev/null
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
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
2.53.0.983.g0bb29b3bc5-goog

