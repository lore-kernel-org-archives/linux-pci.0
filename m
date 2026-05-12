Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8233F8C4
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611736; cv=none; b=alI967SWY7v582Bg0t5c52rZqo9+kZGrnT0gfIFoV+hYCZa56iYiBvAnnMsogKw3DcsFRQScxuseFvpXpumEMcjYcNFEFhDTuVWyVidFXJX9sEdD9iGqbV2k7ZW0F2zM2ByqenxGGqd6bQGvsEVRUB5DHseHVvhzj0uebJ5Sa1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611736; c=relaxed/simple;
	bh=dFgN73SxskU2yU9KWfkqH1j1q/LgmsabMzg6CQUI1Qc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=adHZY9d6K0bhqEdC1cqUPGzk6eCuBM0zE7s1VwxogdKE7DKxBtRjE5BmtZZ2YFGgVB0g9bpyOF7SFf576ZPfQu3vsYG7PERMhUr/6DoSLw0iDjKeJ03EmnPRqHMfJEdeH57dXWrntRKXXoEa+ebKaLt1rnRykcjyC0SiKVH0QbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyEmEz/N; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyEmEz/N"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b7aba0af02so63990825ad.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611733; x=1779216533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4K+3x46P5Tng2/W1DPr8N223Eo9F5ffuPNYieXQuRE=;
        b=vyEmEz/Nw3R8zgOm92myY6FUcXBRr65b28IgDiqKJuw+u72xuiPBko8FnhuIjlEByK
         cy55oFHPUmR3J28RcHBpcFfzm0ASuyuCtVGnnZ6Z7o1r11fgiA35AyAS4A+N54o2d6hP
         7BbQ9ILPdVjYn7h/eOOsMnYw1TDwx5OGWLEX30hTKho6Hqr4/GY4AJkj/zsXQCSsa0Oq
         ygJtvfYK/DzZBzwc7mkN31EJEHv+h7Pm13F2eaoC0dZp7JUiDQ7O93SH/PGUlwjn75d9
         rHeUu7rvLW5FjMQmV3pe2pXA94zackDUb1g+LtTBEwf6D9YRxVn5X49FsKSpRvcgskiS
         WBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611733; x=1779216533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4K+3x46P5Tng2/W1DPr8N223Eo9F5ffuPNYieXQuRE=;
        b=W9g2679IX++fF0bv+8qw4dj1S4CyuvLq7hmsmh1L0dlZouCH1v0Hjz6kLva1r5FV6o
         ReKHOQ7DJciH5wWSOdCVpb4Yl3eBfYU9wl5XN8AmYhcjJCAmayCyzvknvK6EIqRrDh+c
         mS1SYsJeUsz5Lgog0wcNEBmESFP5Qh+O3RzYBTiaFVpjB9jo3q5T7ha/CAkrm1F2SJ4l
         2OxsiduIG2p0heGHuQ1c09p7n281cXjfEf6Jfz1h7Inl0mfbEHdN7Xmi/49wFEqQMhNJ
         6tTmP+c6nwb9EXuV4g+8TwfG9UyhbvK7Jke4qA8TcDKxtMoCJlzkW5ZQ0doBOopwlQal
         IaoQ==
X-Forwarded-Encrypted: i=1; AFNElJ86bkJHNK8Xg5wc0gL1StMc2r3+yBS6bno+rwoinKSvKAEeduHs0t/pOLhAc67R5TPAPNtr6gxZlbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpB8kOKs1XVBVxFjkUDVNizW4uTWE20UcXrIbpMquWRHjXKqkc
	hT3LTx3BicXv9gzPtUr+L7rrWI7MA1cj3F7sEmCkDzRZpmy5RKljo5hvoltCdzHbV1iPTApQIgZ
	LQq6fQg9lG9oIaw==
X-Received: from plbkf6.prod.google.com ([2002:a17:903:5c6:b0:2b9:53bb:4a09])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ed04:b0:2bc:78ec:54c0 with SMTP id d9443c01a7336-2bd27291c8emr1934145ad.31.1778611732668;
 Tue, 12 May 2026 11:48:52 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:37 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-3-dmatlack@google.com>
