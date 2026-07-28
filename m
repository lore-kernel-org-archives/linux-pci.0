Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB658477980
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276628; cv=none; b=Lwm6yYe84JtUBdtTZJ1m7x2BJBjx5grnhkoAsmD5D2cHB7SYUD2KqTZEp0Cgx6dnAv18ZG2ALg/apl3mCQy+jWrwWU2SiPox3BRKB4SkmY6ivzgqhZD0x236MGg0Kte0BHeKQq17ys6Z6fOBXPA72Sm1ZNCfTY+etEa2itRMn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276628; c=relaxed/simple;
	bh=Xnx74TzyUZbuOfA/JFxMMnk50cNCavNqrWoIvIARVvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EtwU3DddBo52aIK4Uv4ojdv+1AcE0yWHH+TOKiYP2+HCmce6go1SNNkeVoVG+/vNLN+YRPFZo1+hm+6CBFboht8InmJ2APe1p+rzlqMOMrkLkEyhiKQgLLTj5gQxhQb7BDlWCdhnaYL1snwEGEt+WkyunY7fmWZEdr61Vn0vr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWOwtWSf; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWOwtWSf"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8482b95574dso368411b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276623; x=1785881423; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGAhZMzqBLCDQKhaJ1H7fxzxpkTMhw4CZknznVqC8zM=;
        b=NWOwtWSfBeu0CwkQb9UL5L0zkfJMztoQQS98Zc0OahjSSRTEyiYE0O259L79M0p6QW
         LcL+Hjle6PBlL5N3z/7JOZ6UA3/fNHVDa84hZ0lnwAzsoPIiG4r3q5UezuibSJnge/rq
         n7xt+NETgE7H948L1qknRfna5+yQJENPPhBIIyxyabkJMu0mLiNi47EGl+S52Ndr0Jo4
         TzGllYoRvAj3PqwqO58RJRkGZwSyQYh/WwsDwZtgPFSJRpngML7zuk5aH0IUBmnbCUdk
         YFPw7T50WovrAMOe7ag3oni8Esnt9MbtevzohQOnzDDgp+SZpqZJkNecjfj91R4rcW5L
         B66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276623; x=1785881423;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGAhZMzqBLCDQKhaJ1H7fxzxpkTMhw4CZknznVqC8zM=;
        b=EGZEUJkW4myfM+uCnGmWVnGNqq2qN4zHwhjg1+HLlNkG0XB8ybtnZ/lHd3VX0BppQB
         9jZbLwaK1+aRjRjTLyi8ItMIGxRfE3c8pzteQLl0n4azDrMUkO4GCHPNIjGO7Ibg09yL
         5qLtKwoCP+GJDYGjo3yKXW+4y78ihqoCCpgTRp1U9zC7D3InAAl130HeDiV4LkUV6Vsk
         WCSOag+/8//6v9ZNfIxWnlJjYeibDH4XNEUXmxeYbsRTzcIh86m8aEdbIQfBBicGZr67
         zN43dGfN30B8VZPprvUL7zQv1r7OlSx9IJE2eNAXFJHPuyuqV3AMia4/JMthESgAl4yT
         eyxw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+7MPxfNXR5XxIsYMsNscU3gFiJKZlvs2Fo3cANFzw+VbLoeIrcdC7krtmGUIdAWjrZCGPJkZOiDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHwL48J1OFQLsEbAGvN1Czo9X4LANJM3urfZF/N161Hl/dv9/
	cD9H07JtTYsk3MREQiFuiEwXNomhM3HWkzzJ1w4Qqv4b6ohQGJoZqzSXmnAjQWyZePXuwZCSavB
	mN+d7QCayVHDQmA==
X-Received: from pfhx23.prod.google.com ([2002:a05:6a00:1897:b0:848:4e44:7f19])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a222:b0:848:584f:7e41 with SMTP id d2e1a72fcca58-84e933ada35mr4409226b3a.78.1785276622323;
 Tue, 28 Jul 2026 15:10:22 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:09:56 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-3-dmatlack@google.com>
Subject: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI devices
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

Add APIs to allow drivers to notify the PCI core of which devices are
being preserved across a Live Update for the next kernel, i.e.
"outgoing" devices.

