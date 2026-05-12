Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F1348875
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611736; cv=none; b=kmpETJ3Bo6CXol03vnESRbqDbmoB+AmfOA1AYs8UrP7BYc/saXAQYhMalNVvtQNOJxTcHaLxlDku/LFp2p1hWppAnlaa4fxLEHXZs3GSlFU4+YHN9aaY1JcNnm0A0VUWx9+x+kwDhAdMPslQo+GYzg8AZEBHuAqcVMvdjworBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611736; c=relaxed/simple;
	bh=T8S/VlQHm/jaf8lCWAY1cva1xZ3EX/+cDtsnVSKAce4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pvv/90k8lL+RnclaEhlBmLi+Wpf7hFZzAx/p2/NCFPwJ1OiJVmlx152hsW9pg0wot4jGgl8QDGvcPtqyUCtkaVfnzCakKkK2pKdFZFjkfnqPqZWsBovAjGBA3iwPkl2cu+PtD8MyyAA+tiy7wL0WYZruiHR5Vs3Y2TOxuo4PG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qg08h23Z; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qg08h23Z"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so6012500b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611734; x=1779216534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRPMEjK5N2pbYThoIfW7Ke0tk0ug6zfSh2dkLV6x6RU=;
        b=qg08h23ZyNcJCsPt2cA9qLTdNoTLrdYeXDFIlaj/imhFhk0P5umj5UpyDKGCxWdPZA
         yqIhW/PURbowWAlr0flQgc2ZTR+BHPEj3llqFdRD3msD4DadklmmWFgp9xO2nGVIqICR
         +uT7+82vx6LhquDP4n4Q6guKLVxknepNbCb9XEZ7iJ0H3YR+ohgeTccUJq9meqCsc0d1
         Lgz7QL8NVDlQc2xhb72A18CsMUaPlH6Um+3l9/8J5Yrhad/KS/QT8VFHS3wmF72MKmem
         zU6AORU2+89QHrV5LfFcuys9crY6k61crlgIsCx9JZOel0/vmhH8m7xVyTlTwVSmdBHx
         0BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611734; x=1779216534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRPMEjK5N2pbYThoIfW7Ke0tk0ug6zfSh2dkLV6x6RU=;
        b=V2K0LJVo0OhEdaxOvKmGcY4bHHcCze8S7YwwNp0hYE5S3vT43d8NyA9tzeN2SV+WP3
         fcb0cKjdxUbMFlhx6VJwWS+A5gUNk/9VYRsEzL/bjqmJwK2Ib1Vt1Uin+aM5Pk+utpmU
         dIBSjKcJfFt44uD9Su0/Zqp7PNSzNKym+d0t/3Te+kYDq/jNfAW7oBSvqQaCPCLdG+6X
         gR4lWKMdRQ5UgcbHrNv7xPjGKl++RJLxUEv+o8M1FdwSQ5CqlGWiu5u3qLWHtqMjL7jd
         iQnnC2axydFiSumJuPKT06WbFfROPOgrAmpiJ0kJJ5TsSIU/JO6DVvqfQXk3lVzFk0Y7
         r6Sw==
X-Forwarded-Encrypted: i=1; AFNElJ9X8E8o8Ji6+Rov5QG0vDAjdNW1TkgqwqdBFBlJa5x2DBfMiLOeQXYdLHFtDNdnVP5BXeEtujLfVFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kGOA+Jzl1oEpCwuDECqHDLpWIgR44ozfBHrJMnR/vXgU5sWk
	2SHY4D9BFBABMRFMQSq8RuiShemdOxPurbnGwLJ3zs2eoFMT9iQofklAfygKaYhsFzmzP483NYv
	hTd4LJc3CLo+bZQ==