Subject: [PATCH v5 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
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
need special handling during shutdown and kexec, and so that it can be
handed off to the next kernel.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c       | 167 ++++++++++++++++++++++++++++++---
 drivers/pci/probe.c            |   3 +
 include/linux/kho/abi/pci.h    |   9 +-
 include/linux/pci.h            |   3 +
 include/linux/pci_liveupdate.h |  23 +++++
 5 files changed, 191 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index dd2449e12b6d..9c4582ecd55c 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -43,6 +43,26 @@
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
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -55,13 +75,29 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 
+/**
+ * struct pci_flb_outgoing - Outgoing PCI FLB object
+ * @ser: The outgoing struct pci_ser for the next kernel.
+ * @lock: Lock used to protect against changes to @ser.
+ */
+struct pci_flb_outgoing {
+	struct pci_ser *ser;
+	struct mutex lock;
+};
+
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
+	struct pci_flb_outgoing *outgoing;
 	struct pci_dev *dev = NULL;
 	u32 max_nr_devices = 0;
-	struct pci_ser *ser;
 	unsigned long size;
 
+	outgoing = kmalloc_obj(*outgoing);
+	if (!outgoing)
+		return -ENOMEM;
+
+	mutex_init(&outgoing->lock);
+
 	/*
 	 * Allocate enough space to preserve all of the devices that are
 	 * currently present on the system. Extra padding can be added to this
@@ -74,27 +110,30 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 
 	size = struct_size_t(struct pci_ser, devices, max_nr_devices);
 
-	ser = kho_alloc_preserve(size);
-	if (IS_ERR(ser))
-		return PTR_ERR(ser);
+	outgoing->ser = kho_alloc_preserve(size);
+	if (IS_ERR(outgoing->ser)) {
+		kfree(outgoing);
+		return PTR_ERR(outgoing->ser);
+	}
 
 	pr_debug("Preserved struct pci_ser with room for %u devices\n",
 		 max_nr_devices);
 
-	ser->max_nr_devices = max_nr_devices;
-	ser->nr_devices = 0;
+	outgoing->ser->max_nr_devices = max_nr_devices;
+	outgoing->ser->nr_devices = 0;
 
-	args->obj = ser;
-	args->data = virt_to_phys(ser);
+	args->obj = outgoing;
+	args->data = virt_to_phys(outgoing->ser);
 	return 0;
 }
 
 static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 {
-	struct pci_ser *ser = args->obj;
+	struct pci_flb_outgoing *outgoing = args->obj;
 
-	WARN_ON_ONCE(ser->nr_devices);
-	kho_unpreserve_free(ser);
+	WARN_ON_ONCE(outgoing->ser->nr_devices);
+	kho_unpreserve_free(outgoing->ser);
+	kfree(outgoing);
 
 	pr_debug("Unpreserved struct pci_ser\n");
 }
@@ -123,6 +162,112 @@ static struct liveupdate_flb pci_liveupdate_flb = {
 	.compatible = PCI_LUO_FLB_COMPATIBLE,
 };
 
+/**
+ * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
+ * @dev: The PCI device to preserve.
+ *
+ * pci_liveupdate_preserve() notifies the PCI core that a PCI device should be
+ * preserved across the next Live Update. Drivers must call
+ * pci_liveupdate_preserve() from their struct liveupdate_file_handler
+ * preserve() callback to ensure the outgoing struct pci_ser is allocated.
+ *
+ * Returns: 0 on success, <0 on failure.
+ */
+int pci_liveupdate_preserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	struct pci_ser *ser;
+	int i, ret;
+
+	if (dev->is_virtfn)
+		return -EINVAL;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
+	if (ret)
+		return ret;
+
+	if (!outgoing)
+		return -ENOENT;
+
+	guard(mutex)(&outgoing->lock);
+	ser = outgoing->ser;
+
+	guard(write_lock)(&dev->liveupdate.lock);
+
+	if (dev->liveupdate.outgoing)
+		return -EBUSY;
+
+	if (ser->nr_devices == ser->max_nr_devices)
+		return -ENOSPC;
+
+	for (i = 0; i < ser->max_nr_devices; i++) {
+		/*
+		 * Start searching at index ser->nr_devices. This should result
+		 * in a constant time search under expected conditions (devices
+		 * are not getting unpreserved).
+		 */
+		int index = (ser->nr_devices + i) % ser->max_nr_devices;
+		struct pci_dev_ser *dev_ser = &ser->devices[index];
+
+		if (dev_ser->refcount)
+			continue;
+
+		pci_info(dev, "Device will be preserved across next Live Update\n");
+		ser->nr_devices++;
+
+		dev_ser->domain = pci_domain_nr(dev->bus);
+		dev_ser->bdf = pci_dev_id(dev);
+		dev_ser->refcount = 1;
+
+		dev->liveupdate.outgoing = dev_ser;
+		return 0;
+	}
+
+	return -ENOSPC;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
+
+/**
+ * pci_liveupdate_unpreserve() - Cancel preservation of a PCI device
+ * @dev: The PCI device to preserve.
+ *
+ * pci_liveupdate_unpreserve() notifies the PCI core that a PCI device should no
+ * longer be preserved across the next Live Update. Drivers must call
+ * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
+ * unpreserve() callback to ensure the outgoing struct pci_ser is allocated.
+ */
+void pci_liveupdate_unpreserve(struct pci_dev *dev)
+{
+	struct pci_flb_outgoing *outgoing = NULL;
+	struct pci_dev_ser *dev_ser;
+	struct pci_ser *ser;
+	int ret;
+
+	ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&outgoing);
+
+	if (ret || !outgoing) {
+		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update state\n");
+		return;
+	}
+
+	guard(mutex)(&outgoing->lock);
+	ser = outgoing->ser;
+
+	guard(write_lock)(&dev->liveupdate.lock);
+
+	dev_ser = dev->liveupdate.outgoing;
+	if (!dev_ser) {
+		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
+		return;
+	}
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate.outgoing = NULL;
+}
+EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
+
 /**
  * pci_liveupdate_register_flb() - Register a file handler with the PCI core
  * @fh: The file handler to register.
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..54ae32cb0000 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2522,6 +2522,9 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	spin_lock_init(&dev->pcie_cap_lock);
 #ifdef CONFIG_PCI_MSI
 	raw_spin_lock_init(&dev->msi_lock);
+#endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	rwlock_init(&dev->liveupdate.lock);
 #endif
 	return dev;
 }
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index 6ebcf817fff4..807fe0e6538f 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -23,19 +23,22 @@
  * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
  *
  * @domain: The device's PCI domain number (segment).
  * @bdf: The device's PCI bus, device, and function number.
- * @padding: Padding to naturally align struct pci_dev_ser.
+ * @refcount: Reference count used by the PCI core to keep track of whether it
+ *            is done using a device's struct pci_dev_ser. The value of the
+ *            refcount is equal to the number of devices preserved at or below
+ *            this device in the PCI hierarchy.
  */
 struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