Drivers must notify the PCI core when devices are preserved so that the
PCI core can update its FLB data (struct pci_ser) and track the list of
outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
device must be preserved across Live Update. pci_liveupdate_unpreserve()
reverses this (cancels the preservation of the device).

This tracking ensures the PCI core is fully aware of which devices may
need special handling during shutdown and kexec, and so the list of
preserved devices can be handed off to the next kernel.

For now, the API only supports preserving non-VF devices on a root bus
(not behind an PCI-to-PCI bridges).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 210 +++++++++++++++++++++++++++++++++
 drivers/pci/liveupdate.h       |  21 ++++
 drivers/pci/probe.c            |   2 +
 include/linux/pci.h            |   3 +
 include/linux/pci_liveupdate.h |  21 ++++
 5 files changed, 257 insertions(+)
 create mode 100644 drivers/pci/liveupdate.h

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index fffb41a66ca7..b003b7069cdb 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -36,6 +36,27 @@
  *
  *  * ``pci_liveupdate_register_flb(driver_file_handler)``
  *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
+ *
+ * Device Tracking
+ * ===============
+ *
+ * Drivers must notify the PCI core when specific devices are preserved or
+ * unpreserved with the following APIs:
+ *
+ *  * ``pci_liveupdate_preserve(pci_dev)``
+ *  * ``pci_liveupdate_unpreserve(pci_dev)``
+ *
+ * This allows the PCI core to keep its FLB data (struct pci_ser) up to date
+ * with the list of **outgoing** preserved devices for the next kernel.
+ *
+ * Restrictions
+ * ============
+ *
+ * The PCI core enforces the following restrictions on which devices can be
+ * preserved. These may be relaxed in the future:
+ *
+ *  * The device cannot be a Virtual Function (VF).
+ *  * The device cannot be behind a PCI-to-PCI bridge.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -50,6 +71,21 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#include "liveupdate.h"
+
+/**
+ * struct pci_liveupdate_global - Global state for PCI Live Update support
+ * @rwsem: Reader/writer semaphore used to protect the incoming and outgoing
+ *         FLBs, and the references to them in struct pci_dev.
+ */
+struct pci_liveupdate_global {
+	struct rw_semaphore rwsem;
+};
+
+static struct pci_liveupdate_global pci_liveupdate = {
+	.rwsem = __RWSEM_INITIALIZER(pci_liveupdate.rwsem),
+};
+
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
  * @ser: Pointer to the preserved struct pci_ser.