X-Received: from pfblh16.prod.google.com ([2002:a05:6a00:7110:b0:82f:805:b62a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:929d:b0:82f:1b42:11d0 with SMTP id d2e1a72fcca58-83e39948512mr15528636b3a.15.1778611733501;
 Tue, 12 May 2026 11:48:53 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:38 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-4-dmatlack@google.com>
Subject: [PATCH v5 03/11] PCI: liveupdate: Track incoming preserved PCI devices
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

During PCI enumeration, the previous kernel might have passed state about
devices that were preserved across kexec. The PCI core needs to fetch
this state to identify which devices are "incoming" and require special
handling.

Add pci_liveupdate_setup_device() which is called during device setup
to fetch the serialized state (struct pci_ser) from the Live Update
Orchestrator. The first time this happens, pci_flb_retrieve() will run
and convert the array of pci_dev_ser structs into an xarray so that it
can be looked up efficiently.

If a device is found in the xarray, the PCI core stores a pointer to its
state in dev->liveupdate_incoming and holds a reference to the incoming
FLB until pci_liveupdate_finish() is called by the driver.

This ensures proper lifecycle management for incoming preserved devices
and allows the PCI core and drivers to apply specific Live Update
logic to them in subsequent commits.

Drivers can check if a device is an incoming preserved device (e.g.
during probe) by calling pci_liveupdate_is_incoming().

CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that the
domain and bdf can be guaranteed to fit in an unsigned long and be used
as the xarray key.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                    |   1 +
 drivers/pci/Kconfig            |   2 +-
 drivers/pci/liveupdate.c       | 223 ++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h       |  26 ++++
 drivers/pci/probe.c            |   5 +
 include/linux/pci_liveupdate.h |  13 ++
 6 files changed, 267 insertions(+), 3 deletions(-)
 create mode 100644 drivers/pci/liveupdate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c618830cf61..0e262c0ceb43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20537,6 +20537,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	drivers/pci/liveupdate.c
+F:	drivers/pci/liveupdate.h
 F:	include/linux/kho/abi/pci.h
 F:	include/linux/pci_liveupdate.h
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 08398cbe970c..eea0a6cd388a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
 
 config PCI_LIVEUPDATE
 	bool "PCI Live Update Support (EXPERIMENTAL)"
-	depends on PCI && LIVEUPDATE
+	depends on PCI && LIVEUPDATE && 64BIT
 	help
 	  Enable PCI core support for preserving PCI devices across Live
 	  Update. This, in combination with support in a device's driver,
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 9c4582ecd55c..f14396dd1477 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -56,6 +56,20 @@
  * This allows the PCI core to keep its FLB data (struct pci_ser) up to date
  * with the list of **outgoing** preserved devices for the next kernel.
  *
+ * After kexec, whenever a device is enumerated, the PCI core will check if it
+ * is an **incoming** preserved device (i.e. preserved by the previous kernel)
+ * by checking the incoming FLB data (struct pci_ser).
+ *
+ * Drivers must notify the PCI core when an **incoming** device is done
+ * participating in the incoming Live Update with the following API:
+ *
+ *  * ``pci_liveupdate_finish(pci_dev)``
+ *
+ * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
+ * ``pci_liveupdate_preserve()``. i.e. A PCI device can be **outgoing**
+ * (preserved for next kernel) and **incoming** (preserved by previous kernel)
+ * at the same time.
+ *
  * Restrictions
  * ============
  *
@@ -75,6 +89,8 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 
+#include "liveupdate.h"
+
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
  * @ser: The outgoing struct pci_ser for the next kernel.
@@ -85,6 +101,21 @@ struct pci_flb_outgoing {
 	struct mutex lock;
 };
 
+/**
+ * struct pci_flb_incoming - Incoming PCI FLB object
+ * @ser: The incoming struct pci_ser from the previous kernel.
+ * @xa: Xarray used to quickly lookup devices in @ser.
+ */
+struct pci_flb_incoming {
+	struct pci_ser *ser;
+	struct xarray xa;
+};
+
+static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
+{
+	return domain << 16 | bdf;
+}
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing;
@@ -140,13 +171,44 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 
 static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
-	args->obj = phys_to_virt(args->data);
+	struct pci_flb_incoming *incoming;
+	int i, ret;
+
+	incoming = kmalloc_obj(*incoming);
+	if (!incoming)
+		return -ENOMEM;
+
+	incoming->ser = phys_to_virt(args->data);
+
+	xa_init(&incoming->xa);
+
+	for (i = 0; i < incoming->ser->max_nr_devices; i++) {
+		struct pci_dev_ser *dev_ser = &incoming->ser->devices[i];
+		unsigned long key;
+
+		if (!dev_ser->refcount)
+			continue;
+
+		key = pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
+		ret = xa_err(xa_store(&incoming->xa, key, dev_ser, GFP_KERNEL));
+		if (ret) {
+			xa_destroy(&incoming->xa);
+			kfree(incoming);
+			return ret;
+		}
+	}
+
+	args->obj = incoming;
 	return 0;
 }
 
 static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 {
-	kho_restore_free(args->obj);
+	struct pci_flb_incoming *incoming = args->obj;
+
+	xa_destroy(&incoming->xa);
+	kho_restore_free(incoming->ser);
+	kfree(incoming);
 }
 
 static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
@@ -268,6 +330,163 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
 
+static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
+{
+	struct pci_flb_incoming *incoming = NULL;
+	int ret;
+
+	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
+
+	/* Live Update is not enabled. */
+	if (ret == -EOPNOTSUPP)
+		return NULL;
+
+	/* Live Update is enabled, but there is no incoming FLB data. */
+	if (ret == -ENODATA)
+		return NULL;
+
+	/*
+	 * Live Update is enabled and there is incoming FLB data, but none of it
+	 * matches pci_liveupdate_flb.compatible.
+	 *
+	 * This could mean that no PCI FLB data was passed by the previous
+	 * kernel, but it could also mean the previous kernel used a different
+	 * compatibility string (i.e. a different ABI).
+	 */
+	if (ret == -ENOENT) {
+		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
+		return NULL;
+	}
+
+	/*
+	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
+	 * but it cannot be retrieved.
+	 */
+	if (ret) {
+		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
+		return NULL;
+	}
+
+	return incoming;
+}
+
+static void pci_liveupdate_flb_put_incoming(void)
+{
+	liveupdate_flb_put_incoming(&pci_liveupdate_flb);
+}
+
+void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+	struct pci_flb_incoming *incoming;
+	struct pci_dev_ser *dev_ser;
+	unsigned long key;
+
+	incoming = pci_liveupdate_flb_get_incoming();
+	if (!incoming)
+		return;
+
+	key = pci_ser_xa_key(pci_domain_nr(dev->bus), pci_dev_id(dev));
+	dev_ser = xa_load(&incoming->xa, key);
+
+	/* This device was not preserved across Live Update */
+	if (!dev_ser) {
+		pci_liveupdate_flb_put_incoming();
+		return;
+	}
+
+	/*
+	 * This device was preserved, but has already been probed and gone
+	 * through pci_liveupdate_finish(). This can happen if PCI core probes
+	 * the same device multiple times, e.g. due to hotplug.
+	 */
+	if (!dev_ser->refcount) {
+		pci_liveupdate_flb_put_incoming();
+		return;
+	}
+
+	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
+	guard(write_lock)(&dev->liveupdate.lock);
+	dev->liveupdate.incoming = dev_ser;
+
+	/*
+	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
+	 * that dev->liveupdate.incoming does not get freed while it is in use.
+	 */
+}
+
+void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+	bool incoming;
+
+	scoped_guard(write_lock, &dev->liveupdate.lock)
+		incoming = !!xchg(&dev->liveupdate.incoming, NULL);
+
+	/*
+	 * Drop the FLB reference acquired in pci_liveupdate_setup_device() if
+	 * the device is being cleaned up before pci_liveupdate_finish(), e.g.
+	 * due to allocation failure during setup.
+	 *
+	 * Do not drop dev->liveupdate.incoming->refcount since this device has
+	 * not gone through pci_liveupdate_finish() and thus is still an
+	 * incoming preserved device.
+	 */
+	if (incoming)
+		pci_liveupdate_flb_put_incoming();
+}
+
+/**
+ * pci_liveupdate_finish() - Finish the preservation of a PCI device across Live Update
+ * @dev: The PCI device
+ *
+ * pci_liveupdate_finish() notifies the PCI core that a PCI device that was
+ * preserved across the previous Live Update has finished participating in Live
+ * Update. Drivers must call pci_liveupdate_finish() from their struct
+ * liveupdate_file_handler finish() callback to ensure the incoming struct
+ * pci_ser is allocated.
+ */
+void pci_liveupdate_finish(struct pci_dev *dev)
+{
+	guard(write_lock)(&dev->liveupdate.lock);
+
+	if (!dev->liveupdate.incoming) {
+		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
+		return;
+	}
+
+	pci_info(dev, "Device is finished participating in Live Update\n");
+
+	/*
+	 * Drop the refcount so this device does not get treated as an incoming
+	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
+	 * again because the device is hot-plugged.
+	 */
+	dev->liveupdate.incoming->refcount = 0;
+	dev->liveupdate.incoming = NULL;
+
+	/* Drop this device's reference on the incoming FLB. */
+	pci_liveupdate_flb_put_incoming();
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
+
+/**
+ * pci_liveupdate_is_incoming() - Check if a device is incoming preserved
+ * @dev: The PCI device to check
+ *
+ * Check if a device was preserved across Live Update by the previous kernel,
+ * i.e. the device is incoming preserved. Note that a device is only considered
+ * incoming preserved prior to pci_liveupdate_finish(). It is up to drivers to
+ * synchronize usage of pci_liveupdate_is_incoming() with their own call to
+ * pci_liveupdate_finish() to avoid acting on stale data.
+ *
+ * Returns: True if the device is incoming preserved, false otherwise.
+ */
+bool pci_liveupdate_is_incoming(struct pci_dev *dev)
+{
+	guard(read_lock)(&dev->liveupdate.lock);
+	return dev->liveupdate.incoming;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_is_incoming);
+
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
  * @fh: The file handler to register.
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
new file mode 100644
index 000000000000..eaaa3559fd77
--- /dev/null
+++ b/drivers/pci/liveupdate.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Live Update support (core API)
+ *
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+#ifndef DRIVERS_PCI_LIVEUPDATE_H
+#define DRIVERS_PCI_LIVEUPDATE_H
+
+#include <linux/pci.h>
+
+#ifdef CONFIG_PCI_LIVEUPDATE
+void pci_liveupdate_setup_device(struct pci_dev *dev);
+void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+#else
+static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
+{
+}
+
+static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+}
+#endif
+
+#endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 54ae32cb0000..b5fdc5017f92 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include "liveupdate.h"
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2069,6 +2070,8 @@ int pci_setup_device(struct pci_dev *dev)
 	if (pci_early_dump)
 		early_dump_pci_device(dev);
 