-	u16 padding;
+	u16 refcount;
 } __packed;
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8cadeeab86fd..a7c3722b1e77 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -594,6 +594,9 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+#ifdef CONFIG_PCI_LIVEUPDATE
+	struct pci_liveupdate liveupdate;
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
index 8ec98beefcb4..0803d44becd5 100644
--- a/include/linux/pci_liveupdate.h
+++ b/include/linux/pci_liveupdate.h
@@ -8,14 +8,28 @@
 #ifndef LINUX_PCI_LIVEUPDATE_H
 #define LINUX_PCI_LIVEUPDATE_H
 
+#include <linux/kho/abi/pci.h>
 #include <linux/liveupdate.h>
 #include <linux/types.h>
+#include <linux/spinlock_types.h>
+
+/**
+ * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
+ * @lock: Lock used to protect members of struct pci_liveupdate.
+ * @outgoing: State preserved for the next kernel.
+ */
+struct pci_liveupdate {
+	rwlock_t lock;
+	struct pci_dev_ser *outgoing;
+};
 
 struct pci_dev;
 
 #ifdef CONFIG_PCI_LIVEUPDATE
 int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh);
 void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh);
+int pci_liveupdate_preserve(struct pci_dev *dev);
+void pci_liveupdate_unpreserve(struct pci_dev *dev);
 #else
 static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
 {
@@ -25,6 +39,15 @@ static inline int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh
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
2.54.0.563.g4f69b47b94-goog