@@ -128,6 +164,180 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+static void pci_liveupdate_flb_put_outgoing(void)
+{
+	liveupdate_flb_put_outgoing(&pci_liveupdate_flb);
+}
+
+static struct pci_flb_outgoing *pci_liveupdate_flb_get_outgoing(void)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	int ret;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!outgoing)
+		return ERR_PTR(-ENOENT);
+
+	return outgoing;
+}
+
+static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoing)
+{
+	struct pci_dev_ser *dev_ser;
+	struct kho_block_set_it it;
+	u64 count = 0;
+	int err;
+
+	kho_block_set_it_init(&it, &outgoing->block_set);
+
+	/* Try to find an existing, previously unpreserved, entry. */
+	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+		if (!dev_ser->refcount)
+			return dev_ser;
+
+		count++;
+	}
+
+	/* Otherwise grow the block set and reserve a new entry. */
+	err = kho_block_set_grow(&outgoing->block_set, count + 1);
+	if (err)
+		return ERR_PTR(err);
+
+	if (!count)
+		kho_block_set_it_init(&it, &outgoing->block_set);
+
+	/* This should always succeed since kho_block_set_grow() succeeded. */
+	dev_ser = kho_block_set_it_reserve_entry(&it);
+	if (WARN_ON_ONCE(!dev_ser))
+		return ERR_PTR(-ENOSPC);
+
+	return dev_ser;
+}
+
+static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
+					     struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	outgoing->ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate.outgoing = NULL;
+}
+
+static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
+					  struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
+	if (dev->is_virtfn) {
+		pci_warn(dev, "Cannot preserve Virtual Functions\n");
+		return -EINVAL;
+	}
+
+	if (dev->liveupdate.outgoing) {
+		pci_warn(dev, "Device is already preserved\n");
+		return -EBUSY;
+	}
+
+	if (!pci_is_root_bus(dev->bus)) {
+		pci_warn(dev, "Cannot preserve devices behind bridges\n");
+		return -EINVAL;
+	}
+
+	dev_ser = pci_flb_alloc_dev_ser(outgoing);
+	if (IS_ERR(dev_ser))
+		return PTR_ERR(dev_ser);
+
+	pci_info(dev, "Device will be preserved across next Live Update\n");
+	outgoing->ser->nr_devices++;
+	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+
+	dev_ser->domain = pci_domain_nr(dev->bus);
+	dev_ser->bdf = pci_dev_id(dev);
+	dev_ser->refcount = 1;
+
+	dev->liveupdate.outgoing = dev_ser;
+	return 0;
+}
+
+/**
+ * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
+ * @dev: The PCI device to preserve.
+ *
+ * pci_liveupdate_preserve() notifies the PCI core that a PCI device should be
+ * preserved across the next Live Update. Drivers are expected to call
+ * pci_liveupdate_preserve() from their struct liveupdate_file_handler
+ * preserve() callback to ensure the outgoing struct pci_ser is already set up.
+ *
+ * Returns: 0 on success, <0 on failure.
+ */
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	int ret;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	outgoing = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(outgoing))
+		return PTR_ERR(outgoing);
+
+	ret = pci_liveupdate_preserve_device(outgoing, dev);
+
+	pci_liveupdate_flb_put_outgoing();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
+
+/**
+ * pci_liveupdate_unpreserve() - Cancel preservation of a PCI device
+ * @dev: The PCI device to unpreserve.
+ *
+ * pci_liveupdate_unpreserve() notifies the PCI core that a PCI device should no
+ * longer be preserved across the next Live Update. Drivers are expected to call
+ * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
+ * unpreserve() callback to ensure the outgoing struct pci_ser is already set
+ * up.
+ */
+void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+
+	guard(rwsem_write)(&pci_liveupdate.rwsem);
+
+	outgoing = pci_liveupdate_flb_get_outgoing();
+	if (IS_ERR(outgoing)) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+	}
+
+	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_flb_put_outgoing();
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
+void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+	/*
+	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
+	 * since there should no longer be any references to @dev on the system.
+	 *
+	 * This should never happen in practice. Drivers should block removal
+	 * while a device is preserved.
+	 */
+	if (READ_ONCE(dev->liveupdate.outgoing))
+		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
+}
+
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
  * @fh: The file handler to register.
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
new file mode 100644
index 000000000000..b2335581f8d0
--- /dev/null
+++ b/drivers/pci/liveupdate.h
@@ -0,0 +1,21 @@
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
+void pci_liveupdate_cleanup_device(struct pci_dev *dev);
+#else
+static inline void pci_liveupdate_cleanup_device(struct pci_dev *dev)
+{
+}
+#endif
+
+#endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..14b66acbdb15 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include "liveupdate.h"
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2485,6 +2486,7 @@ static void pci_release_dev(struct device *dev)
 
 	pci_dev = to_pci_dev(dev);
 	pci_release_capabilities(pci_dev);
+	pci_liveupdate_cleanup_device(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index da58aa101e4c..b41dd572a2d6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -593,6 +593,9 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	struct pci_liveupdate liveupdate;
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 8ec98beefcb4..894052ad6961 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -8,14 +8,26 @@
 #ifndef LINUX_PCI_LIVEUPDATE_H
 #define LINUX_PCI_LIVEUPDATE_H
 
+#include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
+/**
+ * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
+ * @outgoing: State preserved for the next kernel.
+ */
+struct pci_liveupdate {
+	struct pci_dev_ser *outgoing;
+};
+
 struct pci_dev;
 
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+int pci_liveupdate_preserve(struct pci_dev *dev);
+void pci_liveupdate_unpreserve(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -25,6 +37,15 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
 static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
 {
 }
+
+static inline int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+}
 #endif
 
 #endif /* LINUX_PCI_LIVEUPDATE_H */
-- 
2.55.0.487.gaf234c4eb3-goog

