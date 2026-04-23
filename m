Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6933BED5C
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979409; cv=none; b=p1WIxn59gQrOE9sCEDEaSnenSb+NAtK6ZpXFjiy3X+sE4dxIgPAhp05/DUkIHnx2IFrV2sh8kmpU5KulV52MBY066CaT4tr5dpzD91j8/nAyQOkhnyG5555D0V/IWezwdAJBl9uGfw9zSkrGG02H+EBFrtkq8Q7ZiQwA3ZOdaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979409; c=relaxed/simple;
	bh=lmCH11RetuzuaSSML9d3XWPKOuj/Ox/xuKogjwWNArY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BLL+OYlLUvQGc2t+mggHYbF/fsb2kjNpU4g11/iwG2tYDNAsADxtBGgjlKUR0K8Zjs1qGpSD6UoKrMpW1r7fF8YCG0e1OAbOqettBaKoLU1N3PwLbMQwY2NOzgLBAAZ6NcBHYzVKp+NHO87ZPkA+ADMbsN29ChXswUFV1/HlZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fuy+fWls; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fuy+fWls"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so4451887a12.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979402; x=1777584202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjMaEBohopo2Yfkm1Hw1N9aZDGPCAerYqbSdZNNS1LM=;
        b=Fuy+fWls4dtCpSL2XnbO3JFl88Kq3jXSQN5QTNaog979hA3L08Fm3+PJJ7Lcw2ptNN
         4MuQ1lNnRCtm6xp8gcH9f0QY+54zScvYGEjQnOMbB1HK39OW8Wn0MNffX1AlGh/O3cfo
         lG9WEkavKIyCWaJK1Up+lpP2sSvdajtiYN2EEoy06kSx5KFAppcnhhg3ECkfQLsWwkFC
         9jei27zHtMGoFZLTqcSLellhK/oiN4ngzIboKIBkmoM4+KrPGofw9d5uvEtTUq2pd3nl
         tzbbsF/WbfC4izmm496Oz25avJMtJGCkCRvh7sc0s0tDLQxh7QJsPJtQkCkKjxEaJWq/
         yhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979402; x=1777584202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjMaEBohopo2Yfkm1Hw1N9aZDGPCAerYqbSdZNNS1LM=;
        b=KN+A3QTELK2uBVKQNQn4EOcIuFxfcpeAQp54WP6iqRbmuSZdGnf1D4+exj8FzHUbve
         yRZenG46EhJGJ3JW1SzzPhrrDAEqv0iVNPZrj+owMk1yepBf18XrL9v4GjoGgKyHtmJl
         cO7C1tPpPqLshQ2fNTQLz0FWbxWpPH0axOBC7d3juoyuJGrmGZFiH7Cqbdz2yViQH7df
         UkMOGcr4ZhrUx9qPGRe1Qy7v5ZkgkrjiFDNvMmI1GchkMkUOGNAaVXFJVonFbhb90Wgu
         9G0Zk5aNJUMmgIa3unK8D3uLPEnPFZomsF1k8oQrlCvK0bux1jvvyBzCWIN0O7aOvqG4
         JD/w==
X-Forwarded-Encrypted: i=1; AFNElJ9eCjlrBk9Nt0JFDeC7u4XEEc8TIBmuoUIHpatcD055OwwkvU2j7gcNSYtUw5TNQrWo//7OEc1/VdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGPObQAkzmjhbPczyqY43KrJpr6aj4Rte/ktL9T9h07ACatr0Y
	B9ni7tTCHr4hpFFFMB43G0r9MYAUS2VoO/Jlt2+B4aq02rOpZWaJSwH3qCs7qdvLnoFO2uypTGO
	W6iHM0nWbjQJv5Q==