+	pci_liveupdate_setup_device(dev);
+
 	/* Need to have dev->class ready */
 	dev->cfg_size = pci_cfg_space_size(dev);
 
@@ -2192,6 +2195,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_liveupdate_cleanup_device(dev);
 		pci_release_of_node(dev);
 		return -EIO;
 
@@ -2490,6 +2494,7 @@ static void pci_release_dev(struct device *dev)
 
 	pci_dev = to_pci_dev(dev);
 	pci_release_capabilities(pci_dev);
+	pci_liveupdate_cleanup_device(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 0803d44becd5..1c2ee32ad058 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -17,10 +17,12 @@
  * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
  * @lock: Lock used to protect members of struct pci_liveupdate.
  * @outgoing: State preserved for the next kernel.
+ * @incoming: State preserved by the previous kernel.
  */
 struct pci_liveupdate {
 	rwlock_t lock;
 	struct pci_dev_ser *outgoing;
+	struct pci_dev_ser *incoming;
 };
 
 struct pci_dev;
@@ -30,6 +32,8 @@ int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
 int pci_liveupdate_preserve(struct pci_dev *dev);
 void pci_liveupdate_unpreserve(struct pci_dev *dev);
+void pci_liveupdate_finish(struct pci_dev *dev);
+bool pci_liveupdate_is_incoming(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -48,6 +52,15 @@ static inline int pci_liveupdate_preserve(struct pci_dev *dev)
 static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
 }
+
+static inline void pci_liveupdate_finish(struct pci_dev *dev)
+{
+}
+
+static inline bool pci_liveupdate_is_incoming(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* LINUX_PCI_LIVEUPDATE_H */
-- 
2.54.0.563.g4f69b47b94-goog