X-Received: from pgge8.prod.google.com ([2002:a63:db08:0:b0:c79:6636:f4c1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:158a:b0:3a2:c9a1:2c26 with SMTP id adf61e73a8af0-3a2c9a2b9ebmr18927671637.7.1776979401541;
 Thu, 23 Apr 2026 14:23:21 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:05 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-2-dmatlack@google.com>
Subject: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
it to participate in the preservation of PCI devices across Live Update.
Essentially, this commit enables the PCI core to allocate a struct
(struct pci_ser) and preserve it across a Live Update whenever at least
one device is preserved.

Preserving PCI devices across Live Update is built on top of the Live
Update Orchestrator's (LUO) support for file preservation. Drivers are
expected to expose a file to userspace to represent a single PCI device
and support preservation of that file. This is itended primarily to
support preservation of PCI devices bound to VFIO drivers.

This commit enables drivers to register their liveupdate_file_handler
with the PCI core so that the PCI core can do its own tracking and
enforcement of which devices are preserved.

  pci_liveupdate_register_flb(driver_file_handler);
  pci_liveupdate_unregister_flb(driver_file_handler);

When the first file (with a handler registered with the PCI core) is
preserved, the PCI core will be notified to allocate its tracking struct
(pci_ser). When the last file is unpreserved (i.e. preservation
cancelled) the PCI core will be notified to free struct pci_ser.

This struct is preserved across a Live Update using KHO and can be
fetched by the PCI core during early boot (e.g. during device
enumeration) so that it knows which devices were preserved.

Note that this commit only allocates struct pci_ser and preserves it
across Live Update. A subsequent commit will add an API for drivers to
tell the PCI core exactly which devices are being preserved.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 MAINTAINERS                 |  12 ++++
 drivers/pci/Kconfig         |  14 ++++
 drivers/pci/Makefile        |   1 +
 drivers/pci/liveupdate.c    | 139 ++++++++++++++++++++++++++++++++++++
 include/linux/kho/abi/pci.h |  61 ++++++++++++++++
 include/linux/pci.h         |  15 ++++
 6 files changed, 242 insertions(+)
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c9b7b6f9828e..94af31837375 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.rst
 
+PCI LIVE UPDATE
+M:	Bjorn Helgaas <bhelgaas@google.com>
+M:	David Matlack <dmatlack@google.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+Q:	https://patchwork.kernel.org/project/linux-pci/list/
+B:	https://bugzilla.kernel.org
+C:	irc://irc.oftc.net/linux-pci
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	drivers/pci/liveupdate.c
+F:	include/linux/kho/abi/pci.h
+
 PCI MSI DRIVER FOR ALTERA MSI IP
 L:	linux-pci@vger.kernel.org
 S:	Orphan
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 33c88432b728..08398cbe970c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -328,6 +328,20 @@ config VGA_ARB_MAX_GPUS
 	  Reserves space in the kernel to maintain resource locking for
 	  multiple GPUS.  The overhead for each GPU is very small.
 
+config PCI_LIVEUPDATE
+	bool "PCI Live Update Support (EXPERIMENTAL)"
+	depends on PCI && LIVEUPDATE
+	help
+	  Enable PCI core support for preserving PCI devices across Live
+	  Update. This, in combination with support in a device's driver,
+	  enables PCI devices to run and perform memory transactions
+	  uninterrupted during a kexec for Live Update.
+
+	  This option should only be enabled by developers working on
+	  implementing this support.
+
+	  If unsure, say N.
+
 source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..e8d003cb6757 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= pci-sysfs.o slot.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
+obj-$(CONFIG_PCI_LIVEUPDATE)	+= liveupdate.o
 endif
 
 obj-$(CONFIG_OF)		+= of.o
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
new file mode 100644
index 000000000000..d4fa61625d56
--- /dev/null
+++ b/drivers/pci/liveupdate.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+
+/**
+ * DOC: PCI Live Update
+ *
+ * The PCI subsystem participates in the Live Update process to enable drivers
+ * to preserve their PCI devices across kexec.
+ *
+ * .. note::
+ *    The support for preserving PCI devices across Live Update is currently
+ *    *partial* and should be considered *experimental*. It should only be
+ *    used by developers working on the implementation for the time being.
+ *
+ *    To enable the support, enable ``CONFIG_PCI_LIVEUPDATE``.
+ *
+ * File-Lifecycle-Bound (FLB) Data
+ * ===============================
+ *
+ * PCI device preservation across Live Update is built on top of the Live Update
+ * Orchestrator's (LUO) support for file preservation across kexec. Drivers
+ * are expected to expose a file to represent a single PCI device and support
+ * preservation of that file with ``ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)``.
+ * This allows userspace to control the preservation of devices and ensure
+ * proper lifecycle management while a device is preserved. The first intended
+ * use-case is preserving vfio-pci device files.
+ *
+ * The PCI core maintains its own state about what devices are being preserved
+ * across Live Update using a feature called File-Lifecycle-Bound (FLB) data in
+ * LUO.  Essentially, this allows the PCI core to allocate struct pci_ser when
+ * the first device (file) is preserved and free it when the last device (file)
+ * is unpreserved. After kexec, the PCI core can fetch the struct pci_ser (which
+ * was constructed by the previous kernel) from LUO at any time (e.g. during
+ * enumeration) so that it knows which devices were preserved.
+ *
+ * To enable the PCI core to be notified whenever a file representing a device
+ * is preserved, drivers must register their struct liveupdate_file_handler with
+ * the PCI core by using the following APIs:
+ *
+ *  * ``pci_liveupdate_register_flb(driver_file_handler)``
+ *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
+ */
+
+#define pr_fmt(fmt) "PCI: liveupdate: " fmt
+
+#include <linux/bsearch.h>
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/pci.h>
+#include <linux/liveupdate.h>
+#include <linux/mutex.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+#include <linux/sort.h>
+
+static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_dev *dev = NULL;
+	u32 max_nr_devices = 0;
+	struct pci_ser *ser;
+	unsigned long size;
+
+	/*
+	 * Allocate enough space to preserve all of the devices that are
+	 * currently present on the system. Extra padding can be added to this
+	 * in the future to increase the chances that there is enough room to
+	 * preserve devices that are not yet present on the system (e.g. VFs,
+	 * hot-plugged devices).
+	 */
+	for_each_pci_dev(dev)
+		max_nr_devices++;
+
+	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
+
+	pr_debug("Preserving struct pci_ser with room for %u devices\n",
+		 max_nr_devices);
+
+	ser = kho_alloc_preserve(size);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ser->max_nr_devices = max_nr_devices;
+	ser->nr_devices = 0;
+
+	args->obj = ser;
+	args->data = virt_to_phys(ser);
+	return 0;
+}
+
+static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
+{
+	struct pci_ser *ser = args->obj;
+
+	pr_debug("Unpreserving struct pci_ser\n");
+	WARN_ON_ONCE(ser->nr_devices);
+	kho_unpreserve_free(ser);
+}
+
+static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
+{
+	args->obj = phys_to_virt(args->data);
+	return 0;
+}
+
+static void pci_flb_finish(struct liveupdate_flb_op_args *args)
+{
+	kho_restore_free(args->obj);
+}
+
+static struct liveupdate_flb_ops pci_liveupdate_flb_ops = {
+	.preserve = pci_flb_preserve,
+	.unpreserve = pci_flb_unpreserve,
+	.retrieve = pci_flb_retrieve,
+	.finish = pci_flb_finish,
+	.owner = THIS_MODULE,
+};
+
+static struct liveupdate_flb pci_liveupdate_flb = {
+	.ops = &pci_liveupdate_flb_ops,
+	.compatible = PCI_LUO_FLB_COMPATIBLE,
+};
+
+int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
+{
+	pr_debug("Registering file handler \"%s\"\n", fh->compatible);
+	return liveupdate_register_flb(fh, &pci_liveupdate_flb);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_register_flb);
+
+void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
+{
+	pr_debug("Unregistering file handler \"%s\"\n", fh->compatible);
+	liveupdate_unregister_flb(fh, &pci_liveupdate_flb);
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unregister_flb);
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
new file mode 100644
index 000000000000..5c0e92588c00
--- /dev/null
+++ b/include/linux/kho/abi/pci.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * David Matlack <dmatlack@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_PCI_H
+#define _LINUX_KHO_ABI_PCI_H
+
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * DOC: PCI File-Lifecycle Bound (FLB) Live Update ABI
+ *
+ * This header defines the ABI for preserving core PCI state across kexec using
+ * Live Update File-Lifecycle Bound (FLB) data.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
+ */
+
+#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+
+/**
+ * struct pci_dev_ser - Serialized state about a single PCI device.
+ *
+ * @domain: The device's PCI domain number (segment).
+ * @bdf: The device's PCI bus, device, and function number.
+ * @reserved: Reserved (to naturally align struct pci_dev_ser).
+ */
+struct pci_dev_ser {
+	u32 domain;
+	u16 bdf;
+	u16 reserved;
+} __packed;
+
+/**
+ * struct pci_ser - PCI Subsystem Live Update State
+ *
+ * This struct tracks state about all devices that are being preserved across
+ * a Live Update for the next kernel.
+ *
+ * @max_nr_devices: The length of the devices[] flexible array.
+ * @nr_devices: The number of devices that were preserved.
+ * @devices: Flexible array of pci_dev_ser structs for each device.
+ */
+struct pci_ser {
+	u32 max_nr_devices;
+	u32 nr_devices;
+	struct pci_dev_ser devices[];
+} __packed;
+
+/* Ensure all elements of devices[] are naturally aligned. */
+static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
+static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
+
+#endif /* _LINUX_KHO_ABI_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..d70080babd52 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -40,6 +40,7 @@
 #include <linux/resource_ext.h>
 #include <linux/msi_api.h>
 #include <uapi/linux/pci.h>
+#include <linux/liveupdate.h>
 
 #include <linux/pci_ids.h>
 
@@ -2876,4 +2877,18 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 	WARN_ONCE(condition, "%s %s: " fmt, \
 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
 
+#ifdef CONFIG_PCI_LIVEUPDATE
+int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
+void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+#else
+static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
+{
+}
+#endif
+
 #endif /* LINUX_PCI_H */
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

